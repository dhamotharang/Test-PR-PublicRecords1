IMPORT CMS_AddOn, tools;

EXPORT Build_Base(STRING                          pversion,
                  BOOLEAN                         pUseProd  = FALSE,
									STRING                          pFileEffectiveDate,
                  DATASET(CMS_AddOn.Layouts.Base) pBaseFile = IF(CMS_AddOn._Flags(pUseProd).Update,
																																 CMS_AddOn.Files().Base.QA,
																																 DATASET([], CMS_AddOn.Layouts.Base))) := MODULE

	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
									 CMS_AddOn.Build_Base_Main(pversion,
									                           pUseProd,
									                           pFileEffectiveDate,
																						 pBaseFile).All,
									 OUTPUT('No Valid version parameter passed, skipping CMS_AddOn.Build_Base atribute'));

END;
