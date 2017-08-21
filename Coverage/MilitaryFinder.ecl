/* W20080221-152223
Military Finder (MFind)
*/

import ut;

mfind_file := mfind.File_MFind_Clean;

r1 := record
 string20 field;
 string10 date_;
end;

r1 t1(mfind_file le, integer c) := transform
 self.field := choose(c,'MIL_ACTIVE_DATE','MIL_EST_SEP_DATE','MIL_SEP_DATE');
 self.date_ := choose(c,le.mil_active_date,le.mil_est_sep_date,le.mil_sep_date);
end;

p1 := normalize(mfind_file,3,t1(left,counter));

ut.macAppendStandardizedDate(p1,date_,p1_out);

//output(p1_out);

r2 := record
 string6 clean_date_ym;
 p1_out.field;
end;

r2 t2(p1_out le) := transform
 self.clean_date_ym := if(le.yyyy='0000','',le.yyyy+le.mm);
 self               := le;
end;

p2 := project(p1_out,t2(left));

r3 := record
 p2.clean_date_ym;
 p2.field;
 count_ := count(group);
end;

ta1 := sort(table(p2,r3,field,clean_date_ym,few),field,clean_date_ym);
output(ta1(count_>1),all);