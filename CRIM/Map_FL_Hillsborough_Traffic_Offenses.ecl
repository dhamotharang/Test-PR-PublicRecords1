import crim_common, Crim, Address;

df := crim.File_FL_Hillsborough_Traffic;

Crim_Common.Layout_In_Court_Offenses tr_df_offenses(df input) := Transform

self.process_date 				    := Crim_Common.Version_In_Arrest_Offenses;
self.offender_key 				    := '26'+trim(input.Uniform_Case_Number,left,right);
self.vendor 					        := '26';
self.state_origin 				    := 'FL';
self.source_file 				      := 'FL-HILLSBOROUGH-DMV';
self.off_comp 					      := '';
self.off_delete_flag 			    := '';
self.off_date 					      := input.Date_of_Offense;
self.arr_date 					      := '';
self.num_of_counts 				    := '';
self.le_agency_cd 				    := '';
self.le_agency_desc 			    := '';
self.le_agency_case_number    := '';
self.traffic_ticket_number    := input.Citation_Number;
self.traffic_dl_no 				    := '';
self.traffic_dl_st 				    := '';
self.arr_off_code 				    := '';
self.arr_off_desc_1 			    := '';
self.arr_off_desc_2 			    := '';
self.arr_off_type_cd 			    := '';
self.arr_off_type_desc 		    := '';
self.arr_off_lev 				      := '';
self.arr_statute 				      := '';
self.arr_statute_desc 		    := '';
self.arr_disp_date 				    := '';
self.arr_disp_code 				    := '';
self.arr_disp_desc_1 			    := '';
self.arr_disp_desc_2 			    := '';
self.pros_refer_cd 				    := '';
self.pros_refer 				      := '';
self.pros_assgn_cd 				    := '';
self.pros_assgn 				      := '';
self.pros_chg_rej 				    := '';
self.pros_off_code 				    := '';
self.pros_off_desc_1 			    := '';
self.pros_off_desc_2 			    := '';
self.pros_off_type_cd 		    := '';
self.pros_off_type_desc 	    := '';
self.pros_off_lev 				    := '';
self.pros_act_filed 			    := '';
self.court_case_number 		    := trim(input.Uniform_Case_Number,left,right);
self.court_cd 					      := '';
self.court_desc 				      := '';
self.court_appeal_flag 		    := '';
self.court_final_plea 		    := '';
self.court_off_code 			    := '';
self.court_off_desc_1 		    := '';
self.court_off_desc_2			    := '';
self.court_off_type_cd 		    := '';
self.court_off_type_desc 	    := '';
self.court_off_lev 				    := '';
self.court_statute 				    := input.Statute_Violated;
self.court_additional_statutes 	:= '';
self.court_statute_desc 	    := input.Statute_Description;
self.court_disp_date 			    := '';
self.court_disp_code 			    := '';
self.court_disp_desc_1	      := '';
self.court_disp_desc_2 		    := '';
self.sent_date 					      := '';
self.sent_jail 					      := '';
self.sent_susp_time 			    := '';
self.sent_court_cost 			    := '';
self.sent_court_fine 			    := '';
self.sent_susp_court_fine     := '';
self.sent_probation 			    := '';
self.sent_addl_prov_code 	    := '';
self.sent_addl_prov_desc_1    := '';
self.sent_addl_prov_desc_2    := '';
self.sent_consec 				      := '';
self.sent_agency_rec_cust_ori := '';
self.sent_agency_rec_cust 		:= '';
self.appeal_date 				      := '';
self.appeal_off_disp 			    := '';
self.appeal_final_decision 		:= '';
end;

proj_df_offenses := project(df,tr_df_offenses(left));

sd_df_offenses:= dedup(sort(distribute(proj_df_offenses,hash(offender_key)),
									offender_key,off_date,court_statute,court_statute_desc,local),
									offender_key,off_date,court_statute,court_statute_desc,local,left):
									PERSIST('~thor_dell400::persist::Crim_FL_Hillsborough_Traffic_Offenses');

export Map_FL_Hillsborough_Traffic_Offenses	:= sd_df_offenses;
