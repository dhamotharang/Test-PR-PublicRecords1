// This module publishes the common BASE layout that gets passed from step to step
// during the internal linking process.
//
// It also publishes a set of SuperFiles representing the final result after all
// internal linking steps have completed.
//
// The three main exports in this module are...
//
// 1. BIPV2.CommonBase.Layout
// 2. BIPV2.CommonBase.DS_BASE
// 2. BIPV2.CommonBase.DS_CLEAN
//
// Going forward, we'll want anybody who needs the header layout to reference #1. 
// Almost everyone who needs the header should reference #3.  #2 feeds back around
// as the base file for the next build.

IMPORT ut, MDR,	BIPV2, BIPV2_Company_Names, AID, _Control, Suppress;

EXPORT CommonBase := MODULE

	// Clean only SBFE Records
	EXPORT sbfe_clean(ds) := FUNCTIONMACRO
		IMPORT Suppress;
		ds_exclude  :=	ds(source IN MDR.sourceTools.set_Business_Credit);
		ds_exorcise	:=	ds_exclude(ingest_status<>'Old'); // Exorcise all ghosts, which _can_ remove cluster base records!
		ds_reg      :=	Suppress.applyRegulatory.applyBIPV2(ds_exorcise);
		RETURN ds_reg;
	ENDMACRO;

	EXPORT	DS_SBFE_CLEAN								:= sbfe_clean(BIPV2.CommonBase.DS_BASE);
	EXPORT	DS_SBFE_FATHER_CLEAN				:= sbfe_clean(BIPV2.CommonBase.DS_FATHER);
	EXPORT	DS_SBFE_FATHER_STATIC_CLEAN	:= sbfe_clean(BIPV2.CommonBase.DS_FATHER_STATIC);
	EXPORT	DS_SBFE_PROD_CLEAN					:= sbfe_clean(BIPV2.CommonBase.DS_PROD);
	EXPORT	DS_SBFE_LOCAL_CLEAN					:= sbfe_clean(BIPV2.CommonBase.DS_LOCAL);
	EXPORT	DS_SBFE_LOCAL_STATIC_CLEAN	:= sbfe_clean(BIPV2.CommonBase.DS_LOCAL_STATIC);
	

END;