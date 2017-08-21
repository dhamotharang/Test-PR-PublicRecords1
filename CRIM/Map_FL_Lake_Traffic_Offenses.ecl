IMPORT crim_common, Crim, ut;

ds := crim.file_fl_lake_traffic;

Crim_Common.Layout_In_Court_Offenses tr_ds_offenses(ds dInput) := Transform
UpperFName						:= ut.CleanSpacesAndUpper(dInput.fname);
UpperLName						:= ut.CleanSpacesAndUpper(dInput.lname);
UpperMName						:= ut.CleanSpacesAndUpper(dInput.mname);
UpperSuffix						:= ut.CleanSpacesAndUpper(dInput.suffix);
ClnDate								:= ut.date_slashed_MMDDYYYY_to_YYYYMMDD(dInput.filing_date);
self.process_date		  := Crim_Common.Version_Development;
self.offender_key 		:= '63'+hash(UpperFName,UpperLName,UpperMName)+ClnDate;
self.vendor				    := '63';
self.state_origin		  := 'FL';
self.source_file		  := 'FL-LAKE_CTY_TRAFFIC';
self.off_comp 					      := '';
self.off_delete_flag 			    := '';
self.off_date 					      := '';
self.arr_date 					      := '';
self.num_of_counts 				    := '';
self.le_agency_cd 				    := '';
self.le_agency_desc 			    := '';
self.le_agency_case_number    := '';
self.traffic_ticket_number    := '';
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
self.court_case_number 		    := '';
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
self.court_statute 				    := ut.CleanSpacesAndUpper(dInput.statute);
self.court_additional_statutes:= '';
self.court_statute_desc 	    := '';
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

proj_ds_offenses := project(ds,tr_ds_offenses(left));

//Look up statue description
lkstatute := crim.files_lkp.Lake_Traffic;

jStatuteDesc := join(proj_ds_offenses, lkstatute,
								trim(left.court_statute,left,right) = trim(right.statute,left,right),
								transform({proj_ds_offenses},self.court_statute_desc := right.description; self := left),left outer, lookup);
								
sd_df_offenses:= dedup(sort(distribute(jStatuteDesc,hash(offender_key)),
									offender_key,court_statute,court_statute_desc,local),
									RECORD,local):
									PERSIST('~thor_dell400::persist::Crim_FL_Lake_Traffic_Offenses');

EXPORT Map_FL_Lake_Traffic_Offenses := sd_df_offenses;