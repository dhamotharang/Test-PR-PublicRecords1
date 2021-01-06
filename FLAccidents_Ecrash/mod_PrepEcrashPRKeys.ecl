IMPORT FLAccidents, STD;
EXPORT mod_PrepEcrashPRKeys(DATASET(Layout_eCrash.Consolidation) proutIn = FLAccidents_Ecrash.File_KeybuildV2.prout) := MODULE

//***********************************************************************
//                 key_EcrashV2_accnbr
//***********************************************************************
Ecrash := proutIn(report_code IN ['EA','TM','TF']);//for ecrash iyetek they need report number displayed even no vin and name
Filter_CRU := proutIn(report_code NOT IN ['EA','TM','TF']);

crash_accnbr_base := 	Ecrash + Filter_CRU (vin+driver_license_nbr+tag_nbr+lname <>''); 
						
// normalize addl_report_number 
NormAddlRpt := PROJECT(crash_accnbr_base(TRIM(addl_report_number,LEFT,RIGHT) NOT IN ['','0','UNK', 'UNKNOWN'] AND report_code IN ['TF','TM']), TRANSFORM( {crash_accnbr_base}, 
                                         SELF.accident_nbr :=STD.Str.Filter(LEFT.addl_report_number,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789');
                                         SELF := LEFT)); 

crash_accnbr_base_norm := (crash_accnbr_base + NormAddlRpt) (TRIM(accident_nbr,LEFT,RIGHT)<>'');
											 
dst_accnbr_base := DISTRIBUTE(crash_accnbr_base_norm, HASH32(orig_accnbr));
srt_accnbr_base := SORT(dst_accnbr_base, EXCEPT did, EXCEPT b_did, LOCAL);
unq_accnbr_base := DEDUP(srt_accnbr_base, EXCEPT did, EXCEPT b_did, LOCAL);
EXPORT dep_accnbr_base := PROJECT(unq_accnbr_base, TRANSFORM({STRING40 l_accnbr, RECORDOF(unq_accnbr_base)},
                                                              SELF.l_accnbr := LEFT.accident_nbr;
																													    SELF := LEFT;
																													    ));

//***********************************************************************
//                 key_EcrashV2_accnbrv1
//***********************************************************************
// eCrash & CRU Reports
EcrashAndCru_v1 := proutIn(report_code IN ['EA','TM','TF'] AND  
                         (work_type_id IN ['2','3'] OR ( (work_type_id IN ['0','1']  AND 
                         (TRIM(report_type_id,ALL) IN ['A','DE'] OR STD.str.ToUpperCase(TRIM(vendor_code,LEFT,RIGHT)) = 'CMPD'))) ) ); 
// CRU Inq/Natational Accident Reports
Filter_CRU_v1 := proutIn(report_code not in ['EA','TM','TF']);
				
// eCrash Reports:  normalize addl_report_number for ecrash TM,TF and EA work type 1,0
NormAddlRpt_v1 := PROJECT(EcrashAndCru_v1(TRIM(addl_report_number,LEFT,RIGHT) NOT IN ['','0','UNK', 'UNKNOWN'] AND work_type_id NOT IN ['2','3']), 
                       TRANSFORM( {EcrashAndCru_v1},
                                 SELF.accident_nbr := STD.Str.Filter(LEFT.addl_report_number,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789');
                                 SELF := LEFT;)); 

crash_accnbrv1_base_norm_v1 := (EcrashAndCru_v1 + NormAddlRpt_v1 + Filter_CRU_v1 (vin+driver_license_nbr+tag_nbr+lname <> '')) (TRIM(accident_nbr,LEFT,RIGHT)<> '');
											  
dst_accnbrv1_base := DISTRIBUTE(crash_accnbrv1_base_norm_v1, HASH32(orig_accnbr));
srt_accnbrv1_base := SORT(dst_accnbrv1_base, EXCEPT did, EXCEPT b_did, LOCAL);
unq_accnbrv1_base := DEDUP(srt_accnbrv1_base, EXCEPT did, EXCEPT b_did, LOCAL);
EXPORT dep_accnbrv1_base := PROJECT(unq_accnbrv1_base, TRANSFORM({STRING40 l_accnbr, RECORDOF(unq_accnbrv1_base)},
                                                                 SELF.l_accnbr := LEFT.accident_nbr;
																													       SELF := LEFT;
																													       )):INDEPENDENT;
											
//***********************************************************************
//                 Key_EcrashV2_Partial_Report_Nbr
//***********************************************************************
// Allowing only EA agency and iyetek
in_accnbr := dep_accnbrv1_base(report_code IN ['EA','TM','TF'] AND work_type_id NOT IN ['2','3'] AND 
																											(TRIM(report_type_id,ALL) IN ['A','DE'] OR STD.str.ToUpperCase(TRIM(vendor_code,LEFT,RIGHT)) = 'CMPD'));
                            														
// parsing 40 char reportnumber 
parse_report := PROJECT(in_accnbr, TRANSFORM(Layout_PrepEcrashPRKeys.Partial_Report_Nbr_Slim, 

  part_num := IF(TRIM(STD.Str.FilterOut(LEFT.l_accnbr,'0-'),LEFT,RIGHT) ='' , '', TRIM(LEFT.l_accnbr,LEFT,RIGHT));
 
  SELF.f1 := part_num[1..4];
  SELF.f2 := IF(LENGTH(TRIM(part_num[2..5],LEFT,RIGHT)) < 4 , '',part_num[2..5]) ;
  SELF.f3 := IF(LENGTH(TRIM(part_num[3..6],LEFT,RIGHT)) < 4 , '',part_num[3..6]);
  SELF.f4 := IF(LENGTH(TRIM(part_num[4..7],LEFT,RIGHT)) < 4 , '',part_num[4..7]);
  SELF.f5 := IF(LENGTH(TRIM(part_num[5..8],LEFT,RIGHT)) < 4 , '',part_num[5..8]);
  SELF.f6 := IF(LENGTH(TRIM(part_num[6..9],LEFT,RIGHT)) < 4 , '',part_num[6..9]);
  SELF.f7 := IF(LENGTH(TRIM(part_num[7..10],LEFT,RIGHT)) < 4 , '',part_num[7..10]);
  SELF.f8 := IF(LENGTH(TRIM(part_num[8..11],LEFT,RIGHT)) < 4 , '',part_num[8..11]);
  SELF.f9 := IF(LENGTH(TRIM(part_num[9..12],LEFT,RIGHT)) < 4 , '',part_num[9..12]) ; 
  SELF.f10 := IF(LENGTH(TRIM(part_num[10..13],LEFT,RIGHT)) < 4 , '',part_num[10..13]); 
  SELF.f11 := IF(LENGTH(TRIM(part_num[11..14],LEFT,RIGHT)) < 4 , '',part_num[11..14]);
  SELF.f12 := IF(LENGTH(TRIM(part_num[12..15],LEFT,RIGHT)) < 4 , '',part_num[12..15]);
  SELF.f13 := IF(LENGTH(TRIM(part_num[13..16],LEFT,RIGHT)) < 4 , '',part_num[13..16]);
  SELF.f14 := IF(LENGTH(TRIM(part_num[14..17],LEFT,RIGHT)) < 4 , '',part_num[14..17]);
  SELF.f15 := IF(LENGTH(TRIM(part_num[15..18],LEFT,RIGHT)) < 4 , '',part_num[15..18]);
  SELF.f16 := IF(LENGTH(TRIM(part_num[16..19],LEFT,RIGHT)) < 4 , '',part_num[16..19]);
  SELF.f17 := IF(LENGTH(TRIM(part_num[17..20],LEFT,RIGHT)) < 4 , '',part_num[17..20]);
	SELF.f18 := IF(LENGTH(TRIM(part_num[18..21],LEFT,RIGHT)) < 4 , '',part_num[18..21]);
  SELF.f19 := IF(LENGTH(TRIM(part_num[19..22],LEFT,RIGHT)) < 4 , '',part_num[19..22]);
  SELF.f20 := IF(LENGTH(TRIM(part_num[20..23],LEFT,RIGHT)) < 4 , '',part_num[20..23]);
  SELF.f21 := IF(LENGTH(TRIM(part_num[21..24],LEFT,RIGHT)) < 4 , '',part_num[21..24]);
  SELF.f22 := IF(LENGTH(TRIM(part_num[22..25],LEFT,RIGHT)) < 4 , '',part_num[22..25]);
  SELF.f23 := IF(LENGTH(TRIM(part_num[23..26],LEFT,RIGHT)) < 4 , '',part_num[23..26]);
	SELF.f24 := IF(LENGTH(TRIM(part_num[24..27],LEFT,RIGHT)) < 4 , '',part_num[24..27]);
  SELF.f25 := IF(LENGTH(TRIM(part_num[25..28],LEFT,RIGHT)) < 4 , '',part_num[25..28]);
	SELF.f26 := IF(LENGTH(TRIM(part_num[26..29],LEFT,RIGHT)) < 4 , '',part_num[26..29]);
  SELF.f27 := IF(LENGTH(TRIM(part_num[27..30],LEFT,RIGHT)) < 4 , '',part_num[27..30]);
  SELF.f28 := IF(LENGTH(TRIM(part_num[28..31],LEFT,RIGHT)) < 4 , '',part_num[28..31]);
  SELF.f29 := IF(LENGTH(TRIM(part_num[29..32],LEFT,RIGHT)) < 4 , '',part_num[29..32]);
  SELF.f30 := IF(LENGTH(TRIM(part_num[30..33],LEFT,RIGHT)) < 4 , '',part_num[30..33]);
  SELF.f31 := IF(LENGTH(TRIM(part_num[31..34],LEFT,RIGHT)) < 4 , '',part_num[31..34]);
  SELF.f32 := IF(LENGTH(TRIM(part_num[32..35],LEFT,RIGHT)) < 4 , '',part_num[32..35]);
  SELF.f33 := IF(LENGTH(TRIM(part_num[33..36],LEFT,RIGHT)) < 4 , '',part_num[33..36]);
  SELF.f34 := IF(LENGTH(TRIM(part_num[34..37],LEFT,RIGHT)) < 4 , '',part_num[34..37]);
  SELF.f35 := IF(LENGTH(TRIM(part_num[35..38],LEFT,RIGHT)) < 4 , '',part_num[35..38]);
  SELF.f36 := IF(LENGTH(TRIM(part_num[36..39],LEFT,RIGHT)) < 4 , '',part_num[36..39]);
  SELF.f37 := IF(LENGTH(TRIM(part_num[37..40],LEFT,RIGHT)) < 4 , '',part_num[37..40]);
  SELF := LEFT)); 



 Layout_PrepEcrashPRKeys.Partial_Report_Nbr_slim_rec tslim(parse_report L, INTEGER cnt) := TRANSFORM
    SELF.partial_report_nbr := CHOOSE(cnt, l.f1,
																					 l.f2,
																					 l.f3,
																					 l.f4,
																					 l.f5,
																					 l.f6,
                                           l.f7,
                                           l.f8,
                                           l.f9,
                                           l.f10,
                                           l.f11,
                                           l.f12,
                                           l.f13,
                                           l.f14,
                                           l.f15,
                                           l.f16,
                                           l.f17,
                                           l.f18,
                                           l.f19,
                                           l.f20,
                                           l.f21,
                                           l.f22, 
																					 l.f23,
																					 l.f24,
																					 l.f25,
																					 l.f26,
																					 l.f27,
																					 l.f28,
																					 l.f29,
																					 l.f30,
																					 l.f31,
																					 l.f32,
																					 l.f33,
																					 l.f34,
																					 l.f35,
																					 l.f36,
																					 l.f37);						  	
		SELF := L;
	END;
norm_report := NORMALIZE(parse_report, 37, tslim(LEFT, COUNTER))(partial_report_nbr <>''); 
	 
EXPORT clean_partnbr := DEDUP(DISTRIBUTE(PROJECT(norm_report , TRANSFORM(Layout_PrepEcrashPRKeys.Partial_Report_Nbr_slim_rec , 
                                                                SELF.partial_report_nbr := IF(TRIM(STD.Str.FilterOut(LEFT.partial_report_nbr,'0-'),LEFT,RIGHT) ='' , '', TRIM(LEFT.partial_report_nbr,LEFT,RIGHT)),
					                                                      SELF := LEFT))(partial_report_nbr <>''),HASH32(l_accnbr)), ALL,LOCAL);
	 
//***********************************************************************
//                 key_EcrashV2_accnbr_father
//***********************************************************************
allrecs := proutIn(vin+driver_license_nbr+tag_nbr+lname <>'');

crash_accnbr_father_base := allrecs(accident_nbr<>'');

// normalize addl_report_number 
NormAddlRpt := PROJECT(crash_accnbr_father_base(addl_report_number NOT IN ['','0','UNK', 'UNKNOWN'] AND report_code IN ['TF','TM']), TRANSFORM( {crash_accnbr_father_base}, 
                       SELF.accident_nbr :=STD.Str.Filter(LEFT.addl_report_number,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789');
                       SELF := LEFT)); 

crash_accnbr_father_base_norm := crash_accnbr_father_base + NormAddlRpt;
											 
dst_accnbr_father_base := DISTRIBUTE(crash_accnbr_father_base_norm, HASH32(orig_accnbr));
srt_accnbr_father_base := SORT(dst_accnbr_father_base, EXCEPT did, EXCEPT b_did, LOCAL);
unq_accnbr_father_base := DEDUP(srt_accnbr_father_base, EXCEPT did, EXCEPT b_did, LOCAL);
EXPORT dep_accnbr_father_base := PROJECT(unq_accnbr_father_base, TRANSFORM({STRING40 l_accnbr, RECORDOF(unq_accnbr_father_base)},
                                                              SELF.l_accnbr := LEFT.accident_nbr;
																													    SELF := LEFT;
																													    ));
//***********************************************************************
//                    key_EcrashV2_bdid
//***********************************************************************
dst_bdid_base := DISTRIBUTE(proutIn(b_did<>'',b_did<>'000000000000'), HASH32(b_did, orig_accnbr));
srt_bdid_base := SORT(dst_bdid_base, b_did, orig_accnbr, LOCAL);
unq_bdid_base := DEDUP(srt_bdid_base, b_did, orig_accnbr, LOCAL);  
EXPORT ded_bdid_base := PROJECT(unq_bdid_base, TRANSFORM({UNSIGNED6 l_bdid, RECORDOF(unq_bdid_base)},
                                                          SELF.l_bdid := (integer)LEFT.b_did;
																												  SELF := LEFT;
																												  ));

//***********************************************************************
//                     Key_EcrashV2_did
//***********************************************************************
dDIDBase := DISTRIBUTE(proutIn(DID <> '', DID <> '000000000000'), HASH32(DID, Orig_Accnbr));
sDIDBase := SORT(dDIDBase, DID, Orig_Accnbr, Vin, LOCAL);
uDIDBase := DEDUP(sDIDBase, DID, Orig_Accnbr, Vin, LOCAL);  

Layout_Keys_PR.DID xformDID(uDIDBase l) :=  TRANSFORM
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
ecrash_dlnbr_base := proutIn(driver_license_nbr<>'');

dst_dlnbr_base := DISTRIBUTE(ecrash_dlnbr_base, HASH32(driver_license_nbr, orig_accnbr));
srt_dlnbr_base := SORT(dst_dlnbr_base, driver_license_nbr, orig_accnbr, LOCAL);
unq_dlnbr_base := DEDUP(srt_dlnbr_base, driver_license_nbr, orig_accnbr, LOCAL);
EXPORT dep_dlnbr_base := PROJECT(unq_dlnbr_base, TRANSFORM({STRING25 l_dlnbr, RECORDOF(unq_dlnbr_base)},
                                                            SELF.l_dlnbr := LEFT.driver_license_nbr;
																												    SELF := LEFT;
																												    ));
//***********************************************************************
//                    Key_EcrashV2_tagnbr
//***********************************************************************
ecrash_tagnbr_base := proutIn(tag_nbr<>'');

dst_tagnbr_base := DISTRIBUTE(ecrash_tagnbr_base, HASH32(tag_nbr, orig_accnbr));
srt_tagnbr_base := SORT(dst_tagnbr_base, tag_nbr, orig_accnbr, LOCAL);
unq_tagnbr_base := DEDUP(srt_tagnbr_base, tag_nbr, orig_accnbr, LOCAL);
EXPORT dep_tagnbr_base := PROJECT(unq_tagnbr_base, TRANSFORM({STRING10 l_tagnbr, RECORDOF(unq_tagnbr_base)},
                                                            SELF.l_tagnbr := LEFT.tag_nbr;
																												    SELF := LEFT;
																												    ));

//***********************************************************************
//                     Key_EcrashV2_vin
//***********************************************************************
Vinallrecs := proutIn(Vin <> '' AND Vin <> '0' );
dVinBase := DISTRIBUTE(Vinallrecs, HASH32(Vin, Orig_Accnbr));
sVinBase := SORT(dVinBase, Vin, Orig_Accnbr, LOCAL);
uVinBase := DEDUP(sVinBase, Vin, Orig_Accnbr, LOCAL);  

Layout_Keys_PR.VIN xformVin(uVinBase l) :=  TRANSFORM
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

Layout_PrepEcrashPRKeys.eCrash_vin7 add_vin7(ecrash_vin_base l):=TRANSFORM
 len:=LENGTH(TRIM(l.l_vin));
 SELF.l_vin7:=l.l_vin[len-6..len];
 SELF:=l;	
END;
EXPORT ecrash_vin_base_7:= PROJECT(ecrash_vin_base,add_vin7(LEFT))(TRIM(l_vin7)<>'');

END;