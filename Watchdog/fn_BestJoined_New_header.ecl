/*2017-02-28T09:57:12Z (Wendy Ma)
DF-18485
*/
import header,ut;

export fn_BestJoined_New_header( dataset(recordof(header.layout_header))head,boolean isnewheader) := function 

//boolean var2 := true : stored('isnewheader');

did_rec := record
	head.did;
	integer4 total_records := count(group);
end;

did_dups0 := table(head, did_rec, did, local);
did_dups_pst := did_dups0 : persist('persist::watchdog_did_dedup_2');
did_dups := if (isnewheader=true,did_dups_pst); 
bphone := if (isnewheader=true,watchdog.BestPhone()) ;
bssn := if (isnewheader=true,watchdog.BestSSN);
bdob := if (isnewheader=true,watchdog.BestDob);
baddress := if (isnewheader=true,watchdog.BestAddress());
btitle := if (isnewheader=true,Watchdog.BestTitle); 
bfname := if (isnewheader=true,watchdog.BestFirstName);
bmname := if (isnewheader=true,watchdog.BestMiddleName);
blname := if (isnewheader=true,watchdog.BestLastName);
bsuffix := if (isnewheader=true,watchdog.BestSuffix);
bdeath := if (isnewheader=true,watchdog.Death);
bproperty := if (isnewheader=true,watchdog.BestProperty);
bvehicle := if (isnewheader=true,watchdog.BestVehicle);
bankrupt1 := if (isnewheader=true,watchdog.Bankruptcy);
dl := if (isnewheader=true,watchdog.BestDL);
bpaw := if (isnewheader=true,watchdog.BestPeopleAtWork);
bADL_ind := if (isnewheader=true,Header.fn_ADLSegmentation(header.file_headers).core_check_pst);
bValidSSN := if (isnewheader=true, watchdog.validSSN(head));
lbest := Watchdog.Layout_Best_Marketing_Flag;
//getphone
lbest getphone(did_dups l, bphone r) := transform
	self.phone := r.phone10;
	self.marketing_flag := r.marketing_flag;
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
	self.addr_dt_first_seen := r.addr_dt_first_seen;
  self.RawAID := r.RawAID;
	self := l;
end;

waddress := join(wdob, baddress, left.did = right.did,
			     getaddress(left, right), left outer, local);

//getlname
lbest getlname(lbest l, blname r) := transform
	self.lname := r.lname;
	self := l;
end;

wlname := join(waddress, blname, left.did = right.did,
			   getlname(left, right), left outer, local);

//get fname
lbest getfname(lbest l, bfname r) := transform
	self.fname := if(l.lname <> r.fname, r.fname, '');
	self := l;
end;

wfname := join(wlname, bfname, left.did = right.did,
			   getfname(left, right), left outer, local);
//getmname
lbest getmname(lbest l, bmname r) := transform
	self.mname := if(l.lname <> r.mname and l.fname <> r.mname, r.mname, '');
	self := l;
end;

wmname := join(wfname, bmname, left.did = right.did,
			 getmname(left, right), left outer, local);

//get suffix
lbest getsuffix(lbest l, bsuffix r) := transform
	self.name_suffix := r.name_suffix;
	self := l;
end;

wsuffix := join(wmname, bsuffix, left.did = right.did,
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
	self.run_date := (integer)watchdog.RunDate_build;
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

//get title 
lbest gettitle(lbest l, btitle r) := transform
	self.title := r.title;
	self := l;
end;

wtitle := join(wpaw, btitle, left.did = right.did,
			   gettitle(left, right), left outer, local);

//get ADL indicator
lbest getADL_ind(lbest le, bADL_ind ri):= transform 
self.adl_ind := ri.ind;
self := le;
end;

wADL_ind := join(wtitle,bADL_ind,left.did = right.did,
					getADL_ind(left,right),left outer,local);

//get validSSN flag
lbest getvalidssn(lbest l, bValidSSN r) := transform
	self.valid_ssn := r.valid_ssn;
	self := l;
end;

wvalidSSN := join(wADL_ind, bValidSSN, left.did = right.did and left.ssn = right.ssn,
			 getvalidssn(left, right), left outer, local);
return wvalidSSN ; 
end; 
