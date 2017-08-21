#workunit('name','UCC_reBDID');

import uccd, business_header_ss,business_header,ut,did_add, lib_Stringlib;

//pre-processparty
ds_ucc_party :=uccd.File_WithExpParty;
//count(ds_ucc_party);


Layout_WithExpPartyExpanded_Int :=  record
    string1   	record_type; 		 // current/historical
	boolean   	isDirect;
	
	string2   	ucc_vendor;
	string8   	ucc_process_date;
				
	string50  	ucc_key;
	string20  	event_key;
	string20  	party_key;
	string20  	collateral_key;
				
	string8   	party_status_cd;
	string60  	party_status_desc;
	string8   	party_address1_type_cd;
	string60  	party_address1_type_desc;
				
	unsigned6  	bdid;
	unsigned6   did;
	string2   	file_state;
	//string1 	rec_code; 		 // not mapped
	string8   	contrib_num;
	//string4 	value_2900; 		 // not mapped
	string32  	orig_filing_num;
	//string1 	experian_rec_type; 	 // not mapped
	string1   	party_type;
	string350 	orig_name;
	string200 	street_address;
	string60  	city;
	string50  	orig_state;
	string15  	zip_code;
	string8   	insert_date;
	//string1  	filed_code; 		 // not mapped
	//string15 	filed_place; 		 // not mapped
	string10  	ssn;
	string182 	clean_address;
	string70  	p_name;
	string200 	name;

    string10    prim_range;
	string28    prim_name;
	string8     sec_range;
	string2     st;
	string5     zip;
    qstring34   vendor_id;
end;

Layout_WithExpPartyExpanded_Int string_to_int(ds_ucc_party le) := TRANSFORM

            self.bdid := (unsigned6) le.bdid;
            self.did := (unsigned6) le.did;
            self.prim_range := le.clean_address[1..10];
			self.prim_name  := le.clean_address[13..40];
			self.sec_range  := le.clean_address[57..64];
			self.zip        := le.clean_address[117..121];
			self.st         := le.clean_address[115..116];
			
			self.vendor_id  := le.file_state + Le.ucc_key[4..35];
			self := le;
END;

 
File_withExpParty_Int := project(ds_ucc_party, string_to_int(left));

party_update_event := File_withExpParty_Int;

//count(party_update_event(bdid <> 0));

count(party_update_event);

prec := Layout_WithExpPartyExpanded_Int;


Business_Header.MAC_Source_Match(party_update_event, party_Source_Match,
                        FALSE, bdid,
                        FALSE, 'U',
                        FALSE, corp_key,
                        name,
                        prim_range, prim_name,sec_range, zip,
                        FALSE, phone10,
                        TRUE, SSN,
//                     TRUE, corp_key
                       TRUE, vendor_id);

// Then do a standard BDID match for the records which did not BDID,

// since the Corporate file may be newer than the Business Headers


BDID_Matchset := ['A','F'];



party_bdid_match := party_Source_Match(bdid <> 0);

party_bdid_nomatch := party_Source_Match(bdid = 0);


count(party_bdid_match);

count(party_bdid_nomatch);
 

Business_Header_SS.MAC_match_Flex(party_bdid_nomatch,
                                  BDID_Matchset,
                                  name,
                                  prim_range, prim_name, zip,
                                  sec_range, st,
                                  phone10, ssn,
                                  bdid, prec,
                                  FALSE, BDID_score_field,
                                  party_bdid_rematch)
 

my_party_bdid_all := party_bdid_match + party_bdid_rematch;

uccd.layout_Moxie_WithExpParty  fix_ucc_party(my_party_bdid_all l) := transform
    self.isdirect  := if(l.isdirect = true, 'Y', 'N');
            self.bdid               := IF((unsigned)l.bdid<>0,intformat(L.bdid,12,1),'');
            self.did    := IF((unsigned6)l.did<>0,intformat(L.did,12,1),'');
            self :=l;
end;
ds_ucc_party_fixed_for_bdid := project(my_party_bdid_all, fix_ucc_party(left));
count(ds_ucc_party_fixed_for_bdid);

/* change event key for MN */


my_events := dataset('~thor_data400::base::ucc_event_wexp_deduped_20051014', {uccd.layout_moxie_WithExpEvent,unsigned8 __filepos { virtual(fileposition)}}, flat);

my_events_to_join_MN := distribute(my_events(trim(filing_type_desc, left, right) = 'Initial Filing' and file_state = 'MN'),hash(ucc_key));

ds_ucc_party_fixed_3_to_fix_MN := distribute(ds_ucc_party_fixed_for_bdid(file_state='MN'),hash(ucc_key));

uccd.layout_Moxie_WithExpParty  fix_event_key_in_party_MN(ds_ucc_party_fixed_3_to_fix_MN l,my_events_to_join_MN r) 
	:= transform 
	self.event_key:= r.event_key;
	self := l;
	end;
ds_ucc_party_fixed_3_MN := join(ds_ucc_party_fixed_3_to_fix_MN,my_events_to_join_MN, left.ucc_key=right.ucc_key, fix_event_key_in_party_MN(left,right),local);


/* change event key for VT */

ds_ucc_party_fixed_3_to_fix_VT := ds_ucc_party_fixed_for_bdid(file_state='VT');

uccd.layout_Moxie_WithExpParty  fix_event_key_in_party_VT(ds_ucc_party_fixed_3_to_fix_VT l) 
	:= transform 
	self.event_key:= lib_stringlib.StringLib.stringfilterout(L.event_key, ' ');
	self := l;
	end;
ds_ucc_party_fixed_3_VT := project(ds_ucc_party_fixed_3_to_fix_VT, fix_event_key_in_party_VT(left));

/* change event key for NC*/

ds_ucc_party_fixed_3_to_fix_NC := distribute(ds_ucc_party_fixed_for_bdid(file_state='NC'),hash(event_key));

ds_ucc_party_fixed_the_rest := ds_ucc_party_fixed_for_bdid(file_state<>'MN' and file_state<>'VT' and file_state<>'NC');


my_events_to_join := sort(distribute(my_events(file_state='NC'),hash(event_key)),event_key,filing_date,local);



uccd.layout_Moxie_WithExpParty  fix_event_key_in_party_NC(ds_ucc_party_fixed_3_to_fix_NC l,my_events_to_join r) 
	:= transform 
	self.ucc_key:=r.ucc_key;
	self := l;
	end;
ds_ucc_party_fixed_3_NC := join(ds_ucc_party_fixed_3_to_fix_NC,my_events_to_join, left.event_key=right.event_key, fix_event_key_in_party_NC(left,right),local);


ds_ucc_party_fixed:= ds_ucc_party_fixed_3_MN + ds_ucc_party_fixed_3_VT + ds_ucc_party_fixed_3_NC + ds_ucc_party_fixed_the_rest;

count(ds_ucc_party_fixed);
/* */ 

ds_ucc_party_deduped := dedup(sort(distribute(ds_ucc_party_fixed,hash(ucc_key)),isDirect,ucc_vendor,ucc_key,event_key,party_key,collateral_key,party_status_cd,
        party_status_desc,party_address1_type_cd,party_address1_type_desc,bdid,did,file_state,contrib_num,orig_filing_num,
        party_type,orig_name,street_address,city,orig_state,zip_code,ssn,-p_name,name,-ucc_process_date,local),record, except record_type,ucc_process_date,insert_date,clean_address,local);
count(ds_ucc_party_deduped);


uccd.layout_Moxie_WithExpParty tskip(uccd.layout_Moxie_WithExpParty L, uccd.layout_Moxie_WithExpParty R) := transform
self.p_name := if(L.isdirect = R.isdirect and L.ucc_vendor = R.ucc_vendor and L.ucc_key = R.ucc_key 
and L.event_key = R.event_key and L.party_key = R.party_key and L.collateral_key = R.collateral_key and L.party_status_cd = R.party_status_cd and L.party_status_desc = R.party_status_desc
and L.party_address1_type_cd = R.party_address1_type_cd and L.party_address1_type_desc = R.party_address1_type_desc and L.bdid = R.bdid and L.did = R.did and L.file_state = R.file_state and
L.contrib_num = R.contrib_num and L.orig_filing_num = R.orig_filing_num and L.party_type = R.party_type and L.orig_name = R.orig_name and L.street_address = R.street_address and L.city = R.city 
and L.orig_state = R.orig_state and L.zip_code = R.zip_code and L.ssn = R.ssn and L.name = R.name and L.ucc_process_date = R.ucc_process_date and L.record_type = R.record_type and L.insert_date = R.insert_date
and L.clean_address = R.clean_address and L.p_name <> '' and R.p_name = '', skip, R.p_name);
self       := R;
end;
ds_ucc_party_rededuped := iterate(ds_ucc_party_deduped, tskip(left,right), local);
count(ds_ucc_party_rededuped);

output(ds_ucc_party_rededuped,,'~thor_data400::base::ucc_party_wexp_deduped_'+ UCCD.version_development,overwrite);
output(ds_ucc_party_rededuped(party_type='S' or party_type='A'),,'~thor_data400::base::ucc_secured_wexp_deduped_'+ UCCD.version_development, overwrite);
output(ds_ucc_party_rededuped(party_type='D'),,'~thor_data400::base::ucc_debtor_wexp_deduped_'+ UCCD.version_development, overwrite);

