/*********************************************************************
**  Intended for submissions via builder window to hthor, into scheduler
*********************************************************************/
IMPORT UT;

#workunit('name','RoxieLogs: list updates');

//******
// FIRST, LETS FIGURE OUT WHICH SUBFILES EXIST ON THE OTHER THOR AND NOT DATALAND
// WE'LL PUT THE LIST ON DISK SO THAT WE CAN LOOP ON HTHOR AND THEN PICK UP THE ANSWER FROM THOR LATER
//******

sfn := roxielogs.File_LogsTrim.super_file_name;
fsfn := roxielogs.File_LogsTrim.foreign_super_file_name;
lsfn := '~' + sfn;

rec := {string100 lfn};
ds := dataset([{''}], rec);

strip_foreign_prefix(string s) := '~' + s[length(trim(ut.foreign_logs))..];

compressed_subfile(string s) := trim(stringlib.stringfindreplace(s, '::logs::', '::logs::compressed::'));

dataset(rec) f(dataset(rec) l, integer c) := function
	lfniq := strip_foreign_prefix(FileServices.GetSuperFileSubName(fsfn, c));
	clfniq := compressed_subfile(lfniq);
	return 
	l +
	dataset(
		[{
		if(
			(lfniq <> '' and stringlib.stringfind(lfniq, '::in::', 1) = 0) and // excluding input file
			FileServices.FindSuperFileSubName(lsfn, clfniq) = 0,
			lfniq[2..],
			''			
		)
		}],
		rec
	);
end;

need_update := dedup(sort(loop(ds, FileServices.GetSuperFileSubCount(fsfn),  f(rows(left), counter))(lfn <> ''), -lfn), lfn);

str_cron := '0 22 * * *'; //every day at 6PM ET

email_body :=
THORLIB.WUID()
+ '\nCount needing update: ' + count(need_update)
+ '\n' + str_cron;
;


action := 
sequential(
	output(need_update,,lsfn + 'need_update',overwrite),
	fileservices.sendemail('cmorton@seisint.com', str_cron,email_body)
);

action : WHEN(EVENT('CRON', str_cron));