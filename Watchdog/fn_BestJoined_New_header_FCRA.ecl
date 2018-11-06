/*2017-02-28T09:58:00Z (Wendy Ma)
DF-18485
*/
import header,ut;

export fn_BestJoined_New_header_FCRA( dataset(recordof(header.layout_header))head, string build_type) := function 

//boolean var2 := true : stored('isnewheader');
string20 var1 := '' : stored('watchtype');

did_rec := record
	head.did;
	integer4 total_records := count(group);
end;

did_dups0 := table(head, did_rec, did, local);
did_dups_pst := did_dups0 : persist('persist::watchdog_did_dedup_2');
did_dups := did_dups_pst; 
bphone := watchdog.BestPhone(build_type);
bssn := watchdog.BestSSN;
baddress := watchdog.BestAddress(build_type);
btitle := Watchdog.BestTitle; 
bfname := watchdog.BestFirstName;
bmname := watchdog.BestMiddleName;
blname := watchdog.BestLastName;
bsuffix := watchdog.BestSuffix;
bADL_ind := Header.fn_ADLSegmentation(header.file_headers).core_check_pst;
bValidSSN := watchdog.validSSN(head);
lbest := Watchdog.Layout_Best_Marketing_Flag;

//getphone for FCRA nonEQ and nonEN
lbest getphone(did_dups l, bphone r) := transform
	self.phone := r.phone10;
	self.marketing_flag := r.marketing_flag;
	self := l;
end;

wphone_ := join(did_dups, bphone, left.did = right.did, 
			   getphone(left, right), left outer, local);

wphone  := map(var1 = 'fcra_best_append' => 
           project(did_dups, transform(lbest, self := left)),
					 wphone_);
//getssn
lbest getssn(lbest l, bssn r) := transform
	self.ssn := r.ssn;
	self := l;
end;

wssn := join(wphone, bssn, left.did = right.did, 
			 getssn(left, right), left outer, local);

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

waddress := join(wssn, baddress, left.did = right.did,
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

//get title 
lbest gettitle(lbest l, btitle r) := transform
	self.title := r.title;
	self := l;
end;

wtitle := join(wsuffix, btitle, left.did = right.did,
			   gettitle(left, right), left outer, local);

//get ADL indicator
lbest getADL_ind(lbest le, bADL_ind ri):= transform 
self.adl_ind := ri.ind;
self.run_date := (integer)RunDate_build;
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
			 
			 
bdob := DISTRIBUTE(watchdog.BestDob, did);

//getdob
lbest getdob(wvalidSSN l, bdob r) := transform
	self.did := IF(r.dob = 0 or ut.Age(r.dob) >= 21, l.did, SKIP);
	//self.dob := r.dob;	// suppress dob
	self := l;
end;

result_wdob_ := join(wvalidSSN, bdob, left.did = right.did,
			 getdob(left, right), left outer, local);					 

//exclude the minors from watchdog GLB
wdob := distribute(Watchdog.file_best, did);
 
lbest exclude_minors(result_wdob_ l, wdob r) := transform
	self.did := IF(r.dob = 0 or ut.Age(r.dob) >= 21, l.did, SKIP);
	//self.dob := r.dob;	// suppress dob
	self := l;
end;

result_wdob := join(result_wdob_, wdob, left.did = right.did,
			 exclude_minors(left, right), left outer, local);				
			 
return result_wdob ; 
end; 
