import lib_fileservices,roxiekeybuild,ut,strata,_Control,Risk_Indicators;

export Spray_TPM_Inputs(string filedate) :=

function

string ipaddr := if ( _Control.ThisEnvironment.Name = 'Dataland', _Control.IPAddress.bctlpedata12,_Control.IPAddress.bctlpedata11 );
string groupname := thorlib.group();
  
spray_tpm 			:= Fileservices.SprayFixed(ipaddr, '/data/thor_back5/local_data/tpmdata/sources/' + filedate + '/TPM.DAT', 111, groupname, '~thor_data400::in::tpm_'+filedate, , , ,true);
spray_ocn 			:= Fileservices.SprayFixed(ipaddr, '/data/thor_back5/local_data/tpmdata/sources/' + filedate + '/OCN.DAT', 43, groupname, '~thor_data400::in::tpm_ocn_'+filedate, , , , true);
spray_plname 	  := Fileservices.SprayFixed(ipaddr, '/data/thor_back5/local_data/tpmdata/sources/' + filedate + '/PLNAME.DAT', 65, groupname, '~thor_data400::in::tpm_plname_'+filedate, , , ,true);

move_tpm 			:= sequential(FileServices.StartSuperFileTransaction(),
				FileServices.AddSuperFile		('~thor_data400::in::tpm_delete','~thor_data400::in::tpm_grandfather',, true),
				FileServices.ClearSuperFile	('~thor_data400::in::tpm_grandfather'),
				FileServices.AddSuperFile		('~thor_data400::in::tpm_grandfather','~thor_data400::in::tpm_father',, true),
				FileServices.ClearSuperFile	('~thor_data400::in::tpm_father'),
				FileServices.AddSuperFile		('~thor_data400::in::tpm_father', '~thor_data400::in::tpm',, true),
				FileServices.ClearSuperFile	('~thor_data400::in::tpm'),
				FileServices.AddSuperFile		('~thor_data400::in::tpm', '~thor_data400::in::tpm_'+filedate), 
				FileServices.FinishSuperFileTransaction(),
				FileServices.ClearSuperFile	('~thor_data400::in::tpm_Delete'));
				
move_tpm_ocn 	:= sequential(FileServices.StartSuperFileTransaction(),
				FileServices.AddSuperFile		('~thor_data400::in::tpm_ocn_delete','~thor_data400::in::tpm_ocn_grandfather',, true),
				FileServices.ClearSuperFile	('~thor_data400::in::tpm_ocn_grandfather'),
				FileServices.AddSuperFile		('~thor_data400::in::tpm_ocn_grandfather','~thor_data400::in::tpm_ocn_father',, true),
				FileServices.ClearSuperFile	('~thor_data400::in::tpm_ocn_father'),
				FileServices.AddSuperFile		('~thor_data400::in::tpm_ocn_father', '~thor_data400::in::tpm_ocn',, true),
				FileServices.ClearSuperFile	('~thor_data400::in::tpm_ocn'),
				FileServices.AddSuperFile		('~thor_data400::in::tpm_ocn', '~thor_data400::in::tpm_ocn_'+filedate), 
				FileServices.FinishSuperFileTransaction(),
				FileServices.ClearSuperFile	('~thor_data400::in::tpm_ocn_Delete'));
				
move_tpm_plname 	:= sequential(FileServices.StartSuperFileTransaction(),
				FileServices.AddSuperFile		('~thor_data400::in::tpm_plname_delete','~thor_data400::in::tpm_plname_grandfather',, true),
				FileServices.ClearSuperFile	('~thor_data400::in::tpm_plname_grandfather'),
				FileServices.AddSuperFile		('~thor_data400::in::tpm_plname_grandfather','~thor_data400::in::tpm_plname_father',, true),
				FileServices.ClearSuperFile	('~thor_data400::in::tpm_plname_father'),
				FileServices.AddSuperFile		('~thor_data400::in::tpm_plname_father', '~thor_data400::in::tpm_plname',, true),
				FileServices.ClearSuperFile	('~thor_data400::in::tpm_plname'),
				FileServices.AddSuperFile		('~thor_data400::in::tpm_plname', '~thor_data400::in::tpm_plname_'+filedate),	
				FileServices.FinishSuperFileTransaction(),
				FileServices.ClearSuperFile	('~thor_data400::in::tpm_plname_Delete'));

//%mail_list% := 'jfreibaum@seisint.com';

spray_send_success_msg 	:= FileServices.sendemail('jfreibaum@seisint.com','tpmdata Spray Succeeded','tpmdata Spray Succeeded');
spray_send_failure_msg	:= FileServices.sendemail('jfreibaum@seisint.com','tpmdata Spray Failed','tpmdata Spray Failed');
								
run_all := sequential(spray_tpm, spray_ocn, spray_plname, move_tpm, move_tpm_ocn, move_tpm_plname)
 : success(spray_send_success_msg), 
   failure(spray_send_failure_msg);

return run_all;

end;
