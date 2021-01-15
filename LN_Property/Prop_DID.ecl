import did_add, header, business_header, business_header_ss;
pj_in := ln_property.Prop_Joined;

//  Remove Fail condition because the old property is letting bad dates through also
//  JB 6.24.05
//bad := count(pj_in(dt_first_seen > dt_last_seen or dt_first_seen = 0 and dt_last_seen > 0));
//if(bad > 0, fail('You have some bad dates coming out of Prop_Joined'));

matchset := ['A', 'P', 'Z'];

did_add.MAC_Match_Flex
	(pj_in, matchset,
	 ssn_field, dob_field, fname, mname, lname, suffix,
	 prim_range, prim_name, sec_range, zip, st, phone,
	 DID, header.Layout_New_Records, false, DID_Score_field,
	 75, pj_out)

with_did := distribute(pj_out,hash((string12)(vendor_id[1..12])));
no_did := distribute(File_Search,hash((STRING12)(ln_fares_id)));

Layout_did_out propDIDs(no_did L, with_did R) := transform
 self.did := r.did;
 self.bdid := 0;
 self := l;
end;

added_dids := join(no_did,with_did,left.ln_fares_id=right.vendor_id[1..12] and left.fname=right.fname
						and left.lname=right.lname,propDIDs(left,right),left outer ,local);

for_bdid1 := added_dids(cname != '');

business_header.MAC_Source_Match(for_bdid1,wbdid1,
						false,bdid,
						false,'PR',
						false,foo,
						cname,
						prim_Range,Prim_name,sec_range,zip,
						false,foo,
						false,foo);

for_bdid2 := wbdid1(bdid = 0);
myset := ['A'];

business_header_ss.MAC_Match_Flex(for_bdid2,myset,
						cname,
						prim_range,prim_name,zip,sec_range,st,
						foo,foo,
						bdid,
						Layout_did_out,
						false,score,
						wbdid2);

outfinal := wbdid2 + wbdid1(bdid!=0) + added_dids(cname = '');

export Prop_DID := outfinal : persist('~thor_data400::persist::ln_property_did');
