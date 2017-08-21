import crim_common, Crim, Address, lib_stringlib,ut;

df := CRIM.File_OH_Delaware(Summary_Name != 'Summary_Name' and Parties_Type = 'Defendant' and Summary_LastName <> '');


Crim_Common.Layout_In_Court_Offenses tr_df_offenses(df input) := Transform

string8     fSlashedMDYtoCYMD(string pDateIn) 
:=    intformat((integer2)regexreplace('.*/.*/([0-9]+)',pDateIn,'$1'),4,1) 
+     intformat((integer1)regexreplace('([0-9]+)/.*/.*',pDateIn,'$1'),2,1)
+     intformat((integer1)regexreplace('.*/([0-9]+)/.*',pDateIn,'$1'),2,1);

self.process_date 				    := Crim_Common.Version_Development;
self.offender_key 				    := '1H'+ trim(input.Summary_CaseNumber,left,right) + trim(input.Summary_LastName,left,right);
self.vendor 					    := '1H';
self.state_origin 				    := 'OH';
self.source_file 				    := 'OH-DelawareCrmCrt';
self.off_comp 					    := trim(input.PartyCharges_Number,all);
self.off_delete_flag 			    := '';
self.off_date 					    := if(input.Summary_OffenseDate <> '', fSlashedMDYtoCYMD(input.Summary_OffenseDate), '');
self.arr_date 					    := if(input.Summary_ArrestDate <> '', fSlashedMDYtoCYMD(input.Summary_ArrestDate), '');
self.num_of_counts 				    := '';
self.le_agency_cd 				    := '';
self.le_agency_desc 			    := '';
self.le_agency_case_number          := '';
self.traffic_ticket_number          := '';
self.traffic_dl_no 				    := '';
self.traffic_dl_st 				    := '';
self.arr_off_code 				    := '';
self.arr_off_desc_1 			    := '';
self.arr_off_desc_2 			    := '';
self.arr_off_type_cd 			    := '';
self.arr_off_type_desc 		        := '';
self.arr_off_lev 				    := '';
self.arr_statute 				    := '';
self.arr_statute_desc 		        := '';
self.arr_disp_date 				    := '';
self.arr_disp_code 				    := '';
self.arr_disp_desc_1 			    := '';
self.arr_disp_desc_2 			    := '';
self.pros_refer_cd 				    := '';
self.pros_refer 				    := '';
self.pros_assgn_cd 				    := '';
self.pros_assgn 				    := '';
self.pros_chg_rej 				    := '';
self.pros_off_code 				    := '';
self.pros_off_desc_1 			    := '';
self.pros_off_desc_2 			    := '';
self.pros_off_type_cd 		        := '';
self.pros_off_type_desc 	        := '';
self.pros_off_lev 				    := '';
self.pros_act_filed 			    := '';
self.court_case_number 		        := trim(input.Summary_CaseNumber,left,right);
self.court_cd 					    := '';
self.court_desc 				    := '';
self.court_appeal_flag 		        := '';
self.court_final_plea 		        := '';
self.court_off_code 			    := '';
self.court_off_desc_1 		        := MAP(input.PartyChargeSummary_AmendedCharge <> '' => trim(input.PartyChargeSummary_AmendedCharge),
                                           input.PartyChargeSummary_AmendedCharge = '' and input.PartyChargeSummary_Description <> '' => trim(input.PartyChargeSummary_Description),
										   trim(input.Summary_Description));
self.court_off_desc_2			    := '';
self.court_off_type_cd 		        := '';
self.court_off_type_desc 	        := '';
self.court_off_lev 				    := '';
self.court_statute 				    := MAP(input.PartyChargeSummary_AmendedCharge <> '' => '',
                                           input.PartyChargeSummary_Description <> '' => trim(input.PartyChargeSummary_ActionCode),
										   input.Summary_ActionCode);
self.court_additional_statutes 	    := '';
self.court_statute_desc 	        := '';
self.court_disp_date 			    := if(input.CaseDispositionSummary_DispositionDate <> '', fSlashedMDYtoCYMD(input.CaseDispositionSummary_DispositionDate), '');
self.court_disp_code 			    := '';
self.court_disp_desc_1	            := trim(input.CaseDispositionSummary_Disposition);
self.court_disp_desc_2 		        := '';
self.sent_date 					    := '';
self.sent_jail 					    := if(Stringlib.StringFilter(input.PartyChargeSentencingSummary_SentencingDaysInJail, '0123456789') <> '', Stringlib.StringFilter(input.PartyChargeSentencingSummary_SentencingDaysInJail, '0123456789') + ' Days', '');
self.sent_susp_time 			    := if(Stringlib.StringFilter(input.PartyChargeSentencingSummary_SuspendedDaysInJail, '0123456789') <> '', Stringlib.StringFilter(input.PartyChargeSentencingSummary_SuspendedDaysInJail, '0123456789') + ' Days', '');
self.sent_court_cost 			    := '';
self.sent_court_fine 			    := '';
self.sent_susp_court_fine           := '';
self.sent_probation 			    := if(Stringlib.StringFilter(input.PartyChargeSentencingSummary_DaysOfProbation, '0123456789') <> '', Stringlib.StringFilter(input.PartyChargeSentencingSummary_DaysOfProbation, '0123456789') + ' Days', '');
self.sent_addl_prov_code 	        := '';
self.sent_addl_prov_desc_1          := '';
self.sent_addl_prov_desc_2          := '';
self.sent_consec 				    := '';
self.sent_agency_rec_cust_ori       := '';
self.sent_agency_rec_cust 		    := '';
self.appeal_date 				    := '';
self.appeal_off_disp 			    := '';
self.appeal_final_decision 		    := '';
end;

proj_df_offenses := project(df,tr_df_offenses(left));

sd_df_offenses:= dedup(sort(distribute(proj_df_offenses,hash(offender_key)),
									offender_key,off_date,off_comp,court_statute,court_off_desc_1,local),
									offender_key,off_date,off_comp,court_statute,court_off_desc_1,local,left):
									PERSIST('~thor_dell400::persist::Crim_OH_Delaware_Offenses');



export Map_OH_Delaware_Offenses := sd_df_offenses;