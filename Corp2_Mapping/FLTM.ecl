import ut, lib_stringlib, _validate, Address, corp2, corp2_mapping, lib_datalib, _control, versioncontrol;

export FLTM := MODULE;
	
	export Layouts_Raw_Input := MODULE;

		export TMFile := record
			string012 TM_NUMBER;
			string001 TM_CLASS_TYPE_01; 
			string004 TM_CLASS_01;
			string001 TM_CLASS_TYPE_02; 
			string004 TM_CLASS_02;
			string001 TM_CLASS_TYPE_03; 
			string004 TM_CLASS_03;
			string001 TM_CLASS_TYPE_04; 
			string004 TM_CLASS_04;
			string001 TM_CLASS_TYPE_05; 
			string004 TM_CLASS_05;
			string001 TM_CLASS_TYPE_06; 
			string004 TM_CLASS_06;
			string001 TM_CLASS_TYPE_07; 
			string004 TM_CLASS_07;
			string001 TM_CLASS_TYPE_08; 
			string004 TM_CLASS_08;
			string001 TM_CLASS_TYPE_09; 
			string004 TM_CLASS_09;
			string001 TM_CLASS_TYPE_10; 
			string004 TM_CLASS_10;
			string001 TM_CLASS_TYPE_11; 
			string004 TM_CLASS_11;
			string001 TM_CLASS_TYPE_12; 
			string004 TM_CLASS_12;
			string001 TM_CLASS_TYPE_13; 
			string004 TM_CLASS_13;
			string001 TM_CLASS_TYPE_14; 
			string004 TM_CLASS_14;
			string001 TM_CLASS_TYPE_15; 
			string004 TM_CLASS_15;
			string001 TM_CLASS_TYPE_16; 
			string004 TM_CLASS_16;
			string001 TM_CLASS_TYPE_17; 
			string004 TM_CLASS_17;
			string001 TM_CLASS_TYPE_18; 
			string004 TM_CLASS_18;
			string001 TM_CLASS_TYPE_19; 
			string004 TM_CLASS_19;
			string001 TM_CLASS_TYPE_20; 
			string004 TM_CLASS_20;
			string001 TM_STATUS;
			string042 TM_DISCLAIMER_1;
			string042 TM_DISCLAIMER_2;
			string050 TM_USED_1;
			string050 TM_USED_2;
			string008 TM_EP_DATE;
			string008 TM_DATE_FILED;
			string008 TM_1ST_DATE;
			string008 TM_1ST_FLA_DATE;
			string005 TM_TRADE_SEQ;
			string005 TM_PRINCE_SEQ;
			string012 TM_PRINCE_DOC_NUMBER_01;
			string042 TM_PRINCE_NAME_01;
			string042 TM_PRINCE_MAIL_ADD1_01;
			string042 TM_PRINCE_MAIL_ADD2_01;
			string028 TM_PRINCE_MAIL_CITY_01;
			string002 TM_PRINCE_MAIL_STATE_01;
			string010 TM_PRINCE_MAIL_ZIP_01;
			string002 TM_PRINCE_MAIL_COUNTRY_01;
			string012 TM_PRINCE_DOC_NUMBER_02;
			string042 TM_PRINCE_NAME_02;
			string042 TM_PRINCE_MAIL_ADD1_02;
			string042 TM_PRINCE_MAIL_ADD2_02;
			string028 TM_PRINCE_MAIL_CITY_02;
			string002 TM_PRINCE_MAIL_STATE_02;
			string010 TM_PRINCE_MAIL_ZIP_02;
			string002 TM_PRINCE_MAIL_COUNTRY_02;
			string012 TM_PRINCE_DOC_NUMBER_03;
			string042 TM_PRINCE_NAME_03;
			string042 TM_PRINCE_MAIL_ADD1_03;
			string042 TM_PRINCE_MAIL_ADD2_03;
			string028 TM_PRINCE_MAIL_CITY_03;
			string002 TM_PRINCE_MAIL_STATE_03;
			string010 TM_PRINCE_MAIL_ZIP_03;
			string002 TM_PRINCE_MAIL_COUNTRY_03;
			string012 TM_PRINCE_DOC_NUMBER_04;
			string042 TM_PRINCE_NAME_04;
			string042 TM_PRINCE_MAIL_ADD1_04;
			string042 TM_PRINCE_MAIL_ADD2_04;
			string028 TM_PRINCE_MAIL_CITY_04;
			string002 TM_PRINCE_MAIL_STATE_04;
			string010 TM_PRINCE_MAIL_ZIP_04;
			string002 TM_PRINCE_MAIL_COUNTRY_04;
			string012 TM_PRINCE_DOC_NUMBER_05;
			string042 TM_PRINCE_NAME_05;
			string042 TM_PRINCE_MAIL_ADD1_05;
			string042 TM_PRINCE_MAIL_ADD2_05;
			string028 TM_PRINCE_MAIL_CITY_05;
			string002 TM_PRINCE_MAIL_STATE_05;
			string010 TM_PRINCE_MAIL_ZIP_05;
			string002 TM_PRINCE_MAIL_COUNTRY_05;
			string012 TM_PRINCE_DOC_NUMBER_06;
			string042 TM_PRINCE_NAME_06;
			string042 TM_PRINCE_MAIL_ADD1_06;
			string042 TM_PRINCE_MAIL_ADD2_06;
			string028 TM_PRINCE_MAIL_CITY_06;
			string002 TM_PRINCE_MAIL_STATE_06;
			string010 TM_PRINCE_MAIL_ZIP_06;
			string002 TM_PRINCE_MAIL_COUNTRY_06;
			string005 TM_NUMBER_NAME;
			string192 TM_NAME;
			string005 TM_EVENT_SEQ;
			string020 TM_LAST_EVENT_CODE;
			string008 TM_LAST_EVENT_EFT_DATE;
			string008 TM_LAST_EVENT_FILED_DATE;
			string005 TM_XREF_SEQ;
			string192 TM_X_NAME;
			string050 TM_USED_3;
			string002 crlf;
			end;		
			
	end; // end of Layouts_Raw_Input module
	
	export Files_Raw_Input := MODULE;
	
		export tmFile(string FileDate)		:= distribute(dataset('~thor_data400::in::corp2::'+filedate+'::tmfile::fltm',	
																	   layouts_Raw_Input.TMFile,FLAT),hash32(tm_number));																	            
	end;

	
	export Update(string fileDate,string version, boolean pShouldSpray = _Dataset().bShouldSpray, boolean pOverwrite = false) := function			
		
		trimUpper(string s) := function
			return trim(stringlib.StringToUppercase(s),left,right);
			end;					
			
		getEventType(string evt) := function
		    eventType := case(trimUpper(evt),								
							'CORAMCANNP' =>	'CANCELLATION NON PAYMENT',									
							'CORAMEXP'   =>	'EXPIRATION',								
							'CORAPAMND'  =>	'AMENDMENT',									
							'CORAPCANTM' =>	'TRADEMARK CANCELLATION',									
							'CORAPTMASG' =>	'TRADEMARK ASSIGNMENT',	
							'CORAPTMONC' =>	'TRADEMARK OWNER NAME CHANGE',
							'CORAPTMREN' =>	'TRADEMARK RENEWAL',								
							'');
			return(eventType);
			end;
				
		getTypeClass(string typeIn, string classIn) := function	
	        thisType := case(typeIn,
			                 '1' => if(trim(classIn,left,right)<>'','TM-',''),
							 '2' => if(trim(classIn,left,right)<>'','SM-',''),
							 '');
							 
		    typeClass := if((typeIn in ['1','2']) and (trim(classIn,left,right)<>''),
						    thisType + classIn + ', ',
							'');
			return(typeClass);
			end;
				
			
		//---------------------- Code to normalize the Ann input file to separate Principals ----------------	
		
		normalizedPrince := record
			string012 TM_NUMBER;
			string192 TM_NAME;
			string042 TM_PRINCE_NAME;
			string042 TM_PRINCE_MAIL_ADD1;
			string042 TM_PRINCE_MAIL_ADD2;
			string028 TM_PRINCE_MAIL_CITY;
			string002 TM_PRINCE_MAIL_STATE;
			string010 TM_PRINCE_MAIL_ZIP;
			string002 TM_PRINCE_MAIL_COUNTRY;						
			end;						

		normalizedPrince normalizePrince(Layouts_Raw_Input.TMFile l, unsigned1 cnt) := transform		 
			self.TM_PRINCE_NAME	    		:= choose(cnt,
												  l.TM_PRINCE_NAME_01,
												  l.TM_PRINCE_NAME_02,
												  l.TM_PRINCE_NAME_03,
												  l.TM_PRINCE_NAME_04,
												  l.TM_PRINCE_NAME_05,
												  l.TM_PRINCE_NAME_06);
			self.TM_PRINCE_MAIL_ADD1   		:= choose(cnt,
												  l.TM_PRINCE_MAIL_ADD1_01,
												  l.TM_PRINCE_MAIL_ADD1_02,
												  l.TM_PRINCE_MAIL_ADD1_03,
												  l.TM_PRINCE_MAIL_ADD1_04,
												  l.TM_PRINCE_MAIL_ADD1_05,
												  l.TM_PRINCE_MAIL_ADD1_06);
			self.TM_PRINCE_MAIL_ADD2		:= choose(cnt,
												  l.TM_PRINCE_MAIL_ADD2_01,
												  l.TM_PRINCE_MAIL_ADD2_02,
												  l.TM_PRINCE_MAIL_ADD2_03,
												  l.TM_PRINCE_MAIL_ADD2_04,
												  l.TM_PRINCE_MAIL_ADD2_05,
												  l.TM_PRINCE_MAIL_ADD2_06);
			self.TM_PRINCE_MAIL_CITY		:= choose(cnt,
												  l.TM_PRINCE_MAIL_CITY_01,
												  l.TM_PRINCE_MAIL_CITY_02,
												  l.TM_PRINCE_MAIL_CITY_03,
												  l.TM_PRINCE_MAIL_CITY_04,
												  l.TM_PRINCE_MAIL_CITY_05,
												  l.TM_PRINCE_MAIL_CITY_06);
			self.TM_PRINCE_MAIL_STATE		:= choose(cnt,
												  l.TM_PRINCE_MAIL_STATE_01,
												  l.TM_PRINCE_MAIL_STATE_02,
												  l.TM_PRINCE_MAIL_STATE_03,
												  l.TM_PRINCE_MAIL_STATE_04,
												  l.TM_PRINCE_MAIL_STATE_05,
												  l.TM_PRINCE_MAIL_STATE_06);	
			self.TM_PRINCE_MAIL_ZIP			:= choose(cnt,
												  l.TM_PRINCE_MAIL_ZIP_01,
												  l.TM_PRINCE_MAIL_ZIP_02,
												  l.TM_PRINCE_MAIL_ZIP_03,
												  l.TM_PRINCE_MAIL_ZIP_04,
												  l.TM_PRINCE_MAIL_ZIP_05,
												  l.TM_PRINCE_MAIL_ZIP_06);
			self.TM_PRINCE_MAIL_COUNTRY		:= choose(cnt,
												  l.TM_PRINCE_MAIL_COUNTRY_01,
												  l.TM_PRINCE_MAIL_COUNTRY_02,
												  l.TM_PRINCE_MAIL_COUNTRY_03,
												  l.TM_PRINCE_MAIL_COUNTRY_04,
												  l.TM_PRINCE_MAIL_COUNTRY_05,
												  l.TM_PRINCE_MAIL_COUNTRY_06);																			  		
			self 							:= l;
			end;
		
		NormalizedPrinceInput	:= normalize(Files_Raw_Input.tmFile(fileDate), 6, normalizePrince(left, counter));
	       		
			
				
		Corp2.Layout_Corporate_Direct_Corp_In corpTransform1(Layouts_Raw_Input.TMFile input) := transform,
											SKIP(trimUpper(input.tm_number)='')

			self.dt_first_seen					:= fileDate;
			self.dt_last_seen					:= fileDate;
			self.dt_vendor_first_reported		:= fileDate;
			self.dt_vendor_last_reported		:= fileDate;				
			self.corp_key						:= '12-' + trimUpper(input.tm_number);
			self.corp_vendor					:= '12';
			self.corp_state_origin				:= 'FL';
			self.corp_process_date				:= fileDate;
		 	self.corp_orig_sos_charter_nbr		:= trimUpper(input.tm_number);
			self.corp_src_type					:= 'SOS';	
			self.corp_ln_name_type_cd			:= '03';
			self.corp_ln_name_type_desc			:= 'TRADEMARK';
			self.corp_legal_name 				:= trimUpper(input.tm_name);
			ct01                                := getTypeClass(input.tm_class_type_01,input.tm_class_01);													      
			ct02                                := getTypeClass(input.tm_class_type_02,input.tm_class_02);
			ct03                                := getTypeClass(input.tm_class_type_03,input.tm_class_03);
			ct04                                := getTypeClass(input.tm_class_type_04,input.tm_class_04);
			ct05                                := getTypeClass(input.tm_class_type_05,input.tm_class_05);
			ct06                                := getTypeClass(input.tm_class_type_06,input.tm_class_06);
			ct07                                := getTypeClass(input.tm_class_type_07,input.tm_class_07);
	 		ct08                                := getTypeClass(input.tm_class_type_08,input.tm_class_08);
			ct09                                := getTypeClass(input.tm_class_type_09,input.tm_class_09);
			ct10                                := getTypeClass(input.tm_class_type_10,input.tm_class_10);
			ct11                                := getTypeClass(input.tm_class_type_11,input.tm_class_11);
			ct12                                := getTypeClass(input.tm_class_type_12,input.tm_class_12);
			ct13                                := getTypeClass(input.tm_class_type_13,input.tm_class_13);
			ct14                                := getTypeClass(input.tm_class_type_14,input.tm_class_14);
			ct15                                := getTypeClass(input.tm_class_type_15,input.tm_class_15);
			ct16                                := getTypeClass(input.tm_class_type_16,input.tm_class_16);
			ct17                                := getTypeClass(input.tm_class_type_17,input.tm_class_17);
			ct18                                := getTypeClass(input.tm_class_type_18,input.tm_class_18);
			ct19                                := getTypeClass(input.tm_class_type_19,input.tm_class_19);
			ct20                                := getTypeClass(input.tm_class_type_20,input.tm_class_20);			
			allct1 								:= ct01+ct02+ct03+ct04+ct05+
										           ct06+ct07+ct08+ct09+ct10+
												   ct11+ct12+ct13+ct14+ct15+
												   ct16+ct17+ct18+ct19+ct20;												   
			allct2                          	:= if(trim(allct1,left,right)<>'',
													  'TYPE/CLASS: ' + trim(allct1,left,right),
													  '');			                                         
			addl_info1                          := regexreplace(',$',allct2,'');			
			addl_info2                          := if(trimUpper(input.tm_disclaimer_1 +
																input.tm_disclaimer_2)<>'',
													  'DISCLAIMER FOR: ' +
													  trimUpper(input.tm_disclaimer_1 +
																input.tm_disclaimer_2),
													  '');													  
			self.corp_addl_info					:= if(addl_info1<>'' and addl_info2<>'',
			                                          addl_info1 + '; ' +
													  addl_info2,
													  addl_info1 + addl_info2);											
			self.corp_status_cd					:= if(trimUpper(input.tm_status) in ['A','I'],
													  trimUpper(input.tm_status),
													  '');
		 	self.corp_status_desc				:= map(trimUpper(input.tm_status) = 'A' => 'ACTIVE',
													   trimUpper(input.tm_status) = 'I' => 'INACTIVE',														
													   '');														   
			self.corp_entity_desc               := trimUpper(input.tm_used_1) + ' ' +
												   trimUpper(input.tm_used_2) + ' ' +	
												   trimUpper(input.tm_used_3);												   
			newExpireDate      		            := if(stringlib.stringfilter(input.tm_ep_date,'0123456789') != input.tm_ep_date or 
													length(trim(input.tm_ep_date,left,right))!= 8,
													'',			
												    input.tm_ep_date[5..8] + 
				                                    input.tm_ep_date[1..4]);												   
			self.corp_term_exist_cd				:= if(_validate.date.fIsValid(newExpireDate),
														'D',
														'');													  
			self.corp_term_exist_exp			:= if(_validate.date.fIsValid(newExpireDate),
														newExpireDate,
														'');													   														 						
			self.corp_term_exist_desc			:= if(_validate.date.fIsValid(newExpireDate),
														'EXPIRATION DATE',
		 												'');													
            newDateFiled      		            := if(stringlib.stringfilter(input.tm_date_filed,'0123456789') != input.tm_date_filed or 
													length(trim(input.tm_date_filed,left,right))!= 8,
													'',			
												    input.tm_date_filed[5..8] + 
				                                    input.tm_date_filed[1..4]);														
			self.corp_filing_date				:= if(_validate.date.fIsValid(newDateFiled) and
													  _validate.date.fIsValid(newDateFiled,_validate.date.rules.DateInPast),
													    (newDateFiled),
														'');														           			
		 	self.corp_inc_state					:= 'FL';																								   										   			
			self 								:= [];					
			end; 	
		
		Corp2.Layout_Corporate_Direct_Corp_In corpTransform2(Layouts_Raw_Input.TMFile input) := transform,
											SKIP((trimUpper(input.tm_number)='') 
											      OR 
											     (stringlib.stringfilter(input.tm_1st_date,'0123456789') != input.tm_1st_date) 
												  OR 
												 (length(trim(input.tm_1st_date,left,right))!= 8) 
												  OR
												 (_validate.date.fIsValid(input.tm_1st_date[5..8] + 
																		  input.tm_1st_date[1..4])=false) 
												  OR
											     (_validate.date.fIsValid(input.tm_1st_date[5..8] + 
																		  input.tm_1st_date[1..4],
												  _validate.date.rules.DateInPast)=false))												 

			self.dt_first_seen					:= fileDate;
			self.dt_last_seen					:= fileDate;
			self.dt_vendor_first_reported		:= fileDate;
			self.dt_vendor_last_reported		:= fileDate;				
			self.corp_key						:= '12-' + trimUpper(input.tm_number);
			self.corp_vendor					:= '12';
			self.corp_state_origin				:= 'FL';
			self.corp_process_date				:= fileDate;
		 	self.corp_orig_sos_charter_nbr		:= trimUpper(input.tm_number);
			self.corp_src_type					:= 'SOS';													
			self.corp_filing_date				:= input.tm_1st_date[5..8] + 
				                                   input.tm_1st_date[1..4];			
		 	self.corp_filing_desc				:= 'FIRST USED ANYWHERE';											
			self 								:= [];					
			end; 	
			
		Corp2.Layout_Corporate_Direct_Corp_In corpTransform3(Layouts_Raw_Input.TMFile input) := transform,
											SKIP((trimUpper(input.tm_number)='') 
											      OR 
											     (stringlib.stringfilter(input.tm_1st_fla_date,'0123456789') != input.tm_1st_fla_date) 
												  OR 
												 (length(trim(input.tm_1st_fla_date,left,right))!= 8) 
												  OR
												 (_validate.date.fIsValid(input.tm_1st_fla_date[5..8] + 
																		  input.tm_1st_fla_date[1..4])=false) 
												  OR
											     (_validate.date.fIsValid(input.tm_1st_fla_date[5..8] + 
																		  input.tm_1st_fla_date[1..4],
												  _validate.date.rules.DateInPast)=false))												 

			self.dt_first_seen					:= fileDate;
			self.dt_last_seen					:= fileDate;
			self.dt_vendor_first_reported		:= fileDate;
			self.dt_vendor_last_reported		:= fileDate;				
			self.corp_key						:= '12-' + trimUpper(input.tm_number);
			self.corp_vendor					:= '12';
			self.corp_state_origin				:= 'FL';
			self.corp_process_date				:= fileDate;
		 	self.corp_orig_sos_charter_nbr		:= trimUpper(input.tm_number);
			self.corp_src_type					:= 'SOS';													
			self.corp_filing_date				:= input.tm_1st_fla_date[5..8] + 
				                                   input.tm_1st_fla_date[1..4];			
		 	self.corp_filing_desc				:= 'FIRST USED IN FLORIDA';											
			self 								:= [];					
			end;
			
		Corp2.Layout_Corporate_Direct_Corp_In corpTransform4(Layouts_Raw_Input.TMFile input) := transform,
											SKIP((trimUpper(input.tm_number)='') 
											      OR 
											     (trimUpper(input.tm_x_name)='')) 
												 												 
			self.dt_first_seen					:= fileDate;
			self.dt_last_seen					:= fileDate;
			self.dt_vendor_first_reported		:= fileDate;
			self.dt_vendor_last_reported		:= fileDate;				
			self.corp_key						:= '12-' + trimUpper(input.tm_number);
			self.corp_vendor					:= '12';
			self.corp_state_origin				:= 'FL';
			self.corp_process_date				:= fileDate;
		 	self.corp_orig_sos_charter_nbr		:= trimUpper(input.tm_number);
			self.corp_src_type					:= 'SOS';													
			self.corp_ln_name_type_cd			:= 'I';
			self.corp_ln_name_type_desc			:= 'OTHER';
			self.corp_legal_name 				:= trimUpper(input.tm_x_name);										
			self 								:= [];					
			end;
			
		corp2_mapping.Layout_ContPreClean contTransform(normalizedPrince input) := transform,
											SKIP(trimUpper(input.tm_prince_name)='')
			self.dt_first_seen					:=fileDate;
			self.dt_last_seen					:=fileDate;			
			self.corp_key						:= '12-' + trimUpper(input.tm_number);
			self.corp_vendor					:= '12';
			self.corp_state_origin				:= 'FL';
			self.corp_process_date				:= fileDate;
			self.corp_orig_sos_charter_nbr		:= trimUpper(input.tm_number);				
			self.corp_legal_name				:= trimUpper(input.tm_name);			
			self.cont_type_cd					:= 'O';
            self.cont_type_desc					:= 'OWNER';																		
			self.cont_name					    := trimUpper(input.tm_prince_name);																																		  																																																					
			self.cont_address_line1				:= trimUpper(input.tm_prince_mail_add1);
			self.cont_address_line3				:= trimUpper(input.tm_prince_mail_city);
			self.cont_address_line4				:= trimUpper(input.tm_prince_mail_state);																				   
			self.cont_address_line5				:= Stringlib.stringFilter(input.tm_prince_mail_zip,'0123456789');																													
			self.cont_address_line6				:= trimUpper(input.tm_prince_mail_country);													 
			self.cont_address_type_cd           := 'M';
			self.cont_address_type_desc         := 'MAILING';
			self 								:= [];						
			end;											
				
				
		Corp2.Layout_Corporate_Direct_Event_In EventTransform(Layouts_Raw_Input.TMFile input):=transform,
												SKIP(trimUpper(input.tm_last_event_code)='')
			self.corp_key						:= '12-' + trimUpper(input.tm_number);
			self.corp_vendor					:= '12';
			self.corp_state_origin				:= 'FL';
			self.corp_process_date				:= fileDate;
			self.corp_sos_charter_nbr			:= trimUpper(input.tm_number);						
			newFileDate							:= trim(input.tm_last_event_filed_date[5..8] +
												        input.tm_last_event_filed_date[1..4],left,right);
            													     
			self.event_filing_date				:= if(_validate.date.fIsValid(newFileDate) and												    		
													  _validate.date.fIsValid(newFileDate,_validate.date.rules.DateInPast),
														newFileDate,
														'');													   
            self.event_filing_cd                := trimUpper(input.tm_last_event_code);
			self.event_filing_desc				:= getEventType(trimUpper(input.tm_last_event_code));												 				
			self								:= [];
			end;
	
			
			
		Corp2.Layout_Corporate_Direct_Cont_In cleanCont(corp2_mapping.Layout_ContPreClean input) := transform		
			string73 tempname 					:= if(input.cont_name = '', '', Address.CleanPersonFML73(input.cont_name));
			pname 								:= Address.CleanNameFields(tempName);
			cname 								:= DataLib.companyclean(input.cont_name);
			keepPerson 							:= corp2.Rewrite_Common.IsPerson(input.cont_name);
			keepBusiness 						:= corp2.Rewrite_Common.IsCompany(input.cont_name);
			
			self.cont_title1					:= if(keepPerson, pname.title, '');
			self.cont_fname1 					:= if(keepPerson, pname.fname, '');
			self.cont_mname1 					:= if(keepPerson, pname.mname, '');
			self.cont_lname1 					:= if(keepPerson, pname.lname, '');
			self.cont_name_suffix1 				:= if(keepPerson, pname.name_suffix, '');
			self.cont_score1 					:= if(keepPerson, pname.name_score, '');
		
			self.cont_cname1 					:= if(keepBusiness, cname[1..70],'');
			self.cont_cname1_score 				:= if(keepBusiness, pname.name_score, '');
		
			string182 clean_address 			:= Address.CleanAddress182(trim(trim(input.cont_address_line1,left,right) + ' ' +
																				trim(input.cont_address_line2,left,right),
																				left,right),
																				trim(trim(input.cont_address_line3,left,right) + ', ' +
																					 trim(input.cont_address_line4,left,right) + ' ' +
																					 trim(input.cont_address_line5,left,right) + ' ' +
																					 trim(input.cont_address_line6,left,right),
																				left,right
																					)
																			);	
																				
			self.cont_prim_range    			:= clean_address[1..10];
			self.cont_predir 	      			:= clean_address[11..12];
			self.cont_prim_name 	  			:= clean_address[13..40];
			self.cont_addr_suffix   			:= clean_address[41..44];
			self.cont_postdir 	  		  		:= clean_address[45..46];
			self.cont_unit_desig 	  			:= clean_address[47..56];
			self.cont_sec_range 	  			:= clean_address[57..64];
			self.cont_p_city_name	  			:= clean_address[65..89];
			self.cont_v_city_name	 			:= clean_address[90..114];
			self.cont_state 			      	:= clean_address[115..116];
			self.cont_zip5 		      			:= clean_address[117..121];
			self.cont_zip4 		 	     		:= clean_address[122..125];
			self.cont_cart 		    	  		:= clean_address[126..129];
			self.cont_cr_sort_sz 	 			:= clean_address[130];
			self.cont_lot 		      			:= clean_address[131..134];
			self.cont_lot_order 	  			:= clean_address[135];
			self.cont_dpbc 		   		   		:= clean_address[136..137];
			self.cont_chk_digit 	  			:= clean_address[138];
			self.cont_rec_type		  			:= clean_address[139..140];
			self.cont_ace_fips_st	  			:= clean_address[141..142];
			self.cont_county 	 	 			:= clean_address[143..145];
			self.cont_geo_lat 	    			:= clean_address[146..155];
			self.cont_geo_long 	    			:= clean_address[156..166];
			self.cont_msa 		      			:= clean_address[167..170];
			self.cont_geo_blk					:= clean_address[171..177];
			self.cont_geo_match 	  			:= clean_address[178];
			self.cont_err_stat 	    			:= clean_address[179..182];

			self								:= input;
			self 								:= [];
			end;
				
		
		corpMapped1		:= project(Files_Raw_Input.tmFile(fileDate), corpTransform1(left));
		
		corpMapped2		:= project(Files_Raw_Input.tmFile(fileDate), corpTransform2(left));
		
		corpMapped3		:= project(Files_Raw_Input.tmFile(fileDate), corpTransform3(left));
		
		corpMapped4		:= project(Files_Raw_Input.tmFile(fileDate), corpTransform4(left));
		
		allCorp         := sort(distribute(corpMapped1 + corpMapped2 + 
										   corpMapped3 + corpMapped4,hash32(corp_key)),corp_key,local);
		
		contMapped		:= project(NormalizedPrinceInput, contTransform(left));
		
		cleanedCont     := project(contMapped,cleanCont(left));
		
		// eventsMapped	:= project(Files_Raw_Input.tmFile(fileDate), eventTransform(left));										
	VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+version+'::cont_fltm',cleanedCont,cont_out	,,,pOverwrite);		
	VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+version+'::corp_fltm',allCorp		,corp_out	,,,pOverwrite);
	
		mapFLTMFiling := parallel(
			 cont_out		
			,corp_out		
		);
		

		result := 
		sequential(
			 if(pshouldspray = true,fSprayFiles('fltm',filedate,pOverwrite := pOverwrite))
			,mapFLTMFiling
			,parallel(
				 fileservices.addsuperfile('~thor_data400::in::corp2::sprayed::cont','~thor_data400::in::corp2::'+version+'::cont_fltm')
				,fileservices.addsuperfile('~thor_data400::in::corp2::sprayed::corp','~thor_data400::in::corp2::'+version+'::corp_fltm')
			)							
		);

		return result;
	end;					 
	
end; 