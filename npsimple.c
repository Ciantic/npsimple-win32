/**
 * (C)opyright 2008 Aplix Corporation. All rights reserved.
 */
#include <stdio.h>
#include <string.h>

#if defined(OS_Darwin)
#include <Webkit/npapi.h>
#include <WebKit/npfunctions.h>
#include <WebKit/npruntime.h>
#define OSCALL
#endif

#if XULRUNNER_SDK
#include <npapi.h>
#include <npupp.h>
#include <npruntime.h>
#elif _WINDOWS /* WebKit SDK on Windows */
#ifndef PLATFORM
#define PLATFORM(x) defined(x)
#endif
#include <npfunctions.h>
#ifndef OSCALL
#define OSCALL WINAPI
#endif
#endif

static NPObject *so              = NULL;
static NPNetscapeFuncs *npnfuncs = NULL;

/* NPN */

static void logmsg(const char *msg) {
#ifndef _WINDOWS
	fputs(msg, stderr);
#else
	static FILE *out = fopen("\\npsimple.log", "a");
	fputs(msg, out);
	fclose(out);
#endif
}

static bool
hasMethod(NPObject* obj, NPIdentifier methodName) {
	logmsg("npsimple: hasMethod\n");
	return true;
}

static bool
invokeDefault(NPObject *obj, const NPVariant *args, uint32_t argCount, NPVariant *result) {
	logmsg("npsimple: invokeDefault\n");
	result->type = NPVariantType_Int32;
	result->value.intValue = 42;
	return true;
}

static bool
invoke(NPObject* obj, NPIdentifier methodName, const NPVariant *args, uint32_t argCount, NPVariant *result) {
	logmsg("npsimple: invoke\n");
	return invokeDefault(obj, args, argCount, result);
}

static bool
hasProperty(NPObject *obj, NPIdentifier propertyName) {
	logmsg("npsimple: hasProperty\n");
	return false;
}

static bool
getProperty(NPObject *obj, NPIdentifier propertyName, NPVariant *result) {
	logmsg("npsimple: getProperty\n");
	return false;
}

static NPClass npcRefObject = {
	NP_CLASS_STRUCT_VERSION,
	NULL,
	NULL,
	NULL,
	hasMethod,
	invoke,
	invokeDefault,
	hasProperty,
	getProperty,
	NULL,
	NULL,
};

/* NPP */

static NPError
nevv(NPMIMEType pluginType, NPP instance, uint16 mode, int16 argc, char *argn[], char *argv[], NPSavedData *saved) {
	logmsg("npsimple: new\n");
	return NPERR_NO_ERROR;
}

static NPError
destroy(NPP instance, NPSavedData **save) {
	if(so)
		npnfuncs->releaseobject(so);
	so = NULL;
	logmsg("npsimple: destroy\n");
	return NPERR_NO_ERROR;
}

static NPError
getValue(NPP instance, NPPVariable variable, void *value) {
	switch(variable) {
	default:
		logmsg("npsimple: getvalue - default\n");
		return NPERR_GENERIC_ERROR;
	case NPPVpluginNameString:
		logmsg("npsimple: getvalue - name string\n");
		*((char **)value) = "AplixFooPlugin";
		break;
	case NPPVpluginDescriptionString:
		logmsg("npsimple: getvalue - description string\n");
		*((char **)value) = "<a href=\"http://www.aplix.co.jp/\">AplixFooPlugin</a> plugin.";
		break;
	case NPPVpluginScriptableNPObject:
		logmsg("npsimple: getvalue - scriptable object\n");
		if(!so)
			so = npnfuncs->createobject(instance, &npcRefObject);
		npnfuncs->retainobject(so);
		*(NPObject **)value = so;
		break;
#ifdef XULRUNNER_SDK
	case NPPVpluginNeedsXEmbed:
		logmsg("npsimple: getvalue - xembed\n");
		*((PRBool *)value) = PR_FALSE;
		break;
#endif
	}
	return NPERR_NO_ERROR;
}

static NPError /* expected by Safari on Darwin */
handleEvent(NPP instance, void *ev) {
	logmsg("npsimple: handleEvent\n");
	return NPERR_NO_ERROR;
}

static NPError /* expected by Opera */
setWindow(NPP instance, NPWindow* pNPWindow) {
	logmsg("npsimple: setWindow\n");
	return NPERR_NO_ERROR;
}

/* EXPORT */
#ifdef __cplusplus
extern "C" {
#endif

NPError OSCALL
NP_GetEntryPoints(NPPluginFuncs *nppfuncs) {
	logmsg("npsimple: NP_GetEntryPoints\n");
	nppfuncs->version       = (NP_VERSION_MAJOR << 8) | NP_VERSION_MINOR;
	nppfuncs->newp          = nevv;
	nppfuncs->destroy       = destroy;
	nppfuncs->getvalue      = getValue;
	nppfuncs->event         = handleEvent;
	nppfuncs->setwindow     = setWindow;

	return NPERR_NO_ERROR;
}

#ifndef HIBYTE
#define HIBYTE(x) ((((uint32)(x)) & 0xff00) >> 8)
#endif

NPError OSCALL
NP_Initialize(NPNetscapeFuncs *npnf
#if !defined(_WINDOWS) && !defined(OS_Darwin)
			, NPPluginFuncs *nppfuncs)
#else
			)
#endif
{
	logmsg("npsimple: NP_Initialize\n");
	if(npnf == NULL)
		return NPERR_INVALID_FUNCTABLE_ERROR;

	if(HIBYTE(npnf->version) > NP_VERSION_MAJOR)
		return NPERR_INCOMPATIBLE_VERSION_ERROR;

	npnfuncs = npnf;
#if !defined(_WINDOWS) && !defined(OS_Darwin)
	NP_GetEntryPoints(nppfuncs);
#endif
	return NPERR_NO_ERROR;
}

NPError
OSCALL NP_Shutdown() {
	logmsg("npsimple: NP_Shutdown\n");
	return NPERR_NO_ERROR;
}

char *
NP_GetMIMEDescription(void) {
	logmsg("npsimple: NP_GetMIMEDescription\n");
	return "application/x-vnd-aplix-foo:.foo:dev-jsx@aplix.co.jp";
}

NPError OSCALL /* needs to be present for WebKit based browsers */
NP_GetValue(void *npp, NPPVariable variable, void *value) {
	return getValue((NPP)npp, variable, value);
}

#ifdef __cplusplus
}
#endif
