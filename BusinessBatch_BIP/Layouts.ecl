IMPORT Address,Batchshare,BIPV2,BIPV2_Best,BizLinkFull,Corp2, UCCV2;

EXPORT Layouts := MODULE

	EXPORT Input := RECORD
		STRING20  acctno;
		STRING120 comp_name;
		STRING10  prim_range;
		STRING2   predir;
		STRING28  prim_name;
		STRING4   addr_suffix;
		STRING2   postdir;
		STRING10  unit_desig;
		STRING8   sec_range;
		STRING25  city_name;
		STRING2   st;
		STRING5   z5;
		STRING4   zip4;
		STRING3   mileradius;
		STRING16  workphone;
		STRING9   fein;
		UNSIGNED6 seleid;
	END;
	
  EXPORT Input_Processed :=
	RECORD(Input)
    STRING20 orig_acctno := '';
    Batchshare.Layouts.ShareErrors;
  END;
	
  EXPORT scored := 
	RECORD
	  INTEGER2 record_score;
		INTEGER2 weight;
	END;
	
	EXPORT TopLinkids :=
	RECORD
		UNSIGNED6 ultid;
		UNSIGNED6 orgid;
		UNSIGNED6 seleid;
		UNSIGNED6 proxid;
		UNSIGNED6 powid;
		UNSIGNED6 empid;
		UNSIGNED6 dotid;
  END;		
	
  EXPORT LinkIdsWithAcctNo :=
  RECORD
    STRING20 acctno;
    BIPV2.IDlayouts.l_header_ids;
		scored;
  END;
  
  EXPORT Phones :=
  RECORD
    STRING20  acctno;
    BIPV2.IDlayouts.l_header_ids;
    STRING10  phone10;
		STRING10  dt_first_seen;
		STRING10  dt_last_seen;
  END;
	
	EXPORT BankruptcyInfo :=
	RECORD
	   STRING20 acctno;
		 BIPV2.IDlayouts.l_header_ids;
		 STRING10 Bankruptcy_date_filed;
		 UNSIGNED2 total_Bankruptcies;
	END;
	
	EXPORT PropertyInfo :=
	RECORD
	   STRING20 acctno;
		 BIPV2.IDlayouts.l_header_ids;
		 // STRING4   Own_rent;  // wether or not the business owns or rents at the bus addr.
		                     // values: 'Own' OR 'Rent'
		 UNSIGNED2 Property_owned; // count of # of properties owned or associated 
		                           // with this busines
		 UNSIGNED4 Property_owned_size;
		 STRING  sProperty_owned_size;
		 //STRING100 Input_residential; // Y or N for a residential address		 
	END;
	EXPORT PropertyInfoExtra :=
	RECORD
	   PropertyInfo;
		 UNSIGNED6 seq;
		 STRING20 ln_fares_id;
		 STRING45  apnt_or_pin_number;
		 STRING SortByDate;
		 STRING1 Buyer_Or_Borrower_Ind;
	END;
	
	EXPORT watchListInfo := 
	RECORD
	   STRING20 acctno;
		 BIPV2.IDlayouts.l_header_ids;
	   STRING3 gov_debarred;
		 STRING10 gov_debarred_start_date;
		 STRING10 gov_debarred_exp_date;
		 STRING3 Ofac_auth_rep;
		 STRING3 Ofac_business;
  END;
	
	EXPORT LienInfo :=
	RECORD
	   STRING20 acctno;
		 BIPV2.IDlayouts.l_header_ids;
		 STRING10 Judgment_Liens_date_filed;
		 UNSIGNED2 total_Judgments_and_Liens;
		 UNSIGNED2 judgments_Liens_satisfied;
	END;
  
	EXPORT LienInfoExtra :=
	RECORD
	   LienInfo; 
		 BOOLEAN LienRowJudgmentIsSatisfied;
	END;
  
	EXPORT uccInfo := RECORD
	  STRING20 acctno;
		STRING10 ucc_date_filed;
		UNSIGNED2 total_UCC;
		UNSIGNED2 total_UCC_released;
		BIPV2.IDlayouts.l_header_ids;
	  STRING2   source; 
		UCCV2.Layout_UCC_Common.Layout_party_With_AID.tmsid; //needed for linking to the ucc main & party keys
		UCCV2.Layout_UCC_Common.Layout_party_With_AID.rmsid; 
    // v--- report output/needed fields from the ucc main (tmsid/rmsid) key file
		UCCV2.Layout_UCC_Common.Layout_ucc_new.filing_jurisdiction;
		UCCV2.Layout_UCC_Common.Layout_ucc_new.orig_filing_number;		
		//UCCV2.Layout_UCC_Common.Layout_ucc_new.orig_filing_type;	// not needed ???
		UCCV2.Layout_UCC_Common.Layout_ucc_new.orig_filing_date;	
		UCCV2.Layout_UCC_Common.Layout_ucc_new.filing_number;
		UCCV2.Layout_UCC_Common.Layout_ucc_new.filing_type;	
		UCCV2.Layout_UCC_Common.Layout_ucc_new.filing_date;	
		UCCV2.Layout_UCC_Common.Layout_ucc_new.expiration_date;
		UCCV2.Layout_UCC_Common.Layout_ucc_new.filing_agency;
		UCCV2.Layout_UCC_Common.Layout_ucc_new.address;
		UCCV2.Layout_UCC_Common.Layout_ucc_new.city;
		UCCV2.Layout_UCC_Common.Layout_ucc_new.state;
		UCCV2.Layout_UCC_Common.Layout_ucc_new.zip;
		//v--- will be split apart into 100 byte fields???
		UCCV2.Layout_UCC_Common.Layout_ucc_new.collateral_desc; 
    // other fields from the ucc main (tmsid/rmsid) key file for internal processing
		UCCV2.Layout_UCC_Common.Layout_ucc_new.process_date; // needed for sorting
		//string8   filing_status; //might need to be used to determine overall ucc status???
		UCCV2.Layout_UCC_Common.Layout_ucc_new.status_type; //used to determine overall ucc status
		// v--- derived fields for internal processing
		string1   status_code; // derived field to indicate A(active) or T(terminated)
		//rec_ids_with_linkidsdata_slimmed.role_type; //carried forward from linkids key, D, S or A
	  unsigned4 total_as_debtor  := 0;
		unsigned4 total_as_secured := 0;
	END;
  
	EXPORT UCCInfoExtra :=
	RECORD
	   UCCInfo;
		 BOOLEAN UCCIsReleased;
	END;
  
	EXPORT UCCInfoExtraSlim :=
	RECORD
	   STRING20 acctno;
		STRING10 ucc_date_filed;
		UNSIGNED2 total_UCC;
		UNSIGNED2 total_UCC_released;
		BIPV2.IDlayouts.l_header_ids;	
		BOOLEAN UCCIsReleased;
	END;
  
	EXPORT UCCInfoLayout :=
	RECORD
	  STRING20 acctno;
		STRING10 ucc_date_filed;
		UNSIGNED2 total_UCC;
		UNSIGNED2 total_UCC_released;
		BIPV2.IDlayouts.l_header_ids;	
	END;
	
  EXPORT Corps :=
  RECORD
    STRING20  acctno;
    BIPV2.IDlayouts.l_header_ids;
		STRING10 corp_filing_jurisdiction;
	  Corp2.Layout_Corporate_Direct_Corp_Base.corp_ra_name;
    Corp2.Layout_Corporate_Direct_Corp_Base.corp_ra_title1;
	  Corp2.Layout_Corporate_Direct_Corp_Base.corp_ra_fname1;
	  Corp2.Layout_Corporate_Direct_Corp_Base.corp_ra_mname1;
	  Corp2.Layout_Corporate_Direct_Corp_Base.corp_ra_lname1;
    Corp2.Layout_Corporate_Direct_Corp_Base.corp_ra_name_suffix1;
    Corp2.Layout_Corporate_Direct_Corp_Base.corp_ra_cname1;
    Corp2.Layout_Corporate_Direct_Corp_Base.corp_ra_phone10;
		Corp2.Layout_Corporate_Direct_Corp_Base.corp_sos_charter_nbr;
		Corp2.Layout_Corporate_Direct_Corp_Base.dt_first_seen;
		Corp2.Layout_Corporate_Direct_Corp_Base.dt_last_seen;
		Corp2.Layout_Corporate_Direct_Corp_Base.corp_state_origin;
		Corp2.Layout_Corporate_Direct_Corp_Base.corp_foreign_domestic_ind;
		Corp2.Layout_Corporate_Direct_Corp_Base.corp_for_profit_ind;
		Corp2.Layout_Corporate_Direct_Corp_Base.corp_term_exist_cd;
		Corp2.Layout_Corporate_Direct_Corp_Base.corp_term_exist_exp;
		Corp2.Layout_Corporate_Direct_Corp_Base.corp_term_exist_desc;
		Corp2.Layout_Corporate_Direct_Corp_Base.corp_forgn_term_exist_cd;
		Corp2.Layout_Corporate_Direct_Corp_Base.corp_forgn_term_exist_exp;
		Corp2.Layout_Corporate_Direct_Corp_Base.corp_forgn_term_exist_desc;
		Corp2.Layout_Corporate_Direct_Corp_Base.corp_status_desc;
		Corp2.Layout_Corporate_Direct_Corp_Base.corp_filing_date;
		// adding these fields
		Corp2.Layout_Corporate_Direct_Corp_Base.corp_filing_desc;		
		Corp2.layout_corporate_Direct_corp_base.corp_orig_org_structure_desc;	
		Corp2.layout_corporate_Direct_corp_base.corp_orig_bus_type_desc;
		Corp2.layout_corporate_Direct_corp_base.corp_name_comment;																		
  END;

  EXPORT Flags :=
  RECORD
    STRING20 acctno;
    BIPV2.IDlayouts.l_header_ids;
		STRING1 vehicles;
		STRING1 aircraft;
		STRING1 watercraft;
    STRING1 judgmentlien_flag;
    STRING1 property_flag;
    STRING1 ucc_flag;
  END;
  
  EXPORT Executives :=
  RECORD
    STRING20 acctno;
    BIPV2.IDlayouts.l_header_ids;
    Address.layout_clean_name;
    BIPV2.Layout_Business_Linking_Full.contact_job_title_derived;
		STRING10 dt_first_seen_Contact;
		STRING10 dt_last_seen_Contact;
		unsigned6 contact_did;
  END;
  
  EXPORT DCAInfo :=
  RECORD
    STRING20 acctno;
    BIPV2.IDlayouts.l_header_ids;
    STRING10 num_employees;
		STRING10 sales_or_revenue;
		STRING15 sales;
  END;
  
	EXPORT DivCertInfo :=
	RECORD
	  STRING20 acctno;
		BIPV2.IDlayouts.l_header_ids;
		STRING8  div_dt_first_seen;
		STRING8  div_dt_last_seen;
		STRING2  div_state;
		STRING80 div_minorityAffiliation;
	  STRING80 div_certificationtype1;
    STRING8  div_certificatedatefrom1;
	  STRING8  div_certificatedateto1;
    STRING80 div_certificatestatus1;
		STRING60 div_certificatenumber1;
    STRING80 div_certificationtype2;
    STRING8  div_certificatedatefrom2;
		STRING8  div_certificatedateto2;
    STRING80 div_certificatestatus2;
		STRING60 div_certificatenumber2;
    STRING80 div_certificationtype3;
		STRING8  div_certificatedatefrom3;
		STRING8  div_certificatedateto3;
    STRING80 div_certificatestatus3;
    STRING60 div_certificatenumber3;
    STRING80 div_certificationtype4;
		STRING8  div_certificatedatefrom4;
		STRING8  div_certificatedateto4;
    STRING80 div_certificatestatus4;
    STRING60 div_certificatenumber4;
	END;
	
	EXPORT LaborActionsWHDInfo :=
	RECORD
	  STRING20 acctno;
		BIPV2.IDlayouts.l_header_ids;
		STRING15 laborActionViolations;
		STRING15 laborActionBackWages;
		STRING15 laborActionMoneyPenalties;		
	END;
	
	EXPORT OSHAInspectionInfo :=
	RECORD
	  STRING20 acctno;
		BIPV2.IDlayouts.l_header_ids;		
		unsigned2 OshaViolations;		
  END;		
		
	EXPORT PARENT_FINAL := record	  
		STRING120 parent_company_name;
		STRING10  parent_prim_range;
		STRING2   parent_predir;
		STRING28  parent_prim_name;
		STRING4   parent_addr_suffix;
		STRING2   parent_postdir;
		STRING10  parent_unit_desig;
		STRING8   parent_sec_range;
		STRING25  parent_city;
		STRING2   parent_state;
		STRING5   parent_zip;
		STRING4   parent_zip4;
		STRING10  parent_phone;
		STRING1   parent_sub;
	END;
  
	EXPORT fein_final := RECORD
		STRING20 Acctno;
		TopLinkids;
	  STRING9   fein_var1;
		STRING9   fein_var2;
		STRING9   fein_var3;
		STRING9   fein_var4;
		STRING9   fein_var5;
		STRING9   fein_var6;
		STRING9   fein_var7;
		STRING9   fein_var8;
		STRING9   fein_var9;
		unsigned2 Total_fein;
	END;
	
	EXPORT BusinessType_Final := RECORD
		STRING20 Acctno;
		TopLinkids;
		STRING20 Business_type;
	END;
	
	EXPORT YrsInBus_Final := RECORD
	  STRING20 Acctno;
		TopLinkids;
		STRING3 Years_in_Business;
		STRING10 Corp_filing_date;
		STRING1  Input_residential;
    // STRING10 Years_inBusiness_2;
		// STRING10 Years_inBusiness_3;
		// STRING10 Years_inBusiness_4;
		// STRING10 Years_inBusiness_5;
		// STRING10 Years_inBusiness_6;
		// STRING10 Years_inBusiness_7;
		// STRING10 Years_inBusiness_8;
    // STRING10 Years_inBusiness_9;
		// STRING10 Years_inBusiness_10;
  END;
	
	EXPORT cName_FINAL := RECORD
    STRING20 Acctno;
		TopLinkids;
	  STRING120 Company_name_var1;
		STRING10  Company_name_var1_first_seen;
		STRING10  Company_name_var1_last_seen;
		STRING120 Company_name_var2;
		STRING10  Company_name_var2_first_seen;
		STRING10  Company_name_var2_last_seen;
		STRING120 Company_name_var3;
		STRING10  Company_name_var3_first_seen;
		STRING10  Company_name_var3_last_seen;
		STRING120 Company_name_var4;
		STRING10  Company_name_var4_first_seen;
		STRING10  Company_name_var4_last_seen;
		STRING120 Company_name_var5;
		STRING10  Company_name_var5_first_seen;
		STRING10  Company_name_var5_last_seen;
		STRING120 company_name_var6;
		STRING10  Company_name_var6_first_seen;
		STRING10  Company_name_var6_last_seen;
		STRING120 company_name_var7;
		STRING10  Company_name_var7_first_seen;
		STRING10  Company_name_var7_last_seen;
		STRING120 Company_name_var8;
		STRING10  Company_name_var8_first_seen;
		STRING10  Company_name_var8_last_seen;
		STRING120 Company_name_var9;
		STRING10  Company_name_var9_first_seen;
		STRING10  Company_name_var9_last_seen;
	END;
	
	EXPORT ADDRESS_Final := RECORD
		STRING20  Acctno;
		TopLinkids;
		STRING10  prim_range_var1;
		STRING2   predir_var1;
		STRING28  prim_name_var1;
		STRING4   addr_suffix_var1;
		STRING2   postdir_var1;
		STRING10  unit_desig_var1;
		STRING8   sec_range_var1;
		STRING25  city_var1;
		STRING2   state_var1;
		STRING5   zip_var1;
		STRING4   zip4_var1;
    UNSIGNED4 dt_first_seen_var1;
    UNSIGNED4 dt_last_seen_var1;
		STRING20  county_var1;
		STRING30  address_type_var1;
		STRING10  Address_status_var1;
		
		STRING10  prim_range_var2;
		STRING2   predir_var2;
		STRING28  prim_name_var2;
		STRING4   addr_suffix_var2;
		STRING2   postdir_var2;
		STRING10  unit_desig_var2;
		STRING8   sec_range_var2;
		STRING25  city_var2;
		STRING2   state_var2;
		STRING5   zip_var2;
		STRING4   zip4_var2;
    UNSIGNED4  dt_first_seen_var2;
    UNSIGNED4  dt_last_seen_var2;
		STRING20  county_var2;
		STRING30  address_type_var2;
		STRING10  Address_status_var2;
		STRING50  url_var2;
		
		STRING10  prim_range_var3;
		STRING2   predir_var3;
		STRING28  prim_name_var3;
		STRING4   addr_suffix_var3;
		STRING2   postdir_var3;
		STRING10  unit_desig_var3;
		STRING8   sec_range_var3;
		STRING25  city_var3;
		STRING2   state_var3;
		STRING5   zip_var3;
		STRING4   zip4_var3;
    UNSIGNED4  dt_first_seen_var3;
    UNSIGNED4  dt_last_seen_var3;
		STRING20  county_var3;
		STRING30  address_type_var3;
		STRING10  Address_status_var3;
		STRING50  url_var3;  // they only want up to 3 URL variations thus stopping
		// here
		
		STRING10  prim_range_var4;
		STRING2   predir_var4;
		STRING28  prim_name_var4;
		STRING4   addr_suffix_var4;
		STRING2   postdir_var4;
		STRING10  unit_desig_var4;
		STRING8   sec_range_var4;
		STRING25  city_var4;
		STRING2   state_var4;
		STRING5   zip_var4;
		STRING4   zip4_var4;
    UNSIGNED4  dt_first_seen_var4;
    UNSIGNED4  dt_last_seen_var4;
		STRING20  county_var4;
		STRING30  address_type_var4;
		STRING10  Address_status_var4;
		
		STRING10  prim_range_var5;
		STRING2   predir_var5;
		STRING28  prim_name_var5;
		STRING4   addr_suffix_var5;
		STRING2   postdir_var5;
		STRING10  unit_desig_var5;
		STRING8   sec_range_var5;
		STRING25  city_var5;
		STRING2   state_var5;
		STRING5   zip_var5;
		STRING4   zip4_var5;
    UNSIGNED4  dt_first_seen_var5;
    UNSIGNED4  dt_last_seen_var5;
		STRING20  county_var5;
		STRING30  address_type_var5;
		STRING10  Address_status_var5;
		
		STRING10  prim_range_var6;
		STRING2   predir_var6;
		STRING28  prim_name_var6;
		STRING4   addr_suffix_var6;
		STRING2   postdir_var6;
		STRING10  unit_desig_var6;
		STRING8   sec_range_var6;
		STRING25  city_var6;
		STRING2   state_var6;
		STRING5   zip_var6;
		STRING4   zip4_var6;
    UNSIGNED4  dt_first_seen_var6;
    UNSIGNED4  dt_last_seen_var6;
		STRING20  county_var6;
		STRING30  address_type_var6;
		STRING10  Address_status_var6;
		
		STRING10  prim_range_var7;
		STRING2   predir_var7;
		STRING28  prim_name_var7;
		STRING4   addr_suffix_var7;
		STRING2   postdir_var7;
		STRING10  unit_desig_var7;
		STRING8   sec_range_var7;
		STRING25  city_var7;
		STRING2   state_var7;
		STRING5   zip_var7;
		STRING4   zip4_var7;
    UNSIGNED4  dt_first_seen_var7;
    UNSIGNED4  dt_last_seen_var7;
		STRING20  county_var7;
		STRING30  address_type_var7;
		STRING10  Address_status_var7;
		
		STRING10  prim_range_var8;
		STRING2   predir_var8;
		STRING28  prim_name_var8;
		STRING4   addr_suffix_var8;
		STRING2   postdir_var8;
		STRING10  unit_desig_var8;
		STRING8   sec_range_var8;
		STRING25  city_var8;
		STRING2   state_var8;
		STRING5   zip_var8;
		STRING4   zip4_var8;
    UNSIGNED4  dt_first_seen_var8;
    UNSIGNED4  dt_last_seen_var8;
		STRING20  county_var8;
		STRING30  address_type_var8;
		STRING10  Address_status_var8;
		
		STRING10  prim_range_var9;
		STRING2   predir_var9;
		STRING28  prim_name_var9;
		STRING4   addr_suffix_var9;
		STRING2   postdir_var9;
		STRING10  unit_desig_var9;
		STRING8   sec_range_var9;
		STRING25  city_var9;
		STRING2   state_var9;
		STRING5   zip_var9;
		STRING4   zip4_var9;
    UNSIGNED4  dt_first_seen_var9;
    UNSIGNED4 dt_last_seen_var9;	
		STRING20  county_var9;
		STRING30  address_type_var9;
		STRING10  Address_status_var9;
		
		UNSIGNED2 total_addresses;
	END;
	
	EXPORT BEST_FINAL := record
	  STRING20  acctno;
		TopLinkids;
	  STRING120 best_company_name;
		STRING10  best_prim_range;
		STRING2   best_predir;
		STRING28  best_prim_name;
		STRING4   best_addr_suffix;
		STRING2   best_postdir;
		STRING10  best_unit_desig;
		STRING8   best_sec_range;
		STRING25  best_city;
		STRING2   best_state;
		STRING5   best_zip;
		STRING4   best_zip4;
		STRING20  best_County;
    UNSIGNED4 best_dt_first_seen;
    UNSIGNED4 best_dt_last_seen;
		STRING10  best_phone;		
		STRING9   best_fein;
		STRING8   best_sic_code;
		STRING80  best_SIC_Description;
		STRING10  best_naics_code;
		STRING120 best_NAICS_DESCRIPTION;
		STRING10  best_address_status;
		STRING30  best_address_type;
		STRING30  status;
		STRING50  url;
		STRING50  email;
		STRING3   Years_in_business;
		STRING60 Business_Type; // pulled from bip v2 header.. similar to corp_filing_type below 
		STRING1 Input_residential;
		UNSIGNED2  Input_total_businesses_active;
		UNSIGNED2  Input_total_businesses_history;
		PARENT_FINAL;		
	END;
	
	EXPORT BestLayout := RECORD
		Best_Final; 
		address_Final - [acctno, ultid, orgid, seleid] - TopLinkids;
		cname_final - [acctno, ultid, orgid, seleid] - TopLinkids;
	END;
	EXPORT BestLayoutWithFeinVarsTmp := RECORD(BestLayout)
		fein_final - [acctno, ultid, orgid, seleid] - TopLinkids;
		INTEGER2 record_score;
	END;
	
	EXPORT BestLayoutWithFeinVars := RECORD(BestLayout)
		fein_final - [acctno, ultid, orgid, seleid] - TopLinkids;
	END;

  

  EXPORT BusHeaderMetaData := RECORD
	  STRING20  acctno;
		STRING50  Business_Status;
	  STRING120 dba_name_var1;
		STRING120 dba_name_var2;
		STRING120 dba_name_var3;
		STRING120 dba_name_var4;
		STRING120 dba_name_var5;
		STRING120 dba_name_var6;
		STRING120 dba_name_var7;
		STRING120 dba_name_var8;
		STRING120 dba_name_var9;
		 
		STRING8   sic_code_var1;
		STRING80  SIC_Description_var1 := '';
		STRING8   sic_code_var2;
		STRING80  SIC_Description_var2 := '';
		STRING8   sic_code_var3;
		STRING80  SIC_Description_var3 := '';
		STRING8   sic_code_var4;
		STRING80  SIC_Description_var4 := '';
		STRING8   sic_code_var5;
		STRING80  SIC_Description_var5 := '';
		STRING8   sic_code_var6;
		STRING80  SIC_Description_var6 := '';
		STRING8   sic_code_var7;
		STRING80  SIC_Description_var7 := '';
		STRING8   sic_code_var8;
		STRING80  SIC_Description_var8 := '';
		STRING8   sic_code_var9;
		STRING80  SIC_Description_var9 := '';
	
		STRING8   naics_code_var1;
		STRING120 NAICS_Description_var1 := '';
		STRING8   naics_code_var2;
		STRING120 NAICS_Description_var2 := '';
		STRING8   naics_code_var3;
		STRING120 NAICS_Description_var3 := '';
		STRING8   naics_code_var4;
		STRING120 NAICS_Description_var4 := '';
		STRING8   naics_code_var5;	
		STRING120 NAICS_Description_var5 := '';
		STRING8   naics_code_var6;
		STRING120 NAICS_Description_var6 := '';
		STRING8   naics_code_var7;
		STRING120 NAICS_Description_var7 := '';
		STRING8   naics_code_var8;
		STRING120 NAICS_Description_var8 := '';
		STRING8   naics_code_var9;
		STRING120 NAICS_Description_var9 := '';
	END;
	
	EXPORT BusHeaderMetaDataTmp := RECORD
	  BestLayoutWithFeinVars;
		BusHeaderMetaData - [acctno];
		scored;
	END;
  
	EXPORT BusHeaderMetaDataFinal := RECORD
	  BestLayoutWithFeinVars;
		BusHeaderMetaData - [acctno];
	END;
	
	EXPORT Final := RECORD
		STRING20  acctno;
		BusHeaderMetaDataFinal - [acctno];
		                              
    
		Flags - [acctno] - BIPV2.IDlayouts.l_header_ids;
		
		BankruptcyInfo - [acctno] - BIPV2.IDlayouts.l_header_ids;
		LienInfo - [acctno] - BIPV2.IDlayouts.l_header_ids;
		UCCInfoLayout - [acctno] - BIPV2.IDLayouts.l_header_ids;		
		PropertyInfo - [acctno,sproperty_owned_size] - BIPV2.IDLayouts.l_header_ids;
		watchListInfo - [acctno] - BIPV2.IDLayouts.l_header_ids;
		DivCertInfo - [acctno] - BIPV2.IDlayouts.l_header_ids;
		LaborActionsWHDInfo - [acctno] - BIPV2.IDlayouts.l_header_ids;
		OSHAInspectionInfo - [acctno] - BIPV2.idlayouts.l_header_ids;
		STRING5   ra_title;
		STRING20  ra_fname;
		STRING20  ra_mname;
		STRING20  ra_lname;
		STRING5   ra_name_suffix;
		STRING120 ra_cname;
		STRING10  ra_phone;
		
		 // same as corp_filing_type below 
	  STRING10  Foreign_domestic_status; // (values of foreign or domestic)
		                                 // Case on F or D (field: corp_foreign_domestic_ind)
	  STRING3   Profit;    // values of 'yes' (for profit) or 'no' (not for profit).
		                     // field: corp_for_profit_ind
    STRING3   state_of_origin;   //field : corp_state_origin				
		
		STRING10  corp_expiration_date;
		STRING10  corp_filing_jurisdiction;
		
		STRING60  corp_status_desc;
		STRING10  corp_filing_date;		
		STRING50  corp_filing_type; // adding this field JIRA 13498 from field corp_filing_desc
		// ******
		
		// ********
		// disclaimer:  field names are not very descriptive 
		// layout changes done here are only done at product request to meet requirements which
		// don't have descriptive field names.
		STRING20  corp_var1;
		STRING10  corp_var1_first_seen;
		STRING10  corp_var1_last_seen;
		STRING3   corp_var1_state_origin;
		
	  STRING20  corp_var2;
		STRING10  corp_var2_first_seen;
		STRING10  corp_var2_last_seen;
		STRING3   corp_var2_state_origin;
		
		STRING20  corp_var3;
		STRING10  corp_var3_first_seen;
		STRING10  corp_var3_last_seen;
		STRING3   corp_var3_state_origin;
		
		STRING20  corp_var4;
		STRING10  corp_var4_first_seen;
		STRING10  corp_var4_last_seen;
		STRING3   corp_var4_state_origin;
		
		STRING20  corp_var5;
		STRING10  corp_var5_first_seen;
		STRING10  corp_var5_last_seen;
		STRING3   corp_var5_state_origin;
		
		STRING20  corp_var6;
		STRING10  corp_var6_first_seen;
		STRING10  corp_var6_last_seen;
		STRING3   corp_var6_state_origin;
		
		STRING20  corp_var7;
		STRING10  corp_var7_first_seen;
		STRING10  corp_var7_last_seen;
		STRING3   corp_var7_state_origin;
		
		STRING20  corp_var8;
		STRING10  corp_var8_first_seen;
		STRING10  corp_var8_last_seen;
		STRING3   corp_var8_state_origin;
		
		STRING20  corp_var9;
		STRING10  corp_var9_first_seen;
		STRING10  corp_var9_last_seen;
		STRING3   corp_var9_state_origin;
		
		STRING20  corp_var10;
		STRING10  corp_var10_first_seen;
		STRING10  corp_var10_last_seen;			
		STRING3   corp_var10_state_origin;
		
		UNSIGNED2 total_Corp;
		
		STRING10  num_employees;
		STRING10  sales_or_revenue;
		STRING15  sales;
     
		// STRING10  best_phone_dt_first_seen;
		// STRING10  best_phone_dt_last_seen;
		STRING10  phone_var1;
		STRING10  phone_var1_last_seen;
		STRING10  phone_var1_first_seen;
		STRING10  phone_var2;
		STRING10  phone_var2_last_seen;
		STRING10  phone_var2_first_seen;
		STRING10  phone_var3;
		STRING10  phone_var3_last_seen;
		STRING10  phone_var3_first_seen;
		STRING10  phone_var4;
		STRING10  phone_var4_last_seen;
		STRING10  phone_var4_first_seen;
		STRING10  phone_var5;
		STRING10  phone_var5_last_seen;
		STRING10  phone_var5_first_seen;
		STRING10  phone_var6;
		STRING10  phone_var6_last_seen;
		STRING10  phone_var6_first_seen;
		STRING10  phone_var7;
	  STRING10  phone_var7_last_seen;
		STRING10  phone_var7_first_seen;
		STRING10  phone_var8;
		STRING10  phone_var8_last_seen;
		STRING10  phone_var8_first_seen;
		STRING10  phone_var9;
		STRING10  phone_var9_last_seen;
		STRING10  phone_var9_first_seen;
    UNSIGNED2 total_phones;
		UNSIGNED6 executive_var1_lexid;
		STRING5   executive_title_var1;
		STRING20  executive_fname_var1;
		STRING20  executive_mname_var1;
		STRING20  executive_lname_var1;
		STRING5   executive_name_suffix_var1;
		STRING60  executive_display_title_var1;
   	STRING10  executive_var1_first_seen;
	  STRING10  executive_var1_last_seen;
		UNSIGNED6 executive_var2_lexid;
		STRING5   executive_title_var2;
		STRING20  executive_fname_var2;
		STRING20  executive_mname_var2;
		STRING20  executive_lname_var2;
		STRING5   executive_name_suffix_var2;
		STRING60  executive_display_title_var2;
		STRING10  executive_var2_first_seen;
	  STRING10  executive_var2_last_seen;
		UNSIGNED6 executive_var3_lexid;
		STRING5   executive_title_var3;
		STRING20  executive_fname_var3;
		STRING20  executive_mname_var3;
		STRING20  executive_lname_var3;
		STRING5   executive_name_suffix_var3;
		STRING60  executive_display_title_var3;
		STRING10  executive_var3_first_seen;
	  STRING10  executive_var3_last_seen;
		UNSIGNED6 executive_var4_lexid;
		STRING5   executive_title_var4;
		STRING20  executive_fname_var4;
		STRING20  executive_mname_var4;
		STRING20  executive_lname_var4;
		STRING5   executive_name_suffix_var4;
		STRING60  executive_display_title_var4;
		STRING10  executive_var4_first_seen;
	  STRING10  executive_var4_last_seen;
		UNSIGNED6 executive_var5_lexid;
		STRING5   executive_title_var5;
		STRING20  executive_fname_var5;
		STRING20  executive_mname_var5;
		STRING20  executive_lname_var5;
		STRING5   executive_name_suffix_var5;
		STRING60  executive_display_title_var5;
		STRING10  executive_var5_first_seen;
	  STRING10  executive_var5_last_seen;
		UNSIGNED6 executive_var6_lexid;
		STRING5   executive_title_var6;
		STRING20  executive_fname_var6;
		STRING20  executive_mname_var6;
		STRING20  executive_lname_var6;
		STRING5   executive_name_suffix_var6;
		STRING60  executive_display_title_var6;
		STRING10  executive_var6_first_seen;
	  STRING10  executive_var6_last_seen;
		UNSIGNED6 executive_var7_lexid;
		STRING5   executive_title_var7;
		STRING20  executive_fname_var7;
		STRING20  executive_mname_var7;
		STRING20  executive_lname_var7;
		STRING5   executive_name_suffix_var7;
		STRING60  executive_display_title_var7;
		STRING10  executive_var7_first_seen;
	  STRING10  executive_var7_last_seen;
		UNSIGNED6 executive_var8_lexid;
		STRING5   executive_title_var8;
		STRING20  executive_fname_var8;
		STRING20  executive_mname_var8;
		STRING20  executive_lname_var8;
		STRING5   executive_name_suffix_var8;
		STRING60  executive_display_title_var8;
		STRING10  executive_var8_first_seen;
	  STRING10  executive_var8_last_seen;
	  UNSIGNED6 executive_var9_lexid;
		STRING5   executive_title_var9;
		STRING20  executive_fname_var9;
		STRING20  executive_mname_var9;
		STRING20  executive_lname_var9;
		STRING5   executive_name_suffix_var9;
		STRING60  executive_display_title_var9;
		STRING10  executive_var9_first_seen;
	  STRING10  executive_var9_last_seen;
    
    Batchshare.Layouts.ShareErrors;
	END;
  
  EXPORT FinalWithLinkIds :=
  RECORD(Final)
		scored;
  END;
  
/*   // Sele best layout for reference purposes only
  EXPORT SELE_Best :=
  RECORD
    STRING30 acctno;
    BizLinkFull.process_Biz_layouts.id_stream_layout AND NOT UniqueId;
    BOOLEAN did_fetch;
    RECORDOF(BizLinkFull.Process_Biz_Layouts.Key) AND NOT BizLinkFull.process_Biz_layouts.id_stream_layout; // No HEADERSEARCH specified 
    BOOLEAN FullMatch_Required; // If the input enquiry is insisting upon full record match
    BOOLEAN Has_Fullmatch;      // This UID has a fully matching record
    BOOLEAN RecordsOnly;        // If the input enquiry only wants matching records returned
    BOOLEAN Is_Fullmatch;       // This record matches completely
    INTEGER2 Record_Score;      // Score for this particular record
    INTEGER2 Match_parent_proxid;
    INTEGER2 Match_sele_proxid;
    INTEGER2 Match_org_proxid;
    INTEGER2 Match_ultimate_proxid;
    INTEGER2 Match_has_lgid;
    INTEGER2 Match_empid;
    INTEGER2 Match_powid;
    INTEGER2 Match_source;
    INTEGER2 Match_source_record_id;
    INTEGER2 Match_company_name;
    INTEGER2 Match_company_name_prefix;
    INTEGER2 Match_cnp_name;
    INTEGER2 Match_cnp_number;
    INTEGER2 Match_cnp_btype;
    INTEGER2 Match_cnp_lowv;
    INTEGER2 Match_company_phone;
    INTEGER2 Match_company_phone_3;
    INTEGER2 Match_company_phone_3_ex;
    INTEGER2 Match_company_phone_7;
    INTEGER2 Match_company_fein;
    INTEGER2 Match_company_sic_code1;
    INTEGER2 Match_prim_range;
    INTEGER2 Match_prim_name;
    INTEGER2 Match_sec_range;
    INTEGER2 Match_city;
    INTEGER2 Match_city_clean;
    INTEGER2 Match_st;
    INTEGER2 Match_zip;
    INTEGER2 Match_company_url;
    INTEGER2 Match_isContact;
    INTEGER2 Match_contact_did;
    INTEGER2 Match_title;
    INTEGER2 Match_fname;
    INTEGER2 Match_fname_preferred;
    INTEGER2 Match_mname;
    INTEGER2 Match_lname;
    INTEGER2 Match_name_suffix;
    INTEGER2 Match_contact_ssn;
    INTEGER2 Match_contact_email;
    INTEGER2 Match_sele_flag;
    INTEGER2 Match_org_flag;
    INTEGER2 Match_ult_flag;
    INTEGER2 Match_contactname;
    INTEGER2 Match_streetaddress;
    BOOLEAN  is_truncated := FALSE;
    BIPV2_Best.Layouts.key.company_address.county_name;
    DATASET(BIPV2_Best.Layouts.Source) company_fein_sources;
    DATASET(BIPV2_Best.Layouts.Source) company_name_sources;
    BIPV2_Best.Layouts.key.company_address.company_address_data_permits;
    BOOLEAN ParentAboveSELE;
    BOOLEAN isActive;
    BOOLEAN isDefunct;
  END;
*/

END;
