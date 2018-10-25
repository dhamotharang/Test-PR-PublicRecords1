import  address, ut, header_slimsort, did_add, didville,watchdog, ExperianCred, _validate;

export Build_base(string ver) := module

name_clean := Files.Cashed_Names_File;
addr_clean := Files.Cashed_Address_File;
norm_addr :=  Normalize_Address(ver).all;

//-----------------------------------------------------------------
//join Clean Names to normalized data
//-----------------------------------------------------------------
Layouts.Layout_Out t_join_get_name (norm_addr le, name_clean ri) := TRANSFORM
	SELF.title       	:= ri.Clean_Name[ 1.. 5];
	SELF.fname       	:= ri.Clean_Name[ 6..25];
	//Blank middle names = 'NULL'
	SELF.mname       	:= if(trim(ri.Clean_Name[26..45],all) = 'NULL', '',ri.Clean_Name[26..45]) ;
	SELF.lname       	:= ri.Clean_Name[46..65];
	SELF.name_suffix 	:= if(le.Gender <> 'F', ri.Clean_Name[66..70], '');
	SELF.name_score  	:= ri.Clean_Name[71..73];
	SELF				:= le;
	SELF				:= [];
END;

get_name := join (distribute(norm_addr, hash(Orig_lname, Orig_fname, Orig_mname)) , 
				  distribute(name_clean, hash(Orig_lname, Orig_fname, Orig_mname)), 
				  left.Orig_lname 	= right.Orig_lname and 
				  left.Orig_fname 	= right.Orig_fname and 
				  left.Orig_mname 	= right.Orig_mname and 
				  left.Orig_suffix	= right.Orig_suffix,
				  t_join_get_name(left,right), 
				  left outer, 
				  local);
					
					
//-----------------------------------------------------------------
//join clean address to normalized data
//-----------------------------------------------------------------
invalid_prim_name := ['NONE','UNKNOWN','UNKNWN','UNKNOWEN','UNKNONW','UNKNON','UNKNWON','UNKONWN','UNEKNOWN','UN KNOWN','GENERAL DELIVERY'];

Layouts.Layout_Out t_join_get_address (get_name  le, addr_clean ri) := TRANSFORM
	valid_dob   :=  			if(le.Date_of_Birth <> '', _validate.date.fCorrectedDateString(le.Date_of_Birth,false), '');
	valid_snn	:= 				if((unsigned)le.Social_Security_Number > 0, le.Social_Security_Number, '');
	
	SELF.Social_Security_Number := if(le.NameType[..2] = 'SP', '', valid_snn);
	SELF.Date_of_Birth			:= if(le.NameType[..2] = 'SP' or valid_dob[..4] = '0000', '', valid_dob);
	SELF.Telephone				:= if(le.NameType[..2] = 'C1' and le.AddressSeq = 1, le.Telephone, '');
	SELF.Gender					:= if(le.NameType[..2] = 'SP', '', le.Gender);
	STRING28  v_prim_name 		:= ri.Clean_Address[13..40];
	STRING5   v_zip       		:= ri.Clean_Address[117..121];
	STRING4   v_zip4      		:= ri.Clean_Address[122..125];
	SELF.prim_range  			:= ri.Clean_Address[ 1..  10];
	SELF.predir      			:= ri.Clean_Address[ 11.. 12];
	SELF.prim_name   			:= if(trim(v_prim_name) in invalid_prim_name,'',v_prim_name);
	SELF.addr_suffix 			:= ri.Clean_Address[ 41.. 44];
	SELF.postdir     			:= ri.Clean_Address[ 45.. 46];
	SELF.unit_desig  			:= ri.Clean_Address[ 47.. 56];
	SELF.sec_range   			:= ri.Clean_Address[ 57.. 64];
	SELF.p_city_name 			:= ri.Clean_Address[ 65.. 89];
	SELF.v_city_name 			:= ri.Clean_Address[ 90..114];
	SELF.st          			:= ri.Clean_Address[115..116];
	SELF.zip         			:= if(v_zip='00000','',v_zip);
	SELF.zip4       	 		:= if(v_zip4='0000','',v_zip4);
	SELF.cart        			:= ri.Clean_Address[126..129];
	SELF.cr_sort_sz  			:= ri.Clean_Address[130..130];
	SELF.lot         			:= ri.Clean_Address[131..134];
	SELF.lot_order   			:= ri.Clean_Address[135..135];
	SELF.dbpc        			:= ri.Clean_Address[136..137];
	SELF.chk_digit   			:= ri.Clean_Address[138..138];
	SELF.rec_type    			:= ri.Clean_Address[139..140];
	SELF.county      			:= ri.Clean_Address[141..145];
	SELF.geo_lat     			:= ri.Clean_Address[146..155];
	SELF.geo_long    			:= ri.Clean_Address[156..166];
	SELF.msa         			:= ri.Clean_Address[167..170];
	SELF.geo_blk     			:= ri.Clean_Address[171..177];
	SELF.geo_match   			:= ri.Clean_Address[178..178];
	SELF.err_stat    			:= ri.Clean_Address[179..182];

//----------------------------------------------------------------
//---VERY IMPORTANT: Setting first/last date seen and current record flag
//----------------------------------------------------------------
	
	valid_Address_Create_Date   :=  if((unsigned)le.Orig_Address_Create_date between 18000101 and (unsigned) ut.GetDate, (unsigned) le.Orig_Address_Create_date, 0);
	valid_Address_Update_Date   :=  if((unsigned)le.Orig_Address_Update_date between 18000101 and (unsigned) ut.GetDate, (unsigned) le.Orig_Address_Update_date, 0);

	SELF.date_first_seen 		   	   := 	(unsigned)valid_Address_Create_Date;

	SELF.date_last_seen 			   :=   (unsigned)valid_Address_Update_Date;
	
	SELF.date_vendor_first_reported    := 	(unsigned)ver;
	SELF.date_vendor_last_reported     :=   (unsigned)ver;	
	
	SELF.current_rec_flag			   :=   if(le.AddressSeq = 1 and le.NameType = 'C1', 
											   1,0);
	SELF.current_experian_pin    := 1;											 
	SELF							   := le;
END;


get_address := join (	distribute(get_name, hash(Orig_Prim_Range, Orig_Predir, Orig_Prim_Name, Orig_Addr_Suffix, Orig_Postdir, Orig_Unit_Desig, Orig_Sec_Range, Orig_City, Orig_State, Orig_ZipCode)) , 
						distribute(addr_clean,hash(Orig_Prim_Range, Orig_Predir, Orig_Prim_Name, Orig_Addr_Suffix, Orig_Postdir, Orig_Unit_Desig, Orig_Sec_Range, Orig_City, Orig_State, Orig_ZipCode)) ,
										left.Orig_Prim_Range = right.Orig_Prim_Range AND
										left.Orig_Predir     = right.Orig_Predir AND
										left.Orig_Prim_Name  = right.Orig_Prim_Name AND
										left.Orig_Addr_Suffix= right.Orig_Addr_Suffix AND
										left.Orig_Postdir    = right.Orig_Postdir AND
										left.Orig_Unit_Desig = right.Orig_Unit_Desig AND
										left.Orig_Sec_Range  = right.Orig_Sec_Range AND
										left.Orig_City       = right.Orig_City AND
										left.Orig_State      = right.Orig_State AND
										left.Orig_ZipCode    = right.Orig_ZipCode,
										t_join_get_address(left,right), 
										left outer, 
										local) 
										: persist('~thor_data400::persist::experiancred::build_base::clean_normalized');
										
//-----------------------------------------------------------------										
//Delete records with Name score <= 50 or invalid state
//-----------------------------------------------------------------
valid_st := ['AA','AE','AK','AL','AP','AR','AS','AZ','CA','CO','CT','DC','DE','FL','FM','GA',
'GU','HI','IA','ID','IL','IN','KS','KY','LA','MA','MD','ME','MH','MI','MN','MO','MP',
'MS','MT','NC','ND','NE','NH','NJ','NM','NV','NY','OH','OK','OR','PA','PR','PW','RI',
'SC','SD','TN','TX','UT','VA','VI','VT','WA','WI','WV','WY', ''];

Bad_Names50_CurrentNmAddr 	:= get_address(current_rec_flag = 1 and ((unsigned)name_score <= 50 or st not in valid_st));
Bad_Names50_CurrentNmAddr_d := distribute(Bad_Names50_CurrentNmAddr, hash(Encrypted_Experian_PIN));
experian_d					:= distribute(get_address, hash(Encrypted_Experian_PIN));

Layouts.Layout_Out t_delete_bad_names(experian_d le, Bad_Names50_CurrentNmAddr_d ri) := transform
	SELF := le;
end;

delete_bad_names := join(experian_d, 
						 Bad_Names50_CurrentNmAddr_d,
						 left.Encrypted_Experian_PIN = right.Encrypted_Experian_PIN,
						 t_delete_bad_names(left, right),
						 left only,
						 local);
experian_clean_update:= delete_bad_names ((unsigned)name_score > 50 and st in valid_st);
							
//-----------------------------------------------------------------
//Reset currect_rec_flag = 0 for records in the prev base where we are receiving an update
//-----------------------------------------------------------------

cur_base_d   := distribute(project(Files.Base_File_Out, transform(recordof(Files.Base_File_Out), self.did := 0, self := left)), hash(Encrypted_Experian_PIN));

#IF (IsFullUpdate = false)
cur_update_d := dedup(sort(distribute(experian_clean_update, hash(Encrypted_Experian_PIN)),Encrypted_Experian_PIN, local),Encrypted_Experian_PIN, local);

Layouts.Layout_Out t_apply_updates (cur_base_d le, cur_update_d ri) := transform
	self.current_rec_flag	:= if(le.Encrypted_Experian_PIN = ri.Encrypted_Experian_PIN and 
															le.current_rec_flag = 1, 
															0, le.current_rec_flag);
	self 					:= le;
end;


apply_updates := join(cur_base_d,
					  cur_update_d,
					  left.Encrypted_Experian_PIN = right.Encrypted_Experian_PIN,
					  t_apply_updates(left, right),
					  left outer,
					  local);


base_and_update := if(nothor(FileServices.GetSuperFileSubCount(Superfile_List.Base_File)) = 0, 
					  experian_clean_update,  
					  experian_clean_update + apply_updates);

#ELSE
reset_cur_base := project(cur_base_d , transform(Layouts.Layout_Out,
										self.current_rec_flag	:= 0,
										self.current_experian_pin := 0,
										self := left));
		


base_and_update := if(nothor(FileServices.GetSuperFileSubCount(Superfile_List.Base_File)) = 0, 
                   experian_clean_update,
									 experian_clean_update + reset_cur_base);
#END

//-----------------------------------------------------------------
//DID base file------ Temporately Disabled to same machine time 
//-----------------------------------------------------------------
	   
src_rec := record
header_slimsort.Layout_Source;
Layouts.Layout_Out;
end;

DID_Add.Mac_Set_Source_Code(base_and_update, src_rec, 'EN', base_and_update_src)
   
matchset := ['A','Z','D','S'];

did_add.MAC_Match_Flex
	(base_and_update_src , 
	 matchset,					
	 Social_Security_Number, 
	 Date_of_Birth , 
	 fname, mname, 
	 lname, 
	 name_suffix, 
	 prim_range, 
	 prim_name, 
	 sec_range, 
	 zip, 
	 st,
	 Telephone, 
	 DID, 
	 src_rec, 
	 true, 
	 DID_score_field,
	 75, 
	 d_did, true, src)
//-----------------------------------------------------------------
//Rollup to eliminate duplications
//-----------------------------------------------------------------

build_experian_base_d := distribute(project(d_did,Layouts.Layout_Out), hash(did, Encrypted_Experian_PIN));  

//build_experian_base_d := distribute(base_and_update, hash(did, Encrypted_Experian_PIN)); 

build_experian_base_s := sort(build_experian_base_d, 
					did, 
					Encrypted_Experian_PIN,
					lname,	
					fname,
					mname,
					Social_Security_Number,
					Date_of_Birth,
					prim_range,
					predir,
					prim_name,
					addr_suffix,
					postdir,
					unit_desig,
					sec_range,
					v_city_name,
					st,
					zip,
					zip4,
					Telephone,
					-current_rec_flag,
					-date_vendor_last_reported,
					local);

Layouts.Layout_Out t_rollup (build_experian_base_s  le, build_experian_base_s ri) := transform
 self.Orig_Address_Create_date   := (string)ut.min2((unsigned)le.Orig_Address_Create_date, (unsigned)ri.Orig_Address_Create_date);
 self.Orig_Address_Update_date	 := (string)ut.max2((unsigned)le.Orig_Address_Update_date, (unsigned)ri.Orig_Address_Update_date);
 self.Orig_Consumer_Create_Date  := (string)ut.min2((unsigned)le.Orig_Consumer_Create_Date, (unsigned)ri.Orig_Consumer_Create_Date);
 self.date_first_seen 			 		 :=  ut.min2(le.date_first_seen, ri.date_first_seen);
 self.date_last_seen 			   		 :=  if(le.date_vendor_last_reported = (unsigned)ver,
																		   le.date_last_seen,
																			 ri.date_last_seen);
 self.date_vendor_first_reported := ut.min2(le.date_vendor_first_reported, ri.date_vendor_first_reported);
 self.date_vendor_last_reported  := ut.max2(le.date_vendor_last_reported, ri.date_vendor_last_reported);
 self.current_rec_flag		     := ut.max2(le.current_rec_flag, ri.current_rec_flag);
 self.current_experian_pin		   := ut.max2(le.current_experian_pin, ri.current_experian_pin);
 self := le;
end;

ExperianCred_base := rollup(build_experian_base_s, 
					t_rollup(left, right), 
					did, 
					Encrypted_Experian_PIN,
					lname,	
					fname,
					mname,
					Social_Security_Number,
					Date_of_Birth,
					prim_range,
					predir,
					prim_name,
					addr_suffix,
					postdir,
					unit_desig,
					sec_range,
					v_city_name,
					st,
					zip,
					zip4,
					Telephone,		
					local);

//-----------------------------------------------------------------
//Append Delete File
//-----------------------------------------------------------------					
Experian_del 		 := Files.File_Delete_In;
Experian_del_dedp   := dedup(sort(distribute(Experian_del, hash(Encrypted_Experian_PIN)),Encrypted_Experian_PIN, -Delete_Date, local) ,Encrypted_Experian_PIN, local) ;

Experian_base_d1     := distribute(ExperianCred_base,  hash(Encrypted_Experian_PIN));

Layouts.Layout_Out t_apply_deletes(Experian_base_d1 le, Experian_del_dedp ri) := transform
	self.delete_flag 	  := if(ri.Encrypted_Experian_PIN <> '', 1, le.delete_flag);
	self.delete_file_date := (unsigned) ri.Delete_Date;
	self.suppression_code := (unsigned) ri.suppression_code;
	SELF := le;
end;

#IF (IsFullUpdate = false)
apply_deletes := join(Experian_base_d1, 
						 Experian_del_dedp,
						 left.Encrypted_Experian_PIN = right.Encrypted_Experian_PIN,
						 t_apply_deletes(left, right),
						 left outer,
						 local);
#ELSE
apply_deletes := ExperianCred_base;
#END
						 
//-----------------------------------------------------------------
//Append Deceased File
//-----------------------------------------------------------------			

Experian_dec 			  := Files.File_Deceased_In;
Experian_dec_dedp   := dedup(sort(distribute(Experian_dec , hash(Encrypted_Experian_PIN)),Encrypted_Experian_PIN, local) ,Encrypted_Experian_PIN, local) ;

Experian_base_d2     := distribute(apply_deletes,  hash(Encrypted_Experian_PIN));

Layouts.Layout_Out t_apply_deceased(Experian_base_d2 le, Experian_dec_dedp ri) := transform
	self.deceased_ind     :=  if(le.Encrypted_Experian_PIN <> ri.Encrypted_Experian_PIN , // no match 
                               le.deceased_ind,                   // Keep existing (left)
                               if(le.NameType[..2] <> 'SP', 1, 0) // Else consider NameType and assign new value
                              );
	SELF := le;
end;

apply_deceased := join(Experian_base_d2, 
						 Experian_dec_dedp,
						 left.Encrypted_Experian_PIN = right.Encrypted_Experian_PIN,
						 t_apply_deceased(left, right),
						 left outer,
						 local);
				 					 
//---------------------------------------------------------------------------										
//Update date last seen to version for current records with:
//       name, address and ssn populated
//       not deleted or deceased
//       there is no other record for the same experian encripted pin with a more recent address
//----------------------------------------------------------------------------
pins_max_dt_layout := record
 experian_clean_update.Encrypted_Experian_PIN;
 unsigned max_dt_last_seen;
end;

pins_dt := project(apply_deceased(current_experian_pin = 1), transform(pins_max_dt_layout, 
																					self.max_dt_last_seen := left.date_last_seen,
																					self := left));
 
pins_max_dt_last_seen :=  dedup(sort(distribute(pins_dt, hash(Encrypted_Experian_PIN)), Encrypted_Experian_PIN, -max_dt_last_seen, local), Encrypted_Experian_PIN, local);

reset_dt_last_seen   := join (distribute(apply_deceased, hash(Encrypted_Experian_PIN)), 
															distribute(pins_max_dt_last_seen, hash(Encrypted_Experian_PIN)),
															left.Encrypted_Experian_PIN = right.Encrypted_Experian_PIN,
															transform(recordof(experian_clean_update),
															self.date_last_seen := if(left.current_rec_flag = 1 and
																												left.lname <>'' and
																												left.prim_range + left.prim_name + left.sec_range <> '' and
																												left.Social_Security_Number not in ut.Set_BadSSN and
																												(unsigned)left.Social_Security_Number > 0 and
																												left.delete_flag  <> 1 and
																												left.deceased_Ind <> 1 and
																												left.date_last_seen >= right.max_dt_last_seen,
																												ut.max2((unsigned)ver, left.date_last_seen),
																												left.date_last_seen),
															 self := left),
															 left outer,
															 local);			
			   
#IF (IsFullUpdate = false)
//Delete records from base where suppression code is in the list of codes to be deleted
Apply_Delete_codes := join(distribute(reset_dt_last_seen, hash(Encrypted_Experian_PIN)),
                    distribute(Experian_del((unsigned)Suppression_Code in experiancred.Delete_Suppression_Codes), hash(Encrypted_Experian_PIN)),
					left.Encrypted_Experian_PIN = right.Encrypted_Experian_PIN,
					transform(Layouts.Layout_Out, self := left),
					left only,
					local);
					
#ELSE
Apply_Delete_codes := reset_dt_last_seen;
#END					 

export All := apply_delete_codes;

END;