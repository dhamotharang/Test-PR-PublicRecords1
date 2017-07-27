import roxiekeybuild,ut,strata;

export Mac_Tpmdata_Spray(sourceIP,sourcefile,filedate,group_name='\'thor400_92\'',email_target='\' \'') := 
macro
#uniquename(spray_tpmdata)
#uniquename(super_tpmdata)
#uniquename(move_them)
#uniquename(recordsize)
#uniquename(fullfile)
#uniquename(daily)
#uniquename(dedup_daily)
#uniquename(basefile)
#uniquename(baseout)
#uniquename(mail_list)
#uniquename(send_succ_msg)
#uniquename(send_fail_msg)
#uniquename(send_success_msg)
#uniquename(send_failure_msg)
#uniquename(updatedops)
%updatedops% := RoxieKeyBuild.updateversion('TelcordiaTpmKeys',filedate,'jfreibaum@seisint.com');

#workunit('name','tpmdata Spray '+filedate);

%recordsize% :=95;

%spray_tpmdata% := FileServices.SprayFixed(sourceIP,sourcefile, %recordsize%, group_name,'~thor_data400::in::tpmdata_'+filedate ,-1,,,true,true);

strata_report := Risk_Indicators.STRATA_XML_TPM(filedate);

%super_tpmdata% := sequential(FileServices.StartSuperFileTransaction(),
				FileServices.AddSuperFile('~thor_data400::base::tpmdata_delete','~thor_data400::base::tpmdata_grandfather',, true),
				FileServices.ClearSuperFile('~thor_data400::base::tpmdata_grandfather'),
				FileServices.AddSuperFile('~thor_data400::base::tpmdata_grandfather','~thor_data400::base::tpmdata_father',, true),
				FileServices.ClearSuperFile('~thor_data400::base::tpmdata_father'),
				FileServices.AddSuperFile('~thor_data400::base::tpmdata_father', '~thor_data400::base::tpmdata',, true),
				FileServices.ClearSuperFile('~thor_data400::base::tpmdata'),
				FileServices.AddSuperFile('~thor_data400::base::tpmdata', '~thor_data400::in::tpmdata_'+filedate),
				FileServices.FinishSuperFileTransaction(),
				FileServices.ClearSuperFile('~thor_data400::base::tpmdata_Delete',true));


RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(Risk_Indicators.Key_Telcordia_tpm,'~thor_data400::key::telcordia_tpm','~thor_data400::key::telcordia::'+filedate+'::tpm',key1);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(Risk_Indicators.Key_Telcordia_tpm_slim,'~thor_data400::key::telcordia_tpm_slim','~thor_data400::key::telcordia::'+filedate+'::tpm_slim',key2);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(Risk_Indicators.Key_Telcordia_NPA_St,'~thor_data400::key::telcordia_npa_st','~thor_data400::key::telcordia::'+filedate+'::npa_st',key3);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(Risk_Indicators.Key_Telcordia_City_State,'~thor_data400::key::telcordia_npa_city_state','~thor_data400::key::telcordia::'+filedate+'::city_state',key4);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(Risk_Indicators.Key_Telcordia_State,'~thor_data400::key::telcordia_state','~thor_data400::key::telcordia::'+filedate+'::state',key5);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(Risk_Indicators.Key_Telcordia_Zip,'~thor_data400::key::telcordia_zip','~thor_data400::key::telcordia::'+filedate+'::zip',key6);


RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::telcordia_tpm','~thor_data400::key::telcordia::'+filedate+'::tpm',key1_built);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::telcordia_tpm_slim','~thor_data400::key::telcordia::'+filedate+'::tpm_slim',key2_built);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::telcordia_npa_st','~thor_data400::key::telcordia::'+filedate+'::npa_st',key3_built);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::telcordia_city_state','~thor_data400::key::telcordia::'+filedate+'::city_state',key4_built);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::telcordia_state','~thor_data400::key::telcordia::'+filedate+'::state',key5_built);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::telcordia_zip','~thor_data400::key::telcordia::'+filedate+'::zip',key6_built);


ut.MAC_SK_Move('~thor_data400::key::telcordia_tpm','Q',out1);
ut.MAC_SK_Move('~thor_data400::key::telcordia_tpm_slim','Q',out2);
ut.MAC_SK_Move('~thor_data400::key::telcordia_npa_st','Q',out3);
ut.MAC_SK_Move('~thor_data400::key::telcordia_city_state','Q',out4);
ut.MAC_SK_Move('~thor_data400::key::telcordia_state','Q',out5);
ut.MAC_SK_Move('~thor_data400::key::telcordia_zip','Q',out6);

%move_them% := sequential(key1,key2,key3,key4,key5,key6, key1_built,key2_built,key3_built,key4_built,key5_built,key6_built,parallel(out1,out2,out3,out4,out5,out6));


%mail_list% := 'roxiedeployment@seisint.com;vniemela@seisint.com';
// %mail_list% := 'kgummadi@seisint.com';

%send_success_msg% := FileServices.sendemail('kgummadi@seisint.com','tpmdata Spray Succeeded','tpmdata Spray Succeeded');

%send_failure_msg% := FileServices.sendemail('kgummadi@seisint.com','tpmdata Spray Failed','tpmdata Spray Failed');
								
RoxieKeyBuild.Mac_Daily_Email_Local('TELCORDIA_TPM','SUCC',filedate,%send_succ_msg%,%mail_list%);
RoxieKeyBuild.Mac_Daily_Email_Local('TELCORDIA_TPM','FAIL',filedate,%send_fail_msg%,%mail_list%);

sequential(%spray_tpmdata%,%super_tpmdata%,%move_them%,strata_report,%updatedops%)
 : success(parallel(%send_succ_msg%,%send_success_msg%)),
   failure(parallel(%send_fail_msg%,%send_failure_msg%));

endmacro;
