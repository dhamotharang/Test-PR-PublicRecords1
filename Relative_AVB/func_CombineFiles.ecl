IMPORT VehicleV2, bankruptcyv2, LiensV2, Property, LN_PropertyV2, ADDRESS, utility_business, experiancred, header,business_header, Inquiry_AccLogs, Enclarity, 
       Watercraft, faa, marriage_divorce_v2, UCCV2;

EXPORT func_CombineFiles(INTEGER test_amt = -1) := FUNCTION

TEST := MAP(test_amt <= 0 => CHOOSEN:ALL,
						 test_amt);
						 
isPop (string12 str) := str NOT IN ['','000000000000'];
pversion := '';
pUseProd := TRUE;
VH  := CHOOSEN(VehicleV2.Files.Base.Party_BIP(append_did>0), TEST);
BK  := CHOOSEN(bankruptcyv2.file_bankruptcy_search(isPop(did)), TEST);
BKM := CHOOSEN(bankruptcyv2.file_bankruptcy_main, TEST);
LN2 := CHOOSEN(IF(test_amt < 0, LiensV2.file_liens_party, project(LiensV2.file_Hogan_party, recordof(LiensV2.file_liens_party)))(isPop(did)), TEST); //good for testing
PRF := CHOOSEN(Property.File_Foreclosure_Base_v2, TEST)(isPop(name1_did)  OR isPop(name2_did)  OR isPop(name3_did)  OR isPop(name4_did)  OR 
                                                        isPop(name5_did)  OR isPop(name6_did)  OR isPop(name7_did)  OR isPop(name8_did));
PRS := CHOOSEN(LN_PropertyV2.File_Search_DID(did>0 AND ln_fares_id[2] IN ['A','D'] AND source_code[2] = 'P'), TEST);
PRT := CHOOSEN(LN_PropertyV2.File_addl_Fares_tax, TEST);
PRN := CHOOSEN(LN_PropertyV2.File_ln_deed_addlnames, TEST);
UTL := CHOOSEN(utility_business.Files().base.built, TEST);
XPC := CHOOSEN(experiancred.files.base_file_out(did>0), TEST);
BSA := CHOOSEN(business_header.File_Business_Contacts_Stats(bdid>0 AND did>0), TEST);
TU  := CHOOSEN(Header.File_Transunion_did(did>0) + Header.file_TUCS_did(did>0) + Header.File_TN_did(did>0), TEST);
EN  := CHOOSEN(Enclarity.Files(,pUseProd).associate_Base.QA(did>0), TEST);

WC  := CHOOSEN(Watercraft.File_Base_Search_Prod(DID>''), TEST);
AIR := CHOOSEN(faa.file_aircraft_registration_out(DID_out>''), TEST);
MD  := CHOOSEN(marriage_divorce_v2.file_mar_div_search(DID>0), TEST);
UCC := CHOOSEN(UCCV2.File_UCC_Party_Base(DID>0), TEST);
//CBD := CHOOSEN(Inquiry_AccLogs.fn_Prodhist().file(Search_Info.Function_Description = 'CHARGEBACK DEFENDER'), TEST);

lowdt(unsigned4 ldt, unsigned4 rdt) := MAP(ldt=0 => rdt,rdt=0 => ldt,min(ldt,rdt));

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

Relative_AVB.Layout_Combined.Layout_Relationship 
									tVehicles(RECORDOF(VH) l) := TRANSFORM
                              SELF.rectype            := constants.vehicle;	
															SELF.attr_lname         := l.lname;
															SELF.attr_prim_range    := l.ace_prim_range; 
															SELF.attr_prim_name     := l.ace_prim_name; 
															SELF.attr_sec_range     := l.ace_sec_range;
															SELF.attr_city          := l.ace_v_city_name;
															SELF.attr_st            := l.ace_st;
															SELF.vh_Vehicle_Key     := l.Vehicle_Key;
															SELF.vh_Iteration_Key   := l.Iteration_Key;
															SELF.vh_Sequence_Key    := l.Sequence_Key;
															self.attr_dt_first_seen := l.date_vendor_first_reported;
															self.attr_dt_last_seen  := l.date_vendor_last_reported;
															SELF.did                := (UNSIGNED6)l.append_did;
															SELF := l;
															SELF := [];
END;

Relative_AVB.func_CleanFunctions().CleanFields(VH, clVH);
Vehicles_Common := PROJECT(clVH, tVehicles(LEFT));
Vehicles_Dist   := DISTRIBUTE(Vehicles_Common,hash(vh_Vehicle_key));
Vehicles_Sort   := SORT(Vehicles_Dist,vh_vehicle_key,vh_iteration_key,vh_sequence_key,did,local);
Vehicles_Dedup  := ROLLUP(Vehicles_Sort,
                          left.vh_vehicle_key   = right.vh_vehicle_key   AND
													left.vh_iteration_key = right.vh_iteration_key AND
													left.vh_sequence_key  = right.vh_sequence_key  AND
													left.did              = right.did,
													transform(recordof(left),
													          self.attr_dt_first_seen := lowdt(left.attr_dt_first_seen, right.attr_dt_first_seen),
																		self.attr_dt_last_Seen  := max(left.attr_dt_last_seen,right.attr_dt_last_seen),
																		self := right,
																		self := left), local);

Vehicles_trec := record
  Vehicles_Dedup.vh_Vehicle_key;
	Vehicles_Dedup.vh_Iteration_key;
	Vehicles_Dedup.vh_Sequence_key;
	cnt := COUNT(GROUP);
end;
Vehicles_Table := TABLE(Vehicles_Dedup,Vehicles_trec,vh_Vehicle_key,vh_Iteration_key,vh_Sequence_key,local);
Vehicles_Multi := JOIN(Vehicles_Dedup,Vehicles_Table(cnt>1),
                     left.vh_Vehicle_key   = right.vh_Vehicle_key   AND
										 left.vh_Iteration_key = right.vh_Iteration_key AND
										 left.vh_Sequence_key  = right.vh_Sequence_key,
										 transform(recordof(left),
										           self := left),local);

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

Relative_AVB.func_CleanFunctions().CleanFields(BK, clBK);

Relative_AVB.Layout_Combined.Layout_Relationship 
									jBankruptcy(recordof(clBK) l, recordof(bkm) r) := TRANSFORM
									            SELF.rectype            := constants.bankruptcy;			
                              SELF.attr_dt_first_seen := (unsigned4) r.date_first_seen,
															SELF.attr_dt_last_seen  := (unsigned4) r.date_last_seen,
                              SELF.attr_lname         := l.lname,															
															SELF.attr_prim_range    := l.prim_range,
															SELF.attr_prim_name     := l.prim_name,
															SELF.attr_sec_range     := l.sec_range,
                              SELF.attr_city          := l.v_city_name;
															SELF.attr_st            := l.st,
															SELF.bk_TMSID           := l.TMSID;
															SELF.bk_name_type       := l.name_type;
															SELF.DID	              := (UNSIGNED6)l.DID;
															SELF := l;
															SELF := [];
END;

Bankruptcy_Common := JOIN(clBK, bkm, LEFT.tmsid = RIGHT.tmsid AND LEFT.seq_number = RIGHT.seq_number, jBankruptcy(LEFT, RIGHT), left outer);
Bankruptcy_Dist   := DISTRIBUTE(Bankruptcy_Common,hash(bk_TMSID));
Bankruptcy_Sort   := SORT(Bankruptcy_Dist,bk_TMSID,bk_name_type,did,local);
Bankruptcy_Dedup  := ROLLUP(Bankruptcy_Sort,
                          left.bk_TMSID     = right.bk_TMSID   AND
													left.bk_name_type = right.bk_name_type AND
													left.did          = right.did,
													transform(recordof(left),
													          self.attr_dt_first_seen := lowdt(left.attr_dt_first_seen, right.attr_dt_first_seen),
																		self.attr_dt_last_Seen  := max(left.attr_dt_last_seen,right.attr_dt_last_seen),
																		self := right,
																		self := left), local);

Bankruptcy_trec := record
  Bankruptcy_Dedup.bk_TMSID;
	cnt := COUNT(GROUP);
end;
Bankruptcy_Table := TABLE(Bankruptcy_Dedup,Bankruptcy_trec,bk_TMSID,local);
Bankruptcy_Multi := JOIN(Bankruptcy_Dedup,Bankruptcy_Table(cnt>1),
                     left.bk_TMSID     = right.bk_TMSID,
										 transform(recordof(left),
										           self := left),local);

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

Relative_AVB.Layout_Combined.Layout_Relationship 
									tLiens(RECORDOF(LN2) l) := TRANSFORM
                              SELF.rectype         := constants.lien;																
															SELF.DID	           := (UNSIGNED6)l.did;
															SELF.ln_tmsid        := l.tmsid,
															SELF.ln_rmsid        := l.rmsid,
															SELF.ln_name_type    := l.name_type,
															SELF.attr_lname      := l.lname,
															SELF.attr_prim_range := l.prim_range,
															SELF.attr_prim_name  := l.prim_name,
															SELF.attr_sec_range  := l.sec_range,
															SELF.attr_city       := l.v_city_name,
															SELF.attr_st         := l.st,
															SELF.attr_dt_first_seen := (unsigned4) IF(l.date_first_seen>'',l.date_first_seen,l.date_vendor_first_reported),
															SELF.attr_dt_last_seen  := (unsigned4) IF(l.date_last_seen>'',l.date_last_seen,l.date_vendor_last_reported),
															SELF := l;
															SELF := [];
END;

Relative_AVB.func_CleanFunctions().CleanFields(LN2, clLN);

Liens_Common := PROJECT(clLN, tLiens(LEFT));
Liens_Dist   := DISTRIBUTE(Liens_Common,hash(ln_TMSID));
Liens_Sort   := SORT(Liens_Dist,ln_tmsid,ln_rmsid,ln_name_type,did,local);
Liens_Dedup  := ROLLUP(Liens_Sort,
                          left.ln_TMSID     = right.ln_TMSID AND
													left.ln_RMSID     = right.ln_RMSID AND
													left.ln_name_type = right.ln_name_type AND
													left.did          = right.did,
													transform(recordof(left),
													          self.attr_dt_first_seen := lowdt(left.attr_dt_first_seen, right.attr_dt_first_seen),
																		self.attr_dt_last_Seen  := max(left.attr_dt_last_seen,right.attr_dt_last_seen),
																		self := right,
																		self := left), local);

Liens_trec := record
  Liens_Dedup.ln_TMSID;
	Liens_Dedup.ln_RMSID;
	cnt := COUNT(GROUP);
end;
Liens_Table := TABLE(Liens_Dedup,Liens_trec,ln_TMSID,ln_RMSID,local);
Liens_Multi := JOIN(Liens_Dedup,Liens_Table(cnt>1),
                     left.ln_TMSID     = right.ln_TMSID AND
										 left.ln_RMSID     = right.ln_RMSID,
										 transform(recordof(left),
										           self := left),local);

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

PRF1 := PROJECT(PRF, TRANSFORM({RECORDOF(PRF), BOOLEAN addrmatch}, SELF.addrmatch := LEFT.situs1_rawaid = LEFT.situs2_rawaid, SELF := LEFT));

Relative_AVB.Layout_Combined.Layout_Relationship 
									tForeclosure(RECORDOF(PRF1) l, INTEGER C, STRING addrtype) := TRANSFORM
                              SELF.rectype := constants.foreclosure;															
															SELF.attr_lname := CHOOSE(C, '', '', l.name1_last, l.name2_last, l.name3_last, l.name4_last, l.name5_last, l.name6_last, l.name7_last, l.name8_last);
															SELF.DID := (UNSIGNED6)CHOOSE(C, '', '', l.name1_did, l.name2_did, l.name3_did, l.name4_did, l.name5_did, l.name6_did, l.name7_did, l.name8_did);
                              SELF.fo_foreclosure_id := l.foreclosure_id;	
                              //P => Plantiff; D => Defendent															
															SELF.fo_name_type      := IF(C>4,'P','D');
															SELF.attr_prim_range := MAP(addrtype ='1'=> l.situs1_prim_range, l.situs2_prim_range);															
															SELF.attr_prim_name  := MAP(addrtype ='1'=> l.situs1_prim_name, l.situs2_prim_name);
															SELF.attr_sec_range  := MAP(addrtype ='1'=> l.situs1_sec_range, l.situs2_sec_range);
															SELF.attr_city       := MAP(addrtype ='1'=> l.situs1_v_city_name, l.situs2_v_city_name);
															SELF.attr_st         := MAP(addrtype ='1'=> l.situs1_st, l.situs2_st);
															SELF.attr_dt_first_seen := (unsigned4) l.recording_date;
															SELF.attr_dt_last_seen  := (unsigned4) l.recording_date;
															SELF := l;
															SELF := [];
END;

Relative_AVB.func_CleanFunctions().CleanFields(PRF1, clPRF);

nmPRF := NORMALIZE(clPRF, 10, tForeclosure(LEFT, COUNTER, '1')) + NORMALIZE(clPRF(~addrmatch and situs2_rawaid > 0), 10, tForeclosure(LEFT, COUNTER, '2'));

Foreclosure_Common	:= nmPRF(did>0 AND attr_prim_name<>'');
Foreclosure_Dist    := DISTRIBUTE(Foreclosure_Common,hash(fo_Foreclosure_id));
Foreclosure_Sort    := SORT(Foreclosure_Dist,fo_foreclosure_id,fo_name_type,did,local);

Foreclosure_Dedup   := ROLLUP(Foreclosure_Sort,
                          left.fo_foreclosure_id = right.fo_foreclosure_id AND
													left.fo_name_type      = right.fo_name_type AND
													left.did               = right.did,
													transform(recordof(left),
													          self.attr_dt_first_seen := lowdt(left.attr_dt_first_seen, right.attr_dt_first_seen),
																		self.attr_dt_last_Seen  := max(left.attr_dt_last_seen,right.attr_dt_last_seen),
																		self := right,
																		self := left), local);

Foreclosure_trec := record
  Foreclosure_Dedup.fo_Foreclosure_id;
	cnt := COUNT(GROUP);
end;

Foreclosure_Table := TABLE(Foreclosure_Dedup,Foreclosure_trec,fo_Foreclosure_id,local);

Foreclosure_Multi := JOIN(Foreclosure_Dedup,Foreclosure_Table(cnt>1),
                     left.fo_Foreclosure_ID = right.fo_Foreclosure_ID,
										 transform(recordof(left),
										           self := left),local);
																			
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

Relative_AVB.Layout_Combined.Layout_Relationship tPROPERTYSEARCH(RECORDOF(PRS) l) := TRANSFORM
                                                  SELF.rectype := constants.property,																								
                                                  SELF.pr_ln_fares_id  := l.ln_fares_id,
                                                  //1st char O for buyer, S for seller; 2nd char A for assessment, D for deed																									
																									SELF.pr_source_code  := l.source_code[1] + l.ln_fares_id[2],
																									SELF.attr_lname      := l.lname,
                                                  SELF.attr_prim_range := l.prim_range,
																									SELF.attr_prim_name  := l.prim_name,
																									SELF.attr_sec_range  := l.sec_range,
																									SELF.attr_city       := l.v_city_name,
																									SELF.attr_st         := l.st,
																									SELF.attr_dt_first_seen := l.dt_first_seen,
																									SELF.attr_dt_last_seen  := l.dt_last_seen,
																									SELF := l;
																									SELF := [];
END;

Relative_AVB.func_CleanFunctions().CleanFields(PRS, clPRS);
Property_Common := PROJECT(clPRS, tPROPERTYSEARCH(LEFT));
Property_Dist   := DISTRIBUTE(Property_Common,hash(pr_ln_fares_id));
Property_Sort   := SORT(Property_Dist,-pr_ln_fares_id,pr_source_code,did,local);
Property_Dedup  := ROLLUP(Property_Sort,
                          left.pr_ln_fares_id  = right.pr_ln_fares_id  AND
													left.pr_source_code  = right.pr_source_code  AND
													left.did             = right.did,
													transform(recordof(left),
													          self.attr_dt_first_seen := lowdt(left.attr_dt_first_seen, right.attr_dt_first_seen),
																		self.attr_dt_last_Seen  := max(left.attr_dt_last_seen,right.attr_dt_last_seen),
																		self := right,
																		self := left), local);
Property_Dedup1 := DEDUP(Property_Dedup,pr_ln_fares_id,did,local);
Property_trec := record
  Property_Dedup1.pr_ln_fares_id;
	cnt := COUNT(GROUP);
end;
Property_Table := TABLE(Property_Dedup1,Property_trec,pr_ln_fares_id,local);
Property_Multi := JOIN(Property_Dedup,Property_Table(cnt>1),
                     left.pr_ln_fares_ID = right.pr_ln_fares_id,
										 transform(recordof(left),
										           self := left),local);
Property_Dist2  := DISTRIBUTE(Property_Multi,hash(attr_prim_range,attr_prim_name,attr_sec_range,attr_city,attr_st));
Property_Sort2  := SORT(Property_Dist2,attr_prim_range,attr_prim_name,attr_sec_range,attr_city,attr_st,did,pr_source_code,local);
Property_Dedup2 := DEDUP(Property_Sort2,attr_prim_range,attr_prim_name,attr_sec_range,attr_city,attr_st,did,pr_source_code,local);									

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//Relative_AVB.Layout_Combined.Layout_Relationship tUTILITY(RECORDOF(UTL) l) := TRANSFORM
//                                                  SELF.rectype := constants.utility;
//																									SELF.prim_range := l.address_street;
//																									SELF.prim_name  := l.address_street_name;
//																									SELF.DID   := (UNSIGNED6)l.DID;
//																									SELF.ut_id := l.id;
//																									SELF := l;
//																									SELF := [];
//END;

//Relative_AVB.func_CleanFunctions().CleanFields(UTL, clUTL);
//Utility_Common := PROJECT(clUTL, tUTILITY(LEFT));

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

Relative_AVB.Layout_Combined.Layout_Relationship tEXPERIAN(RECORDOF(XPC) l) := TRANSFORM
                                                  SELF.rectype := constants.experian;
																									SELF.xp_seq_rec_id      := l.seq_rec_id;
																									SELF.attr_lname         := l.lname,
																									SELF.attr_prim_range    := l.prim_range,
																									SELF.attr_prim_name     := l.prim_name,
																									SELF.attr_sec_range     := l.sec_range,
																									SELF.attr_city          := l.v_city_name;
																									SELF.attr_st            := l.st,
																									SELF.attr_dt_first_seen := l.date_first_seen;
																									SELF.attr_dt_last_seen  := l.date_last_seen;
																									SELF := l;
																									SELF := [];
END;

Relative_AVB.func_CleanFunctions().CleanFields(XPC, clXPC);
Experian_Common := PROJECT(clXPC, tEXPERIAN(LEFT));
Experian_Dist   := DISTRIBUTE(Experian_Common,hash(xp_seq_rec_id));
Experian_Sort   := SORT(Experian_Dist,xp_seq_rec_id,did,local);
Experian_Dedup  := ROLLUP(Experian_Sort,
                          left.xp_seq_rec_id = right.xp_seq_rec_id AND
													left.did               = right.did,
													transform(recordof(left),
													          self.attr_dt_first_seen := lowdt(left.attr_dt_first_seen, right.attr_dt_first_seen),
																		self.attr_dt_last_Seen  := max(left.attr_dt_last_seen,right.attr_dt_last_seen),
																		self := right,
																		self := left), local);

Experian_trec := record
  Experian_Dedup.xp_seq_rec_id;
	cnt := COUNT(GROUP);
end;
Experian_Table := TABLE(Experian_Dedup,Experian_trec,xp_seq_rec_id,local);
Experian_Multi := JOIN(Experian_Dedup,Experian_Table(cnt>1),
                     left.xp_seq_rec_ID     = right.xp_seq_rec_id,
										 transform(recordof(left),
										           self := left),local);
															 
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

Relative_AVB.Layout_Combined.Layout_Relationship tBusinessContacts(RECORDOF(BSA) l) := TRANSFORM
                                                  SELF.rectype    := constants.businessassociates;																									
																									SELF.did        := (UNSIGNED6)l.did;
																									SELF.ba_bdid    := l.bdid;
																									SELF.attr_lname := l.lname;
																									SELF.attr_prim_range := IF(l.company_prim_name='',l.prim_range,l.company_prim_range);
																									SELF.attr_prim_name  := IF(l.company_prim_name='',l.prim_name,l.company_prim_name);
																									SELF.attr_sec_range  := IF(l.company_prim_name='',l.sec_range,l.company_sec_range);
																									SELF.attr_city       := IF(l.company_prim_name='',l.city,l.company_city);
																									SELF.attr_st         := IF(l.company_prim_name='',l.state,l.company_state);
																									SELF.attr_dt_first_seen := l.dt_first_seen;
																									SELF.attr_dt_last_seen  := l.dt_last_seen;
																									SELF := l;
																									SELF := [];
END;

Relative_AVB.func_CleanFunctions().CleanFields(BSA, clBSA);
BusinessContacts_Common := PROJECT(clBSA, tBusinessContacts(LEFT));
BusinessContacts_Dist   := DISTRIBUTE(BusinessContacts_Common,hash(ba_bdid));
BusinessContacts_Sort   := SORT(BusinessContacts_Dist,ba_bdid,attr_prim_range,attr_prim_name,attr_sec_range,attr_city,attr_st,did,local);
BusinessContacts_Dedup  := ROLLUP(BusinessContacts_Sort,
                          left.ba_bdid = right.ba_bdid AND
													left.did     = right.did,
													transform(recordof(left),
													          self.attr_dt_first_seen := lowdt(left.attr_dt_first_seen, right.attr_dt_first_seen),
																		self.attr_dt_last_Seen  := max(left.attr_dt_last_seen,right.attr_dt_last_seen),
																		self := right,
																		self := left), local);

BusinessContacts_trec := record
  BusinessContacts_Dedup.ba_bdid;
	cnt := COUNT(GROUP);
end;
BusinessContacts_Table := TABLE(BusinessContacts_Dedup,BusinessContacts_trec,ba_bdid,local);
BusinessContacts_Multi := JOIN(BusinessContacts_Dedup,BusinessContacts_Table(cnt between 2 AND 50),
                     left.ba_bdid     = right.ba_bdid,
										 transform(recordof(left),
										           self := left),local);

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


Relative_AVB.Layout_Combined.Layout_Relationship tTRANSUNION(RECORDOF(TU) l) := TRANSFORM
                                                  SELF.rectype := constants.transunion;
																									SELF.tu_vendor_id       := l.vendor_id;
																									SELF.attr_lname         := l.lname;
																									SELF.attr_prim_range    := l.prim_range;
																									SELF.attr_prim_name     := l.prim_name;
																									SELF.attr_sec_range     := l.sec_range;
																									SELF.attr_city := l.city_name;
																									SELF.attr_st            := l.st;
																									SELF.attr_dt_first_seen := l.dt_first_seen;
																									SELF.attr_dt_last_seen  := l.dt_last_seen;
																									SELF := l;
																									SELF := [];
END;

Relative_AVB.func_CleanFunctions().CleanFields(TU, clTU);
Transunion_Common := PROJECT(clTU, tTRANSUNION(LEFT));
Transunion_Dist   := DISTRIBUTE(Transunion_Common,hash(tu_vendor_id));
Transunion_Sort   := SORT(Transunion_Dist,tu_vendor_id,did,local);
Transunion_Dedup  := ROLLUP(Transunion_Sort,
                          left.tu_vendor_id = right.tu_vendor_id AND
													left.did        = right.did,
													transform(recordof(left),
													          self.attr_dt_first_seen := lowdt(left.attr_dt_first_seen, right.attr_dt_first_seen),
																		self.attr_dt_last_Seen  := max(left.attr_dt_last_seen,right.attr_dt_last_seen),
																		self := right,
																		self := left), local);

Transunion_trec := record
  Transunion_Dedup.tu_vendor_id;
	cnt := COUNT(GROUP);
end;
Transunion_Table := TABLE(Transunion_Dedup,Transunion_trec,tu_vendor_id,local);
Transunion_Multi := JOIN(Transunion_Dedup,Transunion_Table(cnt>1),
                     left.tu_vendor_id     = right.tu_vendor_id,
										 transform(recordof(left),
										           self := left),local);
															 
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


Relative_AVB.Layout_Combined.Layout_Relationship tEnclarity(RECORDOF(EN) l) := TRANSFORM
                                                  SELF.rectype       := constants.enclarity;
																									SELF.en_billing_group_key := l.group_key;
																									SELF.en_addr_key        := l.addr_key;
																									SELF.attr_lname         := l.lname;
																									SELF.attr_prim_range    := l.prim_range;
																									SELF.attr_prim_name     := l.prim_name;
																									SELF.attr_sec_range     := l.sec_range;
                                                  SELF.attr_city          := l.v_city_name;
																									SELF.attr_st            := l.st;
																									SELF.attr_dt_first_seen := IF(l.dt_first_seen>0,l.dt_first_seen,l.dt_vendor_first_reported);
																									SELF.attr_dt_last_seen  := IF(l.dt_last_seen>0,l.dt_last_seen,l.dt_vendor_last_reported);
																									SELF := l;
																									SELF := [];
END;

Relative_AVB.func_CleanFunctions().CleanFields(EN, clEN);
Enclarity_Common := PROJECT(clEN, tEnclarity(LEFT));
Enclarity_Dist   := DISTRIBUTE(Enclarity_Common,hash(en_billing_group_key,en_addr_key));
Enclarity_Sort   := SORT(Enclarity_Dist,en_billing_group_key,en_addr_key,did,local);
Enclarity_Dedup  := ROLLUP(Enclarity_Sort,
                          left.en_billing_group_key = right.en_billing_group_key AND
													left.en_addr_key = right.en_addr_key AND
													left.did         = right.did,
													transform(recordof(left),
													          self.attr_dt_first_seen := lowdt(left.attr_dt_first_seen, right.attr_dt_first_seen),
																		self.attr_dt_last_Seen  := max(left.attr_dt_last_seen,right.attr_dt_last_seen),
																		self := right,
																		self := left), local);

Enclarity_trec := record
  Enclarity_Dedup.en_billing_group_key;
	Enclarity_Dedup.en_addr_key;
	cnt := COUNT(GROUP);
end;
Enclarity_Table := TABLE(Enclarity_Dedup,Enclarity_trec,en_billing_group_key,en_addr_key,local);
Enclarity_Multi := JOIN(Enclarity_Dedup,Enclarity_Table(cnt>1),
                     left.en_billing_group_key = right.en_billing_group_key AND
										 left.en_addr_key = right.en_addr_key,
										 transform(recordof(left),
										           self := left),local);

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/*
Relative_AVB.Layout_Combined.Layout_Relationship 
									tChargeBack(RECORDOF(CBD) l) := TRANSFORM
                              SELF.rectype := constants.chargeBackDefender;																
															SELF.chargeBackDefender.transaction_id := l.search_info.transaction_id;
															SELF.chargeBackDefender.Sequence_Number := l.search_info.Sequence_Number;
															SELF.source_code	:= 'CB'; 
                              SELF.DID	:= (UNSIGNED6)l.person_q.appended_adl;
															SELF.BDID	:= (UNSIGNED6)l.bus_q.appended_bdid;
															SELF.
															SELF := l;
															SELF := [];
END;

ChargeBack_Slim   := PROJECT(cbd, tChargeBack(LEFT));
ChargeBack_Common := JOIN(ChargeBack_Slim,ChargeBack_Slim,
                          left.chargeBackDefender.transaction_id  = right.chargeBackDefender.transaction_id, //AND
													//left.chargeBackDefender.sequence_number = right.chargeBackDefender.sequence_number,// AND
												 //(left.DID  <> right.DID OR
												  //left.BDID <> right.BDID),
													TRANSFORM(recordof(left),
													          self := left));
*/
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
Relative_AVB.Layout_Combined.Layout_Relationship tWaterCraft(RECORDOF(WC) l) := TRANSFORM
                                                  SELF.rectype            := constants.watercraft;
																									SELF.wc_watercraft_key  := l.watercraft_key;
																									SELF.wc_sequence_key    := l.sequence_key;
																									SELF.wc_state_origin    := l.state_origin;
																									SELF.wc_source_code     := l.source_code;
																									SELF.attr_lname         := l.lname;
																									SELF.attr_prim_range    := l.prim_range;
																									SELF.attr_prim_name     := l.prim_name;
																									SELF.attr_sec_range     := l.sec_range;
                                                  SELF.attr_city          := l.v_city_name;
																									SELF.attr_st            := l.st;
																									SELF.attr_dt_first_seen := (unsigned4) l.date_first_seen;
																									SELF.attr_dt_last_seen  := (unsigned4) l.date_last_seen;
                                                  SELF.did                := (unsigned6) l.did;																									
																									SELF := l;
																									SELF := [];
END;

Relative_AVB.func_CleanFunctions().CleanFields(WC, clWC);
Watercraft_Common := PROJECT(clWC, tWaterCraft(LEFT));
Watercraft_Dist   := DISTRIBUTE(Watercraft_Common,hash(wc_watercraft_key));
Watercraft_Sort   := SORT(Watercraft_Dist,wc_watercraft_key,wc_sequence_key,wc_state_origin,wc_source_code,did,local);
Watercraft_Dedup  := ROLLUP(Watercraft_Sort,
                            left.wc_watercraft_key = right.wc_watercraft_key AND
														left.wc_sequence_key   = right.wc_sequence_key AND
														left.wc_state_origin   = right.wc_state_origin AND
														left.wc_source_code    = right.wc_source_code AND
													  left.did               = right.did,
													  transform(recordof(left),
													            self.attr_dt_first_seen := lowdt(left.attr_dt_first_seen, right.attr_dt_first_seen),
																		  self.attr_dt_last_Seen  := max(left.attr_dt_last_seen,right.attr_dt_last_seen),
																		  self := right,
																		  self := left), local);

Watercraft_trec := record
  Watercraft_Dedup.wc_watercraft_key;
	Watercraft_Dedup.wc_sequence_key;
	Watercraft_Dedup.wc_state_origin;
	Watercraft_Dedup.wc_source_code;
	cnt := COUNT(GROUP);
end;
Watercraft_Table := TABLE(Watercraft_Dedup,Watercraft_trec,wc_watercraft_key,wc_sequence_key,wc_state_origin,wc_source_code,local);
Watercraft_Multi := JOIN(Watercraft_Dedup,Watercraft_Table(cnt>1),
                     left.wc_watercraft_key = right.wc_watercraft_key AND
										 left.wc_sequence_key   = right.wc_sequence_key AND
										 left.wc_state_origin   = right.wc_state_origin AND
										 left.wc_source_code    = right.wc_source_code,
										 transform(recordof(left),
										           self := left),local);
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
Relative_AVB.Layout_Combined.Layout_Relationship tMarriageDivorce(RECORDOF(MD) l) := TRANSFORM
                                                  SELF.rectype            := constants.marriagedivorce;
																									SELF.md_record_id       := l.record_id;
																									SELF.attr_lname         := l.lname;
																									SELF.attr_prim_range    := l.prim_range;
																									SELF.attr_prim_name     := l.prim_name;
																									SELF.attr_sec_range     := l.sec_range;
                                                  SELF.attr_city          := l.v_city_name;
																									SELF.attr_st            := l.st;
																									SELF.attr_dt_first_seen := IF(l.dt_first_seen>0,l.dt_first_seen,l.dt_vendor_first_reported);
																									SELF.attr_dt_last_seen  := IF(l.dt_last_seen>0,l.dt_last_seen,l.dt_vendor_last_reported);
																									SELF := l;
																									SELF := [];
END;

Relative_AVB.func_CleanFunctions().CleanFields(MD, clMD);
MarriageDivorce_Common := PROJECT(clMD, tMarriageDivorce(LEFT));
MarriageDivorce_Dist   := DISTRIBUTE(MarriageDivorce_Common,hash(md_record_id));
MarriageDivorce_Sort   := SORT(MarriageDivorce_Dist,md_record_id,did,local);
MarriageDivorce_Dedup  := ROLLUP(MarriageDivorce_Sort,
                            left.md_record_id = right.md_record_id AND
														left.did               = right.did,
													  transform(recordof(left),
													            self.attr_dt_first_seen := lowdt(left.attr_dt_first_seen, right.attr_dt_first_seen),
																		  self.attr_dt_last_Seen  := max(left.attr_dt_last_seen,right.attr_dt_last_seen),
																		  self := right,
																		  self := left), local);

MarriageDivorce_trec := record
  MarriageDivorce_Dedup.md_record_id;
	cnt := COUNT(GROUP);
end;
MarriageDivorce_Table := TABLE(MarriageDivorce_Dedup,MarriageDivorce_trec,md_record_id,local);
MarriageDivorce_Multi := JOIN(MarriageDivorce_Dedup,MarriageDivorce_Table(cnt>1),
                              left.md_record_id = right.md_record_id,
										          transform(recordof(left),
										                    self := left),local);
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

Relative_AVB.Layout_Combined.Layout_Relationship tUCC(RECORDOF(UCC) l) := TRANSFORM
                                                  SELF.rectype            := constants.UCC;
																									SELF.uc_tmsid           := l.tmsid;
																									SELF.uc_rmsid           := l.rmsid;
																									SELF.attr_lname         := l.lname;
																									SELF.attr_prim_range    := l.prim_range;
																									SELF.attr_prim_name     := l.prim_name;
																									SELF.attr_sec_range     := l.sec_range;
                                                  SELF.attr_city          := l.v_city_name;
																									SELF.attr_st            := l.st;
																									SELF.attr_dt_first_seen := IF(l.dt_first_seen>0,l.dt_first_seen,l.dt_vendor_first_reported);
																									SELF.attr_dt_last_seen  := IF(l.dt_last_seen>0,l.dt_last_seen,l.dt_vendor_last_reported);
																									SELF := l;
																									SELF := [];
END;

Relative_AVB.func_CleanFunctions().CleanFields(UCC, clUC);
UCC_Common := PROJECT(clUC, tUCC(LEFT));
UCC_Dist   := DISTRIBUTE(UCC_Common,hash(uc_tmsid));
UCC_Sort   := SORT(UCC_Dist,uc_tmsid,uc_rmsid,did,local);
UCC_Dedup  := ROLLUP(UCC_Sort,
                            left.uc_tmsid = right.uc_tmsid AND
														left.uc_rmsid = right.uc_rmsid AND
														left.did               = right.did,
													  transform(recordof(left),
													            self.attr_dt_first_seen := lowdt(left.attr_dt_first_seen, right.attr_dt_first_seen),
																		  self.attr_dt_last_Seen  := max(left.attr_dt_last_seen,right.attr_dt_last_seen),
																		  self := right,
																		  self := left), local);

UCC_trec := record
  UCC_Dedup.uc_tmsid;
	UCC_Dedup.uc_rmsid;
	cnt := COUNT(GROUP);
end;
UCC_Table := TABLE(UCC_Dedup,UCC_trec,uc_tmsid,uc_rmsid,local);
UCC_Multi := JOIN(UCC_Dedup,UCC_Table(cnt>1),
                              left.uc_tmsid = right.uc_tmsid AND
															left.uc_rmsid = right.uc_rmsid,
										          transform(recordof(left),
										                    self := left),local);
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
Relative_AVB.Layout_Combined.Layout_Relationship tAir(RECORDOF(AIR) l) := TRANSFORM
                                                  SELF.rectype            := constants.Aircraft;
																									SELF.ac_n_number        := l.n_number;
																									SELF.ac_cert_issue_date := l.cert_issue_date;
																									SELF.attr_lname         := l.lname;
																									SELF.attr_prim_range    := l.prim_range;
																									SELF.attr_prim_name     := l.prim_name;
																									SELF.attr_sec_range     := l.sec_range;
                                                  SELF.attr_city          := l.v_city_name;
																									SELF.attr_st            := l.st;
																									SELF.attr_dt_first_seen := (unsigned4) l.date_first_seen;
																									SELF.attr_dt_last_seen  := (unsigned4) l.date_last_seen;
																									SELF.did                := (unsigned6) l.did_out;
																									SELF := l;
																									SELF := [];
END;

Relative_AVB.func_CleanFunctions().CleanFields(Air, clAC);
Air_Common := PROJECT(clAC, tAir(LEFT));
Air_Dist   := DISTRIBUTE(Air_Common,hash(ac_n_number));
Air_Sort   := SORT(Air_Dist,ac_n_number,ac_cert_issue_date,did,local);
Air_Dedup  := ROLLUP(Air_Sort,
                            left.ac_n_number = right.ac_n_number AND
														left.ac_cert_issue_date = right.ac_cert_issue_date AND
														left.did               = right.did,
													  transform(recordof(left),
													            self.attr_dt_first_seen := lowdt(left.attr_dt_first_seen, right.attr_dt_first_seen),
																		  self.attr_dt_last_Seen  := max(left.attr_dt_last_seen,right.attr_dt_last_seen),
																		  self := right,
																		  self := left), local);

Air_trec := record
  Air_Dedup.ac_n_number;
	Air_Dedup.ac_cert_issue_date;
	cnt := COUNT(GROUP);
end;
Air_Table := TABLE(Air_Dedup,Air_trec,ac_n_number,ac_cert_issue_date,local);
Air_Multi := JOIN(Air_Dedup,Air_Table(cnt>1),
                              left.ac_n_number = right.ac_n_number AND
															left.ac_cert_issue_date = right.ac_cert_issue_date,
										          transform(recordof(left),
										                    self := left),local);
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


ConcatFiles := Liens_Multi + Bankruptcy_Multi + Vehicles_Multi + Foreclosure_Multi + Property_Dedup2 + Experian_Multi + Transunion_Multi + Enclarity_Multi + 
               Watercraft_Multi + MarriageDivorce_Multi + UCC_Multi + Air_Multi;

RETURN ConcatFiles;
END;