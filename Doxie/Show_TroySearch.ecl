/*
Display a result of a TroyGraves Search:
infile : is the result stream previously computed
zips : only show records within the given zips, put in empty set for all zips
allow : is the maximum number of INDIVIDUALS displayed

There are two outputs: a count of the individuals found
                       every header record for the found individuals

*/
export Show_TroySearch(infile,zips,allow='500',suppressDMVInfo=false,bDemoMode=FALSE,pGender='M') := macro

import doxie, suppress;

dj := choosen(sort(dedup(sort(infile,did,-score,local),did,local),-score),(unsigned4)allow);

hres_final := record
  unsigned4 score;
  unsigned1 crim_records;
  unsigned6    did;
  unsigned4    first_seen;
  unsigned4    last_seen;
  string10    phone;
  string9     ssn;
  integer4     dob;
  string120  name;
  string120  addr1;
  string120  addr2;
  unsigned8 rawaid;
  end;

hres := record
	hres_final.score;
	hres_final.crim_records;
	recordof(doxie.key_header);
end;

sp(string s) := if ( trim(s)<>'',trim(s)+' ','' );

hres take_right(dj ll, doxie.Key_Header le) := transform
  self.crim_records := ll.crim_records;
  self.score := ll.score;
  self.did := ll.did;
  self := le;
 end;

with_alldid_raw := JOIN(dj,doxie.Key_Header,left.did=right.s_did and
	~Doxie.DataRestriction.isHeaderSourceRestricted(right.src),
	take_right(left,right));

mod_access := doxie.compliance.GetGlobalDataAccessModule();
with_all_did_suppressed := Suppress.MAC_SuppressSource(with_alldid_raw, mod_access);  

with_alldid_filt := Header.FilterDMVInfo(with_all_did_suppressed);
with_alldid0 := if(suppressDMVInfo, with_alldid_filt, with_all_did_suppressed);

unsigned3 get_header_first_seen(with_alldid0 L) := MAP ( l.dt_first_seen > 0 and ( l.dt_first_seen < l.dt_vendor_first_reported or l.dt_vendor_first_reported=0 )=> l.dt_first_seen,
           l.dt_vendor_first_reported > 0 => l.dt_vendor_first_reported,
           l.dt_vendor_last_reported > 0 and l.dt_vendor_last_reported < l.dt_last_seen => l.dt_vendor_last_reported,
           l.dt_last_seen );

unsigned3 get_header_last_seen(with_alldid0 L) :=  MAP ( l.dt_last_seen > 0 and l.dt_last_seen > l.dt_vendor_last_reported => l.dt_last_seen,
           l.dt_vendor_last_reported > 0 => l.dt_vendor_last_reported,
           l.dt_vendor_first_reported > l.dt_first_seen => l.dt_vendor_first_reported,
           l.dt_first_seen);
					 
hres_final take_header(with_alldid0 le) := transform
  sFname:=IF(bDemoMode,doxie.fn_name_replace(le.did,'FIRST',le.fname,pGender),le.fname);
  sLname:=IF(bDemoMode,doxie.fn_name_replace(le.did,'LAST',le.lname),le.lname);
  
	self.first_seen := get_header_first_seen(le);
  self.last_seen := get_header_last_seen(le);
	self.name := sp(le.title)+sp(sFname)+sp(le.mname)+sp(sLname)+sp(le.name_suffix);
  self.addr1 := sp(le.prim_range)+sp(le.predir)+sp(le.prim_name)+sp(le.suffix)+sp(le.postdir)+sp(le.unit_desig)+sp(le.sec_range);
  self.addr2 := sp(le.city_name)+sp(le.st)+sp(le.zip);
  self := le;
end;
with_alldid := project(with_alldid0, take_header(left));

sw := sort(with_alldid,-score,did,-last_seen,-first_seen);

sws := dedup(sw,score,did);

output(count(dj),named('Individuals'));
output(choosen(sws,10000),named('IndividualList'));
output(choosen(sw,100000),named('HistoricAddresses'))

  endmacro;
