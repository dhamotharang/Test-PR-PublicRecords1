//// For Relatives and Associates: Just focusing on Personal RAs.
//// So Address will be the same (shared address), and same Last Name for Rel and Diff Last Name for Asc.
//// Place search_DID into the look_up DID field, and put DID2 into the DID field.
//// For Neighbors, use thor_data400::key::header_nbr_uid_qa


IMPORT Header, Doxie, MDR, ut,data_services,Relationship;

layout_key_Relatives_V3 :=
	RECORD
		unsigned6 did1;
		string15 type;
		string10 confidence;
		unsigned6 did2;
		integer2 cohabit_score;
		integer2 cohabit_cnt;
		integer2 coapt_score;
		integer2 coapt_cnt;
		integer2 copobox_score;
		integer2 copobox_cnt;
		integer2 cossn_score;
		integer2 cossn_cnt;
		integer2 copolicy_score;
		integer2 copolicy_cnt;
		integer2 coclaim_score;
		integer2 coclaim_cnt;
		integer2 coproperty_score;
		integer2 coproperty_cnt;
		integer2 bcoproperty_score;
		integer2 bcoproperty_cnt;
		integer2 coforeclosure_score;
		integer2 coforeclosure_cnt;
		integer2 bcoforeclosure_score;
		integer2 bcoforeclosure_cnt;
		integer2 colien_score;
		integer2 colien_cnt;
		integer2 bcolien_score;
		integer2 bcolien_cnt;
		integer2 cobankruptcy_score;
		integer2 cobankruptcy_cnt;
		integer2 bcobankruptcy_score;
		integer2 bcobankruptcy_cnt;
		integer2 covehicle_score;
		integer2 covehicle_cnt;
		integer2 coexperian_score;
		integer2 coexperian_cnt;
		integer2 cotransunion_score;
		integer2 cotransunion_cnt;
		integer2 coenclarity_score;
		integer2 coenclarity_cnt;
		integer2 coecrash_score;
		integer2 coecrash_cnt;
		integer2 bcoecrash_score;
		integer2 bcoecrash_cnt;
		integer2 cowatercraft_score;
		integer2 cowatercraft_cnt;
		integer2 coaircraft_score;
		integer2 coaircraft_cnt;
		integer2 comarriagedivorce_score;
		integer2 comarriagedivorce_cnt;
		integer2 coucc_score;
		integer2 coucc_cnt;
		integer2 lname_score;
		integer2 phone_score;
		integer2 dl_nbr_score;
		unsigned2 total_cnt;
		integer2 total_score;
		string10 cluster;
		string2 generation;
		string1 gender;
		unsigned4 lname_cnt;
		unsigned4 rel_dt_first_seen;
		unsigned4 rel_dt_last_seen;
		unsigned2 overlap_months;
		unsigned4 hdr_dt_first_seen;
		unsigned4 hdr_dt_last_seen;
		unsigned2 age_first_seen;
		boolean isanylnamematch;
		boolean isanyphonematch;
		boolean isearlylnamematch;
		boolean iscurrlnamematch;
		boolean ismixedlnamematch;
		string9 ssn1;
		string9 ssn2;
		unsigned4 dob1;
		unsigned4 dob2;
		string28 current_lname1;
		string28 current_lname2;
		string28 early_lname1;
		string28 early_lname2;
		string2 addr_ind1;
		string2 addr_ind2;
		unsigned6 r2rdid;
		unsigned6 r2cnt;
		boolean personal;
		boolean business;
		boolean other;
		unsigned1 title;
	 END;
//-----------

key_RnA := PULL(Relationship.key_relatives_v3);

rs_Relatives_TypePersonal := key_RnA(type = 'PERSONAL' 
																		 AND cohabit_score > 0
																		 AND overlap_months > 0
																		);

rs_Relatives_Personal 	:= SORT(distribute(rs_Relatives_TypePersonal(type = 'PERSONAL' AND isanylnamematch = true)
																					, hash(did1)), did1,local);
rs_Associates_Personal 	:= SORT(distribute(rs_Relatives_TypePersonal(type = 'PERSONAL' AND isanylnamematch = false)
																, hash(did1)), did1,local);

//-----

EXPORT Compliance.Layout_Out_v3 xfmRNA(layout_key_Relatives_V3 LE, Compliance.Layout_Out_v3 RI) := 
	TRANSFORM
		self.did := (unsigned6) LE.did2;
		
		self.src := MAP(LE.isanylnamematch = true => 'RELATIVE'
										, 'ASSOCIATE'
										);

		self.dt_first_seen := (unsigned3) LE.rel_dt_first_seen;
		self.dt_last_seen := (unsigned3) LE.rel_dt_last_seen;
		self.dt_vendor_last_reported := (unsigned3) LE.hdr_dt_last_seen;
		self.dt_vendor_first_reported := (unsigned3) LE.hdr_dt_first_seen;
		
		self.listed_name := LE.current_lname1;
		self.name_ind := LE.title;
		
		self.lookup_did := LE.did1;
		
		self.source_value := self.src;
		
		self.title := RI.title;
		self.fname := RI.fname;
		self.mname := RI.mname;
		self.lname := RI.lname;
		self.name_suffix := RI.name_suffix;
		self.prim_range := RI.prim_range;
		self.predir := RI.predir;
		self.prim_name := RI.prim_name;
		self.suffix := RI.suffix;
		self.postdir := RI.postdir;
		self.unit_desig := RI.unit_desig;
		self.sec_range := RI.sec_range;
		self.city_name := RI.city_name;
		self.st := RI.st;
		self.zip := (qstring5) RI.zip;
		self.zip4 := (qstring4) RI.zip4;
		self.RawAID := (unsigned8) RI.RawAID;
		self.persistent_record_ID := (unsigned8) RI.persistent_record_ID;
		self.nid := RI.nid;
		
		SELF := LE;
		SELF := RI;
	END;

//----
/*
rec_Neighbors_keyfields :=
	RECORD
		qstring5 zip;
		qstring28 prim_name;
		qstring4 suffix;
		string2 predir;
		string2 postdir;
		unsigned6 uid;
	END;
		
rec_Neighbors_nonkeyfields :=
	RECORD
		unsigned6 did;
		qstring10 prim_range;
		qstring8 sec_range;
		unsigned3 dt_first_seen;
		unsigned3 dt_last_seen;
		unsigned6 rid;
		string1 pflag3;
		qstring9 ssn;
		string1 tnt;
		unsigned3 dt_nonglb_last_seen;
		string2 src;
		string1 valid_ssn;
		qstring10 phone;
		qstring5 title;
		qstring20 fname;
		qstring20 mname;
		qstring20 lname;
		qstring5 name_suffix;
		qstring10 unit_desig;
		qstring25 city_name;
		string2 st;
		qstring4 zip4;
		string3 county;
		qstring7 geo_blk;
		integer4 dob;
		string18 county_name;
		unsigned8 rawaid;
	 END;


key_Neighbors := PULL(INDEX(rec_Neighbors_keyfields,rec_Neighbors_nonkeyfields, Data_Services.foreign_prod+ 'thor_data400::key::header_nbr_uid_qa'));
*/
