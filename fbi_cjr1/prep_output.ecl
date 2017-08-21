//
import ut,doxie;
//
Cands := fbi_cjr1.get_candidates;
//
// import doxie_files,doxie_build,lib_stringlib;
// import did_add,  didville;
// import address;
import header;
import watchdog;
// import Marketing_Best;
// import driversv2;
// import corrections;
// import sexoffender;
// file_headers := header.File_Headers;
// file_watchdog_best := watchdog.file_best;
// file_did_death_masterv2 := header.File_Did_Death_MasterV2;
// no did! file_death_master_supplemental := header.file_death_master_supplemental;
// file_dl_searchv2 := dataset('~thor_data400::base::DL2::DLSearch_PUBLIC', DriversV2.Layout_Drivers, flat);
// file_offenders_keybuilding := dataset('~thor_Data400::base::Corrections_Offenders_' + 'public' + '_BUILT',corrections.layout_Offender,flat);
// file_so_main		:= sexoffender.file_Main;
// output(file_headers);
// output(file_watchdog_best);
// output(file_did_death_masterv2);
// output(file_dl_searchv2);
// output(file_offenders_keybuilding);
// output(file_so_main);
//

	   
C_Rec := record
 Cands;
 unsigned1 crim_Records;
 unsigned1 sor_Records;
end;
  
C_Rec take_lu(cands le, doxie.Key_Did_Lookups ri) := transform
 self.crim_records := ri.crim_cnt;
 self.sor_records := ri.sex_cnt;
 self := le;
end;  
		   
Res := join(Cands,doxie.key_did_lookups,left.did=right.did,take_lu(left,right),left outer);		   

infile :=res;
zips := '';
allow := '9999999999';

dj := dedup(sort(distribute(infile,hash(did)),did,-score,local),did,local);

hres := record
  // unsigned4 score;
  unsigned1 crim_records;
  unsigned1 sor_records;
  unsigned6	did;
  unsigned4	first_seen;
  unsigned4	last_seen;
  string10	phone;
  string9	ssn;
  integer4	dob;
  string120	name;
  string120	addr1;
  string120	addr2;
  unsigned4	best_first_seen:=0;
  unsigned4	best_last_seen:=0;
  string10	best_phone:='';
  string9	best_ssn:='';
  integer4	best_dob:=0;
  string20	best_fname:='';
  string120	best_name:='';
  string120	best_addr1:='';
  string120	best_addr2:='';
  string8	best_dod:='';
  string2   best_dl_state:='';
  string25  best_dl_number:='';
  string5   best_height:='';
  string5	best_weight:='';
  string25	best_race:='';
  string10	best_gender:='';
  string25	best_eye_color:='';
  string25	best_hair_color:='';
  end;

sp(string s) := if ( trim(s)<>'',trim(s)+' ','' );

unsigned3 get_header_first_seen(doxie.key_header L) := MAP ( l.dt_first_seen > 0 and ( l.dt_first_seen < l.dt_vendor_first_reported or l.dt_vendor_first_reported=0 )=> l.dt_first_seen,
           l.dt_vendor_first_reported > 0 => l.dt_vendor_first_reported,
           l.dt_vendor_last_reported > 0 and l.dt_vendor_last_reported < l.dt_last_seen => l.dt_vendor_last_reported,
           l.dt_last_seen );

unsigned3 get_header_last_seen(doxie.key_header L) :=  MAP ( l.dt_last_seen > 0 and l.dt_last_seen > l.dt_vendor_last_reported => l.dt_last_seen,
           l.dt_vendor_last_reported > 0 => l.dt_vendor_last_reported,
           l.dt_vendor_first_reported > l.dt_first_seen => l.dt_vendor_first_reported,
           l.dt_first_seen);

pulled_key_header := distribute(pull(doxie.key_header),hash(s_did));

hres take_header(dj l, pulled_key_header r) := transform
  // self.crim_records := l.crim_records;
  // self.sor_records := l.sor_records;
  // self.score := ll.score;
  self.did := l.did;
  self.first_seen := get_header_first_seen(r);
  self.last_seen := get_header_last_seen(r);
  self.name := sp(r.title)+sp(r.fname)+sp(r.mname)+sp(r.lname)+sp(r.name_suffix);
  self.addr1 := sp(r.prim_range)+sp(r.predir)+sp(r.prim_name)+sp(r.suffix)+sp(r.postdir)+sp(r.unit_desig)+sp(r.sec_range);
  self.addr2 := sp(r.city_name)+sp(r.st)+sp(r.zip);
  self := l;
  self := r;
  end;
with_header := JOIN(dj,pulled_key_header,left.did=right.s_did,take_header(left,right),local, left outer);


hres take_best(with_header l, watchdog.file_best r) := transform
  self.did := l.did;
  self.best_last_seen := r.addr_dt_last_seen;
  self.best_name := sp(r.title)+sp(r.fname)+sp(r.mname)+sp(r.lname)+sp(r.name_suffix);
  self.best_fname := r.fname;
  self.best_addr1 := sp(r.prim_range)+sp(r.predir)+sp(r.prim_name)+sp(r.suffix)+sp(r.postdir)+sp(r.unit_desig)+sp(r.sec_range);
  self.best_addr2 := sp(r.city_name)+sp(r.st)+sp(r.zip);
  self.best_ssn := r.ssn;
  self.best_phone := r.phone;
  self.best_dob := r.dob;
  self.best_dod := r.dod;
  self := l;
  end;
with_best := JOIN(with_header, watchdog.file_best,left.did=right.did,take_best(left,right),local,left outer);

hres take_dl(with_best l, fbi_cjr1.get_best_dl r) := transform
  self.did := l.did;
  self.best_dl_state := r.dl_state;
  self.best_dl_number := r.dl_number;
  self := l;
  end;
with_dl := JOIN(with_best, distribute(fbi_cjr1.get_best_dl,hash(did)),left.did=right.did,take_dl(left,right),local, left outer);

hres take_descriptors(with_dl l, fbi_cjr1.get_best_descriptors r) := transform
  self.did := l.did;
  self.best_height:=r.height;
  self.best_weight:=r.weight;
  self.best_race:=r.race_desc;
  self.best_gender:=r.gender_desc;
  self.best_eye_color:=r.eye_color_desc;
  self.best_hair_color:=r.hair_color_desc; 
  self := l;
  end;
with_descriptors := JOIN(with_dl, distribute(fbi_cjr1.get_best_descriptors,hash(did)),left.did=right.did,take_descriptors(left,right),local, left outer);

export prep_output := with_descriptors : persist('thor::persist::fbi_cjr1:prep_output');

// sw := sort(with_alldid,did,-first_seen);
// sws := dedup(sw,score,did);
// output(count(dj),named('Individuals'));
// output(choosen(sws,10000),named('IndividualList'));
// output(choosen(sw,100000),named('HistoricAddresses'))

