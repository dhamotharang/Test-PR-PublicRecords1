import Corp2, _validate, Address, lib_stringlib, _control, versioncontrol;

export RI := module

    export constants := module
	   export cluster := '~thor_data400::';
	end;

	export Layouts_Raw_Input := module
	   	
		export Entities := record
			string Entity_ID; 
			string EntityName;
			string ElectedName;
			string DateOfOrganization;
			string Chapter;
			string Charter;
			string Status;
			string EffectDate;
			string Purpose;
			string Duration; 
			string StateOfIncorp;
			string LastAnnualRptYear;
			string BeManagedBy;
			string BusinessAddr1;
			string BusinessAddr2;
			string BusinessCity;
			string BusinessState;
			string BusinessCountry;
			string BusinessZip;
			string MailingAddr1;
			string MailingAddr2;
			string MailingCity;
			string MailingState;
			string MailingCountry;
			string MailingZip;
			string IsAddressedMaintained;
			string IsAgentResigned;
			string AgentName;
			string AgentAddr1;
			string AgentAddr2;
			string AgentCity;
			string AgentState;
			string AgentZip;	
		end;
		
		export Amendments := record
			string Entity_ID;
			string EffectiveDate;
			string FilingCode;
			string FilingName;
			string Comments;
		end;
		
		export Names := record
			string Entity_ID;
			string EntityName;
			string EntityNameType;
			string FileDate;
			string AbandonedDate;
			string EntityTypeDescriptor;
		end;
		
		export Mergers := record
			string MergerDate;
			string MergerType;
			string MergedEntityName;
			string MergedEntity_ID;
			string SurvivingEntity_ID;
		end;
		
		export Officers := record
			string Entity_ID;
			string IndividualTitle;
			string FirstName;
			string LastName;
			string MiddleName;
			string Suffix;
			string TermExpiration;
			string Bus_StreetAddr;
			string Bus_City;
			string Bus_State;
			string Bus_CountryCode;
			string Bus_PostalCode;
		end;
		
		export Stocks := record
			string Entity_ID;
			string StockClass;
			string AuthorizedNumber;
			string ParValuePerShare;
			string RestrictionIndicator;
			string TotalIssuedOutstanding;
			string Series;
		end;		
	end;
	
	export Layouts_Lookup := module
	    export Layout_Country := record
		    string code;
			string desc;			
		end;
		
	    export Layout_state := record
		    string code;
			string desc;
		end;

	    export Layout_filings := record
		    string filing_code;
			string filing_desc;
		end;
		
	end;
	
	export Files_Raw_Input := module
	    // vendor file definition
		export VendorEntities(string fileDate)        := distribute(
		                                                   dataset(Constants.cluster + 'in::corp2::'+fileDate+'::Entities::ri',
														           Layouts_Raw_Input.Entities,CSV(HEADING(1), SEPARATOR(['\t']), QUOTE('"'), TERMINATOR(['\r\n', '\n'])))
																   (trim(Entity_ID,left,right) <> '' and (integer) trim(Entity_ID,left,right) <> 0),
																   hash64((integer)Entity_ID)
																  );
		
		export VendorAmendments(string fileDate)      := dataset(Constants.cluster + 'in::corp2::'+fileDate+'::Amendments::ri',
														         Layouts_Raw_Input.Amendments,CSV(HEADING(1), SEPARATOR(['\t']), QUOTE('"'), TERMINATOR(['\r\n', '\n'])));
		
		export VendorNames(string fileDate)           := distribute(
														   dataset(Constants.cluster + 'in::corp2::'+fileDate+'::Names::ri',
														           Layouts_Raw_Input.Names,CSV(HEADING(1), SEPARATOR(['\t']), QUOTE('"'), TERMINATOR(['\r\n', '\n'])))
																   (trim(Entity_ID,left,right) <> '' and (integer) trim(Entity_ID,left,right) <> 0),
																   hash64((integer)Entity_ID)
																  );
		
		export VendorMergers(string fileDate)         := distribute(
		                                                   dataset(Constants.cluster + 'in::corp2::'+fileDate+'::Mergers::ri',
														           Layouts_Raw_Input.Mergers,CSV(HEADING(1), SEPARATOR(['\t']), QUOTE('"'), TERMINATOR(['\r\n', '\n'])))
																   (trim(SurvivingEntity_ID,left,right) <> '' and (integer) trim(SurvivingEntity_ID,left,right) <> 0),
																   hash64((integer)SurvivingEntity_ID)
																  );
		
		export VendorOfficers(string fileDate)        := distribute(
		                                                   dataset(Constants.cluster + 'in::corp2::'+fileDate+'::Officers::ri',
														           Layouts_Raw_Input.Officers,CSV(HEADING(1), SEPARATOR(['\t']), QUOTE('"'), TERMINATOR(['\r\n', '\n'])))
																   ((integer)trim(Entity_ID,left,right) <> 0),
																   hash64((integer)Entity_ID)
																  );
		
		export VendorStocks(string fileDate)          := dataset(Constants.cluster + 'in::corp2::'+fileDate+'::Stocks::ri',
														         Layouts_Raw_Input.Stocks,CSV(HEADING(1), SEPARATOR(['\t']), QUOTE('"'), TERMINATOR(['\r\n', '\n'])));        
	end;
	
	
	export File_Lookups := module
	    // file Lookup tables definition
		export Country                                := dataset(_dataset().foreign_prod + Constants.cluster[2..] + 'in::corp2::lookup::country::ri',
														         Layouts_Lookup.Layout_Country,CSV(SEPARATOR(['\t']), QUOTE('"'), TERMINATOR(['\r\n', '\n'])));

		export foreign_state_code                     := dataset(_dataset().foreign_prod + Constants.cluster[2..] + 'in::corp2::lookup::state::ri',
														         Layouts_Lookup.Layout_state,CSV(SEPARATOR(['\t']), QUOTE('"'), TERMINATOR(['\r\n', '\n'])));

		export corp_filings                           := dataset(_dataset().foreign_prod + Constants.cluster[2..] + 'in::corp2::lookup::corp_filings::ri',
														         Layouts_Lookup.Layout_filings,CSV(SEPARATOR(['\t']), QUOTE('"'), TERMINATOR(['\r\n', '\n'])));
    end;


	//****************  Update process begins   *******************************************************
	export Update(string fileDate, string version, boolean pShouldSpray = _Dataset().bShouldSpray, boolean pOverwrite = false) := function
	
		// function that trim's leading and trailing white spaces and uppercases the given string. 
		trimAndUCase(string str) := function
		  return stringlib.StringToUpperCase(trim(str, left, right));
		end;
		
		// function to format date from mm/dd/ccyy to ccyymmdd.
		formatDate(string indate) := function
		   DateFinder := '^([0-9]{1,2})/([0-9]{1,2})/([0-9]{4})$';	
			
			in_Date := trim(indate, left,right);
			outDate := if(regexfind(DateFinder,in_Date),
                          intformat((integer)regexfind(DateFinder,in_Date,3),4,1) +
  		                  intformat((integer)regexfind(DateFinder,in_Date,1),2,1) +
		                  intformat((integer)regexfind(DateFinder,in_Date,2),2,1),
	   	                  '');						  

		    return (outDate);
		end;
		
		Layout_For_Corp_In := record
		   string1 rec_type := '';
		   Layouts_Raw_Input.Entities;
		   Layouts_Raw_Input.Mergers;
		   string Name_EntityName := '';
		   Layouts_Raw_Input.Names and not [Entity_ID, EntityName];
		   string state_desc   := '';
		   string Country_desc := '';
		   string chapter_cd   := '';
		   string chapter_desc := '';
		end;
		
		Layout_For_Corp_In trfEntityToCommonCorp(Layouts_Raw_Input.Entities l) := transform
		    self.chapter_cd := if (trim(l.chapter) <> '', trimAndUcase(l.chapter)[8..],'');
		    self := l;
			self := [];
		end;
		
		Entitys_In_Common_Corp := project(Files_Raw_Input.VendorEntities(filedate), trfEntityToCommonCorp(left));
		
		ded_Entity_recs := dedup(sort(Files_Raw_Input.VendorEntities(filedate), Entity_ID, local), Entity_ID, local);
		//ded_Entity_recs := dedup(sort(Files_Raw_Input.VendorEntities(filedate), Entity_ID), Entity_ID);
		
		Layout_For_Corp_In trfMergerToCommonCorp(Layouts_Raw_Input.Mergers l, Layouts_Raw_Input.Entities  r) := transform
		   self.rec_type            := 'M';
		   self.Entity_ID           := r.Entity_ID;
		   self.MergerDate          := l.MergerDate;
		   self.MergerType          := l.MergerType;
		   self.MergedEntityName    := l.MergedEntityName;
		   self.MergedEntity_ID     := l.MergedEntity_ID;
		   self.SurvivingEntity_ID  := l.SurvivingEntity_ID;		   
		   self                     := [];
		end;
		
		Merger_In_Common_Corp := join(Files_Raw_Input.VendorMergers(filedate), ded_Entity_recs, 
		                              (integer)trim(left.SurvivingEntity_ID,left,right) = (integer)trim(right.Entity_ID,left,right),
							      	  trfMergerToCommonCorp(left,right), local);
		
				
		Layout_For_Corp_In  trfNameToCommonCorp(Layouts_Raw_Input.Names l, Layouts_Raw_Input.Entities r) := transform, 
																		skip(trimAndUcase(l.EntityNameType) = 'ACTUAL')
		   self.rec_type             := 'N';
		   self.Entity_ID            := r.Entity_ID;
		   self.Name_EntityName      := l.EntityNAme;
		   self.EntityNameType       := l.EntityNameType;
		   self.FileDate             := l.FileDate;
		   self.AbandonedDate        := l.AbandonedDate;
		   self.EntityTypeDescriptor := l.EntityTypeDescriptor;
		   self                      := [];
		end;
		
		Name_In_Common_Corp := join(Files_Raw_Input.VendorNames(filedate), ded_Entity_recs, 
		                            (integer)trim(left.entity_id,left,right) = (integer)trim(right.entity_id,left,right),
				 		            trfNameToCommonCorp(left, right), local);
		
		In_Corp_Records := sort(distribute(Entitys_In_Common_Corp + 
		                                   Merger_In_Common_Corp  +
								           Name_In_Common_Corp, hash64(Entity_ID)), Entity_ID, rec_type, local);
		
		Layout_Common_Cont := record
			Layouts_Raw_Input.Officers;
			Layouts_Raw_Input.Entities.EntityName;
			string Country_desc;
		end;
		
		Layout_Common_Cont getEntityNameCont(Layouts_Raw_Input.Officers l, Layouts_Raw_Input.Entities  r) := transform
		   self.EntityName := r.EntityName;
		   self            := l;
		   self            := [];
		end;
		
		Officer_Recs_Cont := join(Files_Raw_Input.VendorOfficers(fileDate), ded_Entity_recs,
		                          (integer)trim(left.Entity_id,left,right) = (integer)trim(right.Entity_id,left,right),
								  getEntityNameCont(left,right), left outer, local
								 );
		
		// ********************* Code Translations ***************************************************
		Layout_For_Corp_In getCountryCorp(Layout_For_Corp_In l, Layouts_Lookup.Layout_Country r) := transform
		    self.Country_desc := r.desc;
		    self              := l;
		end;
		
		J1 := join(In_Corp_Records, File_Lookups.Country, 
		           trimAndUcase(left.BusinessCountry) = trimAndUcase(right.code),
		           getCountryCorp(left, right), left outer, lookup);
	
	    Layout_For_Corp_In getStateCorp(Layout_For_Corp_In l, Layouts_Lookup.Layout_state r) := transform
		    self.state_desc := r.desc;
		    self            := l;
		end;
		
		J2 := join(J1, File_Lookups.foreign_state_code, 
		           trimAndUcase(left.StateOfIncorp) = trimAndUcase(right.code),
		           getStateCorp(left, right), left outer, lookup);
				   
	    Layout_For_Corp_In getChapterCorp(Layout_For_Corp_In l, Layouts_Lookup.Layout_filings r) := transform
		    self.chapter_desc := r.filing_desc;
		    self              := l;
		end;
		
		J3 := join(J2, File_Lookups.corp_filings, 
		           trimAndUcase(left.chapter_cd) = trimAndUcase(right.filing_code),
		           getChapterCorp(left, right), left outer, lookup);
		
				
		Layout_Common_Cont getCountryCont(Layout_Common_Cont l, Layouts_Lookup.Layout_Country r) := transform
		    self.country_desc := r.desc;
			self              := l;			
		end;
		
		Recs_For_Contact := join(Officer_Recs_Cont, File_Lookups.Country,
		                         trimAndUcase(left.Bus_CountryCode) = trimAndUcase(right.code),
		                         getCountryCont(left, right), left outer, lookup);
		   
		// **********************End Translations  ***************************************************
		
		
		//************************************** CORP ***********************************************
		Corp2.Layout_Corporate_Direct_Corp_In  trfCleanCorp(Layout_For_Corp_In l) := transform		
			string73 tempname 					:= stringlib.StringToUpperCase(if(trim(l.AgentName,left,right) = '', 
			                                                                      '', Address.CleanPerson73(trim(l.AgentName,left,right))));
			pname 								:= Address.CleanNameFields(tempName);
			cname 								:= DataLib.companyclean(trimAndUCase(l.AgentName));
			keepPerson 							:= corp2.Rewrite_Common.IsPerson(trim(l.AgentName));
			keepBusiness 						:= corp2.Rewrite_Common.IsCompany(trim(l.AgentName));
			
			self.corp_ra_title1					:= if(keepPerson, pname.title, '');
			self.corp_ra_fname1 				:= if(keepPerson, pname.fname, '');
			self.corp_ra_mname1 				:= if(keepPerson, pname.mname, '');
			self.corp_ra_lname1 				:= if(keepPerson, pname.lname, '');
			self.corp_ra_name_suffix1 			:= if(keepPerson, pname.name_suffix, '');
			self.corp_ra_score1 				:= if(keepPerson, pname.name_score, '');
		
			self.corp_ra_cname1 				:= if(keepBusiness, cname[1..70],'');
			self.corp_ra_cname1_score 			:= if(keepBusiness, pname.name_score, '');
			
			string182 clean_address 			:= stringlib.StringToUpperCase(
													 if(trim(l.BusinessAddr1,left,right) +
													    trim(l.BusinessAddr2,left,right) +
														trim(l.BusinessCity,left,right)  +
														trim(l.BusinessState,left,right) +
														trim(l.BusinessAddr1,left,right) <> '', 
													    Address.CleanAddress182(trim(trim(l.BusinessAddr1,left,right) + ' ' +
																					 trim(l.BusinessAddr2,left,right),left,right),
																			    trim(trim(l.BusinessCity,left,right) + ', ' +
																					 trim(l.BusinessState,left,right) + ' ' +
																					 stringlib.stringfilter(l.BusinessZip,'0123456789'),left,right)
																			    ),''));	
			
			cp_addr                             := Address.CleanAddressFieldsFips(clean_address);
			
			string182 clean_ra_address 			:= stringlib.StringToUpperCase(
			                                         if(trim(l.AgentAddr1,left,right) +
													    trim(l.AgentAddr2,left,right) +
														trim(l.AgentCity,left,right)  +
														trim(l.AgentState,left,right) +
														trim(l.AgentZip,left,right) <> '',
													    Address.CleanAddress182(trim(trim(l.AgentAddr1,left,right) + ' ' +
																					 trim(l.AgentAddr2,left,right),left,right),
																			    trim(trim(l.AgentCity,left,right) + ', ' +
																					 trim(l.AgentState,left,right) + ' ' +
																					 stringlib.stringfilter(l.AgentZip,'0123456789'),left,right)
																			    ),''));
																			   
			ra_addr                             := Address.CleanAddressFieldsFips(clean_ra_address);
			
			self.corp_addr1_prim_range    		:= cp_addr.prim_range;
			self.corp_addr1_predir 	      		:= cp_addr.predir;
			self.corp_addr1_prim_name 	  		:= cp_addr.prim_name;
			self.corp_addr1_addr_suffix   		:= cp_addr.addr_suffix;
			self.corp_addr1_postdir 	    	:= cp_addr.postdir;
			self.corp_addr1_unit_desig 	  		:= cp_addr.unit_desig;
			self.corp_addr1_sec_range 	  		:= cp_addr.sec_range;
			self.corp_addr1_p_city_name	  		:= cp_addr.p_city_name;
			self.corp_addr1_v_city_name	  		:= cp_addr.v_city_name;
			self.corp_addr1_state 			    := cp_addr.st;
			self.corp_addr1_zip5 		      	:= cp_addr.zip;
			self.corp_addr1_zip4 		      	:= cp_addr.zip4;
			self.corp_addr1_cart 		      	:= cp_addr.cart;
			self.corp_addr1_cr_sort_sz 	 		:= cp_addr.cr_sort_sz;
			self.corp_addr1_lot 		    	:= cp_addr.lot;
			self.corp_addr1_lot_order 	  		:= cp_addr.lot_order;
			self.corp_addr1_dpbc 		    	:= cp_addr.dbpc;
			self.corp_addr1_chk_digit 	  		:= cp_addr.chk_digit;
			self.corp_addr1_rec_type			:= cp_addr.rec_type;
			self.corp_addr1_ace_fips_st	  		:= cp_addr.fips_state;
			self.corp_addr1_county 	  			:= cp_addr.fips_county;
			self.corp_addr1_geo_lat 	    	:= cp_addr.geo_lat;
			self.corp_addr1_geo_long 	    	:= cp_addr.geo_long;
			self.corp_addr1_msa 		    	:= cp_addr.msa;
			self.corp_addr1_geo_blk				:= cp_addr.geo_blk;
			self.corp_addr1_geo_match 	  		:= cp_addr.geo_match;
			self.corp_addr1_err_stat 	    	:= cp_addr.err_stat;
																				
			self.corp_ra_prim_range    			:= ra_addr.prim_range;
			self.corp_ra_predir 	      		:= ra_addr.predir;
			self.corp_ra_prim_name 	  			:= ra_addr.prim_name;
			self.corp_ra_addr_suffix   			:= ra_addr.addr_suffix;
			self.corp_ra_postdir 	    		:= ra_addr.postdir;
			self.corp_ra_unit_desig 	  		:= ra_addr.unit_desig;
			self.corp_ra_sec_range 	  			:= ra_addr.sec_range;
			self.corp_ra_p_city_name	  		:= ra_addr.p_city_name;
			self.corp_ra_v_city_name	  		:= ra_addr.v_city_name;
			self.corp_ra_state 			      	:= ra_addr.st;
			self.corp_ra_zip5 		      		:= ra_addr.zip;
			self.corp_ra_zip4 		      		:= ra_addr.zip4;
			self.corp_ra_cart 		      		:= ra_addr.cart;
			self.corp_ra_cr_sort_sz 	 		:= ra_addr.cr_sort_sz;
			self.corp_ra_lot 		      		:= ra_addr.lot;
			self.corp_ra_lot_order 	  			:= ra_addr.lot_order;
			self.corp_ra_dpbc 		      		:= ra_addr.dbpc;
			self.corp_ra_chk_digit 	  			:= ra_addr.chk_digit;
			self.corp_ra_rec_type		  		:= ra_addr.rec_type;
			self.corp_ra_ace_fips_st	  		:= ra_addr.fips_state;
			self.corp_ra_county 	  			:= ra_addr.fips_county;
			self.corp_ra_geo_lat 	    		:= ra_addr.geo_lat;
			self.corp_ra_geo_long 	    		:= ra_addr.geo_long;
			self.corp_ra_msa 		      		:= ra_addr.msa;
			self.corp_ra_geo_blk				:= ra_addr.geo_blk;
			self.corp_ra_geo_match 	  			:= ra_addr.geo_match;
			self.corp_ra_err_stat 	    		:= ra_addr.err_stat;
			
			self.dt_first_seen					:= fileDate;
			self.dt_last_seen					:= fileDate;
			self.dt_vendor_first_reported		:= fileDate;
			self.dt_vendor_last_reported		:= fileDate;
			self.corp_ra_dt_first_seen			:= fileDate;
			self.corp_ra_dt_last_seen			:= fileDate;
			
			self.corp_key						:= '44-' + (string)(integer)trimAndUCase(l.Entity_ID);
			self.corp_vendor					:= '44';
			self.corp_state_origin				:= 'RI';
			self.corp_process_date				:= fileDate;
			self.corp_orig_sos_charter_nbr		:= (string)(integer)trimAndUCase(l.Entity_ID);
			self.corp_src_type					:= 'SOS';
									
			self.corp_address1_type_cd          := if (trim(clean_address) <> '', 'B', '');
			self.corp_address1_type_desc        := if (trim(clean_address) <> '', 'BUSINESS', '');
			self.corp_address1_line1            := if (trim(l.BusinessAddr1) = '#','',trimAndUCase(l.BusinessAddr1));
			self.corp_address1_line2            := if (trim(l.BusinessAddr2) = '#','',trimAndUCase(l.BusinessAddr2));
			self.corp_address1_line3            := if (trim(l.BusinessCity)  = '#','',trimAndUCase(l.BusinessCity));
			self.corp_address1_line4            := if (trim(l.BusinessState) = '#','',trimAndUCase(l.BusinessState));
			self.corp_address1_line5            := stringlib.stringfilter(l.BusinessZip, '0123456789');
			self.corp_address1_line6            := if (trimAndUCase(l.BusinessCountry) in ['US','USA','#'],'',trimAndUCase(l.Country_desc));
			
			self.corp_ra_name                   := trimAndUCase(l.AgentName);
			
			self.corp_ra_address_type_cd        := '';
			self.corp_ra_address_type_desc      := if (trim(clean_ra_address) <> '','REGISTERED ADDRESS','');
			self.corp_ra_address_line1          := trimAndUCase(l.AgentAddr1);
			self.corp_ra_address_line2          := trimAndUCase(l.AgentAddr2);
			self.corp_ra_address_line3          := trimAndUCase(l.AgentCity);
			self.corp_ra_address_line4          := trimAndUCase(l.AgentState);
			self.corp_ra_address_line5          := stringlib.stringfilter(l.AgentZip, '0123456789');
			
			self.corp_legal_name                := map(l.rec_type = ''  => trimAndUCase(l.EntityName), 
			                                           l.rec_type = 'N' => trimAndUcase(l.Name_EntityName),
													   l.rec_type = 'M' => trimAndUcase(l.MergedEntityName),
													   ''
													  );
			self.corp_ln_name_type_cd           := map(l.rec_type = ''  => '01',
			                                           l.rec_type = 'N' => map(trimAndUCase(l.EntityNameType) = 'CHG_NAME'             => 'P',
																		       trimAndUCase(l.EntityNameType) = 'FICTITIOUS'           => 'F',
																			   trimAndUCase(l.EntityNameType) = 'FICTITIOUS (FOREIGN)' => 'F',
																			   trimAndUCase(l.EntityNameType) = 'REGISTRATION'         => '09',
																			   trimAndUCase(l.EntityNameType) = 'RESERVATION'          => '07',
																			   ''
																			  ),
													   ''
													  );
			self.corp_ln_name_type_desc         := map(l.rec_type = 'N' => map(self.corp_ln_name_type_cd = 'P'  => 'PRIOR',
																			   self.corp_ln_name_type_cd = 'F'  => 'FBN',
																			   self.corp_ln_name_type_cd = '09' => 'REGISTRATION',
																			   self.corp_ln_name_type_cd = '07' => 'RESERVED',
																			   ''
																			),
													   l.rec_type = 'M' => 'NON-SURVIVOR',
													   'LEGAL'
													  );

			self.corp_status_cd					:= ''; //trimAndUCase(l.Status);
			self.corp_status_desc				:= if (trim(l.Status) = '' and l.rec_type = '', 'ACTIVE',
													   map (l.rec_type = ''  =>
															 if (stringlib.StringFindCount(l.Status, '/') >= 2,'', 
																 trimAndUCase(l.Status)),
															l.rec_type = 'N' => if (trim(l.AbandonedDate,left,right) <> '', 'ABANDONED',''),
															''
														   )
													  );
			self.corp_status_date				:= map(l.rec_type = 'N' => formatDate(l.AbandonedDate),'');
			
			self.corp_orig_org_structure_desc   := map(l.rec_type = 'N' => trimAndUcase(l.EntityTypeDescriptor),
			                                           l.rec_type = ''  => trimAndUCase(l.Charter),
													   ''
			                                           );
			
			self.corp_orig_bus_type_desc        := trimAndUCase(l.Purpose);

            self.corp_inc_state                 := if (trimAndUCase(l.StateOfIncorp) = self.corp_state_origin, 
													   trimAndUCase(l.StateOfIncorp), '');
			
			self.corp_inc_date                  := if (trimAndUCase(l.StateOfIncorp) = self.corp_state_origin, 
													   if(_validate.date.fIsValid(formatDate(l.DateOfOrganization)),
													      formatDate(l.DateOfOrganization),''),
													  '');
			
			self.corp_forgn_date                := if (trimAndUCase(l.StateOfIncorp) <> self.corp_state_origin and 
			                                           trim(l.StateOfIncorp,left,right) <> '', formatDate(l.DateOfOrganization), '');
													   
			self.corp_forgn_state_cd            := if (trimAndUCase(l.StateOfIncorp) not in ['#','RI',''], trimAndUCase(l.StateOfIncorp), '');
			
			self.corp_forgn_state_desc          := if (self.corp_forgn_state_cd <> '', trimAndUCase(l.state_desc), '');			
			
			self.corp_filing_date               := map(l.rec_type = 'M' => if(_validate.date.fIsValid(formatDate(l.MergerDate)) and
			                                                                  _validate.date.fIsValid(formatDate(l.MergerDate),_validate.date.rules.DateInPast),
			                                                                  formatDate(l.MergerDate),''), 
			                                           l.rec_type = 'N' => if(_validate.date.fIsValid(formatDate(l.FileDate)) and
													                          _validate.date.fIsValid(formatDate(l.FileDate),_validate.date.rules.DateInPast),
													                          formatDate(l.FileDate), ''),
													   ''
													  );
													   
			self.corp_term_exist_exp            := if (stringlib.StringFindCount(l.Duration, '/') >= 2, 
			                                           if(_validate.date.fIsValid(formatDate(l.Duration)), 
													      formatDate(l.Duration),''),'');													   
			
			self.corp_term_exist_cd             := if (trimAndUCase(l.Duration) = 'PERPETUAL', 'P',
			                                           if(self.corp_term_exist_exp <> '', 'D',''));
			
			self.corp_term_exist_desc           := map(self.corp_term_exist_cd = 'D' => 'EXPIRATION DATE',
			                                           self.corp_term_exist_cd = 'P' => 'PERPETUAL',
													   ''
													  );
		
			addl_info1                          := if (trim(l.Chapter,left,right) <> '', 
			                                           'CHAPTER: ' + trimAndUcase(l.Chapter) + 
													    if(trim(l.chapter_desc) <> '', ' '+trim(l.chapter_desc),''), '');
			
			addl_info2                          := if (trim(l.EffectDate,left,right) <> '', 
												       if (addl_info1 <> '', '; EFFECTIVE DATE: ' + formatDate(l.EffectDate),
													       'EFFECTIVE DATE: ' + formatDate(l.EffectDate)), '');
														   
			addl_info3                          := if (trim(l.MergedEntity_ID,left,right) <> '', 
			                                           'NON-SURVIVING CHARTER NUMBER: ' + (string)(integer)trimAndUcase(l.MergedEntity_ID),'');
			
			self.corp_addl_info                 :=  map(l.rec_type = ''  => addl_info1 +
																		    addl_info2,
													    l.rec_type = 'M' => addl_info3,
														''
													   );

			self.corp_ra_addl_info              := if (trimAndUcase(l.IsAgentResigned) = 'Y', 'RESIGNED', '');
			
			self								:= l;
			self 								:= [];
		end;
		
		MapCleanCorp := project(J3, trfCleanCorp(left));
		//************************************** End ***********************************************
						
		//************************************** Cont **********************************************
		Corp2.Layout_Corporate_Direct_Cont_In trfCont(Layout_Common_Cont l) := transform
			string73 tempname 				:= stringlib.StringToUpperCase(if(trim(l.FirstName,left,right) + 
			                                                                  trim(l.LastName,left,right) <> '',
			                                                                  Address.CleanPersonFML73(trim(trim(l.FirstName,left,right)  + ' ' +
																			                                trim(l.MiddleName,left,right) + ' ' +
																											trim(l.LastName,left,right)   + ' ' +
																											trim(l.Suffix,left,right),left,right)),
																		      ''));
																				 
			pname 							:= Address.CleanNameFields(tempName);
			
			string182 clean_address 		:= stringlib.StringToUpperCase(
			                                     if(trim(l.Bus_StreetAddr,left,right) +
												    trim(l.Bus_City,left,right) +
													trim(l.Bus_State,left,right) +
													trim(l.Bus_PostalCode,left,right) <> '',
												   Address.CleanAddress182(trim(l.Bus_StreetAddr,left,right),
																		   trim(trim(l.Bus_City,left,right) + ', ' +
																				trim(l.Bus_State,left,right) + ' ' +
																				stringlib.stringfilter(l.Bus_PostalCode,'0123456789'),
																				left,right
																				)
																		   ),''));	
			caddr                           := Address.CleanAddressFieldsFips(clean_address);
			
			self.cont_title1				:= pname.title;
			self.cont_fname1 				:= pname.fname;
			self.cont_mname1 				:= pname.mname;
			self.cont_lname1 				:= pname.lname;
			self.cont_name_suffix1 			:= pname.name_suffix;
			self.cont_score1 				:= pname.name_score;
			
			self.cont_prim_range            := caddr.prim_range;
			self.cont_predir                := caddr.predir;
			self.cont_prim_name             := caddr.prim_name;
			self.cont_addr_suffix           := caddr.addr_suffix;
			self.cont_postdir               := caddr.postdir;
			self.cont_unit_desig            := caddr.unit_desig;
			self.cont_sec_range             := caddr.sec_range;
			self.cont_p_city_name           := caddr.p_city_name;
			self.cont_v_city_name           := caddr.v_city_name;
			self.cont_state                 := caddr.st;
			self.cont_zip5                  := caddr.zip;
			self.cont_zip4                  := caddr.zip4;
			self.cont_cart                  := caddr.cart;
			self.cont_cr_sort_sz            := caddr.cr_sort_sz;
			self.cont_lot                   := caddr.lot;
			self.cont_lot_order             := caddr.lot_order;
			self.cont_dpbc                  := caddr.dbpc;
			self.cont_chk_digit             := caddr.chk_digit;
			self.cont_rec_type              := caddr.rec_type;
			self.cont_ace_fips_st           := caddr.fips_state;
			self.cont_county                := caddr.fips_county;
			self.cont_geo_lat               := caddr.geo_lat;
			self.cont_geo_long              := caddr.geo_long;
			self.cont_msa                   := caddr.msa;
			self.cont_geo_blk               := caddr.geo_blk;
			self.cont_geo_match             := caddr.geo_match;
			self.cont_err_stat              := caddr.err_stat;
			
			self.corp_key					:= '44-' + (string)(integer)trimAndUCase(l.Entity_ID);
			self.corp_vendor				:= '44';		
			self.corp_state_origin			:= 'RI';
			self.corp_process_date			:= fileDate;
			self.dt_first_seen				:= fileDate;
			self.dt_last_seen				:= fileDate;

			self.corp_orig_sos_charter_nbr	:= (string)(integer)trimAndUCase(l.Entity_ID);
			self.corp_legal_name            := trimAndUCase(l.EntityName);
			
			self.cont_name         	 	    := stringlib.StringFindReplace(
												 trim(trimAndUCase(l.FirstName)  + ' ' + 
											          trimAndUCase(l.MiddleName) + ' ' +
											          trimAndUCase(l.LastName)   + ' ' +
											          trimAndUCase(l.Suffix),left,right),'  ', ' ');
											   
			self.cont_type_cd  		        := if (self.cont_name <> '', 'F','');
			self.cont_type_desc  		    := if (self.cont_name <> '', 'OFFICER','');
			self.cont_title1_desc		    := trimAndUCase(l.IndividualTitle);
			
			self.cont_address_line1         := if (trim(l.Bus_StreetAddr) in ['#'], '', trimAndUCase(l.Bus_StreetAddr));
			self.cont_address_line2         := if (trim(l.Bus_City) in ['#'], '', trimAndUCase(l.Bus_City));
			self.cont_address_line3         := if (trim(l.Bus_State) in ['#'], '', trimAndUCase(l.Bus_State));
			self.cont_address_line4         := stringlib.stringfilter(l.Bus_PostalCode, '0123456789');
			self.cont_address_line5         := if (trimAndUCase(l.Bus_CountryCode) in ['US','USA','#'], '', trimAndUCase(l.Country_desc));
			
			self.cont_address_type_cd       := if (trim(clean_address) <> '', 'B', '');
			self.cont_address_type_desc     := if (trim(clean_address) <> '', 'BUSINESS', '');

			self							:= [];
		end;
		
		MapCont := project(Recs_For_Contact, trfCont(left));		
		//************************************** End ************************************************

		//************************************** Events *********************************************
		Corp2.Layout_Corporate_Direct_Event_In  trfEvent(Layouts_Raw_Input.Amendments l) := transform 

			self.corp_key					:= '44-' + (string)(integer)trimAndUCase(l.Entity_ID);
			self.corp_vendor				:= '44';		
			self.corp_state_origin			:= 'RI';
			self.corp_process_date			:= fileDate;
			
			self.corp_sos_charter_nbr		:= (string)(integer)trimAndUCase(l.Entity_ID);
			
			self.event_filing_date     		:= if(_validate.date.fIsValid(formatDate(l.EffectiveDate)) and
			                                      _validate.date.fIsValid(formatDate(l.EffectiveDate),_validate.date.rules.DateInPast), 
			                                      formatDate(l.EffectiveDate), '');
			self.event_date_type_cd         := if (trim(self.event_filing_date) <> '','EFF','');
			self.event_date_type_desc       := if (trim(self.event_filing_date) <> '','EFFECTIVE','');
			self.event_filing_desc          := trimAndUCase(l.FilingName);
			self.event_desc                 := if (trim(l.comments) <> '',
			                                       trim(stringlib.StringFindReplace(trimAndUCase(l.Comments), '<BR>', ' '),left,right), '');
			
			self							:= [];
		end;
		
		MapEvent := project(Files_Raw_Input.VendorAmendments(fileDate)((integer)trim(Entity_ID) <> 0),
		                    trfEvent(left));		
		//************************************** End ************************************************
		
		//************************************** STOCK **********************************************
		Corp2.Layout_Corporate_Direct_Stock_In trfStock(Layouts_Raw_Input.Stocks l) := transform

			self.corp_key					:= '44-' + (string)(integer)trimAndUCase(l.Entity_ID);
			self.corp_vendor				:= '44';		
			self.corp_state_origin			:= 'RI';
			self.corp_process_date			:= fileDate;

			self.corp_sos_charter_nbr		:= (string)(integer)trimAndUCase(l.Entity_ID);
			self.stock_class         		:= trimAndUCase(l.StockClass);
			self.stock_Authorized_Nbr  		:= if ((integer)trim(l.AuthorizedNumber) <> 0, (string)(integer)trim(l.AuthorizedNumber), '');
			self.stock_nbr_par_shares  		:= if (trim(l.ParValuePerShare,left,right) in ['','0'], '', trim(l.ParValuePerShare,left,right));
			self.stock_shares_issued		:= if (trim(l.TotalIssuedOutstanding,left,right) not in ['','0'], 
			                                       trim(l.TotalIssuedOutstanding,left,right), '');
			self.stock_Addl_Info            := if (trim(l.Series) <> '','SERIES OF STOCK: '+ trimAndUcase(l.Series),'');
			self							:= [];
		end;
		
		MapStock := project(Files_Raw_Input.VendorStocks(fileDate)(trim(entity_ID,left,right) <> '' and (integer)entity_ID <> 0),
		                    trfStock(left));		
		//************************************** End ************************************************
		
		//************************************** AR **********************************************
		Corp2.Layout_Corporate_Direct_AR_In trfAnnualReport(Layouts_Raw_Input.Entities l) := transform, 
		                                                    skip ((integer)trim(l.LastAnnualRptYear,left,right) = 0)
		
			self.corp_key					:= '44-' + (string)(integer)trimAndUCase(l.Entity_ID);
			self.corp_vendor				:= '44';		
			self.corp_state_origin			:= 'RI';
			self.corp_process_date			:= filedate;
			
			self.corp_sos_charter_nbr		:= (string)(integer)trimAndUCase(l.Entity_ID);

			self.ar_year					:= if (stringlib.stringfilter(l.LastAnnualRptYear,'0123456789') <> '' and
												   _validate.date.fIsValid(stringlib.stringfilter(l.LastAnnualRptYear,'0123456789'), 
													                       _validate.date.Rules.YearValid),
												   stringlib.stringfilter(l.LastAnnualRptYear,'0123456789'),'');  

			self.ar_comment					:= 'LAST ANNUAL REPORT FILED YEAR';		
			self							:= [];
		end;
		
		MapAR := project(Files_Raw_Input.VendorEntities(filedate), trfAnnualReport(left));
				
		//************************************** End ************************************************
		
	VersionControl.macBuildNewLogicalFile(Constants.cluster + 'in::corp2::'+version+'::corp_RI'	,MapCleanCorp	,corp_out	,,,pOverwrite);		
	VersionControl.macBuildNewLogicalFile(Constants.cluster + 'in::corp2::'+version+'::cont_RI'	,MapCont			,cont_out	,,,pOverwrite);
	VersionControl.macBuildNewLogicalFile(Constants.cluster + 'in::corp2::'+version+'::event_RI',MapEvent			,event_out,,,pOverwrite);
	VersionControl.macBuildNewLogicalFile(Constants.cluster + 'in::corp2::'+version+'::stock_RI',MapStock			,stock_out,,,pOverwrite);
	VersionControl.macBuildNewLogicalFile(Constants.cluster + 'in::corp2::'+version+'::AR_RI'		,MapAR				,ar_out		,,,pOverwrite);
		                                                                                                                                                       
		Map_RI_As_Corp := parallel (
									 corp_out	
									,cont_out	
									,event_out
									,stock_out
									,ar_out		
									);
		result := 
		sequential(
			 if(pshouldspray = true,fSprayFiles('ri',filedate,pOverwrite := pOverwrite))
			,Map_RI_As_Corp
			,parallel(
				 fileservices.addsuperfile(Constants.cluster + 'in::corp2::sprayed::corp'	,Constants.cluster + 'in::corp2::'+version+'::corp_RI')
				,fileservices.addsuperfile(Constants.cluster + 'in::corp2::sprayed::cont'	,Constants.cluster + 'in::corp2::'+version+'::cont_RI')
				,fileservices.addsuperfile(Constants.cluster + 'in::corp2::sprayed::stock',Constants.cluster + 'in::corp2::'+version+'::stock_RI')									
				,fileservices.addsuperfile(Constants.cluster + 'in::corp2::sprayed::event',Constants.cluster + 'in::corp2::'+version+'::event_RI')
				,fileservices.addsuperfile(Constants.cluster + 'in::corp2::sprayed::AR'		,Constants.cluster + 'in::corp2::'+version+'::AR_RI')
			)
		);
					
		return result;
	end;
	
end;