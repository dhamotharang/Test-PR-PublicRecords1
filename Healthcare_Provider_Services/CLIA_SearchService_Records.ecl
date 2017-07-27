import Autokey_batch, AutokeyB2, BatchServices, CLIA, codes;

EXPORT CLIA_SearchService_Records(dataset(Healthcare_Provider_Services.CLIA_Layouts.batch_in) ds_batch_in,
														CLIA_Interfaces.clia_config in_mod) := MODULE

		//Call autokeys
		clia_constants := CLIA._Constants();
		ak_config_data := MODULE(BatchServices.Interfaces.i_AK_Config)
			export workHard        := TRUE; // for Autokey_batch.Fetch_Address_Batch to run at all.
			export useAllLookups   := TRUE; // for Autokey_batch.Fetch_SSN_Batch to run SSN2 key. SSN key is empty.
			export isTestHarness   := FALSE;
			export PenaltThreshold := 100;
			export skip_set        := clia_constants.AUTOKEY_SKIP_SET;
		END;
		
		shared ds_fids := Autokey_batch.get_fids(project(ds_batch_in,Autokey_batch.Layouts.rec_inBatchMaster), clia_constants.AUTOKEY_NAME, ak_config_data);
		shared ds_byak_raw := join(ds_fids,clia.Key_Autokey_Payload,left.id=right.fakeid,limit(Healthcare_Provider_Services.Constants.MAX_RECS_ON_JOIN));
		Healthcare_Provider_Services.CLIA_Layouts.batch_out xformByAK(recordof(ds_byak_raw) f) := transform
				self.acctno:=f.acctno;
				self.seq:=0;
				self.clia_number:=f.clia_number;
				self.did:=f.did;
				self.bdid:=f.bdid;
				self.bdid_score:=f.bdid_score;
				self.term_code:=if(f.lab_term_code = '00','',f.lab_term_code);
				self.term_code_desc := '';
				self.certificate_type:=f.certificate_type;
				self.expiration_date:=f.expiration_date;
				self.record_type:=if(f.record_type='C',f.record_type,skip);
				self.lab_type:=f.lab_type;
				self.facility_name:=f.facility_name;
				self.facility_name2:=f.facility_name2;
				self.address1:=f.address1;
				self.address2:=f.address2;
				self.city:=f.city;
				self.state:=f.state;
				self.zip:=f.zip;
				self.zip4:=f.zip4;
				self.facility_phone:=f.facility_phone;
				self.dt_vendor_first_reported:=f.dt_vendor_first_reported;
				self.dt_vendor_last_reported:=f.dt_vendor_last_reported;
				self.raw_aid:=f.raw_aid;
				self.ace_aid:=f.ace_aid;
				// self.clean_company_address:=f.clean_company_address;
				// self.clean_phones:=f.clean_phones;
				SELF.clean_company_address_prim_range:=f.clean_company_address.prim_range;
				SELF.clean_company_address_predir:=f.clean_company_address.predir;
				SELF.clean_company_address_prim_name:=f.clean_company_address.prim_name;
				SELF.clean_company_address_addr_suffix:=f.clean_company_address.addr_suffix;
				SELF.clean_company_address_postdir:=f.clean_company_address.postdir;
				SELF.clean_company_address_unit_desig:=f.clean_company_address.unit_desig;
				SELF.clean_company_address_sec_range:=f.clean_company_address.sec_range;
				SELF.clean_company_address_p_city_name:=f.clean_company_address.p_city_name;
				SELF.clean_company_address_v_city_name:=f.clean_company_address.v_city_name;
				SELF.clean_company_address_st:=f.clean_company_address.st;
				SELF.clean_company_address_zip:=f.clean_company_address.zip;
				SELF.clean_company_address_zip4:=f.clean_company_address.zip4;
				SELF.clean_company_address_cart:=f.clean_company_address.cart;
				SELF.clean_company_address_cr_sort_sz:=f.clean_company_address.cr_sort_sz;
				SELF.clean_company_address_lot:=f.clean_company_address.lot;
				SELF.clean_company_address_lot_order:=f.clean_company_address.lot_order;
				SELF.clean_company_address_dbpc:=f.clean_company_address.dbpc;
				SELF.clean_company_address_chk_digit:=f.clean_company_address.chk_digit;
				SELF.clean_company_address_rec_type:=f.clean_company_address.rec_type;
				SELF.clean_company_address_fips_state:=f.clean_company_address.fips_state;
				SELF.clean_company_address_fips_county:=f.clean_company_address.fips_county;
				SELF.clean_company_address_geo_lat:=f.clean_company_address.geo_lat;
				SELF.clean_company_address_geo_long:=f.clean_company_address.geo_long;
				SELF.clean_company_address_msa:=f.clean_company_address.msa;
				SELF.clean_company_address_geo_blk:=f.clean_company_address.geo_blk;
				SELF.clean_company_address_geo_match:=f.clean_company_address.geo_match;
				SELF.clean_company_address_err_stat:=f.clean_company_address.err_stat;
				SELF.clean_phones_phone:=f.clean_phones.phone;
		end;
		export ds_byak := project(ds_byak_raw, xformByAK(left));
		
		//join with bdid
		shared ds_byBdid_raw := join(ds_batch_in,clia.Keys().bdid.qa,left.bdid=right.bdid,limit(Healthcare_Provider_Services.Constants.MAX_RECS_ON_JOIN));
		Healthcare_Provider_Services.CLIA_Layouts.batch_out xformByBDID(recordof(ds_byBdid_raw) f) := transform
				self.acctno:=f.acctno;
				self.seq:=0;
				self.clia_number:=f.clia_number;
				self.did:=f.did;
				self.bdid:=f.bdid;
				self.bdid_score:=f.bdid_score;
				self.term_code:=if(f.lab_term_code = '00','',f.lab_term_code);
				self.term_code_desc := '';
				self.certificate_type:=f.certificate_type;
				self.expiration_date:=f.expiration_date;
				self.record_type:=if(f.record_type='C',f.record_type,skip);
				self.lab_type:=f.lab_type;
				self.facility_name:=f.facility_name;
				self.facility_name2:=f.facility_name2;
				self.address1:=f.address1;
				self.address2:=f.address2;
				self.city:=f.city;
				self.state:=f.state;
				self.zip:=f.zip;
				self.zip4:=f.zip4;
				self.facility_phone:=f.facility_phone;
				self.dt_vendor_first_reported:=f.dt_vendor_first_reported;
				self.dt_vendor_last_reported:=f.dt_vendor_last_reported;
				self.raw_aid:=f.raw_aid;
				self.ace_aid:=f.ace_aid;
				// self.clean_company_address:=f.clean_company_address;
				// self.clean_phones:=f.clean_phones;		
        SELF.clean_company_address_prim_range:=f.clean_company_address.prim_range;
				SELF.clean_company_address_predir:=f.clean_company_address.predir;
				SELF.clean_company_address_prim_name:=f.clean_company_address.prim_name;
				SELF.clean_company_address_addr_suffix:=f.clean_company_address.addr_suffix;
				SELF.clean_company_address_postdir:=f.clean_company_address.postdir;
				SELF.clean_company_address_unit_desig:=f.clean_company_address.unit_desig;
				SELF.clean_company_address_sec_range:=f.clean_company_address.sec_range;
				SELF.clean_company_address_p_city_name:=f.clean_company_address.p_city_name;
				SELF.clean_company_address_v_city_name:=f.clean_company_address.v_city_name;
				SELF.clean_company_address_st:=f.clean_company_address.st;
				SELF.clean_company_address_zip:=f.clean_company_address.zip;
				SELF.clean_company_address_zip4:=f.clean_company_address.zip4;
				SELF.clean_company_address_cart:=f.clean_company_address.cart;
				SELF.clean_company_address_cr_sort_sz:=f.clean_company_address.cr_sort_sz;
				SELF.clean_company_address_lot:=f.clean_company_address.lot;
				SELF.clean_company_address_lot_order:=f.clean_company_address.lot_order;
				SELF.clean_company_address_dbpc:=f.clean_company_address.dbpc;
				SELF.clean_company_address_chk_digit:=f.clean_company_address.chk_digit;
				SELF.clean_company_address_rec_type:=f.clean_company_address.rec_type;
				SELF.clean_company_address_fips_state:=f.clean_company_address.fips_state;
				SELF.clean_company_address_fips_county:=f.clean_company_address.fips_county;
				SELF.clean_company_address_geo_lat:=f.clean_company_address.geo_lat;
				SELF.clean_company_address_geo_long:=f.clean_company_address.geo_long;
				SELF.clean_company_address_msa:=f.clean_company_address.msa;
				SELF.clean_company_address_geo_blk:=f.clean_company_address.geo_blk;
				SELF.clean_company_address_geo_match:=f.clean_company_address.geo_match;
				SELF.clean_company_address_err_stat:=f.clean_company_address.err_stat;
				SELF.clean_phones_phone:=f.clean_phones.phone;
		end;
		export ds_byBDID := project(ds_byBdid_raw, xformByBDID(left));

		//join with clia number
		shared ds_byCLIA_NBR_raw := join(ds_batch_in,clia.Keys().clia_number.qa,left.CLIANumber=right.clia_number,limit(Healthcare_Provider_Services.Constants.MAX_RECS_ON_JOIN));
		Healthcare_Provider_Services.CLIA_Layouts.batch_out xformByCLIA_NBR(recordof(ds_byCLIA_NBR_raw) f) := transform
				self.acctno:=f.acctno;
				self.seq:=0;
				self.clia_number:=f.clia_number;
				self.did:=f.did;
				self.bdid:=f.bdid;
				self.bdid_score:=f.bdid_score;
				self.term_code:=if(f.lab_term_code = '00','',f.lab_term_code);
				self.term_code_desc := '';
				self.certificate_type:=f.certificate_type;
				self.expiration_date:=f.expiration_date;
				self.record_type:=if(f.record_type='C',f.record_type,skip);
				self.lab_type:=f.lab_type;
				self.facility_name:=f.facility_name;
				self.facility_name2:=f.facility_name2;
				self.address1:=f.address1;
				self.address2:=f.address2;
				self.city:=f.city;
				self.state:=f.state;
				self.zip:=f.zip;
				self.zip4:=f.zip4;
				self.facility_phone:=f.facility_phone;
				self.dt_vendor_first_reported:=f.dt_vendor_first_reported;
				self.dt_vendor_last_reported:=f.dt_vendor_last_reported;
				self.raw_aid:=f.raw_aid;
				self.ace_aid:=f.ace_aid;
				SELF.clean_company_address_prim_range:=f.clean_company_address.prim_range;
				SELF.clean_company_address_predir:=f.clean_company_address.predir;
				SELF.clean_company_address_prim_name:=f.clean_company_address.prim_name;
				SELF.clean_company_address_addr_suffix:=f.clean_company_address.addr_suffix;
				SELF.clean_company_address_postdir:=f.clean_company_address.postdir;
				SELF.clean_company_address_unit_desig:=f.clean_company_address.unit_desig;
				SELF.clean_company_address_sec_range:=f.clean_company_address.sec_range;
				SELF.clean_company_address_p_city_name:=f.clean_company_address.p_city_name;
				SELF.clean_company_address_v_city_name:=f.clean_company_address.v_city_name;
				SELF.clean_company_address_st:=f.clean_company_address.st;
				SELF.clean_company_address_zip:=f.clean_company_address.zip;
				SELF.clean_company_address_zip4:=f.clean_company_address.zip4;
				SELF.clean_company_address_cart:=f.clean_company_address.cart;
				SELF.clean_company_address_cr_sort_sz:=f.clean_company_address.cr_sort_sz;
				SELF.clean_company_address_lot:=f.clean_company_address.lot;
				SELF.clean_company_address_lot_order:=f.clean_company_address.lot_order;
				SELF.clean_company_address_dbpc:=f.clean_company_address.dbpc;
				SELF.clean_company_address_chk_digit:=f.clean_company_address.chk_digit;
				SELF.clean_company_address_rec_type:=f.clean_company_address.rec_type;
				SELF.clean_company_address_fips_state:=f.clean_company_address.fips_state;
				SELF.clean_company_address_fips_county:=f.clean_company_address.fips_county;
				SELF.clean_company_address_geo_lat:=f.clean_company_address.geo_lat;
				SELF.clean_company_address_geo_long:=f.clean_company_address.geo_long;
				SELF.clean_company_address_msa:=f.clean_company_address.msa;
				SELF.clean_company_address_geo_blk:=f.clean_company_address.geo_blk;
				SELF.clean_company_address_geo_match:=f.clean_company_address.geo_match;
				SELF.clean_company_address_err_stat:=f.clean_company_address.err_stat;
				SELF.clean_phones_phone:=f.clean_phones.phone;
		end;
		export ds_byCLIA_NBR := project(ds_byCLIA_NBR_raw, xformByCLIA_NBR(left));
	
		//Collect all records filtered by best criteria and pass the no hits to the next best criteria
		inputMatchedbyBDID := join(ds_batch_in,ds_byBDID,left.acctno=right.acctno,transform(Healthcare_Provider_Services.CLIA_Layouts.batch_out_penalty,self._bdid:=left.bdid; self :=right; self:=left;));
		NoHitsbyBDID := join(ds_batch_in,inputMatchedbyBDID,left.acctno=right.acctno,left only);
		inputMatchedbyClia := join(NoHitsbyBDID,ds_byCLIA_NBR,left.acctno=right.acctno,transform(Healthcare_Provider_Services.CLIA_Layouts.batch_out_penalty,self._bdid:=left.bdid; self :=right; self:=left;));
		NoHitsbyClia := join(NoHitsbyBDID,inputMatchedbyClia,left.acctno=right.acctno,left only);
		inputMatchedbyak := join(NoHitsbyClia,ds_byak,left.acctno=right.acctno,transform(Healthcare_Provider_Services.CLIA_Layouts.batch_out_penalty,self._bdid:=left.bdid; self :=right; self:=left;));
		
		//Collect all hits
		rec_combined := join(inputMatchedbyBDID+inputMatchedbyClia+inputMatchedbyak,Codes.Key_Codes_V3,
												keyed(right.file_name = 'CLIA_LAB_TYPE') and keyed(right.field_name = 'TERMINATION_CODE') and left.term_code = right.code,
												transform(Healthcare_Provider_Services.CLIA_Layouts.batch_out_penalty,self.term_code_desc:=right.long_desc;self:=left), left outer);
		//Penalize results
		rec_penalty := Healthcare_Provider_Services.Functions.apply_penalty_clia(rec_combined);
		// Filter out records with too high a penalty
		rec_keep := sort(rec_penalty(record_penalty < in_mod.penalty_threshold),record_penalty,-dt_vendor_last_reported);
		// Slim down results to not have penalty related fields
		rec_final := project(rec_keep,Healthcare_Provider_Services.CLIA_Layouts.batch_out);
		
		export records:=rec_final;

end;