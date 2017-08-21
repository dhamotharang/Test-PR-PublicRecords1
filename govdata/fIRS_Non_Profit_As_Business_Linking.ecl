IMPORT business_header, ut,mdr;

rNewBusinessLayout := RECORD
  Business_Header.Layout_Business_Linking.Linking_Interface;
END;

EXPORT fIRS_Non_Profit_As_Business_Linking(DATASET(govdata.Layouts_IRS_NonProfit.Base_AID) pBasefile) := FUNCTION

	rNewBusinessLayout into(govdata.Layouts_IRS_NonProfit.Base_AID L) := TRANSFORM
		// Gen Data   
		SELF.source := MDR.sourceTools.src_IRS_Non_Profit;
		SELF.dt_first_seen := IF((INTEGER) L.ruling_date > 190000,
					((INTEGER) L.ruling_date) * 100, 
					IF((INTEGER) L.tax_period > 190000,
						((INTEGER) L.tax_period) * 100,
						(INTEGER) L.process_date));
		SELF.dt_last_seen := (INTEGER) L.process_date;
		SELF.dt_vendor_first_reported := SELF.dt_first_seen;
		SELF.dt_vendor_last_reported := (INTEGER) L.process_date;
    SELF.company_bdid := L.bdid;

		// Business Data
		SELF.company_name := L.primary_name_of_organization;
		SELF.company_rawaid := L.Append_RawAID;
		SELF.company_address.prim_range := L.prim_range;
		SELF.company_address.predir := L.predir;
		SELF.company_address.prim_name := L.prim_name;
		SELF.company_address.addr_suffix := L.addr_suffix;
		SELF.company_address.postdir := L.postdir;
		SELF.company_address.unit_desig := L.unit_desig;
		SELF.company_address.sec_range := L.sec_range;
		SELF.company_address.p_city_name := L.p_city_name;
		SELF.company_address.v_city_name := L.v_city_name;
		SELF.company_address.st := L.st;
		SELF.company_address.zip := L.zip;
		SELF.company_address.zip4 := L.zip4;
		SELF.company_address.cart := L.cart;
		SELF.company_address.cr_sort_sz := L.cr_sort_sz;
		SELF.company_address.lot := L.lot;
		SELF.company_address.lot_order := L.lot_order;
		SELF.company_address.dbpc := L.dbpc;
		SELF.company_address.chk_digit := L.chk_digit;
		SELF.company_address.rec_type := L.rec_type;
		SELF.company_address.fips_state := L.county[1..2];
		SELF.company_address.fips_county := L.county[3..5];
		SELF.company_address.geo_lat := L.geo_lat;
		SELF.company_address.geo_long := L.geo_long;
		SELF.company_address.msa := L.msa;
		SELF.company_address.geo_blk := L.geo_blk;
		SELF.company_address.geo_match := L.geo_match;
		SELF.company_address.err_stat := L.err_stat;

		SELF.company_fein := L.employer_id_number;    
		SELF.vl_id := L.employer_id_number + L.group_exemption_number;
		SELF.source_record_id	:= l.source_rec_id;
		SELF.current := TRUE;
    
    // Contact Data
		SELF.contact_name.title := L.title;
		SELF.contact_name.fname := L.fname;
		SELF.contact_name.mname := L.mname;
		SELF.contact_name.lname := L.lname;
		SELF.contact_name.name_suffix := L.name_suffix;
		SELF.contact_name.name_score := L.name_score;
    SELF := L;
    SELF := [];
	END;

	pIRSNonP := PROJECT(pBasefile(primary_name_of_organization != ''), into(LEFT));

	rNewBusinessLayout RollupBL(rNewBusinessLayout l, rNewBusinessLayout r) := TRANSFORM
	  SELF.dt_first_seen               := ut.EarliestDate(ut.EarliestDate(l.dt_first_seen,r.dt_first_seen),
				                                                ut.EarliestDate(l.dt_last_seen,r.dt_last_seen));
	  SELF.dt_last_seen                := max(l.dt_last_seen,r.dt_last_seen);
	  SELF.dt_vendor_last_reported     := max(l.dt_vendor_last_reported, 
                                                      r.dt_vendor_last_reported);
	  SELF.dt_vendor_first_reported    := ut.EarliestDate(l.dt_vendor_first_reported,
                                                        r.dt_vendor_first_reported);
    SELF := l;
	END;

	pIRSNonP_dist   := DISTRIBUTE(pIRSNonP,
						         HASH(company_address.zip, TRIM(company_address.prim_name), TRIM(company_address.prim_range),
                     TRIM(company_name), TRIM(contact_name.lname)));

  sIRSNonP := SORT(pIRSNonP_dist, company_address.zip, company_address.prim_name, company_address.prim_range,
                                  company_name, company_address.sec_range, contact_name.lname,
                                  contact_name.fname, contact_name.mname, contact_name.name_suffix, LOCAL);

	rIRSNonP := ROLLUP(sIRSNonP,
						         LEFT.company_address.zip = RIGHT.company_address.zip AND
						         LEFT.company_address.prim_name = RIGHT.company_address.prim_name AND
						         LEFT.company_address.prim_range = RIGHT.company_address.prim_range AND
						         LEFT.company_name = RIGHT.company_name AND
						         (RIGHT.company_address.sec_range = '' OR
                     LEFT.company_address.sec_range = RIGHT.company_address.sec_range) AND
                     LEFT.contact_name.fname = RIGHT.contact_name.fname AND
                     LEFT.contact_name.mname = RIGHT.contact_name.mname AND
                     LEFT.contact_name.lname = RIGHT.contact_name.lname AND
                     LEFT.contact_name.name_suffix = RIGHT.contact_name.name_suffix,
						         RollupBL(LEFT, RIGHT),
						         LOCAL);

	RETURN rIRSNonP(company_name != '');

END;