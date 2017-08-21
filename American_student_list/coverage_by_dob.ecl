
asl_file := american_student_list.File_american_student_DID;

r1 := record
 string6 dob_ym;
end;

r1 t1(asl_file le) := transform
 self.dob_ym := le.dob_formatted[1..6];
end;

p1 := project(asl_file,t1(left));

r2 := record
 p1.dob_ym;
 count_ := count(group);
end;

ta1 := sort(table(p1,r2,dob_ym,few),dob_ym);

export coverage_by_dob := output(ta1,all);