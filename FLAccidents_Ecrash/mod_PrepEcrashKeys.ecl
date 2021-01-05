IMPORT STD;
EXPORT mod_PrepEcrashKeys(DATASET(Layout_eCrash.Consolidation) EcrashIn = FLAccidents_Ecrash.File_KeybuildV2.out) := MODULE

SHARED SupplementalBase := Files.Base.Supplemental;
SHARED ds_PhotoBase := Files.Base.PhotoBase;

SHARED fn_accnbrv1(DATASET(Layout_eCrash.Consolidation) Input) := FUNCTION
Filter_CRU := EcrashIn(report_code not in ['EA','TM','TF']);
				
// normalize addl_report_number for ecrash TM,TF and EA work type 1,0
NormAddlRpt := PROJECT(Input(TRIM(addl_report_number,LEFT,RIGHT) NOT IN ['','0','UNK', 'UNKNOWN'] AND work_type_id NOT IN ['2','3']), TRANSFORM( {Input}, 
                       SELF.accident_nbr :=STD.Str.Filter(LEFT.addl_report_number,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789');
                       SELF := LEFT)); 
crash_accnbr_base_norm := (Input + NormAddlRpt + Filter_CRU (vin+driver_license_nbr+tag_nbr+lname <> '')) (TRIM(accident_nbr,LEFT,RIGHT)<>'');
											 
dst_accnbr_base := DISTRIBUTE(crash_accnbr_base_norm, HASH32(orig_accnbr));
srt_accnbr_base := SORT(dst_accnbr_base, EXCEPT did, EXCEPT b_did, LOCAL);
unq_accnbr_base := DEDUP(srt_accnbr_base, EXCEPT did, EXCEPT b_did, LOCAL);
dep_accnbr_base := PROJECT(unq_accnbr_base, TRANSFORM({STRING40 l_accnbr, RECORDOF(unq_accnbr_base)},
                                                       SELF.l_accnbr := LEFT.accident_nbr;
																											 SELF := LEFT;
																											 ));
RETURN dep_accnbr_base;
END;

//***********************************************************************
//                 key_Ecrashv2_accnbrv1_father
//***********************************************************************
Ecrash := EcrashIn(report_code IN ['EA','TM','TF']);//for ecrash iyetek they need report number displayed even no vin and name
EXPORT dep_accnbr_base := fn_accnbrv1(Ecrash);

//***********************************************************************
//                 key_ecrashV2_dol
//***********************************************************************
allrecs := EcrashIn(vin+driver_license_nbr+tag_nbr+lname <> '' AND 
                    (TRIM(report_type_id,ALL) IN ['A','DE'] OR STD.str.ToUpperCase(TRIM(vendor_code,LEFT,RIGHT)) = 'CMPD'));

crash_base := PROJECT(allrecs((accident_date<>'' AND (UNSIGNED) accident_date<>0) ), Layout_PrepEcrashKeys.dol_slim);
											 
dst_base := DISTRIBUTE(crash_base, HASH32(accident_date));
srt_base := SORT(dst_base, EXCEPT did, EXCEPT b_did, LOCAL);
//dep_base := dedup(srt_base, except did, except b_did, local);
EXPORT dep_base := DEDUP(srt_base, accident_nbr, accident_date, report_code, jurisdiction, jurisdiction_state, report_type_id, LOCAL);

//***********************************************************************
//                 Key_eCrashv2_LinkIds
//***********************************************************************

              //NO CHANGE - TO BE DEPRECATED//

//***********************************************************************
//         key_EcrashV2_Unrestricted_accnbrv1
//***********************************************************************
// eCrash & CRU Reports
EcrashAndCru := EcrashIn(report_code IN ['EA','TM','TF'] AND  
                        (work_type_id IN ['2','3'] OR ( (work_type_id IN ['0','1']  AND 
												(TRIM(report_type_id,ALL) IN ['A','DE'] OR STD.str.ToUpperCase(TRIM(vendor_code,LEFT,RIGHT)) = 'CMPD'))) ) ); 
				
EXPORT Unrestricted_dep_accnbr_base := fn_accnbrv1(EcrashAndCru):INDEPENDENT;

//***********************************************************************
//           Key_eCrashV2_DeltaDate
//***********************************************************************
DeltaDate := Unrestricted_dep_accnbr_base(report_code IN ['EA','TM','TF'] AND work_type_id NOT IN ['2','3'] AND 
										                      (TRIM(report_type_id,ALL) IN ['A','DE'] OR STD.str.ToUpperCase(TRIM(vendor_code,LEFT,RIGHT)) = 'CMPD'));
														
MaxDate := MAX(DeltaDate, (INTEGER)date_vendor_last_reported);

STRING8 Delta_Date := IF ((INTEGER)MaxDate > 0,INTFORMAT((INTEGER)MaxDate,8,1),mod_Utilities.StrSysDate);

EXPORT DateFile := DATASET([{'DELTADATE',Delta_Date}],FLAccidents_Ecrash.Layouts.Delta_Date);

//***********************************************************************
//           Key_ECrashV2_Payload
//***********************************************************************

     // AUTO KEY - Updated in File_Ecrash_AutoKeyV2//

//***********************************************************************
//           key_EcrashV2_agency
//***********************************************************************
EXPORT AgencyBase :=  PROJECT(Files.Base.AgencyCmbd, TRANSFORM(Layout_Keys_eCrash.Agency, SELF := LEFT; SELF := [];));

//***********************************************************************
//           Key_ecrashV2_PhotoId
//***********************************************************************
ds_SupplementalBase := SupplementalBase(TRIM(Report_Type_Id, LEFT, RIGHT) IN ['A','DE'] OR
                                               STD.Str.ToUpperCase(TRIM(Vendor_Code, LEFT, RIGHT)) = 'CMPD');
d_SupplementalBase := DISTRIBUTE(ds_SupplementalBase, HASH32(Super_Report_Id));
ds_SuperReport := DEDUP(SORT(d_SupplementalBase, Super_Report_Id, Report_Id, LOCAL), Super_Report_Id, Report_Id, LOCAL);

Layout_Keys_eCrash.PhotoId trans_PhotoSuperReport(ds_PhotoBase l, ds_SuperReport r):= TRANSFORM
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
EXPORT dep_Report_base := DEDUP(srt_Report_base, report_id, Super_report_id,LOCAL);

//***********************************************************************
//           Key_eCrashv2_Supplemental
//***********************************************************************
// Update and latest hashkeys included. 
supp_allrecs   := SupplementalBase( u_d_flag <> 'D' AND  (((TRIM(report_type_id,ALL) IN ['A','DE'] OR STD.str.ToUpperCase(TRIM(vendor_code,LEFT,RIGHT)) = 'CMPD')) OR 
																												  TRIM(vendor_code,LEFT,RIGHT) = 'COPLOGIC'));
  
dst_supp_allrecs := DISTRIBUTE(Supp_allrecs, HASH32(super_report_id));
srt_supp_base    := SORT(dst_supp_allrecs, super_report_id,hash_key,report_code,creation_date,Sent_to_HPCC_DateTime,MAP(u_d_flag='' => 3,u_d_flag = 'U' => 2, 1),report_id, LOCAL);
EXPORT ded_base    := DEDUP(srt_supp_base, super_report_id,hash_key,report_code,RIGHT, LOCAL);  

END;