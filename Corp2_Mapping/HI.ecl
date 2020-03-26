import corp2,corp2_mapping,corp2_raw_hi,scrubs,scrubs_corp2_mapping_hi_ar,
			 scrubs_corp2_mapping_hi_event,scrubs_corp2_mapping_hi_main,scrubs_corp2_mapping_hi_stock,
			 std,tools,ut,versioncontrol; 			 

export HI := MODULE 

	export Update(string fileDate, string version, boolean pShouldSpray = _Dataset().bShouldSpray, boolean pOverwrite = false, boolean pUseProd = Tools._Constants.IsDataland) := function

		state_origin			 			:= 'HI';
		state_fips	 				 		:= '15';
		state_desc	 			 			:= 'HAWAII';

		CompanyMaster 					:= dedup(sort(distribute(Corp2_Raw_HI.Files(fileDate,puseprod).Input.CompanyMaster.Logical,hash(filenumber,filesuffix)),record,local),record,local) : independent;
		CompanyOfficer 					:= dedup(sort(distribute(Corp2_Raw_HI.Files(fileDate,puseprod).Input.CompanyOfficer.Logical,hash(filenumber,filesuffix)),record,local),record,local) : independent;
		CompanyStock 						:= dedup(sort(distribute(Corp2_Raw_HI.Files(fileDate,puseprod).Input.CompanyStock.Logical,hash(filenumber,filesuffix)),record,local),record,local) : independent;
		CompanyTransaction 			:= dedup(sort(distribute(Corp2_Raw_HI.Files(fileDate,puseprod).Input.CompanyTransaction.Logical,hash(filenumber,filesuffix)),record,local),record,local) : independent;
		TTSMaster 							:= dedup(sort(distribute(Corp2_Raw_HI.Files(fileDate,puseprod).Input.TTSMaster.Logical,hash(filenumber,filesuffix)),record,local),record,local) : independent;
		TTSTransaction 					:= dedup(sort(distribute(Corp2_Raw_HI.Files(fileDate,puseprod).Input.TTSTransaction.Logical,hash(filenumber,filesuffix)),record,local),record,local) : independent;
	
		//Cleanup the name various versions of "HONOLULU".
		CompanyMasterFixed			:= project(CompanyMaster,
																			 transform(Corp2_Raw_HI.Layouts.CompanyMasterLayoutIn,
																								 self.mailcity				:= if(corp2.t2u(left.mailcity) in ['HONOLU'],'HONOLULU',left.mailcity);
																								 self.principalcity		:= if(corp2.t2u(left.principalcity) in ['HONOLU'],'HONOLULU',left.principalcity);
																								 self.agentcity				:= if(corp2.t2u(left.agentcity) in ['HONOLU'],'HONOLULU',left.agentcity);
																								 self									:= left;
																								)
																			 );
																			 
		//Per CI, remove records with a blank ttstradename to eliminate blank legal names
		TTSMasterFixed					:= project(TTSMaster(corp2.t2u(ttstradename)<>''),
																			 transform(Corp2_Raw_HI.Layouts.TTSMasterLayoutIn,
																								 self.ttsmailcity			:= if(corp2.t2u(left.ttsmailcity) in ['HONOLU'],'HONOLULU',left.ttsmailcity);
																								 self									:= left;																								 
																								)
																			 );

		TTSMaster_ZZ						:= TTSMasterFixed(corp2.t2u(filesuffix)='ZZ'); 	//"ZZ" - represents Tradename, Trademark & Servicemark records
		TTSMaster_NonZZ					:= TTSMasterFixed(corp2.t2u(filesuffix)<>'ZZ');	//"ZZ" - represents Tradename, Trademark & Servicemark records																			 
		
		currentyear 						:= (integer)StringLib.getdateYYYYMMDD()[1..4];		
		
		//********************************************************************
		// Join TTSMaster (filesuffix <> 'ZZ') with CompanyMaster file 
		//
		// Note: The filesuffix of 'ZZ' represents Tradename, Trademark and 
		//			 Servicemark owners who do not have a	business registration.
		//			 These owners are known as "unregistered owners".  Therefore,
		//			 a master record would not exist.  Only keep those records 
		// 			 that have an associated CompanyMaster record for the "NON ZZ"
		//			 records.
		//********************************************************************
		TTSMasterNonZZ					:= join(CompanyMasterFixed, TTSMaster_NonZZ,		
																	  left.filenumber = right.filenumber and
																	  left.filesuffix = right.filesuffix,
																	  transform(Corp2_Raw_HI.Layouts.TTSMasterLayoutIn,
																							ttsAddress 							 := corp2.t2u(right.ttsmailaddressline1)	+
																																				  corp2.t2u(right.ttsmailaddressline2)	+
																																				  corp2.t2u(right.ttsmailaddressline3)	+
																																				  corp2.t2u(right.ttsmailcity)				 	+
																																				  corp2.t2u(right.ttsmaillocality)		 	+
																																				  corp2.t2u(right.ttsmailpostalcode)	 	+
																																				  corp2.t2u(right.ttsmailcountry);
																							mailAddress 						 := corp2.t2u(left.mailaddressline1)			+
																																				  corp2.t2u(left.mailaddressline2)			+
																																				  corp2.t2u(left.mailaddressline3)			+
																																				  corp2.t2u(left.mailcity)				 			+
																																				  corp2.t2u(left.maillocality)					+
																																				  corp2.t2u(left.mailpostalcode)	 			+
																																				  corp2.t2u(left.mailcountry);
																							principalAddress 				 := corp2.t2u(left.principaladdressline1)	+
																																				  corp2.t2u(left.principaladdressline2)	+
																																				  corp2.t2u(left.principaladdressline3)	+
																																				  corp2.t2u(left.principalcity)					+
																																				  corp2.t2u(left.principallocality)			+
																																				  corp2.t2u(left.principalpostalcode)		+
																																				  corp2.t2u(left.principalcountry);																														
																							self.ttsmailaddressline1 := if(ttsAddress = mailAddress or ttsAddress = principalAddress,'',right.ttsmailaddressline1);
																							self.ttsmailaddressline2 := if(ttsAddress = mailAddress or ttsAddress = principalAddress,'',right.ttsmailaddressline2);
																							self.ttsmailaddressline3 := if(ttsAddress = mailAddress or ttsAddress = principalAddress,'',right.ttsmailaddressline3);
																							self.ttsmailcity 				 := if(ttsAddress = mailAddress or ttsAddress = principalAddress,'',right.ttsmailcity);
																							self.ttsmaillocality 		 := if(ttsAddress = mailAddress or ttsAddress = principalAddress,'',right.ttsmaillocality);
																							self.ttsmailpostalcode 	 := if(ttsAddress = mailAddress or ttsAddress = principalAddress,'',right.ttsmailpostalcode);
																							self.ttsmailcountry 		 := if(ttsAddress = mailAddress or ttsAddress = principalAddress,'',right.ttsmailcountry);
																						  self										 := right;
																						 ),
																	  inner,
																	  local
																	 );

		TTSMasterFiltered				:= TTSMasterNonZZ + TTSMaster_ZZ : independent;
		
		HasTermValues						:= corp2.t2u(CompanyMasterFixed.expirationdate)<>'' or  corp2.t2u(CompanyMasterFixed.term) <> '';
		MasterNoTermValues			:= CompanyMasterFixed(not(HasTermValues));
		MasterHasTermValues			:= CompanyMasterFixed(HasTermValues);

		//********************************************************************
		// Normalize CompanyMaster file 
		//********************************************************************
		Corp2_Raw_HI.Layouts.TempCompanyMasterLayoutIn NormCompanyTermTransform(Corp2_Raw_HI.Layouts.CompanyMasterLayoutIn l, integer c) := transform,
		skip(c = 1 and corp2.t2u(l.expirationdate) = '' or
				 c = 2 and corp2.t2u(l.term) = '')
				self.temp_term_date					:= choose(c,corp2.t2u(l.expirationdate),corp2.t2u(l.term));
				self 												:= l;
				self 												:= [];			
		end;

		NormHasTermValues			:= normalize(MasterHasTermValues, 2, NormCompanyTermTransform(left,counter)) : independent;			
		MasterNoTerm					:= project(MasterNoTermValues,
																		 transform(Corp2_Raw_HI.Layouts.TempCompanyMasterLayoutIn,
																							 self := left;
																							 self := [];
																							 )
																	  );
		
		NormCompanyMasterTerm := NormHasTermValues + MasterNoTerm;

		Corp2_Raw_HI.Layouts.TempCompanyMasterLayoutIn NormCompanyMasterNameTransform(Corp2_Raw_HI.Layouts.TempCompanyMasterLayoutIn l, integer c) := transform,
		skip(c = 2 and Corp2_Raw_HI.Functions.CorpLegalName(state_origin,state_desc,l.xrefname1) = '' or
				 c = 3 and Corp2_Raw_HI.Functions.CorpLegalName(state_origin,state_desc,l.xrefname2) = ''
				)
				self.temp_legal_name				:= choose(c,Corp2_Raw_HI.Functions.CorpLegalName(state_origin,state_desc,l.mastername),
																								Corp2_Raw_HI.Functions.CorpLegalName(state_origin,state_desc,l.xrefname1),
																								Corp2_Raw_HI.Functions.CorpLegalName(state_origin,state_desc,l.xrefname2)
																						 );
				self.temp_term_desc					:= choose(c,if(self.temp_legal_name<>'','M1',''),
																								if(self.temp_legal_name<>'','X1',''),
																								if(self.temp_legal_name<>'','X2','')
																						 );																						 
				self 												:= l;
		end;

		NormCompanyMasterName		:= distribute(normalize(NormCompanyMasterTerm, 3, NormCompanyMasterNameTransform(left,counter)),hash(filenumber,filesuffix)) : independent;

		//********************************************************************
		// Normalize TTSMaster file 
		//********************************************************************
		Corp2_Raw_HI.Layouts.TempTTSMasterLayoutIn NormTTSMasterNameTransform(Corp2_Raw_HI.Layouts.TTSMasterLayoutIn l, integer c) := transform,
		skip(c = 2 and Corp2_Raw_HI.Functions.CorpLegalName(state_origin,state_desc,l.ttsxrefname1)	= '' or
				 c = 3 and Corp2_Raw_HI.Functions.CorpLegalName(state_origin,state_desc,l.ttsxrefname2)	= ''
				)			
				self.temp_legal_name				:= choose(c,Corp2_Raw_HI.Functions.CorpLegalName(state_origin,state_desc,l.ttstradename),
																								Corp2_Raw_HI.Functions.CorpLegalName(state_origin,state_desc,l.ttsxrefname1),
																								Corp2_Raw_HI.Functions.CorpLegalName(state_origin,state_desc,l.ttsxrefname2)
																						 );

				self.temp_name_type_desc		:= choose(c,Corp2_Raw_HI.Functions.CorpLNNameTypeDesc(corp2.t2u(l.filesuffix),corp2.t2u(l.ttstradename)),
																								Corp2_Raw_HI.Functions.CorpLNNameTypeDesc(corp2.t2u(l.filesuffix),corp2.t2u(l.ttsxrefname1)),
																								Corp2_Raw_HI.Functions.CorpLNNameTypeDesc(corp2.t2u(l.filesuffix),corp2.t2u(l.ttsxrefname2))
																						 );																							
				self 												:= l;
				self 												:= [];			
		end;

		NormTTSMasterName				:= normalize(TTSMasterFiltered, 3, NormTTSMasterNameTransform(left,counter)) : independent;		

		Corp2_Raw_HI.Layouts.TempTTSMasterLayoutIn NormTTSMasterFilingTransform(Corp2_Raw_HI.Layouts.TempTTSMasterLayoutIn l, integer c) := transform,
		skip(c = 2 and Corp2_Mapping.fValidateDate(l.ttscertificationdate,'DD_MMM_CCYY').GeneralDate = '')
				self.temp_filing_date				:= choose(c,Corp2_Mapping.fValidateDate(l.ttsregistrationdate,'DD_MMM_CCYY').GeneralDate,
																								Corp2_Mapping.fValidateDate(l.ttscertificationdate,'DD_MMM_CCYY').GeneralDate
																						 );
				self.temp_filing_desc				:= choose(c,if(Corp2_Mapping.fValidateDate(l.ttsregistrationdate,'DD_MMM_CCYY').GeneralDate<>'','REGISTRATION',''),
																								if(Corp2_Mapping.fValidateDate(l.ttscertificationdate,'DD_MMM_CCYY').GeneralDate<>'','CERTIFICATION','')
																						 );			
				self 												:= l;
		end;

		NormTTSMaster						:= normalize(NormTTSMasterName, 2, NormTTSMasterFilingTransform(left,counter)) : independent;
		
		//********************************************************************
		// Process CompanyMaster file
		//********************************************************************
		Corp2_mapping.LayoutsCommon.Main CompanyMasterTransform(Corp2_Raw_HI.Layouts.TempCompanyMasterLayoutIn l) := transform
				self.dt_vendor_first_reported							:= (integer)filedate;
				self.dt_vendor_last_reported							:= (integer)filedate;
				self.dt_first_seen												:= (integer)filedate;
				self.dt_last_seen													:= (integer)filedate;
				self.corp_ra_dt_first_seen								:= (integer)filedate;
				self.corp_ra_dt_last_seen									:= (integer)filedate;
				//Note: the corp_key differs from the corp_orig_sos_charter_nbr in that the filesuffix appears before the file number.
				self.corp_key															:= corp2.t2u(state_fips + '-' + corp2.t2u(l.filesuffix) + '-' + corp2.t2u(l.filenumber));
				self.corp_vendor													:= state_fips;
				self.corp_state_origin										:= state_origin;			
				self.corp_process_date										:= filedate;		
				self.corp_orig_sos_charter_nbr 						:= corp2.t2u(l.filenumber + ' ' + l.filesuffix);
				self.corp_legal_name 											:= corp2.t2u(l.temp_legal_name); //cleaned earlier; see "Note" at top of attribute.
				self.corp_ln_name_type_cd   							:= if(corp2.t2u(l.temp_term_desc) = 'M1',Corp2_Raw_HI.Functions.CorpLNNameTypeCD(l.filesuffix),Corp2_Raw_HI.Functions.CorpLNNameTypeCD(l.temp_term_desc));
				self.corp_ln_name_type_desc 							:= if(corp2.t2u(l.temp_term_desc) = 'M1',Corp2_Raw_HI.Functions.CorpLNNameTypeDesc(l.filesuffix),Corp2_Raw_HI.Functions.CorpLNNameTypeDesc(l.temp_term_desc));
				self.corp_address1_type_cd 								:= if(Corp2_Mapping.fAddressExists(state_origin,state_desc,l.principaladdressline1,l.principaladdressline2+' '+l.principaladdressline3,l.principalcity,l.principallocality,l.principalpostalcode,l.principalcountry).ifAddressExists,'B','');
				self.corp_address1_type_desc 							:= if(Corp2_Mapping.fAddressExists(state_origin,state_desc,l.principaladdressline1,l.principaladdressline2+' '+l.principaladdressline3,l.principalcity,l.principallocality,l.principalpostalcode,l.principalcountry).ifAddressExists,'BUSINESS','');
				self.corp_address1_line1									:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.principaladdressline1,l.principaladdressline2+' '+l.principaladdressline3,l.principalcity,l.principallocality,l.principalpostalcode,l.principalcountry).AddressLine1;
				self.corp_address1_line2				 					:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.principaladdressline1,l.principaladdressline2+' '+l.principaladdressline3,l.principalcity,l.principallocality,l.principalpostalcode,l.principalcountry).AddressLine2;
				self.corp_address1_line3				 					:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.principaladdressline1,l.principaladdressline2+' '+l.principaladdressline3,l.principalcity,l.principallocality,l.principalpostalcode,l.principalcountry).AddressLine3;
				self.corp_prep_addr1_line1     						:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.principaladdressline1,l.principaladdressline2+' '+l.principaladdressline3,l.principalcity,l.principallocality,l.principalpostalcode,l.principalcountry).PrepAddrLine1;
				self.corp_prep_addr1_last_line 						:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.principaladdressline1,l.principaladdressline2+' '+l.principaladdressline3,l.principalcity,l.principallocality,l.principalpostalcode,l.principalcountry).PrepAddrLastLine;
				self.corp_address2_type_cd 								:= if(Corp2_Mapping.fAddressExists(state_origin,state_desc,l.mailaddressline1,l.mailaddressline2+' '+l.mailaddressline3,l.mailcity,l.maillocality,l.mailpostalcode,l.mailcountry).ifAddressExists,'M','');
				self.corp_address2_type_desc 							:= if(Corp2_Mapping.fAddressExists(state_origin,state_desc,l.mailaddressline1,l.mailaddressline2+' '+l.mailaddressline3,l.mailcity,l.maillocality,l.mailpostalcode,l.mailcountry).ifAddressExists,'MAILING','');
				self.corp_address2_line1									:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.mailaddressline1,l.mailaddressline2+' '+l.mailaddressline3,l.mailcity,l.maillocality,l.mailpostalcode,l.mailcountry).AddressLine1;
				self.corp_address2_line2				 					:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.mailaddressline1,l.mailaddressline2+' '+l.mailaddressline3,l.mailcity,l.maillocality,l.mailpostalcode,l.mailcountry).AddressLine2;
				self.corp_address2_line3				 					:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.mailaddressline1,l.mailaddressline2+' '+l.mailaddressline3,l.mailcity,l.maillocality,l.mailpostalcode,l.mailcountry).AddressLine3;				
				self.corp_prep_addr2_line1      					:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.mailaddressline1,l.mailaddressline2+' '+l.mailaddressline3,l.mailcity,l.maillocality,l.mailpostalcode,l.mailcountry).PrepAddrLine1;
				self.corp_prep_addr2_last_line 						:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.mailaddressline1,l.mailaddressline2+' '+l.mailaddressline3,l.mailcity,l.maillocality,l.mailpostalcode,l.mailcountry).PrepAddrLastLine;
				self.corp_filing_date											:= Corp2_Mapping.fValidateDate(l.organizationdate,'DD_MMM_CCYY').PastDate;
				self.corp_filing_desc											:= if(self.corp_filing_date<>'','ORGANIZATION','');				
				self.corp_status_cd												:= Corp2_Raw_HI.Functions.CorpStatusCD(l.status);
				self.corp_status_desc 										:= Corp2_Raw_HI.Functions.CorpStatusDesc(l.status);
				//corp_status_comment -> overloaded field
				self.corp_status_comment									:= if(length(corp2.t2u(l.status)) = 1 and regexfind('[[:digit:]]',l.status),'YEAR(S) SINCE LAST FILING: ' + corp2.t2u(l.status),'');
				self.corp_inc_state 											:= state_origin;																												
				self.corp_inc_date 												:= map(corp2.t2u(l.locality) = state_desc 											=> Corp2_Mapping.fValidateDate(l.incorporationdate,'DD_MMM_CCYY').PastDate,
																												 corp2.t2u(l.locality) = '' and corp2.t2u(l.country) = '' => Corp2_Mapping.fValidateDate(l.incorporationdate,'DD_MMM_CCYY').PastDate,
																												 ''
																												);
				self.corp_term_exist_cd 									:= map(Corp2_Mapping.fValidateDate(l.temp_term_date,'DD_MMM_CCYY').GeneralDate <> '' => 'D',
																												 corp2.t2u(l.temp_term_date) = 'PER' 																		       => 'P',
																												 ut.isNumeric(corp2.t2u(l.temp_term_date))																		 => 'N',
																												 ''
																												);
				self.corp_term_exist_exp 									:= map(self.corp_term_exist_cd = 'D' => Corp2_Mapping.fValidateDate(l.temp_term_date,'DD_MMM_CCYY').GeneralDate,
																												 self.corp_term_exist_cd = 'P' => '',
																												 self.corp_term_exist_cd = 'N' => corp2.t2u(l.temp_term_date),
																												 ''
																												);
				self.corp_term_exist_desc 								:= map(self.corp_term_exist_cd = 'D' => 'EXPIRATION DATE',
																												 self.corp_term_exist_cd = 'P' => 'PERPETUAL',
																												 self.corp_term_exist_cd = 'N' => 'NUMBER OF YEARS',
																												 ''
																												);
				self.corp_foreign_domestic_ind 						:= Corp2_Raw_HI.Functions.CorpForgnDomesticInd(l.filesuffix,l.companytype);
				self.corp_forgn_state_cd 									:= if(corp2.t2u(l.locality) not in [state_desc,''],Corp2_Raw_HI.Functions.CorpForgnStateCD(l.locality),'');
				self.corp_forgn_state_desc 								:= if(corp2.t2u(l.locality) not in [state_desc,''],Corp2_Raw_HI.Functions.CorpForgnStateDesc(l.locality),'');
				self.corp_forgn_date 											:= Corp2_Raw_HI.Functions.CorpForgnDate(l.locality,l.country,l.filesuffix,l.incorporationdate);
				self.corp_orig_org_structure_desc 				:= Corp2_Raw_HI.Functions.CorpOrigOrgStructureDesc(l.filesuffix,l.companytype);
				self.corp_for_profit_ind									:= map(corp2.t2u(l.filesuffix) in ['D1','F1'] => 'Y',
																												 corp2.t2u(l.filesuffix) in ['D2','F2'] => 'N',				
																												 ''
																												);
				//corp_orig_bus_type_desc -> overloaded field
				self.corp_orig_bus_type_desc							:= regexreplace('(\\.)$',corp2.t2u(l.purpose),''); //remove ending period
				self.corp_addl_info 											:= Corp2_Raw_HI.Functions.CorpAddlInfo(l.partnermaintenance,l.partnerterms,l.initialllcmembers,l.vote,l.consentname,l.similarname);
				self.corp_ra_full_name 										:= if(corp2.t2u(l.agentpersonname)<>'SERVICE TO:',Corp2_Raw_HI.Functions.CorpLegalName(state_origin,state_desc,l.agentpersonname),''); //see "Note" at top of attribute.
				self.corp_ra_address_type_cd							:= if(Corp2_Mapping.fAddressExists(state_origin,state_desc,l.agentaddressline1,l.agentaddressline2+' '+l.agentaddressline3,l.agentcity,l.agentlocality,l.agentpostalcode,l.agentcountry).ifAddressExists,'R','');
				self.corp_ra_address_type_desc						:= if(Corp2_Mapping.fAddressExists(state_origin,state_desc,l.agentaddressline1,l.agentaddressline2+' '+l.agentaddressline3,l.agentcity,l.agentlocality,l.agentpostalcode,l.agentcountry).ifAddressExists,'REGISTERED OFFICE','');
				self.corp_ra_address_line1								:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.agentaddressline1,l.agentaddressline2+' '+l.agentaddressline3,l.agentcity,l.agentlocality,l.agentpostalcode,l.agentcountry).AddressLine1;
				self.corp_ra_address_line2				 				:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.agentaddressline1,l.agentaddressline2+' '+l.agentaddressline3,l.agentcity,l.agentlocality,l.agentpostalcode,l.agentcountry).AddressLine2;
				self.corp_ra_address_line3				 				:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.agentaddressline1,l.agentaddressline2+' '+l.agentaddressline3,l.agentcity,l.agentlocality,l.agentpostalcode,l.agentcountry).AddressLine3;
				self.ra_prep_addr_line1										:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.agentaddressline1,l.agentaddressline2+' '+l.agentaddressline3,l.agentcity,l.agentlocality,l.agentpostalcode,l.agentcountry).PrepAddrLine1;
				self.ra_prep_addr_last_line								:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.agentaddressline1,l.agentaddressline2+' '+l.agentaddressline3,l.agentcity,l.agentlocality,l.agentpostalcode,l.agentcountry).PrepAddrLastLine;
				self.corp_country_of_formation						:= Corp2_Mapping.fCleanCountry(state_origin,state_desc,l.country).Country;
				self.corp_partner_terms										:= corp2.t2u(l.partnerterms);
				self.corp_llc_managed_desc								:= map(corp2.t2u(l.partnermaintenance) = 'MEM' => 'MEMBER MANAGED',
																												 corp2.t2u(l.partnermaintenance) = 'MGR' => 'MANAGER MANAGED',
																												 ''
																												);
				self.corp_nbr_of_initial_llc_members			:= if((integer)l.initialllcmembers=0,'',corp2.t2u(l.initialllcmembers));
				self.corp_purpose													:= regexreplace('(\\.)$',corp2.t2u(l.purpose),''); //remove ending period
				self.internalfield1								 				:= corp2.t2u(l.filesuffix);			//for scrubbing purposes		
				self.internalfield2								 				:= corp2.t2u(l.companytype);		//for scrubbing purposes				
				self.recordorigin													:= 'C';
				self 																			:= [];
		end;

		MapCompanyMaster				:= project(NormCompanyMasterName(corp2.t2u(filesuffix) <> 'ZZ'), CompanyMasterTransform(left)) : independent;

		//********************************************************************
		// Process CompanyOfficer file			
		//********************************************************************
		Corp2_mapping.LayoutsCommon.Main CompanyOfficerTransform(Corp2_Raw_HI.Layouts.TempMasterOfficerLayoutIn l) := transform,
		skip(corp2.t2u(l.personname) in ['VACANT',''])
				self.dt_vendor_first_reported							:= (integer)filedate;
				self.dt_vendor_last_reported							:= (integer)filedate;
				self.dt_first_seen												:= (integer)filedate;
				self.dt_last_seen													:= (integer)filedate;
				self.corp_ra_dt_first_seen								:= (integer)filedate;
				self.corp_ra_dt_last_seen									:= (integer)filedate;
				//Note: the corp_key differs from the corp_orig_sos_charter_nbr in that the filesuffix appears before the file number.				
				self.corp_key															:= corp2.t2u(state_fips + '-' + corp2.t2u(l.filesuffix) + '-' + corp2.t2u(l.filenumber));
				self.corp_vendor													:= state_fips;
				self.corp_state_origin										:= state_origin;			
				self.corp_process_date										:= filedate;		
				self.corp_orig_sos_charter_nbr 						:= corp2.t2u(l.filenumber + ' ' + l.filesuffix);
				self.corp_legal_name 											:= corp2.t2u(l.temp_legal_name); //cleaned earlier; see "Note" at top of attribute.
				self.corp_inc_state 											:= state_origin;																												
				self.cont_type_cd 												:= map(corp2.t2u(l.officertype) = 'OFFICER' => 'F',
																												 corp2.t2u(l.officertype) = 'MEMBER'  => 'M',
																												 corp2.t2u(l.officertype) = 'PARTNER' => 'M',
																												 ''
																												);
				self.cont_type_desc 											:= map(corp2.t2u(l.officertype) = 'OFFICER' => 'OFFICER',
																												 corp2.t2u(l.officertype) = 'MEMBER'  => 'MEMBER/MANAGER/PARTNER',
																												 corp2.t2u(l.officertype) = 'PARTNER' => 'MEMBER/MANAGER/PARTNER',
																												 ''
																												);
				self.cont_full_name 											:= Corp2_Raw_HI.Functions.CorpLegalName(state_origin,state_desc,l.personname); //see "Note" at top of attribute.
				self.cont_title1_desc 										:= if(self.cont_full_name<>'',Corp2_Raw_HI.Functions.ContTitleDesc(l.title,'1'),'');
				self.cont_title2_desc 										:= if(self.cont_full_name<>'',Corp2_Raw_HI.Functions.ContTitleDesc(l.title,'2'),'');
				self.cont_title3_desc 										:= if(self.cont_full_name<>'',Corp2_Raw_HI.Functions.ContTitleDesc(l.title,'3'),'');
				self.cont_title4_desc 										:= if(self.cont_full_name<>'',Corp2_Raw_HI.Functions.ContTitleDesc(l.title,'4'),'');
				self.cont_title5_desc 										:= if(self.cont_full_name<>'',Corp2_Raw_HI.Functions.ContTitleDesc(l.title,'5'),'');
				self.cont_effective_date									:= Corp2_Mapping.fValidateDate(l.startdate,'DD_MMM_CCYY').PastDate;
				self.recordorigin													:= 'T';				
				self 																			:= [];
		end;

		//This join ensures that every companyofficer has an associated companymaster record.
		CompanyMasterOfficer		:= join(NormCompanyMasterName,CompanyOfficer,
																		left.filenumber = right.filenumber and
																		left.filesuffix = right.filesuffix,
																		transform(Corp2_Raw_HI.Layouts.TempMasterOfficerLayoutIn,
																							self := left;
																							self := right;
																							),
																		inner,
																		local
																	 );

		CompanyOfficerMapped		:= project(CompanyMasterOfficer,CompanyOfficerTransform(left)) : independent;

		//********************************************************************
		// Normalize CompanyOfficer file on title
		// Note: The build process can only handle one title and this
		//			 transform normalizes the titles and places them all in 
		//			 cont_title1_desc and cleans up cont_title2_desc to 
		//       cont_title5_desc.
		//********************************************************************
		Corp2_mapping.LayoutsCommon.Main NormCompanyOfficerTransform(Corp2_mapping.LayoutsCommon.Main l, integer c) := transform,
		skip(c = 1 and corp2.t2u(l.cont_full_name) 	 = '' or
				 c = 2 and corp2.t2u(l.cont_title2_desc) = '' or
				 c = 3 and corp2.t2u(l.cont_title3_desc) = '' or
				 c = 4 and corp2.t2u(l.cont_title4_desc) = '' or 
				 c = 5 and corp2.t2u(l.cont_title5_desc) = ''
				)
				self.cont_title1_desc				:= choose(c,corp2.t2u(l.cont_title1_desc),
																								corp2.t2u(l.cont_title2_desc),
																								corp2.t2u(l.cont_title3_desc),
																								corp2.t2u(l.cont_title4_desc),
																								corp2.t2u(l.cont_title5_desc)
																						 );
				self.cont_title2_desc				:= '';
				self.cont_title3_desc				:= '';
				self.cont_title4_desc				:= '';
				self.cont_title5_desc				:= '';
				self 												:= l;
				self 												:= [];			
		end;

		MapCompanyOfficer				:= normalize(CompanyOfficerMapped, 5, NormCompanyOfficerTransform(left,counter)) : independent;		

		//********************************************************************
		// Process TTSMaster file		
		//********************************************************************
		Corp2_mapping.LayoutsCommon.Main TTSMasterTransform(Corp2_Raw_HI.Layouts.TempTTSMasterLayoutIn l) := transform
				self.dt_vendor_first_reported							:= (integer)fileDate;
				self.dt_vendor_last_reported							:= (integer)fileDate;
				self.dt_first_seen												:= (integer)fileDate;
				self.dt_last_seen													:= (integer)fileDate;
				self.corp_ra_dt_first_seen								:= (integer)fileDate;
				self.corp_ra_dt_last_seen									:= (integer)fileDate;
				//Note: the corp_key differs from the corp_orig_sos_charter_nbr in that the filesuffix appears before the file number.				
				self.corp_key															:= corp2.t2u(state_fips + '-' + corp2.t2u(l.filesuffix) + '-' + corp2.t2u(l.filenumber));
				self.corp_vendor													:= state_fips;
				self.corp_state_origin										:= state_origin;			
				self.corp_process_date										:= filedate;		
				self.corp_orig_sos_charter_nbr 						:= corp2.t2u(l.filenumber + ' ' + l.filesuffix);
				self.corp_legal_name 											:= corp2.t2u(l.temp_legal_name); //cleaned earlier; see "Note" at top of attribute.
				self.corp_status_desc 										:= if(corp2.t2u(l.ttstradetype) in ['TRADE MARK','SERVICE MARK'],Corp2_Raw_HI.Functions.CorpStatusDesc(l.ttsstatus),'');
				self.corp_ln_name_type_cd 								:= Corp2_Raw_HI.Functions.CorpLNNameTypeCD(l.filesuffix,l.ttstradetype);
				self.corp_ln_name_type_desc 							:= Corp2_Raw_HI.Functions.CorpLNNameTypeDesc(l.filesuffix,l.ttstradetype);
				self.corp_address1_type_cd								:= if(Corp2_Mapping.fAddressExists(state_origin,state_desc,l.ttsmailaddressline1,l.ttsmailaddressline2+' '+l.ttsmailaddressline3,l.ttsmailcity,l.ttsmaillocality,l.ttsmailpostalcode,l.ttsmailcountry).ifAddressExists,'TM','');
				self.corp_address1_type_desc							:= if(Corp2_Mapping.fAddressExists(state_origin,state_desc,l.ttsmailaddressline1,l.ttsmailaddressline2+' '+l.ttsmailaddressline3,l.ttsmailcity,l.ttsmaillocality,l.ttsmailpostalcode,l.ttsmailcountry).ifAddressExists,'TRADENAME/TRADEMARK/SERVICEMARK MAILING','');
				self.corp_address1_line1									:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.ttsmailaddressline1,l.ttsmailaddressline2+' '+l.ttsmailaddressline3,l.ttsmailcity,l.ttsmaillocality,l.ttsmailpostalcode,l.ttsmailcountry).AddressLine1;
				self.corp_address1_line2				 					:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.ttsmailaddressline1,l.ttsmailaddressline2+' '+l.ttsmailaddressline3,l.ttsmailcity,l.ttsmaillocality,l.ttsmailpostalcode,l.ttsmailcountry).AddressLine2;
				self.corp_address1_line3				 					:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.ttsmailaddressline1,l.ttsmailaddressline2+' '+l.ttsmailaddressline3,l.ttsmailcity,l.ttsmaillocality,l.ttsmailpostalcode,l.ttsmailcountry).AddressLine3;		
				self.corp_filing_date											:= if(corp2.t2u(l.ttstradetype) in ['SERVICE MARK'],Corp2_Mapping.fValidateDate(l.temp_filing_date,'CCYYMMDD').GeneralDate,'');
				self.corp_filing_desc											:= if(corp2.t2u(l.ttstradetype) in ['SERVICE MARK'],corp2.t2u(l.temp_filing_desc),'');
				self.corp_inc_state 											:= state_origin;
				self.corp_inc_date 												:= Corp2_Mapping.fValidateDate(l.ttscertificationdate,'DD_MMM_CCYY').PastDate;
				self.corp_term_exist_cd 									:= if(corp2.t2u(l.ttstradetype) in ['TRADE NAME','SERVICE MARK'] and Corp2_Mapping.fValidateDate(l.ttsexpirationdate,'DD_MMM_CCYY').GeneralDate<>'','D','');
				self.corp_term_exist_exp 									:= if(corp2.t2u(l.ttstradetype) in ['TRADE NAME','SERVICE MARK'],Corp2_Mapping.fValidateDate(l.ttsexpirationdate,'DD_MMM_CCYY').GeneralDate,'');
				self.corp_term_exist_desc 								:= if(corp2.t2u(l.ttstradetype) in ['TRADE NAME','SERVICE MARK'] and Corp2_Mapping.fValidateDate(l.ttsexpirationdate,'DD_MMM_CCYY').GeneralDate<>'','EXPIRATION DATE','');
				self.corp_for_profit_ind									:= map(corp2.t2u(l.filesuffix) in ['D1','F1'] => 'Y',
																												 corp2.t2u(l.filesuffix) in ['D2','F2'] => 'N',				
																												 ''
																												);				
				//corp_orig_bus_type_desc -> overloaded field
				self.corp_orig_bus_type_desc							:= regexreplace('(\\.)$',corp2.t2u(l.ttspurpose),''); //remove ending period
				self.corp_certificate_nbr 								:= corp2.t2u(l.certificatenumber);
				//corp_addl_info -> overloaded field
				self.corp_addl_info 											:= Corp2_Raw_HI.Functions.FormatDate(l.ttscertificationdate);
				self.corp_prep_addr1_line1     						:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.ttsmailaddressline1,l.ttsmailaddressline2+' '+l.ttsmailaddressline3,l.ttsmailcity,l.ttsmaillocality,l.ttsmailpostalcode,l.ttsmailcountry).PrepAddrLine1;
				self.corp_prep_addr1_last_line 						:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.ttsmailaddressline1,l.ttsmailaddressline2+' '+l.ttsmailaddressline3,l.ttsmailcity,l.ttsmaillocality,l.ttsmailpostalcode,l.ttsmailcountry).PrepAddrLastLine;
				self.corp_name_effective_date							:= if(corp2.t2u(l.ttstradetype)='TRADE NAME',Corp2_Mapping.fValidateDate(l.ttsregistrationdate,'DD_MMM_CCYY').PastDate,'');
				self.corp_name_status_desc								:= if(corp2.t2u(l.ttstradetype)='TRADE NAME',corp2.t2u(l.ttsstatus),'');
				self.corp_purpose													:= regexreplace('(\\.)$',corp2.t2u(l.ttspurpose),''); //remove ending period
				self.corp_trademark_expiration_date				:= if(corp2.t2u(l.ttstradetype)='TRADE MARK',Corp2_Mapping.fValidateDate(l.ttsexpirationdate,'DD_MMM_CCYY').GeneralDate,'');
				self.corp_trademark_filing_date						:= if(corp2.t2u(l.ttstradetype)='TRADE MARK',Corp2_Mapping.fValidateDate(l.ttsregistrationdate,'DD_MMM_CCYY').GeneralDate,'');				
				self.internalfield1								 				:= corp2.t2u(l.filesuffix);				//for scrubbing purposes
				self.internalfield2								 				:= corp2.t2u(l.ttscompanytype);		//for scrubbing purposes
				self.recordorigin													:= 'C';
				self 																			:= [];
		end;

		MapTTSMaster 						:= project(NormTTSMaster,TTSMasterTransform(left)) : independent;
		
		//********************************************************************
		// Process TTSMaster "REGISTRANTS" file
		//********************************************************************
		Corp2_mapping.LayoutsCommon.Main	TTSMasterRegistrantsTransform(Corp2_Raw_HI.Layouts.TempTTSMasterLayoutIn l) := transform,
		skip(corp2.t2u(l.ttsregistrant) in ['VACANT',''])
				self.dt_vendor_first_reported							:= (integer)filedate;
				self.dt_vendor_last_reported							:= (integer)filedate;
				self.dt_first_seen												:= (integer)filedate;
				self.dt_last_seen													:= (integer)filedate;
				self.corp_ra_dt_first_seen								:= (integer)filedate;
				self.corp_ra_dt_last_seen									:= (integer)filedate;
				//Note: the corp_key differs from the corp_orig_sos_charter_nbr in that the filesuffix appears before the file number.				
				self.corp_key															:= corp2.t2u(state_fips + '-' + corp2.t2u(l.filesuffix) + '-' + corp2.t2u(l.filenumber));
				self.corp_vendor													:= state_fips;
				self.corp_state_origin										:= state_origin;			
				self.corp_process_date										:= filedate;		
				self.corp_orig_sos_charter_nbr 						:= corp2.t2u(l.filenumber + ' ' + l.filesuffix);
				self.corp_legal_name 											:= corp2.t2u(l.temp_legal_name); //cleaned earlier; see "Note" at top of attribute.
				self.corp_inc_state 											:= state_origin;
				self.cont_type_cd 												:= '02';
				self.cont_type_desc 											:= 'REGISTRANT';
				self.cont_full_name 											:= Corp2_Raw_HI.Functions.CorpLegalName(state_origin,state_desc,l.ttsregistrant); //see "Note" at top of attribute.
				self.recordorigin													:= 'T';				
				self 																			:= [];
		end;
	
		MapTTSMasterRegistrants := project(NormTTSMaster(corp2.t2u(ttsregistrant) <> ''),TTSMasterRegistrantsTransform(left)) : independent;

		MapMain 								:= dedup(sort(distribute(MapCompanyMaster + MapTTSMaster + MapCompanyOfficer + MapTTSMasterRegistrants,hash(corp_key)),record,local),record,local);

		//********************************************************************
		// Process CompanyMaster file for "ANNUAL REPORT" data
		//********************************************************************
		Corp2_mapping.LayoutsCommon.AR CompanyMasterARTransform(Corp2_Raw_HI.Layouts.CompanyMasterLayoutIn l,integer c) := transform,
		skip(c = 2 and corp2.t2u(l.annualfilingyear2)	= '' or
				 c = 3 and corp2.t2u(l.annualfilingyear3)	= ''
				)
				//Note: the corp_key differs from the corp_sos_charter_nbr in that the filesuffix appears before the file number.				
				self.corp_key															:= corp2.t2u(state_fips + '-' + corp2.t2u(l.filesuffix) + '-' + corp2.t2u(l.filenumber));
				self.corp_vendor													:= state_fips;
				self.corp_state_origin										:= state_origin;
				self.corp_process_date										:= fileDate;
				self.corp_sos_charter_nbr   			     		:= corp2.t2u(l.filenumber + ' ' + l.filesuffix);
				self.ar_year															:= choose(c,Corp2_Raw_HI.Functions.ARYear(l.annualfilingyear1,currentyear),
																															Corp2_Raw_HI.Functions.ARYear(l.annualfilingyear2,currentyear),
																															Corp2_Raw_HI.Functions.ARYear(l.annualfilingyear3,currentyear)
																													 );
				self.ar_status	 													:= choose(c,Corp2_Raw_HI.Functions.ARStatusComment(l.annualfilingstatus1),
																															Corp2_Raw_HI.Functions.ARStatusComment(l.annualfilingstatus2),
																															Corp2_Raw_HI.Functions.ARStatusComment(l.annualfilingstatus3)
																													 );																													 
				//Note: ar_comment continues to be mapped until ar_status (a new "AR" field) is customer facing.
				self.ar_comment	 													:= self.ar_status;
				self 																			:= [];
		end; 

		MapAllAR	  						:= normalize(CompanyMasterFixed, 3, CompanyMasterARTransform(left,counter)) : independent;
		MapAR 									:= dedup(sort(distribute(MapAllAR(corp2.t2u(ar_year+ar_status+ar_comment)<>''),hash(corp_key)),record,local),record,local);

		//********************************************************************
		// Process CompanyTransaction file
		//********************************************************************
		Corp2_mapping.LayoutsCommon.Events CompanyTransactionTransform(Corp2_Raw_HI.Layouts.CompanyTransactionLayoutIn l) := transform		
				//Note: the corp_key differs from the corp_sos_charter_nbr in that the filesuffix appears before the file number.								
				self.corp_key															:= corp2.t2u(state_fips + '-' + corp2.t2u(l.filesuffix) + '-' + corp2.t2u(l.filenumber));
				self.corp_vendor													:= state_fips;
				self.corp_state_origin										:= state_origin;
				self.corp_process_date										:= fileDate;
				self.corp_sos_charter_nbr   			     		:= corp2.t2u(l.filenumber + ' ' + l.filesuffix);
				self.event_filing_date 										:= Corp2_Mapping.fValidateDate(l.effectivedate,'DD_MMM_CCYY').PastDate;
				self.event_date_type_cd 									:= 'EFF';
				self.event_date_type_desc 								:= 'EFFECTIVE';				
				self.event_filing_cd											:= corp2.t2u(l.transid);
				self.event_filing_desc										:= regexreplace('(\\?)*',corp2.t2u(l.transdesc),'');
				self.event_desc 													:= corp2.t2u(l.remarks);
				self 																			:= [];
		end;

		// Join with CompanyMaster to eliminate those records that do not have a matching 
		// CompanyMaster record.
		CompanyTransactionMaster:= join(CompanyMasterFixed, CompanyTransaction,		
																	  left.filenumber = right.filenumber and
																	  left.filesuffix = right.filesuffix,
																	  transform(Corp2_Raw_HI.Layouts.CompanyTransactionLayoutIn,
																							self := right;
																						 ),
																	  inner,
																	  local
																	 );
																	 
		MapCompanyTransaction 	:= project(CompanyTransactionMaster,CompanyTransactionTransform(left)) : independent;

		//********************************************************************
		// Process TTSTransaction file		
		//********************************************************************
		Corp2_mapping.LayoutsCommon.Events TTSTransactionTransform(Corp2_Raw_HI.Layouts.TTSTransactionLayoutIn l) := transform		
				//Note: the corp_key differs from the corp_sos_charter_nbr in that the filesuffix appears before the file number.						
				self.corp_key															:= corp2.t2u(state_fips + '-' + corp2.t2u(l.filesuffix) + '-' + corp2.t2u(l.filenumber));
				self.corp_vendor													:= state_fips;
				self.corp_state_origin										:= state_origin;
				self.corp_process_date										:= fileDate;
				self.corp_sos_charter_nbr   			     		:= corp2.t2u(l.filenumber + ' ' + l.filesuffix);
				self.event_filing_date 										:= Corp2_Mapping.fValidateDate(l.ttstranseffectivedate,'DD_MMM_CCYY').GeneralDate;
				self.event_date_type_cd 									:= 'EFF';
				self.event_date_type_desc 								:= 'EFFECTIVE';				
				self.event_filing_cd											:= corp2.t2u(l.ttstransid);
				self.event_filing_desc										:= regexreplace('(\\?)*',corp2.t2u(l.ttstransdesc),'');
				self.event_desc 													:= corp2.t2u(l.ttstransremarks);
				self 																			:= [];
		end;

		// Join with CompanyMaster to eliminate those records that do not have a matching 
		// CompanyMaster record.
		TTSTransactionMaster		:= join(CompanyMasterFixed, TTSTransaction,		
																	  left.filenumber = right.filenumber and
																	  left.filesuffix = right.filesuffix,
																	  transform(Corp2_Raw_HI.Layouts.TTSTransactionLayoutIn,
																							self := right;
																						 ),
																	  inner,
																	  local
																	 );
																	 
		MapTTSTransaction 			:= project(TTSTransactionMaster,TTSTransactionTransform(left)) : independent;

		MapEvents								:= dedup(sort(distribute(MapCompanyTransaction + MapTTSTransaction,hash(corp_key)),record,local),record,local);
						
		//********************************************************************
		// Process CompanyStock file
		//********************************************************************	

		// Join with CompanyMaster to eliminate those records that do not have a matching 
		// CompanyMaster record.
		CompanyStockMaster			:= join(CompanyMasterFixed, CompanyStock,		
																	  left.filenumber = right.filenumber and
																	  left.filesuffix = right.filesuffix,
																	  transform(Corp2_Raw_HI.Layouts.CompanyStockLayoutIn,
																							self := right;
																						 ),
																	  inner,
																	  local
																	 );

		Corp2_mapping.LayoutsCommon.Stock CompanyStockTransform(Corp2_Raw_HI.Layouts.CompanyStockLayoutIn l) := transform
				//Note: the corp_key differs from the corp_sos_charter_nbr in that the filesuffix appears before the file number.						
				self.corp_key															:= corp2.t2u(state_fips + '-' + corp2.t2u(l.filesuffix) + '-' + corp2.t2u(l.filenumber));
				self.corp_vendor													:= state_fips;
				self.corp_state_origin										:= state_origin;
				self.corp_process_date										:= fileDate;
				self.corp_sos_charter_nbr   			     		:= corp2.t2u(l.filenumber + ' ' + l.filesuffix);
				self.stock_class 													:= Corp2_Raw_HI.Functions.StockClass(l.stockclass);
				self.stock_shares_issued 									:= Corp2_Raw_HI.Functions.StockSharesIssued(l.sharescount);
				self.stock_par_value 											:= Corp2_Raw_HI.Functions.StockParValue(l.parvalue);
				//Note: stock_total_capital is an overloaded field; can remove after new fields are customer facing.
				self.stock_total_capital 									:= Corp2_Raw_HI.Functions.StockTotalCapital(l.stockamount);
				self.stock_stock_description							:= if(Corp2_Mapping.fValidateDate(l.stockdate,'DD_MMM_CCYY').PastDate <> '',
																											  'AUTHORIZED CAPTIAL AS OF: '+ut.date_YYYYMMDDtoDateSlashed(Corp2_Mapping.fValidateDate(l.stockdate,'DD_MMM_CCYY').PastDate),
																												''
																											 );
				self.stock_number_of_shares_paid_for			:= Corp2_Raw_HI.Functions.SharesPaidFor(l.paidshares);
				self.stock_total_value_of_shares_paid_for := Corp2_Raw_HI.Functions.SharesPaidFor(l.stockamount);
				self 																			:= [];
		end;
															 
		MapCompanyStock 				:= project(CompanyStockMaster,CompanyStockTransform(left)) : independent;
					    	
		Corp2_mapping.LayoutsCommon.Stock CompanyStockLimitsTransform(Corp2_Raw_HI.Layouts.CompanyMasterLayoutIn l) := transform
				//Note: the corp_key differs from the corp_sos_charter_nbr in that the filesuffix appears before the file number.						
				self.corp_key															:= corp2.t2u(state_fips + '-' + corp2.t2u(l.filesuffix) + '-' + corp2.t2u(l.filenumber));
				self.corp_vendor													:= state_fips;
				self.corp_state_origin										:= state_origin;
				self.corp_process_date										:= fileDate;
				self.corp_sos_charter_nbr   			     		:= corp2.t2u(l.filenumber + ' ' + l.filesuffix);
				//Note: stock_change_date is an overloaded field; can remove after new fields are customer facing.
        self.stock_change_date 										:= Corp2_Mapping.fValidateDate(l.limitdate,'DD_MMM_CCYY').PastDate;
				self.stock_addl_info											:= Corp2_Raw_HI.Functions.StockAddlInfo(l.limit1);
				self.stock_date_stock_limit_approved			:= Corp2_Mapping.fValidateDate(l.limitdate,'DD_MMM_CCYY').PastDate;
				self 																			:= [];
		end;
		
		CompanyStockLimits 			:= CompanyMasterFixed(Corp2_Mapping.fValidateDate(limitdate,'DD_MMM_CCYY').PastDate <> '' or regexreplace('(\\-)*',limit1,'') <> '');		
		MapCompanyMaster2Stock 	:= project(CompanyStockLimits,CompanyStockLimitsTransform(left)) : independent;
	
		MapStock		 						:= dedup(sort(distribute(MapCompanyStock + MapCompanyMaster2Stock,hash(corp_key)),record,local),record,local);
		
		//********************************************************************
		// SCRUB AR 
		//********************************************************************	
		AR_F := MapAR;
		AR_S := Scrubs_Corp2_Mapping_HI_AR.Scrubs;				// Scrubs module
		AR_N := AR_S.FromNone(AR_F); 											// Generate the error flags
		AR_T := AR_S.FromBits(AR_N.BitmapInfile);     		// Use the FromBits module; makes my bitmap datafile easier to get to
		AR_U := AR_S.FromExpanded(AR_N.ExpandedInFile); 	// Pass the expanded error flags into the Expanded module

		//Outputs reports
		AR_ErrorSummary			 	 := output(AR_U.SummaryStats, named('AR_ErrorSummary_HI'+filedate));
		AR_ScrubErrorReport 	 := output(choosen(AR_U.AllErrors, 1000), named('AR_ScrubErrorReport_HI'+filedate));
		AR_SomeErrorValues		 := output(choosen(AR_U.BadValues, 1000), named('AR_SomeErrorValues_HI'+filedate));
		AR_IsScrubErrors		 	 := IF(count(AR_U.AllErrors)<> 0,true,false);

		// Orbit Stats
		AR_OrbitStats				 	 := AR_U.OrbitStats();

		//Outputs files
		AR_CreateBitMaps			 := output(AR_N.BitmapInfile,,'~thor_data::corp_HI_ar_scrubs_bits',overwrite,compressed);	//long term storage
		AR_TranslateBitMap		 := output(AR_T);
		
		//Submits Profile's stats to Orbit
		AR_SubmitStats 			   := Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_HI_AR','ScrubsAlerts', AR_OrbitStats, version,'Corp_HI_AR').SubmitStats;
		AR_ScrubsWithExamples  := Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_HI_AR','ScrubsAlerts', AR_OrbitStats, version,'Corp_HI_AR').CompareToProfile_with_Examples;

		AR_ScrubsAlert				 := AR_ScrubsWithExamples(RejectWarning = 'Y');
		AR_ScrubsAttachment	   := Scrubs.fn_email_attachment(AR_ScrubsAlert);
		AR_MailFile					   := FileServices.SendEmailAttachData(corp2.Email_Notification_Lists.AttachedList
																															,'Scrubs CorpAR_HI Report' //subject
																															,'Scrubs CorpAR_HI Report' //body
																															,(data)AR_ScrubsAttachment
																															,'text/csv'
																															,'Corp'+state_origin+'ARScrubsReport.csv'																															
																														);

		AR_BadRecords				 := AR_N.ExpandedInFile(
																								corp_key_Invalid							  			<> 0 or
																								corp_vendor_Invalid							  		<> 0 or
																								corp_state_origin_Invalid							<> 0 or
																								corp_process_date_Invalid							<> 0 or
																								corp_sos_charter_nbr_Invalid					<> 0 or
																								ar_year_Invalid							  				<> 0 or
																								ar_comment_Invalid							  		<> 0 or
																								ar_status_Invalid							  			<> 0
																							 );

		AR_GoodRecords			 := AR_N.ExpandedInFile(
																								corp_key_Invalid							  			= 0 and
																								corp_vendor_Invalid							  		= 0 and
																								corp_state_origin_Invalid							= 0 and
																								corp_process_date_Invalid							= 0 and
																								corp_sos_charter_nbr_Invalid					= 0 and
																								ar_year_Invalid					  						= 0 and
																								ar_comment_Invalid			  						= 0 and																								
																								ar_status_Invalid 										= 0	
																								);

		AR_FailBuild					 := if(count(AR_GoodRecords) = 0,true,false);

		AR_ApprovedRecords		 := project(AR_GoodRecords,transform(Corp2_Mapping.LayoutsCommon.AR,self := left;));


		AR_ALL								 := sequential(IF(count(AR_BadRecords) <> 0
																								 ,IF (poverwrite
																										 ,OUTPUT(AR_BadRecords,,Corp2_Mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::ar_'+state_origin,overwrite,__compressed__)
																										 ,OUTPUT(AR_BadRecords,,Corp2_Mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::ar_'+state_origin,__compressed__)
																										 )
																								 )
																						  ,output(AR_ScrubsWithExamples, ALL, NAMED('CorpAR'+state_origin+'ScrubsReportWithExamples'+filedate))
																							//Send Alerts if Scrubs exceeds thresholds
																							,IF(COUNT(AR_ScrubsAlert) > 0, AR_MailFile, OUTPUT('CORP2_MAPPING.HI - No "AR" Corp Scrubs Alerts'))
																							,AR_ErrorSummary
																							,AR_ScrubErrorReport
																							,AR_SomeErrorValues
																							,AR_SubmitStats
																					);

		//********************************************************************
		// SCRUB EVENT
		//********************************************************************	
		Event_F := MapEvents;
		Event_S := Scrubs_Corp2_Mapping_HI_Event.Scrubs;						// Scrubs module
		Event_N := Event_S.FromNone(Event_F); 											// Generate the error flags
		Event_T := Event_S.FromBits(Event_N.BitmapInfile);     			// Use the FromBits module; makes my bitmap datafile easier to get to
		Event_U := Event_S.FromExpanded(Event_N.ExpandedInFile); 		// Pass the expanded error flags into the Expanded module
		
		//Outputs reports
		Event_ErrorSummary				:= output(Event_U.SummaryStats, named('Event_ErrorSummary_HI'+filedate));
		Event_ScrubErrorReport 		:= output(choosen(Event_U.AllErrors, 1000), named('Event_ScrubErrorReport_HI'+filedate));
		Event_SomeErrorValues			:= output(choosen(Event_U.BadValues, 1000), named('Event_SomeErrorValues_HI'+filedate));
		Event_IsScrubErrors		 		:= IF(count(Event_U.AllErrors) <> 0,true,false);

		// Orbit Stats
		Event_OrbitStats					:= Event_U.OrbitStats();

		//Outputs files
		Event_CreateBitMaps				:= output(Event_N.BitmapInfile,,'~thor_data::corp_HI_event_scrubs_bits',overwrite,compressed);	//long term storage
		Event_TranslateBitMap			:= output(Event_T);

		//Submits Profile's stats to Orbit
		Event_SubmitStats 			 := Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_HI_Event','ScrubsAlerts', Event_OrbitStats, version,'Corp_HI_Event').SubmitStats;
		Event_ScrubsWithExamples := Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_HI_Event','ScrubsAlerts', Event_OrbitStats, version,'Corp_HI_Event').CompareToProfile_with_Examples;

		Event_ScrubsAlert					:= Event_ScrubsWithExamples(RejectWarning = 'Y');
		Event_ScrubsAttachment		:= Scrubs.fn_email_attachment(Event_ScrubsAlert);

		Event_MailFile						:= FileServices.SendEmailAttachData(corp2.Email_Notification_Lists.AttachedList
																																 ,'Scrubs CorpEvent_HI Report' //subject
																																 ,'Scrubs CorpEvent_HI Report' //body
																																 ,(data)Event_ScrubsAttachment
																																 ,'text/csv'
																																 ,'Corp'+state_origin+'EventScrubsReport.csv'
																																);
																																 
		Event_BadRecords				 	:= Event_N.ExpandedInFile(	
																												corp_key_Invalid							  			<> 0 or
																												corp_vendor_Invalid							  		<> 0 or
																												corp_state_origin_Invalid							<> 0 or
																												corp_process_date_Invalid							<> 0 or
																												corp_sos_charter_nbr_Invalid					<> 0 or
																												event_filing_date_Invalid							<> 0 or
																												event_filing_cd_Invalid								<> 0
																											 );
		
		Event_GoodRecords					:= Event_N.ExpandedInFile(	
																												corp_key_Invalid							  			= 0 and
																												corp_vendor_Invalid							  		= 0 and
																												corp_state_origin_Invalid							= 0 and
																												corp_process_date_Invalid							= 0 and
																												corp_sos_charter_nbr_Invalid					= 0 and
																												event_filing_date_Invalid							= 0 and
																												event_filing_cd_Invalid								= 0																												
																											);

		Event_FailBuild					  := if(count(Event_GoodRecords) = 0,true,false);

		Event_ApprovedRecords			:= project(Event_GoodRecords,transform(Corp2_Mapping.LayoutsCommon.Events,self := left));
	
		Event_ALL									:= sequential(IF(count(Event_BadRecords) <> 0
																											,IF (poverwrite
																													,OUTPUT(Event_BadRecords,,Corp2_Mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::event_'+state_origin,overwrite,__compressed__)
																													,OUTPUT(Event_BadRecords,,Corp2_Mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::event_'+state_origin,__compressed__)
																													)
																											)
																									 ,output(Event_ScrubsWithExamples, ALL, NAMED('CorpEvent'+state_origin+'ScrubsReportWithExamples'+filedate))
																									 //Send Alerts if Scrubs exceeds thresholds
																									 ,IF(COUNT(Event_ScrubsAlert) > 0, Event_MailFile, OUTPUT('CORP2_MAPPING.HI - No "EVENT" Corp Scrubs Alerts'))
																									 ,Event_ErrorSummary
																									 ,Event_ScrubErrorReport
																									 ,Event_SomeErrorValues		
																									 ,Event_SubmitStats
																								);

	//********************************************************************
  // SCRUB MAIN
  //********************************************************************	
		Main_F := MapMain;
		Main_S := Scrubs_Corp2_Mapping_HI_Main.Scrubs;					// Scrubs module
		Main_N := Main_S.FromNone(Main_F); 											// Generate the error flags
		Main_T := Main_S.FromBits(Main_N.BitmapInfile);     		// Use the FromBits module; makes my bitmap datafile easier to get to
		Main_U := Main_S.FromExpanded(Main_N.ExpandedInFile); 	// Pass the expanded error flags into the Expanded module
		
		//Outputs reports
		Main_ErrorSummary					:= output(Main_U.SummaryStats, named('Main_ErrorSummary_HI'+filedate));
		Main_ScrubErrorReport 		:= output(choosen(Main_U.AllErrors, 1000), named('Main_ScrubErrorReport_HI'+filedate));
		Main_SomeErrorValues			:= output(choosen(Main_U.BadValues, 1000), named('Main_SomeErrorValues_HI'+filedate));
		Main_IsScrubErrors		 		:= IF(count(Main_U.AllErrors)<> 0,true,false);

		// Orbit Stats
		Main_OrbitStats						:= Main_U.OrbitStats();

		//Outputs files
		Main_CreateBitMaps				:= output(Main_N.BitmapInfile,,'~thor_data::corp_HI_main_scrubs_bits',overwrite,compressed);	//long term storage
		Main_TranslateBitMap			:= output(Main_T);

		//Submits Profile's stats to Orbit
		Main_SubmitStats 			  := Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_HI_Main','ScrubsAlerts', Main_OrbitStats, version,'Corp_HI_Main').SubmitStats;
		Main_ScrubsWithExamples := Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_HI_Main','ScrubsAlerts', Main_OrbitStats, version,'Corp_HI_Main').CompareToProfile_with_Examples;

		Main_ScrubsAlert					:= Main_ScrubsWithExamples(RejectWarning = 'Y');
		Main_ScrubsAttachment			:= Scrubs.fn_email_attachment(Main_ScrubsAlert);
		Main_MailFile							:= FileServices.SendEmailAttachData(corp2.Email_Notification_Lists.AttachedList
																																 ,'Scrubs CorpMain_HI Report' //subject
																																 ,'Scrubs CorpMain_HI Report' //body
																																 ,(data)Main_ScrubsAttachment
																																 ,'text/csv'
																																 ,'Corp'+state_origin+'MainScrubsReport.csv'
																																 );
																																 
		Main_BadRecords						:= Main_N.ExpandedInFile(	
																											 dt_vendor_first_reported_Invalid 			<> 0 or
																											 dt_vendor_last_reported_Invalid 				<> 0 or
																											 dt_first_seen_Invalid 									<> 0 or
																											 dt_last_seen_Invalid 									<> 0 or
																											 corp_ra_dt_first_seen_Invalid 					<> 0 or
																											 corp_ra_dt_last_seen_Invalid 					<> 0 or
																											 corp_key_Invalid 											<> 0 or
																											 corp_vendor_Invalid 										<> 0 or
																											 corp_state_origin_Invalid 							<> 0 or
																											 corp_process_date_Invalid 							<> 0 or
																											 corp_orig_sos_charter_nbr_Invalid 			<> 0 or
																											 corp_legal_name_Invalid 								<> 0 or
																											 corp_ln_name_type_cd_Invalid 					<> 0 or
																											 corp_ln_name_type_desc_Invalid 				<> 0 or
																											 corp_address1_type_cd_Invalid 					<> 0 or
																											 corp_address1_type_desc_Invalid  			<> 0 or
																											 corp_address1_line3_Invalid  					<> 0 or
																											 corp_address2_type_cd_Invalid  				<> 0 or
																											 corp_address2_type_desc_Invalid  			<> 0 or
																											 corp_address2_line3_Invalid 						<> 0 or
																											 corp_filing_date_Invalid 							<> 0 or
																											 corp_filing_desc_Invalid 							<> 0 or
																											 corp_status_date_Invalid								<> 0 or
																											 corp_inc_state_Invalid 								<> 0 or
																											 corp_inc_date_Invalid 									<> 0 or
																											 corp_term_exist_cd_Invalid							<> 0 or
																											 corp_term_exist_exp_Invalid						<> 0 or
																											 corp_term_exist_desc_Invalid						<> 0 or
																											 corp_foreign_domestic_ind_Invalid			<> 0 or
																											 corp_forgn_state_cd_Invalid 						<> 0 or
																											 corp_forgn_state_desc_Invalid 					<> 0 or
																											 corp_forgn_date_Invalid 								<> 0 or
																											 corp_for_profit_ind_Invalid						<> 0 or
																											 corp_certificate_nbr_Invalid 					<> 0 or
																											 corp_ra_effective_date_Invalid 				<> 0 or
																											 corp_ra_address_type_cd_Invalid 				<> 0 or
																											 corp_ra_address_type_desc_Invalid 			<> 0 or
																											 corp_ra_address_line3_Invalid 					<> 0 or
																											 cont_type_cd_Invalid 									<> 0 or
																											 cont_type_desc_Invalid 								<> 0 or
																											 corp_country_of_formation_Invalid 			<> 0 or
																											 corp_llc_managed_desc_Invalid 					<> 0 or
																											 corp_name_effective_date_Invalid 			<> 0 or
																											 corp_name_status_desc_Invalid 					<> 0 or
																											 corp_trademark_expiration_date_Invalid <> 0 or
																											 recordorigin_Invalid					 					<> 0 or
																											 internalfield1_Invalid					 				<> 0 or
																											 internalfield2_Invalid					 				<> 0
																										);

		Main_GoodRecords					:= Main_N.ExpandedInFile(
																										 	 dt_vendor_first_reported_Invalid 			= 0 and
																											 dt_vendor_last_reported_Invalid 				= 0 and
																											 dt_first_seen_Invalid 									= 0 and
																											 dt_last_seen_Invalid 									= 0 and
																											 corp_ra_dt_first_seen_Invalid 					= 0 and
																											 corp_ra_dt_last_seen_Invalid 					= 0 and
																											 corp_key_Invalid 											= 0 and
																											 corp_vendor_Invalid 										= 0 and
																											 corp_state_origin_Invalid 							= 0 and
																											 corp_process_date_Invalid 							= 0 and
																											 corp_orig_sos_charter_nbr_Invalid 			= 0 and
																											 corp_legal_name_Invalid 								= 0 and
																											 corp_ln_name_type_cd_Invalid 					= 0 and
																											 corp_ln_name_type_desc_Invalid 				= 0 and
																											 corp_address1_type_cd_Invalid 					= 0 and
																											 corp_address1_type_desc_Invalid  			= 0 and
																											 corp_address1_line3_Invalid  					= 0 and
																											 corp_address2_type_cd_Invalid  				= 0 and
																											 corp_address2_type_desc_Invalid  			= 0 and
																											 corp_address2_line3_Invalid 						= 0 and
																											 corp_filing_date_Invalid 							= 0 and
																											 corp_filing_desc_Invalid 							= 0 and
																											 corp_status_date_Invalid								= 0 and
																											 corp_inc_state_Invalid 								= 0 and
																											 corp_inc_date_Invalid 									= 0 and
																											 corp_term_exist_cd_Invalid							= 0 and
																											 corp_term_exist_exp_Invalid						= 0 and
																											 corp_term_exist_desc_Invalid						= 0 and
																											 corp_foreign_domestic_ind_Invalid			= 0 and
																											 corp_forgn_state_cd_Invalid 						= 0 and
																											 corp_forgn_state_desc_Invalid 					= 0 and
																											 corp_forgn_date_Invalid 								= 0 and
																											 corp_for_profit_ind_Invalid						= 0 and
																											 corp_certificate_nbr_Invalid 					= 0 and
																											 corp_ra_effective_date_Invalid 				= 0 and
																											 corp_ra_address_type_cd_Invalid 				= 0 and
																											 corp_ra_address_type_desc_Invalid 			= 0 and
																											 corp_ra_address_line3_Invalid 					= 0 and
																											 cont_type_cd_Invalid 									= 0 and
																											 cont_type_desc_Invalid 								= 0 and
																											 corp_country_of_formation_Invalid 			= 0 and
																											 corp_llc_managed_desc_Invalid 					= 0 and
																											 corp_name_effective_date_Invalid 			= 0 and
																											 corp_name_status_desc_Invalid 					= 0 and
																											 corp_trademark_expiration_date_Invalid = 0 and
-																											 recordorigin_Invalid					 					= 0 and
																											 internalfield1_Invalid					 				= 0 and
																											 internalfield2_Invalid					 				= 0																											 
																										);
																										
		Main_FailBuild					:= map( corp2_mapping.fCalcPercent(count(Main_N.ExpandedInFile(corp_key_invalid<>0)),count(Main_N.ExpandedInFile),false) 										> Scrubs_Corp2_Mapping_HI_Main.Threshold_Percent.CORP_KEY										 => true,
																		corp2_mapping.fCalcPercent(count(Main_N.ExpandedInFile(corp_orig_sos_charter_nbr_invalid<>0)),count(Main_N.ExpandedInFile),false) 	> Scrubs_Corp2_Mapping_HI_Main.Threshold_Percent.CORP_ORIG_SOS_CHARTER_NBR 	 => true,
																		corp2_mapping.fCalcPercent(count(Main_N.ExpandedInFile(corp_legal_name_invalid<>0)),count(Main_N.ExpandedInFile),false) 						> Scrubs_Corp2_Mapping_HI_Main.Threshold_Percent.CORP_LEGAL_NAME 						 => true,
																		corp2_mapping.fCalcPercent(count(Main_N.ExpandedInFile(corp_inc_date_invalid<>0)),count(Main_N.ExpandedInFile),false) 							> Scrubs_Corp2_Mapping_HI_Main.Threshold_Percent.CORP_INC_DATE 						 	 => true,
																		corp2_mapping.fCalcPercent(count(Main_N.ExpandedInFile(internalfield1_Invalid<>0)),count(Main_N.ExpandedInFile),false) 							> Scrubs_Corp2_Mapping_HI_Main.Threshold_Percent.FILESUFFIX									 => true,																		
																		corp2_mapping.fCalcPercent(count(Main_N.ExpandedInFile(internalfield2_Invalid<>0)),count(Main_N.ExpandedInFile),false) 							> Scrubs_Corp2_Mapping_HI_Main.Threshold_Percent.COMPANYTYPE								 => true,																																				
																	  count(Main_GoodRecords) = 0																																																																																											 => true,																		
																		false
																	);

		Main_ApprovedRecords		:= project(Main_GoodRecords,transform(Corp2_Mapping.LayoutsCommon.Main,self := left));

		Main_ALL		 			:= sequential( IF(count(Main_BadRecords) <> 0
																							,IF (poverwrite
																									,OUTPUT(Main_BadRecords,,Corp2_Mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::main_'+state_origin,overwrite,__compressed__)
																									,OUTPUT(Main_BadRecords,,Corp2_Mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::main_'+state_origin,__compressed__)
																									)
																							)
																					,output(Main_ScrubsWithExamples, ALL, NAMED('CorpMain'+state_origin+'ScrubsReportWithExamples'+filedate))
																					//Send Alerts if Scrubs exceeds thresholds
																					,IF(COUNT(Main_ScrubsAlert) > 0, Main_MailFile, OUTPUT('CORP2_MAPPING.HI - No "MAIN" Corp Scrubs Alerts'))
																					,Main_ErrorSummary
																					,Main_ScrubErrorReport
																					,Main_SomeErrorValues		
																					,Main_SubmitStats
																			);

	//********************************************************************
  // SCRUB STOCK
  //********************************************************************	
		Stock_F := MapStock;
		Stock_S := Scrubs_Corp2_Mapping_HI_Stock.Scrubs;						// Scrubs module
		Stock_N := Stock_S.FromNone(Stock_F); 											// Generate the error flags
		Stock_T := Stock_S.FromBits(Stock_N.BitmapInfile);     			// Use the FromBits module; makes my bitmap datafile easier to get to
		Stock_U := Stock_S.FromExpanded(Stock_N.ExpandedInFile); 		// Pass the expanded error flags into the Expanded module

		//Outputs reports
		Stock_ErrorSummary			 	:= output(Stock_U.SummaryStats, named('Stock_ErrorSummary_HI'+filedate));
		Stock_ScrubErrorReport 	 	:= output(choosen(Stock_U.AllErrors, 1000), named('Stock_ScrubErrorReport_HI'+filedate));
		Stock_SomeErrorValues		 	:= output(choosen(Stock_U.BadValues, 1000), named('Stock_SomeErrorValues_HI'+filedate));
		Stock_IsScrubErrors		 	 	:= IF(count(Stock_U.AllErrors)<> 0,true,false);

		// Orbit Stats
		Stock_OrbitStats				 	:= Stock_U.OrbitStats();

		//Outputs files
		Stock_CreateBitMaps				:= output(Stock_N.BitmapInfile,,'~thor_data::corp_HI_scrubs_bits',overwrite,compressed);	//long term storage
		Stock_TranslateBitMap			:= output(Stock_T);

		//Submits Profile's stats to Orbit
		Stock_SubmitStats 			  := Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_HI_Stock','ScrubsAlerts', Stock_OrbitStats, version,'Corp_HI_Stock').SubmitStats;
		Stock_ScrubsWithExamples  := Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_HI_Stock','ScrubsAlerts', Stock_OrbitStats, version,'Corp_HI_Stock').CompareToProfile_with_Examples;

		Stock_ScrubsAlert					:= Stock_ScrubsWithExamples(RejectWarning = 'Y');
		Stock_ScrubsAttachment		:= Scrubs.fn_email_attachment(Stock_ScrubsAlert);
		Stock_MailFile						:= FileServices.SendEmailAttachData(corp2.Email_Notification_Lists.AttachedList
																																 ,'Scrubs CorpStock_HI Report' //subject
																																 ,'Scrubs CorpStock_HI Report' //body
																																 ,(data)Stock_ScrubsAttachment
																																 ,'text/csv'
																																 ,'Corp'+state_origin+'StockScrubsReport.csv'
																															);

		Stock_BadRecords					:= Stock_N.ExpandedInFile(	
																												corp_key_Invalid							  								<> 0 or
																												corp_vendor_Invalid 														<> 0 or
																												corp_state_origin_Invalid 					 						<> 0 or
																												corp_process_date_Invalid						  					<> 0 or
																												corp_sos_charter_nbr_Invalid										<> 0 or
																												stock_class_Invalid															<> 0 or
																												stock_shares_issued_Invalid											<> 0 or
																												stock_par_value_Invalid													<> 0 or
																												stock_change_date_Invalid												<> 0 or
																												stock_total_capital_Invalid											<> 0 or
																												stock_date_stock_limit_approved_Invalid					<> 0 or
																												stock_number_of_shares_paid_for_Invalid					<> 0 or
																												stock_total_value_of_shares_paid_for_Invalid	 	<> 0 
																											 );
																																							
		Stock_GoodRecords					:= Stock_N.ExpandedInFile(	
																												corp_key_Invalid							  								= 0 and
																												corp_vendor_Invalid 														= 0 and
																												corp_state_origin_Invalid 					 						= 0 and
																												corp_process_date_Invalid						  					= 0 and
																												corp_sos_charter_nbr_Invalid										= 0 and
																												stock_class_Invalid															= 0 and
																												stock_shares_issued_Invalid											= 0 and
																												stock_par_value_Invalid													= 0 and
																												stock_change_date_Invalid												= 0 and
																												stock_total_capital_Invalid											= 0 and
																												stock_date_stock_limit_approved_Invalid					= 0 and
																												stock_number_of_shares_paid_for_Invalid					= 0 and
																												stock_total_value_of_shares_paid_for_Invalid	 	= 0 																											 );
																														
		Stock_FailBuild						:= if(count(Stock_GoodRecords) = 0,true,false);

		Stock_ApprovedRecords			:= project(Stock_GoodRecords,transform(Corp2_Mapping.LayoutsCommon.Stock,self := left));

		Stock_ALL									:= sequential( IF(count(Stock_BadRecords) <> 0
																							,IF (poverwrite
																									,OUTPUT(Stock_BadRecords,,Corp2_Mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::stock_'+state_origin,overwrite,__compressed__)
																									,OUTPUT(Stock_BadRecords,,Corp2_Mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::stock_'+state_origin,__compressed__)
																									)
																							)
																					,output(Stock_ScrubsWithExamples, ALL, NAMED('CorpStockHIScrubsReportWithExamples'+filedate))
																					//Send Alerts if Scrubs exceeds thresholds
																					,IF(COUNT(Stock_ScrubsAlert) > 0, Stock_MailFile, OUTPUT('CORP2_MAPPING.HI - No "Stock" Corp Scrubs Alerts'))
																					,Stock_ErrorSummary
																					,Stock_ScrubErrorReport
																					,Stock_SomeErrorValues
																					,Stock_SubmitStats
																					);
																			
		//********************************************************************
		// UPDATE
		//********************************************************************	
		Fail_Build						:= if(AR_FailBuild = true or Event_FailBuild = true or Main_FailBuild = true or Stock_FailBuild = true,true,false);
		IsScrubErrors					:= if(AR_IsScrubErrors = true or Event_IsScrubErrors = true or Main_IsScrubErrors = true or Stock_IsScrubErrors = true,true,false);

		VersionControl.macBuildNewLogicalFile(Corp2_Mapping._dataset().thor_cluster_Files + 'in::corp2::' 	+ version + '::AR_' 		+ state_origin, AR_ApprovedRecords	 , write_ar,,,pOverwrite);
		VersionControl.macBuildNewLogicalFile(Corp2_Mapping._dataset().thor_cluster_Files + 'in::corp2::' 	+ version + '::Event_' 	+ state_origin, Event_ApprovedRecords, write_event,,,pOverwrite);
		VersionControl.macBuildNewLogicalFile(Corp2_Mapping._dataset().thor_cluster_Files + 'in::corp2::' 	+ version + '::Main_' 	+ state_origin, Main_ApprovedRecords , write_main,,,pOverwrite);
		VersionControl.macBuildNewLogicalFile(Corp2_Mapping._dataset().thor_cluster_Files + 'in::corp2::' 	+ version + '::Stock_' 	+ state_origin, Stock_ApprovedRecords, write_stock,,,pOverwrite);

		VersionControl.macBuildNewLogicalFile(Corp2_Mapping._dataset().thor_cluster_Files + 'fail::corp2::' + version + '::AR_' 		+ state_origin, AR_F		, write_fail_ar,,,pOverwrite);
		VersionControl.macBuildNewLogicalFile(Corp2_Mapping._dataset().thor_cluster_Files + 'fail::corp2::' + version + '::Event_' 	+ state_origin, Event_F	, write_fail_event,,,pOverwrite);
		VersionControl.macBuildNewLogicalFile(Corp2_Mapping._dataset().thor_cluster_Files + 'fail::corp2::' + version + '::Main_' 	+ state_origin, Main_F	, write_fail_main,,,pOverwrite);
		VersionControl.macBuildNewLogicalFile(Corp2_Mapping._dataset().thor_cluster_Files + 'fail::corp2::' + version + '::Stock_' 	+ state_origin, Stock_F	, write_fail_stock,,,pOverwrite);

		MapHI:= sequential ( if(pshouldspray = true,Corp2_mapping.fSprayFiles(state_origin,version,pOverwrite := pOverwrite))
												// ,Corp2_Raw_HI.Build_Bases(filedate,version,puseprod).All
												,AR_All
												,Event_All
												,Main_All
												,Stock_All
												,if(Fail_Build <> true	 
												 ,sequential (write_ar
																		 ,write_event
																		 ,write_main
																		 ,write_stock	
																		 ,fileservices.addsuperfile(Corp2_Mapping._Dataset().thor_cluster_Files + 'in::'+Corp2_Mapping._Dataset().NameMapped+'::sprayed::ar'		,Corp2_Mapping._Dataset().thor_cluster_Files + 'in::corp2::'+version+'::ar_'		+ state_origin)
																		 ,fileservices.addsuperfile(Corp2_Mapping._Dataset().thor_cluster_Files + 'in::'+Corp2_Mapping._Dataset().NameMapped+'::sprayed::event'	,Corp2_Mapping._Dataset().thor_cluster_Files + 'in::corp2::'+version+'::event_'	+ state_origin)
																		 ,fileservices.addsuperfile(Corp2_Mapping._Dataset().thor_cluster_Files + 'in::'+Corp2_Mapping._Dataset().NameMapped+'::sprayed::main'	,Corp2_Mapping._Dataset().thor_cluster_Files + 'in::corp2::'+version+'::main_'	+ state_origin)																		 
																		 ,fileservices.addsuperfile(Corp2_Mapping._Dataset().thor_cluster_Files + 'in::'+Corp2_Mapping._Dataset().NameMapped+'::sprayed::stock'	,Corp2_Mapping._Dataset().thor_cluster_Files + 'in::corp2::'+version+'::stock_'	+ state_origin)
																		 ,if (count(Main_BadRecords) <> 0 or count(AR_BadRecords) <> 0 or count(Event_BadRecords) <> 0 or count(Stock_BadRecords)<>0
																				 ,Corp2_Mapping.Send_Email(state_origin,version,count(Main_BadRecords)<>0,count(AR_BadRecords)<>0,count(Event_BadRecords)<>0,count(Stock_BadRecords)<>0,count(Main_BadRecords),count(AR_BadRecords),count(Event_BadRecords),count(Stock_BadRecords),count(Main_ApprovedRecords),count(AR_ApprovedRecords),count(Event_ApprovedRecords),count(Stock_ApprovedRecords)).RecordsRejected																				 
																				 ,Corp2_Mapping.Send_Email(state_origin,version,count(Main_BadRecords)<>0,count(AR_BadRecords)<>0,count(Event_BadRecords)<>0,count(Stock_BadRecords)<>0,count(Main_BadRecords),count(AR_BadRecords),count(Event_BadRecords),count(Stock_BadRecords),count(Main_ApprovedRecords),count(AR_ApprovedRecords),count(Event_ApprovedRecords),count(Stock_ApprovedRecords)).MappingSuccess
																				 )
																		 ,if (IsScrubErrors
																				 ,Corp2_Mapping.Send_Email(state_origin,version,Main_IsScrubErrors,AR_IsScrubErrors,Event_IsScrubErrors,Stock_IsScrubErrors).FieldsInvalidPerScrubs
																				 )
																		 ) //if Fail_Build <> true																			
												 ,sequential  (write_fail_ar
																		  ,write_fail_event
																		  ,write_fail_main
																		  ,write_fail_stock												 
																			,Corp2_Mapping.Send_Email(state_origin,version).MappingFailed
																		 ) //if Fail_Build = true
												 )
										);												
											
		isFileDateValid := if((string)std.date.today() between ut.date_math(filedate,-30) and ut.date_math(filedate,30),true,false);
		return sequential (	 if (isFileDateValid
														,MapHI
														,sequential (Corp2_Mapping.Send_Email(state_origin,filedate).InvalidFileDateParm
																				,FAIL('Corp2_Mapping.'+state_origin+' failed.  An invalid filedate was passed in as a parameter.')
																				)
														)
											);
	
	end;	// end of Update function

end; //end HI module 