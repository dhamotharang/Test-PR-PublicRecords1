import ut,_control;
export Mac_Liens_Daily_Spray(sourcefile,filedate,group_name=_control.TargetGroup.ADL_400,email_target='\' \'') := 
macro
#uniquename(spray_liens)
#uniquename(super_liens)
#uniquename(recordsize)
#uniquename(fullfile)
#uniquename(daily)
#uniquename(dedup_daily)
#uniquename(basefile)
#uniquename(basefile_2)
#uniquename(baseout)
#uniquename(sourceIP)

#workunit('name','Liens Daily Spray '+filedate);
#workunit('priority','high');


///////////////// Replace dummy records version with current date ///////////

#uniquename(dummy_ds)
#uniquename(new_dummy_ver)
#uniquename(new_dummy_data)

%sourceIP% := _control.IPAddress.edata12;

%dummy_ds% := dataset('~thor_data400::in::liens_dummy',bankrupt.Layout_Liens,thor);

Bankrupt.layout_liens change_dummy_ver(%dummy_ds% d) := transform
	self.uploaddate := ut.GetDate;
	self := d;
end;

%new_dummy_ver% := project(%dummy_ds%,change_dummy_ver(left));


///////////////// Regular liens ////////////////

%recordsize% :=2039;

%spray_liens% := FileServices.SprayFixed(%sourceIP%,sourcefile, %recordsize%, group_name,'~thor_data400::in::liens_'+filedate ,-1,,,true,true);

%fullfile% := dataset('~thor_data400::base::liens',bankrupt.Layout_Liens,thor);

%daily% := dataset('~thor_data400::in::liens_'+filedate,bankrupt.Layout_Liens,thor);

%dedup_daily% := dedup(%daily%,ALL);

#uniquename(prt_title)
#uniquename(prt_recs)
#uniquename(prt_sample)
#uniquename(email_prt_sample)
%prt_title% := output('200 new Liens sample records ...');
%prt_recs% := output(choosen(enth(%dedup_daily%,200),200));
%prt_sample% := parallel(%prt_title%, %prt_recs%);
%email_prt_sample% := FileServices.sendemail('qualityassurance@seisint.com','LIENS DAILY SAMPLE READY','at ' + thorlib.WUID());


%basefile% := %fullfile%((integer)did < 999999001000) + %dedup_daily% + %new_dummy_ver%;

%basefile_2% := %basefile%(~((integer)amount=20233 and defname[1..11]='WHITE GLOVE' and filing_date='20020723'));

%baseout% := output(%basefile_2%,,'~thor_data400::in::liens_full_'+filedate,overwrite);

%super_liens% := sequential(%baseout%,
				FileServices.StartSuperFileTransaction(),
				FileServices.AddSuperFile('~thor_data400::base::liens_delete','~thor_data400::base::liens_grandfather',, true),
				FileServices.AddSuperFile('~thor_data400::base::liens_daily_delete','~thor_data400::base::liens_daily_grandfather',, true),
				FileServices.ClearSuperFile('~thor_data400::base::liens_grandfather'),
				FileServices.ClearSuperFile('~thor_data400::base::liens_daily_grandfather'),
				FileServices.AddSuperFile('~thor_data400::base::liens_grandfather','~thor_data400::base::liens_father',, true),
				FileServices.AddSuperFile('~thor_data400::base::liens_daily_grandfather','~thor_data400::base::liens_daily_father',, true),
				FileServices.ClearSuperFile('~thor_data400::base::liens_father'),
				FileServices.ClearSuperFile('~thor_data400::base::liens_daily_father'),
				FileServices.AddSuperFile('~thor_data400::base::liens_father', '~thor_data400::base::liens',, true),
				FileServices.AddSuperFile('~thor_data400::base::liens_daily_father', '~thor_data400::base::liens_daily',, true),
				FileServices.ClearSuperFile('~thor_data400::base::liens'),
				FileServices.ClearSuperFile('~thor_data400::base::liens_daily'),
				FileServices.AddSuperFile('~thor_data400::base::liens', '~thor_data400::in::liens_full_'+filedate),
				FileServices.AddSuperFile('~thor_data400::base::liens_daily', '~thor_data400::in::liens_'+filedate), 
				FileServices.ClearSuperFile('~thor_data400::in::liens_did_in'),
				FileServices.AddSuperFile('~thor_data400::in::liens_did_in', '~thor_data400::in::liens_full_'+filedate), 
				FileServices.FinishSuperFileTransaction(),
				FileServices.ClearSuperFile('~thor_data400::base::liens_Delete',true),
				FileServices.ClearSuperFile('~thor_data400::base::liens_daily_Delete',true));

sequential(%spray_liens%,%super_liens%,%prt_recs%,%email_prt_sample%)
 : success(FileServices.sendemail(if(email_target<>' ',email_target,'cpettola@seisint.com'),'Liens Spray Succeeded','Liens Spray Succeeded')),
   failure(FileServices.sendemail(if(email_target<>' ',email_target,'cpettola@seisint.com'),'Liens Spray Failure','Liens Spray Failure'))
 ;

endmacro;