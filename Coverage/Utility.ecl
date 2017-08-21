/* W20080222-120601
Utility
*/

export coverage_by_connect_date_opt_state := module

util_file := utilfile.file_util_in;

r1 := record
 string6 connect_date_ym;
 util_file.st;
end;

r1 t1(util_file le) := transform
 self.connect_date_ym := le.connect_date[1..6];
 self                 := le;
end;

shared p1 := project(util_file,t1(left));

r2 := record
 p1.st;
 p1.connect_date_ym;
 count_ := count(group);
end;

ta1 := sort(table(p1,r2,st,connect_date_ym,few),st,connect_date_ym);
ta1_filt := ta1(count_>1000);

export by_connect_date_and_state := output(ta1_filt,all);

r3 := record
 p1.connect_date_ym;
 count_ := count(group);
end;

ta2 := sort(table(p1,r3,connect_date_ym,few),connect_date_ym);
ta2_filt := ta2(count_>1000);

export by_connect_date := output(ta2_filt,all);

end;

coverage_by_connect_date_opt_state.by_connect_date_and_state;
coverage_by_connect_date_opt_state.by_connect_date;