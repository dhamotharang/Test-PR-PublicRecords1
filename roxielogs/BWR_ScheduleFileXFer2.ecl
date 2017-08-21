/*********************************************************************
**  Intended for submissions via builder window to thor200, into scheduler
W20101029-091933 is the most recent WU
*********************************************************************/
IMPORT UT;

#workunit('name','RoxieLogs: copy files');

//******
// READ THE FILE OF NEEDED UPDATES.  THAT FILE WAS WRITTEN BY roxielogs.BWR_ScheduleFileXFer1.
// THEN, SCRUB THE FILE AND WRITE IT TO DATALAND AND ADD IT TO THE SUPERFILE
//******

sfn := roxielogs.File_LogsTrim.super_file_name;
fsfn := ut.foreign_logs + sfn;
lsfn := '~' + sfn;


rec := {string100 lfn};
ds := dataset([{''}], rec);

need_update := dataset(lsfn + 'need_update', rec, thor);

compressed_subfile(string s) := trim(stringlib.stringfindreplace(s, '::logs::', '::logs::compressed::'));

do_update(string lfn) :=
FUNCTION
	
	unscrub := roxielogs.File_LogsTrim.ds_raw(ut.foreign_logs + lfn);
	scrubbed := roxielogs.File_LogsTrim.scrub(unscrub);
	llfn := '~' + compressed_subfile(lfn);

	return 
	if(lfn <> '',
		sequential
		(
			output(scrubbed,,llfn, COMPRESSED, OVERWRITE),  
			FileServices.AddSuperFile(lsfn, llfn)
		)
	);


END;

update1 := need_update[1].lfn;
update2 := need_update[2].lfn;
// update3 := need_update[3].lfn;
// update4 := need_update[4].lfn;
// update5 := need_update[5].lfn;


updates := 
sequential
(
	if(update1 <> '', do_update(update1))
	,if(update2 <> '', do_update(update2))
	// ,do_update(update3)
	// ,do_update(update4)
	// ,do_update(update5)
);

str_cron := '0 23 * * *'; //every day at 7PM ET

email_body :=
THORLIB.WUID()
+ '\nCount needing update: ' + count(need_update)
+ if(update1 <> '', '\nUpdated: ' + update1, '')
+ if(update2 <> '', '\nUpdated: ' + update2, '')
// + if(update3 <> '', '\nUpdated: ' + update3, '')
// + if(update4 <> '', '\nUpdated: ' + update4, '')
// + if(update5 <> '', '\nUpdated: ' + update5, '')
+ '\n' + str_cron;
;


action := 
sequential(
	updates,
	fileservices.sendemail('cmorton@seisint.com', str_cron,email_body)
);

action : WHEN(EVENT('CRON', str_cron));