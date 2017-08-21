infutor_file := infutor.File_Infutor_DID;

r1 := record
 infutor_file.effective_dt;
 count_ := count(group);
end;

ta1 := sort(table(infutor_file,r1,effective_dt,few),effective_dt);

export coverage_by_effective_date := output(ta1,all);