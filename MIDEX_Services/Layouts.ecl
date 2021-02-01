IMPORT BIPV2, doxie_cbrs, iesp;

EXPORT Layouts := MODULE
  SHARED address_layout := RECORD
    STRING2 predir;
    STRING10 prim_range;
    STRING28 prim_name;
    STRING4 addr_suffix;
    STRING2 postdir;
    STRING10 unit_desig;
    STRING8 sec_range;
    STRING25 city;
    STRING2 st;
    STRING5 zip5;
    STRING35 county;
    STRING3 fips_county;
  END;
  
  EXPORT rec_nmlsInfo := RECORD
    STRING80 nmlsType;
    STRING20 nmlsId;
  END;
  
  EXPORT rec_midex_payloadKeyField := RECORD
    STRING26 midex_rpt_nbr := ''; // SANCTN.key_MIDEX_RPT_NBR.layout_SANCTN_party_key.midex_rpt_nbr NOT exported RECORD
    STRING8 BATCH := '';
    STRING8 INCIDENT_NUM := '';
    STRING8 PARTY_NUM := '';
    STRING1 DBCODE := '';
    STRING8 publicIncidentNum := '';
    STRING8 publicPartyNum := '';
    STRING26 NP_subject_rpt_nbr := '';
    STRING8 NP_subjectParty_num := '';
  END;

  EXPORT rec_profLicMari_payloadKeyField := RECORD
    UNSIGNED6 mari_rid;
  END;

  EXPORT hash_layout := RECORD
    UNSIGNED8 name_hash := 0;
    UNSIGNED8 prev_license_status_hash := 0;
    UNSIGNED8 license_status_hash := 0;
    UNSIGNED8 address_hash := 0;
    UNSIGNED8 phone_hash := 0;
    UNSIGNED8 license_hash := 0;
    UNSIGNED8 license_expir_hash := 0;
    UNSIGNED8 incident_hash := 0;
    UNSIGNED8 nmls_id_hash := 0;
    UNSIGNED8 nmls_status_hash := 0;
    UNSIGNED8 represent_hash := 0;
    UNSIGNED8 disciplinary_hash := 0;
    UNSIGNED8 registration_hash := 0;
    UNSIGNED8 bankruptcy_hash := 0;
    UNSIGNED8 criminal_hash := 0;
    UNSIGNED8 lien_judgment_hash := 0;
    UNSIGNED8 email_hash := 0;
    UNSIGNED8 property_hash := 0;
    UNSIGNED8 relative_hash := 0;
    UNSIGNED8 bus_associate_hash := 0;
    UNSIGNED8 employer_hash := 0;
    UNSIGNED8 name_variation_hash := 0;
    UNSIGNED8 executive_hash := 0;
    UNSIGNED8 SOS_hash := 0;
    UNSIGNED8 AKA_and_name_variation_hash := 0;
    UNSIGNED8 prev_all_hash := 0;
    UNSIGNED8 all_hash := 0;
    BOOLEAN nameChanged;
    BOOLEAN addresschanged;
    BOOLEAN bankruptcyChanged;
    BOOLEAN criminalChanged;
    BOOLEAN incidentChanged;
    BOOLEAN licenseStatusChanged;
    BOOLEAN licenseExpirChanged; // NOT used at this time
    BOOLEAN lienJudgmentChanged;
    BOOLEAN nmlsIDChanged;
    BOOLEAN phoneChanged;
    BOOLEAN RepresentChanged;
    BOOLEAN RegistrationChanged;
    BOOLEAN DisciplinaryChanged;
    BOOLEAN AnyChanged; // NOT used at development time
    BOOLEAN licenseChanged; // NOT used at development time
    BOOLEAN emailChanged;
    BOOLEAN propertyChanged;
    BOOLEAN relativeChanged;
    BOOLEAN BusinessAssociateChanged;
    BOOLEAN employerChanged;
    BOOLEAN NameVariationChanged;
    BOOLEAN executiveChanged;
    BOOLEAN SecretaryOfStateFilingChanged;
    BOOLEAN AKAAndNameVariationChanged;
    BOOLEAN deleted;
  END;

  EXPORT hash_changes := RECORD
    hash_layout.all_hash;
    BOOLEAN isInputHash;
  END;

  EXPORT rec_temp_layout := RECORD
    rec_midex_payloadKeyField;
    STRING25 RecordNumber := '';
    STRING11 RecordType := '';
    STRING20 FirstName := '';
    STRING20 MiddleName := '';
    STRING20 LastName := '';
    STRING5 SuffixName := '';
    STRING3 PrefixName := '';
    DATASET (iesp.share.t_NameAndCompany) AKAs := DATASET([],iesp.share.t_NameAndCompany);
    DATASET (rec_nmlsInfo) nmlsInfo := DATASET([],rec_nmlsInfo);
    STRING50 CompanyName := '';
    STRING50 CompanyAka := '';
    STRING12 UniqueId := '';
    STRING12 BusinessId := '';
    iesp.share.t_BusinessIdentity BusinessIds;
    STRING9 SSN := '';
    STRING8 DOB := '';
    STRING8 LoadDate := '';
    STRING10 prim_range := '';
    STRING2 predir := '';
    STRING28 prim_name := '';
    STRING4 addr_suffix := '';
    STRING2 postdir := '';
    STRING10 unit_desig := '';
    STRING8 sec_range := '';
    STRING25 city := '';
    STRING2 st := '';
    STRING5 Zip5 := '';
    STRING4 Zip4 := '';
    STRING18 county := '';
    STRING3 fips_county := '';
    STRING8 DateFirstSeen := '';
    STRING8 DateLastSeen := '';
    STRING10 phone := ''; // added to layout as placeholder for penalization fnMacro
    UNSIGNED6 bdid := 0;
    UNSIGNED6 did := 0;
    STRING9 tin := '';
    UNSIGNED penalt := 99; //default to > common/GLOBAL penalty threshold(10)
    UNSIGNED populationPenalt := 99;
    STRING80 licenseType := '';
    STRING30 licenseNumber := '';
    STRING2 licenseIssueState := '';
    BOOLEAN isLicenseCurrent := FALSE;
    UNSIGNED8 nmls_id := 0;
    BOOLEAN exactMatch := FALSE;
    UNSIGNED4 global_sid;
    UNSIGNED8 record_sid;
    hash_layout;
  END;
    
  EXPORT Midex_RecordSearch_hash_layout := RECORD
    iesp.midexrecordsearch.t_MIDEXRecordSearchRecord;
    UNSIGNED8 SearchHash;
    UNSIGNED8 PrevSearchHash;
  END;

  EXPORT Midex_RecordSearch_hash_layout_plus := RECORD
    midex_RecordSearch_hash_layout;
    UNSIGNED2 penalt;
    UNSIGNED2 populationPenalt;
    UNSIGNED6 DID;
    UNSIGNED6 BDID;
    BIPV2.IDlayouts.l_xlink_ids;
  END;
    
  EXPORT rec_DBAName := RECORD
    STRING80 DBAName;
  END;
  
  EXPORT rec_NMLSWithDBAs := RECORD
    UNSIGNED6 NMLSId := 0;
    DATASET(rec_DBAName) DBANames := DATASET([],rec_DBAName);
  END;
  
  EXPORT LicenseInfo_Layout := RECORD
    STRING20 lic_number;
    STRING80 lic_type;
    STRING125 lic_status;
    STRING2 lic_state;
    STRING8 lic_issue_date;
    STRING8 lic_expir_date;
    BOOLEAN isCurrent;
    STRING50 business_type := '';
    STRING7 charter := '';
    UNSIGNED8 nmls_id := 0;
    STRING8 orig_issue_date := '';
  END;
    
  EXPORT license_srch_layout := RECORD
    STRING26 midex_rpt_nbr;
    UNSIGNED6 mari_rid;
    DATASET(rec_nmlsInfo) nmls_info;
    STRING20 licensee_FirstName;
    STRING20 licensee_MidName;
    STRING20 licensee_LastName;
    STRING150 licensee_companyName;
    UNSIGNED6 did;
    UNSIGNED6 bdid;
    BIPV2.IDlayouts.l_xlink_ids;
    address_layout;
    LicenseInfo_Layout;
    STRING9 ssn;
    STRING10 taxid;
    STRING80 data_source;
    STRING10 phone;
    UNSIGNED penalt := 99;
    BOOLEAN exactMatch := FALSE;
    STRING8 dob;
    UNSIGNED4 global_sid;
    UNSIGNED8 record_sid;
    hash_layout;
  END;
    
  EXPORT LicenseReport_ids := RECORD
    STRING26 midex_rpt_nbr;
    UNSIGNED6 mari_rid;
  END;

  EXPORT Location_Layout := RECORD
    UNSIGNED8 nmls_id;
    UNSIGNED8 comp_nmls_id;
    UNSIGNED6 mari_rid;
    STRING255 company_name;
    address_layout;
    STRING15 phone;
    STRING10 location_type;
    STRING8 start_date;
  END;
    
  EXPORT Represent_Registration_Layout := RECORD
    UNSIGNED8 nmls_id;
    UNSIGNED6 mari_rid;
    UNSIGNED8 comp_nmls_id;
    STRING255 company_name;
    STRING8 start_date;
    STRING8 end_date;
    STRING20 lic_number;
    STRING80 lic_type;
    STRING25 reg_status;
    STRING8 org_issue_date;
    STRING8 status_date;
    STRING4 renewed_thru;
    STRING3 authorized;
    STRING500 regulator_name;
    STRING500 registration_name;
  END;

  EXPORT Regulator_Layout := RECORD
    UNSIGNED8 nmls_id;
    UNSIGNED8 comp_nmls_id;
    UNSIGNED6 mari_rid;
    STRING500 regulator_name;
    STRING500 registration_name;
    STRING3 authorized;
    DATASET(Represent_Registration_Layout) Registrations{MAXCOUNT(iesp.Constants.MIDEX.MAX_COUNT_REGISTRATIONS)};
  END;
        
  EXPORT Action_Layout := RECORD
    UNSIGNED8 nmls_id;
    UNSIGNED8 comp_nmls_id;
    UNSIGNED6 mari_rid;
    STRING500 regulator_name;
    STRING500 authority_name;
    STRING500 authority_type;
    STRING70 action_type;
    STRING8 action_date;
    STRING500 assoc_doc;
    STRING action_detail;
  END;
    
  EXPORT LicenseReport_Layout := RECORD
    UNSIGNED6 mari_rid;
    UNSIGNED8 nmls_id;
    STRING80 data_source;
    STRING8 last_upd_date;
    UNSIGNED6 did;
    UNSIGNED6 bdid;
    BIPV2.IDlayouts.l_xlink_ids;
    STRING10 TitleName;
    STRING20 FirstName;
    STRING20 MiddleName;
    STRING20 LastName;
    STRING5 SuffixName;
    address_layout;
    STRING80 companyName;
    STRING80 DBAName;
    STRING2 company_predir;
    STRING10 company_prim_range;
    STRING28 company_prim_name;
    STRING4 company_addr_suffix;
    STRING2 company_postdir;
    STRING10 company_unit_desig;
    STRING8 company_sec_range;
    STRING25 company_city;
    STRING2 company_st;
    STRING5 company_zip5;
    STRING35 company_county;
    STRING3 company_county_fips;
    DATASET(LicenseInfo_Layout) Licenses;
    rec_NMLSWithDBAs NMLS_DBAs;
    DATASET(Location_Layout) Locations;
    DATASET(Represent_Registration_Layout) Represents;
    DATASET(Regulator_Layout) Regulators;
    DATASET(Action_Layout) Disc_Actions;
    DATASET(Action_Layout) Reg_Actions;
    STRING9 ssn;
    STRING8 dob;
    STRING10 taxid;
    STRING10 phone;
    STRING26 report_number;
    //CCPA-9 Add CCPA fields
    UNSIGNED4 global_sid;
    UNSIGNED8 record_sid;
    hash_layout;
  END;

  EXPORT LicenseReport_RollupTempLayout := RECORD
    LicenseReport_Layout;
    UNSIGNED8 LicNMLS_id := 0;
  END;

  EXPORT t_StringArrayItem := RECORD
    STRING value {MAXLENGTH(8192)};
  END;

  EXPORT compReport_nonpublicTextRawLayout := RECORD
    rec_midex_payloadKeyField;
    iesp.share.t_Date Date;
    STRING20 field_name;
    DATASET (iesp.share.t_StringArrayItem) Text;
    STRING4 orderNumber;
    STRING8 DateOfInclusion;
  END;
    
  EXPORT compReport_publicTextRawLayout := RECORD
    compReport_nonpublicTextRawLayout;
    STRING70 dataSource := '';
    STRING20 caseNumber := '';
    STRING8 incidentDate := '';
    STRING70 sourceDocument := '';
    STRING90 jurisdiction := '';
    STRING8 modifiedDate := '';
    STRING8 loadDate := '';
    STRING70 additionalInfo := '';
  END;
    
  EXPORT compReport_nonpublicCodesRawLayout := RECORD
    STRING8 BATCH := '';
    STRING1 DBCODE := '';
    STRING8 INCIDENT_NUM := '';
    STRING8 PARTY_NUM := '';
    STRING20 FIELD_NAME := '';
    STRING20 CODE_TYPE := '';
    STRING verification := '';
    DATASET (iesp.share.t_StringArrayItem) OTHER_DESC {MAXCOUNT(2000)};
    DATASET (iesp.midex_share.t_MIDEXLicenseInfo) Licenses;
  END;
    
  EXPORT compReport_AkaDbaLayout := RECORD
    STRING26 midex_rpt_nbr;
    STRING1 dbcode;
    STRING8 batchNumber;
    STRING8 incidentNumber;
    STRING8 partyNumber;
    STRING26 NP_subject_rpt_nbr;
    STRING8 NP_subjectParty_num;
    DATASET (iesp.share.t_Name) AKANames;
    DATASET (iesp.midexcompreport.t_MIDEXDBAName) DBANames;
    STRING1 NAME_TYPE;
  END;
        
  EXPORT compReport_iespPartyFlatPlusJoinFields := RECORD
    iesp.midexcompreport.t_MIDEXCompParty;
    STRING26 midex_rpt_nbr;
    STRING8 batch;
    STRING8 incident_num;
    STRING8 party_num;
    STRING26 NP_subject_rpt_nbr;
    STRING8 NP_subjectParty_num;
    STRING1 DBCODE;
  END;
    
  EXPORT compReport_iespPartyPlusJoinFields := RECORD
    DATASET(iesp.midexcompreport.t_MIDEXCompParty) partyRecs;
    STRING8 batch;
    STRING8 incident_num;
    STRING1 DBCODE;
  END;

  EXPORT compReport_PartyTempLayout := RECORD
    STRING26 midex_rpt_nbr;
    STRING1 dbcode;
    STRING8 batchNumber;
    STRING8 incidentNumber;
    STRING8 partyNumber;
    STRING26 NP_subject_rpt_nbr;
    STRING8 NP_subjectParty_num;
    STRING70 dataSource;
    STRING tin;
    STRING additionalInfo;
    IESP.SHARE.T_NAME Name;
    STRING9 ssn;
    IESP.SHARE.T_DATE dob;
    DATASET (compReport_nonpublicCodesRawLayout) Licenses;
    DATASET (iesp.midex_share.t_MIDEXLicenseInfo) LicensesSlimmed;
    DATASET (iesp.share.t_StringArrayItem) Professions;
    DATASET (iesp.share.t_stringArrayItem) otherIdentifyingRef;
    STRING80 nmlsType;
    STRING20 nmlsId;
    IESP.SHARE.T_ADDRESS address;
    STRING10 prim_range;
    STRING2 predir;
    STRING28 prim_name;
    STRING4 addr_suffix;
    STRING2 postdir;
    STRING10 unit_desig;
    STRING8 sec_range;
    STRING25 p_city_name;
    STRING25 v_city_name;
    STRING2 st;
    STRING5 zip5;
    STRING4 zip4;
    STRING3 fips_county;
    STRING35 county;
    STRING partyEmployer;
    STRING partyPosition;
    STRING partyFirm;
    STRING12 UniqueId;
    STRING12 BusinessId;
    iesp.share.t_BusinessIdentity businessIds;
    DATASET (iesp.share.t_Name) AKANames;
    DATASET (iesp.midexcompreport.t_MIDEXDBAName) DBANames;
    UNSIGNED6 DID;
    UNSIGNED4 global_sid;
    UNSIGNED8 record_sid;
  END;

  EXPORT CompReport_TempLayout := RECORD, MAXLENGTH( 20000 )
    rec_midex_payloadKeyField;
    STRING70 dataSource := '';
    UNSIGNED6 did := 0;
    UNSIGNED6 bdid := 0;
    BIPV2.IDlayouts.l_xlink_ids;
    STRING12 uniqueId := '';
    STRING12 businessId := '';
    iesp.share.t_BusinessIdentity businessIds := ROW([], iesp.share.t_BusinessIdentity);
    STRING9 ssn := '';
    STRING8 dob := '';
    STRING20 firstName := '';
    STRING20 middleName := '';
    STRING20 lastName := '';
    STRING5 suffixName := '';
    STRING3 prefixName := '';
    STRING60 personAKA := '';
    STRING45 jobTitle := '';
    STRING45 companyName := '';
    STRING150 ename := '';
    STRING60 companyAka := '';
    STRING30 tin := '';
    STRING10 prim_range := '';
    STRING2 predir := '';
    STRING28 prim_name := '';
    STRING4 addr_suffix := '';
    STRING2 postdir := '';
    STRING10 unit_desig := '';
    STRING8 sec_range := '';
    STRING25 city := '';
    STRING2 st := '';
    STRING5 zip5 := '';
    STRING4 zip4 := '';
    STRING18 county := '';
    STRING2 fips_state := '';
    STRING3 fips_county := '';
    STRING80 propertyAddr := '';
    STRING25 propertyCity := '';
    STRING2 propertyState := '';
    STRING10 propertyZip := '';
    STRING8 incidentDate := '';
    STRING70 sourceDocument := '';
    STRING90 jurisdiction := '';
    STRING20 caseNumber := '';
    STRING70 additionalInfo := '';
    STRING8 incidentReportedOnDate := '';
    STRING8 entryDate := '';
    STRING8 modifiedDate := '';
    STRING8 loadDate := '';
    STRING8 DateOfInclusion := '';
    iesp.midexcompreport.t_MIDEXCompComment freddieIncidentText;
    iesp.midexcompreport.t_MIDEXCompComment incidentText;
    iesp.midexcompreport.t_MIDEXCompComment responseText;
    DATASET (iesp.share.t_StringArrayItem) otherIdentifyingRef;
    DATASET (iesp.midexcompreport.t_midexCompParty) IncidentParties;
    DATASET (iesp.midex_share.t_MIDEXLicenseInfo) Licenses;
    DATASET (iesp.share.t_StringArrayItem) Professions;
    DATASET (iesp.share.t_StringArrayItem) PublicActions;
    STRING80 nmlsType;
    STRING20 nmlsId;
    STRING verification;
    STRING4 order_number := '';
    STRING255 action := '';
    STRING255 incidentVerification := '';
    STRING255 incidentCodeKeyText := '';
    STRING255 otherInfo := '';
    STRING26 MIDEXFileNumber := '';
    STRING10 Restitution := '';
    STRING10 FINES_LEVIED := '';
    STRING10 Alleged_amount := '';
    STRING10 Estimated_loss := '';
    STRING45 PartyPosition := '';
    STRING45 PartyFirm := '';
    STRING45 PartyEmployer := '';
    STRING10 Phone := '';
    DATASET (iesp.share.t_Name) AKANames;
    DATASET (iesp.midexcompreport.t_MIDEXDBAName) DBANames;
    UNSIGNED4 global_sid;
    UNSIGNED8 record_sid;
    hash_layout;
  END; // Record CompReport_TempLayout

  EXPORT Monitor_layout := RECORD
    STRING26 report_number;
    hash_layout;
    STRING25 passed_name_hash;
    STRING25 passed_license_status_hash;
    STRING25 passed_address_hash;
    STRING25 passed_phone_hash;
    STRING25 passed_license_hash;
    STRING25 passed_incident_hash;
    STRING25 passed_all_hash;
    STRING25 passed_bankruptcy_hash;
    STRING25 passed_criminal_hash;
    STRING25 passed_lien_judgment_hash;
    STRING25 passed_nmls_ID_hash;
    STRING25 passed_Represent_hash;
    STRING25 passed_Registration_hash;
    STRING25 passed_Disciplinary_hash;
    STRING25 passed_email_hash;
    STRING25 passed_property_hash;
    STRING25 passed_relative_hash;
    STRING25 passed_bus_associate_hash;
    STRING25 passed_employer_hash;
    STRING25 passed_name_variation_hash;
    STRING25 passed_executive_hash;
    STRING25 passed_SOS_hash;
    STRING25 passed_AKA_and_name_variation_hash;
  END;
  
  EXPORT company_title_rec := doxie_cbrs.layout_contact.company_title_rec;
  
  EXPORT rec_SmartLinxBusinessPlusSources := RECORD
    iesp.midexcompreport.t_MidexCompBusinessSmartLinxRecord;
    DATASET(iesp.share.t_SourceSection) Sources;
  END;
  
  // created the smartlinx records becasue the record layout is not exported in the service
  EXPORT rec_SmartLinxPersonWithSources := RECORD
    (iesp.smartlinxreport.t_SmartlinxReportIndividual)
    DATASET(iesp.share.t_CodeMap) Messages;
  END;
  
  EXPORT rec_TopBusiness := RECORD
    STRING acctno;
    iesp.midexcompreport.t_MIDEXCompTopBusinessRecord;
  END;
  
  EXPORT rec_NMLSIds := RECORD
    UNSIGNED6 NMLSId;
  END;
  
  EXPORT rec_NMLSWithDBAsAndMariRid := RECORD
    UNSIGNED6 NMLSId;
    DATASET(rec_DBAName) DBANames;
    DATASET(rec_profLicMari_payloadKeyField) MariRids;
  END;

END;
