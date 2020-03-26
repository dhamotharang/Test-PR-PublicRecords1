import lib_fileservices,ut;
// #workunit('name','Mapping MI Marriage');
//bug #78669
Layout_in_cnt := record
Layout_Marriage_MI_Raw;
unsigned integer cnt_ := 0;
end;


Layout_in_cnt tmi_cnt(File_Marriage_MI_raw le,integer count_) := transform
self.cnt_ := if(le.groom_age = '' or le.bride_age = '',count_,count_ + 1);
self := le;
end;

File_mi_cnvt := project(File_Marriage_MI_raw,tmi_cnt(LEFT,COUNTER));


Layout_in_cnt tRollup(File_mi_cnvt l,File_mi_cnvt r) := transform
self.groom_name := l.groom_name + ' ' + r.groom_name;
self.groom_addr := l.groom_addr + ' ' + r.groom_addr;
self.bride_name := l.bride_name + ' '+ r.bride_name;
self.bride_addr := l.bride_addr + ' ' + r.bride_addr;
self.groom_age := l.groom_age[1..2];
self.bride_age := l.bride_age[1..2];
self.lf := l.lf;
end;

File_mi_rollup := Rollup(File_mi_cnvt,LEFT.cnt_=RIGHT.cnt_,tRollup(LEFT,RIGHT));

marriage_divorce_v2.Layout_Marriage_MI_In tFinal(File_mi_rollup le) := transform
fdate := nothor(ut.fGetFilenameVersion('~thor_200::in::mar_div::mi::marriage_raw'));
self.filing_dt1 := (string)fdate;
self.payload1 := le.groom_name + ' '+ le.groom_age;
self.filing_dt2 := (string)fdate;
self.payload2 := le.groom_addr;
self.filing_dt3 := (string)fdate;
self.payload3 := le.bride_name + ' ' + le.bride_age;
self.filing_dt4 := (string)fdate;
self.payload4 := le.bride_addr;
self.filing_dt5 := (string)fdate;
self := [];
end;

File_In_mi_marriage := project(File_mi_rollup,tFinal(LEFT));

getlfname := nothor(Fileservices.GetSuperFileSubName('~thor_200::in::mar_div::mi::marriage_raw',1));

out_File_mi_marriage := output(File_In_mi_marriage (payload1 <> '' or payload3 <> '') ,,'~'+ getlfname + '_new',__compressed__,overwrite);

export mapping_mi_marriage_raw := sequential( if (count(File_Marriage_MI_raw) = 0,FAIL('MI Marriage Raw subfile is dummy  !!! Job Aborted')),
                                             out_File_mi_marriage,
																						 
																						 Fileservices.AddSuperFile('~thor_200::in::mar_div::mi::marriage','~'+ getlfname + '_new'),
																						 Fileservices.ClearSuperFile('~thor_200::in::mar_div::mi::marriage_raw'));



