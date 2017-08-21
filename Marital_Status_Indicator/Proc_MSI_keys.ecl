import _control,dops,doxie_build,RoxieKeybuild,header,Marital_Status_Indicator;

export Proc_MSI_keys(string filedate) := function

  #uniquename(version_date)
  %version_date% := filedate;
	

RoxieKeybuild.MAC_SK_BuildProcess_Local(Marital_Status_Indicator.key_gender_fname,	
							'~thor_data400::key::msi::'+%version_date%+'::gender::fname',
							'~thor_data400::key::msi::@version@::gender::fname',
							msi0);

RoxieKeybuild.MAC_SK_BuildProcess_Local(Marital_Status_Indicator.key_MSI_best_did,	
							'~thor_data400::key::msi::'+%version_date%+'::best_data::did',
							'~thor_data400::key::msi::@version@::best_data::did',
							msi1);
							
RoxieKeybuild.MAC_SK_BuildProcess_Local(Marital_Status_Indicator.key_MSI_V1_did,
							'~thor_data400::key::msi::'+%version_date%+'::marriageV1::did',
							'~thor_data400::key::msi::@version@::marriageV1::did',
							msi2);
							
RoxieKeybuild.MAC_SK_BuildProcess_Local(Marital_Status_Indicator.key_MSI_V2_did,
							'~thor_data400::key::msi::'+%version_date%+'::marriage_V2::did',
							'~thor_data400::key::msi::@version@::marriage_V2::did',
							msi3);

RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::msi::@version@::gender::fname',
																			'~thor_data400::key::msi::'+%version_date%+'::gender::fname',mv_msi0,'2');
RoxieKeyBuild.MAC_SK_Move_v2('~thor_data400::key::msi::@version@::gender::fname','Q',move1);
																		
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::msi::@version@::best_data::did',
																			'~thor_data400::key::msi::'+%version_date%+'::best_data::did',mv_msi1,'2');
RoxieKeyBuild.MAC_SK_Move_v2('~thor_data400::key::msi::@version@::best_data::did','Q',move2);
																			
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::msi::@version@::marriageV1::did',
																			'~thor_data400::key::msi::'+%version_date%+'::marriageV1::did',mv_msi2,'2');
RoxieKeyBuild.MAC_SK_Move_v2('~thor_data400::key::msi::@version@::marriageV1::did','Q',move3);
																			
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::msi::@version@::marriage_V2::did',
																			'~thor_data400::key::msi::'+%version_date%+'::marriage_V2::did',mv_msi3,'2');
RoxieKeyBuild.MAC_SK_Move_v2('~thor_data400::key::msi::@version@::marriage_V2::did','Q',move4);


 logicalKeys := '~thor_data400::key::msi::'+%version_date%+'::marriage_V2::did';
 copyV2 := fileservices.Copy(logicalkeys,'thor400_64',logicalkeys,_control.IPAddress.prod_thor_dali, ,'http://10.194.12.2:8010/FileSpray',,true,true);

return sequential(msi0,mv_msi0,move1,
									msi1,mv_msi1,move2,
									msi2,msi3,
									mv_msi2,mv_msi3,
									move3,move4,copyV2);
end;
