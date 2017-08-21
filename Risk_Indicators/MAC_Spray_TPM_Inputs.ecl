import lib_fileservices,roxiekeybuild,ut,strata,_Control,Risk_Indicators;

export MAC_Spray_TPM_Inputs(filedate) := 

macro

#uniquename(source_ip)
#uniquename(tpm_file)
#uniquename(ocn_file)
#uniquename(plname_file)
#uniquename(spray_tpm)
#uniquename(spray_ocn)
#uniquename(spray_plname)
#uniquename(move_tpm)
#uniquename(move_tpm_ocn)
#uniquename(move_tpm_plname)
#uniquename(mail_list)
#uniquename(send_success_msg)
#uniquename(send_failure_msg)

//%source_ip% 				:= _Control.IPAddress.edata12;
%tpm_file% 					:= '/thor_back5/local_data/tpmdata/sources/' + filedate + '/TPM.DAT';
%ocn_file% 					:= '/thor_back5/local_data/tpmdata/sources/' + filedate + '/OCN.DAT';
%plname_file% 			:= '/thor_back5/local_data/tpmdata/sources/' + filedate + '/PLNAME.DAT';

%spray_tpm% 			:= Fileservices.SprayFixed(_Control.IPAddress.edata12, %tpm_file%, 111, 'thor40_241', '~thor_data400::in::tpm_'+filedate, , , ,true);
%spray_ocn% 			:= Fileservices.SprayFixed(_Control.IPAddress.edata12, %ocn_file%, 43, 'thor40_241', '~thor_data400::in::tpm_ocn_'+filedate, , , , true);
%spray_plname% 	  := Fileservices.SprayFixed(_Control.IPAddress.edata12, %plname_file%, 65, 'thor40_241', '~thor_data400::in::tpm_plname_'+filedate, , , ,true);

%move_tpm% 			:= sequential(FileServices.StartSuperFileTransaction(),
				FileServices.AddSuperFile		('~thor_data400::in::tpm_delete','~thor_data400::in::tpm_grandfather',, true),
				FileServices.ClearSuperFile	('~thor_data400::in::tpm_grandfather'),
				FileServices.AddSuperFile		('~thor_data400::in::tpm_grandfather','~thor_data400::in::tpm_father',, true),
				FileServices.ClearSuperFile	('~thor_data400::in::tpm_father'),
				FileServices.AddSuperFile		('~thor_data400::in::tpm_father', '~thor_data400::in::tpm',, true),
				FileServices.ClearSuperFile	('~thor_data400::in::tpm'),
				FileServices.AddSuperFile		('~thor_data400::in::tpm', '~thor_data400::in::tpm_'+filedate), 
				FileServices.FinishSuperFileTransaction(),
				FileServices.ClearSuperFile	('~thor_data400::in::tpm_Delete'));
				
%move_tpm_ocn% 	:= sequential(FileServices.StartSuperFileTransaction(),
				FileServices.AddSuperFile		('~thor_data400::in::tpm_ocn_delete','~thor_data400::in::tpm_ocn_grandfather',, true),
				FileServices.ClearSuperFile	('~thor_data400::in::tpm_ocn_grandfather'),
				FileServices.AddSuperFile		('~thor_data400::in::tpm_ocn_grandfather','~thor_data400::in::tpm_ocn_father',, true),
				FileServices.ClearSuperFile	('~thor_data400::in::tpm_ocn_father'),
				FileServices.AddSuperFile		('~thor_data400::in::tpm_ocn_father', '~thor_data400::in::tpm_ocn',, true),
				FileServices.ClearSuperFile	('~thor_data400::in::tpm_ocn'),
				FileServices.AddSuperFile		('~thor_data400::in::tpm_ocn', '~thor_data400::in::tpm_ocn_'+filedate), 
				FileServices.FinishSuperFileTransaction(),
				FileServices.ClearSuperFile	('~thor_data400::in::tpm_ocn_Delete'));
				
%move_tpm_plname% 	:= sequential(FileServices.StartSuperFileTransaction(),
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

%send_success_msg% 	:= FileServices.sendemail('jfreibaum@seisint.com','tpmdata Spray Succeeded','tpmdata Spray Succeeded');
%send_failure_msg%	:= FileServices.sendemail('jfreibaum@seisint.com','tpmdata Spray Failed','tpmdata Spray Failed');
								
sequential(%spray_tpm%, %spray_ocn%, %spray_plname%, %move_tpm%, %move_tpm_ocn%, %move_tpm_plname%)
 : success(%send_success_msg%), 
   failure(%send_failure_msg%);

endmacro;