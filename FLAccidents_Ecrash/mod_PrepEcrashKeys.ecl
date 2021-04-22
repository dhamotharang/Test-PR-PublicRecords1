IMPORT STD, dx_Ecrash;

EXPORT mod_PrepEcrashKeys(DATASET(Layout_eCrash.Consolidation) EcrashIn = Files_eCrash.Ds_Base_Consolidation_Ecrash) := MODULE
SHARED SupplementalBase := Files_eCrash.DS_BASE_SUPPLEMENTAL;
SHARED ds_PhotoBase := Files_eCrash.DS_BASE_DOCUMENT;

//***********************************************************************
//                 key_ecrashV2_dol
//***********************************************************************
allrecs := EcrashIn(vin+driver_license_nbr+tag_nbr+lname <> '' AND 
                    (TRIM(report_type_id,ALL) IN ['A','DE'] OR STD.str.ToUpperCase(TRIM(vendor_code,LEFT,RIGHT)) = 'CMPD'));

crash_base := PROJECT(allrecs((accident_date<>'' AND (UNSIGNED) accident_date<>0) ), dx_Ecrash.Layouts.DOL);
											 
dst_base := DISTRIBUTE(crash_base, HASH32(accident_date));
srt_base := SORT(dst_base, EXCEPT did, EXCEPT b_did, LOCAL);
//dep_base := dedup(srt_base, except did, except b_did, local);
EXPORT dep_base := DEDUP(srt_base, accident_nbr, accident_date, report_code, jurisdiction, jurisdiction_state, report_type_id, LOCAL);

//***********************************************************************
//         key_EcrashV2_Unrestricted_accnbrv1
//***********************************************************************
// eCrash & CRU Reports
EcrashAndCru := EcrashIn(report_code IN ['EA','TM','TF'] AND  
                        (work_type_id IN ['2','3'] OR ( (work_type_id IN ['0','1']  AND 
												(TRIM(report_type_id,ALL) IN ['A','DE'] OR STD.str.ToUpperCase(TRIM(vendor_code,LEFT,RIGHT)) = 'CMPD'))) ) ); 
Filter_CRU := EcrashIn(report_code not in ['EA','TM','TF']);
				
// normalize addl_report_number for ecrash TM,TF and EA work type 1,0
NormAddlRpt := PROJECT(EcrashAndCru(TRIM(addl_report_number,LEFT,RIGHT) NOT IN ['','0','UNK', 'UNKNOWN'] AND work_type_id NOT IN ['2','3']), TRANSFORM( {EcrashAndCru}, 
                       SELF.accident_nbr :=STD.Str.Filter(LEFT.addl_report_number,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789');
                       SELF := LEFT)); 
crash_accnbr_base_norm := (EcrashAndCru + NormAddlRpt + Filter_CRU (vin+driver_license_nbr+tag_nbr+lname <> '')) (TRIM(accident_nbr,LEFT,RIGHT)<>'');
											 
dst_accnbr_base := DISTRIBUTE(crash_accnbr_base_norm, HASH32(orig_accnbr));
srt_accnbr_base := SORT(dst_accnbr_base, EXCEPT did, EXCEPT b_did, LOCAL);
unq_accnbr_base := DEDUP(srt_accnbr_base, EXCEPT did, EXCEPT b_did, LOCAL);
dep_accnbr_base := PROJECT(unq_accnbr_base, TRANSFORM(dx_Ecrash.Layouts.UNRESTRICTED_ACCNBRV1,
                                                       SELF.l_accnbr := LEFT.accident_nbr;
																											 SELF := LEFT;
																											 ));	
EXPORT Unrestricted_dep_accnbr_base := dep_accnbr_base:INDEPENDENT;

//***********************************************************************
//           Key_eCrashV2_DeltaDate
//***********************************************************************
DeltaDate := Unrestricted_dep_accnbr_base(report_code IN ['EA','TM','TF'] AND work_type_id NOT IN ['2','3'] AND 
										                      (TRIM(report_type_id,ALL) IN ['A','DE'] OR STD.str.ToUpperCase(TRIM(vendor_code,LEFT,RIGHT)) = 'CMPD'));
														
MaxDate := MAX(DeltaDate, (INTEGER)date_vendor_last_reported);

STRING8 Delta_Date := IF ((INTEGER)MaxDate > 0,INTFORMAT((INTEGER)MaxDate,8,1),mod_Utilities.StrSysDate);

EXPORT DateFile := DATASET([{'DELTADATE',Delta_Date}],dx_Ecrash.Layouts.DELTADATE);

//***********************************************************************
//           Key_ECrashV2_Payload
//***********************************************************************

     // AUTO KEY - Updated in File_Ecrash_AutoKeyV2//

//***********************************************************************
//           key_EcrashV2_agency
//***********************************************************************
dsAgencyBase := PROJECT(Files_eCrash.DS_BASE_CONSOLIDATION_MBSAgency, TRANSFORM(dx_Ecrash.Layouts.AGENCY, SELF := LEFT; SELF := [];));

dsMissingAgency_1520372_CT := PROJECT(dsAgencyBase(mbsi_agency_id = '1520372' AND SOURCE_ID = 'P' AND AGENCY_STATE_ABBR = 'NJ' ), TRANSFORM(RECORDOF(dsAgencyBase), SELF.AGENCY_STATE_ABBR := 'CT'; SELF := LEFT));
dsMissingAgency_1520372_PA := PROJECT(dsAgencyBase(mbsi_agency_id = '1520372' AND SOURCE_ID = 'P' AND AGENCY_STATE_ABBR = 'NJ'), TRANSFORM(RECORDOF(dsAgencyBase), SELF.AGENCY_STATE_ABBR := 'PA'; SELF := LEFT));

dsMissingAgency_1521832_NY := PROJECT(dsAgencyBase(mbsi_agency_id = '1521832' AND SOURCE_ID = 'S' AND AGENCY_STATE_ABBR = 'NJ'), TRANSFORM(RECORDOF(dsAgencyBase), SELF.AGENCY_STATE_ABBR := 'NY'; SELF := LEFT));

dsMissingAgency_1522732_NY_E := PROJECT(dsAgencyBase(mbsi_agency_id = '1522732' AND SOURCE_ID = 'E' AND AGENCY_STATE_ABBR = 'NJ'), TRANSFORM(RECORDOF(dsAgencyBase), SELF.AGENCY_STATE_ABBR := 'NY'; SELF := LEFT));
dsMissingAgency_1522732_NY_P := PROJECT(dsAgencyBase(mbsi_agency_id = '1522732' AND SOURCE_ID = 'P' AND AGENCY_STATE_ABBR = 'NJ'), TRANSFORM(RECORDOF(dsAgencyBase), SELF.AGENCY_STATE_ABBR := 'NY'; SELF := LEFT));

dsMissingAgency_1531712_AR := PROJECT(dsAgencyBase(mbsi_agency_id = '1531712' AND SOURCE_ID = 'P' AND AGENCY_STATE_ABBR = 'TX'), TRANSFORM(RECORDOF(dsAgencyBase), SELF.AGENCY_STATE_ABBR := 'AR'; SELF := LEFT));

dsMissingAgency_1535782_RT := PROJECT(dsAgencyBase(mbsi_agency_id = '1535782' AND SOURCE_ID = 'S' AND AGENCY_STATE_ABBR = 'NJ'), TRANSFORM(RECORDOF(dsAgencyBase), SELF.AGENCY_STATE_ABBR := 'RT'; SELF := LEFT));
dsMissingAgency_1535782_TE := PROJECT(dsAgencyBase(mbsi_agency_id = '1535782' AND SOURCE_ID = 'S' AND AGENCY_STATE_ABBR = 'NJ'), TRANSFORM(RECORDOF(dsAgencyBase), SELF.AGENCY_STATE_ABBR := 'TE'; SELF := LEFT));

dsMissingAgency_1597786_NE := PROJECT(dsAgencyBase(mbsi_agency_id = '1597786' AND SOURCE_ID = 'S' AND AGENCY_STATE_ABBR = 'NJ'), TRANSFORM(RECORDOF(dsAgencyBase), SELF.AGENCY_STATE_ABBR := 'NE'; SELF := LEFT));

dsMissingAgency_1536035_GA := PROJECT(dsAgencyBase(mbsi_agency_id = '1536035' AND SOURCE_ID = 'E' AND AGENCY_STATE_ABBR = 'MI'), TRANSFORM(RECORDOF(dsAgencyBase), SELF.AGENCY_STATE_ABBR := 'GA'; SELF := LEFT));//TEST

dsMissingAgency_1616157_CA := PROJECT(dsAgencyBase(mbsi_agency_id = '1616157' AND SOURCE_ID = 'A' AND AGENCY_STATE_ABBR = 'FL'), TRANSFORM(RECORDOF(dsAgencyBase), SELF.AGENCY_STATE_ABBR := 'CA'; SELF := LEFT)); //TEST

dsMissingAgency_1616167_NY := PROJECT(dsAgencyBase(mbsi_agency_id = '1616167' AND SOURCE_ID = 'A' AND AGENCY_STATE_ABBR = 'FL'), TRANSFORM(RECORDOF(dsAgencyBase), SELF.AGENCY_STATE_ABBR := 'NY'; SELF := LEFT)); //TEST

dsMissingAgency_1616177_NJ := PROJECT(dsAgencyBase(mbsi_agency_id = '1616177' AND SOURCE_ID = 'EB' AND AGENCY_STATE_ABBR = 'FL'), TRANSFORM(RECORDOF(dsAgencyBase), SELF.AGENCY_STATE_ABBR := 'NJ'; SELF := LEFT)); //TEST

dsMissingAgency_1616187_NM := PROJECT(dsAgencyBase(mbsi_agency_id = '1616187' AND SOURCE_ID = '' AND AGENCY_STATE_ABBR = 'FL'), TRANSFORM(RECORDOF(dsAgencyBase), SELF.AGENCY_STATE_ABBR := 'NM'; SELF := LEFT)); //TEST

dsMissingAgency_1616197_CA := PROJECT(dsAgencyBase(mbsi_agency_id = '1616197' AND SOURCE_ID = 'E' AND AGENCY_STATE_ABBR = 'FL'), TRANSFORM(RECORDOF(dsAgencyBase), SELF.AGENCY_STATE_ABBR := 'CA'; SELF := LEFT)); //TEST

dsMissingAgency_6664393_NJ := PROJECT(dsAgencyBase(mbsi_agency_id = '6664393' AND SOURCE_ID = 'C' AND AGENCY_STATE_ABBR = 'CA'), TRANSFORM(RECORDOF(dsAgencyBase), SELF.AGENCY_STATE_ABBR := 'NJ'; SELF := LEFT)); 

dsMissingAgency_6716373_CT := PROJECT(dsAgencyBase(mbsi_agency_id = '6716373' AND SOURCE_ID = 'A' AND AGENCY_STATE_ABBR = 'MA'), TRANSFORM(RECORDOF(dsAgencyBase), SELF.AGENCY_STATE_ABBR := 'CT'; SELF := LEFT)); 

dsMissingAgency_6718143_NJ := PROJECT(dsAgencyBase(mbsi_agency_id = '6718143' AND SOURCE_ID = 'P' AND AGENCY_STATE_ABBR = 'NY'), TRANSFORM(RECORDOF(dsAgencyBase), SELF.AGENCY_STATE_ABBR := 'NJ'; SELF := LEFT)); 

dsMissingAgencyAll := dsMissingAgency_1520372_CT + dsMissingAgency_1520372_PA +
                      dsMissingAgency_1521832_NY +
											dsMissingAgency_1522732_NY_E + dsMissingAgency_1522732_NY_P +
                      dsMissingAgency_1531712_AR +
											dsMissingAgency_1535782_RT + dsMissingAgency_1535782_TE +
											dsMissingAgency_1597786_NE +
											dsMissingAgency_1536035_GA +
											dsMissingAgency_1616157_CA +
											dsMissingAgency_1616167_NY +
											dsMissingAgency_1616177_NJ +
											dsMissingAgency_1616187_NM +
											dsMissingAgency_1616197_CA +
											dsMissingAgency_6664393_NJ +
											dsMissingAgency_6716373_CT +
											dsMissingAgency_6718143_NJ;
											
dsAgencyBaseAll := dsAgencyBase + dsMissingAgencyAll;
EXPORT AgencyBase :=  dsAgencyBaseAll;

//***********************************************************************
//           key_EcrashV2_agencysource
//***********************************************************************
dsAgencySourceBase := PROJECT(Files_eCrash.DS_BASE_CONSOLIDATION_MBSAgency, TRANSFORM(dx_Ecrash.Layouts.AGENCYSOURCE, 
                                                                                      SELF.CONTRIB_SOURCE := LEFT.SOURCE_ID; 
                                                                                      SELF := LEFT; 
																																											SELF := [];));
EXPORT AgencySourceBase	:= dsAgencySourceBase;																																								
//***********************************************************************
//           Key_ecrashV2_PhotoId
//***********************************************************************
ds_SupplementalBase := SupplementalBase(TRIM(Report_Type_Id, LEFT, RIGHT) IN ['A','DE'] OR
                                               STD.Str.ToUpperCase(TRIM(Vendor_Code, LEFT, RIGHT)) = 'CMPD');
d_SupplementalBase := DISTRIBUTE(ds_SupplementalBase, HASH32(Super_Report_Id));
ds_SuperReport := DEDUP(SORT(d_SupplementalBase, Super_Report_Id, Report_Id, LOCAL), Super_Report_Id, Report_Id, LOCAL);

dx_Ecrash.Layouts.PHOTOID trans_PhotoSuperReport(ds_PhotoBase l, ds_SuperReport r):= TRANSFORM
	SELF.Super_Report_Id := r.Super_Report_Id;
	SELF.Document_ID := l.Document_ID;
	SELF.Report_Type := l.Report_Type;
	SELF.Incident_ID := l.Incident_ID;
	SELF.Document_Hash_Key := l.Document_Hash_Key;
	SELF.Date_Created := l.Date_Created;
	SELF.Is_Deleted := l.Is_Deleted;
	SELF.Page_Count := l.Page_Count;
	SELF.Extension := l.Extension;
	SELF.Report_Source := l.Report_Source;
	SELF := l;
	SELF := [];
END;

EXPORT ds_PhotoSuperCmbnd	:= JOIN(ds_PhotoBase, ds_SuperReport,
														 TRIM(LEFT.Incident_Id, LEFT, RIGHT) = TRIM(RIGHT.Incident_Id, LEFT, RIGHT),
														 trans_PhotoSuperReport(LEFT, RIGHT), HASH);
														
//***********************************************************************
//           Key_eCrashV2_ReportId
//***********************************************************************
// Contain all report id's till to date
Reportversion := SupplementalBase(( ((TRIM(report_type_id,ALL) IN ['A','DE'] OR STD.str.ToUpperCase(TRIM(vendor_code,LEFT,RIGHT)) = 'CMPD') AND 
																															TRIM(vendor_code, LEFT,RIGHT) <> 'COPLOGIC')) OR TRIM(vendor_code, LEFT, RIGHT) = 'COPLOGIC');

dst_Report_base := DISTRIBUTE(Reportversion, HASH32(Super_report_id));
srt_Report_base := SORT(dst_Report_base, report_id, Super_report_id, LOCAL);
ded_Report_base := DEDUP(srt_Report_base, report_id, Super_report_id, LOCAL);
EXPORT dep_Report_base := PROJECT(ded_Report_base, TRANSFORM(dx_Ecrash.Layouts.REPORTID, SELF := LEFT;, SELF := [];));

//***********************************************************************
//           Key_eCrashv2_Supplemental
//***********************************************************************
// Update and latest hashkeys included. 
supp_allrecs   := SupplementalBase( u_d_flag <> 'D' AND  (((TRIM(report_type_id,ALL) IN ['A','DE'] OR STD.str.ToUpperCase(TRIM(vendor_code,LEFT,RIGHT)) = 'CMPD')) OR 
																												  TRIM(vendor_code,LEFT,RIGHT) = 'COPLOGIC'));
  
dst_supp_allrecs := DISTRIBUTE(Supp_allrecs, HASH32(super_report_id));
srt_supp_base    := SORT(dst_supp_allrecs, super_report_id,hash_key,report_code,creation_date,Sent_to_HPCC_DateTime,MAP(u_d_flag='' => 3,u_d_flag = 'U' => 2, 1),report_id, LOCAL);
ded_supp_base    := DEDUP(srt_supp_base, super_report_id,hash_key,report_code,RIGHT, LOCAL);  
EXPORT ded_base := PROJECT(ded_supp_base, TRANSFORM(dx_Ecrash.Layouts.SUPPLEMENTAL, SELF := LEFT;, SELF := [];));
 
END;
