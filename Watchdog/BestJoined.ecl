import header;

head := file_header_filtered;

did_rec := record
	head.did;
	integer4 total_records := count(group);
end;

did_dups := table(head, did_rec, did, local) : persist('persist::watchdog_did_dedup_2');

bphone := watchdog.BestPhone;
bssn := watchdog.BestSSN;
bdob := watchdog.BestDob;
baddress := watchdog.BestAddress;
bfname := watchdog.BestFirstName;
bmname := watchdog.BestMiddleName;
blname := watchdog.BestLastName;
bsuffix := watchdog.BestSuffix;
bdeath := watchdog.Death;
bproperty := watchdog.BestProperty;
bvehicle := watchdog.BestVehicle;
bankrupt1 := watchdog.Bankruptcy;
dl := watchdog.BestDL;
bpaw := watchdog.BestPeopleAtWork;

lbest := watchdog.Layout_Best;
//getphone
lbest getphone(did_dups l, bphone r) := transform
	self.phone := r.phone10;
	self := l;
end;

wphone := join(did_dups, bphone, left.did = right.did, 
			   getphone(left, right), left outer, local);

//getssn
lbest getssn(lbest l, bssn r) := transform
	self.ssn := r.ssn;
	self := l;
end;

wssn := join(wphone, bssn, left.did = right.did, 
			 getssn(left, right), left outer, local);


//getdob
lbest getdob(lbest l, bdob r) := transform
	self.dob := r.dob;
	self := l;
end;

wdob := join(wssn, bdob, left.did = right.did,
			 getdob(left, right), left outer, local);


//getaddress
lbest getaddress(lbest l, baddress r) := transform
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
	self := l;
end;

waddress := join(wdob, baddress, left.did = right.did,
			     getaddress(left, right), left outer, local);

//getfname
lbest getfname(lbest l, bfname r) := transform
	self.fname := r.fname;
	self := l;
end;

wfname := join(waddress, bfname, left.did = right.did,
			   getfname(left, right), left outer, local);

//get mname
lbest getmname(lbest l, bmname r) := transform
	self.mname := r.mname;
	self := l;
end;

wmname := join(wfname, bmname, left.did = right.did,
			   getmname(left, right), left outer, local);
//getlname
lbest getlname(lbest l, blname r) := transform
	self.lname := r.lname;
	self := l;
end;

wlname := join(wmname, blname, left.did = right.did,
			 getlname(left, right), left outer, local);

//get suffix
lbest getsuffix(lbest l, bsuffix r) := transform
	self.name_suffix := r.name_suffix;
	self := l;
end;

wsuffix := join(wlname, bsuffix, left.did = right.did,
			 getsuffix(left, right), left outer, local);


//getdeath
lbest getdeath(lbest l, bdeath r) := transform
	self.dod := r.dod;
	self := l;
end;

wdeath := join(wsuffix, bdeath, left.did = right.did,
			 getdeath(left, right), left outer, local);

//get Property
lbest getProp(lbest l, bproperty r) := transform
	self.Prpty_deed_id := r.vendor_id;
	self := l;
end;

wproperty := join(wdeath, bproperty, left.did=right.did,
				getProp(left,right),left outer, local);

//get Vehicle
lbest getVehicle(lbest l, bvehicle r) := transform
	self.Vehicle_vehnum := r.vehnum;
	self := l;
end;

wvehicle := join(wproperty, bvehicle, left.did=right.did,
				getVehicle(left,right),left outer, local);

//get Bankruptcy
lbest getBankrupt(lbest l, bankrupt1 r) := transform
	self.Bkrupt_CrtCode_CaseNo := r.CourtCaseSeq;
	self.main_count := r.main_cnt;
	self.search_count := r.search_cnt;
	self := l;
end;

wbankruptcy := join(wvehicle, bankrupt1, left.did=right.did,
					getBankrupt(left,right),left outer, local);

//get DL
lbest getDL(lbest l, dl r) := transform
	self.dl_number := r.dl_number;
	self.run_date := (integer)RunDate_build;
	self := l;
end;

wdl := join(wbankruptcy, dl, left.did=right.did,
					getdl(left,right),left outer, local);

//get people at work
lbest getPAW(lbest l, bpaw r) := transform
	self.bdid := if(r.bdid=0,'',(qstring12)r.bdid);
	self := l;
end;

wpaw := join(wdl, bpaw, left.did=right.did,
				    getPAW(left,right),left outer, local);


export BestJoined := wpaw : persist('persist::watchdog_joined');