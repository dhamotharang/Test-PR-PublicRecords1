//-- Convert 8 digit integer date into 8 character string
//	 If date = 0, return empty string
//	 If date has only 6 digits (missing DD), multiply by 100 (add 00)
string8 convert_date8(integer4 date) := 
	map(date = 0 => '',
	    date > 100000 and date < 1000000 => (string8)(date * 100),
		(string8)date);

boolean fieldChange(string watch_field) := 
	watch_field!='' and watch_field[1..2]!='*N';

string20 var1 := '' : stored('watchtype');

best_file := dataset('persist::watchdog_joined',layout_best,flat);

delta_file := map(var1='nonglb'=>watchdog.File_Delta_nonglb,
			  var1='nonutility'=>watchdog.File_Delta_nonutility,
			  var1='nonglb_nonutility'=>watchdog.File_Delta_nonglb_nonutility,
			  watchdog.File_Delta);

dis_out := distribute(best_file,hash(did));
dis_delta := distribute(delta_file,hash(did));

layout_moxie setFlag(dis_out l, dis_delta r) := transform
	self.did := intformat(l.did,12,1);	//converted from int
	self.phone := l.phone;
	self.ssn := if(l.ssn= '', '', intformat((integer)l.ssn,9,1));
//-- This one needs to be converted
	self.dob := convert_date8(l.dob);
	self.fname := l.fname;
	self.mname := l.mname;
	self.lname := l.lname;
	self.name_suffix := l.name_suffix;
	self.prim_range := l.prim_range;
	self.predir := l.predir;
	self.prim_name := l.prim_name;
	self.suffix := l.suffix;
	self.postdir := l.postdir;
	self.unit_desig := l.unit_desig;
	self.sec_range := l.sec_range;
	self.city_name := l.city_name[1..13];
	self.st := l.st;
	self.zip := if(l.zip = '', '', intformat((integer)l.zip,5,1));
	self.zip4 := if(l.zip4 = '', '', intformat((integer)l.zip4,4,1));
	self.dod := l.dod;  
    self.Prpty_deed_id := l.Prpty_deed_id;
	self.Vehicle_vehnum := if(l.Vehicle_vehnum!='',trim(l.Vehicle_vehnum,all) + '00000000000000000000','');
	self.Bkrupt_CrtCode_CaseNo := l.bkrupt_crtcode_caseno[1..12];
	self.bdid := intformat((integer)l.bdid,12,1);
	self.run_date := convert_date8(l.run_date);
	self.name_change := if(fieldChange(r.fname) or fieldChange(r.mname) or fieldChange(r.lname),'Y','N');
    self.name_date := EarliestDate;
	self.address_change := if(fieldChange(r.prim_range) or fieldChange(r.predir) or 
								fieldChange(r.prim_name) or fieldChange(r.suffix) or 
								fieldChange(r.postdir) or fieldChange(r.unit_desig) or 
								fieldChange(r.sec_range) or fieldChange(r.city_name) or
								fieldChange(r.st) or fieldChange(r.zip) or fieldChange(r.zip4),'Y','N');
	self.address_date := EarliestDate;
	self.dob_change := if(r.dob>0,'Y','N');
	self.dob_date := EarliestDate;
    self.ssn_change := if(fieldChange(r.ssn),'Y','N');
	self.ssn_date := EarliestDate;
    self.phone_change := if(fieldChange(r.phone),'Y','N');
	self.phone_date := EarliestDate;
	self.death_change := if(fieldChange(r.dod),'Y','N');
    self.death_date := EarliestDate;
    self.vehicle_change := if(fieldChange(r.vehicle_vehnum),'Y','N');
    self.vehicle_date := EarliestDate;
	self.property_change := if(fieldChange(r.prpty_deed_id),'Y','N');
	self.property_date := EarliestDate;
    self.bankruptcy_change := if(fieldChange(r.bkrupt_crtcode_caseno) or 
                                 r.main_count > 0 or r.search_count > 0,'Y','N');
	self.bankruptcy_date := EarliestDate;
//    self.bdid_change := if(fieldChange(r.bdid),'Y','N');
	self.bdid_date := EarliestDate;	
end;

//Set change flags from delta file
flags := join(dis_out,dis_delta(run_date=max(dis_delta,run_date)),left.did=right.did and left.run_date=right.run_date,setFlag(left,right),left outer,local);

//Get all delta history
delta_history := map(var1='nonglb'=>watchdog.File_Delta_nonglb,
			  var1='nonutility'=>watchdog.File_Delta_nonutility,
			  var1='nonglb_nonutility'=>watchdog.File_Delta_nonglb_nonutility,
			  watchdog.File_Delta);


//Find the lastest change date
setDates := record
    string12 did := intformat(delta_history.did,12,1);
 	string8	name_date := max(group,if(~fieldChange(delta_history.fname) and ~fieldChange(delta_history.mname) and 
										~fieldChange(delta_history.lname),EarliestDate,convert_date8(delta_history.run_date)));
	string8	address_date := max(group,if(~fieldChange(delta_history.prim_range) and ~fieldChange(delta_history.predir) and 
										  ~fieldChange(delta_history.prim_name) and ~fieldChange(delta_history.suffix) and 
										  ~fieldChange(delta_history.postdir) and ~fieldChange(delta_history.unit_desig) and 
										  ~fieldChange(delta_history.sec_range) and ~fieldChange(delta_history.city_name) and 
										  ~fieldChange(delta_history.st) and ~fieldChange(delta_history.zip) and ~fieldChange(delta_history.zip4),
										  EarliestDate,convert_date8(delta_history.run_date)));
	string8	dob_date := max(group,if(delta_history.dob<=0,EarliestDate,convert_date8(delta_history.run_date)));
	string8	ssn_date := max(group,if(~fieldChange(delta_history.ssn),EarliestDate,convert_date8(delta_history.run_date)));
	string8	phone_date := max(group,if(~fieldChange(delta_history.phone),EarliestDate,convert_date8(delta_history.run_date)));
    string8	death_date := max(group,if(~fieldChange(delta_history.dod),EarliestDate,convert_date8(delta_history.run_date)));
	string8	vehicle_date := max(group,if(~fieldChange(delta_history.vehicle_vehnum),EarliestDate,convert_date8(delta_history.run_date)));
	string8	property_date := max(group,if(~fieldChange(delta_history.prpty_deed_id),EarliestDate,convert_date8(delta_history.run_date)));
	string8	bankruptcy_date := max(group,if(~fieldChange(delta_history.bkrupt_crtcode_caseno),EarliestDate,convert_date8(delta_history.run_date)));
	string8	bdid_date := max(group,if(~fieldChange(delta_history.bdid),EarliestDate,convert_date8(delta_history.run_date)));  
end;

Dates := table(distribute(delta_history,hash(did)),setDates,did,local);

layout_moxie ls_join(layout_moxie L, setDates R) := transform
 self.name_date := if (r.name_date = '',L.name_date,r.name_date);
 self.address_date := if (r.address_date = '',L.address_date,r.address_date);
 self.dob_date := if (r.dob_date = '',L.dob_date,r.dob_date);
 self.ssn_date := if (r.ssn_date = '',L.ssn_date,r.ssn_date);
 self.phone_date := if (r.phone_date = '',L.phone_date,r.phone_date);
 self.death_date := if (r.death_date = '',L.death_date,r.death_date);
 self.vehicle_date := if (r.vehicle_date = '',L.vehicle_date,r.vehicle_date);
 self.property_date := if (r.property_date = '',L.property_date,r.property_date);
 self.bankruptcy_date := if (r.bankruptcy_date = '',L.bankruptcy_date,r.bankruptcy_date);
 self.bdid_date := if(r.bdid_date = '', L.bdid_date, r.bdid_date);
 self := l;
end;

with_dates := join(flags,dates,left.did=right.did,ls_join(left,right),left outer,local);
export Moxie_despray := with_dates;