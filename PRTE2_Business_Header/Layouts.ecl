import Address;

export Layouts := module

	export Input := module

		//*** Input Business Header layout.
		export Layout_BusHeader := record
			string link_fein;
			string link_inc_date;
			string bdid;					// New field added for Historical data
			string group_id;			// New field added for Historical data
			string vendor_id;			// New field added for Historical data
			string orig_fein;
			string bus_name;
			string long_bus_name;
			string bus_status;
			string sic_code;
			string naics_code;
			string risk_code;
			string bus_type_desc;
			string naics_desc;
			string bus_addr1;
			string bus_addr2;
			string bus_city;
			string bus_st;
			string bus_zip;
			string bus_zip4;
			string bus_country;
			string address_date;
			string address_age_flag;
			string Src;
			string bus_phone;
			string phone_date;
			string phone_age_flag;
			string bus_URL;
			string bus_email;
			string mailing_addr;
			string mailing_city;
			string mailing_st;
			string mailing_zip;
			string dt_vendor_first_reported;
			string dt_vendor_last_reported;
			string dt_first_seen;
			string dt_last_seen;
			string ct_file_dt;
			string ct_filing_dt_age_flag;
			string rel1_bdid;    // New field added for Historical data
			string rel1_fein;
			string rel1_inc_date;
			string rel1_type;
			string rel2_type;	
			string rel3_type;
			string rel4_type;
			string rel5_type;
			string rel6_type;		// New field added for Historical data
			string rel7_type;		// New field added for Historical data
			string rel8_type;		// New field added for Historical data
			string rel9_type;		// New field added for Historical data
			string rel10_type;	// New field added for Historical data
			string rel11_type;	// New field added for Historical data
			string filler1;
			string filler2;
			string filler3;
			string filler4;
			string filler5;
			string filler6;
			string filler7;
			string filler8;
			string filler9;
			string filler10;
			string source_group;  // New field added for Historical data
			string current;				// New field added for Historical data
			string dppa;					// New field added for Historical data
			string vendor_st;			// New field added for Historical data
			string cust_name;
			string bug_num;
			string employee_count;
      string employee_count_data_permits;
      string employee_count_method;
      string sales;
      string sales_data_permits;
      string sales_method;
     	string Aircraft;
			string CorpFilings;
			string DeathMaster;
			string MVR;
			string PersonHeader;
			string WhoIs;
			string EXPERIANCRDKEYS;
			string WORKERS_COMP;
			string ADDRESS_HRI;
			string GOVDATAKEYS;
			string DCAKEYS;
			string DEADCOKEYS;
			string FCCKEYS;
			string IRS;
			string LaborActionWHDKeys;
			string UCC;
			string ECRASHV2;
			string OSHAIR;
			string POE;
			string FBNB2;
			string GSA;
			string FRANDX;
			string BKEVENTS;
			string ACAInstitutionsKeys;
			string CrashCarriers;
			string FEIN;
			string UTILITYDAILY;
			string NDR;
			string SAM;
			string DIVERSITYCERT;
			string NoticeOfDefault;
			string BUSINESSBEST;
			string GlobalWatchlistAndPatriotKeys;
			string BusReg;
			string WaterCraft;
			string JUDGEMENT_LIEN;
			string VehicleV2;
			string Property1;
			string Property2New;	// (requirment for multiple properties);
			string Both; 					// (requirment for multiple properties);
			string Property2; 		// (requirment for multiple properties);
			string Old_link_fein;
			string Order;
		end;

		//*** Input Business Contact layout.
		export Layout_BusContact := record
			string link_fein;
			string link_inc_date;
			string bdid;
			string contact_score;
			string vendor_id;
			string dt_first_seen;
			string dt_last_seen;
			string src;
			string company_source_group;
			string bus_name;
			string bus_dept;
			string bus_addr1;
			string bus_city;
			string bus_st;
			string bus_zip;
			string bus_zip4;
			string bus_phone;
			string bus_email;
			string record_type;
			string from_hdr;
			string glb;
			string dppa;
			string contact_did1;
			string contact_dob1;
			string contact_ssn1;
			string contact_addr1;
			string contact_city1;
			string contact_st1;
			string contact_zip1;
			string contact_zip1_4;
			string contact_county;
			string contact_msa;
			string contact_geo_lat;
			string contact_geo_long;
			string contact_title1;
			string contact_fname1;
			string contact_mname1;
			string contact_lname1;
			string contact_suffix1;
			string company_title1;
			string contact_phone1;
			string contact_did2;
			string contact_dob2;
			string contact_ssn2;
			string contact_addr2;
			string contact_city2;
			string contact_st2;
			string contact_zip2;
			string contact_fname2;
			string contact_mname2;
			string contact_lname2;			
			string company_title2;
			string contact_phone2;
			string contact_did3;
			string contact_dob3;
			string contact_ssn3;
			string contact_addr3;
			string contact_city3;
			string contact_st3;
			string contact_zip3;
			string contact_fname3;
			string contact_mname3;
			string contact_lname3;			
			string company_title3;
			string contact_phone3;
			string contact_did4;
			string contact_dob4;
			string contact_ssn4;
			string contact_addr4;
			string contact_city4;
			string contact_st4;
			string contact_zip4;
			string contact_fname4;
			string contact_mname4;
			string contact_lname4;			
			string company_title4;
			string contact_phone4;
			string contact_did5;
			string contact_dob5;
			string contact_ssn5;
			string contact_addr5;
			string contact_city5;
			string contact_st5;
			string contact_zip5;
			string contact_fname5;
			string contact_mname5;
			string contact_lname5;			
			string company_title5;
			string contact_phone5;
			string contact_did6;
			string contact_dob6;
			string contact_ssn6;
			string contact_addr6;
			string contact_city6;
			string contact_st6;
			string contact_zip6;
			string contact_fname6;
			string contact_mname6;
			string contact_lname6;			
			string company_title6;
			string contact_phone6;
			string contact_did7;
			string contact_dob7;
			string contact_ssn7;
			string contact_addr7;
			string contact_city7;
			string contact_st7;
			string contact_zip7;
			string contact_fname7;
			string contact_mname7;
			string contact_lname7;			
			string company_title7;
			string contact_phone7;
			string contact_did8;
			string contact_dob8;
			string contact_ssn8;
			string contact_addr8;
			string contact_city8;
			string contact_st8;
			string contact_zip8;
			string contact_fname8;
			string contact_mname8;
			string contact_lname8;			
			string company_title8;
			string contact_phone8;
			string contact_did9;
			string contact_dob9;
			string contact_ssn9;
			string contact_addr9;
			string contact_city9;
			string contact_st9;
			string contact_zip9;
			string contact_fname9;
			string contact_mname9;
			string contact_lname9;			
			string company_title9;
			string contact_phone9;
			string contact_did10;
			string contact_dob10;
			string contact_ssn10;
			string contact_addr10;
			string contact_city10;
			string contact_st10;
			string contact_zip10;
			string contact_fname10;
			string contact_mname10;
			string contact_lname10;			
			string company_title10;
			string contact_phone10;
			string Order;
			string cust_name;
		end;
	end;

	
	////////////////////////////////////////////////////////////////////////
	// -- Temporary Layouts for processing
	////////////////////////////////////////////////////////////////////////
	export Temporary := module
	
		export Layout_BC_Norm :=
	  record
			string link_fein;
			string link_inc_date;
			unsigned6 bdid;
			string contact_score;
			string vendor_id;
			string dt_first_seen;
			string dt_last_seen;
			string src;
			string company_source_group;
			string long_bus_name;
			string orig_fein;
			string bus_name;
			string bus_dept;
			string bus_addr1;
			string bus_city;
			string bus_st;
			string bus_zip;
			string bus_zip4;
			string bus_phone;
			string bus_email;
			string record_type;
			string from_hdr;
			string glb;
			string dppa;
			string contact_did;
			string contact_dob;
			string contact_ssn;
			string contact_title;	
			string contact_lname;
			string contact_mname  := '';
			string contact_fname;
			string contact_suffix := '';
			string company_title;
			string contact_phone;
			string contact_addr := '';
			string contact_city := '';
			string contact_st := '';
			string contact_zip := '';
			string contact_zip_4 := '';
			string contact_county := '';
			string contact_msa := '';
			string contact_geo_lat := '';
			string contact_geo_long := '';
			string cust_name;
			string Bus_Prep_Addr_First := '';
			string Bus_Prep_Addr_Last := '';
			string Cont_Prep_Addr_First := '';
			string Cont_Prep_Addr_Last := '';
	  end;

		export Layout_BH_Norm :=
	  record
			unsigned6 uniq_id := 0;
			Input.Layout_BusHeader;				
			string Addr1 := '';
			string Addr2 := '';
			string City := '';
			string State := '';
			string ZipCode := '';
			string Prep_Address_First := '';
			string Prep_Address_Last := '';
			Address.Layout_Clean182_fips;
			string2 Addr_type := '';
			unsigned8 RawAID := 0;
			unsigned8 AceAID := 0;
	  end;
				
		export Layout_For_AID_Addr :=
	  record		
			unsigned6 uniq_id := 0;
			string Prep_Address_First := '';
			string Prep_Address_Last := '';
			Address.Layout_Clean182_fips;
			string2 Addr_type := '';
			unsigned8 RawAID := 0;
			unsigned8 AceAID := 0;
	  end;
		
		export Layout_Relatives := record
			unsigned6 bdid1;
			unsigned6 bdid2;
			Input.Layout_BusHeader.link_fein;
			Input.Layout_BusHeader.link_inc_date;
			Input.Layout_BusHeader.orig_fein;
			Input.Layout_BusHeader.bus_name;
			Input.Layout_BusHeader.long_bus_name;
			string rel_fein;
			string rel_inc_date;
			string rel1_type;
			string rel2_type;
			string rel3_type;
			string rel4_type;
			string rel5_type;
			string rel6_type;
			string rel7_type;
			string rel8_type;
			string rel9_type;
			string rel10_type;
			string rel11_type;
		end;

		export Layout_Rel_Types := record
			unsigned6 bdid1;
			unsigned6 bdid2;
			Input.Layout_BusHeader.link_fein;
			Input.Layout_BusHeader.link_inc_date;
			Input.Layout_BusHeader.orig_fein;
			Input.Layout_BusHeader.bus_name;
			Input.Layout_BusHeader.long_bus_name;
			string rel_type;
		end;
		
	end;
	
	
	////////////////////////////////////////////////////////////////////////
	// -- Out Layouts
	////////////////////////////////////////////////////////////////////////
	export Out := module
	
		export Layout_BH_Out :=
	  record
			unsigned6 bdid;
			Input.Layout_BusHeader -[bdid, filler1 ,filler2 ,filler3 ,filler4 ,filler5
															,filler6 ,filler7 ,filler8 ,filler9 ,filler10
															,Aircraft ,CorpFilings ,DeathMaster ,MVR
															,PersonHeader ,WhoIs ,EXPERIANCRDKEYS
															,WORKERS_COMP ,ADDRESS_HRI ,GOVDATAKEYS
															,DCAKEYS ,DEADCOKEYS ,FCCKEYS ,IRS
															,LaborActionWHDKeys ,UCC ,ECRASHV2 ,OSHAIR
															,POE ,FBNB2	,GSA ,FRANDX ,BKEVENTS ,ACAInstitutionsKeys
															,CrashCarriers ,FEIN ,UTILITYDAILY ,NDR ,SAM
															,DIVERSITYCERT ,NoticeOfDefault ,BUSINESSBEST
															,GlobalWatchlistAndPatriotKeys ,BusReg ,WaterCraft
															,JUDGEMENT_LIEN ,VehicleV2 ,Property1 ,Property2New ,Both
															,Property2 ,Old_link_fein, Order];
			
			string Addr1 := '';
			string Addr2 := '';
			string City := '';
			string State := '';
			string ZipCode := '';
			string Prep_Address_First := '';
			string Prep_Address_Last := '';
			Address.Layout_Clean182_fips;
			string2 Addr_type := '';
			unsigned8 RawAID := 0;
			unsigned8 AceAID := 0;
	  end;
		
		export Layout_BC_Out :=
	  record
			unsigned6 uniq_id := 0;
			unsigned6 bdid := 0;
			unsigned6 did := 0;
			Temporary.Layout_BC_Norm - [bdid, contact_did];
			Address.Layout_Clean_Name;
			Address.Layout_Clean182_fips contact_clean_addr;
			unsigned8 contact_RawAID := 0;
			unsigned8 contact_AceAID := 0;
			Address.Layout_Clean182_fips company_clean_addr;
			unsigned8 company_RawAID := 0;
			unsigned8 company_AceAID := 0;
	  end;
		
	end;
	
end;