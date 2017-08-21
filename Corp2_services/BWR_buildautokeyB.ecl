import autokeyb,Business_Header_SS,business_header,ut,corp2,doxie,address,AutoKeyB2;

export BWR_buildautokeyB(string pversion) := 
function

d1 :=distribute(corp2.files('').Base.Corp.built,hash(corp_key));
d1_dedup :=dedup(sort(d1,corp_key,local),corp_key,local);
pre_d2:=distribute(corp2.files('').Base.cont.Built,hash(corp_key));

// eliminate corp keys that are only in the contact file

d2 := join(pre_d2,d1_dedup,left.corp_key=right.corp_key,transform(recordof(pre_d2),self:=left), local,keep(1));


layout_cont :=record
d2.bdid;       // Seisint Business Identifier
d2.did;
d2.dt_first_seen;
d2.dt_last_seen;
d2.dt_vendor_first_reported;
d2.dt_vendor_last_reported;
d2.corp_key;
d2.corp_vendor;
d2.corp_vendor_county; // new
d2.corp_vendor_subcode; // new
d2.corp_state_origin;
d2.corp_process_date;
d2.corp_orig_sos_charter_nbr;
d2.corp_sos_charter_nbr;  // For application display
d2.corp_legal_name;
d2.cont_name;
d2.cont_title_desc;
d2.cont_sos_charter_nbr; // new
d2.cont_fein;
d2.cont_ssn;
d2.cont_dob;
d2.corp_addr1_prim_range;
d2.corp_addr1_prim_name;
d2.corp_addr1_sec_range;
d2.corp_addr1_p_city_name;
d2.corp_addr1_v_city_name;
d2.corp_addr1_state;
d2.corp_addr1_zip5;
d2.cont_fname;
d2.cont_mname;
d2.cont_lname;
d2.cont_cname;
d2.cont_prim_range;
d2.cont_prim_name;
d2.cont_sec_range;
d2.cont_p_city_name;
d2.cont_v_city_name;
d2.cont_state;
d2.cont_zip5;
d2.corp_phone10;
d2.cont_phone10;
d2.cont_type_desc;
end;

fein_rec :=record
d1.corp_fed_tax_id;		
d1.corp_state_tax_id;	
d1.corp_forgn_fed_tax_id;
d1.corp_forgn_state_tax_id;
d1.corp_key;
end;

with_feins :=record
layout_cont;
string32 fein1 :='';
string32 fein2 :='';
string32 fein3 :='';
string32 fein4 :='';
unsigned1 fein_num :=1;
end;


with_fein :=record
layout_cont;
string32 fein;
string350 company_name :='';
string25 business_city :='';
string25 person_city :='';
end;

justfein :=table(d1,fein_rec,corp_key,corp_fed_tax_id,corp_state_tax_id,corp_forgn_fed_tax_id,corp_forgn_state_tax_id,local);

dis_contacts :=table(d2,with_feins);

// append four feins to contact records that match corp records based on corp_key
with_feins add_fein(with_feins le, fein_rec ri) :=transform
self.fein_num := if(ri.corp_key <>'',(unsigned1) (ri.corp_fed_tax_id <>'') +(unsigned1) (ri.corp_state_tax_id <>'')+(unsigned1) (ri.corp_forgn_fed_tax_id <>'')
								+(unsigned1) (ri.corp_forgn_state_tax_id <>''),1);
self.fein1 :=ri.corp_fed_tax_id;
self.fein2 :=ri.corp_state_tax_id;
self.fein3 :=ri.corp_forgn_fed_tax_id;
self.fein4 :=ri.corp_forgn_state_tax_id;

self :=le;
end;

cont_with_fein :=join(dis_contacts,justfein,left.corp_key=right.corp_key,add_fein(left,right),local,left outer);


// normalize feins out to make each record with multiple feins into multiple records
with_fein normcont(with_feins le, integer C) :=transform
self.fein :=choose(C,le.fein1,le.fein2,le.fein3,le.fein4);
self :=le;
end;

normedcontacts :=dedup(normalize(cont_with_fein,4,normcont(left,counter)),record, all,local);

// use both cont_cname and corp_legal_name in the company_name field

with_fein both_company_names(with_fein le, integer C) :=transform
self.company_name :=choose(C,le.corp_legal_name,le.cont_cname);
self :=le;
end;

splitcnames :=normalize(normedcontacts,if(left.corp_legal_name=left.cont_cname or left.cont_cname='',1,2) ,both_company_names(left,counter));

// use both the vanity city and the primary city name in the business city field
with_fein both_b_city_names(with_fein le, integer C):=transform
self.business_city :=choose(C,le.corp_addr1_p_city_name,le.corp_addr1_v_city_name);
self :=le;
end;

split_b_city_names :=normalize(splitcnames,if(left.corp_addr1_p_city_name=left.corp_addr1_v_city_name or left.corp_addr1_v_city_name='',1,2),both_b_city_names(left,counter));

// use both the vanity city and the primary city name in the person city field
with_fein both_p_city_names(with_fein le, integer C):=transform
self.person_city :=choose(C,le.cont_p_city_name,le.cont_v_city_name);
self :=le;
end;


split_p_city_names :=normalize(split_b_city_names,if(left.cont_p_city_name=left.cont_v_city_name or left.cont_v_city_name='',1,2),both_p_city_names(left,counter));

corp2_services.assorted_layouts.layout_common commlayout(with_fein le, integer cnt):=transform
	pop_corp_address := le.corp_addr1_prim_name<>'' and le.corp_addr1_zip5<>'';
	pop_cont_address := le.cont_prim_name<>'' and le.cont_zip5<>'';
self.corp_key :=le.corp_key;
self.bdid :=le.bdid;
self.business_prim_name :=if(pop_cont_address and ~pop_corp_address,le.cont_prim_name,le.corp_addr1_prim_name);
self.business_prim_range :=if(pop_cont_address and ~pop_corp_address,le.cont_prim_range,le.corp_addr1_prim_range);
self.business_state :=if(cnt=1,
					if(pop_cont_address and ~pop_corp_address,le.cont_state,le.corp_addr1_state),
					le.corp_state_origin);
self.business_city :=if(pop_cont_address and ~pop_corp_address,le.person_city,le.business_city);
self.business_sec_range :=if(pop_cont_address and ~pop_corp_address,le.cont_sec_range,le.corp_addr1_sec_range);
self.business_zip :=if(pop_cont_address and ~pop_corp_address,le.cont_zip5,le.corp_addr1_zip5);
self.business_phone :=le.corp_phone10;
self.company_name :=le.company_name;

self.person_prim_range :=if(pop_corp_address and ~pop_cont_address,le.corp_addr1_prim_range,le.cont_prim_range);
self.person_prim_name :=if(pop_corp_address and ~pop_cont_address,le.corp_addr1_prim_name,le.cont_prim_name);
self.person_city :=if(pop_corp_address and ~pop_cont_address,le.business_city,le.person_city);
self.person_zip :=if(pop_corp_address and ~pop_cont_address,le.corp_addr1_zip5,le.cont_zip5);
self.person_sec_range:=if(pop_corp_address and ~pop_cont_address,le.corp_addr1_sec_range,le.cont_sec_range);
self.person_state :=if(pop_corp_address and ~pop_cont_address,le.corp_addr1_state,le.cont_state);
self.Person_phone :=le.cont_phone10;
self.person_dob :=le.cont_dob;
self.person_ssn :=le.cont_ssn;
self.person_fname := le.cont_fname;
self.person_mname := le.cont_mname;
self.person_lname := le.cont_lname;
self.person_did :=le.did;
self.fein :=le.fein;
self.lookup_bits :=if(~(le.cont_type_desc='REGISTERED AGENT'),
 (unsigned4) ut.bit_set(0,corp2_services.lookup_bit.bit_num(corp2_services.lookup_bit.Not_Ra)) +
 (unsigned4) ut.bit_set(0,corp2_services.lookup_bit.bit_num(corp2_services.lookup_bit.Accurint)),0);
end;

contacts_with_state := project(split_p_city_names,commlayout(left,1));

// Change made to generate keys for businesses & their state of incorporation, not just location state as is
// being done above - 20070621
contacts_with_origin := project(split_p_city_names(corp_addr1_state != corp_state_origin),commlayout(left,2));
contacts_ready := dedup(sort(contacts_with_state + contacts_with_origin,corp_key,local),record,all,local); 


layout_common_with_corp :=record
unsigned6 bdid := 0;  
string2	  corp_inc_state;
string8	  corp_inc_date;
string3	  corp_forgn_state_cd;
string32  corp_forgn_sos_charter_nbr;
string8	  corp_forgn_date;
string30  corp_key;
string2	  corp_state_origin;
string32  corp_orig_sos_charter_nbr;
string32  corp_sos_charter_nbr;  // For application display
string350 corp_legal_name;
string32  corp_fed_tax_id;
string32  corp_state_tax_id;
string32  corp_forgn_fed_tax_id;
string32  corp_forgn_state_tax_id;
string100 corp_ra_name;
string10  corp_addr1_prim_range;
string9	  corp_ra_ssn;
string8	  corp_ra_dob;
string28  corp_addr1_prim_name;
string8   corp_addr1_sec_range;
string25  corp_addr1_p_city_name;
string25  corp_addr1_v_city_name;
string2   corp_addr1_state;
string5   corp_addr1_zip5;
string10  corp_addr2_prim_range;
string28  corp_addr2_prim_name;
string8   corp_addr2_sec_range;
string25  corp_addr2_p_city_name;
string25  corp_addr2_v_city_name;
string2   corp_addr2_state;
string5   corp_addr2_zip5;
string10  corp_phone10;
string10  corp_ra_phone10;
string20  corp_ra_fname1;
string20  corp_ra_mname1;
string20  corp_ra_lname1;
string20  corp_ra_fname2;
string20  corp_ra_mname2;
string20  corp_ra_lname2;
string70  corp_ra_cname1;
string70  corp_ra_cname2;
string10  corp_ra_prim_range;
string2   corp_ra_predir;
string28  corp_ra_prim_name;
string8   corp_ra_sec_range;
string25  corp_ra_p_city_name;
string25  corp_ra_v_city_name;
string2   corp_ra_state;
string5   corp_ra_zip5;
//corp2_services.assorted_layouts.layout_common;
string28 business_prim_name ;
string10 business_prim_range ;
string2 business_state ;
string25 business_city;
string8 business_sec_range;
string5 business_zip ;
string10 business_phone ;
string350 company_name ;
string32 fein;
string10 person_prim_range ;
string28 person_prim_name ;
string25 person_city ;
string5 person_zip ;
string8 person_sec_range;
string2 person_state ;
string10 Person_phone ;
string8 person_dob ;
string9 person_ssn ;
string20 person_fname ;
string20 person_mname ;
string20 person_lname ;
unsigned6 person_did;
unsigned1 zero1 := 0;
unsigned4 lookup_bits := 0;
end;

layout_common_with_corp all_business_addresses(corp2.layout_corporate_direct_corp_base le,integer C):=transform
self.bdid := le.bdid;       // Seisint Business Identifier
self.corp_key :=le.corp_key;

self.person_prim_range :=le.corp_ra_prim_range;
self.person_prim_name :=le.corp_ra_prim_name;
self.person_zip :=le.corp_ra_zip5;
self.person_sec_range:=le.corp_ra_sec_range;
self.person_state :=le.corp_ra_state;
self.Person_phone :=le.corp_ra_phone10;
self.person_dob :=le.corp_ra_dob;
self.person_ssn :=le.corp_ra_ssn;

self.business_phone :=le.corp_phone10;	
self.business_prim_range :=choose((unsigned1)roundup(C/2),le.corp_addr1_prim_range,le.corp_addr2_prim_range);
self.business_prim_name :=choose((unsigned1)roundup(C/2),le.corp_addr1_prim_name,le.corp_addr2_prim_name); 
self.business_sec_range :=choose((unsigned1)roundup(C/2),le.corp_addr1_sec_range,le.corp_addr2_sec_range); 
self.business_state :=choose((unsigned1)roundup(C/2),if(le.corp_addr1_state<>'',le.corp_addr1_state,
	le.corp_state_origin),le.corp_addr2_state);
self.business_zip :=choose((unsigned1)roundup(C/2),le.corp_addr1_zip5,le.corp_addr2_zip5);
self.business_city :=choose(C,le.corp_addr1_p_city_name,le.corp_addr1_v_city_name,le.corp_addr2_p_city_name,le.corp_addr2_v_city_name);
self :=le;
self :=[];
end;



// capture both business addresses including the vanity and primary city names
corp_all_b_addresses := dedup(normalize(d1,if(left.corp_addr1_prim_name='' and left.corp_addr1_zip5='',1,4),all_business_addresses(left,counter)),record,all,local );


layout_common_with_corp both_ra_cities(layout_common_with_corp le,integer C):=transform
self.person_city :=choose(C,le.corp_ra_p_city_name,le.corp_ra_v_city_name);
self :=le;
end;

//capture both ra city names
corp_both_p_cities :=normalize(corp_all_b_addresses,if(left.corp_ra_p_city_name=left.corp_ra_v_city_name or left.corp_ra_v_city_name='',1,2),both_ra_cities(left,counter));

layout_common_with_corp get_address_for_blank(layout_common_with_corp le):=transform
	pop_corp_address := le.business_prim_name<>'' and le.business_zip<>'';
	pop_ra_address := le.person_prim_name<>'' and le.person_zip<>'';
	self.business_prim_range :=if(pop_ra_address and ~pop_corp_address,le.person_prim_range,le.business_prim_range);
	self.business_prim_name := if(pop_ra_address and ~pop_corp_address,le.person_prim_name,le.business_prim_name);
	self.business_sec_range := if(pop_ra_address and ~pop_corp_address,le.person_sec_range,le.business_sec_range);
	self.business_state := if(pop_ra_address and ~pop_corp_address,le.person_state,le.business_state);
	self.business_zip :=if(pop_ra_address and ~pop_corp_address,le.person_zip,le.business_zip);
	self.business_city :=if(pop_ra_address and ~pop_corp_address,le.person_city,le.business_city);

	self.person_prim_range :=if(pop_corp_address and ~pop_ra_address,le.business_prim_range,le.person_prim_range);
	self.person_prim_name := if(pop_corp_address and ~pop_ra_address,le.business_prim_name,le.person_prim_name);
	self.person_sec_range := if(pop_corp_address and ~pop_ra_address,le.business_sec_range,le.person_sec_range);
	self.person_state := if(pop_corp_address and ~pop_ra_address,le.business_state,le.person_state);
	self.person_zip :=if(pop_corp_address and ~pop_ra_address,le.business_zip,le.person_zip);
	self.person_city :=if(pop_corp_address and ~pop_ra_address,le.business_city,le.person_city);
	
	self :=le;
END;
	
corp_fill_blank_addresses :=project(corp_both_p_cities,get_address_for_blank(left));

//capture all company names
layout_common_with_corp all_companies(layout_common_with_corp le,integer C):=transform
self.company_name :=choose(C,le.corp_legal_name,le.corp_ra_cname1,le.corp_ra_cname2);

//only set lookup bit if corp name is not a registered agent
self.lookup_bits  := if(C=1, ut.bit_set(0,corp2_services.lookup_bit.bit_num(corp2_services.lookup_bit.Corp)),0);
self :=le;
end;

corp_all_company_names :=dedup(normalize(corp_fill_blank_addresses,if((left.corp_ra_cname1=left.corp_ra_cname2 and left.corp_ra_cname1=left.corp_legal_name) or (left.corp_ra_cname1=left.corp_ra_cname1 and left.corp_ra_cname1=''),1,3), all_companies(left,counter)),record,all,local );


layout_common_with_corp all_feins(layout_common_with_corp le,integer C):=transform
self.fein :=choose(C,le.corp_fed_tax_id,le.corp_state_tax_id,le.Corp_forgn_fed_tax_id,le.corp_forgn_state_tax_id);
self :=le;
end;

corp_all_feins :=dedup(normalize(corp_all_company_names,4,all_feins(left,counter)),record,all,local );


corp2_services.assorted_layouts.layout_common all_names(layout_common_with_corp le,integer C) :=transform


self.person_fname := choose(C,le.corp_ra_fname1, le.corp_ra_fname2);
self.person_mname := choose(C,le.corp_ra_mname1,le.corp_ra_mname2);
self.person_lname := choose(C,le.corp_ra_lname1,le.corp_ra_lname2);
self :=le;
end;


pre_corp_ready :=dedup(normalize(corp_all_feins,2,all_names(left,counter)),record,all,local);

corp2_services.assorted_layouts.layout_common setaccurint_bit(corp2_services.assorted_layouts.layout_common l):=transform
	self.lookup_bits := if(l.business_prim_name = l.person_prim_name and l.business_prim_range=l.person_prim_range and
												l.business_zip = l.person_zip,l.lookup_bits + 
												ut.bit_set(0,corp2_services.lookup_bit.bit_num(corp2_services.lookup_bit.Accurint))
												,l.lookup_bits);
	self := l;
END;

corp_ready := project(pre_corp_ready,setaccurint_bit(left));



// creating the persist file this way and then reading it later keeps the above processes from being
// repeated for every key, which happens if no persist statement is used or if the persists statement
// is used and the attribute name is passed to Mac_Build rather than a new attribute being created
// once the dataset is read in
persistname := corp2.Thor_Cluster + 'persist::Corp2_services::BWR_buildautokeyB2';



almost_autokey_ready :=corp_ready+contacts_ready;


recordof(almost_autokey_ready) addcontactaddr_corp(almost_autokey_ready l) := transform
	self.person_prim_name := l.business_prim_name;
	self.person_prim_range := l.business_prim_range;
	self.person_state := l.business_state;
	self.person_city := l.business_city;
	self.person_zip := l.business_zip;
	self.person_sec_range := l.business_sec_range;
	// all business addresses get the accurint bit set so that they may be retrieved as well as contact
	// addresses when the address key is hit
	
	self.lookup_bits := if(~ut.bit_test(l.lookup_bits, corp2_services.lookup_bit.bit_num(corp2_services.lookup_bit.Not_Ra)),l.lookup_bits+
		ut.bit_set(0,corp2_services.lookup_bit.bit_num(corp2_services.lookup_bit.Accurint)),l.lookup_bits); 
	self := l;
end;


needsaddcontactaddr_corp := almost_autokey_ready.business_prim_name <> '' and almost_autokey_ready.business_prim_name <> almost_autokey_ready.person_prim_name;



withaddcontactaddr_corp := 
	almost_autokey_ready + 
	project(almost_autokey_ready(needsaddcontactaddr_corp), addcontactaddr_corp(left));


	layout_with_addr_fields := record
	withaddcontactaddr_corp;
	STRING28 prim_name;
	STRING10 prim_range,
	UNSIGNED4 city_code;
	unsigned1 for_accurint;
	END;


	
	layout_with_addr_fields get_addr_like_mac(withaddcontactaddr_corp l):=transform
	
	self.prim_name := ut.StripOrdinal(l.person_prim_name);
	self.prim_range := TRIM(ut.CleanPrimRange(l.person_prim_range),LEFT);
	self.city_code := doxie.Make_CityCode(l.person_city);
	self.for_accurint := map(ut.bit_test(l.lookup_bits,corp2_services.lookup_bit.bit_num(corp2_services.lookup_bit.Accurint))
	and ut.bit_test(l.lookup_bits,corp2_services.lookup_bit.bit_num(corp2_services.lookup_bit.Not_Ra))=>0,
	ut.bit_test(l.lookup_bits,corp2_services.lookup_bit.bit_num(corp2_services.lookup_bit.Accurint)) => 1,
	2);
	self := l;
END;

// prep for setting rep addr bit
get_addr_fields := project(withaddcontactaddr_corp(person_prim_name<>''),get_addr_like_mac(left));


layout_with_addr_fields get_rep_addr(layout_with_addr_fields  l,layout_with_addr_fields  r):=transform
	self.lookup_bits := if(~(l.corp_key=r.corp_key and l.person_did=r.person_did and l.bdid=r.bdid and l.prim_name=r.prim_name and
	l.prim_range= r.prim_range and
	l.person_state=r.person_state and 
	l.city_code = r.city_code and
	l.person_zip =r.person_zip),r.lookup_bits + ut.bit_set(0,corp2_services.lookup_bit.bit_num(corp2_services.lookup_bit.Rep_Addr)),r.lookup_bits),
	self := r;
END;

// for records with the same address set the rep addr bit on the one that is a non ra

with_addr_lookup := iterate(sort(get_addr_fields,corp_key,person_did,bdid,
	prim_name,prim_range,
	person_state,city_code,person_zip,
	for_accurint,local),get_rep_addr(left,right),local);


pass_to_build := withaddcontactaddr_corp:persist(persistname);
//project(with_addr_lookup,corp2_services.assorted_layouts.layout_common) +
//	withaddcontactaddr_corp(person_prim_name=''):persist(persistname);

t := corp2.keynames('').AutokeyRoot;
inlogical := corp2.keynames(pversion).Autokeys.Root.new;

to_use :=dataset(persistname,corp2_services.assorted_layouts.layout_common,flat);

AutoKeyB2.MAC_Build (pass_to_build,person_fname,person_mname,person_lname,
						person_ssn,
						person_dob,
						person_phone,
						person_prim_name,person_prim_range,person_state,person_city,person_zip,person_sec_range,
						zero1,
						zero1,zero1,zero1,
						zero1,zero1,zero1,
						zero1,zero1,zero1,
						lookup_bits,
						person_did,
						company_name,
						fein,
						business_phone,
						business_prim_name,business_prim_range,business_state,business_city,business_zip,business_sec_range,
						bdid,
						t,
						inlogical,
						outaction,false,
						[],true,'BC',TRUE,,
						corp2_services.lookup_bit.bit_num(corp2_services.lookup_bit.Rep_Addr),
	          corp_key,TRUE,TRUE,FALSE,
						corp2_services.lookup_bit.bit_num(corp2_services.lookup_bit.Corp),
						corp2_services.lookup_bit.bit_num(corp2_services.lookup_bit.Not_Ra)
						) 





mymove := Corp2.Promote_Built_To_QA;
//AutoKeyB.MAC_AcceptSK_to_QA(corp2.keynames.AutokeyRoot,mymove)
return sequential(outaction);

end;