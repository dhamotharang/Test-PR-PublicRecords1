IMPORT iesp, DemoSearchTool;

EXPORT KeyLayouts := 
  MODULE
    
    EXPORT business_bdid_rec := 
      RECORD
        UNSIGNED6 BDID := 0;
    END;
   
    EXPORT business_linkid_rec := 
      RECORD
        UNSIGNED6 ULTID := 0;
        UNSIGNED6 ORGID := 0;
        UNSIGNED6 SELEID := 0;
    END;    
    
    EXPORT Ids_rec := 
      RECORD
        UNSIGNED6 DID;
        business_bdid_rec;
        business_linkid_rec;
      END;
    
    EXPORT bizCounts_rec :=
      RECORD
        INTEGER2  Biz_AddressesCount;
        INTEGER2  Biz_AssociatesCount;
        INTEGER2  Biz_BankruptciesCount;
        BOOLEAN   in_Biz_BusinessHeader;
        INTEGER2  Biz_CorporateFilingsCount;
        INTEGER2  Biz_DirectoryAssistanceCount;
        INTEGER2  Biz_EvictionsCount;
        INTEGER2  Biz_ExecutivesCount;
        INTEGER2  Biz_FAAAircraftsCount;
        INTEGER2  Biz_FictitiousBusinessesCount;
        INTEGER2  Biz_ForclosuresCount;
        BOOLEAN   in_Biz_GlobalWatchListOFAC;
        INTEGER2  Biz_GlobalWatchListsCount;
        INTEGER2  Biz_Industry_NAICSCount;
        INTEGER2  Biz_InternetDomainsCount;
        INTEGER2  Biz_JudgmentsCount;
        INTEGER2  Biz_LiensCount;
        INTEGER2  Biz_MotorVehiclesCount;
        INTEGER2  Biz_NumMultiBusinessesCount;
        INTEGER2  Biz_NameVariationsCount;
        INTEGER2  Biz_PropertiesCount;
        INTEGER2  Biz_RegistrationsCount;
        INTEGER2  Biz_RegisteredAgentsCount;
        INTEGER2  Biz_UCCFilingsCount;
        INTEGER2  Biz_WatercraftsCount;
				INTEGER2	Biz_MARILicensesCount;
				INTEGER2 	Biz_PublicSanctnsCount;
				INTEGER2 	Biz_NonPublicSanctnsCount;
				INTEGER2 	Biz_FreddieMacSanctnsCount;
      END;
      
    EXPORT combinedTemp_rec :=
      RECORD
        Ids_rec;
        bizCounts_rec;
        BOOLEAN   isFCRA;
        INTEGER2 owned_business_bdid_cnt;
		    INTEGER2 owned_business_linkId_cnt;
		    DATASET(business_bdid_rec)   ds_owned_businesses_bdid{MAXCOUNT(DemoSearchTool.Constants.JOIN_LIMIT)};
			  DATASET(business_linkid_rec) ds_owned_businesses_linkid{MAXCOUNT(DemoSearchTool.Constants.JOIN_LIMIT)};
      END;

    EXPORT SearchInput_rec := 
      RECORD
        BOOLEAN  isFCRA;
        bizCounts_rec;
        INTEGER2 Per_AddressesCount;
        INTEGER2 Per_AKAsCount;
        INTEGER2 Per_AssociatesCount;
        INTEGER2 Per_BankruptciesCount;
        INTEGER2 Per_CorporateAffiliationsCount;
        INTEGER2 Per_CriminalDeptOfCorrectionsCount;
        INTEGER2 Per_CriminalRecordsCount;
        BOOLEAN  in_Per_DeathKey;
        INTEGER2 Per_DirectoryAssistanceCount;
        INTEGER2 Per_DriverLicenseCount;
        INTEGER2 Per_EmailsCount;
        INTEGER2 Per_EvictionsCount;
        INTEGER2 Per_FAAAircraftsCount;
        INTEGER2 Per_FirstDegreeRelativesCount;
        INTEGER2 Per_ForclosuresCount;
        BOOLEAN  in_Per_GlobalWatchListOFAC;
        INTEGER2 Per_GlobalWatchListsCount;
        BOOLEAN  has_Per_HighRiskIndicatorAddress;
        BOOLEAN  has_Per_HighRiskIndicatorSSN;
        INTEGER2 Per_JudgmentsCount;
        INTEGER2 Per_LiensCount;
        INTEGER2 Per_MarriageDivorceCount;
        INTEGER2 Per_MotorVehiclesCount;
        INTEGER2 Per_NeighborsCount;
        INTEGER2 Per_NoticesOfDefaultCount;
        INTEGER2 Per_NumOfBizExecutiveOfCount;
        INTEGER2 Per_PeopleAtWorkCount;
        BOOLEAN  in_Per_PersonHeader;
        INTEGER2 Per_PhonesPlusCount;
        INTEGER2 Per_ProfessionalLicensesCount;
        INTEGER2 Per_PropertiesCount;
        INTEGER2 Per_RegisteredAgentsCount;
        INTEGER2 Per_SecondDegreeRelativesCount;
        INTEGER2 Per_SexualOffenderCount;
        INTEGER2 Per_SSNsCount;
        INTEGER2 Per_ThirdDegreeRelativesCount;
        INTEGER2 Per_WatercraftsCount;
								INTEGER2	Per_MARILicensesCount;
								INTEGER2 Per_PublicSanctnsCount;
								INTEGER2 Per_NonPublicSanctnsCount;
								INTEGER2 Per_FreddieMacSanctnsCount;
     END;

    EXPORT finalPlusSorting_rec :=
      RECORD
        iesp.demoSearchTool.t_DemoSearchToolSearchRecord; 
        UNSIGNED6 UniqueId;
        business_bdid_rec;
        business_linkid_rec;
      END;
    
    EXPORT SearchToolSrcRecPlusBdidForCombOutput_rec :=
      RECORD
        iesp.demoSearchTool.t_DemoSearchToolSearchRecord;
        business_bdid_rec;
      END;
      
    EXPORT SearchToolSrcRecPlusBipidsForCombOutput_rec :=
      RECORD
        iesp.demoSearchTool.t_DemoSearchToolSearchRecord;
        business_linkid_rec;
      END;

EXPORT People_Layout := RECORD
  boolean isfcra;
  integer8 first_degree_relatives_cnt;
  integer8 second_degree_relatives_cnt;
  integer8 Third_Degree_Relatives_cnt;
  integer8 associates_cnt;
  integer8 neighbors_cnt;
  integer8 akas_cnt;
  integer8 bankruptcy_cnt;
  integer8 corporate_affiliation_cnt;
  integer8 criminal_cnt;
  integer8 criminal_doc_cnt;
  boolean in_deceased;
  integer8 directory_assistance_gong_cnt;
  integer8 dl_cnt;
  integer8 email_cnt;
  integer8 faa_aircraft_cnt;
  integer8 foreclosure_cnt;
  integer8 gwl_cnt;
  boolean in_gwl_ofac_only;
  boolean in_address_hri;
  boolean in_ssn_hri;
  integer8 liens_cnt;
  integer8 judgements_cnt;
  integer8 evictions_cnt;
  integer8 marriage_and_divorce_cnt;
  integer8 mvr_cnt;
  integer8 notice_of_default_cnt;
  integer8 people_at_work_cnt;
  boolean in_person_header;
  integer8 phonesplus_cnt;
  integer8 professional_license_cnt;
  integer8 property_cnt;
  integer8 registered_agent_cnt;
  integer8 sex_offender_cnt;
  integer8 watercraft_cnt;
  integer8 addresses_cnt;
  integer8 ssn_cnt;
	integer8 mari_license_cnt;
	integer8 public_sanctn_cnt;
	integer8 nonpublic_sanctn_cnt;
	integer8 freddiemac_sanctn_cnt;
  integer8 owned_business_bdid_cnt;
  integer8 owned_business_linkid_cnt;
  unsigned6 did;
  DATASET(business_bdid_rec) owned_businesses_bdid{maxcount(25)} := DATASET([],business_bdid_rec);
  DATASET(business_linkid_rec) owned_businesses_linkid{maxcount(25)} := DATASET([],business_linkid_rec);
  unsigned8 __internal_fpos__ :=0;
 END;
 EXPORT Business_Bdid_Layout := RECORD
  boolean isfcra;
  integer8 addresses_cnt;
  integer8 bankruptcy_cnt;
  boolean in_business_header;
  integer8 business_associates_cnt;
  integer8 business_industry_naics_cnt;
  integer8 business_name_variations_cnt;
  integer8 business_registrations_cnt;
  integer8 corporations_sos_cnt;
  integer8 directory_assistance_gong_cnt;
  integer8 executives_cnt;
  integer8 faa_aircraft_cnt;
  integer8 fictitious_businesses_cnt;
  integer8 foreclosure_cnt;
  integer8 gwl_cnt;
  boolean in_gwl_ofac_only;
  integer8 internet_domain_cnt;
  integer8 liens_cnt;
  integer8 judgements_cnt;
  integer8 evictions_cnt;
  integer8 mvr_cnt;
  integer8 property_cnt;
  integer8 registered_agent_cnt;
  integer8 ucc_cnt;
  integer8 watercraft_cnt;
  integer8	mari_license_cnt;
	integer8 public_sanctn_cnt;
	integer8 nonpublic_sanctn_cnt;
	integer8 freddiemac_sanctn_cnt;
	unsigned6 bdid;
	integer8 fp := 0;
 END;
 
 EXPORT Business_Linkids_Layout := RECORD
  integer8 addresses_cnt;
  integer8 bankruptcy_cnt;
  boolean in_business_header;
  integer8 business_associates_cnt;
  integer8 business_industry_naics_cnt;
  integer8 business_name_variations_cnt;
  integer8 business_registrations_cnt;
  integer8 corporations_sos_cnt;
  integer8 directory_assistance_gong_cnt;
  integer8 executives_cnt;
  integer8 faa_aircraft_cnt;
  integer8 fictitious_businesses_cnt;
  integer8 foreclosure_cnt;
  integer8 gwl_cnt;
  boolean in_gwl_ofac_only;
  integer8 internet_domain_cnt;
  integer8 liens_cnt;
  integer8 judgements_cnt;
  integer8 evictions_cnt;
  integer8 mvr_cnt;
  integer8 property_cnt;
  integer8 registered_agent_cnt;
  integer8 ucc_cnt;
  integer8 watercraft_cnt;
	integer8	mari_license_cnt;
	integer8 public_sanctn_cnt;
	integer8 nonpublic_sanctn_cnt;
	integer8 freddiemac_sanctn_cnt;
  unsigned6 ultid;
  unsigned6 orgid;
  unsigned6 seleid;
	unsigned8 __internal_fpos__ := 0;
 END;
 
EXPORT layout_child_address := record
	  qstring120 company_name;
		qstring10 prim_range;
		qstring28 prim_name;
		qstring8 sec_range;
		string5 zip;
		string2 predir;
		qstring4 addr_suffix;
		string2 postdir;
		qstring5 unit_desig;
		qstring25 city;
		string2 state;
		string4 zip4;
		unsigned6 phone;
		unsigned4 fein;
	end;
	EXPORT layout_child_bdid_address := record
		unsigned6 BDID;
		layout_child_address;
	end;
	EXPORT slim_child_bdid_address := layout_child_bdid_address - [prim_range,prim_name,sec_range,zip];

	EXPORT layout_child_seleid_address := record
		unsigned6 ultid;
		unsigned6 orgid;
		unsigned6 seleid;
		unsigned6 bdid;
		layout_child_address;
	end;
	EXPORT slim_child_seleid_address := layout_child_seleid_address - [prim_range,prim_name,sec_range,zip];
	
	EXPORT Business_Address_Layout := record
		integer8 BDID_cnt:= 0;
		integer8 seleid_cnt := 0;
		qstring10 prim_range;
		qstring28 prim_name;
		qstring8 sec_range;
		string5 zip;
		dataset(slim_child_bdid_address,ChooseN(50)) Businesses_bdid := dataset([],slim_child_bdid_address) ;
		dataset(slim_child_seleid_address,ChooseN(50)) Businesses_seleid := dataset([],slim_child_seleid_address) ;
	end;
 END;