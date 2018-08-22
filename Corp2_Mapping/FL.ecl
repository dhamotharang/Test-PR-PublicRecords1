import ut, std, _validate, corp2, corp2_raw_fl, address, scrubs, corp2_mapping, versioncontrol, scrubs_corp2_mapping_fl_main, Scrubs_Corp2_Mapping_FL_Event, tools;
 
export FL := MODULE; 
	
	export Update(string updateType, string fileDate, string version, boolean pShouldSpray = _Dataset().bShouldSpray, boolean pOverwrite = false, boolean pUseProd = Tools._Constants.IsDataland) := function			
		
		state_origin	 := 'FL';
		state_fips	 	 := '12';	 
		state_desc	 	 := 'FLORIDA';	
		
		// Vendor Input Files
		CorpFile  := dedup(sort(distribute(Corp2_Raw_FL.Files(filedate,pUseProd).Input.CorpFile.logical,hash(ann_cor_number)),record,local),record,local) : independent;
		EventFile := if(corp2.t2u(updateType) = 'QUARTERLY'
										,dedup(sort(distribute(Corp2_Raw_FL.Files(filedate,pUseProd).Input.EventFile.logical,hash(cor_event_doc_number)),record,local),record,local)
										,DATASET([],Corp2_Raw_FL.Layouts.EventFileLayoutIN));
										
  	//---------- Begin CORPS Mapping ------------------------------------------------------------//
					
		// Join CorpFile and EventFile to add Merger information to the corp file
		Corp2_Raw_FL.Layouts.CorpEvent_TempLay JoinTrf(Corp2_Raw_FL.Layouts.CorpFileLayoutIN l, Corp2_Raw_FL.Layouts.EventFileLayoutIN r ) := transform
			self             := l; 
			self             := r;
			note2            := corp2.t2u(r.cor_event_note_2);
			note3            := corp2.t2u(r.cor_event_note_3);
		  self.recTypeFlag := map(// 'C' -- Corp Recs without any Merger Info
															corp2.t2u(r.cor_event_doc_number) = ''                                     => 'C', 
															// 'N' -- Corp Recs with Merger Info - Non-Survivor
															(length(note2) in [6,12] and stringlib.StringFind(note2,' ',1) = 0) or
															    (length(note3) in [6,12] and stringlib.StringFind(note3,' ',1) = 0)    => 'N', 
															// 'S' -- Corp Recs with Merger Info - Survivor 
															(length(note2) not in [6,12] or stringlib.StringFind(note2,' ',1) > 0) and
															    (length(note3) not in [6,12] or stringlib.StringFind(note3,' ',1) > 0) => 'S',
															'' );												 
		  self.mergerID    := if(self.recTypeFlag = 'N'
														 ,map((length(note2) in [6,12] and stringlib.StringFind(note2,' ',1) = 0) => note2,
																	(length(note3) in [6,12] and stringlib.StringFind(note3,' ',1) = 0) => note3,
															    '')
														 ,'');
			self             := [];
		end; 
		
		jCorpEvent     := join(CorpFile, EventFile(corp2.t2u(cor_event_code) in ['CORAPCMER','CORAPMER','CORAPMNEW','GENACEMER','GENACENEW']), 
										     	 corp2.t2u(left.ANN_COR_NUMBER) = corp2.t2u(right.cor_event_doc_number), 
											     JoinTrf(left,right), LEFT OUTER, local) : independent;	
		
		jCorpEventHasMergerID  :=jCorpEvent(corp2.t2u(mergerID)<>'');
		jCorpEventNoMergerID   :=jCorpEvent(corp2.t2u(mergerID)='');

		jCorpEventMergerIDDist := distribute(jCorpEventHasMergerID, hash(corp2.t2u(mergerID))): independent;	
		
		// Join jCorpEvent to the CorpFile on the merger ID to get the merger company name 
		Corp2_Raw_FL.Layouts.CorpEvent_TempLay JoinTrf2(Corp2_Raw_FL.Layouts.CorpEvent_TempLay l, Corp2_Raw_FL.Layouts.CorpFileLayoutIN r ) := transform
			self.mergerName  := corp2.t2u(r.ANN_COR_NAME);
			self             := l;
			self             := [];
		end; 
			
	  jCorpWithMerger := join(jCorpEventMergerIDDist, CorpFile, 
											      corp2.t2u(left.mergerID) = corp2.t2u(right.ANN_COR_NUMBER), 
											      JoinTrf2(left,right), inner, local) : independent;
														
		Corporation 		:= jCorpWithMerger + jCorpEventNoMergerID : independent;
		
		// Map to Main Common Layout (CORPS)
		Corp2_Mapping.LayoutsCommon.Main corpTransform(Corp2_Raw_FL.Layouts.CorpEvent_TempLay input) := transform
			self.corp_key						          := state_fips + '-' + corp2.t2u(input.ann_cor_number);		
			self.corp_vendor					        := state_fips;		
			self.corp_state_origin			      := state_origin;
			self.corp_inc_state				        := state_origin;
			self.dt_vendor_first_reported	    := (integer)fileDate;
			self.dt_vendor_last_reported	    := (integer)fileDate;
			self.dt_first_seen				        := (integer)fileDate;
			self.dt_last_seen				          := (integer)fileDate;
			self.corp_ra_dt_first_seen		    := (integer)fileDate;
			self.corp_ra_dt_last_seen		      := (integer)fileDate;
			self.corp_process_date			      := fileDate;
			self.corp_orig_sos_charter_nbr    := corp2.t2u(input.ann_cor_number);
			self.corp_legal_name				      := Corp2_mapping.fCleanBusinessName(state_origin,state_desc,input.ann_cor_name).BusinessName;
			self.corp_ln_name_type_cd			    := '01';
		 	self.corp_ln_name_type_desc			  := 'LEGAL';
			self.corp_status_cd								:= corp2.t2u(input.ann_cor_status);
		 	self.corp_status_desc							:= case(corp2.t2u(input.ann_cor_status),'A' => 'ACTIVE','I' => 'INACTIVE', '');
			self.corp_status_date				      := Corp2_Mapping.fValidateDate(input.ann_last_trx_date,'MMDDCCYY').PastDate;
			self.corp_orig_org_structure_cd		:= corp2.t2u(input.ann_cor_filing_type);
		 	self.corp_orig_org_structure_desc	:= Corp2_Raw_FL.Functions.GetOrgStrucDesc(input.ann_cor_filing_type);
			self.corp_fed_tax_id				      := if (length(corp2.t2u(StringLib.StringFilter(input.ann_cor_fei_number,'0123456789'))) = 9 and
			                                        corp2.t2u(StringLib.StringFilter(input.ann_cor_fei_number,'0123456789')) not in 
																									['000000000','111111111','222222222','333333333','444444444','555555555','666666666','777777777','888888888','999999999']
																							 ,corp2.t2u(StringLib.StringFilter(input.ann_cor_fei_number,'0123456789'))
																							 ,'');
			self.corp_inc_date								:= if(corp2.t2u(input.ann_state_country) in [state_origin, ''] 
																							,Corp2_Mapping.fValidateDate(input.ann_cor_file_date,'MMDDCCYY').PastDate, '');
		 	self.corp_forgn_date	            := if(corp2.t2u(input.ann_state_country) not in [state_origin,''] 
																							,Corp2_Mapping.fValidateDate(input.ann_cor_file_date,'MMDDCCYY').PastDate, '');	
			self.corp_foreign_domestic_ind		:= map(corp2.t2u(input.ann_state_country) in [state_origin, ''] or 
																							    corp2.t2u(input.ann_cor_filing_type) not in ['FORP','FORNP','FORLP','FORL'] => 'D',
			                                         corp2.t2u(input.ann_state_country) not in [state_origin,''] or 
																							    corp2.t2u(input.ann_cor_filing_type) in ['FORP','FORNP','FORLP','FORL'] => 'F',
																							 '');		
			self.corp_forgn_state_cd          := if (corp2.t2u(input.ann_state_country) not in [state_origin,'']
																							,corp2.t2u(input.ann_state_country), '');
		 	self.corp_forgn_state_desc        := Corp2_Raw_FL.Functions.decode_state(self.corp_forgn_state_cd);	
			self.corp_country_of_formation    := if (Corp2_mapping.fCleanCountry(state_origin,state_desc,,input.ann_state_country).country = 'US'
																					 ,'US'
																					 ,if (Corp2_Raw_FL.Functions.decode_state(input.ann_state_country)[1..2] = '**'
																					      ,'',Corp2_Raw_FL.Functions.decode_state(input.ann_state_country)));
			self.corp_for_profit_ind 			    := map (corp2.t2u(input.ann_cor_filing_type) in ['DOMP','FORP']           => 'Y',
																								corp2.t2u(input.ann_cor_filing_type) in ['DOMNP','FORNP','NPREG'] => 'N', '');
			// *** No separate State field for new_princ_2nd_mail address (city and state are together in the city field), so they all need to go through CleanAddress182 to parse out city and state into separate fields
			add1Exists := if(corp2.t2u(input.new_princ_2nd_mail_add1+input.new_princ_2nd_mail_add2+input.new_princ_2nd_mail_city+input.new_princ_2nd_mail_zip) <> '',true,false);
			string182 corpAddr1clean_address	:= if(add1Exists,Address.CleanAddress182(corp2.t2u(input.new_princ_2nd_mail_add1+' '+input.new_princ_2nd_mail_add2),corp2.t2u(input.new_princ_2nd_mail_city+' '+input.new_princ_2nd_mail_zip)),'');
			corpAddr1City                     := if(add1Exists,corpAddr1clean_address[65..89],'');
			corpAddr1State                    := if(add1Exists,corpAddr1clean_address[115..116],'');
			self.corp_address1_type_cd        := if(Corp2_Mapping.fAddressExists(state_origin,state_desc,input.new_princ_2nd_mail_add1,input.new_princ_2nd_mail_add2,corpAddr1City,corpAddr1State,input.new_princ_2nd_mail_zip).ifAddressExists, 'L', '');			
			self.corp_address1_type_desc      := if(Corp2_Mapping.fAddressExists(state_origin,state_desc,input.new_princ_2nd_mail_add1,input.new_princ_2nd_mail_add2,corpAddr1City,corpAddr1State,input.new_princ_2nd_mail_zip).ifAddressExists, 'PRINCIPAL', '');
			self.corp_address1_line1			    := if(self.corp_address1_type_cd<>'',Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.new_princ_2nd_mail_add1,input.new_princ_2nd_mail_add2,corpAddr1City,corpAddr1State,input.new_princ_2nd_mail_zip).AddressLine1,'');
			self.corp_address1_line2			    := if(self.corp_address1_type_cd<>'',Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.new_princ_2nd_mail_add1,input.new_princ_2nd_mail_add2,corpAddr1City,corpAddr1State,input.new_princ_2nd_mail_zip).AddressLine2,'');
			self.corp_address1_line3			    := if(self.corp_address1_type_cd<>'',Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.new_princ_2nd_mail_add1,input.new_princ_2nd_mail_add2,corpAddr1City,corpAddr1State,input.new_princ_2nd_mail_zip).AddressLine3,'');
			self.corp_prep_addr1_line1			  := if(self.corp_address1_type_cd<>'',Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.new_princ_2nd_mail_add1,input.new_princ_2nd_mail_add2,corpAddr1City,corpAddr1State,input.new_princ_2nd_mail_zip).PrepAddrLine1,'');
			self.corp_prep_addr1_last_line	  := if(self.corp_address1_type_cd<>'',Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.new_princ_2nd_mail_add1,input.new_princ_2nd_mail_add2,corpAddr1City,corpAddr1State,input.new_princ_2nd_mail_zip).PrepAddrLastLine,'');

			// *** If ann_cor_2nd_mail_state is blank then call CleanAddress182, else just fCleanAddress
			add2Exists   := if(corp2.t2u(input.ann_cor_2nd_mail_add1+input.ann_cor_2nd_mail_add2+input.ann_cor_2nd_mail_city+input.ann_cor_2nd_mail_zip) <> '',true,false);
			stateIsBlank := if(corp2.t2u(input.ann_cor_2nd_mail_state) = '',true,false);
			string182 corpAddr2clean_address	:= if(add2Exists and stateIsBlank,Address.CleanAddress182(corp2.t2u(input.ann_cor_2nd_mail_add1+' '+input.ann_cor_2nd_mail_add2),corp2.t2u(input.ann_cor_2nd_mail_city+' '+input.ann_cor_2nd_mail_zip)),'');
			corpAddr2City                     := if(corp2.t2u(corpAddr2clean_address[65..89]) <> ''   ,corpAddr2clean_address[65..89]   ,input.ann_cor_2nd_mail_city);
			corpAddr2State                    := if(corp2.t2u(corpAddr2clean_address[115..116]) <> '' ,corpAddr2clean_address[115..116] ,input.ann_cor_2nd_mail_state);
			self.corp_address2_type_cd        := if(Corp2_Mapping.fAddressExists(state_origin,state_desc,input.ann_cor_2nd_mail_add1,input.ann_cor_2nd_mail_add2,corpAddr2City,corpAddr2State,input.ann_cor_2nd_mail_zip).ifAddressExists, 'M', '');			
			self.corp_address2_type_desc      := if(Corp2_Mapping.fAddressExists(state_origin,state_desc,input.ann_cor_2nd_mail_add1,input.ann_cor_2nd_mail_add2,corpAddr2City,corpAddr2State,input.ann_cor_2nd_mail_zip).ifAddressExists, 'MAILING', '');
			self.corp_address2_line1			    := if(self.corp_address2_type_cd<>'',Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.ann_cor_2nd_mail_add1,input.ann_cor_2nd_mail_add2,corpAddr2City,corpAddr2State,input.ann_cor_2nd_mail_zip).AddressLine1,'');
			self.corp_address2_line2			    := if(self.corp_address2_type_cd<>'',Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.ann_cor_2nd_mail_add1,input.ann_cor_2nd_mail_add2,corpAddr2City,corpAddr2State,input.ann_cor_2nd_mail_zip).AddressLine2,'');
			self.corp_address2_line3			    := if(self.corp_address2_type_cd<>'',Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.ann_cor_2nd_mail_add1,input.ann_cor_2nd_mail_add2,corpAddr2City,corpAddr2State,input.ann_cor_2nd_mail_zip).AddressLine3,'');
			self.corp_prep_addr2_line1			  := if(self.corp_address2_type_cd<>'',Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.ann_cor_2nd_mail_add1,input.ann_cor_2nd_mail_add2,corpAddr2City,corpAddr2State,input.ann_cor_2nd_mail_zip).PrepAddrLine1,'');
			self.corp_prep_addr2_last_line	  := if(self.corp_address2_type_cd<>'',Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.ann_cor_2nd_mail_add1,input.ann_cor_2nd_mail_add2,corpAddr2City,corpAddr2State,input.ann_cor_2nd_mail_zip).PrepAddrLastLine,'');
  				
			// *** RA Addresses are ok, so CleanAddress182 not needed.  
			self.corp_ra_address_type_cd      := if(Corp2_Mapping.fAddressExists(state_origin,state_desc,input.ann_ra_add1,'',input.ann_ra_city,input.ann_ra_state,input.ann_ra_zip5 + input.ann_ra_zip4).ifAddressExists, 'R', '');			
			self.corp_ra_address_type_desc    := if(Corp2_Mapping.fAddressExists(state_origin,state_desc,input.ann_ra_add1,'',input.ann_ra_city,input.ann_ra_state,input.ann_ra_zip5 + input.ann_ra_zip4).ifAddressExists, 'REGISTERED OFFICE', '');
			self.corp_ra_address_line1			  := if(self.corp_ra_address_type_cd<>'',Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.ann_ra_add1,'',input.ann_ra_city,input.ann_ra_state,input.ann_ra_zip5 + input.ann_ra_zip4).AddressLine1,'');
			self.corp_ra_address_line2			  := if(self.corp_ra_address_type_cd<>'',Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.ann_ra_add1,'',input.ann_ra_city,input.ann_ra_state,input.ann_ra_zip5 + input.ann_ra_zip4).AddressLine2,'');
			self.corp_ra_address_line3			  := if(self.corp_ra_address_type_cd<>'',Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.ann_ra_add1,'',input.ann_ra_city,input.ann_ra_state,input.ann_ra_zip5 + input.ann_ra_zip4).AddressLine3,'');
			self.ra_prep_addr_line1			      := if(self.corp_ra_address_type_cd<>'',Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.ann_ra_add1,'',input.ann_ra_city,input.ann_ra_state,input.ann_ra_zip5).PrepAddrLine1,'');
			self.ra_prep_addr_last_line	      := if(self.corp_ra_address_type_cd<>'',Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.ann_ra_add1,'',input.ann_ra_city,input.ann_ra_state,input.ann_ra_zip5).PrepAddrLastLine,'');
				
			self.corp_ra_full_name					  := Corp2_mapping.fCleanBusinessName(state_origin,state_desc,input.ann_ra_name).BusinessName;
		  self.corp_ra_title_desc				    := if (self.corp_ra_full_name <> '', 'REGISTERED AGENT',  '');
			self.corp_ra_addl_info            := Corp2_Raw_FL.Functions.GetAddlInfo(input.ann_ra_add1,input.ann_ra_name,input.ann_ra_name_type);
		  
			resDate1 := Corp2_Raw_FL.Functions.GetResignDate1(input.ann_ra_add1);
			resDate2 := if(resDate1 = '' ,Corp2_Raw_FL.Functions.GetResignDate2(input.ann_ra_name,input.ann_ra_name_type) ,'');
			self.corp_ra_resign_date          := if(resDate1 <> '' ,resDate1, resDate2);
			self.corp_merger_date 						:= Corp2_Mapping.fValidateDate(input.cor_event_filed_date,'MMDDCCYY').PastDate;
			self.corp_merger_effective_date 	:= Corp2_Mapping.fValidateDate(input.cor_event_efft_date,'MMDDCCYY').GeneralDate;
			self.corp_merger_desc       			:= if (corp2.t2u(input.recTypeFlag) in ['S','N']
			                                        ,corp2.t2u(input.cor_event_note_1 + input.cor_event_note_2 + input.cor_event_note_3 + input.cor_event_cons_mer_number)
																							,'');
			self.corp_merger_indicator 				:= case (corp2.t2u(input.recTypeFlag), 'S'=>'S', 'N'=>'N', '');
			self.corp_merger_name 						:= corp2.t2u(input.mergerName);
			self.recordOrigin     						:= 'C';
			self                              := [];
		end; 	
		
		mapCorp		:= project(Corporation, corpTransform(left)) : independent;
		
		//---------- End CORPS Mapping -----------------------------------------------------------------//
		
		
		//---------- Begin CONTACTS Mapping ------------------------------------------------------------//
		
		// Normalize CorpFile on the 6 Principal Addresses 	
		Corp2_Raw_FL.Layouts.normPrinc_Layout normPrincTrf(Corp2_Raw_FL.Layouts.CorpFileLayoutIN l, unsigned1 cnt) := transform,
					skip(cnt = 1 and corp2.t2u(l.ANN_PRINC1_NAME)='' or cnt = 2 and corp2.t2u(l.ANN_PRINC2_NAME)='' or
							 cnt = 3 and corp2.t2u(l.ANN_PRINC3_NAME)='' or cnt = 4 and corp2.t2u(l.ANN_PRINC4_NAME)='' or
							 cnt = 5 and corp2.t2u(l.ANN_PRINC5_NAME)='' or cnt = 6 and corp2.t2u(l.ANN_PRINC6_NAME)='' )
			self.norm_TITLE	    := choose(cnt, l.ANN_PRINC1_TITLE    , l.ANN_PRINC2_TITLE    , l.ANN_PRINC3_TITLE, 
															  				 l.ANN_PRINC4_TITLE    , l.ANN_PRINC5_TITLE    , l.ANN_PRINC6_TITLE);
			self.norm_NAME_TYPE := choose(cnt, l.ANN_PRINC1_NAME_TYPE, l.ANN_PRINC2_NAME_TYPE, l.ANN_PRINC3_NAME_TYPE,
																				 l.ANN_PRINC4_NAME_TYPE, l.ANN_PRINC5_NAME_TYPE, l.ANN_PRINC6_NAME_TYPE);
			self.norm_NAME		  := choose(cnt, l.ANN_PRINC1_NAME     , l.ANN_PRINC2_NAME     , l.ANN_PRINC3_NAME,
																				 l.ANN_PRINC4_NAME     , l.ANN_PRINC5_NAME     , l.ANN_PRINC6_NAME);
			self.norm_ADD1		  := choose(cnt, l.ANN_PRINC1_ADD1     , l.ANN_PRINC2_ADD1     , l.ANN_PRINC3_ADD1,
																				 l.ANN_PRINC4_ADD1     , l.ANN_PRINC5_ADD1     , l.ANN_PRINC6_ADD1);
			self.norm_CITY	  	:= choose(cnt, l.ANN_PRINC1_CITY     , l.ANN_PRINC2_CITY     , l.ANN_PRINC3_CITY,
																				 l.ANN_PRINC4_CITY     , l.ANN_PRINC5_CITY     , l.ANN_PRINC6_CITY);	
			self.norm_STATE		  := choose(cnt, l.ANN_PRINC1_STATE    , l.ANN_PRINC2_STATE    , l.ANN_PRINC3_STATE,
																				 l.ANN_PRINC4_STATE    , l.ANN_PRINC5_STATE    , l.ANN_PRINC6_STATE);
			self.norm_ZIP5		  := choose(cnt, l.ANN_PRINC1_ZIP5     , l.ANN_PRINC2_ZIP5     , l.ANN_PRINC3_ZIP5,
																				 l.ANN_PRINC4_ZIP5     , l.ANN_PRINC5_ZIP5     , l.ANN_PRINC6_ZIP5);
			self.norm_ZIP4	  	:= choose(cnt, l.ANN_PRINC1_ZIP4     , l.ANN_PRINC2_ZIP4     , l.ANN_PRINC3_ZIP4,
																				 l.ANN_PRINC4_ZIP4     , l.ANN_PRINC5_ZIP4     , l.ANN_PRINC6_ZIP4);
		  self 						    := l;
		end;
		
		normPrinc_CorpFile	:= normalize(corpFile, 6, normPrincTrf(left, counter)) : independent;
		
		// Map to Main Common Layout (CONTACTS)
		Corp2_Mapping.LayoutsCommon.Main contTransform(Corp2_Raw_FL.Layouts.normPrinc_Layout input) := transform
			self.corp_key						        := state_fips + '-' + corp2.t2u(input.ann_cor_number);		
			self.corp_vendor					      := state_fips;		
			self.corp_state_origin			    := state_origin;
			self.corp_inc_state				      := state_origin;
			self.dt_vendor_first_reported	  := (integer)fileDate;
			self.dt_vendor_last_reported	  := (integer)fileDate;
			self.dt_first_seen				      := (integer)fileDate;
			self.dt_last_seen				        := (integer)fileDate;
			self.corp_ra_dt_first_seen		  := (integer)fileDate;
			self.corp_ra_dt_last_seen		    := (integer)fileDate;
			self.corp_process_date			    := fileDate;
			self.corp_orig_sos_charter_nbr  := corp2.t2u(input.ann_cor_number);
			self.corp_legal_name				    := Corp2_mapping.fCleanBusinessName(state_origin,state_desc,input.ann_cor_name).BusinessName;
			self.cont_full_name						  := corp2.t2u(input.norm_name);
			self.cont_title1_desc           := Corp2_Raw_FL.functions.GetContDesc(input.norm_title);
	  	self.cont_type_cd					      := if(corp2.t2u(input.ann_cor_filing_type) in ['AGENT','DOMNP','DOMP','FORNP','FORP','NPREG','TRUST']
																						,'F','M');
			self.cont_type_desc					    := case(self.cont_type_cd, 'F'=>'OFFICER', 'M'=>'MEMBER/MANAGER/PARTNER',''); 
			self.cont_address_type_cd       := if(Corp2_Mapping.fAddressExists(state_origin,state_desc,input.norm_add1,'',input.norm_city,input.norm_state,input.norm_zip5 + input.norm_zip4).ifAddressExists, 'B', '');			
			self.cont_address_type_desc     := if(Corp2_Mapping.fAddressExists(state_origin,state_desc,input.norm_add1,'',input.norm_city,input.norm_state,input.norm_zip5 + input.norm_zip4).ifAddressExists, 'BUSINESS', '');
			self.cont_address_line1			    := Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.norm_add1,'',input.norm_city,input.norm_state,input.norm_zip5 + input.norm_zip4).AddressLine1;
			self.cont_address_line2			    := Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.norm_add1,'',input.norm_city,input.norm_state,input.norm_zip5 + input.norm_zip4).AddressLine2;
			self.cont_address_line3			    := Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.norm_add1,'',input.norm_city,input.norm_state,input.norm_zip5 + input.norm_zip4).AddressLine3;
			self.cont_prep_addr_line1			  := Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.norm_add1,'',input.norm_city,input.norm_state,input.norm_zip5).PrepAddrLine1;
			self.cont_prep_addr_last_line	  := Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.norm_add1,'',input.norm_city,input.norm_state,input.norm_zip5).PrepAddrLastLine;
  		self.recordOrigin               := 'T';			
			self 							              := [];						
		end;					

		mapCont		  := project(normPrinc_CorpFile, contTransform(left)) : independent;
			
    //----------- End CONTACTS Mapping ---------------------------------------------------------------//
				
				
		//----------- Begin EVENTS Mapping ---------------------------------------------------------------//	
		
		MergConsCodes := ['CORAPCMER' ,'CORAPMER'  ,'CORAPMNEW','GENACEMER','GENACENEW'              /*Mergers*/,
											'CORAPCCONS','CORAPCCONV','CORAPCONS','CORAPCONV','CORLCABNCN','GENACECONV'/*Conv Consolidations*/];
		
		NameChgCodes  := ['CORALPCCNC','CORAPAMDNC','CORAPAMNSN','CORAPARNC' ,'CORAPCORNC','CORAPDBANC','CORAPNC',
										  'CORAPRCRNC','CORAPRNC'  ,'CORAPTMONC','CORLCAMDNC','CORLCCORNC','CORLCDBANC','CORLCNC',
											'CORLCRNC'  ,'CORLPAMDNC','CORLPNC'   ,'CORMERNC'  ,'LTDAPRCRNC'];
											
		// Map to Events Common Layout - Quarterly Events
		Corp2_Mapping.LayoutsCommon.Events EventTrf1(Corp2_Raw_FL.Layouts.EventFileLayoutIN input):=transform									
			self.corp_key					    := state_fips + '-' + corp2.t2u(input.cor_event_doc_number);
			self.corp_vendor				  := state_fips;
			self.corp_state_origin		:= state_origin;
			self.corp_process_date		:= fileDate;
			self.corp_sos_charter_nbr	:= corp2.t2u(input.cor_event_doc_number);
			self.event_filing_cd      := corp2.t2u(input.cor_event_code);
			self.event_filing_desc		:= corp2.t2u(corp2.t2u(input.cor_event_desc1) + ' ' + corp2.t2u(input.cor_event_desc2));
			self.event_filing_date		:= Corp2_Mapping.fValidateDate(input.cor_event_filed_date,'MMDDCCYY').PastDate;													   
			self.event_date_type_desc	:= if (self.event_filing_date<>'',	'FILED','');
			self.event_revocation_comment1 := corp2.t2u(input.cor_event_code); // This is for scrubs purposes only
		  self								      := [];
		end;
		
		//For all codes that are not Mergers, Conversion Consolidations, or Name Changes
		mapEvent1	:= project(eventFile(corp2.t2u(cor_event_code) not in [MergConsCodes,NameChgCodes,'']),EventTrf1(left)) : independent; 
							
		// Map to Events Common Layout - Merger and Conversion Consolidation Events
		Corp2_Mapping.LayoutsCommon.Events EventTrf2(Corp2_Raw_FL.Layouts.EventFileLayoutIN input):=transform									
      self.corp_key					    := state_fips + '-' + corp2.t2u(input.cor_event_doc_number);
			self.corp_vendor				  := state_fips;
			self.corp_state_origin		:= state_origin;
			self.corp_process_date		:= fileDate;
			self.corp_sos_charter_nbr	:= corp2.t2u(input.cor_event_doc_number);
			self.event_filing_cd      := corp2.t2u(input.cor_event_code);
			self.event_filing_desc		:= corp2.t2u(corp2.t2u(input.cor_event_desc1) + ' ' + corp2.t2u(input.cor_event_desc2));
			self.event_filing_date		:= Corp2_Mapping.fValidateDate(input.cor_event_filed_date,'MMDDCCYY').PastDate;													   
			self.event_date_type_desc	:= if (self.event_filing_date<>'',	'FILED','');
			self.event_desc           := corp2.t2u(input.cor_event_note_1 + ' ' + input.cor_event_note_2 + ' ' +
			                                       input.cor_event_note_3 + ' ' + input.cor_event_cons_mer_number);	
			self.event_corp_nbr				:= corp2.t2u(input.cor_event_cons_mer_number);  //Retained from old mapper
			self.event_corp_nbr_desc	:= if(self.event_corp_nbr<>'','MERGING CORP NUMBER','');  //Retained from old mapper
			self								      := [];
		end;
		
		//For codes that are Mergers and Conversion Consolidations
		mapEvent2	:= project(eventFile(corp2.t2u(cor_event_code) in MergConsCodes) ,EventTrf2(left)) : independent;
		
		
		// Map to Events Common Layout - Name Changes Events
		Corp2_Mapping.LayoutsCommon.Events EventTrf3(Corp2_Raw_FL.Layouts.EventFileLayoutIN input):=transform									
			self.corp_key					    := state_fips + '-' + corp2.t2u(input.cor_event_doc_number);
			self.corp_vendor				  := state_fips;
			self.corp_state_origin		:= state_origin;
			self.corp_process_date		:= fileDate;
			self.corp_sos_charter_nbr	:= corp2.t2u(input.cor_event_doc_number);
			self.event_filing_cd      := corp2.t2u(input.cor_event_code);
			self.event_filing_desc		:= corp2.t2u(corp2.t2u(input.cor_event_desc1) + ' ' + corp2.t2u(input.cor_event_desc2));
			self.event_filing_date		:= Corp2_Mapping.fValidateDate(input.cor_event_filed_date,'MMDDCCYY').PastDate;													   
			self.event_date_type_desc	:= if (self.event_filing_date<>'',	'FILED','');
			self.event_desc           := if (corp2.t2u(input.cor_event_cor_name) <> ''
			                                 ,'NAME CHANGED TO ' + corp2.t2u(input.cor_event_cor_name), '');
			self							      	:= [];
		end;
								 
		//For codes that are Name Changes and COR_EVENT_COR_NAME is not blank		
		mapEvent3 := project(eventFile(corp2.t2u(cor_event_code) in NameChgCodes and 
																	 corp2.t2u(cor_event_cor_name) <> '') ,EventTrf3(left)) : independent;
		
	  //--------------- End EVENTS Mapping --------------------------------------------------------//
				
				
		//--------------- Begin AR Mapping --------------------------------------------------------//	
		
		// Normalize CorpFile on the 3 Annual Reports	
	
		Corp2_Raw_FL.Layouts.normAR_Layout normARTrf(Corp2_Raw_FL.Layouts.CorpFileLayoutIN l, unsigned1 cnt) := transform,
		skip(cnt = 1 and corp2.t2u(l.ann_report_year1+l.ann_report_date1) = '' or
				 cnt = 2 and corp2.t2u(l.ann_report_year2+l.ann_report_date2) = '' or
				 cnt = 3 and corp2.t2u(l.ann_report_year3+l.ann_report_date3) = ''
				)
			self.norm_YEAR      := choose(cnt, corp2.t2u(l.ANN_REPORT_YEAR1), 
																				 corp2.t2u(l.ANN_REPORT_YEAR2), 
																				 corp2.t2u(l.ANN_REPORT_YEAR3));
	  	self.norm_DATE  	  := choose(cnt, Corp2_Mapping.fValidateDate(l.ANN_REPORT_DATE1,'MMDDCCYY').PastDate, 
																				 Corp2_Mapping.fValidateDate(l.ANN_REPORT_DATE2,'MMDDCCYY').PastDate, 
																				 Corp2_Mapping.fValidateDate(l.ANN_REPORT_DATE3,'MMDDCCYY').PastDate);	
			self 						    := l;
		end;

		normAR_CorpFile	:= normalize(corpFile, 3, normARTrf(left, counter)) : independent;
		
		// Map to AR Common Layout
		Corp2_Mapping.LayoutsCommon.AR arTransform(normAR_CorpFile input):=transform,
									skip(corp2.t2u(input.norm_YEAR)= '' and corp2.t2u(input.norm_DATE)= '')
   		self.corp_key					    := state_fips + '-' + corp2.t2u(input.ann_cor_number);
			self.corp_vendor				  := state_fips;
			self.corp_state_origin		:= state_origin;
			self.corp_process_date		:= fileDate;
			self.corp_sos_charter_nbr	:= corp2.t2u(input.ann_cor_number);										
			self.ar_year					    := if (length(input.norm_YEAR) = 4 and _validate.support.fIntegerInRange((integer)input.norm_YEAR,1600,(unsigned4)fileDate[1..4]) 
			                                ,corp2.t2u(input.norm_YEAR),'');
			self.ar_filed_dt				  := input.norm_DATE;										
			self							        := [];
		end;	
  	//--------------- End AR Mapping --------------------------------------------------------//			


		//-----------------------------------------------------------//
		// Build the Final Mapped Files
		//-----------------------------------------------------------//
		mapMain  := dedup(sort(distribute(mapCorp + mapCont,hash(corp_key)), record,local), record,local) : independent;
		mapAR		 := dedup(sort(distribute(project(normAR_CorpFile, arTransform(left)),hash(corp_key)), record,local), record,local) : independent;
		mapEvent := dedup(sort(distribute(mapEvent1 + mapEvent2 + mapEvent3,hash(corp_key)), record,local), record,local) : independent;
	
	//--------------------------------------------------------------------	
  // Scrubs for MAIN
  //--------------------------------------------------------------------
		Main_F := MapMain;
		Main_S := Scrubs_Corp2_Mapping_FL_Main.Scrubs;        // Scrubs module
		Main_N := Main_S.FromNone(Main_F); 										// Generate the error flags
		Main_T := Main_S.FromBits(Main_N.BitmapInfile);     	// Use the FromBits module; makes my bitmap datafile easier to get to
		Main_U := Main_S.FromExpanded(Main_N.ExpandedInFile); // Pass the expanded error flags into the Expanded module

	//Outputs reports
		Main_ErrorSummary					:= output(Main_U.SummaryStats, named('Main_ErrorSummary_FL'+filedate));
		Main_ScrubErrorReport 		:= output(choosen(Main_U.AllErrors, 1000), named('Main_ScrubErrorReport_FL'+filedate));
		Main_SomeErrorValues			:= output(choosen(Main_U.BadValues, 1000), named('Main_SomeErrorValues_FL'+filedate));
		Main_IsScrubErrors		 		:= IF(count(Main_U.AllErrors)<> 0,true,false);

		// Orbit Stats
		Main_OrbitStats						:= Main_U.OrbitStats();
		
		//Outputs files
		Main_CreateBitMaps				:= output(Main_N.BitmapInfile,,'~thor_data::corp_FL_main_scrubs_bits',overwrite,compressed);	//long term storage
		Main_TranslateBitMap			:= output(Main_T);

	  //Submits Profile's stats to Orbit
		Main_SubmitStats 					:= Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_FL_Main','ScrubsAlerts', Main_OrbitStats, version,'Corp_FL_Main').SubmitStats;

		Main_ScrubsWithExamples		:= Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_FL_Main','ScrubsAlerts', Main_OrbitStats, version,'Corp_FL_Main').CompareToProfile_with_Examples;
		
		Main_ScrubsAlert					:= Main_ScrubsWithExamples(RejectWarning = 'Y');
		Main_ScrubsAttachment			:= Scrubs.fn_email_attachment(Main_ScrubsAlert);
		Main_SendEmailFile				:= FileServices.SendEmailAttachData( corp2.Email_Notification_Lists.spray
																																	 ,'Scrubs CorpMain_FL Report' //subject
																																	 ,'Scrubs CorpMain_FL Report' //body
																																	 ,(data)Main_ScrubsAttachment
																																	 ,'text/csv'
																																	 ,'CorpFLMainScrubsReport.csv'
																																	 ,
																																	 ,
																																	 ,corp2.Email_Notification_Lists.spray
																																 );		
																																 
		Main_BadRecords := Main_T.ExpandedInFile(	dt_vendor_first_reported_invalid 	 <> 0 or
																							dt_vendor_last_reported_invalid 	 <> 0 or
																							dt_first_seen_invalid 			       <> 0 or
																							dt_last_seen_invalid 			         <> 0 or
																							corp_ra_dt_first_seen_invalid 		 <> 0 or
																							corp_ra_dt_last_seen_invalid 			 <> 0 or
																							corp_process_date_invalid 			   <> 0 or
																							corp_merger_effective_date_invalid <> 0 or
																							corp_merger_date_invalid           <> 0 or
																							corp_status_date_invalid           <> 0 or
																							corp_forgn_date_invalid            <> 0 or
																							corp_inc_date_invalid              <> 0 or
																							corp_ra_resign_date_invalid        <> 0 or
																							corp_vendor_invalid 			         <> 0 or
																							corp_state_origin_invalid 			   <> 0 or
																							corp_inc_state_invalid 			       <> 0 or
																							corp_for_profit_ind_invalid 			 <> 0 or
																							corp_foreign_domestic_ind_invalid  <> 0 or
																							corp_legal_name_invalid 			     <> 0 or
																							corp_key_invalid 			             <> 0 or
																							corp_orig_sos_charter_nbr_invalid  <> 0 or
																							corp_orig_org_structure_cd_invalid <> 0 or
																							corp_status_cd_invalid 						 <> 0 or
																							corp_forgn_state_desc_invalid      <> 0 or
																							corp_fed_tax_id_invalid            <> 0 );

		Main_GoodRecords	:= Main_T.ExpandedInFile( dt_vendor_first_reported_invalid 	 = 0 and
																								dt_vendor_last_reported_invalid 	 = 0 and
																								dt_first_seen_invalid 			       = 0 and
																								dt_last_seen_invalid 			         = 0 and
																								corp_ra_dt_first_seen_invalid 		 = 0 and
																								corp_ra_dt_last_seen_invalid 			 = 0 and
																								corp_process_date_invalid 			   = 0 and
																								corp_merger_effective_date_invalid = 0 and
																								corp_merger_date_invalid           = 0 and
																								corp_status_date_invalid           = 0 and
																								corp_forgn_date_invalid            = 0 and
																								corp_inc_date_invalid              = 0 and
																								corp_ra_resign_date_invalid        = 0 and
																								corp_vendor_invalid 			         = 0 and
																								corp_state_origin_invalid 			   = 0 and
																								corp_inc_state_invalid 			       = 0 and
																								corp_for_profit_ind_invalid 			 = 0 and
																								corp_foreign_domestic_ind_invalid  = 0 and
																								corp_legal_name_invalid 			     = 0 and
																								corp_key_invalid 			             = 0 and
																								corp_orig_sos_charter_nbr_invalid  = 0 and
																								corp_orig_org_structure_cd_invalid = 0 and
																								corp_status_cd_invalid 						 = 0 and
																								corp_forgn_state_desc_invalid      = 0 and
																								corp_fed_tax_id_invalid            = 0 );																									 																	
		
		Main_FailBuild	:= map(corp2_mapping.fCalcPercent(count(Main_N.ExpandedInFile(corp_orig_sos_charter_nbr_invalid<>0)),count(Main_N.ExpandedInFile),false) > Scrubs_Corp2_Mapping_FL_Main.Threshold_Percent.CORP_ORIG_SOS_CHARTER_NBR => true,
													 corp2_mapping.fCalcPercent(count(Main_N.ExpandedInFile(corp_legal_name_invalid<>0)),					 count(Main_N.ExpandedInFile),false) > Scrubs_Corp2_Mapping_FL_Main.Threshold_Percent.CORP_LEGAL_NAME 					=> true,
													 corp2_mapping.fCalcPercent(count(Main_N.ExpandedInFile(corp_key_invalid<>0)),						     count(Main_N.ExpandedInFile),false) > Scrubs_Corp2_Mapping_FL_Main.Threshold_Percent.CORP_KEY      						=> true,
													 count(Main_GoodRecords) = 0																																																																																				          => true,
													 false );

		Main_ApprovedRecords := project(Main_GoodRecords,transform(Corp2_Mapping.LayoutsCommon.Main,self := left));
	
		Main_RejFile_Exists		:= IF(FileServices.FileExists(Corp2_Mapping._dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::main_' + state_origin),true,false);			
	  Main_ALL		 					:= sequential(IF(count(Main_BadRecords) <> 0
																					,IF (poverwrite
																							,OUTPUT(Main_BadRecords,,Corp2_Mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::main_FL',overwrite,__compressed__,named('Sample_Rejected_MainRecs_FL'+filedate))
																							,sequential (IF(Main_RejFile_Exists,fileservices.deletelogicalfile(Corp2_Mapping._dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::main_'+ state_origin)),
																													 OUTPUT(Main_BadRecords,,Corp2_Mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::main_'+ state_origin,__compressed__,named('Sample_Rejected_MainRecs_FL'+filedate)))))
																		,output(Main_ScrubsWithExamples, ALL, NAMED('CorpMainFLScrubsReportWithExamples'+filedate))																		
																		//Send Alerts if Scrubs exceeds thresholds
																		,IF(COUNT(Main_ScrubsAlert) > 0, Main_SendEmailFile, OUTPUT('CORP2_MAPPING.FL - No "MAIN" Corp Scrubs Alerts'))
																		,Main_ErrorSummary
																		,Main_ScrubErrorReport
																		,Main_SomeErrorValues	
																		,Main_SubmitStats);

  //--------------------------------------------------------------------	
  // Scrubs for Event
  //--------------------------------------------------------------------
		Event_F := MapEvent;
		Event_S := Scrubs_Corp2_Mapping_FL_Event.Scrubs;        // FL scrubs module
		Event_N := Event_S.FromNone(Event_F); 									// Generate the error flags
		Event_T := Event_S.FromBits(Event_N.BitmapInfile);     	// Use the FromBits module; makes my bitmap datafile easier to get to
		Event_U := Event_S.FromExpanded(Event_N.ExpandedInFile);// Pass the expanded error flags into the Expanded module

	//Outputs reports
		Event_ErrorSummary				:= output(Event_U.SummaryStats, named('Event_ErrorSummary_FL'+filedate));
		Event_ScrubErrorReport 		:= output(choosen(Event_U.AllErrors, 1000), named('Event_ScrubErrorReport_FL'+filedate));
		Event_SomeErrorValues			:= output(choosen(Event_U.BadValues, 1000), named('Event_SomeErrorValues_FL'+filedate));
		Event_IsScrubErrors		 		:= IF(count(Event_U.AllErrors)<> 0,true,false);

		// Orbit Stats
		Event_OrbitStats						:= Event_U.OrbitStats();
		
		//Outputs files
		Event_CreateBitMaps				:= output(Event_N.BitmapInfile,,'~thor_data::corp_FL_Event_scrubs_bits',overwrite,compressed);	//long term storage
		Event_TranslateBitMap			:= output(Event_T);

	  //Submits Profile's stats to Orbit
		Event_SubmitStats 				:= Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_FL_Event','ScrubsAlerts', Event_OrbitStats, version,'Corp_FL_Event').SubmitStats;

		Event_ScrubsWithExamples	:= Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_FL_Event','ScrubsAlerts', Event_OrbitStats, version,'Corp_FL_Event').CompareToProfile_with_Examples;
		
		Event_ScrubsAlert					:= Event_ScrubsWithExamples(RejectWarning = 'Y');
		Event_ScrubsAttachment		:= Scrubs.fn_email_attachment(Event_ScrubsAlert);
		Event_SendEmailFile				:= FileServices.SendEmailAttachData( corp2.Email_Notification_Lists.spray
																																	 ,'Scrubs CorpEvent_FL Report' //subject
																																	 ,'Scrubs CorpEvent_FL Report' //body
																																	 ,(data)Event_ScrubsAttachment
																																	 ,'text/csv'
																																	 ,'CorpFLEventScrubsReport.csv'
																																	 ,
																																	 ,
																																	 ,corp2.Email_Notification_Lists.spray
																																 );		
																																 
		Event_BadRecords := Event_T.ExpandedInFile(	corp_key_invalid  		            <> 0 or
																								corp_sos_charter_nbr_invalid      <> 0 or
																								event_revocation_comment1_invalid <> 0 );	

		Event_GoodRecords	:= Event_T.ExpandedInFile(corp_key_invalid  		            = 0 and
																								corp_sos_charter_nbr_invalid      = 0 and
																								event_revocation_comment1_invalid = 0 );																					 																	
		
		Event_FailBuild	:= if(count(Event_GoodRecords) = 0,true,false);

		Event_ApprovedRecords := project(Event_GoodRecords,transform(Corp2_Mapping.LayoutsCommon.Events,self := left));		
		
		Event_RejFile_Exists			:= IF(FileServices.FileExists(Corp2_Mapping._dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::event_' + state_origin),true,false);			
	  Event_ALL									:= sequential(IF(count(Event_BadRecords)<> 0
																						 ,if(poverwrite
																								,OUTPUT(Event_BadRecords,,Corp2_Mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::event_FL',overwrite,__compressed__,named('Sample_Rejected_Event_Recs_FL'+filedate))
																								,sequential (IF(Event_RejFile_Exists,fileservices.deletelogicalfile(Corp2_Mapping._dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::event_'+ state_origin)),
																														 OUTPUT(Main_BadRecords,,Corp2_Mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::event_'+ state_origin,__compressed__,named('Sample_Rejected_Event_Recs_FL'+filedate)))))
																					 ,output(Event_ScrubsWithExamples, ALL, NAMED('CorpEventFLScrubsReportWithExamples'+filedate))
																					 //Send Alerts if Scrubs exceeds thresholds
																					 ,IF(COUNT(Event_ScrubsAlert) > 0, Event_SendEmailFile, OUTPUT('CORP2_MAPPING.FL - No "EVENT" Corp Scrubs Alerts'))
																					 ,Event_ErrorSummary
																					 ,Event_ScrubErrorReport
																					 ,Event_SomeErrorValues	
																					 ,Event_SubmitStats);							 
	
 //-------------------- Version Control -----------------------------------------------------//	
	VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+version+'::main_fl'			,Main_ApprovedRecords ,main_out		     ,,,pOverwrite);		
	VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+version+'::event_fl'			,Event_ApprovedRecords,event_out	     ,,,pOverwrite);
	VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+version+'::ar_fl'				,MapAR		            ,ar_out			     ,,,pOverwrite);
	
	VersionControl.macBuildNewLogicalFile('~thor_data400::failed::corp2::'+version+'::main_fl'	,MapMain              ,write_fail_main ,,,pOverwrite);		
	VersionControl.macBuildNewLogicalFile('~thor_data400::failed::corp2::'+version+'::event_fl'	,MapEvent             ,write_fail_event,,,pOverwrite);	
	
	mapFL:= sequential(   if(pshouldspray = true,Corp2_mapping.fSprayFiles(state_origin ,version,pOverwrite := pOverwrite))
											  // ,if(corp2.t2u(updateType) = 'DAILY'    ,Corp2_Raw_FL.Build_Bases_FL_Daily(filedate,version,pUseProd).All)     // determined build bases is not needed
												// ,if(corp2.t2u(updateType) = 'QUARTERLY',Corp2_Raw_FL.Build_Bases_FL_Quarterly(filedate,version,pUseProd).All) // determined build bases is not needed
												,main_out
												,if(corp2.t2u(updateType) = 'QUARTERLY',event_out)
												,if(corp2.t2u(updateType) = 'QUARTERLY',ar_out)
												,IF(Main_FailBuild <> true or Event_FailBuild <> true
												  	,sequential( if(corp2.t2u(updateType) = 'QUARTERLY',fileservices.addsuperfile(Corp2_Mapping._Dataset().thor_cluster_Files + 'in::'+Corp2_Mapping._Dataset().NameMapped+'::sprayed::ar'	 ,Corp2_Mapping._Dataset().thor_cluster_Files + 'in::corp2::'+version+'::ar_FL'))
																				,if(corp2.t2u(updateType) = 'QUARTERLY',fileservices.addsuperfile(Corp2_Mapping._Dataset().thor_cluster_Files + 'in::'+Corp2_Mapping._Dataset().NameMapped+'::sprayed::event',Corp2_Mapping._Dataset().thor_cluster_Files + 'in::corp2::'+version+'::event_FL'))
																				,fileservices.addsuperfile(Corp2_Mapping._Dataset().thor_cluster_Files + 'in::'+Corp2_Mapping._Dataset().NameMapped+'::sprayed::main'	,Corp2_Mapping._Dataset().thor_cluster_Files + 'in::corp2::'+version+'::main_FL')																		 
																				,if (count(Main_BadRecords) <> 0 or  count(Event_BadRecords) <> 0 
																						 ,Corp2_Mapping.Send_Email(state_origin ,version,count(Main_BadRecords)<>0,,count(Event_BadRecords)<>0,,count(Main_BadRecords),,count(Event_BadRecords),,count(Main_ApprovedRecords),count(mapAR),count(Event_ApprovedRecords)).RecordsRejected																				 
																						 ,Corp2_Mapping.Send_Email(state_origin ,version,count(Main_BadRecords)<>0,,count(Event_BadRecords)<>0,,count(Main_BadRecords),,count(Event_BadRecords),,count(Main_ApprovedRecords),count(mapAR),count(Event_ApprovedRecords)).MappingSuccess																				 
																						 )	 
																			)
														 ,sequential( write_fail_main//if it fails on  main file threshold ,still writing mapped files!
																				 ,write_fail_event
																				 ,Corp2_Mapping.Send_Email(state_origin ,version).MappingFailed
																				)
													)
												,if (Main_IsScrubErrors or Event_IsScrubErrors
														,Corp2_Mapping.Send_Email(state_origin ,version,Main_IsScrubErrors,false,Event_IsScrubErrors).FieldsInvalidPerScrubs)
												,if(corp2.t2u(updateType) = 'QUARTERLY',Event_All) 
												,Main_All	
										);
		isFileDateValid := if((string)Std.Date.Today() between ut.date_math(filedate[1..8],-180) and ut.date_math(filedate[1..8],180),true,false);
		return sequential (if (isFileDateValid and corp2.t2u(updateType) in ['DAILY','QUARTERLY']
														,mapFL
														,sequential (Corp2_Mapping.Send_Email(state_origin,filedate).InvalidFileDateParm
																		     ,FAIL('Corp2_Mapping.FL failed.  Must specify either DAILY or QUARTERLY as 1st parameter or an invalid filedate was passed in as a parameter.')))); 														
 		
 End; //Update Function

End;//End FL Module											

					