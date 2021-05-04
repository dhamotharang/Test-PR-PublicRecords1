IMPORT STD,IDA;

EXPORT _BWR_DropQuotationMarks(string pversion='',boolean pUseProd=false) := function


DS:=DATASET('~thor_data400::in::IDA::built',{string x},csv(heading(1),separator(''),terminator(['\n', '\r\n']), quote('"')));
output(count(ds),NAMED('Total_records_cnt_in_file'));
filter:=ds(REGEXFIND('\"',x,nocase));
output(count(filter),NAMED('Total_records_cnt_that_have_quotation_marks'));
output(filter,all,NAMED('Records_that_have_quotation_marks'));


prj:=PROJECT(ds,TRANSFORM({recordof(ds)},
                              SELF.x:=REGEXREPLACE('\"',Left.x,''),
                              SELF:=LEFT));


out:=output(prj,,'~thor_data400::in::prep::ida::'+pversion,csv(heading(single),separator(''), terminator(['\n', '\r\n']), quote('"')),compressed,overwrite);

PrepFile:=sequential(out
		          ,STD.File.StartSuperFileTransaction()
				  ,STD.File.Addsuperfile('~thor_data400::in::prep::ida::qa','~thor_data400::in::prep::ida::built',,TRUE)
				  ,STD.File.ClearSuperfile('~thor_data400::in::prep::ida::built')
                  ,STD.File.AddSuperFile('~thor_data400::in::prep::ida::built', '~thor_data400::in::prep::ida::'+pversion)
				  ,STD.File.FinishSuperFileTransaction()

);

return PrepFile;

end;