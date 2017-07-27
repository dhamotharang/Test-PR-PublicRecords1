import Corp2, _validate, Address, lib_stringlib, _control, versioncontrol;

export KS := module

    export constants := module
	   export cluster := '~thor_data400::';
	end;

	export Layouts_Raw_Input := module
	    // record lenght 317
		export Cpabrep := record
			string2  Filetype;
			string1  Filler0;
			string7  Corp_Number;
			string1  Filler1;
			string70 Corp_Name;
			string30 Attn_Line;
			string30 Address_1;
			string30 Address_2;
			string20 City;
			string9  Zip;
			string1  Close_Corp;
			string2  Tax_closing;
			string8  Date_of_Incorp;
			string6  Last_Correct_A_R;
			string8  A_R_Due;
			string8  Extension_Date;
			string8  Forfeiture_Date;
			string8  Expiration_Date;
			string9  Stock_Issued;
			string1  Filler2;
			string9  FEIN;
			string1  Cleanup_Stat;
			string10 Cleanup_ID;
			string8  Prior_Busn_Date;
			string1  More_5_O_D;
			string7  Last_Update;
			string2  State;
			string3  State_Country;
			string3  Country;
			string1  A_R_Status;
			string1  Filler3;
			string2  Corporation_Type;
			string2  Corp_Stat;
			string7  RANUM;
			string1  lf;
		end;
		
		// record lenght 75
		export Cpaerep := record
			string2  Update_Code;
			string1  Filler0;
			string7  CNNumber;
			string5  CN_Seq_Number;
			string1  Filler;
			string40 CN_Name;
			string7  CN_CCN;
			string1  CN_Cur_Pre;
			string1  CN_Master_Type;
			string8  CN_File_date;
			string1  CN_Verify;
			string1  lf;
		end;
	
		// record lenght 186
		export Cpadrep := record
			string2  Update_Code;
			string1  Filler0;
			string7  RANUM;
			string1  Filler;
			string70 RANAME;
			string30 RAADDR1;
			string30 RAADDR2;
			string4  RAZIP4;
			string1  RASTATUS;
			string10 RAUID;
			string2  RASTATE;
			string2  RACOUNTY;
			string20 RACITY;
			string5  RAZIP5;
			string1  lf;
		end;
	
		// record lenght 83
		export Cpahst := record
			string2  Update_Code;
			string1  Filler0;
			string7  Corp_Number;
			string2  Seq_Number;
			string1  Filler;
			string3  Fund;
			string8  Validation_Date;
			string4  Validation_Number;
			string3  Validation_Sub;
			string7  Amount_Paid;
			string8  Transaction_Date;
			string8  Filing_AR_Date;
			string10 User_ID;
			string4  Microfilm_Roll;
			string5  Microfilm_Frame;
			string1  Agriculture_Code;
			string1  Bad_Check_Code;
			string3  Number_Of_Pages;
			string1  Delete_Or_Error;
			string3  History_Code;
			string1  lf;
		end;
		
		// record lenght 41
		export Cpaqrep := record
			string7  CORP_NUM;
			string2  CORP_SEQNUM;
			string1  FILLER;
			string30 CORP_NAME_CONT;
			string1  lf;
		end;
		
		// record lenght 148
		export Cpbcrep := record
			string2  Update_Code;
			string1  Filler0;
			string7  PNNUMBER;
			string5  PNSEQNUM;
			string1  FILLER;
			string70 PNCORPNAME;
			string30 PNAME1;
			string30 PNAME2;
			string1  PNCURPREV;
			string1  lf;
		end;
		
		// Status code translation table layout
		// record lenght 78
		export Cpakrep := record
			string2  Corp_Stat_Code;
			string60 Long_Desc;
			string15 Short_Desc;
			string1  lf;
		end;
		
		// State & country code translation table layout
		// record lenght 34
		export Cpanrep := record
			string3  Code;
			string30 Name;
			string1  lf;
		end;
		
		// County code translation table layout
		// record lenght 58
		export Cpasrep := record
			string2  County_Code;
			string20 City_Name;
			string5  Zip;
			string30 County_Name;
			string1  lf;
		end;
		
		// Corp type code translation table layout
		// record lenght 33
		export Crptyp := record
			string2  Corporation_Type;
			string30 Corp_typ_desc;
			string1  lf;
		end;
		
		// Annual report status code translation table layout
		// record lenght 68
		export Cpalrep := record
			string2  A_R_Status;
			string50 Long_Arsc_Desc;
			string15 Short_Arsc_Desc;
			string1  lf;
		end;
	
	end;

	export Files_Raw_Input := module
		// vendor file definition 
		export VendorCpabrep(string filedate) := dataset(Constants.cluster + 'in::corp2::'+filedate+'::cpabrep::ks',	
													     Layouts_Raw_Input.Cpabrep, thor);													  
													   
		export VendorCpaerep(string filedate) := dataset(Constants.cluster + 'in::corp2::'+filedate+'::cpaerep::ks',	
														 Layouts_Raw_Input.Cpaerep, thor);													 
													   
		export VendorCpadrep(string filedate) := dataset(Constants.cluster + 'in::corp2::'+filedate+'::cpadrep::ks',	
														 Layouts_Raw_Input.Cpadrep, thor);												
													   
		export VendorCpahst(string filedate)  := dataset(Constants.cluster + 'in::corp2::'+filedate+'::cpahst::ks',	
														 Layouts_Raw_Input.Cpahst, thor);													   
													   													   
		export VendorCpaqrep(string filedate) := dataset(Constants.cluster + 'in::corp2::'+filedate+'::cpaqrep::ks',	
														 Layouts_Raw_Input.Cpaqrep, thor);
													   													   
		export VendorCpbcrep(string filedate) := dataset(Constants.cluster + 'in::corp2::'+filedate+'::Cpbcrep::ks',	
														 Layouts_Raw_Input.Cpbcrep, thor);
		
		// lookup files provided by the vendor with each update
		export VendorCpakrep(string filedate) := dataset(Constants.cluster + 'lookup::corp2::'+filedate+'::Cpakrep::ks',	
														 Layouts_Raw_Input.Cpakrep, thor);
													   													   
		export VendorCpanrep(string filedate) := dataset(Constants.cluster + 'lookup::corp2::'+filedate+'::Cpanrep::ks',	
														 Layouts_Raw_Input.Cpanrep, thor);
													   	
		export VendorCpasrep(string filedate) := dataset(Constants.cluster + 'lookup::corp2::'+filedate+'::Cpasrep::ks',	
														 Layouts_Raw_Input.Cpasrep, thor);
													   
		export VendorCrptyp(string filedate) := dataset(Constants.cluster + 'lookup::corp2::'+filedate+'::Crptyp::ks',	
														Layouts_Raw_Input.Crptyp, thor);
		
		export VendorCpalrep(string filedate) := dataset(Constants.cluster + 'lookup::corp2::'+filedate+'::Cpalrep::ks',	
														 Layouts_Raw_Input.Cpalrep, thor);
										
	end; //Files_Raw_Input
	
	//****************  Update process begins   *******************************************************
	export Update(string fileDate, string version, boolean pShouldSpray = _Dataset().bShouldSpray, boolean pOverwrite = false) := function
	    
		Layout_Joined := record
		   Layouts_Raw_Input.Cpabrep and not [lf];
		   Layouts_Raw_Input.Cpaerep.CN_Cur_Pre;
		   Layouts_Raw_Input.Cpaerep.CN_File_Date;
		   Layouts_Raw_Input.Cpadrep.RANAME;
		   Layouts_Raw_Input.Cpadrep.RAADDR1;
		   Layouts_Raw_Input.Cpadrep.RAADDR2;
		   Layouts_Raw_Input.Cpadrep.RACITY;
		   Layouts_Raw_Input.Cpadrep.RASTATE;
		   Layouts_Raw_Input.Cpadrep.RAZIP5;
		   Layouts_Raw_Input.Cpadrep.RAZIP4;
		   Layouts_Raw_Input.Cpbcrep.PNCORPNAME;
		   Layouts_Raw_Input.Cpaqrep.CORP_NAME_CONT;
		   string30 CORP_NAME_CONT_2 := '';
		   string30 CORP_NAME_CONT_3 := '';		   
		end;
		
		Layout_Cpaqrep_extended := record
		   Layouts_Raw_Input.Cpaqrep and not [lf];
		   string30 CORP_NAME_CONT_2 := '';
		   string30 CORP_NAME_CONT_3 := '';
		end;
		
		Layout_J_Cpbcrep_Cpaerep := record
		   Layouts_Raw_Input.Cpbcrep and not [lf];
		   Layouts_Raw_Input.Cpaerep.CN_Cur_Pre;
		   Layouts_Raw_Input.Cpaerep.CN_File_Date;		   
		end;
		
		Layout_Joined  joinJ1(Layouts_Raw_Input.Cpabrep l, Layouts_Raw_Input.Cpadrep r) := transform
		   self.RANAME    := r.RANAME;
		   self.RAADDR1   := r.RAADDR1;
		   self.RAADDR2   := r.RAADDR2;
		   self.RACITY    := r.RACITY;
		   self.RASTATE   := r.RASTATE;
		   self.RAZIP5    := r.RAZIP5;
		   self.RAZIP4    := r.RAZIP4;		   
		   self           := l;
		   self           := [];
		end;
		
		J1 := join (Files_Raw_Input.VendorCpabrep(filedate), Files_Raw_Input.VendorCpadrep(filedate), trim(left.RANUM, left, right) = trim(right.RANUM, left, right), 
		            joinJ1(left, right), left outer);
		
	
		Layout_Cpaqrep_extended trfProject(Layouts_Raw_Input.Cpaqrep l) := transform
		   self := l;
		end;
		
		Cpaqrep_ext := project (Files_Raw_Input.VendorCpaqrep(filedate), trfProject(left));
		
		Cpaqrep_ext_srt := sort(Cpaqrep_ext, CORP_NUM, CORP_SEQNUM);
		
		Layout_Cpaqrep_extended  trfdenorm(Layout_Cpaqrep_extended l, Layout_Cpaqrep_extended r, integer c) := transform
	        self.CORP_NAME_CONT_2 := if (c = 2, r.CORP_NAME_CONT, '');
	        self.CORP_NAME_CONT_3 := if (c = 3, r.CORP_NAME_CONT, '');			
			self := l;
		end;
		
		// denormalize the records to get the all the Corp_name parts in one record.
		denorm_Cpaqrep := denormalize(Cpaqrep_ext_srt, Cpaqrep_ext_srt,
		                              left.Corp_Num = Right.Corp_Num,
									  trfdenorm(left, right, counter)
									 );
		
		dedup_denorm_Cpagrep := dedup(sort(denorm_Cpaqrep, Corp_Num, CORP_SEQNUM), Corp_Num);
		
		Layout_Joined  joinJ2(Layout_Joined l, Layout_Cpaqrep_extended r) := transform
		   self.CORP_NAME_CONT    := r.CORP_NAME_CONT;
		   self.CORP_NAME_CONT_2  := r.CORP_NAME_CONT_2;
		   self.CORP_NAME_CONT_3  := r.CORP_NAME_CONT_3;
		   self                   := l;
		   self                   := [];
		end;
		
		J2 := join (J1, dedup_denorm_Cpagrep, trim(left.Corp_Number, left, right) = trim(right.CORP_NUM, left, right), 
		            joinJ2(left, right), left outer);
		
		Layout_J_Cpbcrep_Cpaerep  joinJ3(Layouts_Raw_Input.Cpbcrep l, Layouts_Raw_Input.Cpaerep r) := transform
		   self.CN_Cur_Pre   := r.CN_Cur_Pre;
		   self.CN_File_Date := r.CN_File_Date;	     
		   self              := l;
		end;
		
		J3 := join (Files_Raw_Input.VendorCpbcrep(filedate), Files_Raw_Input.VendorCpaerep(filedate), trim(left.PNNumber,left,right) = trim(right.CNNumber,left,right), 
		            joinJ3(left, right), left outer);
	
		Layout_Joined  joinJ4(Layout_Joined l, Layout_J_Cpbcrep_Cpaerep r) := transform
		   self.PNCORPNAME   := r.PNCORPNAME;
		   self.CN_Cur_Pre   := r.CN_Cur_Pre;
		   self.CN_File_Date := r.CN_File_Date;
		   self              := l;
		   self              := [];
		end;
		
		J4 := join (J2, J3, trim(left.Corp_Number,left,right) = trim(right.PNNUMBER,left,right), 
		            joinJ4(left, right), left outer);
		
		
		// deduping on the record.
		deduped_Joined_recs := dedup(sort(J4, record), record);
		
		Layout_Norm := record
		  Layout_Joined;
		  string1 Rec_Norm := '';
		end;
		
		Layout_Norm  normPNCORPNAME(Layout_Joined l, unsigned c ) := transform
		   self.Rec_Norm  := choose(c, '', 'Y');
		   self.Corp_Name := choose(c, l.Corp_Name, l.PNCORPNAME);
		   self           := l;
		end;
		
		// normalize the file for PNCORPNAME.
		norm_recs := normalize(deduped_Joined_recs,  
		                       if((trim(left.Corp_Name,left, right)  <> trim(left.PNCORPNAME, left, right) and
							       trim(left.PNCORPNAME,left, right) <> ''), 2, 1),
							   normPNCORPNAME(left, counter)
							  );
							  
		//******* translations starts ***********
		
		Layout_translation := record
		   Layout_Norm;
		   string60  corp_status_desc := '';
		   string60  corp_orig_org_structure_desc := '';
		   string3   corp_country_code := '';
		   string60  corp_country_desc := '';
		end;
		
		
		Layout_translation  getCorpStatus(Layout_Norm l, Layouts_Raw_Input.Cpakrep r) := transform
		   self.corp_country_code := if (stringlib.StringToUpperCase(trim(l.State_Country,left,right)) <> 'KS' and
									     length(stringlib.StringToUpperCase(trim(l.State_Country,left,right))) = 2, 
									     stringlib.StringToUpperCase(trim(l.State_Country,left,right)), 
									     if (stringlib.StringToUpperCase(trim(l.State_Country,left,right)) = '' or
										     length(stringlib.StringToUpperCase(trim(l.State_Country,left,right))) > 2,
										     stringlib.StringToUpperCase(trim(l.Country,left,right)), '')
									    );
		   self.corp_status_desc  := stringlib.StringToUpperCase(trim(r.Long_Desc,left,right));
		   self                   := l;
		end;
		
		// Join to get the translation for Corp_status code
		T1 := join(norm_recs, Files_Raw_Input.VendorCpakrep(filedate), 
		           stringlib.StringToUpperCase(trim(left.Corp_Stat,left,right)) = stringlib.StringToUpperCase(trim(right.Corp_Stat_Code,left,right)),
		           getCorpStatus(left, right), left outer, lookup);
		
		
		Layout_translation  getCorpType(Layout_translation l, Layouts_Raw_Input.Crptyp r) := transform
		   self.corp_orig_org_structure_desc := stringlib.StringToUpperCase(trim(r.Corp_typ_desc,left,right));
		   self                              := l;
		end;
		
		// Join to get the translation for Corporation_type code
		T2 := join(T1, Files_Raw_Input.VendorCrptyp(filedate), 
		           stringlib.StringToUpperCase(trim(left.Corporation_Type,left,right)) = stringlib.StringToUpperCase(trim(right.Corporation_Type,left,right)),
		           getCorpType(left, right), left outer, lookup);
				   
				   
		Layout_translation  getCountry(Layout_translation l, Layouts_Raw_Input.Cpanrep r) := transform
		   self.corp_country_desc := stringlib.StringToUpperCase(trim(r.Name,left,right));
		   self                   := l;
		end;
		
		// Join to get the translation for Country code
		T3 := join(T2, Files_Raw_Input.VendorCpanrep(filedate), 
		           stringlib.StringToUpperCase(trim(left.corp_country_code,left,right)) = stringlib.StringToUpperCase(trim(right.Code,left,right)),
		           getCountry(left, right), left outer, lookup);
		
		
		
		//******* translations ends *************
		
		//************************************** CORP ***********************************************
		Corp2.Layout_Corporate_Direct_Corp_In  trfCleanCorp(Layout_translation l) := transform		
			string73 tempname 					:= stringlib.StringToUpperCase(if(trim(l.RANAME,left,right) = '', 
			                                                                      '', Address.CleanPerson73(trim(l.RANAME,left,right))));
			pname 								:= Address.CleanNameFields(tempName);
			cname 								:= DataLib.companyclean(stringlib.StringToUpperCase(trim(l.RANAME,left,right)));
			keepPerson 							:= corp2.Rewrite_Common.IsPerson(trim(l.RANAME));
			keepBusiness 						:= corp2.Rewrite_Common.IsCompany(trim(l.RANAME));
			
			self.corp_ra_title1					:= if(l.Rec_norm <> 'Y',if(keepPerson, pname.title, ''),'');
			self.corp_ra_fname1 				:= if(l.Rec_norm <> 'Y',if(keepPerson, pname.fname, ''),'');
			self.corp_ra_mname1 				:= if(l.Rec_norm <> 'Y',if(keepPerson, pname.mname, ''),'');
			self.corp_ra_lname1 				:= if(l.Rec_norm <> 'Y',if(keepPerson, pname.lname, ''),'');
			self.corp_ra_name_suffix1 			:= if(l.Rec_norm <> 'Y',if(keepPerson, pname.name_suffix, ''),'');
			self.corp_ra_score1 				:= if(l.Rec_norm <> 'Y',if(keepPerson, pname.name_score, ''),'');
		
			self.corp_ra_cname1 				:= if(l.Rec_norm <> 'Y',if(keepBusiness, cname[1..70],''),'');
			self.corp_ra_cname1_score 			:= if(l.Rec_norm <> 'Y',if(keepBusiness, pname.name_score, ''),'');
			
			string182 clean_address 			:= stringlib.StringToUpperCase(
													 if(trim(l.Address_1,left,right) +
													    trim(l.Address_2,left,right) +
														trim(l.City,left,right)  +
														trim(l.State,left,right) +
														trim(l.Zip,left,right) <> '', 
													    Address.CleanAddress182(trim(trim(l.Address_1,left,right) + ' ' +
																					 trim(l.Address_2,left,right),
																					 left,right
																					 ),
																			    trim(trim(l.City,left,right) + ', ' +
																					 trim(l.State,left,right) + ' ' +
																					 stringlib.stringfilter(l.Zip,'0123456789'),
																					 left,right
																					 )
																			    ),''));			
			
			string182 clean_ra_address 			:= stringlib.StringToUpperCase(
							                         if(trim(l.RAADDR1,left,right) +
													    trim(l.RAADDR2,left,right) +
														trim(l.RACITY,left,right)  +
														trim(l.RASTATE,left,right) +
														trim(l.RAZIP5,left,right) <> '', 
													    Address.CleanAddress182(trim(trim(l.RAADDR1,left,right) + ' ' +
																					 trim(l.RAADDR2,left,right),
																					 left,right
																					 ),
																			    trim(trim(l.RACITY,left,right) + ', ' +
																					 trim(l.RASTATE,left,right) + ' ' +
																					 stringlib.stringfilter(l.RAZIP5,'0123456789') +
																					 stringlib.stringfilter(l.RAZIP4,'0123456789'),
																					 left,right
																					 )
																			    ),''));	
			self.corp_addr1_prim_range    		:= if(l.Rec_norm <> 'Y',clean_address[1..10],'');
			self.corp_addr1_predir 	      		:= if(l.Rec_norm <> 'Y',clean_address[11..12],'');
			self.corp_addr1_prim_name 	  		:= if(l.Rec_norm <> 'Y',clean_address[13..40],'');
			self.corp_addr1_addr_suffix   		:= if(l.Rec_norm <> 'Y',clean_address[41..44],'');
			self.corp_addr1_postdir 	    	:= if(l.Rec_norm <> 'Y',clean_address[45..46],'');
			self.corp_addr1_unit_desig 	  		:= if(l.Rec_norm <> 'Y',clean_address[47..56],'');
			self.corp_addr1_sec_range 	  		:= if(l.Rec_norm <> 'Y',clean_address[57..64],'');
			self.corp_addr1_p_city_name	  		:= if(l.Rec_norm <> 'Y',clean_address[65..89],'');
			self.corp_addr1_v_city_name	  		:= if(l.Rec_norm <> 'Y',clean_address[90..114],'');
			self.corp_addr1_state 			    := if(l.Rec_norm <> 'Y',clean_address[115..116],'');
			self.corp_addr1_zip5 		      	:= if(l.Rec_norm <> 'Y',clean_address[117..121],'');
			self.corp_addr1_zip4 		      	:= if(l.Rec_norm <> 'Y',clean_address[122..125],'');
			self.corp_addr1_cart 		      	:= if(l.Rec_norm <> 'Y',clean_address[126..129],'');
			self.corp_addr1_cr_sort_sz 	 		:= if(l.Rec_norm <> 'Y',clean_address[130],'');
			self.corp_addr1_lot 		    	:= if(l.Rec_norm <> 'Y',clean_address[131..134],'');
			self.corp_addr1_lot_order 	  		:= if(l.Rec_norm <> 'Y',clean_address[135],'');
			self.corp_addr1_dpbc 		    	:= if(l.Rec_norm <> 'Y',clean_address[136..137],'');
			self.corp_addr1_chk_digit 	  		:= if(l.Rec_norm <> 'Y',clean_address[138],'');
			self.corp_addr1_rec_type			:= if(l.Rec_norm <> 'Y',clean_address[139..140],'');
			self.corp_addr1_ace_fips_st	  		:= if(l.Rec_norm <> 'Y',clean_address[141..142],'');
			self.corp_addr1_county 	  			:= if(l.Rec_norm <> 'Y',clean_address[143..145],'');
			self.corp_addr1_geo_lat 	    	:= if(l.Rec_norm <> 'Y',clean_address[146..155],'');
			self.corp_addr1_geo_long 	    	:= if(l.Rec_norm <> 'Y',clean_address[156..166],'');
			self.corp_addr1_msa 		    	:= if(l.Rec_norm <> 'Y',clean_address[167..170],'');
			self.corp_addr1_geo_blk				:= if(l.Rec_norm <> 'Y',clean_address[171..177],'');
			self.corp_addr1_geo_match 	  		:= if(l.Rec_norm <> 'Y',clean_address[178],'');
			self.corp_addr1_err_stat 	    	:= if(l.Rec_norm <> 'Y',clean_address[179..182],'');
																				
			self.corp_ra_prim_range    			:= if(l.Rec_norm <> 'Y',clean_ra_address[1..10],'');
			self.corp_ra_predir 	      		:= if(l.Rec_norm <> 'Y',clean_ra_address[11..12],'');
			self.corp_ra_prim_name 	  			:= if(l.Rec_norm <> 'Y',clean_ra_address[13..40],'');
			self.corp_ra_addr_suffix   			:= if(l.Rec_norm <> 'Y',clean_ra_address[41..44],'');
			self.corp_ra_postdir 	    		:= if(l.Rec_norm <> 'Y',clean_ra_address[45..46],'');
			self.corp_ra_unit_desig 	  		:= if(l.Rec_norm <> 'Y',clean_ra_address[47..56],'');
			self.corp_ra_sec_range 	  			:= if(l.Rec_norm <> 'Y',clean_ra_address[57..64],'');
			self.corp_ra_p_city_name	  		:= if(l.Rec_norm <> 'Y',clean_ra_address[65..89],'');
			self.corp_ra_v_city_name	  		:= if(l.Rec_norm <> 'Y',clean_ra_address[90..114],'');
			self.corp_ra_state 			      	:= if(l.Rec_norm <> 'Y',clean_ra_address[115..116],'');
			self.corp_ra_zip5 		      		:= if(l.Rec_norm <> 'Y',clean_ra_address[117..121],'');
			self.corp_ra_zip4 		      		:= if(l.Rec_norm <> 'Y',clean_ra_address[122..125],'');
			self.corp_ra_cart 		      		:= if(l.Rec_norm <> 'Y',clean_ra_address[126..129],'');
			self.corp_ra_cr_sort_sz 	 		:= if(l.Rec_norm <> 'Y',clean_ra_address[130],'');
			self.corp_ra_lot 		      		:= if(l.Rec_norm <> 'Y',clean_ra_address[131..134],'');
			self.corp_ra_lot_order 	  			:= if(l.Rec_norm <> 'Y',clean_ra_address[135],'');
			self.corp_ra_dpbc 		      		:= if(l.Rec_norm <> 'Y',clean_ra_address[136..137],'');
			self.corp_ra_chk_digit 	  			:= if(l.Rec_norm <> 'Y',clean_ra_address[138],'');
			self.corp_ra_rec_type		  		:= if(l.Rec_norm <> 'Y',clean_ra_address[139..140],'');
			self.corp_ra_ace_fips_st	  		:= if(l.Rec_norm <> 'Y',clean_ra_address[141..142],'');
			self.corp_ra_county 	  			:= if(l.Rec_norm <> 'Y',clean_ra_address[143..145],'');
			self.corp_ra_geo_lat 	    		:= if(l.Rec_norm <> 'Y',clean_ra_address[146..155],'');
			self.corp_ra_geo_long 	    		:= if(l.Rec_norm <> 'Y',clean_ra_address[156..166],'');
			self.corp_ra_msa 		      		:= if(l.Rec_norm <> 'Y',clean_ra_address[167..170],'');
			self.corp_ra_geo_blk				:= if(l.Rec_norm <> 'Y',clean_ra_address[171..177],'');
			self.corp_ra_geo_match 	  			:= if(l.Rec_norm <> 'Y',clean_ra_address[178],'');
			self.corp_ra_err_stat 	    		:= if(l.Rec_norm <> 'Y',clean_ra_address[179..182],'');
			
			self.dt_first_seen					:= fileDate;
			self.dt_last_seen					:= fileDate;
			self.dt_vendor_first_reported		:= fileDate;
			self.dt_vendor_last_reported		:= fileDate;
			self.corp_ra_dt_first_seen			:= fileDate;
			self.corp_ra_dt_last_seen			:= fileDate;
			
			self.corp_key						:= '20-' + stringlib.StringToUpperCase(trim(l.Corp_Number, left, right));
			self.corp_vendor					:= '20';
			self.corp_state_origin				:= 'KS';
			self.corp_process_date				:= fileDate;
			self.corp_orig_sos_charter_nbr		:= stringlib.StringToUpperCase(trim(l.Corp_Number, left, right));
			self.corp_src_type					:= 'SOS';
									
			self.corp_address1_type_cd          := if(l.Rec_norm <> 'Y',
			                                          if (trim(clean_address,left,right) <> '', 'B',''),'');
			self.corp_address1_type_desc        := if(l.Rec_norm <> 'Y',
			                                          if (trim(clean_address,left,right) <> '','BUSINESS',''),'');
			self.corp_address1_line1            := if(l.Rec_norm <> 'Y',stringlib.StringToUpperCase(trim(l.Attn_Line,left,right)),'');
			self.corp_address1_line2            := if(l.Rec_norm <> 'Y',stringlib.StringToUpperCase(trim(l.Address_1,left,right)),'');
			self.corp_address1_line3            := if(l.Rec_norm <> 'Y',stringlib.StringToUpperCase(trim(l.Address_2,left,right)),'');
			self.corp_address1_line4            := if(l.Rec_norm <> 'Y',stringlib.StringToUpperCase(trim(l.City,left,right)),'');
			self.corp_address1_line5            := if(l.Rec_norm <> 'Y',stringlib.StringToUpperCase(trim(l.State,left,right)),'');
			self.corp_address1_line6            := if(l.Rec_norm <> 'Y',stringlib.stringfilter(l.Zip,'0123456789'),'');
			
			self.corp_ra_name                   := if(l.Rec_norm <> 'Y',stringlib.StringToUpperCase(trim(l.RANAME)),'');
			
			self.corp_ra_address_type_cd        := '';
			self.corp_ra_address_type_desc      := if(l.Rec_norm <> 'Y',
													   if (trim(trim(l.RAADDR1,left,right) + 
																trim(l.RAADDR2,left,right) +
																trim(l.RACITY,left,right) +
																trim(l.RASTATE,left,right),left,right) <> '','REGISTERED ADDRESS',''),
													'');
			self.corp_ra_address_line1          := if (l.Rec_norm <> 'Y',stringlib.StringToUpperCase(trim(l.RAADDR1,left,right)),'');
			self.corp_ra_address_line2          := if (l.Rec_norm <> 'Y',stringlib.StringToUpperCase(trim(l.RAADDR2,left,right)),'');
			self.corp_ra_address_line3          := if (l.Rec_norm <> 'Y',stringlib.StringToUpperCase(trim(l.RACITY,left,right)),'');
			self.corp_ra_address_line4          := if (l.Rec_norm <> 'Y',stringlib.StringToUpperCase(trim(l.RASTATE,left,right)),'');
			self.corp_ra_address_line5          := if (l.Rec_norm <> 'Y',
													   stringlib.stringfilter(l.RAZIP5 +
													   if(trim(l.RAZIP4,left,right) = '' or 
														  (integer)trim(l.RAZIP4,left,right) = 0,'',trim(l.RAZIP4,left,right))
													   , '0123456789'),
													   '');
			
			self.corp_legal_name                := stringlib.StringToUpperCase(trim(l.Corp_Name,left, right)) + 
			                                       stringlib.StringToUpperCase(trim(l.Corp_Name_Cont)) +
												   stringlib.StringToUpperCase(trim(l.Corp_Name_Cont_2)) +
												   stringlib.StringToUpperCase(trim(l.Corp_Name_Cont_3));
			self.corp_ln_name_type_cd           := if (l.Rec_norm <> 'Y','01','P');
			self.corp_ln_name_type_desc         := if (l.Rec_norm <> 'Y','LEGAL','PRIOR');

			self.corp_status_cd					:= if (l.Rec_norm <> 'Y',stringlib.StringToUpperCase(trim(l.Corp_Stat, left, right)),'');
			self.corp_status_desc				:= if (l.Rec_norm <> 'Y',l.corp_status_desc,'');
			
			self.corp_orig_org_structure_cd     := if (l.Rec_norm <> 'Y',stringlib.StringToUpperCase(trim(l.Corporation_Type, left, right)),'');
			self.corp_orig_org_structure_desc   := if (l.Rec_norm <> 'Y',l.corp_orig_org_structure_desc,'');
			
			self.corp_orig_bus_type_cd          := if (l.Rec_norm <> 'Y',stringlib.StringToUpperCase(trim(l.Close_Corp)),'');
			self.corp_orig_bus_type_desc        := if (l.Rec_norm <> 'Y',
			                                          if (stringlib.StringToUpperCase(trim(l.Close_Corp)) = 'Y', 'CLOSE CORPORATION','')
													  ,'');

            self.corp_inc_state                 := if (l.Rec_norm <> 'Y',
			                                          if (stringlib.StringToUpperCase(trim(l.State_Country,left,right)) = self.corp_state_origin, 
													      self.corp_state_origin, ''),
													  '');
			
			self.corp_inc_date                  := if (l.Rec_norm <> 'Y',
													   if (stringlib.StringToUpperCase(trim(l.State_Country,left,right)) = self.corp_state_origin, 
														   stringlib.stringfilter(l.Date_of_Incorp, '0123456789'), '')
													  ,'');
			
			self.corp_fed_tax_id                := if (l.Rec_norm <> 'Y',
													   if ((integer)trim(l.FEIN,left,right) <> 0, trim(l.FEIN,left,right),''),'');
			
			self.corp_forgn_date                := if (l.Rec_norm <> 'Y',
													   if (stringlib.StringToUpperCase(trim(l.State_Country,left,right)) <> self.corp_state_origin, 
														   stringlib.stringfilter(l.Date_of_Incorp, '0123456789'), '')
													  ,'');
													   
			self.corp_forgn_state_cd            := if (l.Rec_norm <> 'Y',
			                                           if (l.corp_country_code in ['US', 'USA'], '', l.corp_country_code)
													  ,'');
			self.corp_forgn_state_desc          := if (l.Rec_norm <> 'Y',
			                                           if (l.corp_country_code in ['US', 'USA'], '', l.corp_country_desc),'');
			
			self.corp_filing_date               := if (l.Rec_norm = 'Y',
													   if (stringlib.StringToUpperCase(trim(l.CN_Cur_Pre,left,right)) = 'V',
														   if(_validate.date.fIsValid(trim(l.CN_File_Date,left,right)) and													   
															  _validate.date.fIsValid(trim(l.CN_File_Date,left,right),_validate.date.rules.DateInPast),
															  trim(l.CN_File_Date,left,right),''), '')
													   ,'');
													   
			self.corp_term_exist_exp            := if (l.Rec_norm <> 'Y',
													   if ((integer)stringlib.stringfilter(l.Expiration_Date, '0123456789') <> 0, 
														   if(_validate.date.fIsValid(stringlib.stringfilter(l.Expiration_Date, '0123456789')),
															  stringlib.stringfilter(l.Expiration_Date, '0123456789'),''), '')
													   ,'');
			
			self.corp_term_exist_cd             := if (l.Rec_norm <> 'Y',
													   if (trim(l.Expiration_Date, left,right)[1..4] = '9999', 'P',
														   if (self.corp_term_exist_exp <> '', 'D', ''))
													   ,'');
			
			self.corp_term_exist_desc           := if (l.Rec_norm <> 'Y',
													   map(self.corp_term_exist_cd = 'D' => 'EXPIRATION DATE',
														   self.corp_term_exist_cd = 'P' => 'PERPETUAL',
														   ''
														  )
													   ,'');
		
			dt_forfeiture                       := if (l.Rec_norm <> 'Y',
													   if (trim(l.Forfeiture_Date,left,right) = '' or 
														   (integer) trim(l.Forfeiture_Date,left,right) = 0, '', trim(l.Forfeiture_Date,left,right))
													   ,'');
			
			self.corp_addl_info                 := if (l.Rec_norm <> 'Y',
													   if (_validate.date.fIsValid(dt_forfeiture), 
														   'FORFEITURE DATE: ' + dt_forfeiture[5..6] + '/' + dt_forfeiture[7..8] + '/' + dt_forfeiture[1..4], 
														   ''
														  )
													  ,'');

			self								:= l;
			self 								:= [];
		end;
		
		MapCleanCorp := project(T3, trfCleanCorp(left));
		
		//************************************** End ***********************************************
		//************************************** STOCK *********************************************
		Corp2.Layout_Corporate_Direct_Stock_In trfStock(Layout_Norm l) := transform, skip ((integer) l.Stock_Issued < 1)

			self.corp_key						:= '20-' + stringlib.StringToUpperCase(trim(l.Corp_Number, left, right));		
			self.corp_vendor					:= '20';		
			self.corp_state_origin				:= 'KS';
			self.corp_process_date				:= fileDate;

			self.corp_sos_charter_nbr			:= stringlib.StringToUpperCase(trim(l.Corp_Number, left, right));
			self.stock_shares_issued			:= (string)(integer)trim(l.Stock_Issued, left, right);
			self								:= [];
		end;
		
		MapStock := project(norm_recs, trfStock(left));
		
		//************************************** End ***********************************************
		//************************************** ANNUAL REPORT *************************************
		Corp2.Layout_Corporate_Direct_AR_In trfAnnualReport(Layouts_Raw_Input.Cpahst  l) := transform 
		
			self.corp_key						:= '20-' + stringlib.StringToUpperCase(trim(l.Corp_Number, left, right));		
			self.corp_vendor					:= '20';		
			self.corp_state_origin				:= 'KS';
			self.corp_process_date				:= filedate;
			
			self.corp_sos_charter_nbr			:= stringlib.StringToUpperCase(trim(l.Corp_Number, left, right));

			self.ar_filed_dt					:= if (trim(l.Filing_AR_Date,left,right) <> '' and
														_validate.date.fIsValid(trim(l.Filing_AR_Date,left,right)) and
														_validate.date.fIsValid(trim(l.Filing_AR_Date,left,right),_validate.date.rules.DateInPast),
														trim(l.Filing_AR_Date,left,right),'');  

            self.ar_roll                        := if (trim(l.Microfilm_Roll, left, right) <> '', (string)(integer)trim(l.Microfilm_Roll, left, right), '');
			self.ar_frame                       := if (trim(l.Microfilm_Frame, left, right) <> '', (string)(integer)trim(l.Microfilm_Frame, left, right), '');
			
			self.ar_comment						:= if (trim(l.Number_Of_Pages, left, right) <> '' and (integer)trim(l.Number_Of_Pages) <> 0, 
			                                          'NUMBER OF PAGES: ' + (string)(integer)trim(l.Number_Of_Pages, left, right), '');		
			self								:= [];
		end;
		
		MapAR := project(Files_Raw_Input.VendorCpahst(filedate), trfAnnualReport(left));
		
		//************************************** End ***********************************************
	VersionControl.macBuildNewLogicalFile(Constants.cluster + 'in::corp2::'+version+'::corp_ks'	,MapCleanCorp	,corp_out		,,,pOverwrite);		
	VersionControl.macBuildNewLogicalFile(Constants.cluster + 'in::corp2::'+version+'::stock_ks',MapStock			,stock_out	,,,pOverwrite);
	VersionControl.macBuildNewLogicalFile(Constants.cluster + 'in::corp2::'+version+'::ar_ks'		,MapAR				,ar_out			,,,pOverwrite);
	                                                                                                                                                        
		Map_KS_As_Corp := parallel (
			 corp_out	
			,stock_out
			,ar_out		
		);
		
		result := 
		sequential(
			 if(pshouldspray = true,fSprayFiles('ks',filedate,pOverwrite := pOverwrite, pShouldSprayZeroByteFiles := true))
			,Map_KS_As_Corp
			,parallel(
				 fileservices.addsuperfile(Constants.cluster + 'in::corp2::sprayed::corp'	,Constants.cluster + 'in::corp2::'+version+'::corp_ks')
				,fileservices.addsuperfile(Constants.cluster + 'in::corp2::sprayed::stock',Constants.cluster + 'in::corp2::'+version+'::stock_ks')
				,fileservices.addsuperfile(Constants.cluster + 'in::corp2::sprayed::ar'		,Constants.cluster + 'in::corp2::'+version+'::ar_ks')										
			)
		);
 		
		return result;
	
	end;
end;