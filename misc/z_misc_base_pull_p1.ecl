//
// get search set of dids
//
layout_dids := record
string12	did;
end;
layout_dids didi_to_dids(header.file_headers l) := transform
	self.did := intformat(l.did, 12, 1);
end;
header_sample := project(sample(header.file_headers,600000),didi_to_dids(left));
sample_set_of_didx := 	project(choosen(UtilFile.file_util_daily,1000),layout_dids) + 
						project(choosen(business_header.File_Employment_Out,1000),layout_dids) +
						header_sample;
sample_set_of_dids := dedup(sort(distribute(sample_set_of_didx,hash(did)),did,local),did,local);
//
layout_didi := record
unsigned integer6 did
end;
layout_didi dids_to_didi(sample_set_of_dids l) := transform
	self.did := (unsigned integer6) l.did;
end;
sample_set_of_didi := project(sample_set_of_dids,dids_to_didi(left));
//
// get set of bdids for dids
// 
layout_slim_business_contacts:= record
unsigned integer6 bdid;
unsigned integer6 did;
end;
layout_bdidi := record
unsigned integer6 bdid;
end;
layout_bdidi get_bdidi(layout_slim_business_contacts l, sample_set_of_didi r) := transform 
self.bdid := l.bdid;
end;
slim_Business_Contacts_dist := dedup(sort(distribute(project(business_header.file_business_contacts_plus,layout_slim_business_contacts),hash(did)),did,bdid,local),did,bdid,local);
bdidi_from_didx := join(slim_Business_Contacts_dist,sample_set_of_didi, left.did=right.did, get_bdidi(left,right),local);
bdidi_from_sample := sample(project(slim_business_contacts_dist,layout_bdidi),10000000);
all_bdidi := bdidi_from_didx + bdidi_from_sample;
bdidi_from_did1 := dedup(sort(distribute(all_bdidi ,hash(bdid)),bdid,local),bdid,local);
layout_bdids := record
string12	bdid;
end;
layout_bdids bdidi_to_bdids(bdidi_from_did1 l) := transform
	self.bdid := intformat(l.bdid,12,1);
end;
bdids_from_did1 := project(bdidi_from_did1, bdidi_to_bdids(left));
//
output(sample_set_of_dids,,'~thor_200::temp::rvh_sample_set_dids',overwrite,__compressed__);
//output(sample_set_of_didi);
output(bdids_from_did1,,'~thor_200::temp::rvh_sample_set_bdids',overwrite,__compressed__);
//output(bdidi_from_did1);


