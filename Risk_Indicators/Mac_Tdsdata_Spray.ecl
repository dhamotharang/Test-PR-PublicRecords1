import roxiekeybuild,ut;

export Mac_Tdsdata_Spray(sourceIP,sourcefile,filedate,group_name='\'thor_200\'',email_target='\' \'') := 
macro
#uniquename(spray_tdsdata)
#uniquename(super_tdsdata)
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
%updatedops% := RoxieKeyBuild.updateversion('TelcordiaTdsKeys',filedate,'john.freibaum@lexisnexis.com');

#workunit('name','tdsdata Spray '+filedate);

%recordsize% :=21;

%spray_tdsdata% := FileServices.SprayFixed(sourceIP,sourcefile, %recordsize%, group_name,'~thor_data400::in::tdsdata_'+filedate ,-1,,,true,true);


%super_tdsdata% := sequential(FileServices.StartSuperFileTransaction(),
				FileServices.AddSuperFile('~thor_data400::base::tdsdata_delete','~thor_data400::base::tdsdata_grandfather',, true),
				FileServices.ClearSuperFile('~thor_data400::base::tdsdata_grandfather'),
				FileServices.AddSuperFile('~thor_data400::base::tdsdata_grandfather','~thor_data400::base::tdsdata_father',, true),
				FileServices.ClearSuperFile('~thor_data400::base::tdsdata_father'),
				FileServices.AddSuperFile('~thor_data400::base::tdsdata_father', '~thor_data400::base::tdsdata',, true),
				FileServices.ClearSuperFile('~thor_data400::base::tdsdata'),
				FileServices.AddSuperFile('~thor_data400::base::tdsdata', '~thor_data400::in::tdsdata_'+filedate),
				FileServices.FinishSuperFileTransaction(),
				FileServices.ClearSuperFile('~thor_data400::base::tdsdata_Delete',true));
				
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(Risk_Indicators.Key_Telcordia_tds,'~thor_data400::key::telcordia_tds','~thor_data400::key::telcordia::'+filedate+'::tds',key1,true);

RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::telcordia_tds','~thor_data400::key::telcordia::'+filedate+'::tds',key1_built,true);

ut.MAC_SK_Move('~thor_data400::key::telcordia_tds','Q',out1)

%move_them% := sequential(key1,key1_built,out1);

%mail_list% := 'john.freibaum@lexisnexis.com';
// %mail_list% := 'kgummadi@seisint.com';

%send_success_msg% := FileServices.sendemail('john.freibaum@lexisnexis.com','tdsdata Spray Succeeded','tdsdata Spray Succeeded');

%send_failure_msg% := FileServices.sendemail('john.freibaum@lexisnexis.com','tdsdata Spray Failed','tdsdata Spray Failed');
								
RoxieKeyBuild.Mac_Daily_Email_Local('TELCORDIA_TDS','SUCC',filedate,%send_succ_msg%,%mail_list%);
RoxieKeyBuild.Mac_Daily_Email_Local('TELCORDIA_TDS','FAIL',filedate,%send_fail_msg%,%mail_list%);

sequential(%spray_tdsdata%,%super_tdsdata%,%move_them%,%updatedops%)
 : success(parallel(%send_succ_msg%,%send_success_msg%)),
   failure(parallel(%send_fail_msg%,%send_failure_msg%));

endmacro;