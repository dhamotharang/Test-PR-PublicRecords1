IMPORT STD, dx_Ecrash;

EXPORT mod_PrepEcrashPRKeys(DATASET(Layout_eCrash.Consolidation) proutIn = Files_eCrash.Ds_Base_Consolidation_PR) := MODULE

SHARED proutReportable := proutIn(allow_Sale_Of_Component_Data = TRUE):INDEPENDENT;

//***********************************************************************
//                 key_EcrashV2_accnbr
//***********************************************************************
Ecrash := proutReportable(report_code IN ['EA','TM','TF']);//for ecrash iyetek they need report number displayed even no vin and name
Filter_CRU := proutReportable(report_code NOT IN ['EA','TM','TF']);

crash_accnbr_base := 	Ecrash + Filter_CRU (vin+driver_license_nbr+tag_nbr+lname <>''); 
						
// normalize addl_report_number 
NormAddlRpt := PROJECT(crash_accnbr_base(TRIM(addl_report_number,LEFT,RIGHT) NOT IN ['','0','UNK', 'UNKNOWN'] AND report_code IN ['TF','TM']), TRANSFORM( {crash_accnbr_base}, 
                                         SELF.accident_nbr :=STD.Str.Filter(LEFT.addl_report_number,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789');
                                         SELF := LEFT)); 

crash_accnbr_base_norm := (crash_accnbr_base + NormAddlRpt) (TRIM(accident_nbr,LEFT,RIGHT)<>'');
											 
dst_accnbr_base := DISTRIBUTE(crash_accnbr_base_norm, HASH32(orig_accnbr));
srt_accnbr_base := SORT(dst_accnbr_base, EXCEPT did, EXCEPT b_did, LOCAL);
unq_accnbr_base := DEDUP(srt_accnbr_base, EXCEPT did, EXCEPT b_did, LOCAL);
EXPORT dep_accnbr_base := PROJECT(unq_accnbr_base, TRANSFORM(dx_Ecrash.Layouts.ACCNBR,
                                                             SELF.l_accnbr := LEFT.accident_nbr;
																													   SELF := LEFT;
																													   ));

//***********************************************************************
//                 key_EcrashV2_accnbrv1
//***********************************************************************
// eCrash & CRU Reports
EcrashAndCru_v1 := proutReportable(report_code IN ['EA','TM','TF'] AND  
                         (work_type_id IN ['2','3'] OR ( (work_type_id IN ['0','1']  AND 
                         (TRIM(report_type_id,ALL) IN ['A','DE'] OR STD.str.ToUpperCase(TRIM(vendor_code,LEFT,RIGHT)) = 'CMPD'))) ) ); 
// CRU Inq/Natational Accident Reports
Filter_CRU_v1 := proutReportable(report_code not in ['EA','TM','TF']);
				
// eCrash Reports:  normalize addl_report_number for ecrash TM,TF and EA work type 1,0
NormAddlRpt_v1 := PROJECT(EcrashAndCru_v1(TRIM(addl_report_number,LEFT,RIGHT) NOT IN ['','0','UNK', 'UNKNOWN'] AND work_type_id NOT IN ['2','3']), 
                       TRANSFORM( {EcrashAndCru_v1},
                                 SELF.accident_nbr := STD.Str.Filter(LEFT.addl_report_number,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789');
                                 SELF := LEFT;)); 

crash_accnbrv1_base_norm_v1 := (EcrashAndCru_v1 + NormAddlRpt_v1 + Filter_CRU_v1 (vin+driver_license_nbr+tag_nbr+lname <> '')) (TRIM(accident_nbr,LEFT,RIGHT)<> '');
											  
dst_accnbrv1_base := DISTRIBUTE(crash_accnbrv1_base_norm_v1, HASH32(orig_accnbr));
srt_accnbrv1_base := SORT(dst_accnbrv1_base, EXCEPT did, EXCEPT b_did, LOCAL);
unq_accnbrv1_base := DEDUP(srt_accnbrv1_base, EXCEPT did, EXCEPT b_did, LOCAL);
EXPORT dep_accnbrv1_base := PROJECT(unq_accnbrv1_base, TRANSFORM(dx_Ecrash.Layouts.ACCNBRV1,
                                                                 SELF.l_accnbr := LEFT.accident_nbr;
																													       SELF := LEFT;
																													       )):INDEPENDENT;
											
//***********************************************************************
//                 key_EcrashV2_accnbr_father
//***********************************************************************
allrecs := proutReportable(vin+driver_license_nbr+tag_nbr+lname <>'');

crash_accnbr_father_base := allrecs(accident_nbr<>'');

// normalize addl_report_number 
NormAddlRpt := PROJECT(crash_accnbr_father_base(addl_report_number NOT IN ['','0','UNK', 'UNKNOWN'] AND report_code IN ['TF','TM']), TRANSFORM( {crash_accnbr_father_base}, 
                       SELF.accident_nbr :=STD.Str.Filter(LEFT.addl_report_number,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789');
                       SELF := LEFT)); 

crash_accnbr_father_base_norm := crash_accnbr_father_base + NormAddlRpt;
											 
dst_accnbr_father_base := DISTRIBUTE(crash_accnbr_father_base_norm, HASH32(orig_accnbr));
srt_accnbr_father_base := SORT(dst_accnbr_father_base, EXCEPT did, EXCEPT b_did, LOCAL);
unq_accnbr_father_base := DEDUP(srt_accnbr_father_base, EXCEPT did, EXCEPT b_did, LOCAL);
EXPORT dep_accnbr_father_base := PROJECT(unq_accnbr_father_base, TRANSFORM(dx_Ecrash.Layouts.ACCNBR,
                                                              SELF.l_accnbr := LEFT.accident_nbr;
																													    SELF := LEFT;
																													    ));
//***********************************************************************
//                    Key_EcrashV2_bdid
//***********************************************************************
dst_bdid_base := DISTRIBUTE(proutReportable(b_did<>'',b_did<>'000000000000'), HASH32(b_did, orig_accnbr));
srt_bdid_base := SORT(dst_bdid_base, b_did, orig_accnbr, LOCAL);
unq_bdid_base := DEDUP(srt_bdid_base, b_did, orig_accnbr, LOCAL);  
EXPORT ded_bdid_base := PROJECT(unq_bdid_base, TRANSFORM(dx_Ecrash.Layouts.BDID,
                                                          SELF.l_bdid := (INTEGER)LEFT.b_did;
																												  SELF := LEFT;
																												  ));

//***********************************************************************
//                     Key_EcrashV2_did
//***********************************************************************
dDIDBase := DISTRIBUTE(proutReportable(DID <> '', DID <> '000000000000'), HASH32(DID, Orig_Accnbr));
sDIDBase := SORT(dDIDBase, DID, Orig_Accnbr, Vin, LOCAL);
uDIDBase := DEDUP(sDIDBase, DID, Orig_Accnbr, Vin, LOCAL);  

dx_Ecrash.Layouts.DID xformDID(uDIDBase l) :=  TRANSFORM
 SELF.l_DID := (INTEGER)l.DID;
 SELF.Accident_Nbr := l.Accident_Nbr;
 SELF.Vin := l.Vin;
 SELF.Orig_Accnbr := l.Orig_Accnbr;
 SELF.report_code := l.report_code;
 SELF.jurisdiction := l.jurisdiction;
 SELF.jurisdiction_state := l.jurisdiction_state;
 SELF.jurisdiction_nbr := l.jurisdiction_nbr;
 SELF.vehicle_incident_st := l.vehicle_incident_st;
 SELF := l;
 SELF := []; 
END;
EXPORT DIDBase := PROJECT(uDIDBase, xformDID(LEFT));

//***********************************************************************
//                    Key_EcrashV2_DLNbr
//***********************************************************************
ecrash_dlnbr_base := proutReportable(driver_license_nbr<>'');

dst_dlnbr_base := DISTRIBUTE(ecrash_dlnbr_base, HASH32(driver_license_nbr, orig_accnbr));
srt_dlnbr_base := SORT(dst_dlnbr_base, driver_license_nbr, orig_accnbr, LOCAL);
unq_dlnbr_base := DEDUP(srt_dlnbr_base, driver_license_nbr, orig_accnbr, LOCAL);
EXPORT dep_dlnbr_base := PROJECT(unq_dlnbr_base, TRANSFORM(dx_Ecrash.Layouts.DLNBR,
                                                           SELF.l_dlnbr := LEFT.driver_license_nbr;
																												   SELF := LEFT;
																												   ));
//***********************************************************************
//                    Key_EcrashV2_tagnbr
//***********************************************************************
ecrash_tagnbr_base := proutReportable(tag_nbr<>'');

dst_tagnbr_base := DISTRIBUTE(ecrash_tagnbr_base, HASH32(tag_nbr, orig_accnbr));
srt_tagnbr_base := SORT(dst_tagnbr_base, tag_nbr, orig_accnbr, LOCAL);
unq_tagnbr_base := DEDUP(srt_tagnbr_base, tag_nbr, orig_accnbr, LOCAL);
EXPORT dep_tagnbr_base := PROJECT(unq_tagnbr_base, TRANSFORM(dx_Ecrash.Layouts.TAGNBR,
                                                            SELF.l_tagnbr := LEFT.tag_nbr;
																												    SELF := LEFT;
																												    ));

//***********************************************************************
//                     Key_EcrashV2_vin
//***********************************************************************
Vinallrecs := proutReportable(Vin <> '' AND Vin <> '0' );
dVinBase := DISTRIBUTE(Vinallrecs, HASH32(Vin, Orig_Accnbr));
sVinBase := SORT(dVinBase, Vin, Orig_Accnbr, LOCAL);
uVinBase := DEDUP(sVinBase, Vin, Orig_Accnbr, LOCAL);  

dx_Ecrash.Layouts.VIN xformVin(uVinBase l) :=  TRANSFORM
 SELF.l_Vin := l.Vin;
 SELF.Accident_Nbr := l.Accident_Nbr;
 SELF.Orig_Accnbr := l.Orig_Accnbr;
 SELF.report_code := l.report_code;
 SELF.jurisdiction := l.jurisdiction;
 SELF.jurisdiction_state := l.jurisdiction_state;
 SELF.jurisdiction_nbr := l.jurisdiction_nbr;
 SELF.vehicle_incident_st := l.vehicle_incident_st;
 SELF := l;
 SELF := [];
END;
EXPORT VinBase := PROJECT(uVinBase, xformVin(LEFT)):INDEPENDENT;

//***********************************************************************
//                    Key_EcrashV2_vin7
//***********************************************************************
ecrash_vin_base := VinBase;

dx_Ecrash.Layouts.VIN7 add_vin7(ecrash_vin_base l):=TRANSFORM
 len := LENGTH(TRIM(l.l_vin));
 SELF.l_vin7 := l.l_vin[len-6..len];
 SELF := l;	
END;
EXPORT ecrash_vin_base_7:= PROJECT(ecrash_vin_base,add_vin7(LEFT))(TRIM(l_vin7)<>'');

END;
