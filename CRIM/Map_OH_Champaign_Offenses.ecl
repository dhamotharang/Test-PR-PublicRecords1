import crim_common, Crim, Address;

df := CRIM.File_OH_Champaign;

Crim_Common.Layout_In_Court_Offenses cr_df_offenses(df input) := Transform

string8     fSlashedMDYtoCYMD(string pDateIn) 
:=    intformat((integer2)regexreplace('.*/.*/([0-9]+)',pDateIn,'$1'),4,1) 
+     intformat((integer1)regexreplace('([0-9]+)/.*/.*',pDateIn,'$1'),2,1)
+     intformat((integer1)regexreplace('.*/([0-9]+)/.*',pDateIn,'$1'),2,1);

self.process_date 			    := Crim_Common.Version_In_Arrest_Offenses;
//self.offender_key 		        := '1E'+ hash(input.Name, input.DateOfBirth, input.DateFiled);
self.offender_key 		        := '1E'+ input.CaseNumber;
self.vendor 				    := '1E';
self.state_origin 			    := 'OH';
self.source_file 			    := 'OH-ChampaignCrm';
self.off_comp 				    := '';
self.off_delete_flag 		    := '';
self.off_date 				    := if(fSlashedMDYtoCYMD(input.DateOfViolation) <> '00000000', fSlashedMDYtoCYMD(input.DateOfViolation), '');
self.arr_date 				    := if(fSlashedMDYtoCYMD(input.DateArrested) <> '00000000', fSlashedMDYtoCYMD(input.DateArrested), '');
self.num_of_counts 			    := '';
self.le_agency_cd 			    := '';
self.le_agency_desc 		    := trim(Stringlib.StringToUpperCase(input.AgencyName),left,right);
self.le_agency_case_number      := '';
self.traffic_ticket_number      := if(regexfind('n/a', input.TicketNumber), '', trim(Stringlib.StringToUpperCase(input.TicketNumber),left,right));
self.traffic_dl_no 			    := '';
self.traffic_dl_st 			    := '';
self.arr_off_code 			    := '';
self.arr_off_desc_1 		    := '';
self.arr_off_desc_2 		    := '';
self.arr_off_type_cd 		    := '';
self.arr_off_type_desc 		    := '';
self.arr_off_lev 			    := '';
self.arr_statute 			    := '';
self.arr_statute_desc 		    := '';
self.arr_disp_date 			    := '';
self.arr_disp_code 			    := '';
self.arr_disp_desc_1 		    := '';
self.arr_disp_desc_2 		    := '';
self.pros_refer_cd 			    := '';
self.pros_refer 			    := '';
self.pros_assgn_cd 			    := '';
self.pros_assgn 			    := '';
self.pros_chg_rej 			    := '';
self.pros_off_code 			    := '';
self.pros_off_desc_1 		    := '';
self.pros_off_desc_2 		    := '';
self.pros_off_type_cd 		    := '';
self.pros_off_type_desc 	    := '';
self.pros_off_lev 			    := '';
self.pros_act_filed 		    := '';
self.court_case_number 		    := trim(input.CaseNumber,left,right);
self.court_cd 				    := '';
self.court_desc 			    := '';
self.court_appeal_flag 		    := '';
self.court_final_plea 		    := '';
self.court_off_code 		    := '';
self.court_off_desc_1 		    := trim(Stringlib.StringToUpperCase(input.Description),left,right);
self.court_off_desc_2		    := '';
self.court_off_type_cd 		    := '';
self.court_off_type_desc 	    := '';
self.court_off_lev 			    := trim(input.Degree,left,right);
self.court_statute 				:= trim(input.SectionNumber,left,right);
self.court_additional_statutes 	:= '';
self.court_statute_desc 	    := '';
self.court_disp_date 			:= '';
self.court_disp_code 			:= '';
self.court_disp_desc_1	        := trim(Stringlib.StringToUpperCase(input.Finding),left,right);
self.court_disp_desc_2 		    := '';
self.sent_date 					:= '';
self.sent_jail 					:= '';
self.sent_susp_time 			:= '';
self.sent_court_cost 			:= '';
self.sent_court_fine 			:= '';
self.sent_susp_court_fine       := '';
self.sent_probation 			:= '';
self.sent_addl_prov_code 	    := '';
self.sent_addl_prov_desc_1      := '';
self.sent_addl_prov_desc_2      := '';
self.sent_consec 				:= '';
self.sent_agency_rec_cust_ori   := '';
self.sent_agency_rec_cust 		:= '';
self.appeal_date 				:= '';
self.appeal_off_disp 			:= '';
self.appeal_final_decision 		:= '';
end;

proj_df_offenses := project(df,cr_df_offenses(left));

sd_df_offenses:= dedup(sort(distribute(proj_df_offenses,hash(offender_key)),
									offender_key,off_date,court_statute,court_statute_desc,local),
									offender_key,off_date,court_statute,court_statute_desc,local,left):
									PERSIST('~thor_dell400::persist::Crim_OH_Champaign_Offenses');

export Map_OH_Champaign_Offenses	:= sd_df_offenses;
