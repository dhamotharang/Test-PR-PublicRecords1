﻿//In this attribute National Accidents Inquiry (CRU Inquiries) data is consolidated for eCrash build.

IMPORT PromoteSupers, Std, FLAccidents_Ecrash;

	NtlAccidentsInquiry := FLAccidents_Ecrash.File_CRU_inquiries;
	
	Layout_NtlAccidentsInquiry.ConsolidationBase tNtlAccidentsInquiry(NtlAccidentsInquiry L, UNSIGNED1 cnt) := TRANSFORM
		SELF.report_code := 'I'+ L.report_code;
		SELF.report_category := L.report_category;
		SELF.report_code_desc := L.report_code_desc;
		SELF.accident_nbr := IF(L.vehicle_incident_id[1..3] = 'OID',
														(STRING40)((UNSIGNED6)L.vehicle_incident_id[4..] + 100000000000),
														(STRING40)((UNSIGNED6)L.vehicle_incident_id + 10000000000));
		SELF.accident_date := mod_Utilities.ConvertSlashedMDYtoCYMD(L.loss_date[1..10]);
		SELF.accident_location := MAP(L.cross_street <> '' AND L.cross_street <> 'N/A' => L.street + ' & ' + L.cross_street, L.street);
		SELF.accident_street := L.street;
		SELF.accident_cross_street := MAP(L.cross_street <> 'N/A' => L.cross_street, '');
		SELF.jurisdiction := STD.Str.ToUpperCase(TRIM(L.EDIT_AGENCY_NAME, LEFT, RIGHT));
		SELF.jurisdiction_state := STD.Str.ToUpperCase(L.State);
		SELF.st := IF(L.st = '', SELF.jurisdiction_state, L.st);
		SELF.jurisdiction_nbr := L.AGENCY_ID;
		SELF.cru_jurisdiction := STD.Str.ToUpperCase(TRIM(L.EDIT_AGENCY_NAME, LEFT, RIGHT));
		SELF.cru_jurisdiction_nbr := L.AGENCY_ID + '_' + L.STATE_NBR; 
		SELF.vehicle_incident_city := STD.Str.ToUpperCase(L.city);
		SELF.vehicle_incident_st := STD.Str.ToUpperCase(L.state);
		SELF.did := CHOOSE(cnt, IF(L.did = 0, '000000000000', INTFORMAT(L.did, 12, 1)), '000000000000', '000000000000');	
		SELF.prim_range := CHOOSE(cnt, L.prim_range, '', ''); 
		SELF.predir := CHOOSE(cnt, L.predir, '', '');
		SELF.prim_name := CHOOSE(cnt, L.prim_name, '', '');
		SELF.postdir := CHOOSE(cnt, L.postdir, '', '');
		SELF.unit_desig := CHOOSE(cnt, L.unit_desig, '', '');
		SELF.sec_range := CHOOSE(cnt, L.sec_range, '', '');
		SELF.v_city_name := CHOOSE(cnt, L.v_city_name, '', '');
		SELF.zip4 := CHOOSE(cnt, L.zip4, '', '');
		SELF.addr_suffix := CHOOSE(cnt, L.suffix, '', '');
		SELF.zip := CHOOSE(cnt, L.zip5, '', '');
		SELF.record_type :=	CHOOSE(cnt, 'Vehicle Driver', '', '');
		SELF.driver_license_nbr := CHOOSE(cnt, IF(REGEXFIND('[0-9]', L.drivers_license), L.drivers_license, ''), '', '');
		SELF.dlnbr_st := CHOOSE(cnt, L.drivers_license_st, '', '');
		SELF.tag_nbr := CHOOSE(cnt, L.otag, '', '');
		SELF.tagnbr_st := CHOOSE(cnt, L.otag_state, '', '');
		SELF.vin :=	CHOOSE(cnt, L.vin, '', '');
		SELF.title := CHOOSE(cnt, L.title, L.title2, L.title3); 
		SELF.name_suffix := CHOOSE(cnt, L.name_suffix, L.name_suffix2, L.name_suffix3); 
		SELF.fname :=	CHOOSE(cnt, L.fname, L.fname2, L.fname3); 
		SELF.lname := CHOOSE(cnt, L.lname, L.lname2, L.lname3); 
		SELF.mname :=	CHOOSE(cnt, L.mname, L.mname2, L.mname3);
		t_orig_fname2 := IF(TRIM(L.orig_fname2 , LEFT, RIGHT)IN ['UNK' , 'UNKNOWN' , 'UNK MALE' ], '', L.orig_fname2); 
		t_orig_lname2 := IF(TRIM(L.orig_lname2 , LEFT, RIGHT)IN ['UNK' , 'UNKNOWN' , 'UNK MALE' ], '', L.orig_lname2);
		f_orig_lname2 := IF(REGEXFIND('[0-9]', t_orig_lname2) = true, '', t_orig_lname2); 
		t_orig_fname3 := IF(TRIM(L.orig_fname3 , LEFT, RIGHT)IN ['UNK' , 'UNKNOWN' , 'UNK MALE' ], '', L.orig_fname3); 
		t_orig_lname3 := IF(TRIM(L.orig_lname3 , LEFT, RIGHT)IN ['UNK' , 'UNKNOWN' , 'UNK MALE' ], '', L.orig_lname3); 
		f_orig_lname3 := IF(REGEXFIND('[0-9]', t_orig_lname3) = TRUE, '', t_orig_lname3);
		SELF.orig_fname := CHOOSE(cnt, L.orig_fname, IF(TRIM(t_orig_fname2, LEFT, RIGHT) = '' AND TRIM(f_orig_lname2, LEFT, RIGHT) = '', SKIP, t_orig_fname2), IF(TRIM(t_orig_fname3, LEFT, RIGHT) ='' AND TRIM(f_orig_lname3, LEFT, RIGHT) ='',SKIP,t_orig_fname3)); 
		SELF.orig_lname := CHOOSE(cnt,L.orig_lname,f_orig_lname2, f_orig_lname3); 
		SELF.orig_mname := CHOOSE(cnt,L.orig_mname,L.orig_mname2, L.orig_mname3); 
		SELF.DOB :=	CHOOSE(cnt, L.DOB_1, '', '');
		SELF.vehicle_year := CHOOSE(cnt, L.Year, '', '');
		SELF.vehicle_make := CHOOSE(cnt, L.make, '', '');
		SELF.make_description := CHOOSE(cnt, IF(L.make_description <> '', L.make_description, L.Make), '', '');
		SELF.model_description := CHOOSE(cnt, IF(L.model_description <> '', L.model_description, L.Model), '', '');
		SELF.carrier_name := CHOOSE(cnt, L.legal_name, '', '');
		SELF.ssn :=	CHOOSE(cnt, L.ssn_1, '', '');
		SELF.vehicle_status := CHOOSE(cnt, L.vehicle_status, '', '');
		SELF.vehicle_seg := CHOOSE(cnt, L.vehicle_seg, '', '');
		SELF.vehicle_seg_type := CHOOSE(cnt, L.vehicle_seg_type, '', '');
		SELF.model_year := CHOOSE(cnt, L.model_year, '', '');
		SELF.body_style_code := CHOOSE(cnt, L.body_style_code, '', '');
		SELF.engine_size := CHOOSE(cnt, L.engine_size, '', '');
		SELF.fuel_code := CHOOSE(cnt, L.fuel_code, '', '');
		SELF.number_of_driving_wheels := CHOOSE(cnt, L.number_of_driving_wheels, '', '');
		SELF.steering_type := CHOOSE(cnt, L.steering_type, '', '');
		SELF.vina_series := CHOOSE(cnt, L.vina_series, '', '');
		SELF.vina_model := CHOOSE(cnt, L.vina_model, '', '');
		SELF.vina_make := CHOOSE(cnt, L.vina_make, '', '');
		SELF.vina_body_style := CHOOSE(cnt, L.vina_body_style, '', '');
		SELF.series_description := CHOOSE(cnt, L.series_description, '', '');
		SELF.car_cylinders := CHOOSE(cnt, L.car_cylinders, '', '');
		SELF.Report_Has_Coversheet := '0';
		SELF.cru_order_id := L.order_id; 
		SELF.cru_sequence_nbr := L.sequence_nbr; 
		SELF.date_vendor_last_reported := L.last_changed;
		SELF.creation_date := ''; 
		SELF.report_type_id := L.service_id;
		SELF.addl_report_number := L.REPORT_NBR;
		SELF.acct_nbr := L.acct_nbr; 
		SELF.CRU_inq_name_type := CHOOSE(cnt, '1', '2', '3');
		SELF.reason_id := L.reason_id; 
		SELF.agency_id := L.agency_id;
		SELF := L;
		SELF := [];
	END;
  NtlAccidentsInquiryConsolidationBase := NORMALIZE(NtlAccidentsInquiry, 3, tNtlAccidentsInquiry(LEFT, COUNTER));

EXPORT Map_NtlAccidentsInquiry_Consolidation := NtlAccidentsInquiryConsolidationBase;