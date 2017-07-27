IMPORT doxie_crs, doxie_files, NPPES;

EXPORT ingenix_provider_module := 
  MODULE

    EXPORT ingenix_name_rec := 
      RECORD	
        STRING20 	Prov_Clean_fname;
        STRING20  Prov_Clean_mname;
        STRING20 	Prov_Clean_lname;
        STRING5  	Prov_Clean_name_suffix;
        UNSIGNED2 ProviderNameTierID;
      END;

    EXPORT ingenix_phone_slim_rec := 
      RECORD	
        STRING10	PhoneNumber;
        STRING60	PhoneType;
        UNSIGNED2 PhoneNumberTierTypeID;
      END;
      
    EXPORT ingenix_addr_rec := 
      RECORD, MAXLENGTH(32766)
        STRING10	Prov_Clean_prim_range;
        STRING2   Prov_Clean_predir;
        STRING28	Prov_Clean_prim_name;
        STRING4 	Prov_Clean_addr_suffix;
        STRING2   Prov_Clean_postdir;
        STRING10  Prov_Clean_unit_desig;
        STRING8	  Prov_Clean_sec_range;
        STRING25  Prov_Clean_p_city_name;
        STRING25	Prov_Clean_v_city_name;
        STRING2   Prov_Clean_st;
        STRING5 	Prov_Clean_zip;
        STRING4   Prov_Clean_zip4;
        UNSIGNED2 ProviderAddressTierTypeID;
        DATASET(ingenix_phone_slim_rec) phone; 
      END;

    EXPORT ingenix_addr_rec_online := 
      RECORD, MAXLENGTH(32766)
        STRING10	Prov_Clean_prim_range;
        STRING2   Prov_Clean_predir;
        STRING28	Prov_Clean_prim_name;
        STRING4 	Prov_Clean_addr_suffix;
        STRING2   Prov_Clean_postdir;
        STRING10  Prov_Clean_unit_desig;
        STRING8	  Prov_Clean_sec_range;
        STRING25  Prov_Clean_p_city_name;
        STRING25	Prov_Clean_v_city_name;
        STRING2   Prov_Clean_st;
        STRING5 	Prov_Clean_zip;
        STRING4   Prov_Clean_zip4;
        UNSIGNED2 ProviderAddressTierTypeID;
				string8  	first_seen := '';
				string8  	last_seen := '';
        DATASET(ingenix_phone_slim_rec) phone; 
      END;

    EXPORT ingenix_phone_rec := 
      RECORD	
        STRING28	 Prov_Clean_prim_name;
        STRING2    Prov_Clean_st;
        STRING5 	 Prov_Clean_zip;
        STRING10	 Prov_Clean_prim_range;
        STRING8	   Prov_Clean_sec_range;
        STRING10	 PhoneNumber;
        STRING60	 PhoneType;
        UNSIGNED2  PhoneNumberTierTypeID;
      END;

    EXPORT ingenix_dob_rec := 
      RECORD	
        STRING8	  BirthDate;
        UNSIGNED2 BirthDateTierTypeID;
      END;

    EXPORT ingenix_license_rec := 
      RECORD	
        STRING2	  LicenseState;	
        STRING12	LicenseNumber;
        UNSIGNED2 LicenseNumberTierTypeID;
      END;

    EXPORT ingenix_taxid_rec := 
      RECORD	
        STRING10  TaxID;
        UNSIGNED2 TaxIDTierTypeID;
      END;
    
    EXPORT ingenix_language_rec := 
      RECORD	
        STRING40  Language;
        UNSIGNED2 LanguageTierTypeID;		
      END;
    
    EXPORT ingenix_upin_rec := 
      RECORD	
        STRING6   UPIN;
        UNSIGNED2 UPINTierTypeID;
      END;
    
    EXPORT ingenix_npi_rec := 
      RECORD	
        STRING10  NPI;
        UNSIGNED2 NPITierTypeID;
				STRING9		NPPESVerified := '';
      END;

    EXPORT ingenix_license_rpt_rec := 
      RECORD		     
        STRING2	  LicenseState;	
        STRING20	LicenseNumber;
        STRING8	  Effective_Date;
        STRING8	  Termination_Date;
        UNSIGNED2 LicenseNumberTierTypeID;
      END;
    
    EXPORT ingenix_dea_rec := 
      RECORD		     
        STRING9   DEANumber;
        UNSIGNED2 DEANumberTierTypeID;
        STRING8	  expiration_date := '';
      END;
    
    EXPORT ingenix_degree_rec := 
      RECORD		     
        STRING10  Degree;
        UNSIGNED2 DegreeTierTypeID;
      END;
    
    EXPORT ingenix_specialty_rec := 
      RECORD		     
        UNSIGNED4 SpecialtyID;
        STRING60	SpecialtyName;
        UNSIGNED4 SpecialtyGroupID;
        STRING60  SpecialtyGroupName;
        UNSIGNED2 SpecialtyTierTypeID;
      END;
          
    EXPORT ingenix_addr_rpt_rec := 
      RECORD	
        STRING10	Prov_Clean_prim_range;
        STRING2   Prov_Clean_predir;
        STRING28	Prov_Clean_prim_name;
        STRING4 	Prov_Clean_addr_suffix;
        STRING2   Prov_Clean_postdir;
        STRING10  Prov_Clean_unit_desig;
        STRING8	  Prov_Clean_sec_range;
        STRING25  Prov_Clean_p_city_name;
        STRING25	Prov_Clean_v_city_name;
        STRING2   Prov_Clean_st;
        STRING5 	Prov_Clean_zip;
        STRING4   Prov_Clean_zip4;
        STRING10  prov_Clean_geo_lat;
        STRING11  prov_Clean_geo_long;
        UNSIGNED2 ProviderAddressTierTypeID;
				//Add Address dates.
				string8  	first_seen := '';
				string8  	last_seen := '';
        DATASET(ingenix_phone_slim_rec) phone; 
      END;


    EXPORT ingenix_group_rec := 
      RECORD		     
        STRING12  BDID;
        STRING120 GroupName;
        UNSIGNED2 GroupNameTierTypeID;
        STRING	  Address;
        STRING 	  City;
        STRING	  State;
        STRING	  Zip;
      END;	
    
    EXPORT ingenix_hospital_rec := 
      RECORD		     
        STRING12  BDID;
        STRING120 HospitalName;
        UNSIGNED2 HospitalNameTierTypeID;
        STRING	  Address;
        STRING 	  City;
        STRING	  State;
        STRING	  Zip;
      END;	
      
    EXPORT ingenix_residency_rec := 
      RECORD		     
        STRING12  BDID;
        STRING120 Residency;
        UNSIGNED2 ResidencyTierTypeID;
      END;		
    
    EXPORT ingenix_medschool_rec := 
      RECORD		     
        STRING12  BDID;
        STRING120 MedSchoolName;
        STRING4   GraduationYear;
        UNSIGNED2 MedSchoolTierTypeID;
      END;		
    
    EXPORT ingenix_did_rec := 
      RECORD		     
        STRING12 DID;
      END;		
    
    EXPORT ingenix_sanc_child_rec := 
      RECORD		     
        unsigned6 SANC_ID;
      END;		

    EXPORT ingenix_ssn_rec := 
      RECORD		     
        STRING9 ssn;
      END;		

    EXPORT ingenix_sanc_child_rec_full := 
      RECORD, MAXLENGTH(200000)	     
        unsigned6   SANC_ID;
        doxie_files.key_sanctions_sancid.SANC_DOB;
        doxie_files.key_sanctions_sancid.SANC_TIN;
        doxie_files.key_sanctions_sancid.SANC_UPIN;
        doxie_files.key_sanctions_sancid.SANC_PROVTYPE;
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
        doxie_files.key_sanctions_sancid.SANC_FAB;
        doxie_files.key_sanctions_sancid.SANC_UNAMB_IND;
        doxie_files.key_sanctions_sancid.process_date;
        doxie_files.key_sanctions_sancid.date_first_seen;
        doxie_files.key_sanctions_sancid.date_last_seen;
        doxie_files.key_sanctions_sancid.SANC_BUSNME;
        doxie_files.key_sanctions_sancid.Prov_Clean_title;
        doxie_files.key_sanctions_sancid.Prov_Clean_fname;
        doxie_files.key_sanctions_sancid.Prov_Clean_mname;
        doxie_files.key_sanctions_sancid.Prov_Clean_lname;
        doxie_files.key_sanctions_sancid.Prov_Clean_name_suffix;
        doxie_files.key_sanctions_sancid.ProvCo_Address_Clean_prim_range;
        doxie_files.key_sanctions_sancid.ProvCo_Address_Clean_predir;
        doxie_files.key_sanctions_sancid.ProvCo_Address_Clean_prim_name;
        doxie_files.key_sanctions_sancid.ProvCo_Address_Clean_addr_suffix;
        doxie_files.key_sanctions_sancid.ProvCo_Address_Clean_postdir;
        doxie_files.key_sanctions_sancid.ProvCo_Address_Clean_unit_desig;
        doxie_files.key_sanctions_sancid.ProvCo_Address_Clean_sec_range;
        doxie_files.key_sanctions_sancid.ProvCo_Address_Clean_p_city_name;
        doxie_files.key_sanctions_sancid.ProvCo_Address_Clean_st;
        doxie_files.key_sanctions_sancid.ProvCo_Address_Clean_zip;
        doxie_files.key_sanctions_sancid.ProvCo_Address_Clean_geo_lat;
        doxie_files.key_sanctions_sancid.ProvCo_Address_Clean_geo_long;
				string did :='';
				string bdid :='';
				STRING7 sanc_grouptype :='';
				STRING3 sanc_subgrouptype :='';
				unsigned2	sanc_priority := 99;
				boolean LNDerivedReinstateDate := false;
				STRING9	NPPESVerified := '';
      END;		

    EXPORT ingenix_taxonomy_rec := 
      RECORD	
        STRING50 TaxonomyCode;
        STRING1	 PrimaryIndicator;
      END;	

    EXPORT ingenix_medicare_optout_rec := 
      RECORD	
				STRING20 OptOutSiteDescription;
				STRING8	AffidavitReceivedDate;
				STRING8	OptOutEffectiveDate;
				STRING8	OptOutTerminationDate;
				STRING2	OptOutStatus;
				STRING8	LastUpdate;
      END;	
    
    EXPORT ingenix_dod_rec := 
      RECORD	
				STRING10 DeceasedIndicator; 
				STRING8	 DeceasedDate;
      END;	

    EXPORT layout_ingenix_provider_search := 
      RECORD, MAXLENGTH(32766)
        STRING10 ProviderID;
        DATASET(ingenix_name_rec)    name;
        DATASET(ingenix_addr_rec)    address;
        DATASET(ingenix_dob_rec)     dob;
        DATASET(ingenix_license_rec) license;
        DATASET(ingenix_taxid_rec)   taxid;
      END;

    EXPORT layout_ingenix_provider_search_plus := 
      RECORD, MAXLENGTH(32766)
        STRING20 ProviderID;
        STRING1	 ProviderSrc :='';
				string did:='';
        DATASET(ingenix_name_rec)    name;
        DATASET(ingenix_addr_rec_online)    address;
        DATASET(ingenix_dob_rec)     dob;
        DATASET(ingenix_license_rec) license;
        DATASET(ingenix_taxid_rec)   taxid;
      END;

    EXPORT ING_NPPES_name_rec :=
      RECORD	
        STRING5   Prov_Name_Prefix_Text;
        STRING20	Prov_Clean_fname;
        STRING20	Prov_Clean_mname;
        STRING35	Prov_Clean_lname; 
        STRING5   Prov_Clean_name_suffix;
        STRING20  Prov_Credential_Text;
        UNSIGNED2 ProviderNameTierID;
      END;

    // New layout added to the doxie.ING_provider_search
    // to return the additional NPPES fields in a section of it's own
    EXPORT layout_ingenix_NPPES_provider_search := 
      RECORD, MAXLENGTH(32766)
        STRING5 rec_type;  // ING or NPPES
        layout_ingenix_provider_search.ProviderID;
        STRING1	 ProviderSrc :='';
				string did:='';
        DATASET(ING_NPPES_name_rec)  name {MAXCOUNT(100)};
        DATASET(ingenix_addr_rec_online)    address {MAXCOUNT(100)};
        DATASET(ingenix_dob_rec)     dob {MAXCOUNT(100)};
        DATASET(ingenix_license_rec) license {MAXCOUNT(100)};
        DATASET(ingenix_taxid_rec)   taxid {MAXCOUNT(100)};
        NPPES.layouts.Vendor.NPI;
				STRING9 NPPESVerified := '';
        NPPES.layouts.Vendor.Provider_Organization_Name;
      END;
    
     // New layout added to include the both address fields to that both
    // can be used in the penalization (because both can be used to search 
    // but only the practice location is output)
    EXPORT layout_NPPES_provider_search_penalt := 
      RECORD, MAXLENGTH(32766)
        UNSIGNED2 rec_count;
        STRING5   rec_type;  // ING or NPPES
        layout_ingenix_provider_search.ProviderID;
				string did:='';
        DATASET(ING_NPPES_name_rec)  name;
        DATASET(ingenix_addr_rec_online)    address;
        DATASET(ingenix_addr_rec_online)    MailingAddress;
        DATASET(ingenix_dob_rec)     dob;
        DATASET(ingenix_license_rec) license;
        DATASET(ingenix_taxid_rec)   taxid;
        NPPES.layouts.Vendor.NPI;
        NPPES.layouts.Vendor.Provider_Organization_Name;
      END;
    
    // used to add the penalty to the final layout 
    EXPORT layout_Ingenix_NPPES_provider_search_penalt := 
      RECORD, MAXLENGTH(32766)
        UNSIGNED1 penalt;
        layout_ingenix_NPPES_provider_search;
      END;
    
    EXPORT layout_ingenix_provider_report := 
      RECORD
        STRING20 ProviderID;
        STRING1	 ProviderSrc :='';
        STRING1  Gender;
        STRING7  Gender_Name;
        BOOLEAN  sanc_flag;
        DATASET(ingenix_sanc_child_rec) sanction_id;
        DATASET(ingenix_did_rec) providerdid;
        DATASET(ingenix_name_rec) name;
        DATASET(ingenix_taxid_rec) taxid;
        DATASET(ingenix_dob_rec) dob;
        DATASET(ingenix_dod_rec) dod;
        DATASET(ingenix_language_rec) language;
        DATASET(ingenix_upin_rec) upin;
        DATASET(ingenix_npi_rec) npi;
        DATASET(ingenix_license_rpt_rec) license;
        DATASET(ingenix_dea_rec) dea;
        DATASET(ingenix_degree_rec) degree;
        DATASET(ingenix_specialty_rec) specialty; 
        DATASET(ingenix_addr_rpt_rec) business_address;
        DATASET(ingenix_group_rec) group_affiliation;
        DATASET(ingenix_hospital_rec) hospital_affiliation;
        DATASET(ingenix_residency_rec) residency;
        DATASET(ingenix_medschool_rec) medschool;
        DATASET(ingenix_taxonomy_rec) taxonomy {MAXCOUNT(doxie_crs.constants.max_taxonomy)};
        DATASET(ingenix_sanc_child_rec_full) sanction_data;
        DATASET(ingenix_ssn_rec) SSN;
        DATASET(ingenix_medicare_optout_rec)   medicareoptout;
        BOOLEAN Deceased := FALSE;
      END;
    
		EXPORT add_rec := 
      RECORD
				STRING55 	  Address1;
				STRING20 	  Address2;
				STRING55 	  City;
				STRING2     St;
				STRING10    Zip;
  			STRING150 	PhoneNumber;				
	   END;
    
    EXPORT layout_ingenix_provider_report_for_batch := 
      RECORD
        STRING20 Acctno;
        layout_ingenix_provider_report;
        DATASET( add_rec) bus_addr2;
        STRING130 Specialty_1      := ''; 
        STRING130 Specialty_2      := ''; 
        STRING130 Specialty_3      := ''; 
        STRING130 Specialty_4      := ''; 
        STRING130 Specialty_5      := ''; 
        STRING130 Specialty_6      := ''; 
        STRING130 Specialty_7      := ''; 
        STRING130 Specialty_8      := ''; 
        STRING130 Specialty_9      := ''; 
        STRING130 Specialty_10     := ''; 
        STRING130 Specialty_11     := ''; 
        STRING130 Specialty_12     := ''; 
        STRING130 Specialty_13     := ''; 
        STRING130 Specialty_14     := ''; 
        STRING130 Specialty_15     := ''; 
        STRING130 Specialty_16     := ''; 
        STRING130 Specialty_17     := ''; 
        STRING130 Specialty_18     := ''; 
        STRING130 Specialty_19     := ''; 
        STRING130 Specialty_20     := ''; 
        STRING130 MedSchoolName_1  := '';
        STRING130 MedSchoolName_2  := '';
        STRING130 MedSchoolName_3  := '';
        STRING130 MedSchoolName_4  := '';
        STRING130 MedSchoolName_5  := '';
        STRING130 MedSchoolName_6  := '';
        STRING130 MedSchoolName_7  := '';
        STRING130 MedSchoolName_8  := '';
        STRING130 MedSchoolName_9  := '';
        STRING130 MedSchoolName_10 := '';
        STRING210 Language1 := '';
        STRING120 TaxID1 := '';
        STRING200 DEANumber1 := ''; //20-22 dea numberse
        STRING120 Degree1 := '';//10 degrees
        STRING70  UPIN1 := ''; //10 upins
        STRING300 Taxonomy_code1 := ''; //6 codes if full 50 length, but most are length 10
        STRING39	License_1 := '';
        STRING39	License_2 := '';
        STRING39	License_3 := '';
        STRING39	License_4 := '';
        STRING39	License_5 := '';
        STRING39	License_6 := '';
        STRING39	License_7 := '';
        STRING39	License_8 := '';
        STRING39	License_9 := '';
        STRING39	License_10 := '';
        STRING39	License_11 := '';
        STRING39	License_12 := '';
        STRING39	License_13 := '';
        STRING39	License_14 := '';
        STRING39	License_15 := '';
        STRING39	License_16 := '';
        STRING39	License_17 := '';
        STRING39	License_18 := '';
        STRING39	License_19 := '';
        STRING39	License_20 := '';
      END; 

    EXPORT batch_Medlic_layout := 
      RECORD, MAXLENGTH(20234)	
        STRING20   ProviderID;
        STRING14   did;
        STRING1    Gender_Name; //Used to be string7 AMS and Ingenix are formatted differently.  Making it String1 so they are the same for the batch
        BOOLEAN    sanc_flag;
        STRING20   Prov_Clean_fname;
        STRING20   Prov_Clean_mname;
        STRING20   Prov_Clean_lname;
        STRING120  FullName :='';
        STRING120  TaxID; //10 taxids
        STRING12	 BirthDate;
        STRING210  Language;//5 languages
        STRING70   UPIN; //10 upins
        STRING300  Taxonomy_code; //6 codes if full 50 length, but most are length 10
        STRING10   NPI;
        STRING39	 License_1;
        STRING39	 License_2;
        STRING39	 License_3;
        STRING39	 License_4;
        STRING39	 License_5;
        STRING39	 License_6;
        STRING39	 License_7;
        STRING39	 License_8;
        STRING39	 License_9;
        STRING39	 License_10;
        STRING39   License_11;
        STRING39	 License_12;
        STRING39	 License_13;
        STRING39	 License_14;
        STRING39	 License_15;
        STRING39	 License_16;
        STRING39	 License_17;
        STRING39	 License_18;
        STRING39   License_19;
        STRING39	 License_20;
        // Provider Screening Batch Phase 2 Enhancements
        // Added 4 new license individual fields for each of the 20 licenses
        STRING20  Lic1_Number;
        STRING2	  Lic1_State;	
        STRING10  Lic1_Eff_Date;
        STRING10  Lic1_Exp_Date;
        STRING20  Lic2_Number;
        STRING2	  Lic2_State;	
        STRING10  Lic2_Eff_Date;
        STRING10  Lic2_Exp_Date;
        STRING20  Lic3_Number;
        STRING2	  Lic3_State;	
        STRING10  Lic3_Eff_Date;
        STRING10  Lic3_Exp_Date;
        STRING20  Lic4_Number;
        STRING2	  Lic4_State;	
        STRING10  Lic4_Eff_Date;
        STRING10  Lic4_Exp_Date;
        STRING20  Lic5_Number;
        STRING2	  Lic5_State;	
        STRING10  Lic5_Eff_Date;
        STRING10  Lic5_Exp_Date;
        STRING20  Lic6_Number;
        STRING2	  Lic6_State;	
        STRING10  Lic6_Eff_Date;
        STRING10  Lic6_Exp_Date;
        STRING20  Lic7_Number;
        STRING2	  Lic7_State;	
        STRING10  Lic7_Eff_Date;
        STRING10  Lic7_Exp_Date;
        STRING20  Lic8_Number;
        STRING2	  Lic8_State;	
        STRING10  Lic8_Eff_Date;
        STRING10  Lic8_Exp_Date;
        STRING20  Lic9_Number;
        STRING2	  Lic9_State;	
        STRING10  Lic9_Eff_Date;
        STRING10  Lic9_Exp_Date;
        STRING20  Lic10_Number;
        STRING2	  Lic10_State;	
        STRING10  Lic10_Eff_Date;
        STRING10  Lic10_Exp_Date;
        STRING20  Lic11_Number;
        STRING2	  Lic11_State;	
        STRING10  Lic11_Eff_Date;
        STRING10  Lic11_Exp_Date;
        STRING20  Lic12_Number;
        STRING2	  Lic12_State;	
        STRING10  Lic12_Eff_Date;
        STRING10  Lic12_Exp_Date;
        STRING20  Lic13_Number;
        STRING2	  Lic13_State;	
        STRING10  Lic13_Eff_Date;
        STRING10  Lic13_Exp_Date;
        STRING20  Lic14_Number;
        STRING2	  Lic14_State;	
        STRING10  Lic14_Eff_Date;
        STRING10  Lic14_Exp_Date;
        STRING20  Lic15_Number;
        STRING2	  Lic15_State;	
        STRING10  Lic15_Eff_Date;
        STRING10  Lic15_Exp_Date;
        STRING20  Lic16_Number;
        STRING2	  Lic16_State;	
        STRING10  Lic16_Eff_Date;
        STRING10  Lic16_Exp_Date;
        STRING20  Lic17_Number;
        STRING2	  Lic17_State;	
        STRING10  Lic17_Eff_Date;
        STRING10  Lic17_Exp_Date;
        STRING20  Lic18_Number;
        STRING2	  Lic18_State;	
        STRING10  Lic18_Eff_Date;
        STRING10  Lic18_Exp_Date;
        STRING20  Lic19_Number;
        STRING2	  Lic19_State;	
        STRING10  Lic19_Eff_Date;
        STRING10  Lic19_Exp_Date;
        STRING20  Lic20_Number;
        STRING2	  Lic20_State;	
        STRING10  Lic20_Eff_Date;
        STRING10  Lic20_Exp_Date;
        STRING200 DEANumber; //20-22 dea numberse
        STRING120 Degree;//10 degrees
        STRING130 Specialty_1; 
        STRING130 Specialty_2; 
        STRING130 Specialty_3; 
        STRING130 Specialty_4; 
        STRING130 Specialty_5; 
        STRING130 Specialty_6; 
        STRING130 Specialty_7; 
        STRING130 Specialty_8; 
        STRING130 Specialty_9; 
        STRING130 Specialty_10; 
        STRING130 Specialty_11; 
        STRING130 Specialty_12; 
        STRING130 Specialty_13; 
        STRING130 Specialty_14; 
        STRING130 Specialty_15; 
        STRING130 Specialty_16; 
        STRING130 Specialty_17; 
        STRING130 Specialty_18; 
        STRING130 Specialty_19; 
        STRING130 Specialty_20; 
        STRING55  Address1_1;
        STRING20  Address2_1;
        STRING55  City_1;
        STRING2   St_1;
        STRING10  Zip_1;
        STRING150 PhoneNumber_1;
        STRING55  Address1_2;
        STRING20  Address2_2;
        STRING55  City_2;
        STRING2   St_2;
        STRING10  Zip_2;
        STRING150 PhoneNumber_2;
        STRING55  Address1_3;
        STRING20  Address2_3;
        STRING55  City_3;
        STRING2   St_3;
        STRING10  Zip_3;
        STRING150 PhoneNumber_3;
        STRING55  Address1_4;
        STRING20  Address2_4;
        STRING55  City_4;
        STRING2   St_4;
        STRING10  Zip_4;
        STRING150 PhoneNumber_4;	
        STRING55  Address1_5;
        STRING20  Address2_5;
        STRING55  City_5;
        STRING2   St_5;
        STRING10  Zip_5;
        STRING150 PhoneNumber_5;
        STRING55  Address1_6;
        STRING20  Address2_6;
        STRING55  City_6;
        STRING2   St_6;
        STRING10  Zip_6;
        STRING150 PhoneNumber_6;
        STRING55  Address1_7;
        STRING20  Address2_7;
        STRING55  City_7;
        STRING2   St_7;
        STRING10  Zip_7;
        STRING150 PhoneNumber_7;
        STRING55  Address1_8;
        STRING20  Address2_8;
        STRING55  City_8;
        STRING2   St_8;
        STRING10  Zip_8;
        STRING150 PhoneNumber_8;					
        STRING55  Address1_9;
        STRING20  Address2_9;
        STRING55  City_9;
        STRING2   St_9;
        STRING10  Zip_9;
        STRING150 PhoneNumber_9;					
        STRING55  Address1_10;
        STRING20  Address2_10;
        STRING55  City_10;
        STRING2   St_10;
        STRING10  Zip_10;
        STRING150 PhoneNumber_10;				
        STRING120 GroupName_1;
        STRING100 GroupAffiliationAddress_1;
        STRING30  GroupAffiliationCity_1;
        STRING2   GroupAffiliationState_1;
        STRING10  GroupAffiliationZip_1;
        STRING120 GroupName_2;
        STRING100 GroupAffiliationAddress_2;
        STRING30  GroupAffiliationCity_2;
        STRING2   GroupAffiliationState_2;
        STRING10  GroupAffiliationZip_2;
        STRING120 GroupName_3;
        STRING100 GroupAffiliationAddress_3;
        STRING30  GroupAffiliationCity_3;
        STRING2   GroupAffiliationState_3;
        STRING10  GroupAffiliationZip_3;
        STRING120 GroupName_4;
        STRING100 GroupAffiliationAddress_4;
        STRING30  GroupAffiliationCity_4;
        STRING2   GroupAffiliationState_4;
        STRING10  GroupAffiliationZip_4;
        STRING120 GroupName_5;
        STRING100 GroupAffiliationAddress_5;
        STRING30  GroupAffiliationCity_5;
        STRING2   GroupAffiliationState_5;
        STRING10  GroupAffiliationZip_5;
        STRING120 GroupName_6;
        STRING100 GroupAffiliationAddress_6;
        STRING30  GroupAffiliationCity_6;
        STRING2   GroupAffiliationState_6;
        STRING10  GroupAffiliationZip_6;
        STRING120 GroupName_7;
        STRING100 GroupAffiliationAddress_7;
        STRING30  GroupAffiliationCity_7;
        STRING2   GroupAffiliationState_7;
        STRING10  GroupAffiliationZip_7;
        STRING120 GroupName_8;
        STRING100 GroupAffiliationAddress_8;
        STRING30  GroupAffiliationCity_8;
        STRING2   GroupAffiliationState_8;
        STRING10  GroupAffiliationZip_8;
        STRING120 GroupName_9;
        STRING100 GroupAffiliationAddress_9;
        STRING30  GroupAffiliationCity_9;
        STRING2   GroupAffiliationState_9;
        STRING10  GroupAffiliationZip_9;
        STRING120 GroupName_10;
        STRING100 GroupAffiliationAddress_10;
        STRING30  GroupAffiliationCity_10;
        STRING2   GroupAffiliationState_10;
        STRING10  GroupAffiliationZip_10;
        STRING120 HospitalName_1;				
        STRING100 HospitalAffiliationAddress_1;
        STRING30  HospitalAffiliationCity_1;
        STRING2   HospitalAffiliationState_1;
        STRING10  HospitalAffiliationZip_1;
        STRING120 HospitalName_2;			
        STRING100 HospitalAffiliationAddress_2;
        STRING30  HospitalAffiliationCity_2;
        STRING2   HospitalAffiliationState_2;
        STRING10  HospitalAffiliationZip_2;
        STRING120 HospitalName_3;				
        STRING100 HospitalAffiliationAddress_3;
        STRING30  HospitalAffiliationCity_3;
        STRING2   HospitalAffiliationState_3;
        STRING10  HospitalAffiliationZip_3;
        STRING120 HospitalName_4;				
        STRING100 HospitalAffiliationAddress_4;
        STRING30  HospitalAffiliationCity_4;
        STRING2   HospitalAffiliationState_4;
        STRING10  HospitalAffiliationZip_4;
        STRING120 HospitalName_5;				
        STRING100 HospitalAffiliationAddress_5;
        STRING30  HospitalAffiliationCity_5;
        STRING2   HospitalAffiliationState_5;
        STRING10  HospitalAffiliationZip_5;
        STRING120 HospitalName_6;				
        STRING100 HospitalAffiliationAddress_6;
        STRING30  HospitalAffiliationCity_6;
        STRING2   HospitalAffiliationState_6;
        STRING10  HospitalAffiliationZip_6;
        STRING120 HospitalName_7;				
        STRING100 HospitalAffiliationAddress_7;
        STRING30  HospitalAffiliationCity_7;
        STRING2   HospitalAffiliationState_7;
        STRING10  HospitalAffiliationZip_7;
        STRING120 HospitalName_8;				
        STRING100 HospitalAffiliationAddress_8;
        STRING30  HospitalAffiliationCity_8;
        STRING2   HospitalAffiliationState_8;
        STRING10  HospitalAffiliationZip_8;
        STRING120 HospitalName_9;				
        STRING100 HospitalAffiliationAddress_9;
        STRING30  HospitalAffiliationCity_9;
        STRING2   HospitalAffiliationState_9;
        STRING10  HospitalAffiliationZip_9;
        STRING120 HospitalName_10;				
        STRING100 HospitalAffiliationAddress_10;
        STRING30  HospitalAffiliationCity_10;
        STRING2   HospitalAffiliationState_10;
        STRING10  HospitalAffiliationZip_10;
        STRING120 Residency_1;
        STRING120 Residency_2;
        STRING120 Residency_3;
        STRING120 Residency_4;
        STRING120 Residency_5;
        STRING120 Residency_6;
        STRING120 Residency_7;
        STRING120 Residency_8;
        STRING120 Residency_9;
        STRING120 Residency_10;
        STRING130 MedSchoolName_1;
        STRING130 MedSchoolName_2;
        STRING130 MedSchoolName_3;
        STRING130 MedSchoolName_4;
        STRING130 MedSchoolName_5;
        STRING130 MedSchoolName_6;
        STRING130 MedSchoolName_7;
        STRING130 MedSchoolName_8;
        STRING130 MedSchoolName_9;
        STRING130 MedSchoolName_10;
      END;

  END;