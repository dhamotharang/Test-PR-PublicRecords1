import Ut, lib_stringlib;

string8 lFixMDY(string6 pMDYIn)
 := if((integer4)pMDYIn < 10000,
	   '',
	   if(pMDYIn[5..6] < '20','20','19') + pMDYIn[5..6] + pMDYIn[1..4]
	  );

string8 lFixYMD(string6 pYMDIn)
 := if((integer4)pYMDIn < 190000,
	   '',
	   if(pYMDIn[1..2] < '20','20','19') + pYMDIn
	  );
	  
string8 lFixDOB(string6 pMDYIn)
 := if((integer4)pMDYIn < 10000,
	   '',
	   '19' + pMDYIn[5..6] + pMDYIn[1..4]
	  );

Drivers.Layout_DL lTransform_ME_To_Common(Drivers.File_ME_Full pInput)
 := transform
  self.dt_first_seen 				:= (unsigned8)pInput.append_PROCESS_DATE div 100;
  self.dt_last_seen 				:= (unsigned8)pInput.append_PROCESS_DATE div 100;
  self.dt_vendor_first_reported 	:= (unsigned8)pInput.append_PROCESS_DATE div 100;
  self.dt_vendor_last_reported 	:= (unsigned8)pInput.append_PROCESS_DATE div 100;
  self.orig_state 				:= 'ME';
 	self.dob 						:= if(pInput.orig_DOB[7..8]<>'', 
	                                     (unsigned4)(pInput.orig_DOB[5..8] + pInput.orig_DOB[1..2] + pInput.orig_DOB[3..4]),
										 (unsigned4)lFixDOB(pInput.orig_DOB));
	self.name						:= trim(pInput.orig_FName) + trim(' '+pInput.orig_MI) + trim(' '+pInput.orig_LName) + trim(' '+pInput.orig_NameSuf);
	self.sex_flag					:= pInput.orig_Sex;
	self.height						:= if((integer2)(pInput.orig_Height + pInput.orig_Height2)<>0,pInput.orig_Height + pInput.orig_Height2,'');
	self.weight						:= if((integer2)pInput.orig_Weight<>0,pInput.orig_Weight,'');
	self.hair_color					:= pInput.orig_Hair;
	self.eye_color					:= pInput.orig_Eyes;
	self.addr1						:= pInput.orig_Street;
	self.city 						:= pInput.orig_City;
	self.state						:= pInput.orig_State;
	self.zip 						:= pInput.orig_Zip;
	self.orig_expiration_date		:= if((unsigned1)pInput.orig_DLExpireDate<>0 and pInput.orig_DLExpireDate[7..8] = '',(unsigned4)lFixMDY(pInput.orig_DLIssueDate[1..4]+pInput.orig_DLExpireDate),
	                                       if((unsigned1)pInput.orig_DLExpireDate<>0 and pInput.orig_DLExpireDate[7..8] != '',
								              (unsigned4)(pInput.orig_DLExpireDate[5..8] + pInput.orig_DLExpireDate[1..2] + pInput.orig_DLExpireDate[3..4]),
	                                           0));
	self.lic_issue_date 			:= if(pInput.orig_DLIssueDate[7..8]<>'', 
										if((unsigned4)(pInput.orig_DLIssueDate[5..8] + pInput.orig_DLIssueDate[1..2] + pInput.orig_DLIssueDate[3..4]) < (unsigned4)Drivers.Version_Development,
										   (unsigned4)(pInput.orig_DLIssueDate[5..8] + pInput.orig_DLIssueDate[1..2] + pInput.orig_DLIssueDate[3..4]), 0),
											if((unsigned4)lFixMDY(pInput.orig_DLIssueDate) < (unsigned4)Drivers.Version_Development, (unsigned4)lFixMDY(pInput.orig_DLIssueDate), 0));
	self.orig_issue_date			:= if(pInput.orig_OriginalIssueDate[7..8]<>'',
											(unsigned4)(pInput.orig_OriginalIssueDate[5..8] + pInput.orig_OriginalIssueDate[1..2] + pInput.orig_OriginalIssueDate[3..4]),
												(unsigned4)lFixYMD(pInput.orig_OriginalIssueDate));
	self.restrictions				   := lib_stringlib.stringlib.StringFilter(trim(pInput.orig_Restrictions,
																				 all
																				),
																			'ABCDEFGMQRSW'
																		   );
	self.lic_endorsement 			 := lib_stringlib.StringLib.stringfilter(trim(pInput.orig_Endorsements+
																				 pInput.orig_Endorsements2+
																				 pInput.orig_Endorsements3+
																				 pInput.orig_Endorsements4+
																				 pInput.orig_Endorsements5+
																				 pInput.orig_Endorsements6+
																				 pInput.orig_Endorsements7+
																				 pInput.orig_Endorsements8+
																				 pInput.orig_Endorsements9+
																				 pInput.orig_Endorsements10,
																				 all
																			    ),
																			 'HIJKLNPTXYZ'
																			);
	self.license_type 				:= pInput.orig_DLClass;
	self.dl_number					:= pInput.orig_HistoryNum;
	self.title 						:= pInput.clean_name_prefix;
	self.fname 						:= pInput.clean_name_first;		                             
	self.mname 						:= pInput.clean_name_middle;		                             
	self.lname 						:= pInput.clean_name_last;		                             
	self.name_suffix 				:= pInput.clean_name_suffix;		                             
	self.cleaning_score 			:= pInput.clean_name_score;		                             
	self.prim_range 				:= pInput.clean_prim_range;		                             
	self.predir 					:= pInput.clean_predir;		                             
	self.prim_name 					:= pInput.clean_prim_name;		                             
	self.suffix 					:= pInput.clean_addr_suffix;		                             
	self.postdir 					:= pInput.clean_postdir;		                             
	self.unit_desig 				:= pInput.clean_unit_desig;		                             
	self.sec_range 					:= pInput.clean_sec_range;		                             
	self.p_city_name 				:= pInput.clean_p_city_name;		                             
	self.v_city_name 				:= pInput.clean_v_city_name;		                             
	self.st 						:= pInput.clean_st;		                             
	self.zip5 						:= pInput.clean_zip;		                             
	self.zip4 						:= pInput.clean_zip4;		                             
	self.cart 						:= pInput.clean_cart;		                             
	self.cr_sort_sz 				:= pInput.clean_cr_sort_sz;		                             
	self.lot 						:= pInput.clean_lot;		                             
	self.lot_order 					:= pInput.clean_lot_order;		                             
	self.dpbc 						:= pInput.clean_dpbc;		                             
	self.chk_digit 					:= pInput.clean_chk_digit;		                             
	self.rec_type 					:= pInput.clean_record_type;		                             
	self.ace_fips_st 				:= pInput.clean_ace_fips_st;		                             
	self.county 					:= pInput.clean_fipscounty;		                             
	self.geo_lat 					:= pInput.clean_geo_lat;		                             
	self.geo_long 					:= pInput.clean_geo_long;		                             
	self.msa 						:= pInput.clean_msa;		                             
	self.geo_blk 					:= pInput.clean_geo_blk;		                             
	self.geo_match 					:= pInput.clean_geo_match;		                             
	self.err_stat 					:= pInput.clean_err_stat;		                             
	self.issuance 					:= ''; // had to include explcitly because of...
end;

ME_Transform := project(Drivers.File_ME_Full, lTransform_ME_To_Common(left));
ME_Sort := sort(ME_Transform, dl_number, name, addr1, city, lic_issue_date, -orig_expiration_date);
export ME_as_DL := dedup(ME_Sort, dl_number, name, addr1, city, lic_issue_date) : persist(Drivers.Cluster + 'Persist::DrvLic_ME_as_DL');;

//export ME_as_DL := project(Drivers.File_ME_Full, lTransform_ME_To_Common(left));


