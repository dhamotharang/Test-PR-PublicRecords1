IMPORT Business_Header, ut, mdr, _validate;

EXPORT fLiensV2_As_Business_Linking(DATASET(LiensV2.layout_liens_party_ssn_BIPV2) pFile_Liens) :=
FUNCTION

	Business_Header.Layout_Business_Linking.Linking_Interface  Translate_Liens_to_BLF(LiensV2.layout_liens_party_ssn_BIPV2 l) := 
	TRANSFORM, SKIP(TRIM(l.prim_range) = '' AND TRIM(l.prim_name) = '' AND TRIM(l.v_city_name) = '' AND
                  TRIM(l.st) = '' AND TRIM(l.zip) = '' AND TRIM(l.phone) = '' AND 
                  TRIM(l.tax_id) = '' AND TRIM(l.lname) = '' AND TRIM(l.fname) = '')
		SELF.source 		                   := MDR.sourceTools.src_Liens_v2;
		SELF.dt_first_seen 	               := IF(_validate.date.fIsValid((STRING)l.date_first_seen),
                                             (UNSIGNED4)l.date_first_seen, 0);
		SELF.dt_last_seen 	               := IF(_validate.date.fIsValid((STRING)l.date_last_seen),
                                             (UNSIGNED4)l.date_last_seen, 0);
		SELF.dt_vendor_first_reported      := IF(_validate.date.fIsValid((STRING)l.date_vendor_first_reported),
                                             (UNSIGNED4)l.date_vendor_first_reported, 0);
		SELF.dt_vendor_last_reported 	     := IF(_validate.date.fIsValid((STRING)l.date_vendor_last_reported),
                                             (UNSIGNED4)l.date_vendor_last_reported, 0);
		SELF.rcid 			                   := 0;
		SELF.company_bdid                  := IF(l.bdid <> '', (UNSIGNED6)l.bdid, 0);
		SELF.company_name                  := ut.CleanSpacesAndUpper(l.cname);
		SELF.company_address.prim_range    := l.prim_range;
		SELF.company_address.predir        := l.predir;
		SELF.company_address.prim_name     := l.prim_name;
		SELF.company_address.addr_suffix   := l.addr_suffix;
		SELF.company_address.postdir       := l.postdir;
		SELF.company_address.unit_desig    := l.unit_desig;
		SELF.company_address.sec_range     := l.sec_range;
		SELF.company_address.p_city_name   := l.p_city_name;
		SELF.company_address.v_city_name   := l.v_city_name;
		SELF.company_address.st            := l.st;
		SELF.company_address.zip           := l.zip;
		SELF.company_address.zip4          := l.zip4;
		SELF.company_address.cart          := l.cart;
		SELF.company_address.cr_sort_sz    := l.cr_sort_sz;
		SELF.company_address.lot           := l.lot;
		SELF.company_address.lot_order     := l.lot_order;
		SELF.company_address.dbpc          := l.dbpc;
		SELF.company_address.chk_digit     := l.chk_digit;
		SELF.company_address.rec_type      := l.rec_type;
		SELF.company_address.fips_state    := l.county[1..2];
		SELF.company_address.fips_county   := l.county[3..5];
		SELF.company_address.geo_lat       := l.geo_lat;
		SELF.company_address.geo_long      := l.geo_long;
		SELF.company_address.msa           := l.msa;
		SELF.company_address.geo_blk       := l.geo_blk;
		SELF.company_address.geo_match     := l.geo_match;
		SELF.company_address.err_stat      := l.err_stat;
		SELF.company_fein                  := l.tax_id;
    SELF.company_phone                 := IF(l.phone <> '', ut.CleanPhone(l.phone), '');
 		SELF.dt_first_seen_company_name    := IF(_validate.date.fIsValid((STRING)l.date_first_seen),
                                             (UNSIGNED4)l.date_first_seen, 0);
		SELF.dt_last_seen_company_name     := IF(_validate.date.fIsValid((STRING)l.date_last_seen),
                                             (UNSIGNED4)l.date_last_seen, 0);
		SELF.dt_first_seen_company_address := IF(_validate.date.fIsValid((STRING)l.date_first_seen),
                                             (UNSIGNED4)l.date_first_seen, 0);
		SELF.dt_last_seen_company_address  := IF(_validate.date.fIsValid((STRING)l.date_last_seen),
                                             (UNSIGNED4)l.date_last_seen, 0);
    // SELF.vl_id                         := IF(l.tax_id <> '',
																						 // TRIM(l.tmsid[1..2]) + ut.fnTrim2Upper(l.cname) + l.st + l.tax_id,
																						 // TRIM(l.tmsid[1..2]) + ut.fnTrim2Upper(l.cname) + l.st + l.prim_name + l.p_city_name);   
    SELF.vl_id                         := TRIM(l.tmsid_old[1..2]) + (STRING)HASH(l.tmsid_old + l.rmsid_old);   //DF_24044 keep tmsid consistent as some have changed.
		SELF.current                       := TRUE;
		SELF.source_record_id              := l.persistent_record_id;
    SELF.phone_score                   := IF((INTEGER)SELF.company_phone=0,0,1);
		SELF.dt_first_seen_contact         := IF(_validate.date.fIsValid((STRING)l.date_first_seen),
                                             (UNSIGNED4)l.date_first_seen, 0);
		SELF.dt_last_seen_contact          := IF(_validate.date.fIsValid((STRING)l.date_last_seen),
                                             (UNSIGNED4)l.date_last_seen, 0);
		SELF.contact_did                   := (UNSIGNED6)l.DID;
		SELF.contact_name.title            := TRIM(l.title);
		SELF.contact_name.fname            := TRIM(l.fname);
		SELF.contact_name.mname            := TRIM(l.mname);
		SELF.contact_name.lname            := TRIM(l.lname);
		SELF.contact_name.name_suffix      := TRIM(l.name_suffix);
		SELF.contact_name.name_score       := TRIM(l.name_score);
		SELF.contact_ssn                   := TRIM(l.ssn);
		SELF.contact_phone                 := TRIM(l.phone);
		SELF 			                         := l;
		SELF                               := [];
	END;
	
	liens_as_BLF := PROJECT(pFile_Liens(cname <> '',TRIM(tmsid[1..2],LEFT,RIGHT) != 'A9'),
                          Translate_Liens_to_BLF(LEFT));
	
	// Rollup
	Business_Header.Layout_Business_Linking.Linking_Interface RollupLiens(Business_Header.Layout_Business_Linking.Linking_Interface L,
                                                                        Business_Header.Layout_Business_Linking.Linking_Interface R) := TRANSFORM
	  SELF.dt_first_seen               := ut.EarliestDate(ut.EarliestDate(L.dt_first_seen,R.dt_first_seen),
				                                ut.EarliestDate(L.dt_last_seen,R.dt_last_seen));
	  SELF.dt_last_seen                := MAX(L.dt_last_seen,R.dt_last_seen);
	  SELF.dt_vendor_last_reported     := MAX(L.dt_vendor_last_reported, R.dt_vendor_last_reported);
	  SELF.dt_vendor_first_reported    := ut.EarliestDate(L.dt_vendor_first_reported, R.dt_vendor_first_reported);
	  SELF.company_name                := IF(L.company_name = '', R.company_name, L.company_name);
	  SELF.company_phone               := IF(L.company_phone = '', R.company_phone, L.company_phone);
	  SELF.phone_score                 := IF(L.company_phone = '', R.phone_score, L.phone_score);
	  SELF.company_fein                := IF(L.company_fein = '', R.company_fein, L.company_fein);
	  SELF.company_address.prim_range  := IF(l.company_address.prim_range = '' AND l.company_address.zip4 = '',
                                           r.company_address.prim_range, l.company_address.prim_range);
	  SELF.company_address.predir      := IF(l.company_address.predir = '' AND l.company_address.zip4 = '',
                                           r.company_address.predir, l.company_address.predir);
	  SELF.company_address.prim_name   := IF(l.company_address.prim_name = '' AND l.company_address.zip4 = '',
                                           r.company_address.prim_name, l.company_address.prim_name);
	  SELF.company_address.addr_suffix := IF(l.company_address.addr_suffix = '' AND l.company_address.zip4 = '',
                                           r.company_address.addr_suffix, l.company_address.addr_suffix);
	  SELF.company_address.postdir     := IF(l.company_address.postdir = '' AND l.company_address.zip4 = '',
                                           r.company_address.postdir, l.company_address.postdir);
	  SELF.company_address.unit_desig  := IF(l.company_address.unit_desig = '' AND l.company_address.zip4 = '',
                                           r.company_address.unit_desig, l.company_address.unit_desig);
	  SELF.company_address.sec_range   := IF(l.company_address.sec_range = '' AND l .company_address.zip4 = '',
                                           r.company_address.sec_range, l.company_address.sec_range);
	  SELF.company_address.p_city_name := IF(l.company_address.p_city_name = '' AND l.company_address.zip4 = '',
                                           r.company_address.p_city_name, l.company_address.p_city_name);
	  SELF.company_address.v_city_name := IF(l.company_address.v_city_name = '' AND l.company_address.zip4 = '',
                                           r.company_address.v_city_name, l.company_address.v_city_name);
	  SELF.company_address.st          := IF(l.company_address.st = '' AND l.company_address.zip4 = '',
                                           r.company_address.st, l.company_address.st);
	  SELF.company_address.zip         := IF(l.company_address.zip = '' AND l.company_address.zip4 = '',
                                           r.company_address.zip, l.company_address.zip);
	  SELF.company_address.zip4        := IF(l.company_address.zip4 = '', r.company_address.zip4,
                                           l.company_address.zip4);
	  SELF.company_address.fips_state  := IF(l.company_address.fips_state = '' AND l.company_address.zip4 = '',
                                           r.company_address.fips_state, l.company_address.fips_state);
	  SELF.company_address.fips_county := IF(l.company_address.fips_county = '' AND l.company_address.zip4 = '',
                                           r.company_address.fips_county, l.company_address.fips_county);
	  SELF.company_address.msa         := IF(l.company_address.msa = '' AND l.company_address.zip4 = '',
                                           r.company_address.msa, l.company_address.msa);
	  SELF.company_address.geo_lat     := IF(l.company_address.geo_lat = '' AND l.company_address.zip4 = '',
                                           r.company_address.geo_lat, l.company_address.geo_lat);
	  SELF.company_address.geo_long    := IF(l.company_address.geo_long = '' AND l.company_address.zip4 = '',
                                           r.company_address.geo_long, l.company_address.geo_long);
	  SELF.dt_first_seen_contact       := ut.EarliestDate(ut.EarliestDate(L.dt_first_seen_contact,R.dt_first_seen_contact),
				                                ut.EarliestDate(L.dt_last_seen_contact,R.dt_last_seen_contact));
	  SELF.dt_last_seen_contact        := MAX(L.dt_last_seen_contact,R.dt_last_seen_contact);
	  SELF := l;
	END;

	liens_dist := DISTRIBUTE(liens_as_BLF,
								   HASH64(company_name, company_address.prim_name, 
                        company_address.prim_range, company_address.v_city_name, company_address.st));
	liens_sort := SORT(liens_dist, company_name, company_address.prim_range, company_address.prim_name, 
                     company_address.predir, company_address.addr_suffix, company_address.postdir, 
                     company_address.sec_range, company_address.unit_desig, company_address.v_city_name,
                     company_address.st, company_address.zip, company_phone, company_fein,
                     contact_name.lname, contact_name.fname, contact_name.mname, contact_ssn,
                     contact_phone,
						         dt_vendor_last_reported, dt_vendor_first_reported, dt_last_seen, LOCAL);
	liens_rollup := ROLLUP(liens_sort,
							           ut.CleanCompany(LEFT.company_name) = ut.CleanCompany(RIGHT.company_name) AND
							           LEFT.company_address.prim_name = RIGHT.company_address.prim_name AND
							           LEFT.company_address.prim_range = RIGHT.company_address.prim_range AND
							           LEFT.company_address.predir = RIGHT.company_address.predir AND
							           LEFT.company_address.addr_suffix = RIGHT.company_address.addr_suffix AND
							           LEFT.company_address.postdir = RIGHT.company_address.postdir AND
							           (RIGHT.company_address.sec_range = '' OR 
                          LEFT.company_address.sec_range = RIGHT.company_address.sec_range) AND
							           LEFT.company_address.unit_desig = RIGHT.company_address.unit_desig AND
							           LEFT.company_address.v_city_name = RIGHT.company_address.v_city_name AND
							           LEFT.company_address.st = RIGHT.company_address.st AND
							           LEFT.company_address.zip = RIGHT.company_address.zip AND
							           (RIGHT.company_phone = '' OR LEFT.company_phone = RIGHT.company_phone) AND
							           (RIGHT.company_fein = '' OR LEFT.company_fein = RIGHT.company_fein) AND
							           LEFT.contact_name.lname = RIGHT.contact_name.lname AND
							           LEFT.contact_name.fname = RIGHT.contact_name.fname AND
							           LEFT.contact_name.mname = RIGHT.contact_name.mname AND
							           LEFT.contact_ssn = RIGHT.contact_ssn AND
							           LEFT.contact_phone = RIGHT.contact_phone,
						             RollupLiens(LEFT, RIGHT),
							           LOCAL);
	RETURN liens_rollup;

END;