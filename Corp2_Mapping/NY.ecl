import ut, std, corp2_raw_NY, tools, corp2, VersionControl, Scrubs_Corp2_Mapping_NY_Main, Scrubs_Corp2_Mapping_NY_Event, scrubs;

Export NY :=  MODULE; 
          
    Export Update(string fileDate, string version, boolean pShouldSpray = _Dataset().bShouldSpray,boolean pOverwrite = false, pUseProd = Tools._Constants.IsDataland, boolean pquarterlyReload = false) := function       
	
			state_origin	 := 'NY';
			state_fips	 	 := '36';	
			state_desc	 	 := 'NEW YORK';	       
		
      //---------------------------------------------------------------------------------------------------------			
			// Vendor Input Files
			//---------------------------------------------------------------------------------------------------------
			// On Quarterly Reloads, the Corp2_Raw_NY.Files attribute returns vendor input files created from just  
			//    the Quarterly Master Super file (split into 9 files by record type) and  
			//    the Quarterly Merger Super file.  
			
			// On Weekly Updates, the Corp2_Raw_NY.Files attribute returns vendor input files created from  
			//    a join of the Quarterly Master Super file to the Weekly Master Update file (split into 9 files) and  
			//    a join of the Quarterly Merger Super file to the Weekly Merger Update file
			
			// Files from Master   (one master file gets split by record type into 9 separate files/layouts)
			MasterFilein := dedup(sort(distribute(Corp2_Raw_NY.Files(filedate,pUseProd,pquarterlyReload).input.MasterFile,  hash(corpidno)),          record,local), record,local) : independent; 
			ProcAddrFile := dedup(sort(distribute(Corp2_Raw_NY.Files(filedate,pUseProd,pquarterlyReload).input.ProcAddrFile,hash(process_corpidno)),  record,local), record,local) : independent;     
			RegAgentFile := dedup(sort(distribute(Corp2_Raw_NY.Files(filedate,pUseProd,pquarterlyReload).input.RegAgentFile,hash(register_corpidno)), record,local), record,local) : independent; 
			FictNameFile := dedup(sort(distribute(Corp2_Raw_NY.Files(filedate,pUseProd,pquarterlyReload).input.FictNameFile,hash(fictname_corpidno)), record,local), record,local) : independent; 
			StockFile    := dedup(sort(distribute(Corp2_Raw_NY.Files(filedate,pUseProd,pquarterlyReload).input.StockFile,   hash(stock_corpidno)),    record,local), record,local) : independent; 
			ChairmanFile := dedup(sort(distribute(Corp2_Raw_NY.Files(filedate,pUseProd,pquarterlyReload).input.ChairmanFile,hash(chairman_corpidno)), record,local), record,local) : independent; 
			ExecOffFile  := dedup(sort(distribute(Corp2_Raw_NY.Files(filedate,pUseProd,pquarterlyReload).input.ExecOffFile, hash(executive_corpidno)),record,local), record,local) : independent; 
			OrigPartFile := dedup(sort(distribute(Corp2_Raw_NY.Files(filedate,pUseProd,pquarterlyReload).input.OrigPartFile,hash(origpart_corpidno)), record,local), record,local) : independent; 
			CurrPartFile := dedup(sort(distribute(Corp2_Raw_NY.Files(filedate,pUseProd,pquarterlyReload).input.CurrPartFile,hash(currpart_corpidno)), record,local), record,local) : independent; 
      
			// File from Merger	   (only one layout for merger file records)		
			MergerFile   := dedup(sort(distribute(Corp2_Raw_NY.Files(filedate,pUseProd,pquarterlyReload).input.MergerUnload,hash(merger_corp_id_no)), record,local), record,local) : independent;
	
			
			//***** Start Of Corp Mapping *****
			
			// Before propagating, store the original datefiled into the filler field to be used later
			MasterFilein2 := project(MasterFilein,transform(Corp2_Raw_NY.Layouts.MasterLayout
																						,self.filler := left.datefiled; self := left));
																						
			// The vendor sends some MasterFile records without foreignjurisdictioncode, foreignincdate, and/or countyofficecode
			// populated, so this will populate the missing fields by using records that do have the fields populated
			
			// Fill in missing foreignjurisdictioncodes
			masterWithForgnCd    := MasterFilein2(foreignjurisdictioncode <> '');
			masterWithoutForgnCd := MasterFilein2(foreignjurisdictioncode =  ''); 
			MasterPropJoinCd := join(masterWithoutForgnCd, dedup(masterWithForgnCd, corpidno),
														 corp2.t2u(left.corpidno) = corp2.t2u(right.corpidno),
														 transform(Corp2_Raw_NY.Layouts.MasterLayout,
														 self.foreignjurisdictioncode := right.foreignjurisdictioncode,
														 self:= left, self:= []),	 left outer	);
			MasterFileCd := dedup(sort(distribute(masterWithForgnCd + MasterPropJoinCd, hash(corpidno)), record,local), record,local) : independent;
 
      // Fill in missing foreignincdates
      masterWithForgnDt    := MasterFileCd(foreignincdate <> '');
			masterWithoutForgnDt := MasterFileCd(foreignincdate =  ''); 
			MasterPropJoinDt := join(masterWithoutForgnDt, dedup(masterWithForgnDt, corpidno),
														 corp2.t2u(left.corpidno) = corp2.t2u(right.corpidno),
														 transform(Corp2_Raw_NY.Layouts.MasterLayout,
														 self.foreignincdate := right.foreignincdate,
														 self:= left, self:= []),	 left outer	);
			MasterFileDt := dedup(sort(distribute(masterWithForgnDt + MasterPropJoinDt, hash(corpidno)), record,local), record,local) : independent;
  
	   // Fill in missing dissolutiondate
      masterWithDissolDt    := MasterFileDt(dissolutiondate <> '');
			masterWithoutDissolDt := MasterFileDt(dissolutiondate =  ''); 
			MasterPropJoinDs := join(masterWithoutDissolDt, dedup(masterWithDissolDt, corpidno),
														 corp2.t2u(left.corpidno) = corp2.t2u(right.corpidno),
														 transform(Corp2_Raw_NY.Layouts.MasterLayout,
														 self.dissolutiondate := right.dissolutiondate,
														 self:= left, self:= []),	 left outer	);
			MasterFileDs := dedup(sort(distribute(masterWithDissolDt + MasterPropJoinDs, hash(corpidno)), record,local), record,local) : independent;
  
	    // Fill in missing countyofficecodes
	    masterWithCounty    := MasterFileDs(countyofficecode <> '');
			masterWithoutCounty := MasterFileDs(countyofficecode =  ''); 
			MasterPropJoinCty := join(masterWithoutCounty, dedup(masterWithCounty, corpidno),
														 corp2.t2u(left.corpidno) = corp2.t2u(right.corpidno),
														 transform(Corp2_Raw_NY.Layouts.MasterLayout,
														 self.countyofficecode := right.countyofficecode,
														 self:= left, self:= []),	 left outer	);
	  	MasterFileCty := dedup(sort(distribute(masterWithCounty + MasterPropJoinCty, hash(corpidno)), record,local), record,local) : independent;
  
	   // Get datefiled from recs with doccode_CertCd = '01' and use that datefiled for the other recs of the same corp-key
	    masterWith01    := MasterFileCty(doccode_CertCd =  '01');
			masterWithout01 := MasterFileCty(doccode_CertCd <> '01'); 
			MasterPropJoin01 := join(masterWithout01, dedup(sort(masterWith01, corpidno, datefiled), corpidno),
														 corp2.t2u(left.corpidno) = corp2.t2u(right.corpidno),
														 transform(Corp2_Raw_NY.Layouts.MasterLayout,
														 self.datefiled := right.datefiled,
														 self:= left, self:= []),	 left outer	);
	  	MasterFile := dedup(sort(distribute(masterWith01 + MasterPropJoin01, hash(corpidno)), record,local), record,local) : independent;

	
			// The vendor sends some RA file records without the address fields populated, so get them from Master file records
			jMaster_incdate := project(MasterFile, transform(Corp2_Raw_NY.Layouts.master_incdate_tempLay,
																	 self.IncDate := left.datefiled, self := left));
			                                              
			jMaster_RA := join(jMaster_incdate, RegAgentFile,
													 corp2.t2u(left.corpidno) = corp2.t2u(right.register_corpidno) and
													 corp2.t2u(left.microfilmno) = corp2.t2u(right.register_microfilmno),
													 transform(Corp2_Raw_NY.Layouts.master_ra_tempLay, self:= left, self:= right, self:= []),
													 left outer	);
													 
			srtIterDs			 := sort (jMaster_RA, corpIdNo, corpname, datefiled);
			grpIterDs			 := group(srtIterDs, corpIdNo, corpname);
			
			Corp2_Raw_NY.Layouts.master_ra_tempLay trfIter1(Corp2_Raw_NY.Layouts.master_ra_tempLay l, Corp2_Raw_NY.Layouts.master_ra_tempLay r)	:= transform
				  Blank_Address := if (corp2.t2u(r.register_corpName + r.register_addr1 + r.register_addr2 + 
					                     r.register_city + r.register_state + r.register_zip) = '' ,true ,false);
					self.register_CorpName		   := if (Blank_Address, l.register_CorpName, r.register_CorpName);
					self.register_addr1				   :=	if (Blank_Address, l.register_addr1, r.register_addr1);	
					self.register_addr2				   :=	if (Blank_Address, l.register_addr2, r.register_addr2);	
					self.register_city				   :=	if (Blank_Address, l.register_city, r.register_city);	
					self.register_state				   :=	if (Blank_Address, l.register_state, r.register_state);
					self.register_zip					   :=	if (Blank_Address, l.register_zip, r.register_zip);
					self.countyofficecode        := if (corp2.t2u(r.countyofficecode) = '', l.countyofficecode, r.countyofficecode);
					self.foreignincdate          := if (corp2.t2u(r.foreignincdate) = '', l.foreignincdate, r.foreignincdate);
					self.datefiled               := if (corp2.t2u(r.datefiled) = '', l.datefiled, r.datefiled);
					
					fixRightForJur := if (corp2.t2u(r.foreignjurisdictioncode) in ['EW','MY'], 'NY', corp2.t2u(r.foreignjurisdictioncode)); 
					fixLeftForJur  := if (corp2.t2u(l.foreignjurisdictioncode) in ['EW','MY'], 'NY', corp2.t2u(l.foreignjurisdictioncode));
					self.foreignjurisdictioncode := if (fixRightForJur = '', fixLeftForJur, fixRightForJur);
					self											   := r;
			end;		

			NewIterDs			 := iterate(grpIterDs, trfIter1(left,right));
			srtIterDs2		 := sort(NewIterDs, corpIdNo, datefiled);
			grpIterDs2		 := group(srtIterDs2, corpIdNo);
			
			Corp2_Raw_NY.Layouts.master_ra_tempLay trfIter2(Corp2_Raw_NY.Layouts.master_ra_tempLay l, Corp2_Raw_NY.Layouts.master_ra_tempLay r)	:= transform
				self.IncDate := if (corp2.t2u(r.IncDate) < corp2.t2u(l.IncDate)
														,r.IncDate
														,if (corp2.t2u(l.IncDate) <> '', l.IncDate, r.IncDate)	);
				self				 := r;
			end;
			
			NewIterDs2		 := iterate(grpIterDs2, trfIter2(left,right));
			srtNewIterDs	 := sort(NewIterDs2, corpIdNo, datefiled, microfilmno);
						
			// Read through srtNewIterDs to get the Initial records for a corpid and 
			// then the Subsequent records for a corpid.  Set flags on the records to 
			// indicate if it is an Initial record or Subsequent record.  The flag will  
			// be used later in determining how to map corp_status_desc.
			
			initialRecs1 := dedup(srtNewIterDs, corpIdNo);
			initialRecs  := project(initialRecs1, transform(Corp2_Raw_NY.Layouts.master_ra_tempLay,
														 self.init_subseq_flag := 'I', self := left, self:= []));
			
			subseqRecs   :=  join(initialRecs1, srtNewIterDs, left = right,
													transform(Corp2_Raw_NY.Layouts.master_ra_tempLay, 
													self.init_subseq_flag := 'S', self := right, self:= []),
													right only);
													
			allWithFlags1 := sort(initialRecs + subseqRecs, corpIdNo, doceffectivedate, microfilmno);
			
			 // Join Master File (allWithFlags) and ExecutiveOffice File
			allWithFlags    := distribute(allWithFlags1, hash(corpidno)) : independent;
      ExecOffFiledist := distribute(ExecOffFile,   hash(Executive_corpidno)) : independent;
			
			jMaster_executive := join(allWithFlags, ExecOffFiledist, 
															 left.corpidno = right.Executive_corpidno and
															 corp2.t2u(left.microfilmno) = corp2.t2u(right.Executive_microfilmno),
															 transform(Corp2_Raw_NY.Layouts.master_exec_tempLay, self := left, self := right, self := [];),
															 left outer, local);

			// (Type 01) Transform for Corp Legal recs
			corp2_mapping.LayoutsCommon.Main trfCorpLegal(Corp2_Raw_NY.Layouts.master_exec_tempLay input) := transform
				 self.corp_key                      := state_fips+'-'+corp2.t2u(input.corpidno);
				 self.corp_orig_sos_charter_nbr     := corp2.t2u(input.corpidno);
				 self.corp_ln_name_type_cd          := '01';
				 self.corp_ln_name_type_desc        := 'LEGAL';
				 self.corp_filing_date              := Corp2_Mapping.fValidateDate(input.foreignincdate,'CCYYMMDD').PastDate;
				 self.corp_filing_desc              := if(self.corp_filing_date <> '' ,'HOME STATE' ,'');
				 self.corp_name_status_date         := Corp2_Mapping.fValidateDate(input.dissolutiondate,'CCYYMMDD').PastDate;
				 self.corp_name_status_desc         := if(self.corp_name_status_date <> '','NAME NOT PROTECTED','');
				 self.corp_legal_name               := Corp2_Mapping.fCleanBusinessName(state_origin,state_desc,input.corpname).BusinessName;
				 self.corp_foreign_domestic_ind     := case(corp2.t2u(input.doccode_AuthTyp), 'D'=>'D', 'F'=>'F', '');
				 self.corp_status_desc              := Corp2_Raw_NY.Functions.GetStatusDesc(input.init_subseq_flag,
																																										input.doccode_CertCd,
																																										input.doccode_AuthTyp,
																																										input.doccode_BusTyp,
																																										input.constituentindicator,
																																										input.durationdate, 
																																										input.durationdateflag,
																																										filedate); 
				 
				 // Storing the 6-digit doccode in InternalField1 for Scrubs purposes since it is a 
				 //   critical field for determining corp_status_desc																																						
				 self.InternalField1                   := std.str.toUppercase(input.doccode_CertCd + input.doccode_AuthTyp + input.doccode_BusTyp + 
				                                                            input.doccode_filler + input.doccode_FictTyp);      																															 
		 			
				 // Temporarily storing vendor fields into InternalFields for use in sorting and setting status. 
				 // The vendor field "datefiled" will be stored in two InternalFields:
				 //    ~ InternalField3 will contain the propagated datefiled 
				 //    ~ InternalField5 will contain the original, non-propagated datefiled
				 self.InternalField2                 := Corp2_Mapping.fValidateDate(input.doceffectivedate,'CCYYMMDD').GeneralDate;  
				 self.InternalField3                 := Corp2_Mapping.fValidateDate(input.datefiled,'CCYYMMDD').GeneralDate;  
				 self.InternalField4                 := Corp2.t2u(input.microfilmno);
				 self.InternalField5                 := input.Filler; // non-propagated datefiled
				 
				 self.corp_term_exist_cd            := if(corp2.t2u(input.durationdate) = '' ,'P',
																									if(Corp2_Mapping.fValidateDate(input.durationdate,'CCYYMMDD').GeneralDate <> '','D',''));
				 self.corp_term_exist_exp           := Corp2_Mapping.fValidateDate(input.durationdate,'CCYYMMDD').GeneralDate;
				 self.corp_term_exist_desc          := case(corp2.t2u(self.corp_term_exist_cd),
																										'P'=>'PERPETUAL', 'D'=>'EXPIRATION DATE', '');
				 self.corp_inc_date                 := if(corp2.t2u(input.foreignjurisdictioncode) in ['',state_origin] 
																									,Corp2_Mapping.fValidateDate(input.datefiled,'CCYYMMDD').PastDate,'');
				 self.corp_forgn_date               := if(corp2.t2u(input.foreignjurisdictioncode) not in ['',state_origin] 
																										,Corp2_Mapping.fValidateDate(input.datefiled,'CCYYMMDD').PastDate,'');
				 self.corp_inc_county               := Corp2_Raw_NY.Functions.GetCounty(input.countyofficecode);
				 self.corp_for_profit_ind           := if(corp2.t2u(input.notforprofittype) in ['A','B','C','D','N'],'N','');
				 self.corp_orig_org_structure_cd    := corp2.t2u(input.doccode_AuthTyp + input.doccode_BusTyp);
				 self.corp_orig_org_structure_desc  := Corp2_Raw_NY.Functions.GetOrgStrucDesc(input.doccode_AuthTyp,input.doccode_BusTyp);
				 self.corp_forgn_state_cd           := if(corp2.t2u(input.foreignjurisdictioncode) not in ['',state_origin],
																									corp2.t2u(input.foreignjurisdictioncode),'');
				 self.corp_forgn_state_desc         := Corp2_Raw_NY.Functions.GetStateDesc(self.corp_forgn_state_cd);																					
				 self.corp_addl_info                := Corp2_Raw_NY.Functions.CorpAddlInfo(input.provisionflag,input.purposeflag,input.restatedcertificateflag,input.adminnameflag,input.withdrawpartner); // retained from old mapper
				 self.corp_ra_full_name             := if(corp2.t2u(input.register_corpname) <> 'NO ADDRESS STATED' 
																									,Corp2_Raw_NY.Functions.cleanName(state_origin,state_desc,input.register_corpname),'');
				 
				 fixExecutive_city := if (corp2.t2u(input.Executive_city) = 'EW YORK' ,'NEW YORK' ,corp2.t2u(input.Executive_city));
				 self.corp_address1_type_cd     := if(Corp2_Mapping.fAddressExists(state_origin,state_desc,input.Executive_addr1,input.Executive_addr2,fixExecutive_city,input.Executive_state,input.Executive_zip).ifAddressExists,'B','');	
			   self.corp_address1_type_desc   := if(Corp2_Mapping.fAddressExists(state_origin,state_desc,input.Executive_addr1,input.Executive_addr2,fixExecutive_city,input.Executive_state,input.Executive_zip).ifAddressExists,'BUSINESS','');
				 self.corp_address1_line1				:= Corp2_Mapping.fCleanAddress (state_origin,state_desc,input.Executive_addr1,input.Executive_addr2,fixExecutive_city,input.Executive_state,input.Executive_zip).AddressLine1;
				 self.corp_address1_line2				:= Corp2_Mapping.fCleanAddress (state_origin,state_desc,input.Executive_addr1,input.Executive_addr2,fixExecutive_city,input.Executive_state,input.Executive_zip).AddressLine2;
				 self.corp_address1_line3				:= Corp2_Mapping.fCleanAddress (state_origin,state_desc,input.Executive_addr1,input.Executive_addr2,fixExecutive_city,input.Executive_state,input.Executive_zip).AddressLine3;			
				 self.corp_prep_addr1_line1			:= Corp2_Mapping.fCleanAddress (state_origin,state_desc,input.Executive_addr1,input.Executive_addr2,fixExecutive_city,input.Executive_state,input.Executive_zip).PrepAddrLine1;			
				 self.corp_prep_addr1_last_line := Corp2_Mapping.fCleanAddress (state_origin,state_desc,input.Executive_addr1,input.Executive_addr2,fixExecutive_city,input.Executive_state,input.Executive_zip).PrepAddrLastLine;

				 fixRegister_city := if (corp2.t2u(input.register_city) = 'EW YORK' ,'NEW YORK' ,corp2.t2u(input.register_city));
				 self.corp_ra_address_type_cd       := if(Corp2_Mapping.fAddressExists(state_origin,state_desc,input.register_addr1,input.register_addr2,fixRegister_city,input.register_state,input.register_zip).ifAddressExists,'R','');	
			   self.corp_ra_address_type_desc     := if(Corp2_Mapping.fAddressExists(state_origin,state_desc,input.register_addr1,input.register_addr2,fixRegister_city,input.register_state,input.register_zip).ifAddressExists,'REGISTERED OFFICE','');
				 self.corp_ra_address_line1				  := Corp2_Mapping.fCleanAddress (state_origin,state_desc,input.register_addr1,input.register_addr2,fixRegister_city,input.register_state,input.register_zip).AddressLine1;
				 self.corp_ra_address_line2				  := Corp2_Mapping.fCleanAddress (state_origin,state_desc,input.register_addr1,input.register_addr2,fixRegister_city,input.register_state,input.register_zip).AddressLine2;
				 self.corp_ra_address_line3				  := Corp2_Mapping.fCleanAddress (state_origin,state_desc,input.register_addr1,input.register_addr2,fixRegister_city,input.register_state,input.register_zip).AddressLine3;			
				 self.ra_prep_addr_line1						:= Corp2_Mapping.fCleanAddress (state_origin,state_desc,input.register_addr1,input.register_addr2,fixRegister_city,input.register_state,input.register_zip).PrepAddrLine1;			
				 self.ra_prep_addr_last_line 			  := Corp2_Mapping.fCleanAddress (state_origin,state_desc,input.register_addr1,input.register_addr2,fixRegister_city,input.register_state,input.register_zip).PrepAddrLastLine;
				 self                               := input;
				 self                               := [];        
			end;  			
			
			// Map Corp Legal recs
			MapCorp1  := project(jMaster_executive, trfCorpLegal(left));				
	
			distCorp				:=	distribute(MapCorp1,hash(corp_key));
	
			srtBlankStatus    := sort(distCorp(TRIM(corp_status_desc) = ''),corp_key);
			srtNonBlankStatus := sort(distCorp(TRIM(corp_status_desc) <> ''),corp_key, -InternalField2/*doceffectivedate*/, -InternalField4/*microfilmno*/);
				
			grpIterNonBlankStatus	:= group(srtNonBlankStatus, corp_key);
				
				//Based off the doccode attached to each record in the previous transform, some records may have an incorrect status attached to it.
				//This transform will assign the most recent correct status. 
				corp2_mapping.LayoutsCommon.Main IterTrfrmNBStat(corp2_mapping.LayoutsCommon.Main l, corp2_mapping.LayoutsCommon.Main r)	:= transform
				    self.corp_status_desc		:= if (trim(l.corp_status_desc) = '', r.corp_status_desc, l.corp_status_desc);
						self										:= r;
				end;
				
				IterNBStat		:= iterate(grpIterNonBlankStatus, IterTrfrmNBStat(left,right));
				
				corp2_mapping.LayoutsCommon.Main jAssignBlnkStatus(corp2_mapping.LayoutsCommon.Main l, corp2_mapping.LayoutsCommon.Main r)	:= transform
				    self.corp_status_desc		:= l.corp_status_desc;
						self										:= r;
				end;
				
				//This join will assign the correct status to the records that were not previously assigned a status.
				jAssignedStat := join(IterNBStat, srtBlankStatus,
														 trim(left.corp_key) = trim(right.corp_key),
														 jAssignBlnkStatus(left,right));
 
				AllStatus := IterNBStat + jAssignedStat;
					
				corpFinalSort := sort(AllStatus, corp_key, InternalField2/*doceffectivedate*/, InternalField4/*microfilmno*/);										
		
			
			// Join Fictitious file with Master to get datefiled 
			jMaster_fictname := join(FictNameFile, MasterFile,  
													left.fictname_corpidno = right.corpidno and
													corp2.t2u(left.fictname_microfilmno) = corp2.t2u(right.microfilmno),
													transform(Corp2_Raw_NY.Layouts.master_fictname_tempLay, 
																		self.foreignjurisdictioncode := right.foreignjurisdictioncode;
																		self.datefiled               := right.datefiled;
																		self := left; self := right; self := [];),
													left outer,local) : independent;	

			// (Type 04) Transform for Corp Fictitious Name recs
			Corp2_mapping.layoutsCommon.main trfCorpFictName(Corp2_Raw_NY.Layouts.master_fictname_tempLay input) := transform
											,skip(corp2.t2u(input.fictname_corpidno) = '')
				 self.corp_key                   := state_fips+'-'+corp2.t2u(input.fictname_corpidno);
				 self.corp_orig_sos_charter_nbr  := corp2.t2u(input.fictname_corpidno);
				 self.corp_ln_name_type_cd       := '02';
				 self.corp_ln_name_type_desc     := 'DBA';
				 self.corp_legal_name            := Corp2_Mapping.fCleanBusinessName(state_origin,state_desc,input.fictname_corpname).BusinessName;
				 self.corp_inc_date              := if(corp2.t2u(input.foreignjurisdictioncode) in ['',state_origin] 
																							,Corp2_Mapping.fValidateDate(input.datefiled,'CCYYMMDD').PastDate,'');
				 self.corp_forgn_date            := if(corp2.t2u(input.foreignjurisdictioncode) not in ['',state_origin] 
																							,Corp2_Mapping.fValidateDate(input.datefiled,'CCYYMMDD').PastDate,'');
			
				 // Temporarily storing vendor's datefiled field in InternalField3 for use in sorting
				 self.InternalField3             := Corp2_Mapping.fValidateDate(input.datefiled,'CCYYMMDD').GeneralDate; 
				 self                            := input;
				 self                            := [];        
			end;  
			
			// Map Corp Fictitious Name recs
			MapCorpFict  := project(jMaster_fictname, trfCorpFictName(left));
			
			CorpRecsForIter := corpFinalSort + MapCorpFict;
			
			// Set legal names status to PRIOR based on flags for Master records 
			srtCorpRecs	:= sort(CorpRecsForIter, corp_key, corp_ln_name_type_cd, -InternalField5/*(not-propagated) datefiled*/);
			grpCorpRecs	:= group(srtCorpRecs, corp_key, corp_ln_name_type_cd);

			corp2_mapping.LayoutsCommon.Main trfIter3(corp2_mapping.LayoutsCommon.Main l, corp2_mapping.LayoutsCommon.Main r)	:= transform
				 self.corp_ln_name_type_cd	  := if(l.corp_legal_name <> r.corp_legal_name
																						,if(l.corp_legal_name <> '' 
																							  ,case (l.corp_ln_name_type_cd, '01'=>'P', '02'=>'DP', l.corp_ln_name_type_cd)
																							  ,r.corp_ln_name_type_cd)
																					  ,l.corp_ln_name_type_cd);
				 self.corp_ln_name_type_desc	:= if(l.corp_legal_name <> r.corp_legal_name
																						,if(l.corp_legal_name <> '' 
																							 ,case (l.corp_ln_name_type_cd, '01'=>'PRIOR', '02'=>'DBA PRIOR', l.corp_ln_name_type_desc)
																							 ,r.corp_ln_name_type_desc)
																						,l.corp_ln_name_type_desc);
				 self.corp_status_desc				:= map(l.corp_status_desc <> '' => l.corp_status_desc,
																			       r.corp_status_desc <> '' => r.corp_status_desc,
																						 Corp2_Mapping.fValidateDate(r.InternalField3/*datefiled*/,'CCYYMMDD').PastDate <> '' => 'INACTIVE',
																						 'ACTIVE');
				 self	                        := r;
			end;

			IterMastCorpDs		:= iterate(grpCorpRecs, trfIter3(left,right));
		 
		
			// (Type 08) Transform for Corp Original Partnership Name recs
			jOrigPartFile := join(OrigPartFile, MasterFile,  
													left.origpart_corpidno = right.corpidno and
													corp2.t2u(left.origpart_microfilmno) = corp2.t2u(right.microfilmno),
													transform(Corp2_Raw_NY.Layouts.OrigPart_tempLay, 
																		self.foreignjurisdictioncode := right.foreignjurisdictioncode;
																		self.datefiled               := right.datefiled;
																		self := left; self := right; self := [];),
													left outer,local) : independent;
					
			corp2_mapping.LayoutsCommon.Main trfCorpOrigPart(Corp2_Raw_NY.Layouts.OrigPart_tempLay input) := transform
								,skip(corp2.t2u(input.origpart_corpidno) = '')
				 self.corp_key                   := state_fips+'-'+corp2.t2u(input.origpart_corpidno);
				 self.corp_orig_sos_charter_nbr  := corp2.t2u(input.origpart_corpidno);
				 self.corp_ln_name_type_cd       := '10';
				 self.corp_ln_name_type_desc     := 'ORIGINAL PARTNERSHIP NAME';
				 self.corp_legal_name            := Corp2_Mapping.fCleanBusinessName(state_origin,state_desc,input.origpart_corpname).BusinessName;
				 self.corp_inc_date              := if(corp2.t2u(input.foreignjurisdictioncode) in ['',state_origin] 
																							,Corp2_Mapping.fValidateDate(input.datefiled,'CCYYMMDD').PastDate,'');
				 self.corp_forgn_date            := if(corp2.t2u(input.foreignjurisdictioncode) not in ['',state_origin] 
																							,Corp2_Mapping.fValidateDate(input.datefiled,'CCYYMMDD').PastDate,'');
				 self                            := input;
				 self                            := [];        
			end;  
			
			// Map Corp Original Partnership Name recs
			MapCorpOrigPartner  := project(jOrigPartFile, trfCorpOrigPart(left));
			
			// (Type 09) Transform for Corp Current Partnership Name recs
			jCurrPartFile := join(CurrPartFile, MasterFile,  
													corp2.t2u(left.currpart_corpidno) = corp2.t2u(right.corpidno) and
													corp2.t2u(left.currpart_microfilmno) = corp2.t2u(right.microfilmno),
													transform(Corp2_Raw_NY.Layouts.CurrPart_tempLay, 
																		self.foreignjurisdictioncode := right.foreignjurisdictioncode;
																		self.datefiled               := right.datefiled;
																		self := left; self := right; self := [];),
													left outer,local) : independent;
					
			corp2_mapping.LayoutsCommon.Main trfCorpCurrPart(Corp2_Raw_NY.Layouts.CurrPart_tempLay input) := transform
								 ,skip(corp2.t2u(input.currpart_corpidno) = '')
				 self.corp_key                   := state_fips+'-'+corp2.t2u(input.currpart_corpidno);
				 self.corp_orig_sos_charter_nbr  := corp2.t2u(input.currpart_corpidno);
				 self.corp_ln_name_type_cd       := '11';
				 self.corp_ln_name_type_desc     := 'CURRENT PARTNERSHIP NAME';
				 self.corp_legal_name            := Corp2_Mapping.fCleanBusinessName(state_origin,state_desc,input.currpart_corpname).BusinessName;
				 self.corp_inc_date              := if(corp2.t2u(input.foreignjurisdictioncode) in ['',state_origin] 
																							,Corp2_Mapping.fValidateDate(input.datefiled,'CCYYMMDD').PastDate,'');
				 self.corp_forgn_date            := if(corp2.t2u(input.foreignjurisdictioncode) not in ['',state_origin] 
																							,Corp2_Mapping.fValidateDate(input.datefiled,'CCYYMMDD').PastDate,'');
				 self                            := input;
				 self                            := [];        
			end;  
			
			// Map Corp Current Partnership Name recs
			MapCorpCurrPartner  := project(jCurrPartFile, trfCorpCurrPart(left));
			
			MastPreCorp_Recs := IterMastCorpDs + MapCorpOrigPartner + MapCorpCurrPartner;
	
			// Transform for Corp Merger recs
			corp2_mapping.LayoutsCommon.Main trfCorpMerger(Corp2_Raw_NY.Layouts.MergerLayoutIn input) := transform
							,skip((integer)input.merger_corp_id_no = 0 or 
							      corp2.t2u(input.merger_corp_id_no) = '' or
									  corp2.t2u(input.merger_corp_name) = 'NO CONSTITUENT STATED' or
										Corp2_Mapping.fCleanBusinessName(state_origin,state_desc,input.merger_corp_name).BusinessName[1..11] = '0 0 0 0 0 0')                       
				 self.corp_key                   := state_fips+'-'+corp2.t2u(input.merger_corp_id_no);
				 self.corp_orig_sos_charter_nbr  := corp2.t2u(input.merger_corp_id_no);
				 self.corp_ln_name_type_cd          := 'NS';
				 self.corp_ln_name_type_desc        := 'NON-SURVIVOR';		
				 self.corp_legal_name               := Corp2_Mapping.fCleanBusinessName(state_origin,state_desc,input.merger_corp_name).BusinessName;				 
				 self.corp_merger_name              := Corp2_Mapping.fCleanBusinessName(state_origin,state_desc,input.merger_corp_name).BusinessName;				 
				 self.corp_inc_date                 := Corp2_Mapping.fValidateDate(input.merger_date_filed,'CCYYMMDD').PastDate;
				 self.corp_merger_date              := Corp2_Mapping.fValidateDate(input.merger_date_filed,'CCYYMMDD').PastDate;           																					
				 self.corp_merger_effective_date    := Corp2_Mapping.fValidateDate(input.merger_doc_effective_date,'CCYYMMDD').GeneralDate;
				 self.corp_inc_county               := if(corp2.t2u(input.merger_county_office_code) not in ['98','99']
																									,corp2.t2u(input.merger_county_office_code),'');
         self.corp_merged_corporation_id    := if(corp2.t2u(input.merger_corp_id_no) <> '99999999' ,corp2.t2u(input.merger_corp_id_no) ,'');				 
				 self.corp_merger_desc              := Corp2_Raw_NY.Functions.GetDocType(input.merger_doc_code);
         self.corp_merger_indicator         := if(corp2.t2u(input.merger_constituent_indicator) = 'C','N','');				 
				 self.corp_merger_type_converted_to_cd := corp2.t2u(input.merger_constituent_type);
				 self.corp_merger_type_converted_to_desc := Corp2_Raw_NY.functions.GetConstituent(self.corp_merger_type_converted_to_cd);					 
				 self.corp_orig_org_structure_cd    := if(corp2.t2u(input.merger_doc_code) <> '',corp2.t2u(input.merger_doc_code[3..4]),'');
				 self.corp_orig_org_structure_desc  := Corp2_Raw_NY.Functions.GetOrgStrucDesc(input.merger_doc_code[3],input.merger_doc_code[4]);
				 self.corp_orig_bus_type_cd         := if(corp2.t2u(input.merger_constituent_type) <> '',corp2.t2u(input.merger_constituent_type),'');
         self.corp_orig_bus_type_desc       := Corp2_Raw_NY.functions.GetConstituent(self.corp_orig_bus_type_cd);				 
				 self                               := input;
				 self                               := [];        
			end;  
			
			// Map Corp Merger recs
			MapCorpMerger := project(MergerFile, trfCorpMerger(left));
							
			// Set legal names status to PRIOR based on flags for Merger recs 
			srtMergCorpRecs	:= sort(MapCorpMerger, corp_key, corp_ln_name_type_cd, -InternalField5/*(not-propagated) datefiled*/);
			grpMergCorpRecs	:= group(srtMergCorpRecs, corp_key, corp_ln_name_type_cd);

			corp2_mapping.LayoutsCommon.Main iterMergTrf(corp2_mapping.LayoutsCommon.Main l, corp2_mapping.LayoutsCommon.Main r)	:= transform
				 self.corp_ln_name_type_cd		:= if(l.corp_legal_name <> r.corp_legal_name
																						,if(l.corp_legal_name <> ''
																								,'P'
																								, r.corp_ln_name_type_cd)
																						,l.corp_ln_name_type_cd);
				 self.corp_ln_name_type_desc	:= if(l.corp_legal_name <> r.corp_legal_name
																						,if(l.corp_legal_name <> ''
																								,'PRIOR'
																								,r.corp_ln_name_type_desc)
																						,l.corp_ln_name_type_desc);
				 self	 := r;
			end;	

			IterMergCorpDs		:= iterate(grpMergCorpRecs, iterMergTrf(left,right));
						
			All_Corp_Recs :=  MastPreCorp_Recs + IterMergCorpDs;
 
      MapCorp := dedup(sort(distribute(All_Corp_Recs, hash(corp_key)), record,local), record, except corp_forgn_date, corp_inc_date, InternalField1, InternalField2, InternalField3, InternalField4, InternalField5 ,local) : independent;
			 	              
		 //****** End of Corp Mapping *****			 
						
		 
		 //***** Start of Cont Mapping *****
		 
		// Join Master File and Chairman File  
		jMaster_chairman := join(MasterFile, ChairmanFile, 
														corp2.t2u(left.corpidno) = corp2.t2u(right.Chairman_corpidno) and
														corp2.t2u(left.microfilmno) = corp2.t2u(right.Chairman_microfilmno),
														transform(Corp2_Raw_NY.Layouts.master_chairman_tempLay,
														self := left, self := right, self := []));
		
		// (Type 06) Transform for Chairman/Chief Executive Officer recs		
		corp2_mapping.LayoutsCommon.Main trfContChairman(Corp2_Raw_NY.Layouts.master_chairman_tempLay input) := transform
								,skip(corp2.t2u(input.Chairman_corpidno) = '')
  			 self.corp_key                  := state_fips+'-'+corp2.t2u(input.Chairman_corpidno);
				 self.corp_orig_sos_charter_nbr := corp2.t2u(input.Chairman_corpidno);
				 self.corp_legal_name           := Corp2_Mapping.fCleanBusinessName(state_origin,state_desc,input.corpname).BusinessName;
				 self.cont_full_name            := Corp2_Raw_NY.Functions.cleanName(state_origin,state_desc,input.Chairman_corpname);
				 self.cont_type_cd              := if(corp2.t2u(input.Chairman_corpname) <> '','F','');
				 self.cont_type_desc            := if(corp2.t2u(input.Chairman_corpname) <> '','OFFICER','');
				 
				 fixChairman_city := if (corp2.t2u(input.Chairman_city) = 'EW YORK' ,'NEW YORK' ,corp2.t2u(input.Chairman_city));
				 self.cont_address_type_cd      := if (Corp2_Mapping.fAddressExists(state_origin,state_desc,input.Chairman_addr1,input.Chairman_addr2,fixChairman_city,input.Chairman_state,input.Chairman_zip).ifAddressExists,'T','');
			   self.cont_address_type_desc    := if (Corp2_Mapping.fAddressExists(state_origin,state_desc,input.Chairman_addr1,input.Chairman_addr2,fixChairman_city,input.Chairman_state,input.Chairman_zip).ifAddressExists,'CONTACT','');
				 self.cont_address_line1				:= Corp2_Mapping.fCleanAddress (state_origin,state_desc,input.Chairman_addr1,input.Chairman_addr2,fixChairman_city,input.Chairman_state,input.Chairman_zip).AddressLine1;
				 self.cont_address_line2				:= Corp2_Mapping.fCleanAddress (state_origin,state_desc,input.Chairman_addr1,input.Chairman_addr2,fixChairman_city,input.Chairman_state,input.Chairman_zip).AddressLine2;
				 self.cont_address_line3				:= Corp2_Mapping.fCleanAddress (state_origin,state_desc,input.Chairman_addr1,input.Chairman_addr2,fixChairman_city,input.Chairman_state,input.Chairman_zip).AddressLine3;			
				 self.cont_prep_addr_line1			:= Corp2_Mapping.fCleanAddress (state_origin,state_desc,input.Chairman_addr1,input.Chairman_addr2,fixChairman_city,input.Chairman_state,input.Chairman_zip).PrepAddrLine1;			
				 self.cont_prep_addr_last_line	:= Corp2_Mapping.fCleanAddress (state_origin,state_desc,input.Chairman_addr1,input.Chairman_addr2,fixChairman_city,input.Chairman_state,input.Chairman_zip).PrepAddrLastLine;
  			 self.recordOrigin              := 'T';				 
				 self                           := [];
			end;    
	    
			// Map Contacts from Master/Chairman Joined file
			MapChairmanCont  := project(jMaster_chairman, trfContChairman(left));
				
			// Join Master File and Process File 
			jMaster_process := join(MasterFile, ProcAddrFile, 
															 corp2.t2u(left.corpidno) = corp2.t2u(right.Process_corpidno) and
															 corp2.t2u(left.microfilmno) = corp2.t2u(right.Process_microfilmno),
															 transform(Corp2_Raw_NY.Layouts.master_process_tempLay,
													     self := left, self := right, self := []));
			
			// (Type 02) Transform for Process Address recs
			corp2_mapping.LayoutsCommon.Main trfContProcess(Corp2_Raw_NY.Layouts.master_process_tempLay input) := transform
									,skip(corp2.t2u(input.Process_corpidno) = '')
				 self.corp_key                  := state_fips+'-'+corp2.t2u(input.Process_corpidno);
				 self.corp_orig_sos_charter_nbr := corp2.t2u(input.Process_corpidno);
				 self.corp_legal_name           := Corp2_Mapping.fCleanBusinessName(state_origin,state_desc,input.corpname).BusinessName;
				 self.cont_full_name            := Corp2_Raw_NY.Functions.cleanName(state_origin,state_desc,input.Process_corpname);
         self.cont_type_desc            := 'PROCESS NAME';			
				 
				 fixProcess_city := if (corp2.t2u(input.Process_city) = 'EW YORK' ,'NEW YORK' ,corp2.t2u(input.Process_city));
				 self.cont_address_type_cd      := if (Corp2_Mapping.fAddressExists(state_origin,state_desc,input.Process_addr1,input.Process_addr2,fixProcess_city,input.Process_state,input.Process_zip).ifAddressExists,'P','');
			   self.cont_address_type_desc    := if (Corp2_Mapping.fAddressExists(state_origin,state_desc,input.Process_addr1,input.Process_addr2,fixProcess_city,input.Process_state,input.Process_zip).ifAddressExists,'PROCESS','');
				 self.cont_address_line1				:= Corp2_Mapping.fCleanAddress (state_origin,state_desc,input.Process_addr1,input.Process_addr2,fixProcess_city,input.Process_state,input.Process_zip).AddressLine1;
				 self.cont_address_line2				:= Corp2_Mapping.fCleanAddress (state_origin,state_desc,input.Process_addr1,input.Process_addr2,fixProcess_city,input.Process_state,input.Process_zip).AddressLine2;
				 self.cont_address_line3				:= Corp2_Mapping.fCleanAddress (state_origin,state_desc,input.Process_addr1,input.Process_addr2,fixProcess_city,input.Process_state,input.Process_zip).AddressLine3;			
				 self.cont_prep_addr_line1			:= Corp2_Mapping.fCleanAddress (state_origin,state_desc,input.Process_addr1,input.Process_addr2,fixProcess_city,input.Process_state,input.Process_zip).PrepAddrLine1;			
				 self.cont_prep_addr_last_line	:= Corp2_Mapping.fCleanAddress (state_origin,state_desc,input.Process_addr1,input.Process_addr2,fixProcess_city,input.Process_state,input.Process_zip).PrepAddrLastLine;
				 self.recordOrigin              := 'T';	
				 self                           := [];
			end;
		  
			// Map Contacts from Master/Process Joined file
			MapProcessCont := project(jMaster_process, trfContProcess(left));
			

	 //***** End of Cont Mapping ********************************************
	 
	 // Transform for the final Main file
			Corp2_mapping.layoutsCommon.main trfMapMain(Corp2_mapping.layoutsCommon.main input) := transform
				 self.dt_first_seen            := (integer)fileDate;
				 self.dt_last_seen             := (integer)fileDate;
				 self.dt_vendor_first_reported := (integer)fileDate;
				 self.dt_vendor_last_reported  := (integer)fileDate;
				 self.corp_ra_dt_first_seen    := (integer)fileDate;
				 self.corp_ra_dt_last_seen     := (integer)fileDate;
				 self.corp_process_date        := fileDate;
				 self.corp_vendor              := state_fips;
				 self.corp_state_origin        := state_origin;
				 self.corp_inc_state           := state_origin;
				 self.corp_status_comment      := if(input.recordOrigin <> 'T','GOOD STANDING STATUS CAN ONLY BE DETERMINED BY PERFORMING A SEARCH IN THE RECORDS OF BOTH THE DEPARTMENT OF STATE CORPORATION RECORDS AND THE DEPARTMENT OF TAX AND FINANCE.','');
				 self.InternalField2           := ''; //blank this out
				 self.InternalField3           := ''; //blank this out
				 self.InternalField4           := ''; //blank this out
				 self.InternalField5           := ''; //blank this out
				 self.corp_forgn_state_cd      := if(input.corp_forgn_state_desc = '', '', input.corp_forgn_state_cd);
         self.corp_orig_bus_type_cd		 := if(input.corp_orig_bus_type_desc = '', '', input.corp_orig_bus_type_cd);		 
				 self.recordOrigin             := if(input.recordOrigin <> 'T' ,'C' ,input.recordOrigin);	
				 self                          := input;
				 self                          := [];        
			end;  

	 	 
	 //***** Start Of AR Mapping ********************************************
			// Transform to AR
			corp2_Mapping.LayoutsCommon.AR trfAR(Corp2_Raw_NY.Layouts.MasterLayout input) := transform
					,skip(corp2.t2u(input.doccode_CertCd) not in ['17','32','48'] or corp2.t2u(input.corpidno) = '')
   			 self.corp_key              := state_fips+'-'+corp2.t2u(input.corpidno);
				 self.corp_vendor           := state_fips;
				 self.corp_state_origin     := state_origin;
				 self.corp_process_date     := fileDate;
				 self.corp_sos_charter_nbr  := corp2.t2u(input.corpidno);
				 self.ar_type               := case(corp2.t2u(input.doccode_CertCd),
																						'17' => 'ANNUAL REPORT',
																					  '32' => 'BIENNIAL REPORT',
																					  '48' => 'BIENNIAL STATEMENT AMENDMENT',
																					  '');
				 self.ar_filed_dt           := Corp2_Mapping.fValidateDate(input.datefiled,'CCYYMMDD').PastDate;
													
				 effective_dt               := if(Corp2_Mapping.fValidateDate(input.doceffectivedate,'CCYYMMDD').PastDate <> ''
																					,input.doceffectivedate[5..6] + '/' + 
																					 input.doceffectivedate[7..8] + '/' +
																					 input.doceffectivedate[1..4] ,'');		
				 self.ar_comment            := if(effective_dt <> '', 'EFFECTIVE DATE: ' + corp2.t2u(effective_dt),'');																	 
				 self                       := [];  
			end;   
			//***** End Of AR Mapping *****
			
			
			//***** Start Of Event Mapping *****		
			
			// Normalize on the 2 different event filing dates		
			Corp2_Raw_NY.Layouts.norm_event_tempLay trfNormEvent(Corp2_Raw_NY.Layouts.MasterLayout l, unsigned1 cnt) := transform
						,skip(cnt=1 and l.doceffectivedate = '' or cnt=2 and l.datefiled = '')
				self.norm_event_filing_date := choose(cnt, l.doceffectivedate, l.datefiled);
				self 								    := l;
			end;
			
			normalizedEvent	:= normalize(MasterFile, 2, trfNormEvent(left, counter));	
			
			corp2_Mapping.LayoutsCommon.Events trfMasterEvent(Corp2_Raw_NY.Layouts.norm_event_tempLay input) := transform
			 ,skip(input.doccode_CertCd in ['17','32','48'] or corp2.t2u(input.corpidno) = '')
				 self.corp_key               := state_fips+'-'+corp2.t2u(input.corpidno); 
				 self.corp_vendor            := state_fips;
				 self.corp_state_origin      := state_origin;
				 self.corp_process_date      := fileDate;
				 self.corp_sos_charter_nbr   := corp2.t2u(input.corpidno);
				 self.event_filing_cd        := corp2.t2u(input.doccode_CertCd + input.doccode_AuthTyp + input.doccode_BusTyp + 
				                                          input.doccode_filler + input.doccode_FictTyp);
				 self.event_filing_desc      := Corp2_Raw_NY.Functions.GetDocType(self.event_filing_cd);
				 self.event_filing_date      := if(Corp2_Mapping.fValidateDate(input.norm_event_filing_date,'CCYYMMDD').PastDate <> ''
																					 ,corp2.t2u(input.norm_event_filing_date)
																					 ,if(input.norm_event_filing_date[5..8] = '0000' and (integer)input.norm_event_filing_date[1..4] between 1599 and (integer)filedate[1..4]
																					     ,input.norm_event_filing_date[1..4]
																					     ,''));
				 self.event_date_type_cd     := 'EFF';																				 
				 self.event_date_type_desc   := 'EFFECTIVE';
				 self.event_microfilm_nbr    := corp2.t2u(input.microfilmno);
				 self                        := [];
			end; 
	
			MapMasterEvent1 := project(normalizedEvent, trfMasterEvent(left));
			MapMasterEvent  := dedup(sort(distribute(MapMasterEvent1, hash(corp_sos_charter_nbr)),record, local), record, local) ;
																				
			//***** End Of Event Mapping *****
		
			//***** Start Of Stock Mapping *****   

			jMaster_stock := join(MasterFile, StockFile, 
														corp2.t2u(left.corpidno) = corp2.t2u(right.stock_corpidno) and
														corp2.t2u(left.microfilmno) = corp2.t2u(right.stock_microfilmno),
														transform(Corp2_Raw_NY.Layouts.master_stock_tempLay, self := left, self := right, self := []));
																																		
			// Normalize on the 8 sets of stock fields		
			Corp2_Raw_NY.Layouts.norm_stock_tempLay trfNormStock(Corp2_Raw_NY.Layouts.master_stock_tempLay l, unsigned1 cnt) := transform
			 ,skip((cnt = 1 and corp2.t2u(l.sharecount1) in ['','*'] and corp2.t2u(l.stocktype1) in ['','*'] and corp2.t2u(l.valuepershare1) in ['','*']) or
						 (cnt = 2 and corp2.t2u(l.sharecount2) in ['','*'] and corp2.t2u(l.stocktype2) in ['','*'] and corp2.t2u(l.valuepershare2) in ['','*']) or
						 (cnt = 3 and corp2.t2u(l.sharecount3) in ['','*'] and corp2.t2u(l.stocktype3) in ['','*'] and corp2.t2u(l.valuepershare3) in ['','*']) or
						 (cnt = 4 and corp2.t2u(l.sharecount4) in ['','*'] and corp2.t2u(l.stocktype4) in ['','*'] and corp2.t2u(l.valuepershare4) in ['','*']) or
						 (cnt = 5 and corp2.t2u(l.sharecount5) in ['','*'] and corp2.t2u(l.stocktype5) in ['','*'] and corp2.t2u(l.valuepershare5) in ['','*']) or
						 (cnt = 6 and corp2.t2u(l.sharecount6) in ['','*'] and corp2.t2u(l.stocktype6) in ['','*'] and corp2.t2u(l.valuepershare6) in ['','*']) or
						 (cnt = 7 and corp2.t2u(l.sharecount7) in ['','*'] and corp2.t2u(l.stocktype7) in ['','*'] and corp2.t2u(l.valuepershare7) in ['','*']) or
						 (cnt = 8 and corp2.t2u(l.sharecount8) in ['','*'] and corp2.t2u(l.stocktype8) in ['','*'] and corp2.t2u(l.valuepershare8) in ['','*']) or
						 corp2.t2u(l.corpidno) = ''
				)
				self.norm_sharecount    := choose(cnt ,corp2.t2u(l.sharecount1)	,corp2.t2u(l.sharecount2)
																							,corp2.t2u(l.sharecount3)	,corp2.t2u(l.sharecount4) 
																							,corp2.t2u(l.sharecount5)	,corp2.t2u(l.sharecount6)
																							,corp2.t2u(l.sharecount7)	,corp2.t2u(l.sharecount8) );
				self.norm_stocktype     := choose(cnt	,corp2.t2u(l.stocktype1)	,corp2.t2u(l.stocktype2)
																							,corp2.t2u(l.stocktype3)	,corp2.t2u(l.stocktype4) 
																							,corp2.t2u(l.stocktype5)	,corp2.t2u(l.stocktype6)
																							,corp2.t2u(l.stocktype7)	,corp2.t2u(l.stocktype8) );
				self.norm_valuepershare := choose(cnt ,corp2.t2u(l.valuepershare1) ,corp2.t2u(l.valuepershare2)
																							,corp2.t2u(l.valuepershare3) ,corp2.t2u(l.valuepershare4) 
																							,corp2.t2u(l.valuepershare5) ,corp2.t2u(l.valuepershare6)
																							,corp2.t2u(l.valuepershare7) ,corp2.t2u(l.valuepershare8) );
				self 								    := l;
			end;
			normalizedStock	:= normalize(jMaster_stock, 8, trfNormStock(left, counter));	  
		
			//Stock Transform 
			corp2_Mapping.LayoutsCommon.Stock trfStockmap(Corp2_Raw_NY.Layouts.norm_stock_tempLay input) := transform
				 self.corp_key             := state_fips+'-'+corp2.t2u(input.corpidno);
				 self.corp_vendor          := state_fips;
				 self.corp_state_origin    := state_origin;
				 self.corp_process_date    := fileDate;
				 self.corp_sos_charter_nbr := corp2.t2u(input.corpidno);
				 self.stock_type           := case(input.norm_stocktype,'PV'=>'PAR VALUE', 'NPV'=>'NO PAR VALUE', 'CAP'=>'CAPITAL', ''); 
				 self.stock_authorized_nbr := input.norm_sharecount; 
				 self.stock_par_value  := Corp2_Raw_NY.Functions.FixValuePerShare(input.norm_valuepershare);
				 self                  := [];
			end;  
			//***** End Of Stock Mapping *****
	
	
	//-----------------------------------------------------------//
	// Build the Final Mapped Files
	//-----------------------------------------------------------//                                                          /*Exclude InternalField1 on Dedup*/                       
	 	MapMain  := dedup(sort(distribute(project(MapCorp + MapChairmanCont + MapProcessCont ,trfMapMain(left)),hash(corp_key)), record,local), record, except InternalField1, local) : independent;
		MapAR    := dedup(sort(distribute(project(MasterFile, trfAR(left)),hash(corp_key)), record,local), record,local) : independent;
		MapEvent := dedup(sort(distribute(MapMasterEvent,hash(corp_key)), record,local), record,local) : independent; 	  
		MapStock := dedup(sort(distribute(project(normalizedStock, trfStockmap(left)),hash(corp_key)),record,local), record,local) : independent;
  
	
	//--------------------------------------------------------------------	
  // Scrubs for MAIN
  //--------------------------------------------------------------------
		Main_F := MapMain;
		Main_S := Scrubs_Corp2_Mapping_NY_Main.Scrubs;        // Scrubs module
		Main_N := Main_S.FromNone(Main_F); 										// Generate the error flags
		Main_T := Main_S.FromBits(Main_N.BitmapInfile);     	// Use the FromBits module; makes my bitmap datafile easier to get to
		Main_U := Main_S.FromExpanded(Main_N.ExpandedInFile); // Pass the expanded error flags into the Expanded module

	//Outputs reports
		Main_ErrorSummary					:= output(Main_U.SummaryStats, named('Main_ErrorSummary_NY'+filedate));
		Main_ScrubErrorReport 		:= output(choosen(Main_U.AllErrors, 1000), named('Main_ScrubErrorReport_NY'+filedate));
		Main_SomeErrorValues			:= output(choosen(Main_U.BadValues, 1000), named('Main_SomeErrorValues_NY'+filedate));
		Main_IsScrubErrors		 		:= IF(count(Main_U.AllErrors)<> 0,true,false);

		// Orbit Stats
		Main_OrbitStats						:= Main_U.OrbitStats();
		
		//Outputs files
		Main_CreateBitMaps				:= output(Main_N.BitmapInfile,,'~thor_data::corp_NY_main_scrubs_bits',overwrite,compressed);	//long term storage
		Main_TranslateBitMap			:= output(Main_T);

    //Submits Profile's stats to Orbit
    Main_SubmitStats          := Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_NY_Main','ScrubsAlerts', Main_OrbitStats, version,'Corp_NY_Main').SubmitStats;

		Main_ScrubsWithExamples		:= Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_NY_Main','ScrubsAlerts', Main_OrbitStats, version,'Corp_NY_Main').CompareToProfile_with_Examples;
		
		Main_ScrubsAlert					:= Main_ScrubsWithExamples(RejectWarning = 'Y');
		Main_ScrubsAttachment			:= Scrubs.fn_email_attachment(Main_ScrubsAlert);
		Main_SendEmailFile				:= FileServices.SendEmailAttachData( corp2.Email_Notification_Lists.AttachedList
																																	 ,'Scrubs CorpMain_NY Report' //subject
																																	 ,'Scrubs CorpMain_NY Report' //body
																																	 ,(data)Main_ScrubsAttachment
																																	 ,'text/csv'
																																	 ,'CorpNYMainScrubsReport.csv'
																																	);		
																																 
		Main_BadRecords := Main_T.ExpandedInFile(	dt_vendor_first_reported_invalid 	 <> 0 or
																							dt_vendor_last_reported_invalid 	 <> 0 or
																							dt_first_seen_invalid 			       <> 0 or
																							dt_last_seen_invalid 			         <> 0 or
																							corp_ra_dt_first_seen_invalid 		 <> 0 or
																							corp_ra_dt_last_seen_invalid 			 <> 0 or
																							corp_key_invalid 			             <> 0 or
																							corp_vendor_invalid 			         <> 0 or
																							corp_state_origin_invalid 			   <> 0 or
																							corp_process_date_invalid 			   <> 0 or
																							corp_inc_state_invalid 			       <> 0 or
																							corp_forgn_date_invalid 			     <> 0 or
																							corp_filing_date_invalid 			     <> 0 or
																							corp_inc_date_invalid 			       <> 0 or
																							corp_term_exist_exp_invalid 			 <> 0 or
																							corp_merger_date_invalid 			     <> 0 or
																							corp_merger_effective_date_invalid <> 0 or
																							corp_name_status_date_invalid 		 <> 0 or
																							corp_orig_sos_charter_nbr_invalid  <> 0 or
																							corp_legal_name_invalid 			     <> 0 or
																							corp_foreign_domestic_ind_invalid  <> 0 or
																							corp_for_profit_ind_invalid 			 <> 0 or
																							corp_ln_name_type_cd_invalid 			 <> 0 or
																							corp_ln_name_type_desc_invalid 		 <> 0 or
																							corp_forgn_state_desc_invalid      <> 0 or
																							corp_status_desc_invalid 			     <> 0 or
																							InternalField1_invalid               <> 0 or
																							corp_merger_type_converted_to_cd_invalid <> 0);

		Main_GoodRecords	:= Main_T.ExpandedInFile( dt_vendor_first_reported_invalid 	 = 0 and
																								dt_vendor_last_reported_invalid 	 = 0 and
																								dt_first_seen_invalid 			       = 0 and
																								dt_last_seen_invalid 			         = 0 and
																								corp_ra_dt_first_seen_invalid 		 = 0 and
																								corp_ra_dt_last_seen_invalid 			 = 0 and
																								corp_key_invalid 			             = 0 and
																								corp_vendor_invalid 			         = 0 and
																								corp_state_origin_invalid 			   = 0 and
																								corp_process_date_invalid 			   = 0 and
																								corp_inc_state_invalid 			       = 0 and
																								corp_forgn_date_invalid 			     = 0 and
																								corp_filing_date_invalid 			     = 0 and
																								corp_inc_date_invalid 			       = 0 and
																								corp_term_exist_exp_invalid 			 = 0 and
																								corp_merger_date_invalid 			     = 0 and
																								corp_merger_effective_date_invalid = 0 and
																								corp_name_status_date_invalid 		 = 0 and
																								corp_orig_sos_charter_nbr_invalid  = 0 and
																								corp_legal_name_invalid 			     = 0 and
																								corp_foreign_domestic_ind_invalid  = 0 and
																								corp_for_profit_ind_invalid 			 = 0 and
																								corp_ln_name_type_cd_invalid 			 = 0 and
																								corp_ln_name_type_desc_invalid 		 = 0 and
																								corp_forgn_state_desc_invalid      = 0 and
																								corp_status_desc_invalid 			     = 0 and
																								InternalField1_invalid             = 0 and
																								corp_merger_type_converted_to_cd_invalid = 0);																												 																	
			
		Main_FailBuild	:= map(corp2_mapping.fCalcPercent(count(Main_N.ExpandedInFile(corp_orig_sos_charter_nbr_invalid<>0)),count(Main_N.ExpandedInFile),false) > Scrubs_Corp2_Mapping_NY_Main.Threshold_Percent.CORP_ORIG_SOS_CHARTER_NBR => true,
													 corp2_mapping.fCalcPercent(count(Main_N.ExpandedInFile(corp_legal_name_invalid<>0)),					 count(Main_N.ExpandedInFile),false) > Scrubs_Corp2_Mapping_NY_Main.Threshold_Percent.CORP_LEGAL_NAME 					=> true,
													 corp2_mapping.fCalcPercent(count(Main_N.ExpandedInFile(corp_key_invalid<>0)),						     count(Main_N.ExpandedInFile),false) > Scrubs_Corp2_Mapping_NY_Main.Threshold_Percent.CORP_KEY      						=> true,
													 count(Main_GoodRecords) = 0																																																																																				          => true,
													 false );

		Main_ApprovedRecords := project(Main_GoodRecords,transform(Corp2_Mapping.LayoutsCommon.Main,self := left));
	
		Main_ALL	:= sequential( if(count(Main_BadRecords) <> 0
																,if(poverwrite
																		,output(Main_BadRecords,,Corp2_Mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::main_'+state_origin,overwrite,__compressed__)
																		,output(Main_BadRecords,,Corp2_Mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::main_'+state_origin,__compressed__)
																		)
																)
														,output(Main_ScrubsWithExamples, all, named('CorpMainNYScrubsReportWithExamples'+filedate))
														//Send Alerts if Scrubs exceeds thresholds
														,if(count(Main_ScrubsAlert) > 0, Main_SendEmailFile, output('CORP2_MAPPING.NY - No "MAIN" Corp Scrubs Alerts'))
														,Main_ErrorSummary
														,Main_ScrubErrorReport
														,Main_SomeErrorValues		
														,Main_SubmitStats
												);
																
	//--------------------------------------------------------------------	
  // Scrubs for Event
  //--------------------------------------------------------------------
		Event_F := MapEvent;
		Event_S := Scrubs_Corp2_Mapping_NY_Event.Scrubs;        // NY scrubs module
		Event_N := Event_S.FromNone(Event_F); 									// Generate the error flags
		Event_T := Event_S.FromBits(Event_N.BitmapInfile);     	// Use the FromBits module; mNYes my bitmap datafile easier to get to
		Event_U := Event_S.FromExpanded(Event_N.ExpandedInFile);// Pass the expanded error flags into the Expanded module

	//Outputs reports
		Event_ErrorSummary				:= output(Event_U.SummaryStats, named('Event_ErrorSummary_NY'+filedate));
		Event_ScrubErrorReport 		:= output(choosen(Event_U.AllErrors, 1000), named('Event_ScrubErrorReport_NY'+filedate));
		Event_SomeErrorValues			:= output(choosen(Event_U.BadValues, 1000), named('Event_SomeErrorValues_NY'+filedate));
		Event_IsScrubErrors		 		:= IF(count(Event_U.AllErrors)<> 0,true,false);

		// Orbit Stats
		Event_OrbitStats						:= Event_U.OrbitStats();
		
		//Outputs files
		Event_CreateBitMaps				:= output(Event_N.BitmapInfile,,'~thor_data::corp_NY_Event_scrubs_bits',overwrite,compressed);	//long term storage
		Event_TranslateBitMap			:= output(Event_T);

    //Submits Profile's stats to Orbit  
		Event_SubmitStats         := Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_NY_Event','ScrubsAlerts', Event_OrbitStats, version,'Corp_NY_Event').SubmitStats;

  	Event_ScrubsWithExamples	:= Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_NY_Event','ScrubsAlerts', Event_OrbitStats, version,'Corp_NY_Event').CompareToProfile_with_Examples;
		
		Event_ScrubsAlert					:= Event_ScrubsWithExamples(RejectWarning = 'Y');
		Event_ScrubsAttachment		:= Scrubs.fn_email_attachment(Event_ScrubsAlert);
		Event_SendEmailFile				:= FileServices.SendEmailAttachData( corp2.Email_Notification_Lists.spray
																																	 ,'Scrubs CorpEvent_NY Report' //subject
																																	 ,'Scrubs CorpEvent_NY Report' //body
																																	 ,(data)Event_ScrubsAttachment
																																	 ,'text/csv'
																																	 ,'CorpNYEventScrubsReport.csv'
																																	 ,
																																	 ,
																																	 ,corp2.Email_Notification_Lists.spray
																																 );		
																																 
		Event_BadRecords := Event_T.ExpandedInFile(	corp_key_invalid  		         <> 0 or
																								corp_sos_charter_nbr_invalid   <> 0 or
																								event_filing_cd_invalid 		   <> 0 );	

		Event_GoodRecords	:= Event_T.ExpandedInFile(corp_key_invalid  		         = 0 and
																								corp_sos_charter_nbr_invalid   = 0 and
																								event_filing_cd_invalid		     = 0 );																					 																	
		
		Event_FailBuild	:= if(count(Event_GoodRecords) = 0,true,false);

		Event_ApprovedRecords := project(Event_GoodRecords,transform(Corp2_Mapping.LayoutsCommon.Events,self := left));		
		
  	Event_ALL	:= sequential( if(count(Event_BadRecords) <> 0
																,if(poverwrite
																		,output(Event_BadRecords,,Corp2_Mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::event_'+state_origin,overwrite,__compressed__)
																		,output(Event_BadRecords,,Corp2_Mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::event_'+state_origin,__compressed__)
																		)
																)
														,output(Event_ScrubsWithExamples, all, named('CorpEventNYScrubsReportWithExamples'+filedate))
														//Send Alerts if Scrubs exceeds thresholds
														,if(count(Event_ScrubsAlert) > 0, Event_SendEmailFile, output('CORP2_MAPPING.NY - No "EVENT" Corp Scrubs Alerts'))
														,Event_ErrorSummary
														,Event_ScrubErrorReport
														,Event_SomeErrorValues
														,Event_SubmitStats
												);																	 
	
	
	
  //-------------------- UPDATE -----------------------------------------------------//	
	Fail_Build						:= if(Event_FailBuild = true or Main_FailBuild = true,true,false);
	IsScrubErrors					:= if(Event_IsScrubErrors = true or Main_IsScrubErrors = true ,true,false);
	
	//The projected weekly file is written to a dataset.  The dataset will be added to the vendor_master superfile and must be in the same layout as the quarterly.
	VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+filedate+'::master::weekly::ny', 
																				Corp2_Raw_NY.Files(filedate,pUseProd,pquarterlyReload).input.masterWeekly,
																				master_weekly_out,,,pOverwrite);
	
	VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+version+'::main_ny'			,Main_ApprovedRecords ,write_main		   ,,,pOverwrite);		
	VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+version+'::stock_ny'			,MapStock	            ,write_stock	   ,,,pOverwrite);
	VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+version+'::event_ny'			,Event_ApprovedRecords,write_event	   ,,,pOverwrite);
	VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+version+'::ar_ny'				,MapAR		            ,write_ar			   ,,,pOverwrite);
	
	VersionControl.macBuildNewLogicalFile('~thor_data400::failed::corp2::'+version+'::main_ny'	,MapMain              ,write_fail_main ,,,pOverwrite);		
	VersionControl.macBuildNewLogicalFile('~thor_data400::failed::corp2::'+version+'::event_ny'	,MapEvent	            ,write_fail_event,,,pOverwrite);
	  
 	mapNY:= sequential( if(pshouldspray = true,Corp2_mapping.fSprayFiles(state_origin ,version,pOverwrite := pOverwrite))
												// ,Corp2_Raw_NY.Build_Bases(filedate,version,pUseProd,pquarterlyReload).All  // Determined building bases is not needed
												// For Quarterly Re-loads, the Master file is in 3 parts and Merger file is in one part.
												// The 3 parts of Master file will be added to Master Super and the Merger will be added to Merger Super.
														,if(pQuarterlyReload = true,
														sequential(fileservices.clearsuperfile('~thor_data400::in::corp2::ny::vendor_master'),
																			 fileservices.clearsuperfile('~thor_data400::in::corp2::ny::vendor_merger'),
																			 fileservices.addsuperfile('~thor_data400::in::corp2::ny::vendor_master' ,'~thor_data400::in::corp2::'+filedate+'g1::master::ny'),
																			 fileservices.addsuperfile('~thor_data400::in::corp2::ny::vendor_master' ,'~thor_data400::in::corp2::'+filedate+'g2::master::ny'),
																			 fileservices.addsuperfile('~thor_data400::in::corp2::ny::vendor_master' ,'~thor_data400::in::corp2::'+filedate+'g3::master::ny'),
																			 fileservices.addsuperfile('~thor_data400::in::corp2::ny::vendor_merger' ,'~thor_data400::in::corp2::'+filedate+'g1::merger::ny')
																			 ))					
											,Event_All
											,Main_All
											,if(Fail_Build <> true	 
												 ,sequential (write_ar
																		 ,write_event
																		 ,write_main
																		 ,write_stock
																		 ,fileservices.addsuperfile(Corp2_Mapping._Dataset().thor_cluster_Files + 'in::'+Corp2_Mapping._Dataset().NameMapped +'::sprayed::ar'			,Corp2_Mapping._Dataset().thor_cluster_Files + 'in::corp2::'+version+'::ar_'		+state_origin)
																		 ,fileservices.addsuperfile(Corp2_Mapping._Dataset().thor_cluster_Files + 'in::'+Corp2_Mapping._Dataset().NameMapped +'::sprayed::event'	,Corp2_Mapping._Dataset().thor_cluster_Files + 'in::corp2::'+version+'::event_'	+state_origin)
																		 ,fileservices.addsuperfile(Corp2_Mapping._Dataset().thor_cluster_Files + 'in::'+Corp2_Mapping._Dataset().NameMapped +'::sprayed::main'		,Corp2_Mapping._Dataset().thor_cluster_Files + 'in::corp2::'+version+'::main_'	+state_origin)																		 
																		 ,fileservices.addsuperfile(Corp2_Mapping._Dataset().thor_cluster_Files + 'in::'+Corp2_Mapping._Dataset().NameMapped +'::sprayed::stock'	,Corp2_Mapping._Dataset().thor_cluster_Files + 'in::corp2::'+version+'::stock_'	+state_origin)
																		 ,if (count(Main_BadRecords) <> 0 or count(Event_BadRecords) <> 0 
																				 ,Corp2_Mapping.Send_Email(state_origin,version,count(Main_BadRecords)<>0,,count(Event_BadRecords)<>0,,count(Main_BadRecords),,count(Event_BadRecords),,count(Main_ApprovedRecords),count(MapAR),count(Event_ApprovedRecords),count(MapStock)).RecordsRejected																				 
																				 ,Corp2_Mapping.Send_Email(state_origin,version,count(Main_BadRecords)<>0,,count(Event_BadRecords)<>0,,count(Main_BadRecords),,count(Event_BadRecords),,count(Main_ApprovedRecords),count(MapAR),count(Event_ApprovedRecords),count(MapStock)).MappingSuccess																				 
																				 )
																		 ,if (IsScrubErrors
																				 ,Corp2_Mapping.Send_Email(state_origin,version,Main_IsScrubErrors,,Event_IsScrubErrors).FieldsInvalidPerScrubs
																				 )
																		 ) //if Fail_Build <> true																			
												 ,sequential (write_fail_event
																		 ,write_fail_main
										 								 ,Corp2_Mapping.Send_Email(state_origin,version).MappingFailed
																		 ) //if Fail_Build = true
												 )
												//Create the weekly master dataset (this layout matches the quarterly layout).  Add the weekly master to the vendor_master superfile.
   											,if(pQuarterlyReload = false
														 ,sequential(master_weekly_out
														 ,parallel(if(FileServices.FindSuperFileSubName('~thor_data400::in::corp2::ny::vendor_master', '~thor_data400::in::corp2::'+filedate+'::master::weekly::ny') = 0,
																					fileservices.addsuperfile('~thor_data400::in::corp2::ny::vendor_master' ,'~thor_data400::in::corp2::'+filedate+'::master::weekly::ny'))
																			,if(FileServices.FindSuperFileSubName('~thor_data400::in::corp2::ny::vendor_merger', '~thor_data400::in::corp2::'+filedate+'::merger::ny') = 0,
																				  fileservices.addsuperfile('~thor_data400::in::corp2::ny::vendor_merger' ,'~thor_data400::in::corp2::'+filedate+'::merger::ny'))
																			)))
										);
											
 		isFileDateValid := map(pQuarterlyReload = true  and (string)Std.Date.Today() between ut.date_math(filedate,-120) and ut.date_math(filedate,120) => true,
													 pQuarterlyReload = false and (string)Std.Date.Today() between ut.date_math(filedate,-30) and ut.date_math(filedate,30)   => true,
													 false);
		return sequential (if (isFileDateValid
														,mapNY
														,sequential (Corp2_Mapping.Send_Email(state_origin,filedate).InvalidFileDateParm
																				,FAIL('Corp2_Mapping.NY failed.  An invalid filedate was passed in as a parameter.')))); 	

 End; //Update Function

End;//End NY Module