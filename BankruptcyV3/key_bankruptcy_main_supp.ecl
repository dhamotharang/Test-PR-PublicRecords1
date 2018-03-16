import ut,BankruptcyV2,fcra,dops;

export key_bankruptcy_main_supp(boolean isFCRA = false) := function
  todaysdate := ut.GetDate;
	get_recs :=  BankruptcyV2.file_bankruptcy_main_v3_supplemented(~isFCRA OR fcra.bankrupt_is_ok (todaysdate,date_filed));;
	FCRATest:=if(isFCRA,get_recs(court_code+case_number not in dops.SuppressID('bankruptcy').GetIDsAsSet(isFCRA)),get_recs);
layout_slim := record
get_recs.tmsid;
get_recs.method_dismiss;
get_recs.case_status;
end;

slim_recs := dedup(table(FCRATest,layout_slim,tmsid,method_dismiss,case_status,few),record,all);
key_name := bankruptcyv3.BuildKeyName(isFCRA, 'main::supplemental');

	return index(slim_recs,{tmsid},{method_dismiss,case_status},key_name);
end;