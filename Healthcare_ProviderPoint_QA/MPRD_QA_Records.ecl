import MPRD.layouts as L;
import STD;

EXPORT MPRD_QA_Records(string source_date) := module
	
	//  Files with isTest flag
	SHARED individual := '~thor_data400::in::mprd::individual::' + source_date;
	SHARED facility := '~thor_data400::in::mprd::facility::' + source_date;
	SHARED basc_cp := '~thor_data400::in::mprd::basc_cp::' + source_date;
	SHARED basc_deceased := '~thor_data400::in::mprd::basc_deceased::' + source_date;
	SHARED basc_facility_mme := '~thor_data400::in::mprd::basc_facility_mme::' + source_date;
	SHARED best_hospital := '~thor_data400::in::mprd::best_hospital::' + source_date;
	SHARED claims_addr_master := '~thor_data400::in::mprd::claims_addr_master::' + source_date;
	SHARED claims_by_month := '~thor_data400::in::mprd::claims_by_month::' + source_date;
	SHARED cms_ecp := '~thor_data400::in::mprd::cms_ecp::' + source_date;
	SHARED group_lu := '~thor_data400::in::mprd::group_lu::' + source_date;
	SHARED hospital_lu := '~thor_data400::in::mprd::hospital_lu::' + source_date;
	SHARED lic_filedate := '~thor_data400::in::mprd::lic_filedate::' + source_date;
	SHARED nanpa := '~thor_data400::in::mprd::nanpa::' + source_date;
	SHARED npi_extension := '~thor_data400::in::mprd::npi_extension::' + source_date;
	SHARED npi_extension_facility := '~thor_data400::in::mprd::npi_extension_facility::' + source_date;
	SHARED npi_tin_xref := '~thor_data400::in::mprd::npi_tin_xref::' + source_date;
	SHARED office_attributes := '~thor_data400::in::mprd::office_attributes::' + source_date;
	SHARED office_attributes_facility := '~thor_data400::in::mprd::office_attributes_facility::' + source_date;
	SHARED opi := '~thor_data400::in::mprd::opi::' + source_date;
	SHARED opi_facility := '~thor_data400::in::mprd::opi_facility::' + source_date;
	SHARED source_confidence_lu := '~thor_data400::in::mprd::source_confidence_lu::' + source_date;

 // Function to convert dates
 // usage := output(subtract_days(today, 30));
	SHARED subtract_days(STD.Date.Date_t date_in, integer2 days) := function

		x := 0 - days;
		y := STD.Date.AdjustDate(date_in,,,x);
		z :=  STD.Date.DateToString(y);
		return z;

	end;
 
	shared today := STD.Date.CurrentDate();
 
 /*****************************************************************************
	INDIVIDUAL DATA
*****************************************************************************/

// give us some records we can play with later...no NPI that ends in 9
	shared raw_idv := dataset(individual, L.individual_in, CSV(SEPARATOR('|')));
	shared sort_idv := distribute(sort(raw_idv, group_key), hash32(group_key));
	shared filter_idv := sort_idv((filecode = 'NPI_IDV' or filecode = 'NPI_RET') AND npi_num[10] = '9');

	shared filter_rec := record
		string38 group_key := raw_idv.group_key;
	end;

	shared filter_rec_npi := record
		string10 npi_num := raw_idv.npi_num;
	end;
	
	shared filter_idv_gk := distribute(sort(table(filter_idv, filter_rec), group_key), hash32(group_key)) : INDEPENDENT;
	shared filter_idv_npi := sort(table(filter_idv, filter_rec_npi), npi_num) : INDEPENDENT;

	// Make t_basc_deceased records
	EXPORT t_basc_deceased := module
		shared raw_x := sort(dataset(basc_deceased, L.basc_deceased_in, CSV(SEPARATOR('|'))), group_key) : INDEPENDENT;
		 
		shared L.basc_deceased_in set_test_flag(L.basc_deceased_in l) := transform
				self.istest := true;
				self := l;
		end;

		shared L.basc_deceased_in set_deceased(L.individual_in l, string10 birth_date, string10 death_date) := transform
				self.istest := true;
				self.birthdate := birth_date;
				self.date_of_death := death_date;
				self.incomplete_birthdate := '';
				self.incomplete_date_of_death := '';
				self := l;
		end;
 
		shared mprd_ds := sort(join(raw_x, filter_idv_gk, left.group_key = right.group_key, set_test_flag(left), left only), group_key);

		shared dec_1 := project(raw_idv(npi_num = '1174936439' and filecode = 'NPI_IDV'), set_deceased(left, '1965-08-08', subtract_days(today,1)));
		shared dec_2 := project(raw_idv(npi_num = '1477895639' and filecode = 'NPI_IDV'), set_deceased(left, '1965-08-08', subtract_days(today,1)));

		shared dec_ds := dec_1 + dec_2;
		shared base_ds := mprd_ds + dec_ds;

		export view := base_ds;
		export write := output(base_ds,, '~thor_data400::in::mprd::QA::basc_deceased' ,csv( separator('|'),heading(0), terminator(['\n', '\r\n']),QUOTE('')), UPDATE);

	END;	

	// Make Choicepoint records
	EXPORT t_basc_cp := module
		raw_x := sort(dataset(basc_cp, L.choice_point_in, CSV(SEPARATOR('|'))), group_key) : INDEPENDENT;
		 
		L.choice_point_in set_test_flag(L.choice_point_in l) := transform
				self.istest := true;
				self := l;
		end;

		shared base_ds := sort(join(raw_x, filter_idv_gk, left.group_key = right.group_key, set_test_flag(left), left only), group_key);

		export view := base_ds;
		export write := output(base_ds,, '~thor_data400::in::mprd::QA::basc_cp' ,csv( separator('|'),heading(0), terminator(['\n', '\r\n']),QUOTE('')), UPDATE);
		
	END;	

	// Make Claims_addr_master records
	EXPORT t_claims_addr_master := module
		raw_x := dataset(claims_addr_master, L.claims_address_master_in, CSV(SEPARATOR('|'))) : INDEPENDENT;
		 
		L.claims_address_master_in set_test_flag(L.claims_address_master_in l) := transform
				self.istest := true;
				self := l;
		end;

		shared base_ds := project(raw_x, set_test_flag(left));

		export view := base_ds;
		export write := output(base_ds,, '~thor_data400::in::mprd::QA::claims_addr_master' ,csv( separator('|'),heading(0), terminator(['\n', '\r\n']),QUOTE('')), UPDATE);
		
	END;	

	// Make claims_by_month records
	EXPORT t_claims_by_month := module
		raw_x := dataset(claims_by_month, L.claims_by_month_in, CSV(SEPARATOR('|'))) : INDEPENDENT;
		 
		L.claims_by_month_in set_test_flag(L.claims_by_month_in l) := transform
				self.istest := true;
				self := l;
		end;

		shared base_ds := project(raw_x, set_test_flag(left));

		export view := base_ds;
		export write := output(base_ds,, '~thor_data400::in::mprd::QA::claims_by_month' ,csv( separator('|'),heading(0), terminator(['\n', '\r\n']),QUOTE('')), UPDATE);
		
	END;	

	// Make npi_extension records
	EXPORT t_npi_extension := module
		raw_x := sort(dataset(npi_extension, L.npi_extension_in, CSV(SEPARATOR('|'))), npi_num) : INDEPENDENT;
		 
		L.npi_extension_in set_test_flag(L.npi_extension_in l) := transform
				self.istest := true;
				self := l;
		end;

		shared base_ds := sort(join(raw_x, filter_idv_npi, left.npi_num = right.npi_num, set_test_flag(left), left only), npi_num);

		export view := base_ds;
		export write := output(base_ds,, '~thor_data400::in::mprd::QA::npi_extension' ,csv( separator('|'),heading(0), terminator(['\n', '\r\n']),QUOTE('')), UPDATE);

	END;	

	// Make office_attributes records
	// ties to individual by surrogate_key
	EXPORT t_office_attributes := module
		raw_x := dataset(office_attributes, L.office_attributes_in, CSV(SEPARATOR('|'))) : INDEPENDENT;
		 
		L.office_attributes_in set_test_flag(L.office_attributes_in l) := transform
				self.istest := true;
				self := l;
		end;

		shared base_ds := project(raw_x, set_test_flag(left));

		export view := base_ds;
		export write := output(base_ds,, '~thor_data400::in::mprd::QA::office_attributes' ,csv( separator('|'),heading(0), terminator(['\n', '\r\n']),QUOTE('')), UPDATE);
		
	END;	
	
	// Make opi records
	// ties to individual by npi_num
	EXPORT t_opi := module
		raw_x := dataset(opi, L.opi_in, CSV(SEPARATOR('|'))) : INDEPENDENT;
		 
		L.opi_in set_test_flag(L.opi_in l) := transform
				self.istest := true;
				self := l;
		end;

		shared base_ds := project(raw_x, set_test_flag(left));

		export view := base_ds;
		export write := output(base_ds,, '~thor_data400::in::mprd::QA::opi' ,csv( separator('|'),heading(0), terminator(['\n', '\r\n']),QUOTE('')), UPDATE);
		
	END;	
	
	// Make individual records
	EXPORT t_individual := module

		shared L.individual_in set_test_flag(L.individual_in l) := transform
				self.istest := true;
				self := l;
		end;

		shared L.individual_in set_ska_lops(L.individual_in l, string38 sk, string10 date_val) := transform
				self.istest := true;
				self.filecode := 'SKA_LOPS';
				self.surrogate_key := sk;
				self.prac1_st := 327680;  // reference practice address and phone verified
				self.prac_phone1_st := 16704;  // reference prac phone and phone verified
				self.last_update_date := date_val;
				self := l;
		end;
 
 		shared mprd_ds := sort(join(raw_idv, filter_idv_gk, left.group_key = right.group_key, set_test_flag(left), left only), group_key);
 
		// 13993180752742700000000023069200000000  NPI 1174936439
		shared npi_1 := project(raw_idv(npi_num = '1174936439' and filecode = 'NPI_IDV'), set_test_flag(left));
		// 13651030882191000000000000019900000000 NPI 1477895639
    shared npi_2 := project(raw_idv(npi_num = '1477895639' and filecode = 'NPI_IDV'), set_test_flag(left));

		// SKA_LOPS
		shared ska_1 := project(raw_idv(npi_num = '1174936439' and filecode = 'NPI_IDV'), set_ska_lops(left, '77700000000000000000000000000000100001', subtract_days(today,1)));
		shared ska_2 := project(raw_idv(npi_num = '1477895639' and filecode = 'NPI_IDV'), set_ska_lops(left, '77700000000000000000000000000000100002', subtract_days(today,90)));

		shared npi := npi_1 + npi_2;
		shared ska := ska_1 + ska_2;
		shared base_ds := mprd_ds + ska + npi;


		export view := base_ds;
		export write := output(base_ds,, '~thor_data400::in::mprd::QA::individual' ,csv( separator('|'),heading(0), terminator(['\n', '\r\n']),QUOTE('')), UPDATE);
		
	END;	




/*****************************************************************************
	FACILITY DATA
*****************************************************************************/

	shared raw_fac := dataset(facility, L.facility_in, CSV(SEPARATOR('|')));
	shared sort_fac := distribute(sort(raw_fac, group_key), hash32(group_key));
	shared filter_fac := sort_fac((filecode = 'NPI_FAC' OR filecode = 'NPI_FRET') AND npi_num[10] = '9');

	shared filter_rec_fac := record
		string38 group_key := raw_fac.group_key;
	end;

	shared filter_rec_fac_npi := record
		string10 npi_num := raw_fac.npi_num;
	end;
	
	shared filter_fac_gk := distribute(sort(table(filter_fac, filter_rec_fac), group_key), hash32(group_key)) : INDEPENDENT;
	shared filter_fac_npi := sort(table(filter_fac, filter_rec_fac_npi), npi_num) : INDEPENDENT;
	

	// Make basc_facility_mme records
	EXPORT t_basc_facility_mme := module
		raw_x := sort(dataset(basc_facility_mme, L.basc_facility_mme_in, CSV(SEPARATOR('|'))), group_key) : INDEPENDENT;
		 
		L.basc_facility_mme_in set_test_flag(L.basc_facility_mme_in l) := transform
				self.istest := true;
				self := l;
		end;

		shared base_ds := sort(join(raw_x, filter_fac_gk, left.group_key = right.group_key, set_test_flag(left), left only), group_key);

		export view := base_ds;
		export write := output(base_ds,, '~thor_data400::in::mprd::QA::basc_facility_mme' ,csv( separator('|'),heading(0), terminator(['\n', '\r\n']),QUOTE('')), UPDATE);

	END;	

	// Make best_hospital records
	EXPORT t_best_hospital := module
		raw_x := sort(dataset(best_hospital, L.best_hospital_in, CSV(SEPARATOR('|'))), group_key) : INDEPENDENT;
		 
		L.best_hospital_in set_test_flag(L.best_hospital_in l) := transform
				self.istest := true;
				self := l;
		end;

		shared base_ds := sort(join(raw_x, filter_fac_gk, left.group_key = right.group_key, set_test_flag(left), left only), group_key);

		export view := base_ds;
		export write := output(base_ds,, '~thor_data400::in::mprd::QA::best_hospital' ,csv( separator('|'),heading(0), terminator(['\n', '\r\n']),QUOTE('')), UPDATE);

	END;	

	// Make cms_ecp records
	// tied to facility by seq_num and filecode
	EXPORT t_cms_ecp := module
		raw_x := dataset(cms_ecp, L.cms_ecp_in, CSV(SEPARATOR('|'))) : INDEPENDENT;
		 
		L.cms_ecp_in set_test_flag(L.cms_ecp_in l) := transform
				self.istest := true;
				self := l;
		end;

		shared base_ds := project(raw_x, set_test_flag(left));

		export view := base_ds;
		export write := output(base_ds,, '~thor_data400::in::mprd::QA::cms_ecp' ,csv( separator('|'),heading(0), terminator(['\n', '\r\n']),QUOTE('')), UPDATE);

	END;	

	// Make npi_extension_facility records
	EXPORT t_npi_extension_facility := module
		raw_x := sort(dataset(npi_extension_facility, L.npi_extension_facility_in, CSV(SEPARATOR('|'))), npi_num) : INDEPENDENT;
		 
		L.npi_extension_facility_in set_test_flag(L.npi_extension_facility_in l) := transform
				self.istest := true;
				self := l;
		end;

		shared base_ds := sort(join(raw_x, filter_fac_npi, left.npi_num = right.npi_num, set_test_flag(left), left only), npi_num);

		export view := base_ds;
		export write := output(base_ds,, '~thor_data400::in::mprd::QA::npi_extension_facility' ,csv( separator('|'),heading(0), terminator(['\n', '\r\n']),QUOTE('')), UPDATE);

	END;	

	// Make office_attributes_facility records
	// ties to facility by surrogate_key
	EXPORT t_office_attributes_facility := module
		raw_x := dataset(office_attributes_facility, L.office_attributes_facility_in, CSV(SEPARATOR('|'))) : INDEPENDENT;
		 
		L.office_attributes_facility_in set_test_flag(L.office_attributes_facility_in l) := transform
				self.istest := true;
				self := l;
		end;

		shared mprd_ds := project(raw_x, set_test_flag(left));

		shared custom_ds := dataset([
		{'77700000000000000000000000000000000001', '0900', '0900', 0, '1700', '1700', 0, '', '', 2, '', '', 2, '0900', '0900', 0, '1700', '1700', 0, '', '', 2, '', '', 2, '0900', '0900', 0, '1500', '1500', 0, '', '', 2, '', '', 2, '0900', '0900', 0, '1700', '1700', 0, '', '', 2, '', '', 2, '0900', '0900', 0, '1500', '1500', 0, '', '', 2, '', '', 2, '0900', '0900', 0, '1700', '1700', 0, '', '', 2, '', '', 2, '0900', '0900', 0, '1700', '1700', 0, '', '', 2, '', '', 2, 1028, 1028, 0, '7', '7', 0, 'N', 'N', 0, 'Y', 'Y', 0, 'Y', 'Y', 0, 'RST_FAPP', true}, 
		{'77700000000000000000000000000000000002', '0830', '0830', 0, '1630', '1630', 0, '', '', 2, '', '', 2, '0830', '0830', 0, '1630', '1630', 0, '', '', 2, '', '', 2, '0830', '0830', 0, '1630', '1630', 0, '', '', 2, '', '', 2, '0830', '0830', 0, '1630', '1630', 0, '', '', 2, '', '', 2, '0830', '0830', 0, '1630', '1630', 0, '', '', 2, '', '', 2, '0830', '0830', 0, '1630', '1630', 0, '', '', 2, '', '', 2, '', '', 0, '', '', 0, '', '', 2, '', '', 2, 8191, 8191, 0, '40', '40', 0, 'Y', 'Y', 0, 'Y', 'Y', 0, 'Y', 'Y', 0, 'RST_FAPP', true},
		{'77700000000000000000000000000000000003', '0900', '0900', 0, '1600', '1600', 0, '', '', 2, '', '', 2, '0900', '0900', 0, '1600', '1600', 0, '', '', 2, '', '', 2, '0900', '0900', 0, '1600', '1600', 0, '', '', 2, '', '', 2, '0900', '0900', 0, '1600', '1600', 0, '', '', 2, '', '', 2, '0900', '0900', 0, '1600', '1600', 0, '', '', 2, '', '', 2, '0900', '0900', 0, '1600', '1600', 0, '', '', 2, '', '', 2, '0900', '0900', 0, '1600', '1600', 0, '', '', 2, '', '', 2, 1028, 1028, 0, '7', '7', 0, 'N', 'N', 0, 'Y', 'Y', 0, 'Y', 'N', 0, 'RST_FAPP', true}, 
		{'77700000000000000000000000000000000004', '0830', '0830', 0, '1700', '1700', 0, '', '', 2, '', '', 2, '0830', '0830', 0, '1700', '1700', 0, '', '', 2, '', '', 2, '0830', '0830', 0, '1700', '1700', 0, '', '', 2, '', '', 2, '0830', '0830', 0, '1700', '1700', 0, '', '', 2, '', '', 2, '0830', '0830', 0, '1700', '1700', 0, '', '', 2, '', '', 2, '0830', '0830', 0, '1700', '1700', 0, '', '', 2, '', '', 2, '', '', 0, '', '', 0, '', '', 2, '', '', 2, 8191, 8191, 0, '40', '40', 0, 'Y', 'Y', 0, 'Y', 'Y', 0, 'Y', 'N', 0, 'RST_FAPP', true},
		{'77700000000000000000000000000000000005', '0830', '0830', 0, '1800', '1800', 0, '1200', '1200', 0, '1300', '1300', 0, '0830', '0830', 0, '1800', '1800',  0, '1200', '1200', 0, '1300', '1300', 0, '0830', '0830', 0, '1800', '1800',  0, '1200', '1200', 0, '1300', '1300', 0, '0830', '0830', 0, '1800', '1800', 0, '1200', '1200', 0, '1300', '1300', 0, '0830', '0830', 0, '1800', '1800', 0, '1200', '1200', 0, '1300', '1300', 0, '0830', '0830', 0, '1700', '1700', 0, '1200', '1200', 0, '1300', '1300', 0, '0830', '0830', 0, '1700', '1700', 0, '1200', '1200', 0, '1300', '1300', 0, 8191, 8191, 0, '40', '40', 0, 'Y', 'Y', 0, 'Y', 'Y', 0, 'Y', 'N', 0, 'RST_FAPP', true},
		{'77700000000000000000000000000000000006', '0830', '0830', 0, '1630', '1630', 0, '', '', 2, '', '', 2, '0830', '0830', 0, '1630', '1630', 0, '', '', 2, '', '', 2, '0830', '0830', 0, '1630', '1630', 0, '', '', 2, '', '', 2, '0830', '0830', 0, '1630', '1630', 0, '', '', 2, '', '', 2, '0830', '0830', 0, '1630', '1630', 0, '', '', 2, '', '', 2, '0830', '0830', 0, '1630', '1630', 0, '', '', 2, '', '', 2, '', '', 0, '', '', 0, '', '', 2, '', '', 2, 8191, 8191, 0, '40', '40', 0, 'Y', 'Y', 0, 'Y', 'Y', 0, 'Y', 'Y', 0, 'SKA_GRP', true},
		{'77700000000000000000000000000000000007', '0900', '0900', 0, '1600', '1600', 0, '', '', 2, '', '', 2, '0900', '0900', 0, '1600', '1600', 0, '', '', 2, '', '', 2, '0900', '0900', 0, '1600', '1600', 0, '', '', 2, '', '', 2, '0900', '0900', 0, '1600', '1600', 0, '', '', 2, '', '', 2, '0900', '0900', 0, '1600', '1600', 0, '', '', 2, '', '', 2, '0900', '0900', 0, '1600', '1600', 0, '', '', 2, '', '', 2, '0900', '0900', 0, '1600', '1600', 0, '', '', 2, '', '', 2, 1028, 1028, 0, '7', '7', 0, 'N', 'N', 0, 'Y', 'Y', 0, 'Y', 'N', 0, 'SKA_GRP', true}, 
		{'77700000000000000000000000000000000008', '0830', '0830', 0, '1630', '1630', 0, '', '', 2, '', '', 2, '0830', '0830', 0, '1630', '1630', 0, '', '', 2, '', '', 2, '0830', '0830', 0, '1630', '1630', 0, '', '', 2, '', '', 2, '0830', '0830', 0, '1630', '1630', 0, '', '', 2, '', '', 2, '0830', '0830', 0, '1630', '1630', 0, '', '', 2, '', '', 2, '0830', '0830', 0, '1630', '1630', 0, '', '', 2, '', '', 2, '', '', 0, '', '', 0, '', '', 2, '', '', 2, 8191, 8191, 0, '40', '40', 0, 'Y', 'Y', 0, 'Y', 'Y', 0, 'Y', 'Y', 0, 'SKA_GRP', true},
		{'77700000000000000000000000000000000009', '0900', '0900', 0, '1600', '1600', 0, '', '', 2, '', '', 2, '0900', '0900', 0, '1600', '1600', 0, '', '', 2, '', '', 2, '0900', '0900', 0, '1600', '1600', 0, '', '', 2, '', '', 2, '0900', '0900', 0, '1600', '1600', 0, '', '', 2, '', '', 2, '0900', '0900', 0, '1600', '1600', 0, '', '', 2, '', '', 2, '0900', '0900', 0, '1600', '1600', 0, '', '', 2, '', '', 2, '0900', '0900', 0, '1600', '1600', 0, '', '', 2, '', '', 2, 1028, 1028, 0, '7', '7', 0, 'N', 'N', 0, 'Y', 'Y', 0, 'Y', 'N', 0, 'SKA_GRP', true} 
		], L.office_attributes_facility_in);

		shared base_ds := mprd_ds + custom_ds;

		export view := base_ds ;
		export write := output(base_ds,, '~thor_data400::in::mprd::QA::office_attributes_facility' ,csv( separator('|'),heading(0), terminator(['\n', '\r\n']),QUOTE('')), UPDATE);
		
	END;	
	
	// Make opi_facility records
	// ties to facility by npi_num
	EXPORT t_opi_facility := module
		raw_x := dataset(opi_facility, L.opi_facility_in, CSV(SEPARATOR('|'))) : INDEPENDENT;
		 
		L.opi_facility_in set_test_flag(L.opi_facility_in l) := transform
				self.istest := true;
				self := l;
		end;

		shared base_ds := project(raw_x, set_test_flag(left));

		export view := base_ds;
		export write := output(base_ds,, '~thor_data400::in::mprd::QA::opi_facility' ,csv( separator('|'),heading(0), terminator(['\n', '\r\n']),QUOTE('')), UPDATE);
		
	END;	
	
	// Make facility records
	EXPORT t_facility := module

		shared L.facility_in set_test_flag(L.facility_in l) := transform
				self.istest := true;
				self := l;
		end;

		shared mprd_ds := sort(join(raw_fac, filter_fac_gk, left.group_key = right.group_key, set_test_flag(left), left only), group_key);
		
		// Make RST_FAPP records
		// set of string38 gks := dataset([
												// {12801700521008400000000001735700000000}, // NPI 1295728269  RST1
												// {12001487082007700000000000950330863714}, // NPI 1548268519
												// {14532344810944600000000000556300000000}  // NPI 1013913169
												// ], filter_rec_fac);
												
		shared L.facility_in set_rst_fapp(L.facility_in l, string38 sk, string10 date_val) := transform
				self.istest := true;
				self.filecode := 'RST_FAPP';
				self.surrogate_key := sk;
				self.last_update_date := date_val;
				self := l;
		end;
   		
		shared L.facility_in set_ska_grp(L.facility_in l, string38 sk, string10 date_val) := transform
				self.istest := true;
				self.filecode := 'SKA_GRP';
				self.surrogate_key := sk;
				self.last_update_date := date_val;
				self.prac1_st := 327680;  // reference practice address and phone verified
				self.prac_phone1_st := 16704;  // reference prac phone and phone verified and area code not configured
				self.group_affiliation := 'GAS';
				self := l;
		end;
 
 // Create 3 roster records with different dates.
			// 12801700521008400000000001735700000000    NPI 1295728269  
			// multiple rst_fapp
    shared rst_1 := project(raw_fac(npi_num = '1295728269' and filecode = 'NPI_FAC'), set_rst_fapp(left, '77700000000000000000000000000000000001', '2015-01-01'));
    shared rst_2 := project(raw_fac(npi_num = '1295728269' and filecode = 'NPI_FAC'), set_rst_fapp(left, '77700000000000000000000000000000000002', '2015-05-05'));
    shared rst_3 := project(raw_fac(npi_num = '1295728269' and filecode = 'NPI_FAC'), set_rst_fapp(left, '77700000000000000000000000000000000003', '2015-12-12'));
		// 12001487082007700000000000950330863714 NPI 1548268519
		// ska_grp newer than rst_fapp
    shared rst_4 := project(raw_fac(npi_num = '1548268519' and filecode = 'NPI_FAC'), set_rst_fapp(left, '77700000000000000000000000000000000004', '2015-05-05'));
    shared sg1   := project(raw_fac(npi_num = '1548268519' and filecode = 'NPI_FAC'),  set_ska_grp(left, '77700000000000000000000000000000000006', '2015-09-09'));
		// 12001486852007700000000000563130863714 NPI 1013913169
		// rst_fapp newer than ska_grp (ska_grp trumps rst_fapp)
    shared rst_5 := project(raw_fac(npi_num = '1013913169' and filecode = 'NPI_FAC'), set_rst_fapp(left, '77700000000000000000000000000000000005', '2015-05-05'));
    shared sg2   := project(raw_fac(npi_num = '1013913169' and filecode = 'NPI_FAC'),  set_ska_grp(left, '77700000000000000000000000000000000007', '2015-02-02'));
		// 12001486712007700000000000363630863714  NPI 1699770909
		// multiple ska_recors 
		shared sg3 := project(raw_fac(npi_num = '1699770909' and filecode = 'NPI_FAC'), set_ska_grp(left, '77700000000000000000000000000000000008', '2015-02-02'));
    shared sg4 := project(raw_fac(npi_num = '1699770909' and filecode = 'NPI_FAC'), set_ska_grp(left, '77700000000000000000000000000000000009', '2015-08-08'));

    shared npi_1 := project(raw_fac(npi_num = '1295728269' and filecode = 'NPI_FAC'), set_test_flag(left));
    shared npi_2 := project(raw_fac(npi_num = '1548268519' and filecode = 'NPI_FAC'), set_test_flag(left));
    shared npi_3 := project(raw_fac(npi_num = '1013913169' and filecode = 'NPI_FAC'), set_test_flag(left));
    shared npi_4 := project(raw_fac(npi_num = '1699770909' and filecode = 'NPI_FAC'), set_test_flag(left));

		shared rst_fapp := rst_1 + rst_2 + rst_3 + rst_4 + rst_5;
		shared ska_grp := sg1 + sg2 + sg3 + sg4;
		shared npi_fac := npi_1 + npi_2 + npi_3 + npi_4;
		shared base_ds := mprd_ds + rst_fapp + ska_grp + npi_fac;
		
	//	export view := base_ds;
		export view := base_ds;
		export write := output(base_ds,, '~thor_data400::in::mprd::QA::facility' ,csv( separator('|'),heading(0), terminator(['\n', '\r\n']),QUOTE('')), UPDATE);
		
	END;	


/*****************************************************************************
	MISC DATA/SHARED DATA
*****************************************************************************/

	// Group Lookup records
	EXPORT t_group_lu := module
		raw_x := dataset(group_lu, L.group_lu_in, CSV(SEPARATOR('|'))) : INDEPENDENT;
		 
		L.group_lu_in set_test_flag(L.group_lu_in l) := transform
				self.istest := true;
				self := l;
		end;

		shared base_ds := project(raw_x, set_test_flag(left));

		export view := base_ds;
		export write := output(base_ds,, '~thor_data400::in::mprd::QA::group_lu' ,csv( separator('|'),heading(0), terminator(['\n', '\r\n']),QUOTE('')), UPDATE);

	END;	

	// Hospital Lookup records
	EXPORT t_hospital_lu := module
		raw_x := dataset(hospital_lu, L.hospital_lu_in, CSV(SEPARATOR('|'))) : INDEPENDENT;
		 
		L.hospital_lu_in set_test_flag(L.hospital_lu_in l) := transform
				self.istest := true;
				self := l;
		end;

		shared base_ds := project(raw_x, set_test_flag(left));

		export view := base_ds;
		export write := output(base_ds,, '~thor_data400::in::mprd::QA::hospital_lu' ,csv( separator('|'),heading(0), terminator(['\n', '\r\n']),QUOTE('')), UPDATE);

	END;	

	// license filedate records
	EXPORT t_lic_filedate := module
		raw_x := dataset(lic_filedate, L.lic_filedate_in, CSV(SEPARATOR('|'))) : INDEPENDENT;
		 
		L.lic_filedate_in set_test_flag(L.lic_filedate_in l) := transform
				self.istest := true;
				self := l;
		end;

		shared base_ds := project(raw_x, set_test_flag(left));

		export view := base_ds;
		export write := output(base_ds,, '~thor_data400::in::mprd::QA::lic_filedate' ,csv( separator('|'),heading(0), terminator(['\n', '\r\n']),QUOTE('')), UPDATE);

	END;	

	// Nanpa records
	// looks like for Dono score only
	EXPORT t_nanpa := module
		raw_x := dataset(nanpa, L.nanpa_in, CSV(SEPARATOR('|'))) : INDEPENDENT;
		 
		L.nanpa_in set_test_flag(L.nanpa_in l) := transform
				self.istest := true;
				self := l;
		end;

		shared base_ds := project(raw_x, set_test_flag(left));

		export view := base_ds;
		export write := output(base_ds,, '~thor_data400::in::mprd::QA::nanpa' ,csv( separator('|'),heading(0), terminator(['\n', '\r\n']),QUOTE('')), UPDATE);

	END;	

	// NPI/TIN xref records
	EXPORT t_npi_tin_xref := module
		raw_x := dataset(npi_tin_xref, L.npi_tin_xref_in, CSV(SEPARATOR('|'))) : INDEPENDENT;
		 
		L.npi_tin_xref_in set_test_flag(L.npi_tin_xref_in l) := transform
				self.istest := true;
				self := l;
		end;

		shared base_ds := project(raw_x, set_test_flag(left));

		export view := base_ds;
		export write := output(base_ds,, '~thor_data400::in::mprd::QA::npi_tin_xref' ,csv( separator('|'),heading(0), terminator(['\n', '\r\n']),QUOTE('')), UPDATE);

	END;	

	// source_confidence_lu records
	EXPORT t_source_confidence_lu := module
		raw_x := dataset(source_confidence_lu, L.source_confidence_lu_in, CSV(SEPARATOR('|'))) : INDEPENDENT;
		 
		L.source_confidence_lu_in set_test_flag(L.source_confidence_lu_in l) := transform
				self.istest := true;
				self := l;
		end;

		shared mprd_ds := project(raw_x, set_test_flag(left));

	// add RST_FAPP
		shared custom_ds := dataset([{'RST_FAPP',88,'2016-01-01',true}], L.source_confidence_lu_in);

		shared base_ds := mprd_ds + custom_ds;
		export view := base_ds;
		export write := output(base_ds,, '~thor_data400::in::mprd::QA::source_confidence_lu' ,csv( separator('|'),heading(0), terminator(['\n', '\r\n']),QUOTE('')), UPDATE);

	END;	

END;