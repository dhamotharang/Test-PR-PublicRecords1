



// output(MI7.MapValidCriminalSentencesSourceUID(CRSE_ID in [
// 2061003220 - MI7.bCriminalSentencesMaxKey,
// 2091752400 - MI7.bCriminalSentencesMaxKey,
// 1972562896 - MI7.bCriminalSentencesMaxKey]));


// output(MI7.MapValidCriminalChargesSourceUID(ECL_CHARGE_ID in [
// 110325924,
// 117485006,
// 119967244]));


// output(MI7.File_Court_Offenses_ECL_Cade_id(offender_key = 'TBHDTXDPS2923412(*CL|)%|'));                                    
// output(MI7.File_Court_Offenses_ECL_Cade_id(offender_key = 'TBHDTXDPS2923412(*CL|)%|'));                                       
// output(MI7.File_Court_Offenses_ECL_Cade_id(offender_key = 'TBHDTXDPS2923412(*CL|)%|'));      


// output(MI7.File_Court_Offenses_ECL_Cade_id(ecl_charge_id = 110325924));
// output(MI7.File_Court_Offenses_ECL_Cade_id(ecl_charge_id = 117485006));
// output(MI7.File_Court_Offenses_ECL_Cade_id(ecl_charge_id = 119967244));
                                 
//output(count(MI7.MapValidCriminalChargesSourceUID(ECL_CHARGE_ID < 	181849523 - mi7.bCriminalChargesMaxKey)));			



dist_File_valid_ecl_cade_id_source_uid :=  DISTRIBUTE(mi7.File_valid_ecl_cade_id_source_uid,HASH32(ecl_cade_id));	
dist_MapCourtOffensesToCriminalCharges :=  DISTRIBUTE(mi7.MapCourtOffensesToCriminalCharges,HASH32(ecl_cade_id));																		 

join_get_invalid_crim_charges := join(dist_File_valid_ecl_cade_id_source_uid , dist_MapCourtOffensesToCriminalCharges,
                                                                  left.ecl_cade_id = right.ecl_cade_id, RIGHT ONLY, local);
																																	
																																	
//output(count(join_get_invalid_crim_charges(ECL_CHARGE_ID < 	181849523 - mi7.bCriminalChargesMaxKey)));		


// why charge min in sentence file is less
output(count(mi7.File_Court_Offenses_ECL_Cade_id(ECL_CHARGE_ID < 	181849523 - mi7.bCriminalChargesMaxKey 
                                                                                           and       sent_date +
																																																	sent_jail +
																																																	sent_susp_time +
																																																	sent_court_cost +
																																																	sent_court_fine +
																																																	sent_susp_court_fine +
																																																	sent_probation +
																																																	sent_consec +
																																																	traffic_ticket_number+
																																																	le_agency_desc  +
																																																	le_agency_cd +
																																																	restitution +
																																																	community_service +
																																																	Parole +
																																																	addl_sent_dates +
                                                                                                 	Probation_desc2																																																	
																																																	= '')));														 
																 
																 













