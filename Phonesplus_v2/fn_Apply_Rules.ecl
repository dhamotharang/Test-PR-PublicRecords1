//**********Funtion to flag rules
import ut, mdr, std;
export fn_Apply_Rules (dataset(recordof(Layout_In_Phonesplus.layout_in_common)) phplus_in) := function

celltype := Translation_Codes.cellphone_types;

inquiry_data := dedup(sort(distribute(File_Inquiry_For_Verification, hash(person_q_personal_phone)),person_q_personal_phone, local),person_q_personal_phone, local);

append_inq_info := join(distribute(phplus_in, hash(npa+phone7)),
												distribute(inquiry_data, hash(person_q_personal_phone)),
												left.npa+left.phone7 = right.person_q_personal_phone,
												transform({recordof(phplus_in),
																	 inquiry_data.function_description,
																	 inquiry_data.datetime,
																	 unsigned1 iq_match_type},
																	 self.function_description := right.function_description,
																	 self.datetime := right.datetime,
																	 self.iq_match_type := map (left.npa+left.phone7 = right.person_q_personal_phone and (left.did = right.person_q_apdid or left.hhid = right.hhid)=> 1,
																			  									 left.npa+left.phone7 = right.person_q_personal_phone and left.did <> right.person_q_apdid and left.hhid <> right.hhid => 2,
																													 0);																		
																	self := left),
												left outer,
												local);

recordof(phplus_in) t_flag_rules(append_inq_info le) := transform


//=================RULES THAT MAY INDICATE DISCONNECT==========================
  //-----Vendor Low Confidence rule
	low_vendor_conf_rule:= if(le.cur_orig_conf_score in [5,7],
							   true, false);
		
	low_vendor_conf_caption:= if(low_vendor_conf_rule,
								 Translation_Codes.rules_bitmap_code('Low-Vendor-Conf'), 0b );
								 
	//Deceased rule
	deceased_rule := if(le.did_type = 'DEAD',	
											true, false);
	
	
	deceased_caption:= if(deceased_rule,
								 Translation_Codes.rules_bitmap_code('Deceased'), 0b );
								 
	//Gong History with subsequent disconnect
	gongh_discon_rule := if(Translation_Codes.fFlagIsOn(le.src_all,Translation_Codes.source_bitmap_code('GO')) and
													le.append_phone_type not in ['CELL' , 'LNDLN PRTD TO CELL'] and
													((unsigned)((string)le.eda_did_dt)[..6] > le.datelastseen or 
													(unsigned)((string)le.eda_hist_did_dt)[..6] > le.datelastseen or 
													le.eda_did_dt >  le.eda_hist_did_dt or
													(le.datelastseen = (unsigned)((string)le.eda_hist_did_dt)[..6] and ((string)le.eda_hist_did_dt)[..6 ] = ((string)le.eda_hist_phone_dt) [..6 ] and le.eda_hist_did_dt > le.eda_hist_phone_dt ) or
													(le.datelastseen = (unsigned)((string)le.eda_did_dt)[..6] and ((string)le.eda_did_dt)[..6 ] = ((string)le.eda_phone_dt)[..6 ] and le.eda_did_dt > le.eda_phone_dt ))
											,true,false);

gongh_discon_caption:= if(gongh_discon_rule,
								 Translation_Codes.rules_bitmap_code('Gongh-Disconnect'), 0b );

//consortium discon
consortium_discon_rule := le.append_feedback_phone = '4' and ut.DaysApart((STRING8)Std.Date.Today(),(string)le.append_feedback_phone_dt)  <= 365	;							 

consortium_discon_caption:= if(consortium_discon_rule,
								 Translation_Codes.rules_bitmap_code('Consortium-Disconnect'), 0b );		
								 
//inquiry wrong party
iq_wrongp_rule := if(le.iq_match_type = 2, true, false);

iq_wrongp_caption := if(iq_wrongp_rule,
								 Translation_Codes.rules_bitmap_code('IQ-Wrong-Party'), 0b );		



//=================RULES THAT MAY INDICATE RPC=========================
	
	telnet_cell_rule := if(Translation_Codes.fFlagIsOn(le.src_all,Translation_Codes.source_bitmap_code(mdr.sourceTools.src_Link2Tek)) and le.append_max_source_conf > 10,
	                true, false);
									
	telnet_cell_caption := if(telnet_cell_rule,
	                         Translation_Codes.rules_bitmap_code('TelNet'), 0b );

	//----Neustar verified rule. Bug 162654
	neustar_verified_rule  := if (le.append_avg_source_conf > 10, true, false);							  
	neustar_verified_caption := if(neustar_verified_rule, 
							  Translation_Codes.rules_bitmap_code('Neustar-Verified'), 0b );

	//----Non-pub rule	
	non_pub_rule 	   := if (le.append_nonpublished_match > 1b and  
							  le.append_nonpublished_match <= 1000b and
							  (le.append_phone_type[..4] = 'POTS'), 
							  true, false);
							  
	non_pub_caption		:= if(non_pub_rule, 
							  Translation_Codes.rules_bitmap_code('Non-pub'), 0b );
	
	//----Ported Neustar rule
	ported_neustar_rule :=   if(Translation_Codes.fFlagIsOn(le.append_ported_match, 1b),
							    true, false);
	
	ported_neustar_caption:= if(ported_neustar_rule, 
							    Translation_Codes.rules_bitmap_code('Ported-Neustar'), 0b );
								
								
   //----Seen Once rule
   	seen_once_rule 	    := if (le.append_seen_once_ind,
							   							   true, false);
    seen_once_caption	:= if(seen_once_rule,
							  Translation_Codes.rules_bitmap_code('Seen-Once'), 0b );

   //-----Vendor High Confidence rule
	high_vendor_conf_rule:= if(le.cur_orig_conf_score = 2 or
							   (le.cur_orig_conf_score = 3),
							   true, false);
		
	high_vendor_conf_caption:= if(high_vendor_conf_rule,
								 Translation_Codes.rules_bitmap_code('High-Vendor-Conf'), 0b );
								  
  //------Cellphone match best address
 	cell_best_latest_rule  := if(le.append_phone_type[..4] = 'CELL' and
								  le.append_latest_phone_owner_flag and 
								  le.append_best_addr_match_flag,
							      true, false);
								  
    cell_best_latest_caption   := if(cell_best_latest_rule,
									 Translation_Codes.rules_bitmap_code('Cellphone-Latest'), 0b );
									 
									 
//---------Cellphone or utility source or cellphone sources where individual is the latest owner
source_latest_rule :=        (//Translation_Codes.fFlagIsOn(le.src_all,Translation_Codes.source_bitmap_code('UW')) or
					     //Translation_Codes.fFlagIsOn(le.src_all,Translation_Codes.source_bitmap_code('UT')) or
							 //Translation_Codes.fFlagIsOn(le.src_all,Translation_Codes.source_bitmap_code('ZT')) or
							 //Translation_Codes.fFlagIsOn(le.src_all,Translation_Codes.source_bitmap_code('ZK')) or
							 Translation_Codes.fFlagIsOn(le.src_all,Translation_Codes.source_bitmap_code('01')) or
							 Translation_Codes.fFlagIsOn(le.src_all,Translation_Codes.source_bitmap_code('02')) or
							 Translation_Codes.fFlagIsOn(le.src_all,Translation_Codes.source_bitmap_code('05')) or
							 Translation_Codes.fFlagIsOn(le.src_all,Translation_Codes.source_bitmap_code(mdr.sourceTools.src_InquiryAcclogs)));

source_latest_caption:= if(source_latest_rule, 
						        Translation_Codes.rules_bitmap_code('Source-Latest'), 0b);
								
								
//---------Ported rule: no active phone for individual, address matches best and phone is in eda history
ported_best_no_active_rule := le.append_portability_indicator = '1' and 
							  le.append_indiv_has_active_eda_phone_flag = false and 
							  le.append_latest_phone_owner_flag and 
							  le.append_best_addr_match_flag and 
							  ((((string)le.DateLastSeen)[..4] >= '2001' and
							  ut.DaysApart((string)le.DateLastSeen , (STRING8)Std.Date.Today()) >= 90) or
							  le.DateLastSeen  = 0) and
							  Translation_Codes.fFlagIsOn(le.rules, Translation_Codes.rules_bitmap_code('Disconnected-EDA'));

ported_best_no_active_caption:= if(ported_best_no_active_rule, 
								Translation_Codes.rules_bitmap_code('Ported-Best-No-Active'), 0b);

//---------Ported rule: phone is in gong history and type is a cell
ported_cell_rule 		 := le.append_portability_indicator = '1' and 
							le.append_phone_type[..4] = 'CELL' and
							le.append_latest_phone_owner_flag and
						    ((((string)le.DateLastSeen)[..4] >= '2001' and
							ut.DaysApart((string)le.DateLastSeen , (STRING8)Std.Date.Today()) >= 90) or
							le.DateLastSeen  = 0) and
							Translation_Codes.fFlagIsOn(le.rules, Translation_Codes.rules_bitmap_code('Disconnected-EDA'));

ported_cell_caption 	 := if(ported_cell_rule, 
							   Translation_Codes.rules_bitmap_code('Ported-Cell-Type'), 0b);

//----------Consortium RPC
consortium_rpc_rule := (le.append_feedback_phone7_did in ['1', '2'] or
											 le.append_feedback_phone7_nm_addr in ['1', '2']) and
											 (ut.DaysApart((STRING8)Std.Date.Today(), (string)le.append_feedback_phone7_did_dt) <= 365  or
											 ut.DaysApart((STRING8)Std.Date.Today(), (string)le.append_feedback_phone7_nm_addr_dt) <= 365 );

consortium_rpc_caption := if(consortium_rpc_rule,
							               Translation_Codes.rules_bitmap_code('Consortium-RPC'), 0b);							



//---------Cell phone type match best address
		cell_best_rule := le.append_phone_type[..4] = 'CELL' and
						  le.append_best_addr_match_flag ;
							
		cell_best_caption:= if(cell_best_rule, 
							   Translation_Codes.rules_bitmap_code('Cellphone-Best-Match'), 0b);
								 
//---------Targus Non-pub
		non_pub_targ_rule := le.append_nonpublished_match > 1000b and  
							 le.append_phone_type[..4] = 'POTS';
							 
	non_pub_targ_caption:= if(non_pub_targ_rule, 
								   Translation_Codes.rules_bitmap_code('Targ-Non-pub'), 0b);
		
//-----Classify as include records where phone has vendor confidence score > 0 and <> 5
last_resort_med_vendor_conf_rule := le.cur_orig_conf_score > 0 and
							le.cur_orig_conf_score <> 5;
							
last_resort_med_vendor_conf_caption:= if(last_resort_med_vendor_conf_rule, 
									  Translation_Codes.rules_bitmap_code('Med-Vendor-Conf-Cell'), 0b);
										
discon_rules := if(low_vendor_conf_rule or deceased_rule or gongh_discon_rule or consortium_discon_rule or iq_wrongp_rule, true, false);


//inquiry RPC
iq_rpc_rule := if(le.iq_match_type = 1, true, false);

iq_rpc_caption := if(iq_rpc_rule,
								 Translation_Codes.rules_bitmap_code('IQ-RPC'), 0b );		
										
self.rules := le.rules |
							low_vendor_conf_caption |
							deceased_caption |
							gongh_discon_caption |
							consortium_discon_caption |
							iq_wrongp_caption |
							telnet_cell_caption |
							non_pub_caption |
							ported_neustar_caption |
							seen_once_caption |
							high_vendor_conf_caption |
							cell_best_latest_caption |
							source_latest_caption |
							ported_best_no_active_caption |
							ported_cell_caption |
							consortium_rpc_caption |
							cell_best_caption |
							non_pub_targ_caption |
							last_resort_med_vendor_conf_caption |
							iq_rpc_caption |
							neustar_verified_caption
							;


self.confidencescore := map(
                    telnet_cell_rule => 105,										
										neustar_verified_rule => 110,					//Bug 162654
										le.append_phone_type in celltype and le.append_latest_phone_owner_flag and high_vendor_conf_rule and cell_best_latest_rule and consortium_rpc_rule => 100,
										le.append_phone_type in celltype and le.append_latest_phone_owner_flag and high_vendor_conf_rule and consortium_rpc_rule => 95,
										le.append_phone_type in celltype and le.append_latest_phone_owner_flag and consortium_rpc_rule => 90,
										le.append_phone_type in celltype and le.append_latest_phone_owner_flag and high_vendor_conf_rule => 85,
										le.append_phone_type in celltype and consortium_rpc_rule => 80,
										le.append_phone_type in celltype and high_vendor_conf_rule => 75,
										le.append_phone_type in celltype and le.append_latest_phone_owner_flag => 70,
										le.append_phone_type in celltype => 65,
																				
										le.append_phone_type not in celltype and le.append_latest_phone_owner_flag and high_vendor_conf_rule and consortium_rpc_rule and non_pub_rule and source_latest_rule and iq_rpc_rule and ~discon_rules => 100,
										le.append_phone_type not in celltype and le.append_latest_phone_owner_flag and high_vendor_conf_rule and consortium_rpc_rule and source_latest_rule  and ~discon_rules => 95,
										le.append_phone_type not in celltype and le.append_latest_phone_owner_flag and high_vendor_conf_rule and consortium_rpc_rule and ~discon_rules => 90,	
										le.append_phone_type not in celltype and le.append_latest_phone_owner_flag and consortium_rpc_rule and ~discon_rules => 85,	
										le.append_phone_type not in celltype and le.append_latest_phone_owner_flag and iq_rpc_rule and ~discon_rules => 80,	
										le.append_phone_type not in celltype and le.append_latest_phone_owner_flag and high_vendor_conf_rule and ~discon_rules => 75,
										le.append_phone_type not in celltype and le.append_latest_phone_owner_flag and source_latest_rule and ~discon_rules => 70,
										le.append_phone_type not in celltype and le.append_latest_phone_owner_flag and non_pub_rule and ~discon_rules => 65,
										le.append_phone_type not in celltype and  consortium_rpc_rule  and ~discon_rules => 60,
										le.append_phone_type not in celltype and  iq_rpc_rule  and ~discon_rules => 55,
										le.append_phone_type not in celltype and  high_vendor_conf_rule  and le.cur_orig_conf_score = 2 and ~discon_rules => 50,
										le.append_phone_type not in celltype and  source_latest_rule  and ~discon_rules => 45,
										le.append_phone_type not in celltype and  non_pub_rule  and ~discon_rules => 40,
										le.confidencescore);
self := le;
end;

Flag_Rules := project(append_inq_info , t_flag_rules(left));

//======Set in_flag
highest_score_per_phone := dedup(sort(distribute(Flag_Rules(confidencescore > 0 ), hash(npa+phone7)), npa+phone7, -confidencescore, local), npa+phone7, local);
recordof(phplus_in) t_apply_rules(Flag_Rules  le, highest_score_per_phone ri) := transform
	self.in_flag := if((le.npa+le.phone7 = ri.npa+ri.phone7 and le.confidencescore = ri.confidencescore and le.rules = ri.rules) or
											(le.append_phone_type in celltype and le.datelastseen = 0) or
											le.confidencescore > 100, true, le.in_flag);
	self := le;
end;

set_in_flag := join(distribute(Flag_Rules, hash(npa+phone7)),
									  distribute(highest_score_per_phone, hash(cellphone)),
										left.npa + left.phone7 = right.npa + right.phone7 and
										left.confidencescore = right.confidencescore and
										left.rules = right.rules,
										t_apply_rules(left, right),
										left outer,
										local);
										
return set_in_flag;
end;