/*2012-02-24T17:37:32Z (gwitz)
C:\Documents and Settings\gwitz\Application Data\LexisNexis\querybuilder\gwitz\Boca_Dataland\ZipByCounty2\Spray_Input\2012-02-24T17_37_32Z.ecl
*/



import _control;
export Spray_Input(STRING sourceIP,STRING filedate,STRING group_name='thor_200',STRING email_target='\' \'') := 
function
srcCSVseparator				:=	',';
srcCSVterminator			:=	'\\n,\\r\\n';
srcCSVquote					:=	'"';
sourcePath 				:= '/export/home/gwitz/';

#workunit('name','ZipByCounty Spray ' + filedate);

sprayIP := map(sourceIP = 'edata12' => _control.IPAddress.edata12,
								 sourceIP);

recordsize :=8192;

quarterlyFileName		:= FileServices.remotedirectory(sprayIP,sourcePath,'*ZIPList*csv',false)(size != 0 )[1].name;

spray_banko := fileservices.SprayVariable(sprayIP,sourcePath+quarterlyFileName, recordsize 
										,srcCSVseparator
										,srcCSVterminator
										,srcCSVquote,group_name
										,'~thor_data400::in::zipbycountykeys_'+filedate);

super_banko := sequential(FileServices.StartSuperFileTransaction(),
												FileServices.AddSuperFile('~thor_data400::in::countystate_zip_delete','~thor_data400::in::countystate_zip_father',, true),
												FileServices.ClearSuperFile('~thor_data400::in::countystate_zip_father'),
												FileServices.AddSuperFile('~thor_data400::in::countystate_zip_father', '~thor_data400::in::countystate_zip',, true),
												FileServices.ClearSuperFile('~thor_data400::in::countystate_zip'),
												FileServices.AddSuperFile('~thor_data400::in::countystate_zip','~thor_data400::in::zipbycountykeys_'+filedate), 
												FileServices.FinishSuperFileTransaction(),
												FileServices.ClearSuperFile('~thor_data400::in::countystate_zip_delete',true));

outstatus := sequential(spray_banko,super_banko)
 : success(FileServices.sendemail(if(email_target<>' ',email_target,'gwitz@seisint.com'),'ZipByCounty Spray Succeeded','ZipByCounty Spray Succeeded')),
   failure(FileServices.sendemail(if(email_target<>' ',email_target,'gwitz@seisint.com'),'ZipByCounty Spray Failure','ZipByCounty Spray Failure'))
 ;

return outstatus;
end;
