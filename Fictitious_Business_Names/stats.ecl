d :=  Fictitious_Business_Names.File_In_InfoUSA_DQ458 + 
			Fictitious_Business_Names.File_In_InfoUSA_DQ459 + 
			Fictitious_Business_Names.File_In_InfoUSA_DQ460 + 
			Fictitious_Business_Names.File_In_InfoUSA_DQ461 + 
			Fictitious_Business_Names.File_In_InfoUSA_DQ462 + 
			Fictitious_Business_Names.File_In_InfoUSA_DQ463 + 
			Fictitious_Business_Names.File_In_InfoUSA_DQ464 + 
			Fictitious_Business_Names.File_In_InfoUSA_DQ465 + 
			Fictitious_Business_Names.File_In_InfoUSA_DQ466 + 
			Fictitious_Business_Names.File_In_InfoUSA_DQ467 + 
			Fictitious_Business_Names.File_In_InfoUSA_DQ468 + 
			Fictitious_Business_Names.File_In_InfoUSA_DQ469 ;
			
//d_dist := distribute(d, hash(ci));			

//d_sort := sort(d_dist,ci,local);

stat_rec := record
d.Filing_Number  ;
total := count(group);
end;

stat := table(d,stat_rec,Filing_Number ,few);

sort_stat := sort(stat,Filing_Number );
output(choosen(sort_stat,all));