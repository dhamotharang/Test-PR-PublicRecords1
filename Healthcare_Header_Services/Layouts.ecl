import HMS_STLIC,doxie_files, doxie, doxie_cbrs, NPPES, ingenix_natlprof,standard,ams,Autokey_batch,iesp, dea,Prof_LicenseV2,Enclarity,clia,ncpdp,BIPV2,org_mast;

export Layouts := MODULE

	Export rawkeyRec := Record
		string20 Acctno := '';
	end;
	Export rawDupRec := Record
		rawkeyRec;
		dataset(rawkeyRec) dupAcctno;
	end;
	Export rawNormRec := Record
		rawkeyRec;
		string20 dupAcctno;
	end;

	Export sanc_lookup_rec := record
			string20	 	acctno := '';
			unsigned6		ProviderID:=0;
			unsigned6 	SANC_ID;
			String			src;
	end;

	EXPORT Id := RECORD
		unsigned6 id;
		boolean isdid; 
		boolean isbdid;
		boolean isfake;
	END;
	
	EXPORT GroupKey := RECORD
		string20 acctno := '';
		unsigned6 ProviderID:=0;
		string 		group_key:='';
	END;
	
	EXPORT BusName_WordRec := RECORD
    STRING          word;
	end;
	EXPORT BusName_SeqWordRec := RECORD
		UNSIGNED1       seq;
		BusName_WordRec;
	end;
	EXPORT BusName_WordsScoredRec := RECORD
		UNSIGNED1       seq1;
		STRING          word1;
		UNSIGNED1       seq2;
		STRING          word2;
		UNSIGNED1       prefixMatchScore;
		UNSIGNED1       initialismLeft;
		UNSIGNED1       initialismRight;
		UNSIGNED1       totalScore;
	end;

	EXPORT HeaderRequestLayout := RECORD
		INTEGER   rid;
		UNSIGNED8 lnpid;
		STRING20  fname;
		STRING20  mname;
		STRING28  lname; 
		STRING5   sname;
		STRING1   gender;
		STRING10  prim_range;
		STRING28  prim_name;
		STRING8   sec_range;
		STRING25  v_city_name;
		STRING2   st;
		STRING5   zip;
		STRING9		SSN;
		UNSIGNED4 dob;
		STRING10	PHONE,
		STRING25  lic_nbr;
		STRING2   lic_state;
		STRING10 	Tax_ID;
		STRING10 	DEA_NUMBER;
		STRING40	VENDOR_ID;
		STRING10	NPI_NUMBER;
		STRING10	UPIN;
		INTEGER8	DID;
		INTEGER8	BDID;
		STRING9		SRC;
		INTEGER		SOURCE_RID;
		integer		total_score;
	END;
	EXPORT HeaderRequestLayoutPlus := RECORD
		HeaderRequestLayout;
		boolean		hasLicense; 
		boolean		hasName;
		boolean		hasAddress;
		boolean		isLicenseOnly;
		boolean		isNameAddrOnly;
		boolean		isFullSearch;
	END;

	Export HeaderResponseLayoutWeight := RECORD
		unsigned4 uniqueid;
		integer2 weight;
	END;

	Export HeaderResponseLayout := RECORD
		unsigned4 uniqueid;
		integer2 weight;
		unsigned4 keysused;
		unsigned6 LNPID;
		unsigned8 rid;
		unsigned8 did;
		unsigned8 bdid;
		unsigned6 dotid;
		unsigned6 empid;
		unsigned6 powid;
		unsigned6 proxid;
		unsigned6 orgid;
		unsigned6 ultid;
		string9 src;
		unsigned8 source_rid;
		unsigned4 dt_first_seen;
		unsigned4 dt_last_seen;
		unsigned4 dt_vendor_first_reported;
		unsigned4 dt_vendor_last_reported;
		string1 ambiguous;
		string1 consumer_disclosure;
		STRING1	SSN_FLAG;		
		STRING1	DOB_FLAG;		
		STRING1	LIC_NBR_FLAG;   
		STRING1	FNAME_FLAG;		
		STRING1	MNAME_FLAG;		
		STRING1	LNAME_FLAG;				
		STRING1	ADDR_FLAG;		
		STRING1	TAX_ID_FLAG;	
		STRING1	FEIN_FLAG;			
		STRING1	UPIN_FLAG;			
		STRING1	NPI_NUMBER_FLAG;					
		STRING1	DEA_NUMBER_FLAG;							
		STRING1	PHONE_FLAG;		
		STRING1	CLIA_NUMBER_FLAG;
		STRING1	SUPPRESS_ADDRESS;
		string9 ssn;
		unsigned4 dob;
		string10 phone;
		string25 lic_nbr;
		string2 lic_state;
		string30 lic_type;
		string3 provider_type;
		string5 title;
		string20 fname;
		string20 mname;
		string28 lname;
		string5 sname;
		string120 cname;
		string8 sic_code;
		string1 gender;
		string1 derived_gender;
		unsigned8 address_id;
		string10 prim_range;
		string2 predir;
		string28 prim_name;
		string4 addr_suffix;
		string2 postdir;
		string10 unit_desig;
		string8 sec_range;
		string25 p_city_name;
		string25 v_city_name;
		string2 st;
		string5 zip;
		string4 zip4;
		string4 cart;
		string1 cr_sort_sz;
		string4 lot;
		string1 lot_order;
		string2 dbpc;
		string1 chk_digit;
		string2 rec_type;
		string5 county;
		string10 geo_lat;
		string11 geo_long;
		string4 msa;
		string7 geo_blk;
		string1 geo_match;
		string4 err_stat;
		string1 death_ind;
		unsigned4 dod;
		unsigned4 tax_id;
		unsigned4 fein;
		string6 upin;
		string10 npi_number;
		string10 dea_number;
		string40 vendor_id;
		unsigned8 __internal_fpos__;
		boolean fullmatch_required;
		boolean has_fullmatch;
		boolean recordsonly;
		boolean is_fullmatch;
		integer2 record_score;
		integer2 match_fname;
		integer2 match_mname;
		integer2 match_lname;
		integer2 match_sname;
		integer2 match_gender;
		integer2 match_prim_range;
		integer2 match_prim_name;
		integer2 match_sec_range;
		integer2 match_v_city_name;
		integer2 match_st;
		integer2 match_zip;
		integer2 match_ssn;
		integer2 match_dob;
		integer2 match_lic_state;
		integer2 match_lic_nbr;
		integer2 match_tax_id;
		integer2 match_dea_number;
		integer2 match_vendor_id;
		integer2 match_npi_number;
		integer2 match_upin;
		integer2 match_did;
		integer2 match_bdid;
		integer2 match_src;
		integer2 match_source_rid;
		integer2 keysfailed;
		string100 keysfailed_decode :='';
		boolean	 isSearchFailed := false;
		boolean	 returnThresholdExceeded := false;
		boolean	 srcIndividualHeader := false;
		boolean	 srcBusinessHeader := false;
	END;	
	
	EXPORT HeaderBusRequestLayout := RECORD
		INTEGER   rid;
		UNSIGNED8 lnpid;
		STRING120 comp_name;
		STRING10  prim_range;
		STRING28  prim_name;
		STRING8   sec_range;
		STRING25  v_city_name;
		STRING2   st;
		STRING5   zip;
		STRING10	PHONE,
		STRING25  lic_nbr;
		STRING2   lic_state;
		STRING10 	Tax_ID;
		STRING10 	DEA_NUMBER;
		STRING40	VENDOR_ID;
		STRING10	NPI_NUMBER;
		String15  NCPDPNumber;
		String15  CLIANumber;
		String15  MedicareNumber;
		INTEGER8	BDID;
		string 		Taxonomy;                
		STRING9		SRC;
		INTEGER		SOURCE_RID;
		integer		total_score;
	END;
	EXPORT HeaderBusRequestLayoutPlus := RECORD
		HeaderBusRequestLayout;
		boolean		hasLicense; 
		boolean		hasCName;
		boolean		hasAddress;
		boolean		isLicenseOnly;
		boolean		isCNameAddrOnly;
		boolean		isFullSearch;
	END;

	Export HeaderBusResponseLayout := RECORD
		unsigned4 uniqueid;
		integer2 weight;
		unsigned4 keysused;
		unsigned6 LNPID;
		unsigned8 rid;
		unsigned8 did;
		unsigned8 bdid;
		unsigned6 dotid;
		unsigned6 empid;
		unsigned6 powid;
		unsigned6 proxid;
		unsigned6 seleid;
		unsigned6 orgid;
		unsigned6 ultid;
		string9 src;
		unsigned8 source_rid;
		unsigned4 dt_first_seen;
		unsigned4 dt_last_seen;
		unsigned4 dt_vendor_first_reported;
		unsigned4 dt_vendor_last_reported;
		BOOLEAN ambiguous;
		string1 consumer_disclosure;
		STRING1	SSN_FLAG;		
		STRING1	DOB_FLAG;		
		STRING1	LIC_NBR_FLAG;   
		STRING1	FNAME_FLAG;		
		STRING1	MNAME_FLAG;		
		STRING1	LNAME_FLAG;				
		STRING1	ADDR_FLAG;		
		STRING1	TAX_ID_FLAG;	
		STRING1	FEIN_FLAG;			
		STRING1	UPIN_FLAG;			
		STRING1	NPI_NUMBER_FLAG;					
		STRING1	DEA_NUMBER_FLAG;							
		STRING1	PHONE_FLAG;		
		STRING1	CLIA_NUMBER_FLAG;
		STRING1	SUPPRESS_ADDRESS;
		string9 ssn;
		unsigned4 dob;
		string10 phone;
		string25 lic_nbr;
		string2 lic_state;
		string30 lic_type;
		string3 provider_type;
		string5 title;
		string20 fname;
		string20 mname;
		string28 lname;
		string5 sname;
		string120 cname;
		string120 cnp_name;
		string8 sic_code;
		string1 gender;
		string1 derived_gender;
		unsigned8 address_id;
		string10 address_classification;
		string10 prim_range;
		string2 predir;
		string28 prim_name;
		string4 addr_suffix;
		string2 postdir;
		string10 unit_desig;
		string8 sec_range;
		string25 p_city_name;
		string25 v_city_name;
		string2 st;
		string5 zip;
		string4 zip4;
		string4 cart;
		string1 cr_sort_sz;
		string4 lot;
		string1 lot_order;
		string2 dbpc;
		string1 chk_digit;
		string2 rec_type;
		string5 county;
		string10 geo_lat;
		string11 geo_long;
		string4 msa;
		string7 geo_blk;
		string1 geo_match;
		string4 err_stat;
		string1 death_ind;
		unsigned4 dod;
		unsigned4 tax_id;
		unsigned4 fein;
		string6 upin;
		string10 npi_number;
		string10 dea_number;
		string40 vendor_id;
		unsigned8 __internal_fpos__;
		boolean fullmatch_required;
		boolean has_fullmatch;
		boolean recordsonly;
		boolean is_fullmatch;
		integer2 record_score;
		integer2 match_fname;
		integer2 match_mname;
		integer2 match_lname;
		integer2 match_sname;
		integer2 match_gender;
		integer2 match_prim_range;
		integer2 match_prim_name;
		integer2 match_sec_range;
		integer2 match_v_city_name;
		integer2 match_st;
		integer2 match_zip;
		integer2 match_ssn;
		integer2 match_dob;
		integer2 match_lic_state;
		integer2 match_lic_nbr;
		integer2 match_tax_id;
		integer2 match_dea_number;
		integer2 match_vendor_id;
		integer2 match_npi_number;
		integer2 match_upin;
		integer2 match_did;
		integer2 match_bdid;
		integer2 match_src;
		integer2 match_source_rid;
		boolean	 returnThresholdExceeded := false;
		boolean	 srcIndividualHeader := false;
		boolean	 srcBusinessHeader := false;
	END;	

	EXPORT feinLookupResults := RECORD
		STRING120 	CompanyName := '';
		unsigned4 	boguslink := 0; //Create a bogus link so we can join
	END;	
	
	EXPORT feinLookup := RECORD
		unsigned4 fein := 0;
		string1 bit1 := ''; 
		string1 bit2 := ''; 
		string1 bit3 := ''; 
		string1 bit4 := ''; 
		string1 bit5 := ''; 
		string1 bit6 := ''; 
		string1 bit7 := ''; 
		string1 bit8 := ''; 
		string1 bit9 := ''; 
	END;

	EXPORT NPPES_Layouts := MODULE
	
		EXPORT layout_npiid := record
			string npi_id;
		end;
	
		//Removed this line as it appears that the layout was never migrated to production with these new fields
		// EXPORT temp_layout := NPPES.layouts.keybuild -[bid,bid_score];
		EXPORT temp_layout := NPPES.layouts.KeyBuild;
		
		EXPORT nppes_penalty_recs := record
			temp_layout;
			unsigned record_penalty := 0;
		end;
		
	END;
	
	Export pid_dea_rec := record
		string20	 	acctno := '';
		unsigned6 providerid;
		doxie.ingenix_provider_module.ingenix_dea_rec;
	end;
	EXPORT layout_sancid := record
		unsigned6 sanc_id;
	end;
	
	EXPORT layout_provid := record
		unsigned6 prov_id :=0;
	end;

	EXPORT deepDids := record
		doxie.layout_references;
		boolean isdeepdive := false;
	end;
	
	EXPORT deepBDids := record
		doxie_cbrs.layout_references;
		boolean isdeepdive := false;
	end;
	
	EXPORT layout_NPPES_data := record
		boolean isdeepdive := false;
		NPPES.layouts.KeyBuild;	
	end;

	EXPORT feins := RECORD
		string11 fein:='';
	END;
	
	EXPORT upins := RECORD
		string10 upin:='';
	END;
	
	EXPORT npis := RECORD
		string10 npi:='';
	END;
	
	EXPORT feins_l_c_name := RECORD
		string11 fein:='';
		string130 cname:='';
		string130 lname:='';
	END;
	
	EXPORT sanc_penalty_recs := record
		doxie_files.key_sanctions_sancid;
		unsigned record_penalty :=0;
	end;
	
	EXPORT prov_penalty_recs := record
		doxie_files.key_provider_id;
		unsigned record_penalty :=0;
	end;
	
	EXPORT layout_denormDid := record
		string did;
	end;

	EXPORT layout_denormBDid := record
		string bdid;
	end;
	EXPORT layout_providerVerify := record
		unsigned6 ProviderID:=0;
		unsigned6  SANC_ID:=0;
		string12 DID:='';
		string2	 LicenseState:='';	
		string12 LicenseNumber:='';
		string6  UPIN:='';
		string10 TaxID:='';
	end;

	EXPORT layout_ssn := record
		string12 ssn:='';
	end;
	EXPORT layout_dob := record
		string8 dob:='';
	end;
	EXPORT layout_phone := record
		string phone:='';
		string PhoneType :='';
	end;
	EXPORT layout_did := record
		unsigned6 did:=0;
		unsigned2 freq:=0;
	end;
	EXPORT layout_bdid := record
		UNSIGNED6 bdid:=0;
		unsigned2 freq:=0;
	end;
	EXPORT layout_bipkeys := record
		BIPV2.IDlayouts.l_xlink_ids;
		unsigned2 freq:=0;
	end;
	EXPORT layout_fein := record
		STRING9 fein:='';
	end;
	EXPORT layout_taxid := record
		string11 taxid:='';
	end;
	EXPORT layout_historical_record := record
		string20	 	acctno := '';
		string			processdate :=''
	end;
	EXPORT layout_upin := record
		string20	 	acctno := '';
		unsigned6 ProviderID:=0;
		string upin:='';
	end;
	EXPORT layout_child_upin := record
		string20	 	acctno := '';
		unsigned6 ProviderID:=0;
		dataset(layout_upin) childinfo;
	end;
	Export layout_acct_fein := record
		string20	 	acctno := '';
		unsigned6 ProviderID:=0;
		string9			fein:='';
	end;
	Export layout_child_fein := record
		string20	 	acctno := '';
		unsigned6 ProviderID:=0;
		dataset(layout_fein) childinfo;
	end;
	EXPORT layout_npi := record
		string20	 	acctno := '';
		unsigned6 ProviderID:=0;
		string npi:='';
		boolean usersupplied := false;
		integer bestsource := Healthcare_Header_Services.Constants.DEFAULT_BESTSCORE;
		string10 	npi_deact_date :=''; 
		string10	npi_react_date :='';
		string10	npi_enum_date :='';
		integer1	npi_type := 0;  //type 1=Ind, type2=Fac
	end;
	EXPORT layout_child_npi := record
		string20	 	acctno := '';
		unsigned6 ProviderID:=0;
		dataset(layout_npi) childinfo;
	end;
	EXPORT layout_dea := record
		string20	 	acctno := '';
		unsigned6 ProviderID:=0;
		string dea:='';
    STRING8	expiration_date := '';
    STRING1	dea_bus_act_ind := '';
		integer bestsource := Healthcare_Header_Services.Constants.DEFAULT_BESTSCORE;
		string9  	dea_num := '';
		string10 	dea_num_exp := '';
		string16  dea_num_sch := '';
		string1   dea_num_bus_act_ind := '';
		string10  dea_num_deact_date := '';
		unsigned 	dea_stat := 0;
		String8 	dea_num_status := '';
		string1 	dea_num_bus_act_sub_ind := '';
		string20  dea_num_bus_type := '';
		String100 dea_AddressLine1 := '';
		String100 dea_AddressLine2 := '';
		string10  dea_prim_range := '';
		string2   dea_predir := '';
		string28  dea_prim_name := '';
		string4   dea_addr_suffix := '';
		string2   dea_postdir := '';
		string10  dea_unit_desig := '';
		string8   dea_sec_range := '';
		string25  dea_p_city_name := '';
		string2   dea_st := '';
		string5   dea_z5 := '';
		string4   dea_zip4 := '';
		STRING10  dea_geo_lat := '';
		STRING11  dea_geo_long := '';
	end;
	EXPORT layout_child_dea := record
		string20	 	acctno := '';
		unsigned6 ProviderID:=0;
		dataset(layout_dea) childinfo;
	end;
	EXPORT layout_clianumber := record
		String15 	clianumber:='';
		string1  	clia_cert_type_code:='';
		string10  clia_end_date:='';
		STRING50  clia_lab_type_description:='';
		STRING2	 	clia_lab_term_code:='';
		string 		clia_TermCodeDesc :='';
	end;
	EXPORT layout_optout := record
		String optout_sitedesc:='';
		String8 optout_rec_dt:='';
		String8 optout_eff_dt:='';
		String8 optout_term_dt:='';
		String optout_status:='';
		String optout_last_update:='';
		String death_ind:='';
		String8 death_dt:='';
	end;
	export layout_newaffiliates := record
		string20	 	acctno := '';
		unsigned6 	ProviderID:=0;
		string12		EntityID:='';
		string1			EntityIDType:='';
		string80 		OrganizationName:='';
		string62 		ProviderFull:='';
		string20 		ProviderFirst:='';
		string20 		ProviderMiddle:='';
		string20 		ProviderLast:='';
		string5 		ProviderSuffix:='';
		string3 		ProviderPrefix:='';
		string10 		FacilityStreetNumber:='';
		string2 		FacilityStreetPreDirection:='';
		string28 		FacilityStreetName:='';
		string4 		FacilityStreetSuffix:='';
		string2 		FacilityStreetPostDirection:='';
		string10 		FacilityUnitDesignation:='';
		string8 		FacilityUnitNumber:='';
		string60 		FacilityStreetAddress1:='';
		string60 		FacilityStreetAddress2:='';
		string25 		FacilityCity:='';
		string2 		FacilityState:='';
		string5 		FacilityZip5:='';
		string4 		FacilityZip4:='';
		string10 		FacilityPhone:='';
		string10 		FacilityFax:='';
		string10 		NPI:='';
		string50		RelationshipType:='';
		string8			Effective:='';
		string8			Expiration:='';
		string50		Specialty1:='';
		string50		Specialty2:='';
		string50		PractitionerType :='';
		string20		FacilityType :='';
		string60		OrganizationType :='';
	end;
	EXPORT layout_child_newaffiliates := record
		string20	 	acctno := '';
		unsigned6 ProviderID:=0;
		dataset(layout_newaffiliates) childinfo;
	end;
	export layout_affiliateHospital := record
		string20	 	acctno := '';
		unsigned6 	ProviderID:=0;
		string 			group_key:='';
		unsigned6		bdid := 0;
		string11 		tin :='';
		string   		name := '';
		unsigned 		addrPenalty := 0;
		string80  	address1 := '';
		string10  	prim_range := '';
		string2   	predir := '';
		string28  	prim_name := '';
		string4   	addr_suffix := '';
		string2   	postdir := '';
		string10  	unit_desig := '';
		string8   	sec_range := '';
		string25  	p_city_name := '';
		string2   	st := '';
		string5   	z5 := '';
		string4   	zip4 := '';
		string10		phone := '';
		string			loc_group_key := '';
		string			bill_group_key := '';
		string			bill_NPI := '';
		boolean			worksfor := false;
	end;
	export layout_Child_affiliateHospital := record
		string20	 	acctno := '';
		unsigned6 ProviderID:=0;
		string 			group_key:='';
		dataset(layout_affiliateHospital) childinfo;
	end;


	EXPORT layout_providerID := record
		unsigned6 prov_id;
		boolean isdeepdive := false;
	end;
	EXPORT layout_SrcID := record
		string40	 	SrcId := '';//Can be provider id or ams id or HCID depending on source
		string		 	Src := '';
	end;
	export common_runtime_config := record
			unsigned1 cfg_Version := 0;	
			string25 CustomerID := Healthcare_Header_Services.Constants.CFG_CustomerID;	
			String50 OneStepRule := '';
			UNSIGNED2 penalty_threshold := Healthcare_Header_Services.Constants.CFG_penalty_threshold;
			UNSIGNED2 maxResults := Healthcare_Header_Services.Constants.CFG_maxResults;
			string	DRM := Healthcare_Header_Services.Constants.CFG_DRM;
			string	DPM := Healthcare_Header_Services.Constants.CFG_DRM;
			boolean	hasFullNCPDP := Healthcare_Header_Services.Constants.CFG_False;
			boolean	glb_ok := Healthcare_Header_Services.Constants.CFG_False;
			boolean	dppa_ok := Healthcare_Header_Services.Constants.CFG_False;
			boolean isReport := Healthcare_Header_Services.Constants.CFG_False;
			boolean isBatchService := Healthcare_Header_Services.Constants.CFG_False;
			boolean isExactAddressMatch := Healthcare_Header_Services.Constants.CFG_False;
			boolean IsShowAllDoDs := Healthcare_Header_Services.Constants.CFG_False;
			boolean doDeepDive := Healthcare_Header_Services.Constants.CFG_False;
			boolean BestOnly := Healthcare_Header_Services.Constants.CFG_False;
			boolean ShowComplete := Healthcare_Header_Services.Constants.CFG_False;
			boolean excludeSourceAMS := Healthcare_Header_Services.Constants.CFG_False;
			boolean excludeSourceNPPES := Healthcare_Header_Services.Constants.CFG_False;
			boolean excludeSourceDEA := Healthcare_Header_Services.Constants.CFG_False;
			boolean excludeSourceProfLic := Healthcare_Header_Services.Constants.CFG_False;
			boolean excludeSourceSelectFile := Healthcare_Header_Services.Constants.CFG_False;
			boolean excludeSourceCLIA := Healthcare_Header_Services.Constants.CFG_False;
			boolean excludeSourceNCPDP := Healthcare_Header_Services.Constants.CFG_False;
			boolean excludeLegacySanctions := Healthcare_Header_Services.Constants.CFG_False;
			boolean IncludeAlsoFound := Healthcare_Header_Services.Constants.CFG_False;
			boolean includeCustomerData := Healthcare_Header_Services.Constants.CFG_False;
			boolean IncludeProvidersOnly := Healthcare_Header_Services.Constants.CFG_False;
			boolean IncludeSanctionsOnly := Healthcare_Header_Services.Constants.CFG_False;
			boolean IncludeSanctions := Healthcare_Header_Services.Constants.CFG_True;
			boolean IncludeGroupAffiliations := Healthcare_Header_Services.Constants.CFG_False;
			boolean IncludeHospitalAffiliations := Healthcare_Header_Services.Constants.CFG_False;
			boolean IncludeSpecialties  := Healthcare_Header_Services.Constants.CFG_False;
			boolean IncludeLicenses  := Healthcare_Header_Services.Constants.CFG_False;
			boolean IncludeResidencies  := Healthcare_Header_Services.Constants.CFG_False;
			boolean IncludeABMSBoardCertifiedSpecialty := Healthcare_Header_Services.Constants.CFG_False;
			boolean IncludeABMSCareer := Healthcare_Header_Services.Constants.CFG_False;
			boolean IncludeABMSEducation := Healthcare_Header_Services.Constants.CFG_False;
			boolean IncludeABMSProfessionalAssociations := Healthcare_Header_Services.Constants.CFG_False;
			boolean IncludeNPI := Healthcare_Header_Services.Constants.CFG_False;
			boolean IncludeDEA := Healthcare_Header_Services.Constants.CFG_False;
			boolean IncludeCLIA := Healthcare_Header_Services.Constants.CFG_False;
			boolean IncludeNCPDP := Healthcare_Header_Services.Constants.CFG_False;
			boolean IncludeFEIN := Healthcare_Header_Services.Constants.CFG_False;
			boolean IncludeTaxonomy := Healthcare_Header_Services.Constants.CFG_False;
			boolean IncludeMedicare := Healthcare_Header_Services.Constants.CFG_False;
			boolean IncludeAffiliations := Healthcare_Header_Services.Constants.CFG_False;
			string25 transaction_id:=''; 
			string25 customer_GCID:='';
			STRING25  userid:=''; 
			UNSIGNED1 glb:=0;
			UNSIGNED1 dppa:=0;
			unsigned1 lexid_source_optout := 1;
		//	boolean log_record_source := TRUE;
			string  product_name:='';
			unsigned6 global_company_id := 0;
			string6 SSNMask:=''; 
			string6 DOBMask:=''; 
	end;

	export autokeyInput_base := record
	    Autokey_batch.Layouts.rec_inBatchMaster;
	    string20 license_number := '';
	    string2 license_state := '';
			string10	TaxID := '';
			string20 UPIN := '';	
			string20 NPI := '';	
			string20 DEA := '';	
			String15 CLIANumber := '';
			String15 NCPDPNumber := '';
			String15 MedicareNumber := '';
			UNSIGNED6 ProviderID := 0;	
			string5	 ProviderSrc := '';	
			boolean IsIndividualSearch := false;//Allow the user to force the search to be an individual
			boolean IsBusinessSearch := false;//Allow the user to force the search to be a business
			boolean IsUnknownSearchBoth := false;//Allow the user to force the search down both the Individual and Business paths
	end;
	export autokeyInput_base_validations := record
			autokeyInput_base;
			string20 DEA2 := '';	
			string50 OneStepRule := '';
			string50 MedicalSchoolNameVerification := '';
			integer  GraduationYearVerification :=0;
			String15 Taxonomy1Verification := '';
			String15 Taxonomy2Verification := '';
			String15 Taxonomy3Verification := '';
			String15 Taxonomy4Verification := '';
			String15 Taxonomy5Verification := '';
			String20 StateLicense1Verification := '';
			String2  StateLicense1StateVerification := '';
			String20 StateLicense2Verification := '';
			String2  StateLicense2StateVerification := '';
			String20 StateLicense3Verification := '';
			String2  StateLicense3StateVerification := '';
			String20 StateLicense4Verification := '';
			String2  StateLicense4StateVerification := '';
			String20 StateLicense5Verification := '';
			String2  StateLicense5StateVerification := '';
			String20 StateLicense6Verification := '';
			String2  StateLicense6StateVerification := '';
			String20 StateLicense7Verification := '';
			String2  StateLicense7StateVerification := '';
			String20 StateLicense8Verification := '';
			String2  StateLicense8StateVerification := '';
			String20 StateLicense9Verification := '';
			String2  StateLicense9StateVerification := '';
			String20 StateLicense10Verification := '';
			String2  StateLicense10StateVerification := '';
			String50 BoardCertifiedSpecialtyVerification := '';
			String50 BoardCertifiedSubSpecialtyVerification := '';
			String50 BoardCertifiedSpecialty2Verification := '';
			String50 BoardCertifiedSubSpecialty2Verification := '';
			String50 BoardCertifiedSpecialty3Verification := '';
			String50 BoardCertifiedSubSpecialty3Verification := '';
			String50 BoardCertifiedSpecialty4Verification := '';
			String50 BoardCertifiedSubSpecialty4Verification := '';
			String50 BoardCertifiedSpecialty5Verification := '';
			String50 BoardCertifiedSubSpecialty5Verification := '';
	end;
	export autokeyInput := record
			autokeyInput_base_validations;
			unsigned4 	global_sid :=0;
			unsigned4 	record_sid :=0;
			boolean hasoptout:=false;
			boolean IncludeABMSSpecialty := false;//Usage for including ABMS Records
			boolean IncludeABMSCareer := false;//Usage for including ABMS Career Records
			boolean IncludeABMSEducation := false;//Usage for including ABMS Education Records
			boolean IncludeABMSProfessionalAssociations := false;//Usage for including ABMS Professional Association Records
			boolean derivedInputRecord := false;//Usage for including derived sarch records like multiple licenses
			boolean bipExactFound := false;//Usage for helping Bip function right
	end;
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

	export Layout_Autokeys_Sanc := recordof(Ingenix_NatlProf.file_SearchAutokey_Sanctions);

	export Layout_Autokeys_AMS := recordof(AMS.Key_Autokey_Payload)-fakeid;

	export Layout_Autokeys_NPI := record
		string20 acctno := '';
		unsigned6 	ProviderID:=0;
		recordof(NPPES.Key_NPPES_Payload)-fakeid;
	end;
	export layout_nameinfo := record
		unsigned2   nameSeq := 0;
		unsigned 		namePenalty := 0;
		STRING120 	FullName := '';
		string20		FirstName := '';
		string20		MiddleName := '';
		string20		LastName := '';
		string5			Suffix := '';
		string4			Title := '';
		string6			Gender := '';
		STRING120 	CompanyName := '';
	end;
	export layout_addressphone := record
		STRING10		PhoneNumber:= '';
		STRING10		FaxNumber:= '';
	end;
	export layout_addressinfo := record
		unsigned2   addrSeq := 0;
		unsigned2   addrSeqGrp := 0;
		String1			addrGoldFlag := '';
		String5			addrConfidenceValue := '';
		String1			addrType := '';
		String1			addrTypeCode := '';
		String1			addrVerificationStatusFlag := '';
		String10		addrVerificationDate := '';
		unsigned 		addrPenalty := 0;
		string120  	address1 := '';
		string120  	address2 := '';
		string10  	prim_range := '';
		string2   	predir := '';
		string28  	prim_name := '';
		string4   	addr_suffix := '';
		string2   	postdir := '';
		string10  	unit_desig := '';
		string8   	sec_range := '';
		string25  	p_city_name := '';
		string25  	v_city_name := '';
		string2   	st := '';
		string5   	z5 := '';
		string4   	zip4 := '';
		string1   	primaryLocation := '';
		string1   	practiceAddress := '';
		string1   	BillingAddress := '';
		string8   	last_seen := '';
		string8   	first_seen := '';
		string8   	v_last_seen := '';
		string8   	v_first_seen := '';
		STRING10  	geo_lat := '';
		STRING11  	geo_long := '';
		STRING2  		fips_state := '';
		STRING3  		fips_county := '';
		STRING10		PhoneNumber := '';
		STRING10		FaxNumber := '';
		dataset(layout_addressphone) Phones := dataset([],layout_addressphone);
	end;
	export layout_SrcRec := record
		string Src := '';
		integer seq := 0;
		layout_nameinfo;
		layout_ssn;
		layout_dob;
		layout_did;
		layout_bdid -[freq];
		layout_fein;
		unsigned6 dotid:=0;
		unsigned6 empid:=0;
		unsigned6 powid:=0;
		unsigned6 proxid:=0;
		unsigned6 seleid:=0;
		unsigned6 orgid:=0;
		unsigned6 ultid:=0;
		layout_addressinfo;
	end;
	export layout_LicenseValidation := record
		unsigned2 licenseSeq := 0;
	  string	 	origLicenseState := '';
	  string	 	cleanLicenseState := '';
	  string	 	origLicenseNum := '';
	  string	 	cleanLicenseNum := '';
	  integer	 	cleanIntLicenseNum := 0;
		boolean		LicenseValid := false;
		boolean		LicenseStateValid := false;
		string		TerminationDate := '';
		boolean		TerminationDateValid := false;
	end;
	export layout_addressinfo_rolled := record
	  string20	 	acctno := '';
		layout_addressinfo
	end;
	export layout_licenseinfo := record
	  string20	 	licenseAcctno := '';
		string 			group_key:='';
		unsigned6 	ProviderID:=0;
		unsigned2   licenseSeq := 0;
		String2 		LicenseState := '';
		String			LicenseNumber := '';
		String			LicenseNumberFmt := '';
		String10		LicenseType := '';
		String10		LicenseStatus := '';
		STRING8	  	Effective_Date :='';
		STRING8	  	Termination_Date:='';
		string 			LicSortGroup:='';
	end;
	export layout_child_licenseinfo := record
	  string20	 	acctno := '';
		string 			group_key:='';
		unsigned6 ProviderID:=0;
		dataset(layout_licenseinfo) childinfo;
	end;
	Export layout_slimInput := record
		string20	 	acctno := '';
	end;

	Export layout_childDataLicense := record
		string20	 	acctno := '';
		layout_licenseinfo;
	end;

	Export layout_childDataNPI := record
		layout_npi;
	end;

	Export layout_childDataDID := record
		string20	 	acctno := '';
		layout_did;
	end;

	Export slimINGforAMSLookup := record
		layout_licenseinfo;
		layout_npi -ProviderID;
		layout_did;
	end;

	Export slimforLookup := record
		string20	 	acctno := '';
		unsigned6 	prov_id;
		string120   companyName := '';
		string28  	prim_name := '';
		string25  	p_city_name := '';
		string2   	st := '';
		string5   	z5 := '';
		layout_SrcID;
	end;

	EXPORT layout_language := RECORD	
		string20	 	acctno := '';
		unsigned6 ProviderID:=0;
		STRING40  Language;
		UNSIGNED2 LanguageTierTypeID;		
	END;
	EXPORT layout_child_language := RECORD	
		string20	 	acctno := '';
		unsigned6 ProviderID:=0;
		dataset(layout_language) childinfo;
	END;
	EXPORT layout_medschool := RECORD		     
		string20	 	acctno := '';
		unsigned6 ProviderID:=0;
		string 		group_key:='';
		STRING12  BDID;
		STRING120 MedSchoolName;
		STRING4   GraduationYear;
		UNSIGNED2 MedSchoolTierTypeID;
	END;		
	EXPORT layout_child_medschool := RECORD		     
		string20	 	acctno := '';
		unsigned6 ProviderID:=0;
		string 		group_key:='';
		dataset(layout_medschool) childinfo;
	END;		

  EXPORT layout_residency := RECORD		     
		string20	acctno := '';
		unsigned6 ProviderID:=0;
    STRING12  BDID;
    STRING120 Residency;
    UNSIGNED2 ResidencyTierTypeID;
   END;		
  EXPORT layout_child_residency := RECORD		     
		string20	acctno := '';
		unsigned6 ProviderID:=0;
		dataset(layout_residency) childinfo;
   END;		

	EXPORT layout_degree := RECORD		     
		string20	 	acctno := '';
		unsigned6 ProviderID:=0;
		STRING10  Degree;
		UNSIGNED2 DegreeTierTypeID;
	END;
	EXPORT layout_child_degree := RECORD		     
		string20	 	acctno := '';
		unsigned6 ProviderID:=0;
		dataset(layout_degree) childinfo;
	END;
	
	EXPORT layout_specialty := RECORD		     
		string20	 	acctno := '';
		unsigned6 ProviderID:=0;
		string 		group_key:='';
		UNSIGNED4 SpecialtyID;
		STRING60	SpecialtyName;
		UNSIGNED4 SpecialtyGroupID;
		STRING60  SpecialtyGroupName;
		UNSIGNED2 SpecialtyTierTypeID;
	END;
	EXPORT layout_child_specialty := RECORD		     
		string20	 	acctno := '';
		string 		group_key:='';
		unsigned6 ProviderID:=0;
		dataset(layout_specialty) childinfo;
	END;
          
	EXPORT layout_taxonomy := RECORD	
		string20	acctno := '';
		unsigned6 ProviderID:=0;
		string 		group_key:='';
		STRING50 	TaxonomyCode :='';
		STRING1	 	PrimaryIndicator:='';
		STRING80 	TaxonomyType:='';
		STRING100 Classification:='';
		STRING100 Specialization:='';
	END;	
	EXPORT layout_child_taxonomy := RECORD	
		string20	 	acctno := '';
		unsigned6 ProviderID:=0;
		string 		group_key:='';
		dataset(layout_taxonomy) childinfo;
	END;	
	EXPORT layout_slim := RECORD	
		string20	 	acctno := '';
		unsigned6 	ProviderID:=0;
		string		 	VendorID:='';
		string20		FirstName := '';
		string20		LastName := '';
		STRING120 	UserCompanyName := '';
		string120   CompanyName := '';
		string12		UserSSN := '';
		boolean			UserSSNFound := false;
		string8 		UserDOB := '';
		boolean			UserDOBFound := false;
		string9			UserFEIN := '';
		string26		UserCity := '';
		string9			UserState := '';
		string9			UserZip := '';
		boolean isDeepDiveResults:=false;
		dataset(layout_did) dids := dataset([],layout_did);
		dataset(layout_clianumber) clianumbers := dataset([],layout_clianumber);
		dataset(layout_npi) npis := dataset([],layout_npi);
	END;	
	EXPORT layout_sanctions := RECORD	
		string20	acctno := '';
		unsigned6	ProviderID:=0;
		// string 		group_key:='';
		// string10 	Src:='';
		string		GroupSancDate:='';
		integer		GroupSortOrder:=0;
		Enclarity.Layouts.sanction_base - [sanc1_desc];
		Enclarity.Layouts.Sanc_Codes_input.sanc_desc;
		Enclarity.Layouts.Sanc_Prov_Type_input.prov_type_desc;
		string 		FullDesc :=''; 
		string 		SancCategory :='';
		string 		SancLevel :='';
		string 		SancLegacyType :='';
		string 		StateOrFederal :='';
		string 		RegulatingBoard :='';
		string 		SpecialNotes :='';
		string 		SancLossOfLic :='';
		string 		LicenseStatus :='';
		boolean		isReinstatement := false;
		string sanc1_desc;
	END;	
	EXPORT layout_child_sanctions := RECORD	
		string20	acctno := '';
		unsigned6	ProviderID:=0;
		string 		group_key:='';
		dataset(layout_sanctions) childinfo;
	END;	
	EXPORT layout_LegacySanctions := RECORD	
		string20	acctno := '';
		unsigned6	ProviderID:=0;
		string 		group_key:='';
		string10 	Src:='';
		integer		GroupSortOrder:=0;
		doxie.ingenix_provider_module.ingenix_sanc_child_rec_full;
	END;	
	EXPORT layout_child_LegacySanctions := RECORD	
		string20	acctno := '';
		unsigned6	ProviderID:=0;
		string 		group_key:='';
		dataset(layout_LegacySanctions) childinfo;
	END;	
	EXPORT layout_ssns := RECORD	
		string20	acctno := '';
		unsigned6	ProviderID:=0;
		string12 	ssn:='';
		unsigned4  dob_raw:=0;
		Standard.Date.datestr  dob;
	END;	
	EXPORT layout_ssns_freq := RECORD	
		string20	acctno := '';
		unsigned6	ProviderID:=0;
		string12 	ssn:='';
		unsigned2 freq:=0;
		unsigned4  dob_raw:=0;
	END;	
	EXPORT layout_ssns_bestHit := RECORD	
		string20	acctno := '';
		unsigned6	ProviderID:=0;
		string12 	ssn:='';
		unsigned2 freq:=0;
		boolean		besthit := false;
		unsigned4  dob_raw:=0;
	END;	
	EXPORT layout_child_ssns := RECORD	
		string20	acctno := '';
		unsigned6	ProviderID:=0;
		dataset(layout_ssns) childinfo;
	END;	
	Export layout_sanc_DID := record
		string20	 	acctno := '';
		unsigned6		ProviderID:=0;
		layout_did;
	end;
	Export layout_sanc_Upin := record
		string20	 	acctno := '';
		unsigned6		ProviderID:=0;
		string 			upin:='';
	end;
	Export layout_sanc_fein := record
		string20	 	acctno := '';
		unsigned6		ProviderID:=0;
		string9			fein:='';
	end;
	Export layout_sanc_stlic := record
		string20	 	acctno := '';
		unsigned6		ProviderID:=0;
		String2 		LicenseState := '';
		String			LicenseNumber := '';
	end;
	Export layout_death_DID := record
		string20	 	acctno := '';
		unsigned6		ProviderID:=0;
		layout_did;
		string12 		ssn:='';
		boolean			UserSSNFound := false;
		string6			dob:='';
	end;
	Export layout_death := record
		string20	 	acctno := '';
		unsigned6		ProviderID:=0;
		boolean			death_ind:=false;
		string8			dod:='';
	end;
	Export layout_death_BestHit := record
		string20	 	acctno := '';
		unsigned6		ProviderID:=0;
		boolean			death_ind:=false;
		string8			dod:='';
		boolean			besthit := false;
	end;
	Export layout_slim_clia := record
		string20	 	acctno := '';
		unsigned6		ProviderID:=0;
		layout_clianumber
	end;
	Export layout_clia := record
		string20	 	acctno := '';
		unsigned6		ProviderID:=0;
		iesp.cliasearch.t_CLIARecord;
	end;
	Export layout_child_clia := record
		string20	 	acctno := '';
		unsigned6		ProviderID:=0;
		Dataset(iesp.cliasearch.t_CLIARecord) childinfo;
	end;
	Export layout_full_npi := record
		string20	acctno := '';
		unsigned6		ProviderID:=0;
		STRING9		NPPESVerified := '';
		iesp.npireport.t_NPIReport;
	end;
	Export layout_fullchild_npi := record
		string20	acctno := '';
		unsigned6		ProviderID:=0;
		STRING9		NPPESVerified := '';
		Dataset(iesp.npireport.t_NPIReport) childinfo;
	end;
	Export layout_customerDeath := record
		string20	acctno := '';
		unsigned6		ProviderID:=0;
		boolean hasoptout:=false;
		iesp.healthcare.t_StateVitalRecord;
	end;
	Export layout_fullchild_customerDeath := record
		string20	acctno := '';
		unsigned6		ProviderID:=0;
		boolean hasoptout:=false;
		Dataset(iesp.healthcare.t_StateVitalRecord) childinfo;
	end;
	Export layout_customerLicense := record
		string20	acctno := '';
		unsigned6		ProviderID:=0;
		boolean hasoptout:=false;
		iesp.healthcare.t_StateLicenseRecord;
	end;
	Export layout_fullchild_customerLicense := record
		string20	acctno := '';
		unsigned6		ProviderID:=0;
		boolean hasoptout:=false;
		Dataset(iesp.healthcare.t_StateLicenseRecord) childinfo;
	end;
	Export layout_abms := record
		string20	acctno := '';
		unsigned6		ProviderID:=0;
		iesp.abms.t_ABMSResults;
	end;
	Export layout_fullchild_abms := record
		string20	acctno := '';
		unsigned6		ProviderID:=0;
		Dataset(iesp.abms.t_ABMSResults) childinfo;
	end;

	Export Verifications := record
		String20 	acctno := '';
		String50 	VerificationConfiguration := '';
		String15 	VerificationConfigurationStatus := '';
		boolean 	VerificationConfigurationOutcome := false;
		boolean 	NameVerified := false;
		boolean 	CompanyNameVerified := false;
		boolean	 	AddressVerified := false;
		boolean	 	PhoneVerified := false;
		boolean 	SSNVerified := false;
		boolean 	FEINVerified := false;
		boolean 	FEINSuppliedExists := false;
		boolean 	MedicalSchoolNameVerified := false;
		boolean 	GraduationYearVerified := false;
		boolean 	CLIAValid := false;
		boolean 	CLIAVerified := false;
		boolean 	UPINVerified := false;
		boolean 	NPIValid := false;
		boolean 	NPISuppliedExists := false;
		boolean 	NPIVerified := false;
		boolean 	DEAValid := false;
		boolean 	DEA2Valid := false;
		boolean 	DEAVerified := false;
		boolean 	DEA2Verified := false;
		boolean 	NCPDPNumberVerified := false;
		boolean 	LicenseValid := false;
		boolean 	LicenseVerified := false;
		boolean 	License1Valid := false;
		boolean 	License1Verified := false;
		string25 	License1ResultMatch := '';
		boolean 	License2Valid := false;
		boolean 	License2Verified := false;
		string25 	License2ResultMatch := '';
		boolean 	License3Valid := false;
		boolean 	License3Verified := false;
		string25 	License3ResultMatch := '';
		boolean 	License4Valid := false;
		boolean 	License4Verified := false;
		string25 	License4ResultMatch := '';
		boolean 	License5Valid := false;
		boolean 	License5Verified := false;
		string25 	License5ResultMatch := '';
		boolean 	License6Valid := false;
		boolean 	License6Verified := false;
		string25 	License6ResultMatch := '';
		boolean 	License7Valid := false;
		boolean 	License7Verified := false;
		string25 	License7ResultMatch := '';
		boolean 	License8Valid := false;
		boolean 	License8Verified := false;
		string25 	License8ResultMatch := '';
		boolean 	License9Valid := false;
		boolean 	License9Verified := false;
		string25 	License9ResultMatch := '';
		boolean 	License10Valid := false;
		boolean 	License10Verified := false;
		string25 	License10ResultMatch := '';
		boolean 	TaxonomyVerified := false;
		boolean 	Taxonomy1Verified := false;
		boolean 	Taxonomy2Verified := false;
		boolean 	Taxonomy3Verified := false;
		boolean 	Taxonomy4Verified := false;
		boolean 	Taxonomy5Verified := false;
		boolean 	BoardCertifiedSpecialtyValid := false;
		boolean 	BoardCertifiedSpecialtyVerified := false;
		boolean 	BoardCertifiedSubSpecialtyValid := false;
		boolean 	BoardCertifiedSubSpecialtyVerified := false;
		boolean 	BoardCertifiedSpecialty1Valid := false;
		boolean 	BoardCertifiedSpecialty1Verified := false;
		boolean 	BoardCertifiedSubSpecialty1Valid := false;
		boolean 	BoardCertifiedSubSpecialty1Verified := false;
		boolean 	BoardCertifiedSpecialty2Valid := false;
		boolean 	BoardCertifiedSpecialty2Verified := false;
		boolean 	BoardCertifiedSubSpecialty2Valid := false;
		boolean 	BoardCertifiedSubSpecialty2Verified := false;
		boolean 	BoardCertifiedSpecialty3Valid := false;
		boolean 	BoardCertifiedSpecialty3Verified := false;
		boolean 	BoardCertifiedSubSpecialty3Valid := false;
		boolean 	BoardCertifiedSubSpecialty3Verified := false;
		boolean 	BoardCertifiedSpecialty4Valid := false;
		boolean 	BoardCertifiedSpecialty4Verified := false;
		boolean 	BoardCertifiedSubSpecialty4Valid := false;
		boolean 	BoardCertifiedSubSpecialty4Verified := false;
		boolean 	BoardCertifiedSpecialty5Valid := false;
		boolean 	BoardCertifiedSpecialty5Verified := false;
		boolean 	BoardCertifiedSubSpecialty5Verified := false;
		boolean 	BoardCertifiedSubSpecialty5Valid := false;
		boolean 	isAliveNoSanc := false;
		boolean 	isDead := false;
		boolean 	hasSanctions := false;
		boolean 	hasEPLSSanctions := false;
		boolean 	hasLEIESanctions := false;
		boolean 	hasDisciplinarySanctions := false;
	end;
	Export LegacyReportWithVerifications := record
		boolean	 glb_ok := false;
		boolean	 dppa_ok := false;
		doxie.ingenix_provider_module.layout_ingenix_provider_report;
		dataset(iesp.abms.t_ABMSResults) abmsRaw := dataset([],iesp.abms.t_ABMSResults);
		dataset(Verifications) VerificationInfo := dataset([],Verifications);
	end;
	Export CombinedHeaderResults := record
		string20 acctno := '';
		unsigned record_penalty :=0;
		unsigned record_penalty_name :=0;
		unsigned record_penalty_addr :=0;
		unsigned record_penalty_license :=0;
		boolean	 penalty_applied := false;
		boolean	 glb_ok := false;
		boolean	 dppa_ok := false;
		boolean  isSearchFailed := false;
		boolean hasOptout := false;
		string100 keysfailed_decode :='';
		boolean  isExactLNID := false;
		boolean  isExactDEA := false;
		boolean  isExactNPI := false;
		boolean  isExactUPIN := false;
		boolean  isExactCLIA := false;
		boolean  isExactNCPDP := false;
		boolean  isExactStateLicense := false;
		boolean  isExactSSN := false;
		boolean  isExactLNPID := false;
		boolean  isDeepDiveSSNMatch := false;
		boolean  isDeepDiveFEINMatch := false;
		boolean  isAutokeysResult := false;
		boolean  isDerivedSource := false;
		boolean  hasStateRestrict := false;
		boolean  hasOIG := false;
		boolean  hasOPM := false;
		string   medicare_fac_num := '';
		string   status := '';
		string20	FacilityType :='';
		string60	OrganizationType :='';
		dataset(layout_nameinfo) Names := dataset([],layout_nameinfo);
		dataset(layout_addressinfo) Addresses := dataset([],layout_addressinfo);
		dataset(layout_ssn) ssns := dataset([],layout_ssn);
		dataset(layout_dob) dobs := dataset([],layout_dob);
		dataset(layout_phone) phones := dataset([],layout_phone);
		dataset(layout_did) dids := dataset([],layout_did);
		dataset(layout_bdid) bdids := dataset([],layout_bdid);
		dataset(layout_bipkeys) bipkeys := dataset([],layout_bipkeys);
		dataset(layout_fein) feins := dataset([],layout_fein);
		dataset(layout_taxid) taxids := dataset([],layout_taxid);
		dataset(layout_upin) upins := dataset([],layout_upin);
		dataset(layout_npi) npis := dataset([],layout_npi);
		dataset(layout_dea) deas := dataset([],layout_dea);
		dataset(layout_clianumber) clianumbers := dataset([],layout_clianumber);
		dataset(layout_optout) optouts := dataset([],layout_optout);
		dataset(layout_licenseinfo) StateLicenses := dataset([],layout_licenseinfo);
		dataset(layout_affiliateHospital) affiliates := dataset([],layout_affiliateHospital);
		dataset(layout_affiliateHospital) hospitals := dataset([],layout_affiliateHospital);
		dataset(layout_newaffiliates) newaffiliations := dataset([],layout_newaffiliates);
		dataset(layout_language) 	Languages := dataset([],layout_language);
		dataset(layout_degree) 		Degrees := dataset([],layout_degree);
		dataset(layout_specialty) Specialties := dataset([],layout_specialty);
		dataset(layout_residency) Residencies := dataset([],layout_residency);
		dataset(layout_medschool) MedSchools := dataset([],layout_medschool);
		dataset(layout_taxonomy) 	Taxonomy := dataset([],layout_taxonomy);
		dataset(layout_SrcID) sources := dataset([],layout_SrcID);
		dataset(layout_sanctions) Sanctions := dataset([],layout_sanctions);
		dataset(layout_LegacySanctions) LegacySanctions := dataset([],layout_LegacySanctions);
		dataset(layout_SrcRec) SrcRecRaw := dataset([],layout_SrcRec);
		dataset(iesp.npireport.t_NPIReport)		NPIRaw := dataset([],iesp.npireport.t_NPIReport);
		dataset(iesp.healthcare.t_DEAControlledSubstanceRecordEx)		DEARaw := dataset([],iesp.healthcare.t_DEAControlledSubstanceRecordEx);
		dataset(iesp.proflicense.t_ProfessionalLicenseRecord)		ProfLicRaw := dataset([],iesp.proflicense.t_ProfessionalLicenseRecord);
		dataset(iesp.cliasearch.t_CLIARecord)	CLIARaw := dataset([],iesp.cliasearch.t_CLIARecord);
		dataset(iesp.ncpdp.t_PharmacyReport)	NCPDPRaw := dataset([],iesp.ncpdp.t_PharmacyReport);
		//dataset(iesp.healthcare_orgsearchandreport.t_OrganizationSearchOrganization)	HMSRaw := dataset([],iesp.healthcare_orgsearchandreport.t_OrganizationSearchOrganization);
		STRING9		NPPESVerified := '';
		unsigned6 	LNPID := 0;//Smallest SrcID within the group
		unsigned6 	SrcId := 0;//Can be provider id or ams id or HCID depending on source
		string 			VendorID := '';
		string		 	Src := '';
		string		 	SubSrc := '';
		boolean 	isBestBIPResult := false;
		boolean 	isHeaderResult := false;
		integer 	ProcessingMessage := 0;
		boolean	 	srcIndividualHeader := false;
		boolean	 	srcBusinessHeader := false;
		boolean	DeathLookup := false;
		string8	DateofDeath := '';
		dataset(iesp.abms.t_ABMSResults) abmsRaw := dataset([],iesp.abms.t_ABMSResults);
		dataset(Verifications) VerificationInfo := dataset([],Verifications);
	End;

	Export CombinedHeaderResultsDoxieLayout := record
		CombinedHeaderResults;
		dataset(layout_ssns)			SSNLookups := dataset([],layout_ssns);
		dataset(iesp.healthcare.t_StateVitalRecord) customerDeath := dataset([],iesp.healthcare.t_StateVitalRecord);
		dataset(iesp.healthcare.t_StateLicenseRecord) customerLicense := dataset([],iesp.healthcare.t_StateLicenseRecord);
	End;
	
	Export searchKeyResults := record
		string20	acctno := '';
		string		src :='';
		layout_provid;
		unsigned6 LNPID := 0;//Header ID
		String vendorid := '';//Header Vendor ID
		unsigned6 did := 0;
		unsigned6 bdid := 0;
		UNSIGNED6 UltID := 0;
		UNSIGNED6 OrgID := 0;
		UNSIGNED6 SeleID := 0;
		UNSIGNED6 ProxID := 0;
		UNSIGNED6 PowID := 0;
		UNSIGNED6 EmpID := 0;
		UNSIGNED6 DotID := 0;
		UNSIGNED6 OrphanAltUltID := 0;//In the event UltID = OrgID = SeleID = ProxID this record is the parent and point to nothing else (possible alt information)
		UNSIGNED6 OrphanAltOrgID := 0;//In the event UltID = OrgID = SeleID = ProxID this record is the parent and point to nothing else (possible alt information)
		UNSIGNED6 OrphanAltSeleID := 0;//In the event UltID = OrgID = SeleID = ProxID this record is the parent and point to nothing else (possible alt information)
		UNSIGNED6 OrphanAltProxID := 0;//In the event UltID = OrgID = SeleID = ProxID this record is the parent and point to nothing else (possible alt information)
		boolean 	isAutokeysResult := false;
		boolean derivedInputRecord := false;//Usage for including derived sarch records like multiple licenses
		boolean 	isHeaderResult := false;
		boolean 	isBIPOrphan := false;
		boolean	 glb_ok := false;
		boolean	 dppa_ok := false;
		boolean	 returnThresholdExceeded := false;
		boolean  isSearchFailed := false;
		string100 keysfailed_decode :='';
		boolean	 srcIndividualHeader := false;
		boolean	 srcBusinessHeader := false;
	End;

	Export searchKeyResults_plus_input := record 
		searchKeyResults;
		unsigned4 	global_sid :=0;
		unsigned4 	record_sid :=0;
		boolean hasoptout := false;
		string20	name_first := '';
		string20	name_middle := '';
		string20	name_last := '';
		string120 comp_name := '';
		string10	prim_range := '';
		string2 	predir := '';
		string28	prim_name := '';
		string4 	addr_suffix := '';
		string2 	postdir := '';
		string10	unit_desig := '';
		string8 	sec_range := '';
		string25	p_city_name := '';
		string2 	st := '';
		string5 	z5 := '';
		string20  UserLicenseNumber := '';
		string2 	UserLicenseState := '';
		string10	UserTaxID := '';
		string20 	UserUPIN := '';	
		string20 	UserNPI := '';	
		string20 	UserDEA := '';	
		String15 	UserCLIANumber := '';
		String15 	UserNCPDPNumber := '';
		String15 	UserMedicareNumber := '';
		String9 	UserFEIN := '';
		boolean isExactAddressMatch := false;
	End;

	Export selectfile_providers_base_with_input := record
		searchKeyResults_plus_input;
		Enclarity.Layouts.individual_base -[src,lnpid,did,bdid,DotID,EmpID,POWID,ProxID,SeleID,OrgID,UltID, 
                                        prim_range,predir,prim_name,addr_suffix,postdir,unit_desig,sec_range,p_city_name,st];
		string10	clean_prim_range := '';
		string2 	clean_predir := '';
		string28	clean_prim_name := '';
		string4 	clean_addr_suffix := '';
		string2 	clean_postdir := '';
		string10	clean_unit_desig := '';
		string8 	clean_sec_range := '';
		string25	clean_p_city_name := '';
		string2 	clean_st := '';
		string5 	clean_z5 := '';
	end;
	Export selectfile_facilities_base_with_input := record
		searchKeyResults_plus_input;
		Enclarity.Layouts.Facility_Base -[src,lnpid,bdid,DotID,EmpID,POWID,ProxID,SeleID,OrgID,UltID,
																			prim_range,predir,prim_name,addr_suffix,postdir,unit_desig,sec_range,p_city_name,st];
		integer		addr_conf_score;
		string10	clean_prim_range := '';
		string2 	clean_predir := '';
		string28	clean_prim_name := '';
		string4 	clean_addr_suffix := '';
		string2 	clean_postdir := '';
		string10	clean_unit_desig := '';
		string8 	clean_sec_range := '';
		string25	clean_p_city_name := '';
		string2 	clean_st := '';
		string5 	clean_z5 := '';
	end;
	Export ams_base_with_input := record
		searchKeyResults_plus_input;
		AMS.Layouts.KeyBuild.Main -[did,bdid];
	end;
	EXPORT ams_base_with_input_plus_penalties := RECORD
		ams_base_with_input;
		UNSIGNED2 namePenalty;
		UNSIGNED2 addrPenalty;
	END;
	Export ing_base_with_input := record
		searchKeyResults_plus_input;
		unsigned6 l_providerid;
		Ingenix_NatlProf.Layout_Provider_Base -[did];
	end;
	EXPORT ing_base_with_input_plus_penalties := RECORD
		ing_base_with_input;
		UNSIGNED2 namePenalty;
		UNSIGNED2 addrPenalty;
	END;
	Export dea_base_with_input := record
		searchKeyResults_plus_input;
		unsigned6 l_providerid;
		DEA.Layout_DEA_In_Modified rawData;
		STRING18 county_name := '';
		STRING3  score;
		STRING9  best_ssn;
	end;
	Export npi_base_with_input := record
		searchKeyResults_plus_input;
		unsigned6 l_providerid;
		NPPES.layouts.keybuild -[did,bdid];
	end;
	Export proflic_base_with_input := record
		searchKeyResults_plus_input;
		unsigned6 l_providerid;
		recordof(Prof_LicenseV2.Key_ProfLic_Id()) rawData;
	end;
	Export clia_base_with_input := record
		searchKeyResults_plus_input;
		clia.Layouts.KeyBuild -[did,bdid];
		string TermCodeDesc :='';
	end;
	Export ncpdp_base_with_input := record
		searchKeyResults_plus_input;
		NCPDP.Layouts.Keybuild -[did,bdid,DotID,EmpID,POWID,ProxID,SeleID,OrgID,UltID];
	end;
	Export bocahdr_base_with_input := record
		searchKeyResults_plus_input;
		unsigned6 l_providerid;
		recordof(doxie.key_header) rawData;
	end;
	
	Export hms_base_with_input := record
		searchKeyResults_plus_input;
		unsigned6 l_providerid;
		Org_Mast.layouts.organization_base rawdata;
	end;

	Export hms_Indivbase_with_input := record
		searchKeyResults_plus_input;
		unsigned6 l_providerid;
		HMS_STLIC.Layouts.statelicense_base rawdata;
		//Org_Mast.layouts.organization_base rawdata;//Update to final base file
	end;
end;