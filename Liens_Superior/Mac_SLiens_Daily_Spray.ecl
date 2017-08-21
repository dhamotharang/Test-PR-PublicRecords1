export Mac_SLiens_Daily_Spray(sourceIP,sourcefile,filedate,group_name='\'thor_dell400\'',email_target='\' \'') := 
macro
#uniquename(spray_liens)
#uniquename(super_liens)
#uniquename(recordsize)
#uniquename(ds_superior_liens_preprocess)
#uniquename(ds_superior_liens)
#uniquename(layout_superior)
#uniquename(did)
#uniquename(did_score)
#uniquename(ssn_app)
#uniquename(bdid)
#uniquename(build_superior_liens_keys)

#workunit('name','Superior Liens Daily Spray ' + filedate);

%recordsize% := 815;

%spray_liens% := FileServices.SprayFixed(sourceIP, sourcefile, %recordsize%, group_name, '~thor_data400::in::superior_liens_' + filedate , -1,,, true, true)
				 : success(output('superior liens spray succeeded')), failure(output('superior liens spray failed'));

%ds_superior_liens_preprocess% := dataset('~thor_data400::in::superior_liens_' + filedate,liens_superior.Layout_Superior_Liens_Preprocess, thor);

%layout_superior% := record
  %ds_superior_liens_preprocess%;
  string12 	%did% := '';
  string3  	%did_score% := '';
  string9  	%ssn_app% := '';
  string12	%bdid% := '';
end;

%ds_superior_liens% := output(table(%ds_superior_liens_preprocess%, %layout_superior%),,'~thor_data400::in::superior_liens_full_' + filedate);

%super_liens% := sequential(%ds_superior_liens%,
				FileServices.StartSuperFileTransaction(),
				FileServices.AddSuperFile('~thor_data400::base::superior_liens_delete','~thor_data400::base::superior_liens_grandfather',, true),
				FileServices.ClearSuperFile('~thor_data400::base::superior_liens_grandfather'),
				FileServices.AddSuperFile('~thor_data400::base::superior_liens_grandfather','~thor_data400::base::superior_liens_father',, true),
				FileServices.ClearSuperFile('~thor_data400::base::superior_liens_father'),
				FileServices.AddSuperFile('~thor_data400::base::superior_liens_father', '~thor_data400::base::superior_liens',, true),
				FileServices.ClearSuperFile('~thor_data400::base::superior_liens'),
				FileServices.AddSuperFile('~thor_data400::base::superior_liens', '~thor_data400::in::superior_liens_full_' + filedate), 
				FileServices.FinishSuperFileTransaction(),
				FileServices.ClearSuperFile('~thor_data400::base::superior_liens_Delete', true))
				: success(output('super liens succeeded')), failure(output('super liens failed'));

%build_superior_liens_keys% := Liens_Superior.Proc_build_superior_keys(filedate)
							   : success(output('superior liens roxie key build completed successfully')), failure(output('superior liens roxie key build failed'));

sequential(%spray_liens%, %super_liens%, %build_superior_liens_keys%)
 : success(FileServices.sendemail(if(email_target<>' ', email_target, 'kgummadi@seisint.com'),'Superior Liens Macro Succeeded','Superior Liens Macro Succeeded')),
   failure(FileServices.sendemail(if(email_target<>' ', email_target, 'kgummadi@seisint.com'),'Superior Liens Macro Failure','Superior Liens Macro Failure'))
 ;

endmacro;