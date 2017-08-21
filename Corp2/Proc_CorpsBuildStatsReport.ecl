export proc_CorpsBuildStatsReport(string filedate) := function

layout_used := Record
STRING100 name;
string1 lf;
end;

ds1 := dataset('~thor_data400::dump::corp2::used::corp'+filedate,layout_used,flat);

rec_mmddyyyy := record
                string state;
                string date;
                string notes;
end;

rec_mmddyyyy xfm1(layout_used L) := transform

  STRING replace := stringlib.stringfindreplace(L.name,'::',''); 
	STRING replace1 := stringlib.stringfindreplace(replace,'_',''); 
  STRING name1 := TRIM(replace1);

  INTEGER MyLength := LENGTH(name1);
                INTEGER st := MyLength - 1;
  
                STRING replace2 := stringlib.stringfindreplace(name1[27..(st-1)],'corp','');
                self.state:= stringlib.StringToUpperCase(name1[st..MyLength]+' '+replace2);
                self.date := name1[19..22]+'/'+name1[23..24]+'/'+name1[25..26];
                STRING full_file := if(replace2[1] ='f',stringlib.stringfindreplace(replace2[1],'f','full replacement'),replace2);
                STRING quart_file := if(full_file[1] ='q',stringlib.stringfindreplace(full_file[1],'q','quarterly replacement'),full_file);
                self.notes :=quart_file;
end;

f_mmddyyyy1 := project(ds1, xfm1(left));

f_srt := sort(f_mmddyyyy1, state,date);

retval := output(f_srt, named('f_srt'),all);

return retval;
end;
