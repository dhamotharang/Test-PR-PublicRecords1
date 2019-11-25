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

IMPORT BIPV2_Best_Debug, BIPV2, BIPV2_Best_SBFE;

EXPORT CommonBase := MODULE

	EXPORT	DS_DEBUG_CLEAN								:= BIPV2_Best_SBFE.CommonBase.DS_SBFE_CLEAN               + BIPV2.CommonBase.DS_CLEAN;
	EXPORT	DS_DEBUG_FATHER_CLEAN         := BIPV2_Best_SBFE.CommonBase.DS_SBFE_FATHER_CLEAN        + BIPV2.CommonBase.DS_FATHER_CLEAN;
	EXPORT	DS_DEBUG_FATHER_STATIC_CLEAN  := BIPV2_Best_SBFE.CommonBase.DS_SBFE_FATHER_STATIC_CLEAN + BIPV2.CommonBase.DS_FATHER_STATIC_CLEAN;
	EXPORT	DS_DEBUG_PROD_CLEAN           := BIPV2_Best_SBFE.CommonBase.DS_SBFE_PROD_CLEAN          + BIPV2.CommonBase.DS_PROD_CLEAN;
	EXPORT	DS_DEBUG_LOCAL_CLEAN					:= BIPV2_Best_SBFE.CommonBase.DS_SBFE_LOCAL_CLEAN         + BIPV2.CommonBase.DS_LOCAL_CLEAN;
	EXPORT	DS_DEBUG_LOCAL_STATIC_CLEAN   := BIPV2_Best_SBFE.CommonBase.DS_SBFE_LOCAL_STATIC_CLEAN  + BIPV2.CommonBase.DS_LOCAL_STATIC_CLEAN;
	

END;