import header,compID ; 
export fn_BestJoined_No_New_header( dataset(recordof(header.layout_header))head,boolean isnewheader) := function 
//boolean var2 := true : stored('isnewheader');
string20 var1 := '' : stored('watchtype');

did_rec := record
	head.did;
	integer4 total_records := count(group);
end;

did_dups0 := table(head, did_rec, did, local) ;
did_dups_pst := did_dups0 : persist('persist::watchdog_did_dedup_nonew_header_2');
did_dups := if (isnewheader=false,did_dups_pst); 
lbest := Watchdog.Layout_Best_Marketing_Flag;

baddressweekly := watchdog.BestAddress;

//getaddress
lbest getaddress(did_dups l, baddressweekly r) := transform
	self.prim_range := r.prim_range;
	self.predir := r.predir;
	self.prim_name := r.prim_name;
	self.suffix := r.suffix;
	self.postdir := r.postdir;
	self.unit_desig := r.unit_desig;
	self.sec_range := r.sec_range;
	self.city_name := r.city_name;
	self.st := r.st;
	self.zip := r.zip;
	self.zip4 := r.zip4;
	self.addr_dt_last_seen := r.addr_dt_last_seen;
	self.addr_dt_first_seen := r.addr_dt_first_seen;
  self.RawAID := r.RawAID;
	self := l;
end;

waddressweekly := join(did_dups, baddressweekly, left.did = right.did,
			     getaddress(left, right), left outer, local);
				 
bdeathweekly := watchdog.Death;

lbest getdeath(lbest l, bdeathweekly r) := transform
	self.dod := r.dod;
	self := l;
end;

wdeathweekly := join(waddressweekly, bdeathweekly, left.did = right.did,
			 getdeath(left, right), left outer, local);
			 
fbest := map(var1='nonglb'	          =>Watchdog.File_Best_nonglb,
				  var1='marketing'    =>Watchdog.File_Best_marketing,
				  var1='compid'	  => project(compID.file_compid_best, transform(watchdog.Layout_Best, self := left)),
				  var1='compid_weekly' =>project(compID.file_compid_best_weekly,transform(watchdog.Layout_Best, self := left)),
				  var1='glb_nonen'     =>Watchdog.File_Best_nonExperian,	
				  var1='glb_noneq'     =>Watchdog.File_Best_nonEquifax,	
				  Watchdog.File_Best
				 );	

lbest getall(lbest l, fbest r) := transform
	
	self.phone := r.phone;
	self.marketing_flag := ''; // not available in prev base. but those phones already got blanked in marketing best 
	self.ssn := r.ssn;
    self.dob := r.dob;
    self.fname := r.fname;
	self.mname := r.mname;
	self.lname := r.lname;
	self.name_suffix := r.name_suffix;
	self.Prpty_deed_id := r.Prpty_deed_id;
	self.Vehicle_vehnum := r.Vehicle_vehnum;
    self.Bkrupt_CrtCode_CaseNo := r.Bkrupt_CrtCode_CaseNo;
	self.main_count := r.main_count;
    self.search_count := r.search_count;
    self.dl_number := r.dl_number;
	self.run_date := (integer)RunDate_build;
	self.bdid := r.bdid;
	self.title := r.title;
	self.ADL_ind := r.ADL_ind;
	self.valid_ssn := r.valid_ssn;
	self := l;
end;
				 
result := join( wdeathweekly, distribute(fbest,hash(did)),  left.did = right.did,
			 getall(left, right), left outer, local);
			 
return result; 
end; 