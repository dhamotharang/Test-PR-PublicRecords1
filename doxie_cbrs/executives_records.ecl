import doxie,ut;

export executives_records(dataset(doxie_cbrs.layout_references) bdids) :=
MODULE

doxie_cbrs.mac_Selection_Declare()

execs := doxie_cbrs.contact_records(bdids)(Include_Executives_val);
		
company_title_rec := RECORD
	execs.company_title;
	execs.bdid;
	execs.company_name;
END;

exec_record_base := RECORD
	execs.bdid;
	execs.did;
	execs.dt_last_seen;
	execs.fname;
	execs.mname;
	execs.lname;
	execs.name_suffix;
END;

exec_record := record
	exec_record_base or company_title_rec;
end;

exec_rolled_rec := record
	exec_record_base;
	dataset(company_title_rec) company_titles {maxcount(25)};
	unsigned2 title_rank;
end;

exec_record_plus_rank := record
	exec_record;
	unsigned2 title_rank;
end;

execs_with_title_info := join(execs,executive_titles,
	trim(left.company_title,left,right) = trim(right.stored_title,left,right),
	transform(exec_record_plus_rank,
		self.title_rank := right.title_rank,
		self.company_title := right.display_title,
		self := left));

execs_w_did_rolled := rollup(group(sort(execs_with_title_info(did != 0),did),did),group,transform(exec_rolled_rec,
	self.company_titles := project(topn(dedup(sort(rows(left),company_title,bdid,title_rank),company_title,bdid),25,title_rank,company_title,bdid),company_title_rec),
	self.dt_last_seen := max(rows(left),dt_last_seen),
	self.title_rank := min(rows(left),title_rank),
	self := left));

execs_wo_did_rolled := rollup(group(sort(execs_with_title_info(did = 0),lname,fname,mname),lname,fname,mname),group,transform(exec_rolled_rec,
	self.company_titles := project(topn(dedup(sort(rows(left),company_title,bdid,title_rank),company_title,bdid),25,title_rank,company_title,bdid),company_title_rec),
	self.dt_last_seen := max(rows(left),dt_last_seen),
	self.title_rank := min(rows(left),title_rank),
	self := left));

shared dedup_titles_execs := sort(execs_w_did_rolled + execs_wo_did_rolled,title_rank,-dt_last_seen,if(did != 0,0,1));
	
doxie_cbrs.mac_Selection_Declare()
									
export records := choosen(dedup_titles_execs,Max_Executives_val);
export records_count := count(dedup_titles_execs); 
END;