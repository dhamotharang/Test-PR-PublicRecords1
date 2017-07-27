import doxie_build,RoxieKeybuild,header,Marital_Status_Indicator;

export Proc_MSI_keys(string filedate) := function

  #uniquename(version_date)
  %version_date% := filedate;
	

RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(Marital_Status_Indicator.key_gender_fname,	
							'~thor_data400::key::msi::'+%version_date%+'::gender::fname',
							'~thor_data400::key::msi::@version@::gender::fname',msi0);

RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(Marital_Status_Indicator.key_MSI_best_did,	
							'~thor_data400::key::msi::'+%version_date%+'::best_data::did',
							'~thor_data400::key::msi::@version@::best_data::did',msi1);
							
RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(Marital_Status_Indicator.key_MSI_V1_did,
							'~thor_data400::key::msi::'+%version_date%+'::marriageV1::did',
							'~thor_data400::key::msi::@version@::marriageV1::did',msi2);
							
RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(Marital_Status_Indicator.key_MSI_V2_did,
							'~thor_data400::key::msi::'+%version_date%+'::marriage_V2::did',
							'~thor_data400::key::msi::@version@::marriage_V2::did',msi3);

RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::msi::'+%version_date%+'::gender::fname',
																			'~thor_data400::key::msi::@version@::gender::fname',mv_msi0);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::msi::'+%version_date%+'::best_data::did',
																			'~thor_data400::key::msi::@version@::best_data::did',mv_msi1);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::msi::'+%version_date%+'::marriageV1::did',
																			'~thor_data400::key::msi::@version@::marriageV1::did',mv_msi2);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::msi::'+%version_date%+'::marriage_V2::did',
																			'~thor_data400::key::msi::@version@::key::marriage_V2::did',mv_msi3);


return sequential(msi0,msi1,msi2,msi3,
									mv_msi0,mv_msi1,mv_msi2,mv_msi3);
end;
