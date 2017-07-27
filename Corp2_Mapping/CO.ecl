import Corp2, _validate, Address, _control, versioncontrol, ut;

export CO := MODULE;
	
	export Layouts_Raw_Input := MODULE;

		export corpMstr := record
			string 	EntityID;
			string 	EntityName;
			string 	PrinAddr1;
			string 	PrinAddr2;
			string 	PrinCity;
			string 	PrinState;
			string 	PrinZip;
			string 	PrinCountry;
			string 	MailAddr1;
			string 	MailAddr2;
			string 	MailCity;
			string 	MailState;
			string 	MailZip;
			string 	MailCountry;			
			string 	EntityStatus;
			string 	Jurisdiction;
			string 	PerpetualFlag;
			string 	TermDate;
			string 	EntityType;
			string 	AgentFirstName;
			string 	AgentMiddleName;
			string 	AgentLastName;
			string 	AgentSuffix;
			string 	AgentOrgName;
			string 	AgentPrinAddr1;
			string 	AgentPrinAddr2;
			string 	AgentPrinCity;
			string 	AgentPrinState;
			string 	AgentPrinZip;
			string 	AgentPrinCountry;
			string 	AgentMailAddr1;
			string 	AgentMailAddr2;
			string 	AgentMailCity;
			string 	AgentMailState;
			string 	AgentMailZip;
			string 	AgentMailCountry;			
			string 	EntityFormDate;
		end;
		
		export corpTrdnm := record
			string 	TrdnmID;
			string 	TrdnmDesc;
			string 	TrdnmForm;
			string 	EffDate;
			string 	FirstName;
			string 	MiddleName;
			string 	LastName;
			string 	Suffix;
			string 	RegOrg;
			string 	PrinAddr1;
			string 	PrinAddr2;
			string 	PrinCity;
			string 	PrinState;
			string 	PrinZip;			
			string 	PrinCountry;
			string 	MailAddr1;
			string 	MailAddr2;
			string 	MailCity;
			string 	MailState;
			string 	MailZip;
			string 	MailCountry;			
			string 	AddDate;
		end;
		
		export corpHist := record
			string 	HistEntityID;
			string 	TranID;
			string 	HistDesc;
			string 	Comment;
			string 	RecDate;
			string 	EffDate;
			string 	Name;
		end;
		
		export cotm := record			
			string  TradeMarkID;
			string  TrdmkDscr;
			string  OwnerFName;
			string  OwnerMName;
			string  OwnerLName;
			string  OwnerSuffix;
			string  OwnerOrg;
			string  BusPhyAddr1;
			string  BusPhyAddr2;			
			string  BusPhyCity;
			string  BusPhyState;
			string  BusPhyCountry;
			string  BusPhyZip;
			string  BusMailAddr1;
			string  BusMailAddr2;
			string  BusMailCity;
			string  BusMailSt;
			string  BusMailCountry;
			string  BusMailZip;
			string  AgentFName;
			string  AgentMName;
			string  AgentLName;
			string  AgentSufx;
			string  AgentOrg;
			string  AgentPhyAddr1;
			string  AgentPhyAddr2;
			string  AgentPhyCity;
			string  AgentPhySt;
			string  AgentPhyCountry;
			string  AgentPhyZip;
			string  AgentMailAddress1;
			string  AgentMailAddress2;
			string  AgentMailCityTM;
			string  AgentMailSt;
			string  AgentMailCountryTM;
			string  AgentMailZipTM;
			string  SPAddr1;
			string  SPAddr2;
			string  SPCity;
			string  SPState;
			string  SPCountry;
			string  SPZip;
			string  GSClassCD;
			string  GSDesc;
			string  Status;
			string  FrstUsedCO;
			string  EffectDte;
			string  ExpirDte;
			string  TMType;
			string  SpecDesc;
			string  TradeForm;
			string  EntityForm;
			string  JurisForm;
			string  FiledDate;
			string  DocID;
			string  GSDeleteFlag;
			string  Comments;
			end;					
		
	end; // end of Layouts_Raw_Input module
	
	export Files_Raw_Input := MODULE;
	    
		// vendor file definition
		export CorpMstr(string filedate)				:= dataset(ut.foreign_prod + 'thor_data400::in::corp2::'+filedate+'::corpMstr::co',	
																												layouts_Raw_Input.corpMstr,
																												CSV(HEADING(1),SEPARATOR(['\t']), quote('"'),TERMINATOR(['\r\n', '\n']))
																											 );
													 
		export CorpTrdnm(string filedate) 			:= dataset(ut.foreign_prod + 'thor_data400::in::corp2::'+filedate+'::corpTrdnm::co',	
																												layouts_Raw_Input.corpTrdnm,
																												CSV(HEADING(1),SEPARATOR(['\t']), quote('"'),TERMINATOR(['\r\n', '\n']))
																											 );
													 
		export CorpHist(string filedate)				:= dataset(ut.foreign_prod + 'thor_data400::in::corp2::'+filedate+'::corpHist::co',	
																												layouts_Raw_Input.corpHist,
																												CSV(HEADING(1),SEPARATOR(['\t']), quote('"'),TERMINATOR(['\r\n', '\n']))
																											 );
													 
		export tmChange(string cotmdate)				:= dataset(ut.foreign_prod + 'thor_data400::in::corp2::'+cotmdate+'::tmChange::co',
																												Layouts_Raw_Input.cotm,
																												CSV(SEPARATOR(['|']), quote('"'),TERMINATOR(['\r','\r\n','\n'])));
													 
		export tmCorrection(string cotmdate)		:= dataset(ut.foreign_prod + 'thor_data400::in::corp2::'+cotmdate+'::tmCorrection::co',
																												Layouts_Raw_Input.cotm,
																												CSV(SEPARATOR(['|']), quote('"'),TERMINATOR(['\r','\r\n','\n'])));
													 
		export tmExpired(string cotmdate)				:= dataset(ut.foreign_prod + 'thor_data400::in::corp2::'+cotmdate+'::tmExpired::co',
																											 Layouts_Raw_Input.cotm,
																											 CSV(SEPARATOR(['|']), quote('"'),TERMINATOR(['\r','\r\n','\n'])));
													 
		export tmRegistration(string cotmdate)	:= dataset(ut.foreign_prod + 'thor_data400::in::corp2::'+cotmdate+'::tmRegistration::co',
																											 Layouts_Raw_Input.cotm,
																											 CSV(SEPARATOR(['|']), quote('"'),TERMINATOR(['\r','\r\n','\n'])));
													 
		export tmRenewal(string cotmdate)				:= dataset(ut.foreign_prod + 'thor_data400::in::corp2::'+cotmdate+'::tmRenewal::co',
																											 Layouts_Raw_Input.cotm,
																											 CSV(SEPARATOR(['|']), quote('"'),TERMINATOR(['\r','\r\n','\n'])));
													 
		export tmTransfer(string cotmdate)			:= dataset(ut.foreign_prod + 'thor_data400::in::corp2::'+cotmdate+'::tmTransfer::co',
																											 Layouts_Raw_Input.cotm,
																											 CSV(SEPARATOR(['|']), quote('"'),TERMINATOR(['\r','\r\n','\n'])));
													 
		export tmWithdraw(string cotmdate)			:= dataset(ut.foreign_prod + 'thor_data400::in::corp2::'+cotmdate+'::tmWithdraw::co',
																											 Layouts_Raw_Input.cotm,
																											 CSV(SEPARATOR(['|']), quote('"'),TERMINATOR(['\r','\r\n','\n'])));													 
									 
	end;
	
	export Update(string fileDate, string cotmDate, string version, boolean pShouldSpray = _Dataset().bShouldSpray,boolean pOverwrite = false) := function
	
	  arStrings := 'ANNUAL|'       + 
								 'PERIODIC|'     +
								 'REPORT PRINTED';
		
		cotmHist := record
			Layouts_Raw_Input.cotm;
			Layouts_Raw_Input.corpHist;
		end;			
			
		tmJoined := record
			cotmHist;
			string mastEntityID;
		end;
		
		normalizedMstr := record
			Layouts_Raw_Input.corpMstr;
			string 	Address1;
			string 	Address2;
			string 	City;
			string 	State;
			string 	Zip;
			string 	Country;
			string	AddrType;
			string  AddrDesc;
		end;
	

		normalizedMstr normalizeMstr(Layouts_Raw_Input.corpMstr l, unsigned1 cnt) := transform
			self.Address1		:= choose(cnt,l.AgentPrinAddr1,l.AgentMailAddr1);
			self.Address2	 	:= choose(cnt,l.AgentPrinAddr2,l.AgentMailAddr2);
			self.City				:= choose(cnt,l.AgentPrinCity,l.AgentMailCity);
			self.State			:= choose(cnt,l.AgentPrinState,l.AgentMailState);		
			self.Zip				:= choose(cnt,l.AgentPrinZip,l.AgentMailZip);
			self.Country		:= choose(cnt,l.AgentPrinCountry,l.AgentMailCountry);
			self.AddrType		:= choose(cnt,'B','M');
			self.AddrDesc		:= choose(cnt,'BUSINESS','MAILING');
			self 						:= l;
		end;

		// NormalizeCorpMstr		:= dedup(normalize(Files_Raw_Input.corpMstr(fileDate), 2, normalizeMstr(left, counter)),RECORD, EXCEPT AddrType,AddrDesc);
		NormalizeCorpMstr		:= normalize(Files_Raw_Input.corpMstr(fileDate), 2, normalizeMstr(left, counter));	
		
		normalizedTrdnm := record
			Layouts_Raw_Input.corpTrdnm;
			string 	Address1;
			string 	Address2;
			string 	City;
			string 	State;
			string 	Zip;
			string 	Country;
			string	AddrType;
			string  AddrDesc;			
		end;
	

		normalizedTrdnm normalizeTrdnm(Layouts_Raw_Input.corpTrdnm l, unsigned1 cnt) := transform
			self.Address1		:= choose(cnt,l.PrinAddr1,l.MailAddr1);
			self.Address2	 	:= choose(cnt,l.PrinAddr2,l.MailAddr2);
			self.City				:= choose(cnt,l.PrinCity,l.MailCity);
			self.State			:= choose(cnt,l.PrinState,l.MailState);		
			self.Zip				:= choose(cnt,l.PrinZip,l.MailZip);
			self.Country		:= choose(cnt,l.PrinCountry,l.MailCountry);
			self.AddrType		:= choose(cnt,'T','M');
			self.AddrDesc		:= choose(cnt,'CONTACT','MAILING');			
			self 						:= l;
		end;

		NormalizeCorpTrdnm		:= normalize(Files_Raw_Input.corpTrdnm(fileDate), 2, normalizeTrdnm(left, counter));		
	
	
		trimUpper(string s) := function
			return trim(stringlib.StringToUppercase(s),left,right);
		end;
		
		trimFilterUpper(string s, string r) := function
			return trim(StringLib.StringFilterOut(stringlib.StringtoUpperCase(s),r),left,right);
		end;		
		
		reformatDate(string inDate) := function
			string clean_inDate := trim(regexreplace('0:00',inDate,''),left,right);
			string2 outMM				:= if(clean_inDate[2] = '/',
																'0'+ clean_inDate[1],
																clean_inDate[1..2]);
			string2 outDD				:= if(clean_inDate[length(clean_inDate)-6] = '/',
																'0'+ clean_inDate[length(clean_inDate)-5],
																clean_inDate[length(clean_inDate)-6..length(clean_inDate)-5]);
			string8 newDate			:= clean_inDate[length(clean_inDate)-3..]+outMM+outDD;	
			return newDate;	
		end;
		
		cleanCountry(string inCountry) := function
			string NonUS := trimUpper(regexreplace('US',inCountry,''));
			return NonUS;
		end;
		
		cleanZip(string inZip) := function
			string NoHyphen := trimUpper(regexreplace('-',inZip,''));
			return NoHyphen;
		end;		
				
		corpTypeLayout := record,MAXLENGTH(100)
			string code;
			string desc;
		end; 
	
		CorpTypeTable := dataset(_dataset().foreign_prod + 'thor_data400::lookup::corp2::corpType::co', corpTypeLayout, CSV(SEPARATOR(['\t']), TERMINATOR(['\r\n', '\n'])));				

		ForgnStateDescLayout := record,MAXLENGTH(100)
			string desc;
			string code;
		end; 
	
		ForgnStateTable := dataset(_dataset().foreign_prod + 'thor_data400::lookup::corp2::statetable_id', ForgnStateDescLayout, CSV(SEPARATOR([',']), TERMINATOR(['\r\n', '\n'])));
		
	
		corp2_mapping.Layout_CorpPreClean corpTransform(normalizedMstr input, ForgnStateDescLayout r ) := transform,skip(
																									(	trimUpper(input.address1) = '' and
																										trimUpper(input.address2) = '' and
																										trimUpper(input.City) = '' and
																										trimUpper(input.State) = '' and
																										trimUpper(input.Zip) = '' and
																										trimUpper(input.Country) = '' and
																										trimUpper(input.AddrType) = 'M') or
																										trimUpper(input.EntityID[1]) = '#')
			self.dt_first_seen									:= fileDate;
			self.dt_last_seen										:= fileDate;
			self.dt_vendor_first_reported				:= fileDate;
			self.dt_vendor_last_reported				:= fileDate;
			self.corp_ra_dt_first_seen					:= fileDate;
			self.corp_ra_dt_last_seen						:= fileDate;			
			self.corp_key												:= '08-' + trimUpper(input.entityID);
			self.corp_vendor										:= '08';
			self.corp_state_origin							:= 'CO';
			self.corp_process_date							:= fileDate;
			
			self.corp_orig_sos_charter_nbr			:= trimUpper(input.entityID);
			self.corp_src_type									:= 'SOS';	
			
			self.corp_legal_name								:= regexreplace('(,*[ ]*DELINQUENT[ ]*|,*[ ]*DISSOLVED[ ]*|,*[ ]*RELINQUISHED[ ]*|,*[ ]*WITHDRAWN[ ]*|,*[ ]*TERMINATED[ ]*|,*[ ]*COLORADO AUTHORITY RELINQUISHED[ ]*|,*[ ]*COLORADO AUTHORITY TERMINATED[ ]*)(JANUARY|FEBRUARY|MARCH|APRIL|MAY|JUNE|JULY|AUGUST|SEPTEMBER|OCTOBER|NOVEMBER|DECEMBER).*', trimUpper(input.entityName), ''); 														
			self.corp_ln_name_type_cd						:= '01';													   
			self.corp_ln_name_type_desc					:= 'LEGAL';
													   
			self.corp_status_desc								:= trimUpper(input.entityStatus);
	    self.corp_term_exist_cd							:= map(	trimUpper(input.perpetualFlag) = 'Y' => 'P',
																									trimUpper(input.perpetualFlag) = 'N' => 'D',
																									''
																								);
													   
	    self.corp_term_exist_desc						:= map(trimUpper(input.perpetualFlag) = 'Y' => 'PERPETUAL',
																									trimUpper(input.perpetualFlag) = 'N' => 'EXPIRATION DATE',
																									''
																								);
													   
	    self.corp_term_exist_exp						:= if (trimUpper(input.perpetualFlag) = 'N' and 
																									_validate.date.fIsValid(input.termDate[7..10] + input.termDate[1..2] + input.termDate[4..5]),
																									input.termDate[7..10] + input.termDate[1..2] + input.termDate[4..5],
																									''
																								);	
													   
			self.corp_inc_state									:= if(trimUpper(input.Jurisdiction) = 'CO' or trimUpper(input.Jurisdiction) = '',
			                                          'CO',
																								''
																							 );
												   
			self.corp_forgn_state_cd            := if(trimUpper(input.Jurisdiction) <> 'CO' and trimUpper(input.Jurisdiction) <> '',
			                                          trimUpper(input.Jurisdiction),
													  ''
												   );
												   
			self.corp_forgn_state_desc          := if(trimUpper(input.Jurisdiction) <> 'CO' and trimUpper(input.Jurisdiction) <> '',
			                                          trimUpper(r.desc),
													  ''
												   );
												   
			cleanFormDate												:= input.entityFormDate[7..10] + input.entityFormDate[1..2] + input.entityFormDate[4..5];
												   

			self.corp_inc_date                  := if((	trimUpper(input.Jurisdiction) = 'CO' or trimUpper(input.Jurisdiction) = '') and 
																								_validate.date.fIsValid(cleanFormDate) and 
																								_validate.date.fIsValid(cleanFormDate,_validate.date.rules.DateInPast),
																									cleanFormDate,
																									''
																								);
													
			self.corp_forgn_date 								:= if((	trimUpper(input.Jurisdiction) <>'CO' and trimUpper(input.Jurisdiction) <>'') and 
																									_validate.date.fIsValid(cleanFormDate) and 
																									_validate.date.fIsValid(cleanFormDate,_validate.date.rules.DateInPast),
																										cleanFormDate,
																										''
																								);												   
						   		   
			self.corp_address1_line1 						:= trimUpper(input.prinAddr1);
													
			self.corp_address1_line2						:= if (trimUpper(input.prinAddr2) <> trimUpper(input.prinAddr1),
																									trimUpper(input.prinAddr2),
																									''
																								);
													  
			self.corp_address1_line3						:= trimUpper(input.prinCity);
													
			self.corp_address1_line4						:= trimUpper(input.prinState);
													
			self.corp_address1_line5						:= if((string)(integer)cleanzip(input.prinZip) <> '0',
																								cleanzip(input.prinZip),
																								''														
																								);
													  
			self.corp_address1_line6						:= cleanCountry(input.prinCountry);
																											  
		  self.corp_address1_type_cd					:= if(trim(input.prinAddr1,left,right) <> '' or 
																								trim(input.prinAddr2,left,right) <> '' or 
																								trim(input.prinCity,left,right) <> '' or
																								trim(input.prinState,left,right) <> '' or 
																								trim(input.prinZip,left,right) <>'' or 
																								trim(input.prinCountry,left,right) <> '',
																									'B',
																									''
																								);
													  
		   self.corp_address1_type_desc				:= if(trim(input.prinAddr1,left,right) <> '' or 
																								trim(input.prinAddr2,left,right) <> '' or 
																								trim(input.prinCity,left,right) <> '' or
																								trim(input.prinState,left,right) <> '' or 
																								trim(input.prinZip,left,right) <>'' or 
																								trim(input.prinCountry,left,right) <> '',
																									'BUSINESS',
																									''
																								);
													  
			self.corp_address2_line1 						:= trimUpper(input.mailAddr1);
														
			self.corp_address2_line2						:= if (trimUpper(input.mailAddr2) <> trimUpper(input.mailAddr1),
																									trimUpper(input.mailAddr2),
																									''
																								);
													
			self.corp_address2_line3						:= trimUpper(input.mailCity);
													
			self.corp_address2_line4						:= trimUpper(input.mailState);
							
			self.corp_address2_line5						:= if((string)(integer)cleanzip(input.mailZip) <> '0',
																								cleanzip(input.mailZip),
																								''
																								
																								);
													  
			self.corp_address2_line6						:= cleanCountry(input.mailCountry);
																									  
		  self.corp_address2_type_cd					:= if(trim(input.mailAddr1,left,right) <> '' or 
																								trim(input.mailAddr2,left,right) <> '' or 
																								trim(input.mailCity,left,right) <> '' or
																								trim(input.mailState,left,right) <> '' or 
																								trim(input.mailZip,left,right) <>'' or 
																								trim(input.mailCountry,left,right) <> '',
																									'M',
																									''
																								);
													  
		  self.corp_address2_type_desc				:= if(trim(input.mailAddr1,left,right) <> '' or 
																								trim(input.mailAddr2,left,right) <> '' or 
																								trim(input.mailCity,left,right) <> '' or
																								trim(input.mailState,left,right) <> '' or 
																								trim(input.mailZip,left,right) <>'' or 
																								trim(input.mailCountry,left,right) <> '',
																									'MAILING',
																									''
																								);
													  
	    self.corp_ra_name										:= if(trim(input.agentOrgName,left,right) <> '',
																								trimUpper(input.agentOrgName),
																								trim(trimUpper(input.agentFirstName) + ' ' +
																										trimUpper(input.agentMiddleName) + ' ' +
																										trimUpper(input.agentLastName) + ' ' +
																										trimUpper(input.agentSuffix),left,right)
																								);
													  
		  self.corp_ra_address_line1 					:= trimUpper(input.address1);
														
			self.corp_ra_address_line2					:= if (trimUpper(input.address1) <> trimUpper(input.address2),
																									trimUpper(input.address2),
																									''
																								);
													  
			self.corp_ra_address_line3					:= trimUpper(input.City);
													
			self.corp_ra_address_line4					:= trimUpper(input.State);
														
			self.corp_ra_address_line5					:= if((string)(integer)cleanzip(input.Zip) <> '0',
																									cleanzip(input.Zip),
																									''
																								);	
													  
			self.corp_ra_address_line6					:= cleanCountry(input.Country);
																										  
		  self.corp_ra_address_type_cd				:= if(trim(input.Address1,left,right) <> '' or 
																								trim(input.Address2,left,right) <> '' or 
																								trim(input.City,left,right) <> '' or
																								trim(input.State,left,right) <> '' or 
																								trim(input.Zip,left,right) <>'' or 
																								trim(input.Country,left,right) <> '',
																									input.AddrType,
																									''
																								);
													  
		  self.corp_ra_address_type_desc			:= if(trim(input.Address1,left,right) <> '' or 
																								trim(input.Address2,left,right) <> '' or 
																								trim(input.City,left,right) <> '' or
																								trim(input.State,left,right) <> '' or 
																								trim(input.Zip,left,right) <>'' or 
																								trim(input.Country,left,right) <> '',
																									input.AddrDesc,
																									''
																								);
													  
											
			self.corp_orig_org_structure_cd     := TrimUpper(input.entityType);
							   			
			self																:= [];
						
		end; 
		
		corp2_mapping.Layout_CorpPreClean corpTrdNameTransform(Layouts_Raw_Input.corpTrdnm input) := transform,skip(trim(input.TrdnmDesc,left,right)='')

			self.dt_first_seen							:= fileDate;
			self.dt_last_seen								:= fileDate;
			self.dt_vendor_first_reported		:= fileDate;
			self.dt_vendor_last_reported		:= fileDate;
			self.corp_ra_dt_first_seen			:= fileDate;
			self.corp_ra_dt_last_seen				:= fileDate;			
			self.corp_key										:= '08-' + trimUpper(input.TrdnmID);
			self.corp_vendor								:= '08';
			self.corp_state_origin					:= 'CO';
			self.corp_process_date					:= fileDate;
			
			self.corp_orig_sos_charter_nbr	:= trimUpper(input.TrdnmID);
			self.corp_src_type							:= 'SOS';	
			
			self.corp_legal_name						:= regexreplace('(,*[ ]*DELINQUENT[ ]*|,*[ ]*DISSOLVED[ ]*|,*[ ]*RELINQUISHED[ ]*|,*[ ]*WITHDRAWN[ ]*|,*[ ]*TERMINATED[ ]*|,*[ ]*COLORADO AUTHORITY RELINQUISHED[ ]*|,*[ ]*COLORADO AUTHORITY TERMINATED[ ]*)(JANUARY|FEBRUARY|MARCH|APRIL|MAY|JUNE|JULY|AUGUST|SEPTEMBER|OCTOBER|NOVEMBER|DECEMBER).*', trimUpper(input.TrdnmDesc), '');												
			self.corp_ln_name_type_cd				:= '04';													   
			self.corp_ln_name_type_desc			:= 'TRADENAME';
											   
	    self.corp_filing_date						:= if (	_validate.date.fIsValid(input.EffDate[7..10] + input.EffDate[1..2] + input.EffDate[4..5]) and 
																							_validate.date.fIsValid(input.EffDate[7..10] + input.EffDate[1..2] + input.EffDate[4..5],_validate.date.rules.DateInPast),
																								input.EffDate[7..10] + input.EffDate[1..2] + input.EffDate[4..5],
																								''
																							 );	
													   
						   			
			self														:= [];
						
		end; 	
		
		//full record
		corp2_mapping.Layout_CorpPreClean corpTMTransform(tmJoined input, ForgnStateDescLayout r) := transform

			self.dt_first_seen									:= fileDate;
			self.dt_last_seen										:= fileDate;
			self.dt_vendor_first_reported				:= fileDate;
			self.dt_vendor_last_reported				:= fileDate;
			self.corp_ra_dt_first_seen					:= fileDate;
			self.corp_ra_dt_last_seen						:= fileDate;			
			self.corp_key												:= '08-' + if(trim(input.mastEntityID,left,right)='',
																												trim(input.tradeMarkID,left,right) ,
																												trim(input.mastEntityID,left,right));
			self.corp_vendor										:= '08';
			self.corp_state_origin							:= 'CO';
			self.corp_process_date							:= fileDate;
			
			self.corp_orig_sos_charter_nbr			:= if(trim(input.mastEntityID,left,right)='',
																								trim(input.tradeMarkID,left,right) ,
																								trim(input.mastEntityID,left,right));															
											  
			self.corp_src_type									:= 'SOS';	
			
			self.corp_legal_name								:= regexreplace('(,*[ ]*DELINQUENT[ ]*|,*[ ]*DISSOLVED[ ]*|,*[ ]*RELINQUISHED[ ]*|,*[ ]*WITHDRAWN[ ]*|,*[ ]*TERMINATED[ ]*|,*[ ]*COLORADO AUTHORITY RELINQUISHED[ ]*|,*[ ]*COLORADO AUTHORITY TERMINATED[ ]*)(JANUARY|FEBRUARY|MARCH|APRIL|MAY|JUNE|JULY|AUGUST|SEPTEMBER|OCTOBER|NOVEMBER|DECEMBER).*', trimUpper(input.trdmkDscr), '');
																
			self.corp_ln_name_type_cd						:= '03';											          
													  
			self.corp_ln_name_type_desc					:= 'TRADEMARK';											         
													  
			self.corp_orig_org_structure_desc   := 'TRADEMARK';													              
											   
      self.corp_ra_name										:= trimUpper(input.ownerorg +
																											 input.ownerfname + ' ' +
																											 input.ownermname + ' ' +
																											 input.ownerlname + ' ' +
																											 input.ownersuffix);													
											   
      self.corp_ra_address_line1 					:= trimUpper(input.busphyaddr1);											         													 
													
			self.corp_ra_address_line2					:= trimUpper(input.busphyaddr2);
											         
													
													  
			self.corp_ra_address_line3					:= trimUpper(input.busphycity);
											         
													 
													
			self.corp_ra_address_line4					:= trimUpper(input.busphystate);
											         
													 
													
			self.corp_ra_address_line5					:= if((integer) cleanzip(input.busphyzip) <> 0,
																								cleanzip(input.busphyzip),
																								'');			
													  
			self.corp_ra_address_line6					:= if(trim(input.mastEntityID,left,right)='',
																								 cleanCountry(input.busphycountry),
																								 '');						
																											  																												  
		  self.corp_ra_address_type_desc			:= if(trim(input.busphyAddr1,left,right) <> '' or 
																								trim(input.busphyAddr2,left,right) <> '' or 
																								trim(input.busphyCity,left,right)  <> '' or
																								trim(input.busphyState,left,right) <> '' or 
																								trim(input.busphyZip,left,right)   <> '' or 
																								trim(cleanCountry(input.busphyCountry),left,right) <> '',
																									'REGISTERED OFFICE',
																								'');
			                                           
		  self.corp_orig_bus_type_desc				:= map(trimUpper(input.gsDesc)<>'' and
																								 trimUpper(input.specDesc)<>''=>
																								 trimUpper(input.gsDesc) + 
																								 '; ' + 
																								 trimUpper(input.specDesc),
																								 trimUpper(input.gsDesc)<>'' or
																								 trimUpper(input.specDesc)<>''=>
																								 trimUpper(input.gsDesc) + 														 
																								 trimUpper(input.specDesc),
																								 '');
													  
      newFilingDate												:= if(input.filedDate<>'',
																								input.filedDate[7..10] + input.filedDate[1..2] + input.filedDate[4..5], 
																								'');													  
													  
	    self.corp_filing_date								:= if(_validate.date.fIsValid(newFilingDate) and 
																								_validate.date.fIsValid(newFilingDate),
																								newFilingDate,
																								'');													
														
			newExpDate        									:= if(input.expirDte<>'',
																								input.expirDte[7..10] + input.expirDte[1..2] + input.expirDte[4..5],
																								'');
														
      self.corp_term_exist_exp						:= if(_validate.date.fIsValid(newExpDate), 
																								newExpDate,
																								'');														
														
      self.corp_term_exist_cd							:= if(_validate.date.fIsValid(newExpDate), 
																								'D',
																								'');														
														
      self.corp_term_exist_desc						:= if(_validate.date.fIsValid(newExpDate), 
																								'EXPIRATION DATE',
																								'');
														
      self.corp_addl_info									:= if(trimUpper(input.frstUsedCO)<>'', 
																								'FIRST USED IN CO: ' + trimUpper(input.frstUsedCO),
																								'');
													  
      self.corp_status_desc								:= trimUpper(input.status);	
	   
	    self.corp_inc_state									:= if(trim(input.mastEntityID,left,right)='' and
																								(trimUpper(input.jurisForm)='CO' or
																								 trimUpper(input.jurisForm)=''),
																								 'CO',
																								 '');
													  
	    self.corp_forgn_state_cd						:= if(trim(input.mastEntityID,left,right)='' and
																								trimUpper(input.jurisForm)<>'CO' and
																								trimUpper(input.jurisForm)<>'',
																								trimUpper(input.jurisForm),
																								'');
													  
	    self.corp_forgn_state_desc					:= if(trim(input.mastEntityID,left,right)='' and
																								trimUpper(input.jurisForm)<>'CO' and
																								trimUpper(input.jurisForm)<>'',
																								r.desc,
																								'');
													  
      //set the corp_supp_key here and the same in the TM Event Records
			self.corp_supp_key              		:= if(trim(input.mastEntityID,left,right)<>'',
																								trim(input.mastEntityID,left,right) +
																								trim(input.tradeMarkID,left,right),
																								'');													  
													  
			self 																:= [];
						
		end; 	
		
		//short record
		corp2_mapping.Layout_CorpPreClean corpTM2Transform(tmJoined input) := transform,
													skip(trim(input.mastEntityID,left,right)<>'')

			self.dt_first_seen								:= fileDate;
			self.dt_last_seen									:= fileDate;
			self.dt_vendor_first_reported			:= fileDate;
			self.dt_vendor_last_reported			:= fileDate;
			self.corp_ra_dt_first_seen				:= fileDate;
			self.corp_ra_dt_last_seen					:= fileDate;			
			self.corp_key											:= '08-' + trim(input.tradeMarkID,left,right);
															 
			self.corp_vendor									:= '08';
			self.corp_state_origin						:= 'CO';
			self.corp_process_date						:= fileDate;
			
			self.corp_orig_sos_charter_nbr		:= trim(input.tradeMarkID,left,right);													  														
											  
			self.corp_src_type								:= 'SOS';	
			
			self.corp_legal_name							:= regexreplace('(,*[ ]*DELINQUENT[ ]*|,*[ ]*DISSOLVED[ ]*|,*[ ]*RELINQUISHED[ ]*|,*[ ]*WITHDRAWN[ ]*|,*[ ]*TERMINATED[ ]*|,*[ ]*COLORADO AUTHORITY RELINQUISHED[ ]*|,*[ ]*COLORADO AUTHORITY TERMINATED[ ]*)(JANUARY|FEBRUARY|MARCH|APRIL|MAY|JUNE|JULY|AUGUST|SEPTEMBER|OCTOBER|NOVEMBER|DECEMBER).*', trimUpper(input.ownerorg + input.ownerfname + ' ' + input.ownermname + ' ' + input.ownerlname + ' ' + input.ownersuffix), '');

			self.corp_ln_name_type_cd					:= '01';
													  
			self.corp_ln_name_type_desc				:= 'LEGAL';											          													 													  
											          
      self.corp_address1_line1 					:= trimUpper(input.busphyaddr1);											         													
													
			self.corp_address1_line2					:= trimUpper(input.busphyaddr2);											         													
													  
			self.corp_address1_line3					:= trimUpper(input.busphycity);											        
													
			self.corp_address1_line4					:= trimUpper(input.busphystate);
											         												
			self.corp_address1_line5					:= if((integer) cleanzip(input.busphyzip) <> 0,
																							cleanzip(input.busphyzip),
																							'');			
													  
			self.corp_address1_line6					:= cleanCountry(input.busphycountry);						
																											  
		  self.corp_address1_type_cd				:= if(trim(input.busphyAddr1,left,right) <> '' or 
																							trim(input.busphyAddr2,left,right) <> '' or 
																							trim(input.busphyCity,left,right) <> '' or
																							trim(input.busphyState,left,right) <> '' or 
																							trim(input.busphyZip,left,right) <>'' or 
																							trim(cleanCountry(input.busphyCountry),left,right) <> '',
																							'B',
																							'');													 
													  
		  self.corp_address1_type_desc			:= if(trim(input.busphyAddr1,left,right) <> '' or 
																							trim(input.busphyAddr2,left,right) <> '' or 
																							trim(input.busphyCity,left,right) <> '' or
																							trim(input.busphyState,left,right) <> '' or 
																							trim(input.busphyZip,left,right) <>'' or 
																							trim(cleanCountry(input.busphyCountry),left,right) <> '',
																							'BUSINESS',
																							'');
														
      self.corp_address2_line1 					:= trimUpper(input.busMailAddr1);											         													
													
			self.corp_address2_line2					:= trimUpper(input.busMailaddr2);											         													
													  
			self.corp_address2_line3					:= trimUpper(input.busMailcity);											        
													
			self.corp_address2_line4					:= trimUpper(input.busMailSt);
											         												
			self.corp_address2_line5					:= if((integer) cleanzip(input.busMailzip) <> 0,
																							cleanzip(input.busMailzip),
																							'');			
													  
			self.corp_address2_line6					:= cleanCountry(input.busMailCountry);						
																											  
		  self.corp_address2_type_cd				:= if(trim(input.busMailAddr1,left,right) <> '' or 
																							trim(input.busMailAddr2,left,right) <> '' or 
																							trim(input.busMailCity,left,right) <> '' or
																							trim(input.busMailSt,left,right) <> '' or 
																							trim(input.busMailZip,left,right) <>'' or 
																							trim(cleanCountry(input.busMailCountry),left,right) <> '',
																							'M',
																							'');													 
													  
		  self.corp_address2_type_desc			:= if(trim(input.busMailAddr1,left,right) <> '' or 
																							trim(input.busMailAddr2,left,right) <> '' or 
																							trim(input.busMailCity,left,right) <> '' or
																							trim(input.busMailSt,left,right) <> '' or 
																							trim(input.busMailZip,left,right) <>'' or 
																							trim(cleanCountry(input.busMailCountry),left,right) <> '',
																							'MAILING',
																							'');															
											           	
			self 															:= [];
						
		end; 	
				
		corp2_mapping.Layout_ContPreClean contTransform(normalizedTrdnm input) := transform, skip((trimUpper(input.RegOrg) = '' and 
																								 trimUpper(input.FirstName) = '' and
																								 trimUpper(input.MiddleName) = '' and
																								 trimUpper(input.LastName) = '') or
																								(trimUpper(input.address1) = '' and
																								 trimUpper(input.address2) = '' and
																								 trimUpper(input.City) = '' and
																								 trimUpper(input.State) = '' and
																								 trimUpper(input.Zip) = '' and
																								 trimUpper(input.Country) = '')
																								)

			self.dt_first_seen								:=fileDate;
			self.dt_last_seen									:=fileDate;

			self.corp_key											:= '08-' + trimUpper(input.TrdnmID);
			self.corp_vendor									:= '08';
			self.corp_state_origin						:= 'CO';
			self.corp_process_date						:= fileDate;
			
			self.corp_orig_sos_charter_nbr		:= trimUpper(input.TrdnmID);
			
			self.corp_legal_name							:= regexreplace('(,*[ ]*DELINQUENT[ ]*|,*[ ]*DISSOLVED[ ]*|,*[ ]*RELINQUISHED[ ]*|,*[ ]*WITHDRAWN[ ]*|,*[ ]*TERMINATED[ ]*|,*[ ]*COLORADO AUTHORITY RELINQUISHED[ ]*|,*[ ]*COLORADO AUTHORITY TERMINATED[ ]*)(JANUARY|FEBRUARY|MARCH|APRIL|MAY|JUNE|JULY|AUGUST|SEPTEMBER|OCTOBER|NOVEMBER|DECEMBER).*', trimUpper(input.TrdnmDesc), '');
			
			self.cont_type_cd									:= '02';
			self.cont_type_desc								:= 'REGISTRANT'; 
			
			string100 tmp_name					:= if(trim(input.RegOrg,left,right) <> '',
															trimUpper(input.RegOrg),
															trim(	trimUpper(input.FirstName) + 
																	trimUpper(input.MiddleName) +
																	trimUpper(input.LastName) +
																	trimUpper(input.Suffix),
																left,right
																)
													 );
											  
			self.cont_name						:= regexreplace('(,*[ ]*DELINQUENT[ ]*|,*[ ]*DISSOLVED[ ]*|,*[ ]*RELINQUISHED[ ]*|,*[ ]*WITHDRAWN[ ]*|,*[ ]*TERMINATED[ ]*|,*[ ]*COLORADO AUTHORITY RELINQUISHED[ ]*|,*[ ]*COLORADO AUTHORITY TERMINATED[ ]*)(JANUARY|FEBRUARY|MARCH|APRIL|MAY|JUNE|JULY|AUGUST|SEPTEMBER|OCTOBER|NOVEMBER|DECEMBER).*', trimUpper(tmp_name), '');
			
			self.cont_address_line1 					:= trimUpper(input.Address1),
													
			self.cont_address_line2						:= if(trimUpper(input.Address1) <> trimUpper(input.Address2),
																							trimUpper(input.Address2),
																							''
																						);
													  
			self.cont_address_line3						:= trimUpper(input.City),
													
			self.cont_address_line4						:= trimUpper(input.State),
													
			self.cont_address_line5						:= if((string)(integer)cleanzip(input.Zip) <> '0',
																							cleanzip(input.Zip),
																							''
																							);
													  
			self.cont_address_line6						:= cleanCountry(input.Country),
																										  
		  self.cont_address_type_cd					:= if(trim(input.Address1,left,right) <> '' or 
																							trim(input.Address2,left,right) <> '' or 
																							trim(input.City,left,right) <> '' or
																							trim(input.State,left,right) <> '' or 
																							trim(input.Zip,left,right) <>'' or 
																							trim(input.Country,left,right) <> '',
																								input.AddrType,
																								''
																							);
													  
		  self.cont_address_type_desc				:= if(trim(input.Address1,left,right) <> '' or 
																							trim(input.Address2,left,right) <> '' or 
																							trim(input.City,left,right) <> '' or
																							trim(input.State,left,right) <> '' or 
																							trim(input.Zip,left,right) <>'' or 
																							trim(input.Country,left,right) <> '',
																								input.AddrDesc,
																								''
																							);
													  

			self 															:= [];	
			
		end;
		
		Corp2.Layout_Corporate_Direct_Event_In eventTransform(Layouts_Raw_Input.corpHist input) := transform
			
			self.corp_key										:= '08-' + trimUpper(input.histEntityID);
			self.corp_vendor								:= '08';
			self.corp_process_date					:= fileDate;
			self.corp_sos_charter_nbr				:= trimUpper(input.histEntityID);
			
			self.event_filing_reference_nbr	:= trimUpper(input.TranID);
			
			CleanRecDate										:= input.RecDate[7..10] + input.RecDate[1..2] + input.RecDate[4..5];
													
			self.event_filing_date					:= if (	_validate.date.fIsValid(CleanRecDate) and 
																							_validate.date.fIsValid(CleanRecDate,_validate.date.rules.DateInPast),
																								CleanRecDate,
																								''
																							 );
												   
			self.event_filing_desc					:= trimUpper(input.HistDesc);
			self.event_desc									:= trimUpper(input.comment);
			self														:=[];
		end;
		
		Corp2.Layout_Corporate_Direct_Event_In tmEventTransform(tmJoined input) := transform
			
			self.corp_key										:= '08-' + trimUpper(input.histEntityID);
			self.corp_vendor								:= '08';
			self.corp_process_date					:= fileDate;
			self.corp_sos_charter_nbr				:= trimUpper(input.histEntityID);
			
			self.event_filing_reference_nbr	:= trimUpper(input.TranID);
			
			CleanRecDate										:= input.RecDate[7..10] + input.RecDate[1..2] + input.RecDate[4..5];
													
			self.event_filing_date					:= if (	_validate.date.fIsValid(CleanRecDate) and 
																							_validate.date.fIsValid(CleanRecDate,_validate.date.rules.DateInPast),
																								CleanRecDate,
																								''
																							 );
												   
			self.event_filing_desc					:= trimUpper(input.HistDesc);
			
			//set the corp_supp_key here and the same in the TM Corp Record
			self.corp_supp_key              := if(trim(input.mastEntityID,left,right)<>'',
																						trim(input.mastEntityID,left,right) +
																						trim(input.tradeMarkID,left,right),
																						'');
											   
			self.event_desc									:= trimUpper(input.comment);
			self														:=[];
		end;
	
		Corp2.Layout_Corporate_Direct_AR_In ARTransform(Layouts_Raw_Input.corpHist input):=transform
							
			self.corp_key								:= '08-' + trimUpper(input.histEntityID);	
			self.corp_vendor						:= '08';				
			self.corp_state_origin			:= 'CO';
			self.corp_process_date			:= fileDate;
			self.corp_sos_charter_nbr		:= trimUpper(input.histEntityID);											                  
			self.ar_report_nbr					:= trimUpper(input.TranID);
			CleanRecDate								:= input.RecDate[7..10] + input.RecDate[1..2] + input.RecDate[4..5];													
			self.ar_filed_dt						:= if (	_validate.date.fIsValid(CleanRecDate) and 
																					_validate.date.fIsValid(CleanRecDate,_validate.date.rules.DateInPast),
																						CleanRecDate,
																						'');
			comment1										:= trimUpper(input.HistDesc);
			comment2										:= trimUpper(input.comment);
			self.ar_comment							:= if(comment1 <> '' and comment2 <> '',
																				comment1 + '; ' + comment2,
																				comment1 + comment2);
			self												:=[];
		end;
		
		Corp2.Layout_Corporate_Direct_Corp_In CleanCorpAddrName(corp2_mapping.Layout_CorpPreClean input) := transform		
			string73 tempname 							:= if(input.corp_ra_name = '', '', Address.CleanPersonFML73(input.corp_ra_name));
			pname 													:= Address.CleanNameFields(tempName);
			cname 													:= DataLib.companyclean(input.corp_ra_name);
			keepPerson 											:= corp2.Rewrite_Common.IsPerson(input.corp_ra_name);
			keepBusiness 										:= corp2.Rewrite_Common.IsCompany(input.corp_ra_name);
			
			self.corp_ra_title1							:= if(keepPerson, pname.title, '');
			self.corp_ra_fname1 						:= if(keepPerson, pname.fname, '');
			self.corp_ra_mname1 						:= if(keepPerson, pname.mname, '');
			self.corp_ra_lname1 						:= if(keepPerson, pname.lname, '');
			self.corp_ra_name_suffix1 			:= if(keepPerson, pname.name_suffix, '');
			self.corp_ra_score1 						:= if(keepPerson, pname.name_score, '');
		
			self.corp_ra_cname1 						:= if(keepBusiness, cname[1..70],'');
			self.corp_ra_cname1_score 			:= if(keepBusiness, pname.name_score, '');
			
			string182 clean_address 				:= Address.CleanAddress182(trim(trim(input.corp_address1_line1,left,right) + ' ' +
																																	trim(input.corp_address1_line2,left,right),left,right),
																																	trim(trim(input.corp_address1_line3,left,right) + ', ' +
																																	trim(input.corp_address1_line4,left,right) + ' ' +
																																	trim(input.corp_address1_line5,left,right),
																																	left,right));	
																				
			string182 clean_address2 				:= Address.CleanAddress182(trim(trim(input.corp_address2_line1,left,right) + ' ' +
																																	trim(input.corp_address2_line2,left,right),left,right),
																																	trim(trim(input.corp_address2_line3,left,right) + ', ' +
																																	trim(input.corp_address2_line4,left,right) + ' ' +
																																	trim(input.corp_address2_line5,left,right),
																																	left,right));																				
			
			string182 clean_ra_address 			:= Address.CleanAddress182(trim(trim(input.corp_ra_address_line1,left,right) + ' ' +
																				trim(input.corp_ra_address_line2,left,right),left,right),																				
														                   trim(trim(input.corp_ra_address_line3,left,right) + ', ' +
																				trim(input.corp_ra_address_line4,left,right) + ' ' +
																				trim(input.corp_ra_address_line5,left,right),
																				left,right));	
																				
			self.corp_ra_prim_range    			:= clean_ra_address[1..10];
			self.corp_ra_predir 	      		:= clean_ra_address[11..12];
			self.corp_ra_prim_name 	  			:= clean_ra_address[13..40];
			self.corp_ra_addr_suffix   			:= clean_ra_address[41..44];
			self.corp_ra_postdir 	    			:= clean_ra_address[45..46];
			self.corp_ra_unit_desig 	  		:= clean_ra_address[47..56];
			self.corp_ra_sec_range 	  			:= clean_ra_address[57..64];
			self.corp_ra_p_city_name	  		:= clean_ra_address[65..89];
			self.corp_ra_v_city_name	  		:= clean_ra_address[90..114];
			self.corp_ra_state 			      	:= clean_ra_address[115..116];
			self.corp_ra_zip5 		      		:= clean_ra_address[117..121];
			self.corp_ra_zip4 		      		:= clean_ra_address[122..125];
			self.corp_ra_cart 		      		:= clean_ra_address[126..129];
			self.corp_ra_cr_sort_sz 	 			:= clean_ra_address[130];
			self.corp_ra_lot 		      			:= clean_ra_address[131..134];
			self.corp_ra_lot_order 	  			:= clean_ra_address[135];
			self.corp_ra_dpbc 		      		:= clean_ra_address[136..137];
			self.corp_ra_chk_digit 	  			:= clean_ra_address[138];
			self.corp_ra_rec_type		  			:= clean_ra_address[139..140];
			self.corp_ra_ace_fips_st	  		:= clean_ra_address[141..142];
			self.corp_ra_county 	  				:= clean_ra_address[143..145];
			self.corp_ra_geo_lat 	    			:= clean_ra_address[146..155];
			self.corp_ra_geo_long 	    		:= clean_ra_address[156..166];
			self.corp_ra_msa 		      			:= clean_ra_address[167..170];
			self.corp_ra_geo_blk						:= clean_ra_address[171..177];
			self.corp_ra_geo_match 	  			:= clean_ra_address[178];
			self.corp_ra_err_stat 	    		:= clean_ra_address[179..182];
			
			self.corp_addr1_prim_range    	:= clean_address[1..10];
			self.corp_addr1_predir 	      	:= clean_address[11..12];
			self.corp_addr1_prim_name 	  	:= clean_address[13..40];
			self.corp_addr1_addr_suffix   	:= clean_address[41..44];
			self.corp_addr1_postdir 	   		:= clean_address[45..46];
			self.corp_addr1_unit_desig 	  	:= clean_address[47..56];
			self.corp_addr1_sec_range 	  	:= clean_address[57..64];
			self.corp_addr1_p_city_name	  	:= clean_address[65..89];
			self.corp_addr1_v_city_name	  	:= clean_address[90..114];
			self.corp_addr1_state 			    := clean_address[115..116];
			self.corp_addr1_zip5 		      	:= clean_address[117..121];
			self.corp_addr1_zip4 		      	:= clean_address[122..125];
			self.corp_addr1_cart 		     		:= clean_address[126..129];
			self.corp_addr1_cr_sort_sz 	 		:= clean_address[130];
			self.corp_addr1_lot 		      	:= clean_address[131..134];
			self.corp_addr1_lot_order 	  	:= clean_address[135];
			self.corp_addr1_dpbc 		     		:= clean_address[136..137];
			self.corp_addr1_chk_digit 	  	:= clean_address[138];
			self.corp_addr1_rec_type		  	:= clean_address[139..140];
			self.corp_addr1_ace_fips_st	  	:= clean_address[141..142];
			self.corp_addr1_county 	  			:= clean_address[143..145];
			self.corp_addr1_geo_lat 	    	:= clean_address[146..155];
			self.corp_addr1_geo_long 	    	:= clean_address[156..166];
			self.corp_addr1_msa 		      	:= clean_address[167..170];
			self.corp_addr1_geo_blk					:= clean_address[171..177];
			self.corp_addr1_geo_match 	  	:= clean_address[178];
			self.corp_addr1_err_stat 	    	:= clean_address[179..182];
			
			self.corp_addr2_prim_range    	:= clean_address2[1..10];
			self.corp_addr2_predir 	      	:= clean_address2[11..12];
			self.corp_addr2_prim_name 	  	:= clean_address2[13..40];
			self.corp_addr2_addr_suffix   	:= clean_address2[41..44];
			self.corp_addr2_postdir 	   		:= clean_address2[45..46];
			self.corp_addr2_unit_desig 	  	:= clean_address2[47..56];
			self.corp_addr2_sec_range 	  	:= clean_address2[57..64];
			self.corp_addr2_p_city_name	  	:= clean_address2[65..89];
			self.corp_addr2_v_city_name	  	:= clean_address2[90..114];
			self.corp_addr2_state 			    := clean_address2[115..116];
			self.corp_addr2_zip5 		      	:= clean_address2[117..121];
			self.corp_addr2_zip4 		      	:= clean_address2[122..125];
			self.corp_addr2_cart 		     		:= clean_address2[126..129];
			self.corp_addr2_cr_sort_sz 	 		:= clean_address2[130];
			self.corp_addr2_lot 		      	:= clean_address2[131..134];
			self.corp_addr2_lot_order 	  	:= clean_address2[135];
			self.corp_addr2_dpbc 		     		:= clean_address2[136..137];
			self.corp_addr2_chk_digit 	  	:= clean_address2[138];
			self.corp_addr2_rec_type		  	:= clean_address2[139..140];
			self.corp_addr2_ace_fips_st	  	:= clean_address2[141..142];
			self.corp_addr2_county 	  			:= clean_address2[143..145];
			self.corp_addr2_geo_lat 	    	:= clean_address2[146..155];
			self.corp_addr2_geo_long 	    	:= clean_address2[156..166];
			self.corp_addr2_msa 		      	:= clean_address2[167..170];
			self.corp_addr2_geo_blk					:= clean_address2[171..177];
			self.corp_addr2_geo_match 	  	:= clean_address2[178];
			self.corp_addr2_err_stat 	    	:= clean_address2[179..182];			
			self														:= input;
			self 														:= [];
		end;						
		
		Corp2.Layout_Corporate_Direct_Cont_In CleanContAddrName(corp2_mapping.Layout_ContPreClean input) := transform		
			string73 tempname 						:= if(input.cont_name = '', '', Address.CleanPersonFML73(input.cont_name));
			pname 												:= Address.CleanNameFields(tempName);
			cname 												:= DataLib.companyclean(input.cont_name);
			keepPerson 										:= corp2.Rewrite_Common.IsPerson(input.cont_name);
			keepBusiness 									:= corp2.Rewrite_Common.IsCompany(input.cont_name);
			
			self.cont_title1							:= if(keepPerson, pname.title, '');
			self.cont_fname1 							:= if(keepPerson, pname.fname, '');
			self.cont_mname1 							:= if(keepPerson, pname.mname, '');
			self.cont_lname1 							:= if(keepPerson, pname.lname, '');
			self.cont_name_suffix1 				:= if(keepPerson, pname.name_suffix, '');
			self.cont_score1 							:= if(keepPerson, pname.name_score, '');
		
			self.cont_cname1 							:= if(keepBusiness, cname[1..70],'');
			self.cont_cname1_score 				:= if(keepBusiness, pname.name_score, '');
			
		
			string182 clean_address 			:= Address.CleanAddress182(trim(trim(input.cont_address_line1,left,right) + ' ' +
																				trim(input.cont_address_line2,left,right),left,right),
														                   trim(trim(input.cont_address_line3,left,right) + ', ' +
																				trim(input.cont_address_line4,left,right) + ' ' +
																				trim(input.cont_address_line5,left,right),
																				left,right));	
																				
			self.cont_prim_range    			:= clean_address[1..10];
			self.cont_predir 	      			:= clean_address[11..12];
			self.cont_prim_name 	  			:= clean_address[13..40];
			self.cont_addr_suffix   			:= clean_address[41..44];
			self.cont_postdir 	  		  		:= clean_address[45..46];
			self.cont_unit_desig 	  			:= clean_address[47..56];
			self.cont_sec_range 	  			:= clean_address[57..64];
			self.cont_p_city_name	  			:= clean_address[65..89];
			self.cont_v_city_name	 				:= clean_address[90..114];
			self.cont_state 			      	:= clean_address[115..116];
			self.cont_zip5 		      			:= clean_address[117..121];
			self.cont_zip4 		 	     			:= clean_address[122..125];
			self.cont_cart 		    	  		:= clean_address[126..129];
			self.cont_cr_sort_sz 	 				:= clean_address[130];
			self.cont_lot 		      			:= clean_address[131..134];
			self.cont_lot_order 	  			:= clean_address[135];
			self.cont_dpbc 		   		   		:= clean_address[136..137];
			self.cont_chk_digit 	  			:= clean_address[138];
			self.cont_rec_type		  			:= clean_address[139..140];
			self.cont_ace_fips_st	  			:= clean_address[141..142];
			self.cont_county 	 	 					:= clean_address[143..145];
			self.cont_geo_lat 	    			:= clean_address[146..155];
			self.cont_geo_long 	    			:= clean_address[156..166];
			self.cont_msa 		      			:= clean_address[167..170];
			self.cont_geo_blk							:= clean_address[171..177];
			self.cont_geo_match 	  			:= clean_address[178];
			self.cont_err_stat 	    			:= clean_address[179..182];

			self													:= input;
			self 													:= [];
		end;
		
		corpMain 		:= join(	NormalizeCorpMstr, ForgnStateTable,
									trimUpper(left.jurisdiction) = trim(right.code,left,right),
									corpTransform(left,right),
									left outer, lookup
								);																
	 
		corp2_mapping.Layout_CorpPreClean findCorpType(corp2_mapping.Layout_CorpPreClean input, corpTypeLayout r ) := transform
			self.corp_orig_org_structure_desc := r.desc;
			self         			 								:= input;
			self                           		:= [];
		end; 							 
							 
		ExplodeCorpType := join(	corpMain, corpTypeTable,
									trimUpper(left.corp_orig_org_structure_cd) = trim(right.code,left,right),
									findCorpType(Left,right),
									left Outer, lookup
							    );
								
		Layouts_Raw_Input.corpHist saveHist(Layouts_Raw_Input.corpHist r) := transform
			self  := r;			
		end;
							
		tmJoined saveEntityID(Layouts_Raw_Input.corpHist l, cotmHist r) := transform
			self              := r;	
			self.mastEntityID := l.HistEntityID;
		end;
							
		cotmHist joinTMHist(Layouts_Raw_Input.cotm l, Layouts_Raw_Input.corpHist r) := transform
			self := l;	
			self := r;
		end;
							
							
		allHist			:= Files_Raw_Input.corpHist(fileDate);
		
		arHist 			:= allHist((((regexfind(arStrings,trimUpper(HistDesc))=TRUE)) or 
														((regexfind(arStrings,trimUpper(Comment))=TRUE))) and
														stringlib.stringfilter(trimUpper(tranid),'0123456789')=trimUpper(tranid));
				  
		eventHist 	:= allHist(((regexfind(arStrings,trimUpper(HistDesc))=FALSE)) and 
														((regexfind(arStrings,trimUpper(Comment))=FALSE)) and
														stringlib.stringfilter(trimUpper(tranid),'0123456789')=trimUpper(tranid));
		
		//Set of Event records having a corresponding Master record
		corpEvents 	:= join(Files_Raw_Input.corpMstr(fileDate), eventHist,
												trimUpper(left.EntityID) = trimUpper(right.histEntityID),
												saveHist(right),
												inner);

		tm1 := Files_Raw_Input.tmChange(cotmDate); 
													 
		tm2 := Files_Raw_Input.tmCorrection(cotmDate); 
													 
		tm3 := Files_Raw_Input.tmExpired(cotmDate); 
													 
		tm4 := Files_Raw_Input.tmRegistration(cotmDate); 
													 
		tm5 := Files_Raw_Input.tmRenewal(cotmDate); 
													 
		tm6 := Files_Raw_Input.tmTransfer(cotmDate); 
													 
		tm7 := Files_Raw_Input.tmWithdraw(cotmDate);  
								
		allTM := sort(tm1 + tm2 + tm3 + tm4 + tm5 + tm6 + tm7, TradeMarkID);
		
		tmHist							:= join(allTM, eventHist,
																trimUpper(left.tradeMarkID) = trimUpper(right.HistEntityID),
																joinTMHist(left,right),
																left outer);
								
		tmHistEntity 				:= join(corpEvents, tmHist,
																trimUpper(left.TranID) = trimUpper(right.tradeMarkID),
																saveEntityID(left,right),
																right outer);
								
		sortedTmHistEntity := sort(tmHistEntity,tradeMarkID);
		
		tmCorps 				:= dedup(sortedTmHistEntity,tradeMarkID);
		
		MapCorpTM1 			:= join(tmCorps, ForgnStateTable,
														trimUpper(left.jurisForm) = trimUpper(right.code),
														corpTMTransform(left,right),
														left outer, lookup);
								
		MapCorpTM2      := project(tmCorps, corpTM2Transform(left));
								
		TradeNames			:= project(Files_Raw_Input.CorpTrdnm(fileDate), corpTrdNameTransform(left));
								
		AllCorp					:= sort(ExplodeCorpType + TradeNames + MapCorpTM1 + MapCorpTM2, corp_key);
		
		cleanCorps 			:= project(AllCorp, CleanCorpAddrName(left));
		
		processCorp 		:= output(cleanCorps,,'~thor_data400::in::corp2::'+version+'::corp_co',__COMPRESSED__);
		
		conts 					:= project(NormalizeCorpTrdnm, contTransform(left));
					  
		cleanConts 			:= project(conts, CleanContAddrName(left));
		
		processCont 		:= output(cleanConts,,'~thor_data400::in::corp2::'+version+'::cont_co',__COMPRESSED__);				
		
		MapEvent1				:= project(corpEvents, eventTransform(left));
		
		MapEvent2				:= project(tmHistEntity, tmEventTransform(left));
		
		MapEvents       := sort(MapEvent1 + MapEvent2, corp_key);					
		
		processEvent 		:= output(MapEvents,,'~thor_data400::in::corp2::'+version+'::event_co',__COMPRESSED__);
		
		MapAR						:= project(arHist, ARTransform(left));				
		
		processAR	 			:= output(MapAR,,'~thor_data400::in::corp2::'+version+'::ar_co',__COMPRESSED__);

	VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+version+'::corp_co'	,cleanCorps	,corp_out		,,,pOverwrite);		
	VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+version+'::event_co'	,MapEvents 	,event_out	,,,pOverwrite);
	VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+version+'::ar_co'		,MapAR			,ar_out			,,,pOverwrite);
	VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+version+'::cont_co'	,cleanConts	,cont_out		,,,pOverwrite);

result := 
		sequential(
			if(pshouldspray = true
					,sequential(
						 fSprayFiles('co'		,filedate,pOverwrite := pOverwrite)
						,fSprayFiles('cotm'	,cotmDate,pOverwrite := pOverwrite)
					)
			)
			,parallel(
				 corp_out	
				,event_out
				,ar_out		
				,cont_out	
			)
			,parallel(
				 fileservices.addsuperfile('~thor_data400::in::corp2::sprayed::corp'	,'~thor_data400::in::corp2::'+version+'::corp_co')
				,fileservices.addsuperfile('~thor_data400::in::corp2::sprayed::cont'	,'~thor_data400::in::corp2::'+version+'::cont_co')
				,fileservices.addsuperfile('~thor_data400::in::corp2::sprayed::event'	,'~thor_data400::in::corp2::'+version+'::event_co')
				,fileservices.addsuperfile('~thor_data400::in::corp2::sprayed::ar'		,'~thor_data400::in::corp2::'+version+'::ar_co')
			)							
		);
	                                                                                                                                                        
		return result;

	end;					 
	
end; // end of CO module