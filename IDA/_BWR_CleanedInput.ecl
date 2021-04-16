IMPORT STD,IDA;

#option('pickBestEngine', 0);
#option('outputlimitmb', 2000);

EXPORT _BWR_CleanedInput(string pversion='',boolean pUseProd=false) := function


DS:=DATASET('~thor_data400::in::prep::ida::built',IDA.Layouts.input,csv(heading(1), separator('|'),terminator(['\n', '\r\n']), quote('"')));
output(count(ds),NAMED('Input_file_rec_counts'));
// output(ds,NAMED('Input_file_records'));

badrecords:=ds(~REGEXFIND('[a-z]{3}[0-9]{15}|[a-z]{3}[0-9]{14}|[a-z]{3}[0-9]{13}',clientassigneduniquerecordid,nocase));
output(count(badrecords),NAMED('Bad_records_count'));
output(badrecords,all,NAMED('Bad_records'));

goodrecords:=ds(REGEXFIND('[a-z]{3}[0-9]{15}|[a-z]{3}[0-9]{14}|[a-z]{3}[0-9]{13}',clientassigneduniquerecordid,nocase));
output(count(goodrecords),NAMED('Good_records_count'));
output(goodrecords,NAMED('Good_records'));



outgood:=output(goodrecords,,'~thor_data400::in::clean::ida::'+pversion,csv(heading(single),separator('|'), terminator(['\n', '\r\n']), quote('"')),compressed,overwrite);
outbad:=output(badrecords,,'~thor_data400::in::rejected::ida::'+pversion,csv(heading(single),separator('|'), terminator(['\n', '\r\n']), quote('"')),compressed,overwrite);


CleanOut:=sequential(outgood
		          ,STD.File.StartSuperFileTransaction()
				  ,STD.File.Addsuperfile('~thor_data400::in::clean::ida::qa','~thor_data400::in::clean::ida::built',,TRUE)
				  ,STD.File.ClearSuperfile('~thor_data400::in::clean::ida::built')
                  ,STD.File.AddSuperFile('~thor_data400::in::clean::ida::built', '~thor_data400::in::clean::ida::'+pversion)
				  ,STD.File.FinishSuperFileTransaction()

);

RejectedOut:=sequential(outbad
		          ,STD.File.StartSuperFileTransaction()
				  ,STD.File.Addsuperfile('~thor_data400::in::rejected::ida::qa','~thor_data400::in::rejected::ida::built',,TRUE)
				  ,STD.File.ClearSuperfile('~thor_data400::in::rejected::ida::built')
                  ,STD.File.AddSuperFile('~thor_data400::in::rejected::ida::built', '~thor_data400::in::rejected::ida::'+pversion)
				  ,STD.File.FinishSuperFileTransaction()

);


return SEQUENTIAL(CleanOut,IF(EXISTS(badrecords),RejectedOut));

end;