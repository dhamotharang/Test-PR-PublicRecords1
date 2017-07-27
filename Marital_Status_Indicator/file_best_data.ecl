import doxie, ut;

//Layouts
rDS := RECORD
  unsigned6 did;
  unsigned6 rid;
  string2 source;
  integer4 dt_first_seen;
  integer4 dt_last_seen;
  integer4 dt_vendor_last_reported;
  integer4 dt_vendor_first_reported;
  integer4 dt_nonglb_last_seen;
  string1 rec_type;
  qstring10 prim_range;
  string2 predir;
  qstring28 prim_name;
  string4 suffix;
  string2 postdir;
  qstring10 unit_desig;
  qstring8 sec_range;
  qstring25 city_name;
  string2 st;
  qstring5 zip;
  qstring4 zip4;
  string1 tnt;
  unsigned8 rawaid;
  string1 address_flag;
  unsigned3 addr_dt_last_seen;
  unsigned3 addr_dt_first_seen;
 END;
rWD := RECORD
  unsigned6 did;
  qstring10 phone;
  qstring9 ssn;
  integer4 dob;
  qstring5 title;
  qstring20 fname;
  qstring20 mname;
  qstring20 lname;
  qstring5 name_suffix;
  qstring10 prim_range;
  string2 predir;
  qstring28 prim_name;
  qstring4 suffix;
  string2 postdir;
  qstring10 unit_desig;
  qstring8 sec_range;
  qstring25 city_name;
  string2 st;
  qstring5 zip;
  qstring4 zip4;
  unsigned3 addr_dt_last_seen;
  qstring8 dod;
  qstring17 prpty_deed_id;
  qstring22 vehicle_vehnum;
  qstring22 bkrupt_crtcode_caseno;
  integer4 main_count;
  integer4 search_count;
  qstring15 dl_number;
  qstring12 bdid;
  integer4 run_date;
  integer4 total_records;
  unsigned8 rawaid;
  unsigned3 addr_dt_first_seen;
  string10 adl_ind;
  string1 valid_ssn;
 END;


rHeader := record
	recordof(doxie.key_header);
end;


rOutput := record
	rWD;
	qstring20	first_lname;
	qstring20 last_lname;
 END;
//

//Files
ds_address 	:= dataset(ut.foreign_prod+'thor400_20::persist::watchdog_bestaddress', rDS, thor);
ds_wd				:= dataset(ut.foreign_prod+'thor_data400::base::watchdog_best', rWD, thor);
ds_header 	:= doxie.key_header;

//distributed
dAddress 	:= distribute(ds_address, did);
dWD 			:= distribute(ds_wd, did);
dHeader 	:= distribute(ds_header, did);

//Filters
fVehicles := ['FV','IV','KV','AV','NV','SV','MV','LV','RV','PV','EV','XV','QV','OV','TV','UV','WV','YV','AE','BE','EE','CE','&E','$E','GE','JE','IE','KE','LE','NE','ME','RE','PE','VE','YE','XE','ZE','@E','HE','+E','?E','QE','!E','OE','=E','SE','TE','.E','UE','WE','#E'];
fProperty := ['FA','FP','LA','LP'];
fDrivers  := ['DD','FD','JD','ID','KD','PD','AD','CD','ND','MD','ED','BD','GD','OD','RD','SD','TD','UD','WD','VD','YD','1X','2X','3X','4X','5X','6X','7X','8X','9X','ZX','XX','BX'];
fOther 		:= ['ZT','VO'];
fCredit 	:= ['EQ','TU','TS','LT','EN','TN'];//filter out if required

srcKeep := fVehicles + fProperty + fDrivers + fOther;

//filter header to desired sources
dRange := sort(dHeader(src in srcKeep and ((dt_first_seen <> 0 AND dt_last_seen <> 0))),did,-dt_last_seen, local);

//Build Base
rOutput slimHeader(dWD l) := transform
	self := l;
	self := [];
end;
oBase := project(dWD, slimHeader(left), local);


//Append best address
rOutput addAddress(oBase l, dAddress r) := transform
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
  self.rawaid := r.rawaid;
  self.addr_dt_last_seen := r.addr_dt_last_seen;
  self.addr_dt_first_seen := r.addr_dt_first_seen;
	self := l;
	self := [];
end;

oAddress := join(oBase, dAddress,
							left.did = right.did,
							addAddress(left,right), left outer, keep(1), local);
					

//Get oldest last name
ds_fLast := dedup(sort(dRange, did, dt_first_seen, local), did, local);
rOutput addOldest(oAddress l, ds_fLast r) := transform
	self.first_lname := r.lname;
	self := l;
end;

oFirst := join(oAddress, ds_fLast,
							left.did = right.did,
							addOldest(left,right), left outer, keep(1), local);


//Get newest last name
ds_lLast := dedup(sort(dRange, did, -dt_first_seen,local), did, local);
rOutput addNewest(oFirst l, ds_lLast r) := transform
	self.last_lname := r.lname;
	self := l;
end;

oLast := join(oFirst, ds_lLast,
							left.did = right.did,
							addNewest(left,right), left outer, keep(1), local);


//Final form
rWD makeFinal(oLast l) := transform
	self.lname := map(l.first_lname = '' or l.last_lname = '' 		=> l.lname,
										l.title = 'MR' and l.lname = l.first_lname 	=> l.lname,
										l.title = 'MS' and (l.lname <> l.first_lname and l.first_lname <> l.last_lname)	=> l.last_lname,
										l.lname);
	self := l;
end;
final := project(oLast, makeFinal(left), local);



EXPORT file_best_data := final;