

import Crim_Common, _validate;

// Datasets needed to map the offenses data
ds_offense := CRIM.File_oh_summit_barberton(regexfind('EXPUNGE', StringLib.StringToUpperCase(defendantname), 0)='');

string8     	fSlashedMDYtoCYMD(string pDateIn) 
				:=    intformat((integer2)regexreplace('.*/.*/([0-9]+)',pDateIn,'$1'),4,1) 
				+     intformat((integer1)regexreplace('([0-9]+)/.*/.*',pDateIn,'$1'),2,1)
				+     intformat((integer1)regexreplace('.*/([0-9]+)/.*',pDateIn,'$1'),2,1);

Crim_Common.Layout_In_Court_Offenses tOHBACrim(ds_offense input) := Transform

//ViolationDate
ViolationDate := if(fSlashedMDYtoCYMD(input.ViolationDate) between '19000101' and Crim_Common.Version_Development, fSlashedMDYtoCYMD(input.ViolationDate),'');  
FileDate := if(fSlashedMDYtoCYMD(input.FileDate) between '19000101' and Crim_Common.Version_Development, fSlashedMDYtoCYMD(input.FileDate),'');  


self.process_date 				:= Crim_Common.Version_Development;
self.offender_key 				:= '4F' + trim(input.casenum) + FileDate;    
self.vendor 					    := '4F';
self.state_origin 				:= 'OH';
self.source_file 				  := '(CP)OHSummitBarberto';
self.off_comp 					  := '';
self.off_delete_flag 			:= '';
self.off_date 					  := ViolationDate;
self.arr_date 					  := '';
self.num_of_counts 				:= '';
self.le_agency_cd 				:= '';
self.le_agency_desc 			:= input.AgencyCode;
self.le_agency_case_number := '';
self.traffic_ticket_number := input.TicketNumber;
self.traffic_dl_no 				:= '';
self.traffic_dl_st 				:= '';
self.arr_off_code 				:= '';
self.arr_off_desc_1 			:= '';
self.arr_off_desc_2 			:= '';
self.arr_off_type_cd 			:= '';
self.arr_off_type_desc 		:= '';
self.arr_off_lev 				  := '';
self.arr_statute 				  := '';
self.arr_statute_desc 		:= '';
self.arr_disp_date 				:= '';
self.arr_disp_code 				:= '';
self.arr_disp_desc_1 			:= '';
self.arr_disp_desc_2 			:= '';
self.pros_refer_cd 				:= '';
self.pros_refer 				  := '';
self.pros_assgn_cd 				:= '';
self.pros_assgn 				  := '';
self.pros_chg_rej 				:= '';
self.pros_off_code 				:= '';
self.pros_off_desc_1 			:= '';
self.pros_off_desc_2 			:= '';
self.pros_off_type_cd 		:= '';
self.pros_off_type_desc 	:= '';
self.pros_off_lev 				:= '';
self.pros_act_filed 			:= '';
self.court_case_number 		:= input.casenum;
self.court_cd 					  := '';
self.court_desc 				  := '';
self.court_appeal_flag 		:= ''; 
self.court_final_plea 		:= '';
self.court_off_code 			:= '';
self.court_off_desc_1 		:= input.ViolationDescription;
self.court_off_desc_2			:= case(input.bondpaidtodate,'/OV' => '',
                                                        '.00' => '', 'BOND PAID AMOUNT: $' + input.bondpaidtodate );
self.court_off_type_cd 		:= '';
self.court_off_type_desc 	:= '';
self.court_off_lev 				:= case(input.Degree,'1st Degree Felony' => 'F1',
                                    '1st Degree Misdemeanor'=> 'M1', 
                                      '2nd Degree Felony' => 'F2','2nd Degree Misdemeanor'=> 'M2',
																	      '3rd Degree Felony' => 'F3','3rd Degree Misdemeanor'=> 'M3',
																		      '4th Degree Felony' => 'F4','4th Degree Misdemeanor'=> 'M4',
																			      '5th Degree Felony' => 'F5','Minor Misdemeanor'=> 'MM',''); 
self.court_statute 				:= input.SectionNum;
self.court_additional_statutes 	:= '';
self.court_statute_desc 	:= '';
self.court_disp_date 			:= '';
self.court_disp_code 			:= '';
self.court_disp_desc_1	 	:= '';
self.court_disp_desc_2 		:= '';
self.sent_date 					  := '';
self.sent_jail 					  := '';
self.sent_susp_time 			:= '';					
self.sent_court_cost 			  := '';
self.sent_court_fine 			  := '';
self.sent_susp_court_fine 	:= '';
self.sent_probation 			  := '';
self.sent_addl_prov_code 		:= '';
self.sent_addl_prov_desc_1 	:= '';
self.sent_addl_prov_desc_2 	:= '';
self.sent_consec 				    := '';
self.sent_agency_rec_cust_ori 	:= '';
self.sent_agency_rec_cust 		:= '';
self.appeal_date 				      := '';
self.appeal_off_disp 			    := '';
self.appeal_final_decision 		:= '';

end;

pOHBarbertoOffense := project(ds_offense,tOHBACrim(left));

//ds_TOHBarbertonCrimOffenseOut := pOHBarbertoOffense : PERSIST('~thor_dell400::persist::Crim_OH_Barberton_Offenses');

//ds_TOHBarbertonCrimOffenseOut := dedup(pOHBarbertoOffense,offender_key,off_date,le_agency_desc,traffic_ticket_number,court_case_number,court_off_desc_1,court_off_lev,court_statute)  : PERSIST('~thor_dell400::persist::Crim_OH_Barberton_Offenses');

ds_TOHBarbertonCrimOffenseOut := dedup(sort(distribute(pOHBarbertoOffense,hash(offender_key)),
									                  offender_key,off_date,le_agency_desc,traffic_ticket_number,court_case_number,court_off_desc_1,court_off_lev,court_statute,local),
									                    offender_key,off_date,le_agency_desc,traffic_ticket_number,court_case_number,court_off_desc_1,court_off_lev,court_statute, local)
									                      : PERSIST('~thor_dell400::persist::Crim_OH_Barberton_Offenses');

export Map_OH_Summit_Barberton_Offenses := ds_TOHBarbertonCrimOffenseOut;