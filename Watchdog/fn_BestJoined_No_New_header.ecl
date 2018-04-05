import header; 
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

baddressweekly := watchdog.BestAddress();

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

//update ADL_IND
bADL_ind := if (isnewheader = false,Header.fn_ADLSegmentation(header.file_headers).core_check_pst);

lbest getADL_IND(wdeathweekly l, bADL_ind r) := transform
    self.adl_ind := r.ind;
 	self := l;
end;

wADL_INDweekly := join(wdeathweekly, distribute(bADL_ind, hash(did)), left.did = right.did,
			 getADL_IND(left, right), left outer, local);
			 
fbest := map(
           var1='nonglb'            => Watchdog.File_Best_nonglb
					,var1='nonglb_noneq'			=> Watchdog.File_Best_nonglb_nonEquifax
				  ,var1='marketing'         => Watchdog.File_Best_marketing
					,var1='marketing_noneq'   => Watchdog.File_Best_marketing_nonEquifax
				  ,var1='glb_nonen'         => Watchdog.File_Best_nonExperian
				  ,var1='glb_noneq'         => Watchdog.File_Best_nonEquifax	
				  ,var1='nonutility'        => watchdog.File_Best_nonutility
				  ,var1='nonglb_nonutility' => watchdog.File_Best_nonglb_nonutility
					,var1='glb_nonen_noneq' => Watchdog.File_Best_nonEquifax_nonExperian
				  ,                            Watchdog.File_Best
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
	self.valid_ssn := r.valid_ssn;
	self := l;
end;
				 
result := join( wADL_INDweekly, distribute(fbest,hash(did)),  left.did = right.did,
			 getall(left, right), left outer, local);

bdob := watchdog.BestDob;


//getdob
lbest getdob(result l, bdob r) := transform
	self.dob := r.dob;
	self := l;
end;

result_wdob := join(result, bdob, left.did = right.did,
			 getdob(left, right), left outer, local);

return result_wdob; 
end; 