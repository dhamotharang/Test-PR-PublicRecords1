import ingenix_natlprof,Prof_LicenseV2,Prof_License,standard,doxie, Autokey_batch;

export Assorted_Layouts := MODULE

	EXPORT ProvId_dea := RECORD
			  doxie.layout_inBatchMaster.acctno;
		    Prof_LicenseV2.Layouts_ProfLic.Layout_Base.ProLic_Seq_Id;
				string9	DEANumber;
				string200	DEA_r := '';
				unsigned6  did;
				
	END;
	
	EXPORT ProvId_NPI := RECORD
			  doxie.layout_inBatchMaster.acctno;
		    Prof_LicenseV2.Layouts_ProfLic.Layout_Base.ProLic_Seq_Id;
				string10	NPI;
				unsigned6 did;			
				unsigned6 providerid;
	END;

	
 export Layout_Autokeys_Prov := record
	ingenix_natlprof.Basefile_Provider_Did.ProviderID;
	ingenix_natlprof.Basefile_Provider_Did.AddressID;
	ingenix_natlprof.Basefile_Provider_Did.FILETYP;
	ingenix_natlprof.Basefile_Provider_Did.BirthDate;
	ingenix_natlprof.Basefile_Provider_Did.PhoneNumber;
	unsigned6 did ;
	standard.Addr addr;
	standard.name name;
	unsigned1 zero;
	string1   blank;
	unsigned6 lookups;
	END;

 // Provider Screening Batch Phase 2 enhancements change to use same layout as is 
 // used to build the sanctions autokeys.
 export Layout_Autokeys_Sanc := recordof(Ingenix_NatlProf.file_SearchAutokey_Sanctions);

	shared Layout_clean_name_addr := RECORD
		Prof_License.Layout_proLic_in.prim_range;
		Prof_License.Layout_proLic_in.predir;
		Prof_License.Layout_proLic_in.prim_name;
		Prof_License.Layout_proLic_in.suffix;
		Prof_License.Layout_proLic_in.postdir;
		Prof_License.Layout_proLic_in.unit_desig;
		Prof_License.Layout_proLic_in.sec_range;
		Prof_License.Layout_proLic_in.p_city_name;
		Prof_License.Layout_proLic_in.v_city_name;
		Prof_License.Layout_proLic_in.st;
		Prof_License.Layout_proLic_in.zip;
		Prof_License.Layout_proLic_in.zip4;
		Prof_License.Layout_proLic_in.cart;
		Prof_License.Layout_proLic_in.cr_sort_sz;
		Prof_License.Layout_proLic_in.lot;
		Prof_License.Layout_proLic_in.lot_order;
		Prof_License.Layout_proLic_in.dpbc;
		Prof_License.Layout_proLic_in.chk_digit;
		Prof_License.Layout_proLic_in.record_type;
		Prof_License.Layout_proLic_in.ace_fips_st;
		Prof_License.Layout_proLic_in.county;
		Prof_License.Layout_proLic_in.geo_lat;
		Prof_License.Layout_proLic_in.geo_long;
		Prof_License.Layout_proLic_in.msa;
		Prof_License.Layout_proLic_in.geo_blk;
		Prof_License.Layout_proLic_in.geo_match;
		Prof_License.Layout_proLic_in.err_stat;
		Prof_License.Layout_proLic_in.title;
		Prof_License.Layout_proLic_in.fname;
		Prof_License.Layout_proLic_in.mname;
		Prof_License.Layout_proLic_in.lname;
		Prof_License.Layout_proLic_in.name_suffix;
	END;
  export Layout_key := RECORD
		string17 uniqueid;
		unsigned6 prolic_seq_id;
		unsigned6 ProviderId;
		unsigned6 sanc_id;
		UNSIGNED6	npi;
		unsigned4 global_sid;
    unsigned8 record_sid;
	END;

	Export Layout_Search1 := record
	 string9 taxid;
		Prof_License.Layout_proLic_in.Orig_License_Number;
		Prof_License.Layout_proLic_in.Status;
		Prof_License.Layout_proLic_in.Orig_name;
		Prof_License.Layout_proLic_in.Orig_Former_Name;
		Prof_License.Layout_proLic_in.Company_name;
		Prof_License.Layout_proLic_in.Orig_Addr_1;
		Prof_License.Layout_proLic_in.Orig_Addr_2;
		Prof_License.Layout_proLic_in.Orig_City;
		Prof_License.Layout_proLic_in.Orig_St;
		Prof_License.Layout_proLic_in.Orig_Zip;		
		Prof_License.Layout_proLic_in.Additional_orig_name;
		Prof_License.Layout_proLic_in.additional_orig_additional_1;
		Prof_License.Layout_proLic_in.additional_orig_additional_2;
		Prof_License.Layout_proLic_in.additional_orig_city;
		Prof_License.Layout_proLic_in.additional_orig_st;
		Prof_License.Layout_proLic_in.additional_orig_zip;
		Prof_License.layout_proflic_out.did;
		Prof_License.layout_proflic_out.bdid;
		Prof_License.Layout_proLic_in.phone;
		string20 Phonetype;
		Prof_License.Layout_proLic_in.sex;
		Prof_License.Layout_proLic_in.dob;
		Prof_License.layout_proflic_out.best_ssn;	
		Prof_License.Layout_proLic_in.issue_date;
		Prof_License.Layout_proLic_in.expiration_date;
		Prof_License.Layout_proLic_in.status_effective_dt;
		Prof_License.Layout_proLic_in.Action_Status;
		Prof_License.Layout_proLic_in.date_last_seen;
		Prof_License.Layout_proLic_in.date_first_seen;
		Prof_License.Layout_proLic_in.last_renewal_date;
		Prof_License.Layout_proLic_in.profession_or_board;
		Prof_License.Layout_proLic_in.license_type;
		Prof_License.Layout_proLic_in.license_obtained_by;
		Prof_License.Layout_proLic_in.source_st;
		string25 source_st_decoded;
		Layout_clean_name_addr;
		Prof_License.layout_proflic_out.county_name;
END;
	export layout_search := RECORD
	 Layout_key;
	 Layout_Search1;
	END;
  
	Export Layout_Search_w_pen := RECORD
		Layout_Search;
		unsigned2 penalt;
		boolean isdeepdive;
	END;
	
	export Layout_Search_w_pen_and_license_number := RECORD
	  Layout_Search;
		Prof_License.Layout_proLic_in.license_number;
		unsigned2 penalt;
		boolean isdeepdive;
	END;
	
	export Layout_Report1 := RECORD

		Prof_License.Layout_proLic_in.license_number;
		Prof_License.Layout_proLic_in.board_action_indicator;
		Prof_License.Layout_proLic_in.Action_complaint_violation_dt;
		Prof_License.Layout_proLic_in.Action_complaint_violation_desc;
		Prof_License.Layout_proLic_in.Action_case_number;
		Prof_License.Layout_proLic_in.Action_desc;
		Prof_License.Layout_proLic_in.Action_Posting_Status_dt;
		Prof_License.Layout_proLic_in.Action_effective_dt;
		Prof_License.Layout_proLic_in.misc_other_id;
		Prof_License.Layout_proLic_in.education_continuing_education;
		 Prof_License.Layout_proLic_in.education_1_school_attended;
		 Prof_License.Layout_proLic_in.education_1_dates_attended;
		 Prof_License.Layout_proLic_in.education_1_curriculum;
		 Prof_License.Layout_proLic_in.education_1_degree;
		 Prof_License.Layout_proLic_in.education_2_school_attended;
		 Prof_License.Layout_proLic_in.education_2_dates_attended;
		 Prof_License.Layout_proLic_in.education_2_curriculum;
		 Prof_License.Layout_proLic_in.education_2_degree;
		 Prof_License.Layout_proLic_in.education_3_school_attended;
		 Prof_License.Layout_proLic_in.education_3_dates_attended;
		 Prof_License.Layout_proLic_in.education_3_curriculum;
		 Prof_License.Layout_proLic_in.education_3_degree;
		 Prof_License.Layout_proLic_in.business_flag;
		 Prof_License.Layout_proLic_in.misc_fax;
		 Prof_License.Layout_proLic_in.misc_email;
		 Prof_License.Layout_proLic_in.additional_phone;
		 Prof_License.Layout_proLic_in.personal_race_desc;
		 Prof_License.Layout_proLic_in.misc_occupation;
		 Prof_License.Layout_proLic_in.action_record_type;
		 Prof_License.Layout_proLic_in.personal_pob_desc;
	 
	 string20   other_license_number;
	 string60	  other_license_type;
	 Prof_License.Layout_proLic_in.misc_practice_hours;
	 Prof_License.Layout_proLic_in.misc_practice_type;
		Prof_License.Layout_proLic_in.additional_licensing_specifics;
	END;

	export layout_report := RECORD
	    Layout_Key;
			Layout_Search1;
			Layout_Report1;
	END;
		 
	EXPORT plBatchMaster_npi := RECORD
	     Autokey_batch.Layouts.rec_inBatchMaster;
			 string10 npi;
  END;
			 
END;