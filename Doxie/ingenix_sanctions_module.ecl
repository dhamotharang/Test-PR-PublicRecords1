import doxie_files, Ingenix_NatlProf, OIG;

export ingenix_sanctions_module := module

	export ingenix_sanctions_name_rec := record
		string20 	 Prov_Clean_fname;
		string20   Prov_Clean_mname;
		string20 	 Prov_Clean_lname;
		string5  	 Prov_Clean_name_suffix;
	end;
	
	export ingenix_sanctions_slim_phone_rec := record
		string10	PhoneNumber;
		string12	PhoneType;
	end;
	
	export ingenix_sanctions_addr_rec := record
		string10  ProvCo_Address_Clean_prim_range;
		string2  	ProvCo_Address_Clean_predir;
		string28 	ProvCo_Address_Clean_prim_name;
		string4   ProvCo_Address_Clean_addr_suffix;
		string2 	ProvCo_Address_Clean_postdir;
		string10	ProvCo_Address_Clean_unit_desig;
		string8 	ProvCo_Address_Clean_sec_range;
		string25 	ProvCo_Address_Clean_p_city_name;
		string25 	ProvCo_Address_Clean_v_city_name;
		string2 	ProvCo_Address_Clean_st;
		string5  	ProvCo_Address_Clean_zip;
		string4  	ProvCo_Address_Clean_zip4;
		dataset(ingenix_sanctions_slim_phone_rec) phone;
	end;

     export ingenix_sanctions_phone_rec := record
		string28	ProvCo_Address_Clean_prim_name;
		string2  	ProvCo_Address_Clean_st;
		string5 	ProvCo_Address_Clean_zip;
	     string10	ProvCo_Address_Clean_prim_range;
		string8	ProvCo_Address_Clean_sec_range;
		string10	PhoneNumber;
		string12	PhoneType;
	end;

     export ingenix_sanctions_dob_rec := record
		string8  SANC_DOB;
	end;

     export ingenix_sanctions_taxid_rec := record
		string10  SANC_TIN;
	end;
	
	export ingenix_sanctions_sancid_rec := record
		unsigned6  SANC_ID;
	end;
	
	export ingenix_sanctions_license_rec := record
		string2	LicenseState;	
		string12	LicenseNumber;
		unsigned2 LicenseNumberTierTypeID;
	end;

	
	EXPORT layout_ingenix_sanctions_search := RECORD, MAXLENGTH(200000)
		INTEGER    did;
		unsigned6    SANC_ID;
		STRING20   Prov_Clean_fname;
		STRING20   Prov_Clean_mname;
		STRING20   Prov_Clean_lname;
		STRING5    Prov_Clean_name_suffix;
		STRING10   ProvCo_Address_Clean_prim_range;
		STRING2    ProvCo_Address_Clean_predir;
		STRING28   ProvCo_Address_Clean_prim_name;
		STRING4    ProvCo_Address_Clean_addr_suffix;
		STRING2 	  ProvCo_Address_Clean_postdir;
		STRING10	  ProvCo_Address_Clean_unit_desig;
		STRING8 	  ProvCo_Address_Clean_sec_range;
		STRING25   ProvCo_Address_Clean_p_city_name;
		STRING25   ProvCo_Address_Clean_v_city_name;
		STRING2 	  ProvCo_Address_Clean_st;
		STRING5    ProvCo_Address_Clean_zip;
		STRING4    ProvCo_Address_Clean_zip4;
		STRING10	  PhoneNumber;
		STRING12	  PhoneType;
		STRING8    SANC_DOB;
		STRING10   SANC_TIN;
		string8 	 date_first_seen :='';
		string8 	 date_last_seen :='';
		string8		 date_first_reported :='';
		STRING8    date_last_reported;
	END;
	
	// new layout to include OIG with the Ingenix output
   EXPORT layout_ingenix_OIG_sanctions_search := RECORD, MAXLENGTH(200000)
      STRING5    rec_type;
		layout_ingenix_sanctions_search;
		OIG.Layouts.Raw_OIG_Layout.BUSNAME;   // STRING30	  BUSNAME; 	 20110602
		OIG.Layouts.Raw_OIG_Layout.GENERAL;   // STRING20	  GENERAL; 	 20110602 	
		OIG.Layouts.Raw_OIG_Layout.SPECIALTY; // STRING20	  SPECIALTY; 20110602
		OIG.Layouts.Raw_OIG_Layout.SANCTYPE;  // STRING9	  SANCTYPE ; 20110602	
		OIG.Layouts.Raw_OIG_Layout.SANCDATE;  // STRING8	  SANCDATE ; 20110602	
		OIG.Layouts.Base.SANCDESC;            // STRING250   SANCDESC;  20110602
	END;	
	
	export layout_ingenix_sanctions_report := record, maxlength(200000)
		string20   SANC_ID;
		string12  DID;
		string20 	Prov_Clean_fname;
		string20  Prov_Clean_mname;
		string20 	Prov_Clean_lname;
		string5  	Prov_Clean_name_suffix;
		string10  ProvCo_Address_Clean_prim_range;
		string2  	ProvCo_Address_Clean_predir;
		string28 	ProvCo_Address_Clean_prim_name;
		string4   ProvCo_Address_Clean_addr_suffix;
		string2 	ProvCo_Address_Clean_postdir;
		string10	ProvCo_Address_Clean_unit_desig;
		string8 	ProvCo_Address_Clean_sec_range;
		string25 	ProvCo_Address_Clean_p_city_name;
		string25 	ProvCo_Address_Clean_v_city_name;
		string2 	ProvCo_Address_Clean_st;
		string5  	ProvCo_Address_Clean_zip;
		string4  	ProvCo_Address_Clean_zip4;
		string10	ProvCo_Address_Clean_geo_lat;
		string11	ProvCo_Address_Clean_geo_long;

		// 2 lines added below for provider screening batch phase2 enhancements project
		string12 bdid;
    doxie_files.key_sanctions_sancid.SANC_BUSNME;
		
		doxie_files.key_sanctions_sancid.SANC_DOB;
		doxie_files.key_sanctions_sancid.SANC_TIN;
		doxie_files.key_sanctions_sancid.SANC_UPIN;
		Ingenix_NatlProf.key_NPI_providerid.npi;
		unsigned2 NPITierTypeID;
		string9 NPPESVerified := '';
		doxie_files.key_sanctions_sancid.SANC_PROVTYPE;
		//sanction type
		doxie_files.key_sanctions_sancid.SANC_SANCDTE_form;
		doxie_files.key_sanctions_sancid.SANC_SANCDTE;
		doxie_files.key_sanctions_sancid.SANC_LICNBR;
		doxie_files.key_sanctions_sancid.SANC_SANCST;
	  doxie_files.key_sanctions_sancid.SANC_BRDTYPE;	
		doxie_files.key_sanctions_sancid.SANC_SRC_DESC;
		doxie_files.key_sanctions_sancid.SANC_TYPE;
		doxie_files.key_sanctions_sancid.SANC_TERMS;
		doxie_files.key_sanctions_sancid.SANC_REAS;
		doxie_files.key_sanctions_sancid.SANC_COND;
		doxie_files.key_sanctions_sancid.SANC_FINES;		
		doxie_files.key_sanctions_sancid.SANC_UPDTE_form;
		doxie_files.key_sanctions_sancid.SANC_UPDTE;
		doxie_files.key_sanctions_sancid.date_first_reported;
		doxie_files.key_sanctions_sancid.date_last_reported;
		doxie_files.key_sanctions_sancid.SANC_REINDTE_form;
		doxie_files.key_sanctions_sancid.SANC_REINDTE;
		
		//not sure if need
		doxie_files.key_sanctions_sancid.SANC_FAB;
		doxie_files.key_sanctions_sancid.SANC_UNAMB_IND;

		//appended date
		doxie_files.key_sanctions_sancid.process_date;
		doxie_files.key_sanctions_sancid.date_first_seen;
		doxie_files.key_sanctions_sancid.date_last_seen;
				
		//license information
		//dataset(ingenix_sanctions_license_rec) license;
		string7 sanc_grouptype :='';
		string3 sanc_subgrouptype :='';
		unsigned2	sanc_priority := 99;
		boolean LNDerivedReinstateDate := false;
	end;
	
end;