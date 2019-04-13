Import std, ut, Tools, corp2, versioncontrol, Scrubs, Corp2_Raw_CT, Scrubs_Corp2_Mapping_CT_Main;

export CT := MODULE; 
	
	export Update(String fileDate, String version, boolean pShouldSpray = _Dataset().bShouldSpray, boolean pOverwrite = false, pUseProd = Tools._Constants.IsDataland) := function
		
		state_origin	 := 'CT';
		state_fips	 	 := '09';	
		state_desc	 	 := 'CONNECTICUT';

		// Vendor Input Files
	  BusMaster  := dedup(sort(distribute(Corp2_Raw_CT.Files(filedate,pUseProd).input.fBusMaster,  hash(idBus)),    record,local), record,local) : independent; 
		BusFiling	 := dedup(sort(distribute(Corp2_Raw_CT.Files(filedate,pUseProd).input.fBusFiling,  hash(idBus)),    record,local), record,local) : independent;
 		BusMerger  := dedup(sort(distribute(Corp2_Raw_CT.Files(filedate,pUseProd).input.fBusMerger,  hash(idSurvBus)),record,local), record,local) : independent; 
		BusOther	 := dedup(sort(distribute(Corp2_Raw_CT.Files(filedate,pUseProd).input.fBusOther,   hash(idBus)),    record,local), record,local) : independent; 
		BusReserve := dedup(sort(distribute(Corp2_Raw_CT.Files(filedate,pUseProd).input.fBusReserve, hash(idBus)),    record,local), record,local) : independent; 
		Corps 	   := dedup(sort(distribute(Corp2_Raw_CT.Files(filedate,pUseProd).input.fCorps,      hash(idBus)),    record,local), record,local) : independent; 
		DlmtPart 	 := dedup(sort(distribute(Corp2_Raw_CT.Files(filedate,pUseProd).input.fDlmtPart,   hash(idBus)),		record,local), record,local) : independent; 
		FlmtPart 	 := dedup(sort(distribute(Corp2_Raw_CT.Files(filedate,pUseProd).input.fFlmtPart,   hash(idBus)),		record,local), record,local) : independent; 
		DlmtCorp 	 := dedup(sort(distribute(Corp2_Raw_CT.Files(filedate,pUseProd).input.fDlmtCorp,   hash(idBus)),		record,local), record,local) : independent; 
		FlmtCorp 	 := dedup(sort(distribute(Corp2_Raw_CT.Files(filedate,pUseProd).input.fFlmtCorp,   hash(idBus)),		record,local), record,local) : independent; 
		NameChg 	 := dedup(sort(distribute(Corp2_Raw_CT.Files(filedate,pUseProd).input.fNameChg,    hash(idBus)),		record,local), record,local) : independent; 
		FilmIndx 	 := dedup(sort(distribute(Corp2_Raw_CT.Files(filedate,pUseProd).input.fFilmIndx,   hash(idFlngNbr)),record,local), record,local) : independent; 
		Stock 		 := dedup(sort(distribute(Corp2_Raw_CT.Files(filedate,pUseProd).input.fStock,      hash(idBus)),		record,local), record,local) : independent; 
		Prncipal   := dedup(sort(distribute(Corp2_Raw_CT.Files(filedate,pUseProd).input.fPrncipal,   hash(idBus)),		record,local), record,local) : independent; 
		DlmlPart 	 := dedup(sort(distribute(Corp2_Raw_CT.Files(filedate,pUseProd).input.fDlmlPart,   hash(idBus)),		record,local), record,local) : independent;
		FlmlPart 	 := dedup(sort(distribute(Corp2_Raw_CT.Files(filedate,pUseProd).input.fFlmlPart,   hash(idBus)),		record,local), record,local) : independent; 
		General 	 := dedup(sort(distribute(Corp2_Raw_CT.Files(filedate,pUseProd).input.fGeneral,    hash(idBus)),		record,local), record,local) : independent; 
		ForStat 	 := dedup(sort(distribute(Corp2_Raw_CT.Files(filedate,pUseProd).input.fForStat,    hash(idBus)),		record,local), record,local) : independent; 


		//Normalize the BusMaster file on both RA Addresses
		Corp2_Raw_CT.Layouts.normalizedMaster normMaster(Corp2_Raw_CT.Layouts.BusMasterLayoutIN l, unsigned1 cnt) := transform
          ,skip(cnt=2 and corp2.t2u(l.adAgtResStr1 + l.adAgtResStr2 + l.adAgtResStr3 + l.adAgtResCity + l.adAgtResState + l.adAgtResZip5) = '')				
				self.normRAAddr1		:= choose(cnt ,l.adAgtBusStr1     ,l.adAgtResStr1 );
				self.normRAAddr2	 	:= choose(cnt ,l.adAgtBusStr2     ,l.adAgtResStr2 );
				self.normRAAddr3		:= choose(cnt ,l.adAgtBusStr3     ,l.adAgtResStr3 );
				self.normRACity			:= choose(cnt ,l.adAgtBusCity     ,l.adAgtResCity );
				self.normRAState		:= choose(cnt ,l.adAgtBusState    ,l.adAgtResState);		
				self.normRAZip5			:= choose(cnt ,l.adAgtBusZip5     ,l.adAgtResZip5 );
				self.normRAZip4			:= choose(cnt ,l.adAgtBusZip4     ,l.adAgtResZip4 );
				self.normRACountry	:= choose(cnt ,l.adAgtBusCntry    ,l.adAgtResCntry);
				self.normRAAddrType	:= choose(cnt ,'R'                ,'O');
				self.normRAAddrDesc	:= choose(cnt ,'REGISTERED OFFICE','RESIDENTIAL ADDRESS');			
				self 						    := l;
			end;

			NormBusMaster1	:= normalize(BusMaster, 2, normMaster(left, counter));	
			
			// Join NormBusMaster to Corps to get CdPlOfForm  
			NormBusMaster := join(NormBusMaster1, Corps,
															corp2.t2u(left.idBus) = corp2.t2u(right.idBus),
															transform(Corp2_Raw_CT.Layouts.normalizedMaster, 
															self.CdPlOfForm := right.CdPlOfForm; self := left;),
															left outer, local);
															
		
		//---------- Begin MAIN Mapping --------------------------------------------------------------//
		
		//---------- Begin CORP Mapping --------------------------------------------------------------//
			
			domestic := ['D','G','I','K','L','O'];
			foreign  := ['F','H','J','M'];
			
			//---------------------------------------------------------------		  
			// Map BUSMASTER input file to MAIN (and join in BUSMERGER recs)
			//---------------------------------------------------------------
															
			// Create Merger Recs from the BusMerger file for Non-Survivor Ids
			BusMergerTerm := project(BusMerger(idTermBus not in ['0000000','']),
														transform(Corp2_Raw_CT.Layouts.TempLay_MergerRecs,
														self.SurvOrTermID := left.idTermBus; 
														self.SurvOrTermFlag := 'N'; 
														self.dtFiling := left.dtFiling));
			
			// Create Merger Recs from the BusMerger file for Survivor Ids											
	    BusMergerSurv := project(BusMerger(idSurvBus not in ['0000000','']),
														transform(Corp2_Raw_CT.Layouts.TempLay_MergerRecs,
														self.SurvOrTermID := left.idSurvBus; 
														self.SurvOrTermFlag := 'S'; 
														self.dtFiling := left.dtFiling));
														
      // Combine Non-Survivor and Survivor records into one file that will be joined to the BUSMASTER file	    
			MergerRecs := dedup(sort(distribute(BusMergerTerm + BusMergerSurv,hash(SurvOrTermID)),record,local),record,local);													
			
		  jTempLay_MasterWithMerger := join(NormBusMaster, MergerRecs,
															corp2.t2u(left.idBus) = corp2.t2u(right.SurvOrTermID),
															transform(Corp2_Raw_CT.Layouts.TempLay_MasterWithMerger, self := left; self := right;),
															left outer, local);
															
			Corp2_Mapping.LayoutsCommon.Main corpBusMstrTrf(Corp2_Raw_CT.Layouts.TempLay_MasterWithMerger input) := transform
									,skip(corp2.t2u(input.nmName)='TEST TEST 123' or input.idBus='0000000')
				self.corp_key										:= state_fips + '-' + corp2.t2u(input.idBus);
				self.corp_orig_sos_charter_nbr	:= corp2.t2u(input.idBus);
				self.corp_legal_name						:= Corp2_Mapping.fCleanBusinessName(state_origin,state_desc,input.nmName).BusinessName;
				self.corp_ln_name_type_cd				:= '01';
				self.corp_ln_name_type_desc			:= 'LEGAL';																			
				self.corp_additional_principals := if (corp2.t2u(input.flAddlPrinc) in ['Y','N']
				                                      ,corp2.t2u(input.flAddlPrinc) ,'');
				self.corp_for_profit_ind        := if (corp2.t2u(input.cdSubType) = 'B', 'N', '');	
				self.corp_foreign_domestic_ind  := map(corp2.t2u(input.cdSubType) = 'C' and corp2.t2u(input.cdPlOfForm) in [state_origin,''] => 'D',
				                                       corp2.t2u(input.cdSubType) = 'C' and corp2.t2u(input.cdPlOfForm) not in [state_origin,''] => 'F',
																							 corp2.t2u(input.cdSubType) in domestic => 'D',
				                                       corp2.t2u(input.cdSubType) in foreign  => 'F',
																							 '');
				self.corp_inc_date              := if (corp2.t2u(input.cdSubType) in domestic or 
																							 (corp2.t2u(input.cdSubType) = 'C' and corp2.t2u(input.cdPlOfForm) in [state_origin,'']) 
																							   ,Corp2_Mapping.fValidateDate(input.dtOrigin,'CCYYMMDD').PastDate ,'');																			 
				self.corp_forgn_date            := if (corp2.t2u(input.cdSubType) in foreign or 
																							 (corp2.t2u(input.cdSubType) = 'C' and corp2.t2u(input.cdPlOfForm) not in [state_origin,''])
				                                       ,Corp2_Mapping.fValidateDate(input.dtOrigin,'CCYYMMDD').PastDate ,'');
	
				self.corp_ra_full_name					:= Corp2_Mapping.fCleanBusinessName(state_origin,state_desc,input.nmAgt).BusinessName;
				self.corp_ra_addl_info          := case(corp2.t2u(input.cdAgtType),
																								'B' => 'BUSINESS',
				                                        'I' => 'INDIVIDUAL',
																								'S' => 'SECRETARY OF STATE', '');
        self.corp_ra_resign_date        := Corp2_Mapping.fValidateDate(input.dtAgtResign,'CCYYMMDD').PastDate;  
				self.corp_orig_org_structure_cd	:= corp2.t2u(input.cdSubType);
				self.corp_orig_org_structure_desc	:= Corp2_Raw_CT.Functions.GetOrgStrucDesc(input.cdSubType);
				self.corp_status_cd							:= corp2.t2u(input.cdStatus);
				self.corp_status_desc						:= Corp2_Raw_CT.Functions.GetStatusDesc(input.cdStatus);
							
				corp1str := Corp2_Raw_CT.Functions.FixStreet(input.adStr1,input.adStr2,input.adstr3);
				corp2str := Corp2_Raw_CT.Functions.FixStreet(input.adMailStr1,input.adMailStr2,input.adMailStr3);
				MailingOnly := if(Corp2_Mapping.fAddressExists(state_origin,state_desc,corp1str,'',input.adCity,input.adState,input.adZip5 + input.adZip4,input.adCntry).ifAddressExists,'N','Y'); 

				self.corp_address1_type_cd      := if(MailingOnly = 'N'
																							,if (Corp2_Mapping.fAddressExists(state_origin,state_desc,corp1str,'',input.adCity,input.adState,input.adZip5 + input.adZip4,input.adCntry).ifAddressExists,'B','')
																							,if (Corp2_Mapping.fAddressExists(state_origin,state_desc,input.adMailStr1,input.adMailStr2 + input.adMailStr3,input.adMailCity,input.adMailState,input.adMailZip5 + input.adMailZip4,input.adMailCntry).ifAddressExists,'M','')
																							);
				self.corp_address1_type_desc    := if(MailingOnly = 'N'
																							,if (Corp2_Mapping.fAddressExists(state_origin,state_desc,corp1str,'',input.adCity,input.adState,input.adZip5 + input.adZip4,input.adCntry).ifAddressExists,'BUSINESS','')
																							,if (Corp2_Mapping.fAddressExists(state_origin,state_desc,input.adMailStr1,input.adMailStr2 + input.adMailStr3,input.adMailCity,input.adMailState,input.adMailZip5 + input.adMailZip4,input.adMailCntry).ifAddressExists,'MAILING','')
																							);
				self.corp_address1_line1        := if(MailingOnly = 'N'
																							,Corp2_Mapping.fCleanAddress (state_origin,state_desc,corp1str,'',input.adCity,input.adState,input.adZip5 + input.adZip4,input.adCntry).AddressLine1
																							,Corp2_Mapping.fCleanAddress (state_origin,state_desc,corp2str,'',input.adMailCity,input.adMailState,input.adMailZip5 + input.adMailZip4,input.adMailCntry).AddressLine1
																							);
				self.corp_address1_line2        := if(MailingOnly = 'N'
																							,Corp2_Mapping.fCleanAddress (state_origin,state_desc,corp1str,'',input.adCity,input.adState,input.adZip5 + input.adZip4,input.adCntry).AddressLine2
																							,Corp2_Mapping.fCleanAddress (state_origin,state_desc,corp2str,'',input.adMailCity,input.adMailState,input.adMailZip5 + input.adMailZip4,input.adMailCntry).AddressLine2
																							);				
				self.corp_address1_line3        := if(MailingOnly = 'N'
																							,Corp2_Mapping.fCleanAddress (state_origin,state_desc,corp1str,'',input.adCity,input.adState,input.adZip5 + input.adZip4,input.adCntry).AddressLine3
																							,Corp2_Mapping.fCleanAddress (state_origin,state_desc,corp2str,'',input.adMailCity,input.adMailState,input.adMailZip5 + input.adMailZip4,input.adMailCntry).AddressLine3
																							);	
				self.corp_prep_addr1_line1        := if(MailingOnly = 'N'
																							,Corp2_Mapping.fCleanAddress (state_origin,state_desc,corp1str,'',input.adCity,input.adState,input.adZip5,input.adCntry).PrepAddrLine1
																							,Corp2_Mapping.fCleanAddress (state_origin,state_desc,corp2str,'',input.adMailCity,input.adMailState,input.adMailZip5,input.adMailCntry).PrepAddrLine1
																							);	
				self.corp_prep_addr1_last_line        := if(MailingOnly = 'N'
																							,Corp2_Mapping.fCleanAddress (state_origin,state_desc,corp1str,'',input.adCity,input.adState,input.adZip5,input.adCntry).PrepAddrLastLine
																							,Corp2_Mapping.fCleanAddress (state_origin,state_desc,corp2str,'',input.adMailCity,input.adMailState,input.adMailZip5,input.adMailCntry).PrepAddrLastLine
																							);																							
				
				self.corp_address2_type_cd      := if(MailingOnly = 'N' ,if (Corp2_Mapping.fAddressExists(state_origin,state_desc,input.adMailStr1,input.adMailStr2 + input.adMailStr3,input.adMailCity,input.adMailState,input.adMailZip5 + input.adMailZip4,input.adMailCntry).ifAddressExists,'M','') ,'');	
				self.corp_address2_type_desc    := if(MailingOnly = 'N' ,if (Corp2_Mapping.fAddressExists(state_origin,state_desc,input.adMailStr1,input.adMailStr2 + input.adMailStr3,input.adMailCity,input.adMailState,input.adMailZip5 + input.adMailZip4,input.adMailCntry).ifAddressExists,'MAILING','') ,'');
				self.corp_address2_line1			  := if(MailingOnly = 'N' ,Corp2_Mapping.fCleanAddress (state_origin,state_desc,corp2str,'',input.adMailCity,input.adMailState,input.adMailZip5 + input.adMailZip4,input.adMailCntry).AddressLine1 ,'');
				self.corp_address2_line2				:= if(MailingOnly = 'N' ,Corp2_Mapping.fCleanAddress (state_origin,state_desc,corp2str,'',input.adMailCity,input.adMailState,input.adMailZip5 + input.adMailZip4,input.adMailCntry).AddressLine2 ,'');
				self.corp_address2_line3				:= if(MailingOnly = 'N' ,Corp2_Mapping.fCleanAddress (state_origin,state_desc,corp2str,'',input.adMailCity,input.adMailState,input.adMailZip5 + input.adMailZip4,input.adMailCntry).AddressLine3 ,'');			
				self.corp_prep_addr2_line1			:= if(MailingOnly = 'N' ,Corp2_Mapping.fCleanAddress (state_origin,state_desc,corp2str,'',input.adMailCity,input.adMailState,input.adMailZip5,input.adMailCntry).PrepAddrLine1 ,'');			
				self.corp_prep_addr2_last_line	:= if(MailingOnly = 'N' ,Corp2_Mapping.fCleanAddress (state_origin,state_desc,corp2str,'',input.adMailCity,input.adMailState,input.adMailZip5,input.adMailCntry).PrepAddrLastLine ,'');
				
        rastr := Corp2_Raw_CT.Functions.FixStreet(input.normRAAddr1,input.normRAAddr2,input.normRAAddr3);				
				self.corp_ra_address_type_cd    := if (Corp2_Mapping.fAddressExists(state_origin,state_desc,rastr,'',input.normRACity,input.normRAState,input.normRAZip5 + input.normRAZip4,input.normRACountry).ifAddressExists,input.normRAAddrType,'');
				self.corp_ra_address_type_desc  := if (Corp2_Mapping.fAddressExists(state_origin,state_desc,rastr,'',input.normRACity,input.normRAState,input.normRAZip5 + input.normRAZip4,input.normRACountry).ifAddressExists,input.normRAAddrDesc,'');
				self.corp_ra_address_line1		  := Corp2_Mapping.fCleanAddress (state_origin,state_desc,rastr,'',input.normRACity,input.normRAState,input.normRAZip5 + input.normRAZip4,input.normRACountry).AddressLine1;
				self.corp_ra_address_line2		  := Corp2_Mapping.fCleanAddress (state_origin,state_desc,rastr,'',input.normRACity,input.normRAState,input.normRAZip5 + input.normRAZip4,input.normRACountry).AddressLine2;
				self.corp_ra_address_line3		  := Corp2_Mapping.fCleanAddress (state_origin,state_desc,rastr,'',input.normRACity,input.normRAState,input.normRAZip5 + input.normRAZip4,input.normRACountry).AddressLine3;			
				self.ra_prep_addr_line1					:= Corp2_Mapping.fCleanAddress (state_origin,state_desc,rastr,'',input.normRACity,input.normRAState,input.normRAZip5,input.normRACountry).PrepAddrLine1;			
				self.ra_prep_addr_last_line 		:= Corp2_Mapping.fCleanAddress (state_origin,state_desc,rastr,'',input.normRACity,input.normRAState,input.normRAZip5,input.normRACountry).PrepAddrLastLine;
 				
				self.corp_merged_corporation_id := if (corp2.t2u(input.SurvOrTermFlag) = 'N' ,corp2.t2u(input.SurvOrTermID) ,'');
				self.corp_merger_id             := if (corp2.t2u(input.SurvOrTermFlag) = 'S' ,corp2.t2u(input.SurvOrTermID) ,'');
        self.corp_merger_indicator      := if (corp2.t2u(input.SurvOrTermFlag) in ['N','S'] ,corp2.t2u(input.SurvOrTermFlag) ,'');
				self.corp_merger_desc           := case(input.SurvOrTermFlag,
				                                        'N' => 'NON SURVIVOR BUSINESS ID ' + corp2.t2u(input.SurvOrTermID),
																								'S' => 'SURVIVOR BUSINESS ID ' + corp2.t2u(input.SurvOrTermID),
																								'');
				self.corp_merger_date           := Corp2_Mapping.fValidateDate(input.dtFiling,'CCYYMMDD').PastDate; 
				self														:= [];
			end;
			
			mapBusMaster	:= project(jTempLay_MasterWithMerger(cdSubtype='L'), corpBusMstrTrf(left));
			
      //-----------------------------------------		  
			// Map CORPS input file to MAIN
			//-----------------------------------------
		  jTempLay_CorpWithMaster := join(Corps, NormBusMaster,
															corp2.t2u(left.idBus) = corp2.t2u(right.idBus),
															transform(Corp2_Raw_CT.Layouts.TempLay_CorpWithMaster, self := left; self := right;),
															left outer, local);
														
			Corp2_Mapping.LayoutsCommon.Main corpMasterTrf(Corp2_Raw_CT.Layouts.TempLay_CorpWithMaster input) := transform
									,skip( corp2.t2u(input.nmName) in ['','TEST TEST 123'] or input.idBus='0000000' )
				self.corp_key										:= state_fips + '-' + corp2.t2u(input.idBus);
				self.corp_orig_sos_charter_nbr	:= corp2.t2u(input.idBus);
				self.corp_legal_name						:= Corp2_Mapping.fCleanBusinessName(state_origin,state_desc,input.nmName).BusinessName;
				self.corp_ln_name_type_cd				:= '01';
				self.corp_ln_name_type_desc			:= 'LEGAL';
				self.corp_status_date						:= Corp2_Mapping.fValidateDate(input.dtDissolve,'CCYYMMDD').GeneralDate;	
				self.corp_dissolved_date				:= Corp2_Mapping.fValidateDate(input.dtDissolve,'CCYYMMDD').GeneralDate;	
				self.corp_filing_date				    := Corp2_Mapping.fValidateDate(input.dtComncBus,'CCYYMMDD').GeneralDate;
				self.corp_filing_cd             := if (self.corp_filing_date <> '' ,'X' ,'');
				self.corp_filing_desc           := if (self.corp_filing_date <> '' ,'COMMENCE BUSINESS DATE' ,'');
				self.corp_additional_principals := if (corp2.t2u(input.flAddlPrinc) in ['Y','N']
				                                      ,corp2.t2u(input.flAddlPrinc) ,'');
				self.corp_for_profit_ind        := if (corp2.t2u(input.cdSubType) = 'B', 'N', '');
				self.corp_foreign_domestic_ind  := map(corp2.t2u(input.cdSubType) in domestic or corp2.t2u(input.cdCitizen) = 'D' => 'D',
				                                       corp2.t2u(input.cdSubType) in foreign  or corp2.t2u(input.cdCitizen) = 'F' => 'F',
																							 '');
				self.corp_inc_date              := if (corp2.t2u(input.cdSubType) in domestic or 
																							 (corp2.t2u(input.cdSubType) = 'C' and corp2.t2u(input.cdPlOfForm) in [state_origin,'']) 
																							   ,Corp2_Mapping.fValidateDate(input.dtOrigin,'CCYYMMDD').PastDate ,'');																			 
				self.corp_forgn_date            := if (corp2.t2u(input.cdSubType) in foreign or 
																							 (corp2.t2u(input.cdSubType) = 'C' and corp2.t2u(input.cdPlOfForm) not in [state_origin,''])
				                                       ,Corp2_Mapping.fValidateDate(input.dtOrigin,'CCYYMMDD').PastDate ,'');				self.corp_ra_full_name					:= Corp2_Mapping.fCleanBusinessName(state_origin,state_desc,input.nmAgt).BusinessName;
				self.corp_ra_addl_info          := case(corp2.t2u(input.cdAgtType),
																								'B' => 'BUSINESS',
				                                        'I' => 'INDIVIDUAL',
																								'S' => 'SECRETARY OF STATE', '');
        self.corp_ra_resign_date        := Corp2_Mapping.fValidateDate(input.dtAgtResign,'CCYYMMDD').PastDate;
				self.corp_orig_org_structure_cd	:= corp2.t2u(input.cdSubType);
				self.corp_orig_org_structure_desc	:= Corp2_Raw_CT.Functions.GetOrgStrucDesc(input.cdSubType);
				self.corp_status_cd							:= corp2.t2u(input.cdStatus);
				self.corp_status_desc						:= Corp2_Raw_CT.Functions.GetStatusDesc(input.cdStatus);
				
				corp1str := Corp2_Raw_CT.Functions.FixStreet(input.adStr1,input.adStr2,input.adstr3);
				corp2str := Corp2_Raw_CT.Functions.FixStreet(input.adMailStr1,input.adMailStr2,input.adMailStr3);
				MailingOnly := if(Corp2_Mapping.fAddressExists(state_origin,state_desc,corp1str,'',input.adCity,input.adState,input.adZip5 + input.adZip4,input.adCntry).ifAddressExists,'N','Y'); 

				self.corp_address1_type_cd      := if(MailingOnly = 'N'
																							,if (Corp2_Mapping.fAddressExists(state_origin,state_desc,corp1str,'',input.adCity,input.adState,input.adZip5 + input.adZip4,input.adCntry).ifAddressExists,'B','')
																							,if (Corp2_Mapping.fAddressExists(state_origin,state_desc,input.adMailStr1,input.adMailStr2 + input.adMailStr3,input.adMailCity,input.adMailState,input.adMailZip5 + input.adMailZip4,input.adMailCntry).ifAddressExists,'M','')
																							);
				self.corp_address1_type_desc    := if(MailingOnly = 'N'
																							,if (Corp2_Mapping.fAddressExists(state_origin,state_desc,corp1str,'',input.adCity,input.adState,input.adZip5 + input.adZip4,input.adCntry).ifAddressExists,'BUSINESS','')
																							,if (Corp2_Mapping.fAddressExists(state_origin,state_desc,input.adMailStr1,input.adMailStr2 + input.adMailStr3,input.adMailCity,input.adMailState,input.adMailZip5 + input.adMailZip4,input.adMailCntry).ifAddressExists,'MAILING','')
																							);
				self.corp_address1_line1        := if(MailingOnly = 'N'
																							,Corp2_Mapping.fCleanAddress (state_origin,state_desc,corp1str,'',input.adCity,input.adState,input.adZip5 + input.adZip4,input.adCntry).AddressLine1
																							,Corp2_Mapping.fCleanAddress (state_origin,state_desc,corp2str,'',input.adMailCity,input.adMailState,input.adMailZip5 + input.adMailZip4,input.adMailCntry).AddressLine1
																							);
				self.corp_address1_line2        := if(MailingOnly = 'N'
																							,Corp2_Mapping.fCleanAddress (state_origin,state_desc,corp1str,'',input.adCity,input.adState,input.adZip5 + input.adZip4,input.adCntry).AddressLine2
																							,Corp2_Mapping.fCleanAddress (state_origin,state_desc,corp2str,'',input.adMailCity,input.adMailState,input.adMailZip5 + input.adMailZip4,input.adMailCntry).AddressLine2
																							);				
				self.corp_address1_line3        := if(MailingOnly = 'N'
																							,Corp2_Mapping.fCleanAddress (state_origin,state_desc,corp1str,'',input.adCity,input.adState,input.adZip5 + input.adZip4,input.adCntry).AddressLine3
																							,Corp2_Mapping.fCleanAddress (state_origin,state_desc,corp2str,'',input.adMailCity,input.adMailState,input.adMailZip5 + input.adMailZip4,input.adMailCntry).AddressLine3
																							);	
				self.corp_prep_addr1_line1        := if(MailingOnly = 'N'
																							,Corp2_Mapping.fCleanAddress (state_origin,state_desc,corp1str,'',input.adCity,input.adState,input.adZip5,input.adCntry).PrepAddrLine1
																							,Corp2_Mapping.fCleanAddress (state_origin,state_desc,corp2str,'',input.adMailCity,input.adMailState,input.adMailZip5,input.adMailCntry).PrepAddrLine1
																							);	
				self.corp_prep_addr1_last_line        := if(MailingOnly = 'N'
																							,Corp2_Mapping.fCleanAddress (state_origin,state_desc,corp1str,'',input.adCity,input.adState,input.adZip5,input.adCntry).PrepAddrLastLine
																							,Corp2_Mapping.fCleanAddress (state_origin,state_desc,corp2str,'',input.adMailCity,input.adMailState,input.adMailZip5,input.adMailCntry).PrepAddrLastLine
																							);																							
				
				self.corp_address2_type_cd      := if(MailingOnly = 'N' ,if (Corp2_Mapping.fAddressExists(state_origin,state_desc,input.adMailStr1,input.adMailStr2 + input.adMailStr3,input.adMailCity,input.adMailState,input.adMailZip5 + input.adMailZip4,input.adMailCntry).ifAddressExists,'M','') ,'');	
				self.corp_address2_type_desc    := if(MailingOnly = 'N' ,if (Corp2_Mapping.fAddressExists(state_origin,state_desc,input.adMailStr1,input.adMailStr2 + input.adMailStr3,input.adMailCity,input.adMailState,input.adMailZip5 + input.adMailZip4,input.adMailCntry).ifAddressExists,'MAILING','') ,'');
				self.corp_address2_line1			  := if(MailingOnly = 'N' ,Corp2_Mapping.fCleanAddress (state_origin,state_desc,corp2str,'',input.adMailCity,input.adMailState,input.adMailZip5 + input.adMailZip4,input.adMailCntry).AddressLine1 ,'');
				self.corp_address2_line2				:= if(MailingOnly = 'N' ,Corp2_Mapping.fCleanAddress (state_origin,state_desc,corp2str,'',input.adMailCity,input.adMailState,input.adMailZip5 + input.adMailZip4,input.adMailCntry).AddressLine2 ,'');
				self.corp_address2_line3				:= if(MailingOnly = 'N' ,Corp2_Mapping.fCleanAddress (state_origin,state_desc,corp2str,'',input.adMailCity,input.adMailState,input.adMailZip5 + input.adMailZip4,input.adMailCntry).AddressLine3 ,'');			
				self.corp_prep_addr2_line1			:= if(MailingOnly = 'N' ,Corp2_Mapping.fCleanAddress (state_origin,state_desc,corp2str,'',input.adMailCity,input.adMailState,input.adMailZip5,input.adMailCntry).PrepAddrLine1 ,'');			
				self.corp_prep_addr2_last_line	:= if(MailingOnly = 'N' ,Corp2_Mapping.fCleanAddress (state_origin,state_desc,corp2str,'',input.adMailCity,input.adMailState,input.adMailZip5,input.adMailCntry).PrepAddrLastLine ,'');
				
        rastr := Corp2_Raw_CT.Functions.FixStreet(input.normRAAddr1,input.normRAAddr2,input.normRAAddr3);				
				self.corp_ra_address_type_cd    := if (Corp2_Mapping.fAddressExists(state_origin,state_desc,rastr,'',input.normRACity,input.normRAState,input.normRAZip5 + input.normRAZip4,input.normRACountry).ifAddressExists,input.normRAAddrType,'');
				self.corp_ra_address_type_desc  := if (Corp2_Mapping.fAddressExists(state_origin,state_desc,rastr,'',input.normRACity,input.normRAState,input.normRAZip5 + input.normRAZip4,input.normRACountry).ifAddressExists,input.normRAAddrDesc,'');
				self.corp_ra_address_line1		  := Corp2_Mapping.fCleanAddress (state_origin,state_desc,rastr,'',input.normRACity,input.normRAState,input.normRAZip5 + input.normRAZip4,input.normRACountry).AddressLine1;
				self.corp_ra_address_line2		  := Corp2_Mapping.fCleanAddress (state_origin,state_desc,rastr,'',input.normRACity,input.normRAState,input.normRAZip5 + input.normRAZip4,input.normRACountry).AddressLine2;
				self.corp_ra_address_line3		  := Corp2_Mapping.fCleanAddress (state_origin,state_desc,rastr,'',input.normRACity,input.normRAState,input.normRAZip5 + input.normRAZip4,input.normRACountry).AddressLine3;			
				self.ra_prep_addr_line1					:= Corp2_Mapping.fCleanAddress (state_origin,state_desc,rastr,'',input.normRACity,input.normRAState,input.normRAZip5,input.normRACountry).PrepAddrLine1;			
				self.ra_prep_addr_last_line 		:= Corp2_Mapping.fCleanAddress (state_origin,state_desc,rastr,'',input.normRACity,input.normRAState,input.normRAZip5,input.normRACountry).PrepAddrLastLine;
				
				self.corp_addl_info							:= case(corp2.t2u(input.cdBusType),
																								'B' => 'BUSINESS TYPE: BENEFIT CORPORATION',				
																								'S' => 'BUSINESS TYPE: STOCK',
																								'N' => 'BUSINESS TYPE: NON STOCK',
																								'');
				self.corp_entity_desc						:= case(corp2.t2u(input.cdOrigin),
																								'R' => 'REGULAR',	'S' => 'SPECIALTY CHARTER',	'');
				self.corp_country_of_formation  := Corp2_Raw_CT.Functions.Decode_Country(input.cdPlOfForm);																			
			  self.corp_forgn_state_cd				:= if (corp2.t2u(input.cdPlOfForm) not in [state_origin,'']	,corp2.t2u(input.cdPlOfForm) ,'');
				self.corp_forgn_state_desc			:= if(self.corp_forgn_state_cd <> ''
																							,Corp2_Raw_CT.Functions.GetStateDesc(self.corp_forgn_state_cd) ,'');
				self.corp_home_state_name       := corp2.t2u(input.nmForeign);																			
				self 														:= [];
			end; 
			
			mapCorp	:= project(jTempLay_CorpWithMaster, corpMasterTrf(left));
			
	
			//-----------------------------------------		  
			// Map BUSOTHER input file to MAIN
			//-----------------------------------------
			jTempLay_OtherWithMaster := join(BusOther, NormBusMaster,
																	corp2.t2u(left.idBus) = corp2.t2u(right.idBus),
																	transform(Corp2_Raw_CT.Layouts.TempLay_OtherWithMaster, self := left; self := right;),
																	left outer, local);	
			
			Corp2_Mapping.LayoutsCommon.Main corpOtherTrf(Corp2_Raw_CT.Layouts.TempLay_OtherWithMaster input) := transform
									,skip(corp2.t2u(input.nmName) in ['','TEST TEST 123'] or input.idBus='0000000')
				self.corp_key										:= state_fips + '-' + corp2.t2u(input.idBus);
				self.corp_orig_sos_charter_nbr	:= corp2.t2u(input.idBus);
				self.corp_legal_name						:= Corp2_Mapping.fCleanBusinessName(state_origin,state_desc,input.nmName).BusinessName;
				self.corp_ln_name_type_cd				:= '01';
				self.corp_ln_name_type_desc			:= 'LEGAL';	
				self.corp_status_date						:= Corp2_Mapping.fValidateDate(input.dtDissolve,'CCYYMMDD').GeneralDate;	
				self.corp_dissolved_date				:= Corp2_Mapping.fValidateDate(input.dtDissolve,'CCYYMMDD').GeneralDate;					
				self.corp_additional_principals := if (corp2.t2u(input.flAddlPrinc) in ['Y','N']
				                                      ,corp2.t2u(input.flAddlPrinc) ,'');
				self.corp_for_profit_ind        := if (corp2.t2u(input.cdSubType) = 'B', 'N', '');																			
				self.corp_foreign_domestic_ind  := map(corp2.t2u(input.cdSubType) = 'C' and corp2.t2u(input.cdPlOfForm) in [state_origin,''] => 'D',
				                                       corp2.t2u(input.cdSubType) = 'C' and corp2.t2u(input.cdPlOfForm) not in [state_origin,''] => 'F',
																							 corp2.t2u(input.cdSubType) in domestic => 'D',
				                                       corp2.t2u(input.cdSubType) in foreign  => 'F',
																							 '');
				self.corp_inc_date              := if (corp2.t2u(input.cdSubType) in domestic or 
																							 (corp2.t2u(input.cdSubType) = 'C' and corp2.t2u(input.cdPlOfForm) in [state_origin,'']) 
																							   ,Corp2_Mapping.fValidateDate(input.dtOrigin,'CCYYMMDD').PastDate ,'');																			 
				self.corp_forgn_date            := if (corp2.t2u(input.cdSubType) in foreign or 
																							 (corp2.t2u(input.cdSubType) = 'C' and corp2.t2u(input.cdPlOfForm) not in [state_origin,''])
				                                       ,Corp2_Mapping.fValidateDate(input.dtOrigin,'CCYYMMDD').PastDate ,'');				self.corp_ra_full_name					:= Corp2_Mapping.fCleanBusinessName(state_origin,state_desc,input.nmAgt).BusinessName;
				self.corp_ra_addl_info          := case(corp2.t2u(input.cdAgtType),
																								'B' => 'BUSINESS',
				                                        'I' => 'INDIVIDUAL',
																								'S' => 'SECRETARY OF STATE', '');
        self.corp_ra_resign_date        := Corp2_Mapping.fValidateDate(input.dtAgtResign,'CCYYMMDD').PastDate;
				self.corp_orig_org_structure_cd	:= corp2.t2u(input.cdSubType);
				self.corp_orig_org_structure_desc	:= Corp2_Raw_CT.Functions.GetOrgStrucDesc(input.cdSubType);
				self.corp_status_cd							:= corp2.t2u(input.cdStatus);
				self.corp_status_desc						:= Corp2_Raw_CT.Functions.GetStatusDesc(input.cdStatus);
				
				corp1str := Corp2_Raw_CT.Functions.FixStreet(input.adStr1,input.adStr2,input.adstr3);
				corp2str := Corp2_Raw_CT.Functions.FixStreet(input.adMailStr1,input.adMailStr2,input.adMailStr3);
				MailingOnly := if(Corp2_Mapping.fAddressExists(state_origin,state_desc,corp1str,'',input.adCity,input.adState,input.adZip5 + input.adZip4,input.adCntry).ifAddressExists,'N','Y'); 

				self.corp_address1_type_cd      := if(MailingOnly = 'N'
																							,if (Corp2_Mapping.fAddressExists(state_origin,state_desc,corp1str,'',input.adCity,input.adState,input.adZip5 + input.adZip4,input.adCntry).ifAddressExists,'B','')
																							,if (Corp2_Mapping.fAddressExists(state_origin,state_desc,input.adMailStr1,input.adMailStr2 + input.adMailStr3,input.adMailCity,input.adMailState,input.adMailZip5 + input.adMailZip4,input.adMailCntry).ifAddressExists,'M','')
																							);
				self.corp_address1_type_desc    := if(MailingOnly = 'N'
																							,if (Corp2_Mapping.fAddressExists(state_origin,state_desc,corp1str,'',input.adCity,input.adState,input.adZip5 + input.adZip4,input.adCntry).ifAddressExists,'BUSINESS','')
																							,if (Corp2_Mapping.fAddressExists(state_origin,state_desc,input.adMailStr1,input.adMailStr2 + input.adMailStr3,input.adMailCity,input.adMailState,input.adMailZip5 + input.adMailZip4,input.adMailCntry).ifAddressExists,'MAILING','')
																							);
				self.corp_address1_line1        := if(MailingOnly = 'N'
																							,Corp2_Mapping.fCleanAddress (state_origin,state_desc,corp1str,'',input.adCity,input.adState,input.adZip5 + input.adZip4,input.adCntry).AddressLine1
																							,Corp2_Mapping.fCleanAddress (state_origin,state_desc,corp2str,'',input.adMailCity,input.adMailState,input.adMailZip5 + input.adMailZip4,input.adMailCntry).AddressLine1
																							);
				self.corp_address1_line2        := if(MailingOnly = 'N'
																							,Corp2_Mapping.fCleanAddress (state_origin,state_desc,corp1str,'',input.adCity,input.adState,input.adZip5 + input.adZip4,input.adCntry).AddressLine2
																							,Corp2_Mapping.fCleanAddress (state_origin,state_desc,corp2str,'',input.adMailCity,input.adMailState,input.adMailZip5 + input.adMailZip4,input.adMailCntry).AddressLine2
																							);				
				self.corp_address1_line3        := if(MailingOnly = 'N'
																							,Corp2_Mapping.fCleanAddress (state_origin,state_desc,corp1str,'',input.adCity,input.adState,input.adZip5 + input.adZip4,input.adCntry).AddressLine3
																							,Corp2_Mapping.fCleanAddress (state_origin,state_desc,corp2str,'',input.adMailCity,input.adMailState,input.adMailZip5 + input.adMailZip4,input.adMailCntry).AddressLine3
																							);	
				self.corp_prep_addr1_line1        := if(MailingOnly = 'N'
																							,Corp2_Mapping.fCleanAddress (state_origin,state_desc,corp1str,'',input.adCity,input.adState,input.adZip5,input.adCntry).PrepAddrLine1
																							,Corp2_Mapping.fCleanAddress (state_origin,state_desc,corp2str,'',input.adMailCity,input.adMailState,input.adMailZip5,input.adMailCntry).PrepAddrLine1
																							);	
				self.corp_prep_addr1_last_line        := if(MailingOnly = 'N'
																							,Corp2_Mapping.fCleanAddress (state_origin,state_desc,corp1str,'',input.adCity,input.adState,input.adZip5,input.adCntry).PrepAddrLastLine
																							,Corp2_Mapping.fCleanAddress (state_origin,state_desc,corp2str,'',input.adMailCity,input.adMailState,input.adMailZip5,input.adMailCntry).PrepAddrLastLine
																							);																							
				
				self.corp_address2_type_cd      := if(MailingOnly = 'N' ,if (Corp2_Mapping.fAddressExists(state_origin,state_desc,input.adMailStr1,input.adMailStr2 + input.adMailStr3,input.adMailCity,input.adMailState,input.adMailZip5 + input.adMailZip4,input.adMailCntry).ifAddressExists,'M','') ,'');	
				self.corp_address2_type_desc    := if(MailingOnly = 'N' ,if (Corp2_Mapping.fAddressExists(state_origin,state_desc,input.adMailStr1,input.adMailStr2 + input.adMailStr3,input.adMailCity,input.adMailState,input.adMailZip5 + input.adMailZip4,input.adMailCntry).ifAddressExists,'MAILING','') ,'');
				self.corp_address2_line1			  := if(MailingOnly = 'N' ,Corp2_Mapping.fCleanAddress (state_origin,state_desc,corp2str,'',input.adMailCity,input.adMailState,input.adMailZip5 + input.adMailZip4,input.adMailCntry).AddressLine1 ,'');
				self.corp_address2_line2				:= if(MailingOnly = 'N' ,Corp2_Mapping.fCleanAddress (state_origin,state_desc,corp2str,'',input.adMailCity,input.adMailState,input.adMailZip5 + input.adMailZip4,input.adMailCntry).AddressLine2 ,'');
				self.corp_address2_line3				:= if(MailingOnly = 'N' ,Corp2_Mapping.fCleanAddress (state_origin,state_desc,corp2str,'',input.adMailCity,input.adMailState,input.adMailZip5 + input.adMailZip4,input.adMailCntry).AddressLine3 ,'');			
				self.corp_prep_addr2_line1			:= if(MailingOnly = 'N' ,Corp2_Mapping.fCleanAddress (state_origin,state_desc,corp2str,'',input.adMailCity,input.adMailState,input.adMailZip5,input.adMailCntry).PrepAddrLine1 ,'');			
				self.corp_prep_addr2_last_line	:= if(MailingOnly = 'N' ,Corp2_Mapping.fCleanAddress (state_origin,state_desc,corp2str,'',input.adMailCity,input.adMailState,input.adMailZip5,input.adMailCntry).PrepAddrLastLine ,'');
								
        rastr := Corp2_Raw_CT.Functions.FixStreet(input.normRAAddr1,input.normRAAddr2,input.normRAAddr3);				
				self.corp_ra_address_type_cd    := if (Corp2_Mapping.fAddressExists(state_origin,state_desc,rastr,'',input.normRACity,input.normRAState,input.normRAZip5 + input.normRAZip4,input.normRACountry).ifAddressExists,input.normRAAddrType,'');
				self.corp_ra_address_type_desc  := if (Corp2_Mapping.fAddressExists(state_origin,state_desc,rastr,'',input.normRACity,input.normRAState,input.normRAZip5 + input.normRAZip4,input.normRACountry).ifAddressExists,input.normRAAddrDesc,'');
				self.corp_ra_address_line1		  := Corp2_Mapping.fCleanAddress (state_origin,state_desc,rastr,'',input.normRACity,input.normRAState,input.normRAZip5 + input.normRAZip4,input.normRACountry).AddressLine1;
				self.corp_ra_address_line2		  := Corp2_Mapping.fCleanAddress (state_origin,state_desc,rastr,'',input.normRACity,input.normRAState,input.normRAZip5 + input.normRAZip4,input.normRACountry).AddressLine2;
				self.corp_ra_address_line3		  := Corp2_Mapping.fCleanAddress (state_origin,state_desc,rastr,'',input.normRACity,input.normRAState,input.normRAZip5 + input.normRAZip4,input.normRACountry).AddressLine3;			
				self.ra_prep_addr_line1					:= Corp2_Mapping.fCleanAddress (state_origin,state_desc,rastr,'',input.normRACity,input.normRAState,input.normRAZip5,input.normRACountry).PrepAddrLine1;			
				self.ra_prep_addr_last_line 		:= Corp2_Mapping.fCleanAddress (state_origin,state_desc,rastr,'',input.normRACity,input.normRAState,input.normRAZip5,input.normRACountry).PrepAddrLastLine;
				
				self.corp_entity_desc						:= case(corp2.t2u(input.cdOrigin),
																								'R' => 'REGULAR',	'S' => 'SPECIALTY CHARTER',	'');
				self.corp_orig_bus_type_cd			:= corp2.t2u(input.cdCategory);
				self.corp_orig_bus_type_desc		:= case(corp2.t2u(input.cdCategory),
				                                        'BK' => 'BANK',
																								'C'  => 'CEMETERY',
																								'CU' => 'CREDIT UNION',
																								'IN' => 'INSURANCE',
																								'R'  => 'RELIGIOUS',
																								'');																							
				self.corp_addl_info							:= case(corp2.t2u(input.cdBusType),
																								'B' => 'BUSINESS TYPE: BENEFIT CORPORATION',				
																								'S' => 'BUSINESS TYPE: STOCK',
																								'N' => 'BUSINESS TYPE: NON STOCK',
																								''); 													
				self 														:= [];
			end; 
		  
			mapOther	:= project(jTempLay_OtherWithMaster, corpOtherTrf(left));
				
			//-----------------------------------------		  
			// Map DLMTPART input file to MAIN
			//-----------------------------------------		
			jTempLay_DLMTPartWithMaster := join(	DlmtPart, NormBusMaster,
																			corp2.t2u(left.idBus) = corp2.t2u(right.idBus),
																			transform(Corp2_Raw_CT.Layouts.TempLay_DLMTPartWithMaster, self := left; self := right;),
																			left outer, local);
			
			Corp2_Mapping.LayoutsCommon.Main corpDLMTPartTrf(Corp2_Raw_CT.Layouts.TempLay_DLMTPartWithMaster input) := transform
										,skip(corp2.t2u(input.nmName) in ['','TEST TEST 123'] or input.idBus='0000000')
				self.corp_key										:= state_fips + '-' + corp2.t2u(input.idBus);
				self.corp_orig_sos_charter_nbr	:= corp2.t2u(input.idBus);
				self.corp_legal_name						:= Corp2_Mapping.fCleanBusinessName(state_origin,state_desc,input.nmName).BusinessName;
				self.corp_ln_name_type_cd				:= '01';
				self.corp_ln_name_type_desc			:= 'LEGAL';	
				self.corp_additional_principals := if (corp2.t2u(input.flAddlPrinc) in ['Y','N']
				                                      ,corp2.t2u(input.flAddlPrinc) ,'');
				self.corp_for_profit_ind        := if (corp2.t2u(input.cdSubType) = 'B', 'N', '');																			
				self.corp_foreign_domestic_ind  := map(corp2.t2u(input.cdSubType) = 'C' and corp2.t2u(input.cdPlOfForm) in [state_origin,''] => 'D',
				                                       corp2.t2u(input.cdSubType) = 'C' and corp2.t2u(input.cdPlOfForm) not in [state_origin,''] => 'F',
																							 corp2.t2u(input.cdSubType) in domestic => 'D',
				                                       corp2.t2u(input.cdSubType) in foreign  => 'F',
																							 '');
				self.corp_inc_date              := if (corp2.t2u(input.cdSubType) in domestic or 
																							 (corp2.t2u(input.cdSubType) = 'C' and corp2.t2u(input.cdPlOfForm) in [state_origin,'']) 
																							   ,Corp2_Mapping.fValidateDate(input.dtOrigin,'CCYYMMDD').PastDate ,'');																			 
				self.corp_forgn_date            := if (corp2.t2u(input.cdSubType) in foreign or 
																							 (corp2.t2u(input.cdSubType) = 'C' and corp2.t2u(input.cdPlOfForm) not in [state_origin,''])
				                                       ,Corp2_Mapping.fValidateDate(input.dtOrigin,'CCYYMMDD').PastDate ,'');				self.corp_ra_full_name					:= Corp2_Mapping.fCleanBusinessName(state_origin,state_desc,input.nmAgt).BusinessName;
				self.corp_ra_addl_info          := case(corp2.t2u(input.cdAgtType),
																								'B' => 'BUSINESS',
				                                        'I' => 'INDIVIDUAL',
																								'S' => 'SECRETARY OF STATE', '');
        self.corp_ra_resign_date        := Corp2_Mapping.fValidateDate(input.dtAgtResign,'CCYYMMDD').PastDate;
				self.corp_orig_org_structure_cd	:= corp2.t2u(input.cdSubType);
				self.corp_orig_org_structure_desc	:= Corp2_Raw_CT.Functions.GetOrgStrucDesc(input.cdSubType);
				self.corp_status_cd							:= corp2.t2u(input.cdStatus);
				self.corp_status_desc						:= Corp2_Raw_CT.Functions.GetStatusDesc(input.cdStatus);
				
				corp1str := Corp2_Raw_CT.Functions.FixStreet(input.adStr1,input.adStr2,input.adstr3);
				corp2str := Corp2_Raw_CT.Functions.FixStreet(input.adMailStr1,input.adMailStr2,input.adMailStr3);
				MailingOnly := if(Corp2_Mapping.fAddressExists(state_origin,state_desc,corp1str,'',input.adCity,input.adState,input.adZip5 + input.adZip4,input.adCntry).ifAddressExists,'N','Y'); 

				self.corp_address1_type_cd      := if(MailingOnly = 'N'
																							,if (Corp2_Mapping.fAddressExists(state_origin,state_desc,corp1str,'',input.adCity,input.adState,input.adZip5 + input.adZip4,input.adCntry).ifAddressExists,'B','')
																							,if (Corp2_Mapping.fAddressExists(state_origin,state_desc,input.adMailStr1,input.adMailStr2 + input.adMailStr3,input.adMailCity,input.adMailState,input.adMailZip5 + input.adMailZip4,input.adMailCntry).ifAddressExists,'M','')
																							);
				self.corp_address1_type_desc    := if(MailingOnly = 'N'
																							,if (Corp2_Mapping.fAddressExists(state_origin,state_desc,corp1str,'',input.adCity,input.adState,input.adZip5 + input.adZip4,input.adCntry).ifAddressExists,'BUSINESS','')
																							,if (Corp2_Mapping.fAddressExists(state_origin,state_desc,input.adMailStr1,input.adMailStr2 + input.adMailStr3,input.adMailCity,input.adMailState,input.adMailZip5 + input.adMailZip4,input.adMailCntry).ifAddressExists,'MAILING','')
																							);
				self.corp_address1_line1        := if(MailingOnly = 'N'
																							,Corp2_Mapping.fCleanAddress (state_origin,state_desc,corp1str,'',input.adCity,input.adState,input.adZip5 + input.adZip4,input.adCntry).AddressLine1
																							,Corp2_Mapping.fCleanAddress (state_origin,state_desc,corp2str,'',input.adMailCity,input.adMailState,input.adMailZip5 + input.adMailZip4,input.adMailCntry).AddressLine1
																							);
				self.corp_address1_line2        := if(MailingOnly = 'N'
																							,Corp2_Mapping.fCleanAddress (state_origin,state_desc,corp1str,'',input.adCity,input.adState,input.adZip5 + input.adZip4,input.adCntry).AddressLine2
																							,Corp2_Mapping.fCleanAddress (state_origin,state_desc,corp2str,'',input.adMailCity,input.adMailState,input.adMailZip5 + input.adMailZip4,input.adMailCntry).AddressLine2
																							);				
				self.corp_address1_line3        := if(MailingOnly = 'N'
																							,Corp2_Mapping.fCleanAddress (state_origin,state_desc,corp1str,'',input.adCity,input.adState,input.adZip5 + input.adZip4,input.adCntry).AddressLine3
																							,Corp2_Mapping.fCleanAddress (state_origin,state_desc,corp2str,'',input.adMailCity,input.adMailState,input.adMailZip5 + input.adMailZip4,input.adMailCntry).AddressLine3
																							);	
				self.corp_prep_addr1_line1        := if(MailingOnly = 'N'
																							,Corp2_Mapping.fCleanAddress (state_origin,state_desc,corp1str,'',input.adCity,input.adState,input.adZip5,input.adCntry).PrepAddrLine1
																							,Corp2_Mapping.fCleanAddress (state_origin,state_desc,corp2str,'',input.adMailCity,input.adMailState,input.adMailZip5,input.adMailCntry).PrepAddrLine1
																							);	
				self.corp_prep_addr1_last_line        := if(MailingOnly = 'N'
																							,Corp2_Mapping.fCleanAddress (state_origin,state_desc,corp1str,'',input.adCity,input.adState,input.adZip5,input.adCntry).PrepAddrLastLine
																							,Corp2_Mapping.fCleanAddress (state_origin,state_desc,corp2str,'',input.adMailCity,input.adMailState,input.adMailZip5,input.adMailCntry).PrepAddrLastLine
																							);																							
				
				self.corp_address2_type_cd      := if(MailingOnly = 'N' ,if (Corp2_Mapping.fAddressExists(state_origin,state_desc,input.adMailStr1,input.adMailStr2 + input.adMailStr3,input.adMailCity,input.adMailState,input.adMailZip5 + input.adMailZip4,input.adMailCntry).ifAddressExists,'M','') ,'');	
				self.corp_address2_type_desc    := if(MailingOnly = 'N' ,if (Corp2_Mapping.fAddressExists(state_origin,state_desc,input.adMailStr1,input.adMailStr2 + input.adMailStr3,input.adMailCity,input.adMailState,input.adMailZip5 + input.adMailZip4,input.adMailCntry).ifAddressExists,'MAILING','') ,'');
				self.corp_address2_line1			  := if(MailingOnly = 'N' ,Corp2_Mapping.fCleanAddress (state_origin,state_desc,corp2str,'',input.adMailCity,input.adMailState,input.adMailZip5 + input.adMailZip4,input.adMailCntry).AddressLine1 ,'');
				self.corp_address2_line2				:= if(MailingOnly = 'N' ,Corp2_Mapping.fCleanAddress (state_origin,state_desc,corp2str,'',input.adMailCity,input.adMailState,input.adMailZip5 + input.adMailZip4,input.adMailCntry).AddressLine2 ,'');
				self.corp_address2_line3				:= if(MailingOnly = 'N' ,Corp2_Mapping.fCleanAddress (state_origin,state_desc,corp2str,'',input.adMailCity,input.adMailState,input.adMailZip5 + input.adMailZip4,input.adMailCntry).AddressLine3 ,'');			
				self.corp_prep_addr2_line1			:= if(MailingOnly = 'N' ,Corp2_Mapping.fCleanAddress (state_origin,state_desc,corp2str,'',input.adMailCity,input.adMailState,input.adMailZip5,input.adMailCntry).PrepAddrLine1 ,'');			
				self.corp_prep_addr2_last_line	:= if(MailingOnly = 'N' ,Corp2_Mapping.fCleanAddress (state_origin,state_desc,corp2str,'',input.adMailCity,input.adMailState,input.adMailZip5,input.adMailCntry).PrepAddrLastLine ,'');
								
        rastr := Corp2_Raw_CT.Functions.FixStreet(input.normRAAddr1,input.normRAAddr2,input.normRAAddr3);				
				self.corp_ra_address_type_cd    := if (Corp2_Mapping.fAddressExists(state_origin,state_desc,rastr,'',input.normRACity,input.normRAState,input.normRAZip5 + input.normRAZip4,input.normRACountry).ifAddressExists,input.normRAAddrType,'');
				self.corp_ra_address_type_desc  := if (Corp2_Mapping.fAddressExists(state_origin,state_desc,rastr,'',input.normRACity,input.normRAState,input.normRAZip5 + input.normRAZip4,input.normRACountry).ifAddressExists,input.normRAAddrDesc,'');
				self.corp_ra_address_line1		  := Corp2_Mapping.fCleanAddress (state_origin,state_desc,rastr,'',input.normRACity,input.normRAState,input.normRAZip5 + input.normRAZip4,input.normRACountry).AddressLine1;
				self.corp_ra_address_line2		  := Corp2_Mapping.fCleanAddress (state_origin,state_desc,rastr,'',input.normRACity,input.normRAState,input.normRAZip5 + input.normRAZip4,input.normRACountry).AddressLine2;
				self.corp_ra_address_line3		  := Corp2_Mapping.fCleanAddress (state_origin,state_desc,rastr,'',input.normRACity,input.normRAState,input.normRAZip5 + input.normRAZip4,input.normRACountry).AddressLine3;			
				self.ra_prep_addr_line1					:= Corp2_Mapping.fCleanAddress (state_origin,state_desc,rastr,'',input.normRACity,input.normRAState,input.normRAZip5,input.normRACountry).PrepAddrLine1;			
				self.ra_prep_addr_last_line 		:= Corp2_Mapping.fCleanAddress (state_origin,state_desc,rastr,'',input.normRACity,input.normRAState,input.normRAZip5,input.normRACountry).PrepAddrLastLine;
				
				self.corp_term_exist_exp				:= Corp2_Mapping.fValidateDate(input.dtTerm,'CCYYMMDD').GeneralDate;
				self.corp_term_exist_cd					:= if(self.corp_term_exist_exp <> '', 'D', '');
				self.corp_term_exist_desc				:= if(self.corp_term_exist_cd = 'D', 'EXPIRATION DATE', '');
 				self 														:= [];
			end; 	
	
		  mapDLMTPart				:= project(jTempLay_DLMTPartWithMaster, corpDLMTPartTrf(left));


			//-----------------------------------------		  
			// Map FLMTPART input file to MAIN
			//-----------------------------------------	
			jTempLay_FLMTPartWithMaster := join(	FLMTPart, NormBusMaster,
																			corp2.t2u(left.idBus) = corp2.t2u(right.idBus),
																			transform(Corp2_Raw_CT.Layouts.TempLay_FLMTPartWithMaster, self := left; self := right;),
																			left outer, local);
											
			Corp2_Mapping.LayoutsCommon.Main corpFLMTPartTrf(Corp2_Raw_CT.Layouts.TempLay_FLMTPartWithMaster input) := transform
									,skip(corp2.t2u(input.nmName) in ['','TEST TEST 123'] or input.idBus='0000000')
				self.corp_key										:= state_fips + '-' + corp2.t2u(input.idBus);
				self.corp_orig_sos_charter_nbr	:= corp2.t2u(input.idBus);
				self.corp_legal_name						:= Corp2_Mapping.fCleanBusinessName(state_origin,state_desc,input.nmName).BusinessName;
				self.corp_ln_name_type_cd				:= '01';
				self.corp_ln_name_type_desc			:= 'LEGAL'; 	
				self.corp_additional_principals := if (corp2.t2u(input.flAddlPrinc) in ['Y','N']
				                                      ,corp2.t2u(input.flAddlPrinc) ,'');
				self.corp_for_profit_ind        := if (corp2.t2u(input.cdSubType) = 'B', 'N', '');																			
				self.corp_foreign_domestic_ind  := map(corp2.t2u(input.cdSubType) = 'C' and corp2.t2u(input.cdPlOfForm) in [state_origin,''] => 'D',
				                                       corp2.t2u(input.cdSubType) = 'C' and corp2.t2u(input.cdPlOfForm) not in [state_origin,''] => 'F',
																							 corp2.t2u(input.cdSubType) in domestic => 'D',
				                                       corp2.t2u(input.cdSubType) in foreign  => 'F',
																							 '');
				self.corp_inc_date              := if (corp2.t2u(input.cdSubType) in domestic or 
																							 (corp2.t2u(input.cdSubType) = 'C' and corp2.t2u(input.cdPlOfForm) in [state_origin,'']) 
																							   ,Corp2_Mapping.fValidateDate(input.dtOrigin,'CCYYMMDD').PastDate ,'');																			 
				self.corp_forgn_date            := if (corp2.t2u(input.cdSubType) in foreign or 
																							 (corp2.t2u(input.cdSubType) = 'C' and corp2.t2u(input.cdPlOfForm) not in [state_origin,''])
				                                       ,Corp2_Mapping.fValidateDate(input.dtOrigin,'CCYYMMDD').PastDate ,'');				self.corp_ra_full_name					:= Corp2_Mapping.fCleanBusinessName(state_origin,state_desc,input.nmAgt).BusinessName;
				self.corp_ra_addl_info          := case(corp2.t2u(input.cdAgtType),
																								'B' => 'BUSINESS',
				                                        'I' => 'INDIVIDUAL',
																								'S' => 'SECRETARY OF STATE', '');
        self.corp_ra_resign_date        := Corp2_Mapping.fValidateDate(input.dtAgtResign,'CCYYMMDD').PastDate;
				self.corp_filing_date				    := Corp2_Mapping.fValidateDate(input.dtComncBus,'CCYYMMDD').GeneralDate;
				self.corp_filing_cd             := if (self.corp_filing_date <> '' ,'X' ,'');
				self.corp_filing_desc           := if (self.corp_filing_date <> '' ,'COMMENCE BUSINESS DATE' ,'');				
				self.corp_orig_org_structure_cd	:= corp2.t2u(input.cdSubType);
				self.corp_orig_org_structure_desc	:= Corp2_Raw_CT.Functions.GetOrgStrucDesc(input.cdSubType);
				self.corp_status_cd							:= corp2.t2u(input.cdStatus);
				self.corp_status_desc						:= Corp2_Raw_CT.Functions.GetStatusDesc(input.cdStatus);
				
				corp1str := Corp2_Raw_CT.Functions.FixStreet(input.adStr1,input.adStr2,input.adstr3);
				corp2str := Corp2_Raw_CT.Functions.FixStreet(input.adMailStr1,input.adMailStr2,input.adMailStr3);
				MailingOnly := if(Corp2_Mapping.fAddressExists(state_origin,state_desc,corp1str,'',input.adCity,input.adState,input.adZip5 + input.adZip4,input.adCntry).ifAddressExists,'N','Y'); 

				self.corp_address1_type_cd      := if(MailingOnly = 'N'
																							,if (Corp2_Mapping.fAddressExists(state_origin,state_desc,corp1str,'',input.adCity,input.adState,input.adZip5 + input.adZip4,input.adCntry).ifAddressExists,'B','')
																							,if (Corp2_Mapping.fAddressExists(state_origin,state_desc,input.adMailStr1,input.adMailStr2 + input.adMailStr3,input.adMailCity,input.adMailState,input.adMailZip5 + input.adMailZip4,input.adMailCntry).ifAddressExists,'M','')
																							);
				self.corp_address1_type_desc    := if(MailingOnly = 'N'
																							,if (Corp2_Mapping.fAddressExists(state_origin,state_desc,corp1str,'',input.adCity,input.adState,input.adZip5 + input.adZip4,input.adCntry).ifAddressExists,'BUSINESS','')
																							,if (Corp2_Mapping.fAddressExists(state_origin,state_desc,input.adMailStr1,input.adMailStr2 + input.adMailStr3,input.adMailCity,input.adMailState,input.adMailZip5 + input.adMailZip4,input.adMailCntry).ifAddressExists,'MAILING','')
																							);
				self.corp_address1_line1        := if(MailingOnly = 'N'
																							,Corp2_Mapping.fCleanAddress (state_origin,state_desc,corp1str,'',input.adCity,input.adState,input.adZip5 + input.adZip4,input.adCntry).AddressLine1
																							,Corp2_Mapping.fCleanAddress (state_origin,state_desc,corp2str,'',input.adMailCity,input.adMailState,input.adMailZip5 + input.adMailZip4,input.adMailCntry).AddressLine1
																							);
				self.corp_address1_line2        := if(MailingOnly = 'N'
																							,Corp2_Mapping.fCleanAddress (state_origin,state_desc,corp1str,'',input.adCity,input.adState,input.adZip5 + input.adZip4,input.adCntry).AddressLine2
																							,Corp2_Mapping.fCleanAddress (state_origin,state_desc,corp2str,'',input.adMailCity,input.adMailState,input.adMailZip5 + input.adMailZip4,input.adMailCntry).AddressLine2
																							);				
				self.corp_address1_line3        := if(MailingOnly = 'N'
																							,Corp2_Mapping.fCleanAddress (state_origin,state_desc,corp1str,'',input.adCity,input.adState,input.adZip5 + input.adZip4,input.adCntry).AddressLine3
																							,Corp2_Mapping.fCleanAddress (state_origin,state_desc,corp2str,'',input.adMailCity,input.adMailState,input.adMailZip5 + input.adMailZip4,input.adMailCntry).AddressLine3
																							);	
				self.corp_prep_addr1_line1        := if(MailingOnly = 'N'
																							,Corp2_Mapping.fCleanAddress (state_origin,state_desc,corp1str,'',input.adCity,input.adState,input.adZip5,input.adCntry).PrepAddrLine1
																							,Corp2_Mapping.fCleanAddress (state_origin,state_desc,corp2str,'',input.adMailCity,input.adMailState,input.adMailZip5,input.adMailCntry).PrepAddrLine1
																							);	
				self.corp_prep_addr1_last_line        := if(MailingOnly = 'N'
																							,Corp2_Mapping.fCleanAddress (state_origin,state_desc,corp1str,'',input.adCity,input.adState,input.adZip5,input.adCntry).PrepAddrLastLine
																							,Corp2_Mapping.fCleanAddress (state_origin,state_desc,corp2str,'',input.adMailCity,input.adMailState,input.adMailZip5,input.adMailCntry).PrepAddrLastLine
																							);																							
				
				self.corp_address2_type_cd      := if(MailingOnly = 'N' ,if (Corp2_Mapping.fAddressExists(state_origin,state_desc,input.adMailStr1,input.adMailStr2 + input.adMailStr3,input.adMailCity,input.adMailState,input.adMailZip5 + input.adMailZip4,input.adMailCntry).ifAddressExists,'M','') ,'');	
				self.corp_address2_type_desc    := if(MailingOnly = 'N' ,if (Corp2_Mapping.fAddressExists(state_origin,state_desc,input.adMailStr1,input.adMailStr2 + input.adMailStr3,input.adMailCity,input.adMailState,input.adMailZip5 + input.adMailZip4,input.adMailCntry).ifAddressExists,'MAILING','') ,'');
				self.corp_address2_line1			  := if(MailingOnly = 'N' ,Corp2_Mapping.fCleanAddress (state_origin,state_desc,corp2str,'',input.adMailCity,input.adMailState,input.adMailZip5 + input.adMailZip4,input.adMailCntry).AddressLine1 ,'');
				self.corp_address2_line2				:= if(MailingOnly = 'N' ,Corp2_Mapping.fCleanAddress (state_origin,state_desc,corp2str,'',input.adMailCity,input.adMailState,input.adMailZip5 + input.adMailZip4,input.adMailCntry).AddressLine2 ,'');
				self.corp_address2_line3				:= if(MailingOnly = 'N' ,Corp2_Mapping.fCleanAddress (state_origin,state_desc,corp2str,'',input.adMailCity,input.adMailState,input.adMailZip5 + input.adMailZip4,input.adMailCntry).AddressLine3 ,'');			
				self.corp_prep_addr2_line1			:= if(MailingOnly = 'N' ,Corp2_Mapping.fCleanAddress (state_origin,state_desc,corp2str,'',input.adMailCity,input.adMailState,input.adMailZip5,input.adMailCntry).PrepAddrLine1 ,'');			
				self.corp_prep_addr2_last_line	:= if(MailingOnly = 'N' ,Corp2_Mapping.fCleanAddress (state_origin,state_desc,corp2str,'',input.adMailCity,input.adMailState,input.adMailZip5,input.adMailCntry).PrepAddrLastLine ,'');
								
        rastr := Corp2_Raw_CT.Functions.FixStreet(input.normRAAddr1,input.normRAAddr2,input.normRAAddr3);				
				self.corp_ra_address_type_cd    := if (Corp2_Mapping.fAddressExists(state_origin,state_desc,rastr,'',input.normRACity,input.normRAState,input.normRAZip5 + input.normRAZip4,input.normRACountry).ifAddressExists,input.normRAAddrType,'');
				self.corp_ra_address_type_desc  := if (Corp2_Mapping.fAddressExists(state_origin,state_desc,rastr,'',input.normRACity,input.normRAState,input.normRAZip5 + input.normRAZip4,input.normRACountry).ifAddressExists,input.normRAAddrDesc,'');
				self.corp_ra_address_line1		  := Corp2_Mapping.fCleanAddress (state_origin,state_desc,rastr,'',input.normRACity,input.normRAState,input.normRAZip5 + input.normRAZip4,input.normRACountry).AddressLine1;
				self.corp_ra_address_line2		  := Corp2_Mapping.fCleanAddress (state_origin,state_desc,rastr,'',input.normRACity,input.normRAState,input.normRAZip5 + input.normRAZip4,input.normRACountry).AddressLine2;
				self.corp_ra_address_line3		  := Corp2_Mapping.fCleanAddress (state_origin,state_desc,rastr,'',input.normRACity,input.normRAState,input.normRAZip5 + input.normRAZip4,input.normRACountry).AddressLine3;			
				self.ra_prep_addr_line1					:= Corp2_Mapping.fCleanAddress (state_origin,state_desc,rastr,'',input.normRACity,input.normRAState,input.normRAZip5,input.normRACountry).PrepAddrLine1;			
				self.ra_prep_addr_last_line 		:= Corp2_Mapping.fCleanAddress (state_origin,state_desc,rastr,'',input.normRACity,input.normRAState,input.normRAZip5,input.normRACountry).PrepAddrLastLine;
				
				self.corp_country_of_formation  := Corp2_Raw_CT.Functions.Decode_Country(input.cdPlOfForm);
				self.corp_forgn_state_cd				:= if (corp2.t2u(input.cdPlOfForm) not in [state_origin,'']	,corp2.t2u(input.cdPlOfForm) ,'');
				self.corp_forgn_state_desc			:= if(self.corp_forgn_state_cd <> ''
																							,Corp2_Raw_CT.Functions.GetStateDesc(self.corp_forgn_state_cd) ,'');	
				self.corp_home_state_name       := corp2.t2u(input.nmForeign);																			
				self 														:= [];
  		end; 	
			
			mapFLMTPart				:= project(jTempLay_FLMTPartWithMaster, corpFLMTPartTrf(left));
			
			//-----------------------------------------		  
			// Map DLMTCORP input file to MAIN
			//-----------------------------------------
			jTempLay_DLMTCorpWithMaster := join(	DLMTCorp, NormBusMaster,
																			corp2.t2u(left.idBus) = corp2.t2u(right.idBus),
																			transform(Corp2_Raw_CT.Layouts.TempLay_DLMTCorpWithMaster, self := left; self := right;),
																			left outer, local	);	
																			
			Corp2_Mapping.LayoutsCommon.Main corpDLMTCorpTrf(Corp2_Raw_CT.Layouts.TempLay_DLMTCorpWithMaster input) := transform
									,skip(corp2.t2u(input.nmName) in ['','TEST TEST 123'] or input.idBus='0000000')
				self.corp_key										:= state_fips + '-' + corp2.t2u(input.idBus);
				self.corp_orig_sos_charter_nbr	:= corp2.t2u(input.idBus);
				self.corp_legal_name						:= Corp2_Mapping.fCleanBusinessName(state_origin,state_desc,input.nmName).BusinessName; 
				self.corp_ln_name_type_cd				:= '01';
				self.corp_ln_name_type_desc			:= 'LEGAL';	
				self.corp_status_date						:= Corp2_Mapping.fValidateDate(input.dtDissolve,'CCYYMMDD').GeneralDate;
				self.corp_additional_principals := if (corp2.t2u(input.flAddlPrinc) in ['Y','N']
				                                      ,corp2.t2u(input.flAddlPrinc) ,'');
				self.corp_for_profit_ind        := if (corp2.t2u(input.cdSubType) = 'B', 'N', '');																			
				self.corp_foreign_domestic_ind  := map(corp2.t2u(input.cdSubType) = 'C' and corp2.t2u(input.cdPlOfForm) in [state_origin,''] => 'D',
				                                       corp2.t2u(input.cdSubType) = 'C' and corp2.t2u(input.cdPlOfForm) not in [state_origin,''] => 'F',
																							 corp2.t2u(input.cdSubType) in domestic => 'D',
				                                       corp2.t2u(input.cdSubType) in foreign  => 'F',
																							 '');
				self.corp_inc_date              := if (corp2.t2u(input.cdSubType) in domestic or 
																							 (corp2.t2u(input.cdSubType) = 'C' and corp2.t2u(input.cdPlOfForm) in [state_origin,'']) 
																							   ,Corp2_Mapping.fValidateDate(input.dtOrigin,'CCYYMMDD').PastDate ,'');																			 
				self.corp_forgn_date            := if (corp2.t2u(input.cdSubType) in foreign or 
																							 (corp2.t2u(input.cdSubType) = 'C' and corp2.t2u(input.cdPlOfForm) not in [state_origin,''])
				                                       ,Corp2_Mapping.fValidateDate(input.dtOrigin,'CCYYMMDD').PastDate ,'');				self.corp_ra_full_name					:= Corp2_Mapping.fCleanBusinessName(state_origin,state_desc,input.nmAgt).BusinessName;
				self.corp_ra_addl_info          := case(corp2.t2u(input.cdAgtType),
																								'B' => 'BUSINESS',
				                                        'I' => 'INDIVIDUAL',
																								'S' => 'SECRETARY OF STATE', '');
        self.corp_ra_resign_date        := Corp2_Mapping.fValidateDate(input.dtAgtResign,'CCYYMMDD').PastDate;
				self.corp_orig_org_structure_cd	:= corp2.t2u(input.cdSubType);
				self.corp_orig_org_structure_desc	:= Corp2_Raw_CT.Functions.GetOrgStrucDesc(input.cdSubType);
				self.corp_status_cd							:= corp2.t2u(input.cdStatus);
				self.corp_status_desc						:= Corp2_Raw_CT.Functions.GetStatusDesc(input.cdStatus);
				
				corp1str := Corp2_Raw_CT.Functions.FixStreet(input.adStr1,input.adStr2,input.adstr3);
				corp2str := Corp2_Raw_CT.Functions.FixStreet(input.adMailStr1,input.adMailStr2,input.adMailStr3);
				MailingOnly := if(Corp2_Mapping.fAddressExists(state_origin,state_desc,corp1str,'',input.adCity,input.adState,input.adZip5 + input.adZip4,input.adCntry).ifAddressExists,'N','Y'); 

				self.corp_address1_type_cd      := if(MailingOnly = 'N'
																							,if (Corp2_Mapping.fAddressExists(state_origin,state_desc,corp1str,'',input.adCity,input.adState,input.adZip5 + input.adZip4,input.adCntry).ifAddressExists,'B','')
																							,if (Corp2_Mapping.fAddressExists(state_origin,state_desc,input.adMailStr1,input.adMailStr2 + input.adMailStr3,input.adMailCity,input.adMailState,input.adMailZip5 + input.adMailZip4,input.adMailCntry).ifAddressExists,'M','')
																							);
				self.corp_address1_type_desc    := if(MailingOnly = 'N'
																							,if (Corp2_Mapping.fAddressExists(state_origin,state_desc,corp1str,'',input.adCity,input.adState,input.adZip5 + input.adZip4,input.adCntry).ifAddressExists,'BUSINESS','')
																							,if (Corp2_Mapping.fAddressExists(state_origin,state_desc,input.adMailStr1,input.adMailStr2 + input.adMailStr3,input.adMailCity,input.adMailState,input.adMailZip5 + input.adMailZip4,input.adMailCntry).ifAddressExists,'MAILING','')
																							);
				self.corp_address1_line1        := if(MailingOnly = 'N'
																							,Corp2_Mapping.fCleanAddress (state_origin,state_desc,corp1str,'',input.adCity,input.adState,input.adZip5 + input.adZip4,input.adCntry).AddressLine1
																							,Corp2_Mapping.fCleanAddress (state_origin,state_desc,corp2str,'',input.adMailCity,input.adMailState,input.adMailZip5 + input.adMailZip4,input.adMailCntry).AddressLine1
																							);
				self.corp_address1_line2        := if(MailingOnly = 'N'
																							,Corp2_Mapping.fCleanAddress (state_origin,state_desc,corp1str,'',input.adCity,input.adState,input.adZip5 + input.adZip4,input.adCntry).AddressLine2
																							,Corp2_Mapping.fCleanAddress (state_origin,state_desc,corp2str,'',input.adMailCity,input.adMailState,input.adMailZip5 + input.adMailZip4,input.adMailCntry).AddressLine2
																							);				
				self.corp_address1_line3        := if(MailingOnly = 'N'
																							,Corp2_Mapping.fCleanAddress (state_origin,state_desc,corp1str,'',input.adCity,input.adState,input.adZip5 + input.adZip4,input.adCntry).AddressLine3
																							,Corp2_Mapping.fCleanAddress (state_origin,state_desc,corp2str,'',input.adMailCity,input.adMailState,input.adMailZip5 + input.adMailZip4,input.adMailCntry).AddressLine3
																							);	
				self.corp_prep_addr1_line1        := if(MailingOnly = 'N'
																							,Corp2_Mapping.fCleanAddress (state_origin,state_desc,corp1str,'',input.adCity,input.adState,input.adZip5,input.adCntry).PrepAddrLine1
																							,Corp2_Mapping.fCleanAddress (state_origin,state_desc,corp2str,'',input.adMailCity,input.adMailState,input.adMailZip5,input.adMailCntry).PrepAddrLine1
																							);	
				self.corp_prep_addr1_last_line        := if(MailingOnly = 'N'
																							,Corp2_Mapping.fCleanAddress (state_origin,state_desc,corp1str,'',input.adCity,input.adState,input.adZip5,input.adCntry).PrepAddrLastLine
																							,Corp2_Mapping.fCleanAddress (state_origin,state_desc,corp2str,'',input.adMailCity,input.adMailState,input.adMailZip5,input.adMailCntry).PrepAddrLastLine
																							);																							
				
				self.corp_address2_type_cd      := if(MailingOnly = 'N' ,if (Corp2_Mapping.fAddressExists(state_origin,state_desc,input.adMailStr1,input.adMailStr2 + input.adMailStr3,input.adMailCity,input.adMailState,input.adMailZip5 + input.adMailZip4,input.adMailCntry).ifAddressExists,'M','') ,'');	
				self.corp_address2_type_desc    := if(MailingOnly = 'N' ,if (Corp2_Mapping.fAddressExists(state_origin,state_desc,input.adMailStr1,input.adMailStr2 + input.adMailStr3,input.adMailCity,input.adMailState,input.adMailZip5 + input.adMailZip4,input.adMailCntry).ifAddressExists,'MAILING','') ,'');
				self.corp_address2_line1			  := if(MailingOnly = 'N' ,Corp2_Mapping.fCleanAddress (state_origin,state_desc,corp2str,'',input.adMailCity,input.adMailState,input.adMailZip5 + input.adMailZip4,input.adMailCntry).AddressLine1 ,'');
				self.corp_address2_line2				:= if(MailingOnly = 'N' ,Corp2_Mapping.fCleanAddress (state_origin,state_desc,corp2str,'',input.adMailCity,input.adMailState,input.adMailZip5 + input.adMailZip4,input.adMailCntry).AddressLine2 ,'');
				self.corp_address2_line3				:= if(MailingOnly = 'N' ,Corp2_Mapping.fCleanAddress (state_origin,state_desc,corp2str,'',input.adMailCity,input.adMailState,input.adMailZip5 + input.adMailZip4,input.adMailCntry).AddressLine3 ,'');			
				self.corp_prep_addr2_line1			:= if(MailingOnly = 'N' ,Corp2_Mapping.fCleanAddress (state_origin,state_desc,corp2str,'',input.adMailCity,input.adMailState,input.adMailZip5,input.adMailCntry).PrepAddrLine1 ,'');			
				self.corp_prep_addr2_last_line	:= if(MailingOnly = 'N' ,Corp2_Mapping.fCleanAddress (state_origin,state_desc,corp2str,'',input.adMailCity,input.adMailState,input.adMailZip5,input.adMailCntry).PrepAddrLastLine ,'');
								
        rastr := Corp2_Raw_CT.Functions.FixStreet(input.normRAAddr1,input.normRAAddr2,input.normRAAddr3);				
				self.corp_ra_address_type_cd    := if (Corp2_Mapping.fAddressExists(state_origin,state_desc,rastr,'',input.normRACity,input.normRAState,input.normRAZip5 + input.normRAZip4,input.normRACountry).ifAddressExists,input.normRAAddrType,'');
				self.corp_ra_address_type_desc  := if (Corp2_Mapping.fAddressExists(state_origin,state_desc,rastr,'',input.normRACity,input.normRAState,input.normRAZip5 + input.normRAZip4,input.normRACountry).ifAddressExists,input.normRAAddrDesc,'');
				self.corp_ra_address_line1		  := Corp2_Mapping.fCleanAddress (state_origin,state_desc,rastr,'',input.normRACity,input.normRAState,input.normRAZip5 + input.normRAZip4,input.normRACountry).AddressLine1;
				self.corp_ra_address_line2		  := Corp2_Mapping.fCleanAddress (state_origin,state_desc,rastr,'',input.normRACity,input.normRAState,input.normRAZip5 + input.normRAZip4,input.normRACountry).AddressLine2;
				self.corp_ra_address_line3		  := Corp2_Mapping.fCleanAddress (state_origin,state_desc,rastr,'',input.normRACity,input.normRAState,input.normRAZip5 + input.normRAZip4,input.normRACountry).AddressLine3;			
				self.ra_prep_addr_line1					:= Corp2_Mapping.fCleanAddress (state_origin,state_desc,rastr,'',input.normRACity,input.normRAState,input.normRAZip5,input.normRACountry).PrepAddrLine1;			
				self.ra_prep_addr_last_line 		:= Corp2_Mapping.fCleanAddress (state_origin,state_desc,rastr,'',input.normRACity,input.normRAState,input.normRAZip5,input.normRACountry).PrepAddrLastLine;

				self.corp_term_exist_exp				:= Corp2_Mapping.fValidateDate(input.dtTerm,'CCYYMMDD').GeneralDate;
				self.corp_term_exist_cd					:= if(self.corp_term_exist_exp <> '', 'D', '');
				self.corp_term_exist_desc				:= if(self.corp_term_exist_cd = 'D', 'EXPIRATION DATE', '');
				self 														:= [];
			end; 
			
			mapDLMTCorp				:= project(jTempLay_DLMTCorpWithMaster, corpDLMTCorpTrf(left));
			
			//-----------------------------------------		  
			// Map FLMTCORP input file to MAIN
			//-----------------------------------------	
			jTempLay_FLMTCorpWithMaster := join(	FLMTCorp, NormBusMaster,
																			corp2.t2u(left.idBus) = corp2.t2u(right.idBus),
																			transform(Corp2_Raw_CT.Layouts.TempLay_FLMTCorpWithMaster, self := left; self := right;),
																			left outer, local	);
																			
			Corp2_Mapping.LayoutsCommon.Main corpFLMTCorpTrf(Corp2_Raw_CT.Layouts.TempLay_FLMTCorpWithMaster input) := transform
									,skip(corp2.t2u(input.nmName) in ['','TEST TEST 123'] or input.idBus='0000000')
				self.corp_key										:= state_fips + '-' + corp2.t2u(input.idBus);
				self.corp_orig_sos_charter_nbr	:= corp2.t2u(input.idBus);
				self.corp_legal_name						:= Corp2_Mapping.fCleanBusinessName(state_origin,state_desc,input.nmName).BusinessName;
				self.corp_ln_name_type_cd				:= '01';
				self.corp_ln_name_type_desc			:= 'LEGAL';
				self.corp_status_date						:= Corp2_Mapping.fValidateDate(input.dtDissolve,'CCYYMMDD').GeneralDate;	
        self.corp_filing_date				    := Corp2_Mapping.fValidateDate(input.dtComncBus,'CCYYMMDD').GeneralDate;
				self.corp_filing_cd             := if (self.corp_filing_date <> '' ,'X' ,'');
				self.corp_filing_desc           := if (self.corp_filing_date <> '' ,'COMMENCE BUSINESS DATE' ,'');				
				self.corp_additional_principals := if (corp2.t2u(input.flAddlPrinc) in ['Y','N']
				                                      ,corp2.t2u(input.flAddlPrinc) ,'');
				self.corp_for_profit_ind        := if (corp2.t2u(input.cdSubType) = 'B', 'N', '');																			
				self.corp_foreign_domestic_ind  := map(corp2.t2u(input.cdSubType) = 'C' and corp2.t2u(input.cdPlOfForm) in [state_origin,''] => 'D',
				                                       corp2.t2u(input.cdSubType) = 'C' and corp2.t2u(input.cdPlOfForm) not in [state_origin,''] => 'F',
																							 corp2.t2u(input.cdSubType) in domestic => 'D',
				                                       corp2.t2u(input.cdSubType) in foreign  => 'F',
																							 '');
				self.corp_inc_date              := if (corp2.t2u(input.cdSubType) in domestic or 
																							 (corp2.t2u(input.cdSubType) = 'C' and corp2.t2u(input.cdPlOfForm) in [state_origin,'']) 
																							   ,Corp2_Mapping.fValidateDate(input.dtOrigin,'CCYYMMDD').PastDate ,'');																			 
				self.corp_forgn_date            := if (corp2.t2u(input.cdSubType) in foreign or 
																							 (corp2.t2u(input.cdSubType) = 'C' and corp2.t2u(input.cdPlOfForm) not in [state_origin,''])
				                                       ,Corp2_Mapping.fValidateDate(input.dtOrigin,'CCYYMMDD').PastDate ,'');				self.corp_ra_full_name					:= Corp2_Mapping.fCleanBusinessName(state_origin,state_desc,input.nmAgt).BusinessName;
				self.corp_ra_addl_info          := case(corp2.t2u(input.cdAgtType),
																								'B' => 'BUSINESS',
				                                        'I' => 'INDIVIDUAL',
																								'S' => 'SECRETARY OF STATE', '');
        self.corp_ra_resign_date        := Corp2_Mapping.fValidateDate(input.dtAgtResign,'CCYYMMDD').PastDate;
				self.corp_orig_org_structure_cd	:= corp2.t2u(input.cdSubType);
				self.corp_orig_org_structure_desc	:= Corp2_Raw_CT.Functions.GetOrgStrucDesc(input.cdSubType);
				self.corp_status_cd							:= corp2.t2u(input.cdStatus);
				self.corp_status_desc						:= Corp2_Raw_CT.Functions.GetStatusDesc(input.cdStatus);
				
				corp1str := Corp2_Raw_CT.Functions.FixStreet(input.adStr1,input.adStr2,input.adstr3);
				corp2str := Corp2_Raw_CT.Functions.FixStreet(input.adMailStr1,input.adMailStr2,input.adMailStr3);
				MailingOnly := if(Corp2_Mapping.fAddressExists(state_origin,state_desc,corp1str,'',input.adCity,input.adState,input.adZip5 + input.adZip4,input.adCntry).ifAddressExists,'N','Y'); 

				self.corp_address1_type_cd      := if(MailingOnly = 'N'
																							,if (Corp2_Mapping.fAddressExists(state_origin,state_desc,corp1str,'',input.adCity,input.adState,input.adZip5 + input.adZip4,input.adCntry).ifAddressExists,'B','')
																							,if (Corp2_Mapping.fAddressExists(state_origin,state_desc,input.adMailStr1,input.adMailStr2 + input.adMailStr3,input.adMailCity,input.adMailState,input.adMailZip5 + input.adMailZip4,input.adMailCntry).ifAddressExists,'M','')
																							);
				self.corp_address1_type_desc    := if(MailingOnly = 'N'
																							,if (Corp2_Mapping.fAddressExists(state_origin,state_desc,corp1str,'',input.adCity,input.adState,input.adZip5 + input.adZip4,input.adCntry).ifAddressExists,'BUSINESS','')
																							,if (Corp2_Mapping.fAddressExists(state_origin,state_desc,input.adMailStr1,input.adMailStr2 + input.adMailStr3,input.adMailCity,input.adMailState,input.adMailZip5 + input.adMailZip4,input.adMailCntry).ifAddressExists,'MAILING','')
																							);
				self.corp_address1_line1        := if(MailingOnly = 'N'
																							,Corp2_Mapping.fCleanAddress (state_origin,state_desc,corp1str,'',input.adCity,input.adState,input.adZip5 + input.adZip4,input.adCntry).AddressLine1
																							,Corp2_Mapping.fCleanAddress (state_origin,state_desc,corp2str,'',input.adMailCity,input.adMailState,input.adMailZip5 + input.adMailZip4,input.adMailCntry).AddressLine1
																							);
				self.corp_address1_line2        := if(MailingOnly = 'N'
																							,Corp2_Mapping.fCleanAddress (state_origin,state_desc,corp1str,'',input.adCity,input.adState,input.adZip5 + input.adZip4,input.adCntry).AddressLine2
																							,Corp2_Mapping.fCleanAddress (state_origin,state_desc,corp2str,'',input.adMailCity,input.adMailState,input.adMailZip5 + input.adMailZip4,input.adMailCntry).AddressLine2
																							);				
				self.corp_address1_line3        := if(MailingOnly = 'N'
																							,Corp2_Mapping.fCleanAddress (state_origin,state_desc,corp1str,'',input.adCity,input.adState,input.adZip5 + input.adZip4,input.adCntry).AddressLine3
																							,Corp2_Mapping.fCleanAddress (state_origin,state_desc,corp2str,'',input.adMailCity,input.adMailState,input.adMailZip5 + input.adMailZip4,input.adMailCntry).AddressLine3
																							);	
				self.corp_prep_addr1_line1        := if(MailingOnly = 'N'
																							,Corp2_Mapping.fCleanAddress (state_origin,state_desc,corp1str,'',input.adCity,input.adState,input.adZip5,input.adCntry).PrepAddrLine1
																							,Corp2_Mapping.fCleanAddress (state_origin,state_desc,corp2str,'',input.adMailCity,input.adMailState,input.adMailZip5,input.adMailCntry).PrepAddrLine1
																							);	
				self.corp_prep_addr1_last_line        := if(MailingOnly = 'N'
																							,Corp2_Mapping.fCleanAddress (state_origin,state_desc,corp1str,'',input.adCity,input.adState,input.adZip5,input.adCntry).PrepAddrLastLine
																							,Corp2_Mapping.fCleanAddress (state_origin,state_desc,corp2str,'',input.adMailCity,input.adMailState,input.adMailZip5,input.adMailCntry).PrepAddrLastLine
																							);																							
				
				self.corp_address2_type_cd      := if(MailingOnly = 'N' ,if (Corp2_Mapping.fAddressExists(state_origin,state_desc,input.adMailStr1,input.adMailStr2 + input.adMailStr3,input.adMailCity,input.adMailState,input.adMailZip5 + input.adMailZip4,input.adMailCntry).ifAddressExists,'M','') ,'');	
				self.corp_address2_type_desc    := if(MailingOnly = 'N' ,if (Corp2_Mapping.fAddressExists(state_origin,state_desc,input.adMailStr1,input.adMailStr2 + input.adMailStr3,input.adMailCity,input.adMailState,input.adMailZip5 + input.adMailZip4,input.adMailCntry).ifAddressExists,'MAILING','') ,'');
				self.corp_address2_line1			  := if(MailingOnly = 'N' ,Corp2_Mapping.fCleanAddress (state_origin,state_desc,corp2str,'',input.adMailCity,input.adMailState,input.adMailZip5 + input.adMailZip4,input.adMailCntry).AddressLine1 ,'');
				self.corp_address2_line2				:= if(MailingOnly = 'N' ,Corp2_Mapping.fCleanAddress (state_origin,state_desc,corp2str,'',input.adMailCity,input.adMailState,input.adMailZip5 + input.adMailZip4,input.adMailCntry).AddressLine2 ,'');
				self.corp_address2_line3				:= if(MailingOnly = 'N' ,Corp2_Mapping.fCleanAddress (state_origin,state_desc,corp2str,'',input.adMailCity,input.adMailState,input.adMailZip5 + input.adMailZip4,input.adMailCntry).AddressLine3 ,'');			
				self.corp_prep_addr2_line1			:= if(MailingOnly = 'N' ,Corp2_Mapping.fCleanAddress (state_origin,state_desc,corp2str,'',input.adMailCity,input.adMailState,input.adMailZip5,input.adMailCntry).PrepAddrLine1 ,'');			
				self.corp_prep_addr2_last_line	:= if(MailingOnly = 'N' ,Corp2_Mapping.fCleanAddress (state_origin,state_desc,corp2str,'',input.adMailCity,input.adMailState,input.adMailZip5,input.adMailCntry).PrepAddrLastLine ,'');
								
        rastr := Corp2_Raw_CT.Functions.FixStreet(input.normRAAddr1,input.normRAAddr2,input.normRAAddr3);				
				self.corp_ra_address_type_cd    := if (Corp2_Mapping.fAddressExists(state_origin,state_desc,rastr,'',input.normRACity,input.normRAState,input.normRAZip5 + input.normRAZip4,input.normRACountry).ifAddressExists,input.normRAAddrType,'');
				self.corp_ra_address_type_desc  := if (Corp2_Mapping.fAddressExists(state_origin,state_desc,rastr,'',input.normRACity,input.normRAState,input.normRAZip5 + input.normRAZip4,input.normRACountry).ifAddressExists,input.normRAAddrDesc,'');
				self.corp_ra_address_line1		  := Corp2_Mapping.fCleanAddress (state_origin,state_desc,rastr,'',input.normRACity,input.normRAState,input.normRAZip5 + input.normRAZip4,input.normRACountry).AddressLine1;
				self.corp_ra_address_line2		  := Corp2_Mapping.fCleanAddress (state_origin,state_desc,rastr,'',input.normRACity,input.normRAState,input.normRAZip5 + input.normRAZip4,input.normRACountry).AddressLine2;
				self.corp_ra_address_line3		  := Corp2_Mapping.fCleanAddress (state_origin,state_desc,rastr,'',input.normRACity,input.normRAState,input.normRAZip5 + input.normRAZip4,input.normRACountry).AddressLine3;			
				self.ra_prep_addr_line1					:= Corp2_Mapping.fCleanAddress (state_origin,state_desc,rastr,'',input.normRACity,input.normRAState,input.normRAZip5,input.normRACountry).PrepAddrLine1;			
				self.ra_prep_addr_last_line 		:= Corp2_Mapping.fCleanAddress (state_origin,state_desc,rastr,'',input.normRACity,input.normRAState,input.normRAZip5,input.normRACountry).PrepAddrLastLine;
													 
				self.corp_country_of_formation  := Corp2_Raw_CT.Functions.Decode_Country(input.cdPlOfForm);
				self.corp_forgn_state_cd				:= if (corp2.t2u(input.cdPlOfForm) not in [state_origin,''] ,corp2.t2u(input.cdPlOfForm) ,'');
				self.corp_forgn_state_desc			:= if(self.corp_forgn_state_cd <> ''
																							,Corp2_Raw_CT.Functions.GetStateDesc(self.corp_forgn_state_cd) ,'');	
				self.corp_home_state_name       := corp2.t2u(input.nmForeign);																			
  			self 														:= [];
		  end;
			
			mapFLMTCorp				:= project(jTempLay_FLMTCorpWithMaster, corpFLMTCorpTrf(left));
			
			//-----------------------------------------		  
			// Map DLMLPART input file to MAIN
			//-----------------------------------------	
			jTempLay_DLMLPartWithMaster := join(	DLMLPart, NormBusMaster,
																			corp2.t2u(left.idBus) = corp2.t2u(right.idBus),
																			transform(Corp2_Raw_CT.Layouts.TempLay_DLMLPartWithMaster, self := left; self := right;),
																			left outer, local	);
																			
			Corp2_Mapping.LayoutsCommon.Main corpDLMLPartTrf(Corp2_Raw_CT.Layouts.TempLay_DLMLPartWithMaster input) := transform
									,skip(corp2.t2u(input.nmName) in ['','TEST TEST 123'] or input.idBus='0000000')
				self.corp_key										:= state_fips + '-' + corp2.t2u(input.idBus);
				self.corp_orig_sos_charter_nbr	:= corp2.t2u(input.idBus);
				self.corp_legal_name						:= Corp2_Mapping.fCleanBusinessName(state_origin,state_desc,input.nmName).BusinessName;
				self.corp_ln_name_type_cd				:= '01';
				self.corp_ln_name_type_desc			:= 'LEGAL';	
				self.corp_status_date						:= Corp2_Mapping.fValidateDate(input.dtDissolve,'CCYYMMDD').GeneralDate;	
				self.corp_additional_principals := if (corp2.t2u(input.flAddlPrinc) in ['Y','N']
				                                      ,corp2.t2u(input.flAddlPrinc) ,'');
				self.corp_for_profit_ind        := if (corp2.t2u(input.cdSubType) = 'B', 'N', '');																			
				self.corp_foreign_domestic_ind  := map(corp2.t2u(input.cdSubType) = 'C' and corp2.t2u(input.cdPlOfForm) in [state_origin,''] => 'D',
				                                       corp2.t2u(input.cdSubType) = 'C' and corp2.t2u(input.cdPlOfForm) not in [state_origin,''] => 'F',
																							 corp2.t2u(input.cdSubType) in domestic => 'D',
				                                       corp2.t2u(input.cdSubType) in foreign  => 'F',
																							 '');
				self.corp_inc_date              := if (corp2.t2u(input.cdSubType) in domestic or 
																							 (corp2.t2u(input.cdSubType) = 'C' and corp2.t2u(input.cdPlOfForm) in [state_origin,'']) 
																							   ,Corp2_Mapping.fValidateDate(input.dtOrigin,'CCYYMMDD').PastDate ,'');																			 
				self.corp_forgn_date            := if (corp2.t2u(input.cdSubType) in foreign or 
																							 (corp2.t2u(input.cdSubType) = 'C' and corp2.t2u(input.cdPlOfForm) not in [state_origin,''])
				                                       ,Corp2_Mapping.fValidateDate(input.dtOrigin,'CCYYMMDD').PastDate ,'');				self.corp_ra_full_name					:= Corp2_Mapping.fCleanBusinessName(state_origin,state_desc,input.nmAgt).BusinessName;
				self.corp_ra_addl_info          := case(corp2.t2u(input.cdAgtType),
																								'B' => 'BUSINESS',
				                                        'I' => 'INDIVIDUAL',
																								'S' => 'SECRETARY OF STATE', '');
        self.corp_ra_resign_date        := Corp2_Mapping.fValidateDate(input.dtAgtResign,'CCYYMMDD').PastDate;
				self.corp_orig_org_structure_cd	:= corp2.t2u(input.cdSubType);
				self.corp_orig_org_structure_desc	:= Corp2_Raw_CT.Functions.GetOrgStrucDesc(input.cdSubType);
				self.corp_status_cd							:= corp2.t2u(input.cdStatus);
				self.corp_status_desc						:= Corp2_Raw_CT.Functions.GetStatusDesc(input.cdStatus);
				
				corp1str := Corp2_Raw_CT.Functions.FixStreet(input.adStr1,input.adStr2,input.adstr3);
				corp2str := Corp2_Raw_CT.Functions.FixStreet(input.adMailStr1,input.adMailStr2,input.adMailStr3);
				MailingOnly := if(Corp2_Mapping.fAddressExists(state_origin,state_desc,corp1str,'',input.adCity,input.adState,input.adZip5 + input.adZip4,input.adCntry).ifAddressExists,'N','Y'); 

				self.corp_address1_type_cd      := if(MailingOnly = 'N'
																							,if (Corp2_Mapping.fAddressExists(state_origin,state_desc,corp1str,'',input.adCity,input.adState,input.adZip5 + input.adZip4,input.adCntry).ifAddressExists,'B','')
																							,if (Corp2_Mapping.fAddressExists(state_origin,state_desc,input.adMailStr1,input.adMailStr2 + input.adMailStr3,input.adMailCity,input.adMailState,input.adMailZip5 + input.adMailZip4,input.adMailCntry).ifAddressExists,'M','')
																							);
				self.corp_address1_type_desc    := if(MailingOnly = 'N'
																							,if (Corp2_Mapping.fAddressExists(state_origin,state_desc,corp1str,'',input.adCity,input.adState,input.adZip5 + input.adZip4,input.adCntry).ifAddressExists,'BUSINESS','')
																							,if (Corp2_Mapping.fAddressExists(state_origin,state_desc,input.adMailStr1,input.adMailStr2 + input.adMailStr3,input.adMailCity,input.adMailState,input.adMailZip5 + input.adMailZip4,input.adMailCntry).ifAddressExists,'MAILING','')
																							);
				self.corp_address1_line1        := if(MailingOnly = 'N'
																							,Corp2_Mapping.fCleanAddress (state_origin,state_desc,corp1str,'',input.adCity,input.adState,input.adZip5 + input.adZip4,input.adCntry).AddressLine1
																							,Corp2_Mapping.fCleanAddress (state_origin,state_desc,corp2str,'',input.adMailCity,input.adMailState,input.adMailZip5 + input.adMailZip4,input.adMailCntry).AddressLine1
																							);
				self.corp_address1_line2        := if(MailingOnly = 'N'
																							,Corp2_Mapping.fCleanAddress (state_origin,state_desc,corp1str,'',input.adCity,input.adState,input.adZip5 + input.adZip4,input.adCntry).AddressLine2
																							,Corp2_Mapping.fCleanAddress (state_origin,state_desc,corp2str,'',input.adMailCity,input.adMailState,input.adMailZip5 + input.adMailZip4,input.adMailCntry).AddressLine2
																							);				
				self.corp_address1_line3        := if(MailingOnly = 'N'
																							,Corp2_Mapping.fCleanAddress (state_origin,state_desc,corp1str,'',input.adCity,input.adState,input.adZip5 + input.adZip4,input.adCntry).AddressLine3
																							,Corp2_Mapping.fCleanAddress (state_origin,state_desc,corp2str,'',input.adMailCity,input.adMailState,input.adMailZip5 + input.adMailZip4,input.adMailCntry).AddressLine3
																							);	
				self.corp_prep_addr1_line1        := if(MailingOnly = 'N'
																							,Corp2_Mapping.fCleanAddress (state_origin,state_desc,corp1str,'',input.adCity,input.adState,input.adZip5,input.adCntry).PrepAddrLine1
																							,Corp2_Mapping.fCleanAddress (state_origin,state_desc,corp2str,'',input.adMailCity,input.adMailState,input.adMailZip5,input.adMailCntry).PrepAddrLine1
																							);	
				self.corp_prep_addr1_last_line        := if(MailingOnly = 'N'
																							,Corp2_Mapping.fCleanAddress (state_origin,state_desc,corp1str,'',input.adCity,input.adState,input.adZip5,input.adCntry).PrepAddrLastLine
																							,Corp2_Mapping.fCleanAddress (state_origin,state_desc,corp2str,'',input.adMailCity,input.adMailState,input.adMailZip5,input.adMailCntry).PrepAddrLastLine
																							);																							
				
				self.corp_address2_type_cd      := if(MailingOnly = 'N' ,if (Corp2_Mapping.fAddressExists(state_origin,state_desc,input.adMailStr1,input.adMailStr2 + input.adMailStr3,input.adMailCity,input.adMailState,input.adMailZip5 + input.adMailZip4,input.adMailCntry).ifAddressExists,'M','') ,'');	
				self.corp_address2_type_desc    := if(MailingOnly = 'N' ,if (Corp2_Mapping.fAddressExists(state_origin,state_desc,input.adMailStr1,input.adMailStr2 + input.adMailStr3,input.adMailCity,input.adMailState,input.adMailZip5 + input.adMailZip4,input.adMailCntry).ifAddressExists,'MAILING','') ,'');
				self.corp_address2_line1			  := if(MailingOnly = 'N' ,Corp2_Mapping.fCleanAddress (state_origin,state_desc,corp2str,'',input.adMailCity,input.adMailState,input.adMailZip5 + input.adMailZip4,input.adMailCntry).AddressLine1 ,'');
				self.corp_address2_line2				:= if(MailingOnly = 'N' ,Corp2_Mapping.fCleanAddress (state_origin,state_desc,corp2str,'',input.adMailCity,input.adMailState,input.adMailZip5 + input.adMailZip4,input.adMailCntry).AddressLine2 ,'');
				self.corp_address2_line3				:= if(MailingOnly = 'N' ,Corp2_Mapping.fCleanAddress (state_origin,state_desc,corp2str,'',input.adMailCity,input.adMailState,input.adMailZip5 + input.adMailZip4,input.adMailCntry).AddressLine3 ,'');			
				self.corp_prep_addr2_line1			:= if(MailingOnly = 'N' ,Corp2_Mapping.fCleanAddress (state_origin,state_desc,corp2str,'',input.adMailCity,input.adMailState,input.adMailZip5,input.adMailCntry).PrepAddrLine1 ,'');			
				self.corp_prep_addr2_last_line	:= if(MailingOnly = 'N' ,Corp2_Mapping.fCleanAddress (state_origin,state_desc,corp2str,'',input.adMailCity,input.adMailState,input.adMailZip5,input.adMailCntry).PrepAddrLastLine ,'');
								
        rastr := Corp2_Raw_CT.Functions.FixStreet(input.normRAAddr1,input.normRAAddr2,input.normRAAddr3);				
				self.corp_ra_address_type_cd    := if (Corp2_Mapping.fAddressExists(state_origin,state_desc,rastr,'',input.normRACity,input.normRAState,input.normRAZip5 + input.normRAZip4,input.normRACountry).ifAddressExists,input.normRAAddrType,'');
				self.corp_ra_address_type_desc  := if (Corp2_Mapping.fAddressExists(state_origin,state_desc,rastr,'',input.normRACity,input.normRAState,input.normRAZip5 + input.normRAZip4,input.normRACountry).ifAddressExists,input.normRAAddrDesc,'');
				self.corp_ra_address_line1		  := Corp2_Mapping.fCleanAddress (state_origin,state_desc,rastr,'',input.normRACity,input.normRAState,input.normRAZip5 + input.normRAZip4,input.normRACountry).AddressLine1;
				self.corp_ra_address_line2		  := Corp2_Mapping.fCleanAddress (state_origin,state_desc,rastr,'',input.normRACity,input.normRAState,input.normRAZip5 + input.normRAZip4,input.normRACountry).AddressLine2;
				self.corp_ra_address_line3		  := Corp2_Mapping.fCleanAddress (state_origin,state_desc,rastr,'',input.normRACity,input.normRAState,input.normRAZip5 + input.normRAZip4,input.normRACountry).AddressLine3;			
				self.ra_prep_addr_line1					:= Corp2_Mapping.fCleanAddress (state_origin,state_desc,rastr,'',input.normRACity,input.normRAState,input.normRAZip5,input.normRACountry).PrepAddrLine1;			
				self.ra_prep_addr_last_line 		:= Corp2_Mapping.fCleanAddress (state_origin,state_desc,rastr,'',input.normRACity,input.normRAState,input.normRAZip5,input.normRACountry).PrepAddrLastLine;
				self 														:= [];
  		end; 
			
			mapDLMLPart				:= project(jTempLay_DLMLPartWithMaster, corpDLMLPartTrf(left));	

			//-----------------------------------------		  
			// Map FLMLPART input file to MAIN
			//-----------------------------------------		
			jTempLay_FLMLPartWithMaster := join(	FLMLPart, NormBusMaster,
																			corp2.t2u(left.idBus) = corp2.t2u(right.idBus),
																			transform(Corp2_Raw_CT.Layouts.TempLay_FLMLPartWithMaster, self := left; self := right;),
																			left outer, local);
																			
			Corp2_Mapping.LayoutsCommon.Main corpFLMLPartTrf(Corp2_Raw_CT.Layouts.TempLay_FLMLPartWithMaster input) := transform
									,skip(corp2.t2u(input.nmName) in ['','TEST TEST 123'] or input.idBus='0000000')
				self.corp_key										:= state_fips + '-' + corp2.t2u(input.idBus);
				self.corp_orig_sos_charter_nbr	:= corp2.t2u(input.idBus);
				self.corp_legal_name						:= Corp2_Mapping.fCleanBusinessName(state_origin,state_desc,input.nmName).BusinessName;
				self.corp_ln_name_type_cd				:= '01';
				self.corp_ln_name_type_desc			:= 'LEGAL';
				self.corp_status_date						:= Corp2_Mapping.fValidateDate(input.dtDissolve,'CCYYMMDD').GeneralDate;	
				self.corp_filing_date				    := Corp2_Mapping.fValidateDate(input.dtComncBus,'CCYYMMDD').GeneralDate;
				self.corp_filing_cd             := if (self.corp_filing_date <> '' ,'X' ,'');
				self.corp_filing_desc           := if (self.corp_filing_date <> '' ,'COMMENCE BUSINESS DATE' ,'');				
				self.corp_additional_principals := if (corp2.t2u(input.flAddlPrinc) in ['Y','N']
				                                      ,corp2.t2u(input.flAddlPrinc) ,'');
				self.corp_for_profit_ind        := if (corp2.t2u(input.cdSubType) = 'B', 'N', '');																			
				self.corp_foreign_domestic_ind  := map(corp2.t2u(input.cdSubType) = 'C' and corp2.t2u(input.cdPlOfForm) in [state_origin,''] => 'D',
				                                       corp2.t2u(input.cdSubType) = 'C' and corp2.t2u(input.cdPlOfForm) not in [state_origin,''] => 'F',
																							 corp2.t2u(input.cdSubType) in domestic => 'D',
				                                       corp2.t2u(input.cdSubType) in foreign  => 'F',
																							 '');
				self.corp_inc_date              := if (corp2.t2u(input.cdSubType) in domestic or 
																							 (corp2.t2u(input.cdSubType) = 'C' and corp2.t2u(input.cdPlOfForm) in [state_origin,'']) 
																							   ,Corp2_Mapping.fValidateDate(input.dtOrigin,'CCYYMMDD').PastDate ,'');																			 
				self.corp_forgn_date            := if (corp2.t2u(input.cdSubType) in foreign or 
																							 (corp2.t2u(input.cdSubType) = 'C' and corp2.t2u(input.cdPlOfForm) not in [state_origin,''])
				                                       ,Corp2_Mapping.fValidateDate(input.dtOrigin,'CCYYMMDD').PastDate ,'');				self.corp_ra_full_name					:= Corp2_Mapping.fCleanBusinessName(state_origin,state_desc,input.nmAgt).BusinessName;
				self.corp_ra_addl_info          := case(corp2.t2u(input.cdAgtType),
																								'B' => 'BUSINESS',
				                                        'I' => 'INDIVIDUAL',
																								'S' => 'SECRETARY OF STATE', '');
        self.corp_ra_resign_date        := Corp2_Mapping.fValidateDate(input.dtAgtResign,'CCYYMMDD').PastDate;
				self.corp_orig_org_structure_cd	:= corp2.t2u(input.cdSubType);
				self.corp_orig_org_structure_desc	:= Corp2_Raw_CT.Functions.GetOrgStrucDesc(input.cdSubType);
				self.corp_status_cd							:= corp2.t2u(input.cdStatus);
				self.corp_status_desc						:= Corp2_Raw_CT.Functions.GetStatusDesc(input.cdStatus);
				
				corp1str := Corp2_Raw_CT.Functions.FixStreet(input.adStr1,input.adStr2,input.adstr3);
				corp2str := Corp2_Raw_CT.Functions.FixStreet(input.adMailStr1,input.adMailStr2,input.adMailStr3);
				MailingOnly := if(Corp2_Mapping.fAddressExists(state_origin,state_desc,corp1str,'',input.adCity,input.adState,input.adZip5 + input.adZip4,input.adCntry).ifAddressExists,'N','Y'); 

				self.corp_address1_type_cd      := if(MailingOnly = 'N'
																							,if (Corp2_Mapping.fAddressExists(state_origin,state_desc,corp1str,'',input.adCity,input.adState,input.adZip5 + input.adZip4,input.adCntry).ifAddressExists,'B','')
																							,if (Corp2_Mapping.fAddressExists(state_origin,state_desc,input.adMailStr1,input.adMailStr2 + input.adMailStr3,input.adMailCity,input.adMailState,input.adMailZip5 + input.adMailZip4,input.adMailCntry).ifAddressExists,'M','')
																							);
				self.corp_address1_type_desc    := if(MailingOnly = 'N'
																							,if (Corp2_Mapping.fAddressExists(state_origin,state_desc,corp1str,'',input.adCity,input.adState,input.adZip5 + input.adZip4,input.adCntry).ifAddressExists,'BUSINESS','')
																							,if (Corp2_Mapping.fAddressExists(state_origin,state_desc,input.adMailStr1,input.adMailStr2 + input.adMailStr3,input.adMailCity,input.adMailState,input.adMailZip5 + input.adMailZip4,input.adMailCntry).ifAddressExists,'MAILING','')
																							);
				self.corp_address1_line1        := if(MailingOnly = 'N'
																							,Corp2_Mapping.fCleanAddress (state_origin,state_desc,corp1str,'',input.adCity,input.adState,input.adZip5 + input.adZip4,input.adCntry).AddressLine1
																							,Corp2_Mapping.fCleanAddress (state_origin,state_desc,corp2str,'',input.adMailCity,input.adMailState,input.adMailZip5 + input.adMailZip4,input.adMailCntry).AddressLine1
																							);
				self.corp_address1_line2        := if(MailingOnly = 'N'
																							,Corp2_Mapping.fCleanAddress (state_origin,state_desc,corp1str,'',input.adCity,input.adState,input.adZip5 + input.adZip4,input.adCntry).AddressLine2
																							,Corp2_Mapping.fCleanAddress (state_origin,state_desc,corp2str,'',input.adMailCity,input.adMailState,input.adMailZip5 + input.adMailZip4,input.adMailCntry).AddressLine2
																							);				
				self.corp_address1_line3        := if(MailingOnly = 'N'
																							,Corp2_Mapping.fCleanAddress (state_origin,state_desc,corp1str,'',input.adCity,input.adState,input.adZip5 + input.adZip4,input.adCntry).AddressLine3
																							,Corp2_Mapping.fCleanAddress (state_origin,state_desc,corp2str,'',input.adMailCity,input.adMailState,input.adMailZip5 + input.adMailZip4,input.adMailCntry).AddressLine3
																							);	
				self.corp_prep_addr1_line1        := if(MailingOnly = 'N'
																							,Corp2_Mapping.fCleanAddress (state_origin,state_desc,corp1str,'',input.adCity,input.adState,input.adZip5,input.adCntry).PrepAddrLine1
																							,Corp2_Mapping.fCleanAddress (state_origin,state_desc,corp2str,'',input.adMailCity,input.adMailState,input.adMailZip5,input.adMailCntry).PrepAddrLine1
																							);	
				self.corp_prep_addr1_last_line        := if(MailingOnly = 'N'
																							,Corp2_Mapping.fCleanAddress (state_origin,state_desc,corp1str,'',input.adCity,input.adState,input.adZip5,input.adCntry).PrepAddrLastLine
																							,Corp2_Mapping.fCleanAddress (state_origin,state_desc,corp2str,'',input.adMailCity,input.adMailState,input.adMailZip5,input.adMailCntry).PrepAddrLastLine
																							);																							
				
				self.corp_address2_type_cd      := if(MailingOnly = 'N' ,if (Corp2_Mapping.fAddressExists(state_origin,state_desc,input.adMailStr1,input.adMailStr2 + input.adMailStr3,input.adMailCity,input.adMailState,input.adMailZip5 + input.adMailZip4,input.adMailCntry).ifAddressExists,'M','') ,'');	
				self.corp_address2_type_desc    := if(MailingOnly = 'N' ,if (Corp2_Mapping.fAddressExists(state_origin,state_desc,input.adMailStr1,input.adMailStr2 + input.adMailStr3,input.adMailCity,input.adMailState,input.adMailZip5 + input.adMailZip4,input.adMailCntry).ifAddressExists,'MAILING','') ,'');
				self.corp_address2_line1			  := if(MailingOnly = 'N' ,Corp2_Mapping.fCleanAddress (state_origin,state_desc,corp2str,'',input.adMailCity,input.adMailState,input.adMailZip5 + input.adMailZip4,input.adMailCntry).AddressLine1 ,'');
				self.corp_address2_line2				:= if(MailingOnly = 'N' ,Corp2_Mapping.fCleanAddress (state_origin,state_desc,corp2str,'',input.adMailCity,input.adMailState,input.adMailZip5 + input.adMailZip4,input.adMailCntry).AddressLine2 ,'');
				self.corp_address2_line3				:= if(MailingOnly = 'N' ,Corp2_Mapping.fCleanAddress (state_origin,state_desc,corp2str,'',input.adMailCity,input.adMailState,input.adMailZip5 + input.adMailZip4,input.adMailCntry).AddressLine3 ,'');			
				self.corp_prep_addr2_line1			:= if(MailingOnly = 'N' ,Corp2_Mapping.fCleanAddress (state_origin,state_desc,corp2str,'',input.adMailCity,input.adMailState,input.adMailZip5,input.adMailCntry).PrepAddrLine1 ,'');			
				self.corp_prep_addr2_last_line	:= if(MailingOnly = 'N' ,Corp2_Mapping.fCleanAddress (state_origin,state_desc,corp2str,'',input.adMailCity,input.adMailState,input.adMailZip5,input.adMailCntry).PrepAddrLastLine ,'');
								
        rastr := Corp2_Raw_CT.Functions.FixStreet(input.normRAAddr1,input.normRAAddr2,input.normRAAddr3);				
				self.corp_ra_address_type_cd    := if (Corp2_Mapping.fAddressExists(state_origin,state_desc,rastr,'',input.normRACity,input.normRAState,input.normRAZip5 + input.normRAZip4,input.normRACountry).ifAddressExists,input.normRAAddrType,'');
				self.corp_ra_address_type_desc  := if (Corp2_Mapping.fAddressExists(state_origin,state_desc,rastr,'',input.normRACity,input.normRAState,input.normRAZip5 + input.normRAZip4,input.normRACountry).ifAddressExists,input.normRAAddrDesc,'');
				self.corp_ra_address_line1		  := Corp2_Mapping.fCleanAddress (state_origin,state_desc,rastr,'',input.normRACity,input.normRAState,input.normRAZip5 + input.normRAZip4,input.normRACountry).AddressLine1;
				self.corp_ra_address_line2		  := Corp2_Mapping.fCleanAddress (state_origin,state_desc,rastr,'',input.normRACity,input.normRAState,input.normRAZip5 + input.normRAZip4,input.normRACountry).AddressLine2;
				self.corp_ra_address_line3		  := Corp2_Mapping.fCleanAddress (state_origin,state_desc,rastr,'',input.normRACity,input.normRAState,input.normRAZip5 + input.normRAZip4,input.normRACountry).AddressLine3;			
				self.ra_prep_addr_line1					:= Corp2_Mapping.fCleanAddress (state_origin,state_desc,rastr,'',input.normRACity,input.normRAState,input.normRAZip5,input.normRACountry).PrepAddrLine1;			
				self.ra_prep_addr_last_line 		:= Corp2_Mapping.fCleanAddress (state_origin,state_desc,rastr,'',input.normRACity,input.normRAState,input.normRAZip5,input.normRACountry).PrepAddrLastLine;

				self.corp_country_of_formation  := Corp2_Raw_CT.Functions.Decode_Country(input.cdPlOfForm);
			  self.corp_forgn_state_cd				:= if (corp2.t2u(input.cdPlOfForm) not in [state_origin,'']	,corp2.t2u(input.cdPlOfForm) ,'');
				self.corp_forgn_state_desc			:= if(self.corp_forgn_state_cd <> ''
																							,Corp2_Raw_CT.Functions.GetStateDesc(self.corp_forgn_state_cd) ,'');	
				self.corp_home_state_name       := corp2.t2u(input.nmForeign);																			
				self 														:= [];
			end;
			
			mapFLMLPart				:= project(jTempLay_FLMLPartWithMaster, corpFLMLPartTrf(left));
			
			//-----------------------------------------		  
			// Map GENERAL input file to MAIN
			//-----------------------------------------	
			jTempLay_GeneralWithMaster := join(	General, NormBusMaster,
																			corp2.t2u(left.idBus) = corp2.t2u(right.idBus),
																			transform(Corp2_Raw_CT.Layouts.TempLay_GeneralWithMaster, self := left; self := right;),
																			left outer, local);		
																			
			Corp2_Mapping.LayoutsCommon.Main corpGeneralTrf(Corp2_Raw_CT.Layouts.TempLay_GeneralWithMaster input) := transform
									,skip(corp2.t2u(input.nmName) in ['','TEST TEST 123'] or input.idBus='0000000')
				self.corp_key										:= state_fips + '-' + corp2.t2u(input.idBus);
				self.corp_orig_sos_charter_nbr	:= corp2.t2u(input.idBus);
				self.corp_legal_name						:= Corp2_Mapping.fCleanBusinessName(state_origin,state_desc,input.nmName).BusinessName;
				self.corp_ln_name_type_cd				:= '01';
				self.corp_ln_name_type_desc			:= 'LEGAL';	
				self.corp_status_date						:= Corp2_Mapping.fValidateDate(input.dtDissolve,'CCYYMMDD').GeneralDate;	
				self.corp_dissolved_date				:= Corp2_Mapping.fValidateDate(input.dtDissolve,'CCYYMMDD').GeneralDate;	
				self.corp_additional_principals := if (corp2.t2u(input.flAddlPrinc) in ['Y','N']
				                                      ,corp2.t2u(input.flAddlPrinc) ,'');
				self.corp_for_profit_ind        := if (corp2.t2u(input.cdSubType) = 'B', 'N', '');																			
				self.corp_foreign_domestic_ind  := map(corp2.t2u(input.cdSubType) = 'C' and corp2.t2u(input.cdPlOfForm) in [state_origin,''] => 'D',
				                                       corp2.t2u(input.cdSubType) = 'C' and corp2.t2u(input.cdPlOfForm) not in [state_origin,''] => 'F',
																							 corp2.t2u(input.cdSubType) in domestic => 'D',
				                                       corp2.t2u(input.cdSubType) in foreign  => 'F',
																							 '');
				self.corp_inc_date              := if (corp2.t2u(input.cdSubType) in domestic or 
																							 (corp2.t2u(input.cdSubType) = 'C' and corp2.t2u(input.cdPlOfForm) in [state_origin,'']) 
																							   ,Corp2_Mapping.fValidateDate(input.dtOrigin,'CCYYMMDD').PastDate ,'');																			 
				self.corp_forgn_date            := if (corp2.t2u(input.cdSubType) in foreign or 
																							 (corp2.t2u(input.cdSubType) = 'C' and corp2.t2u(input.cdPlOfForm) not in [state_origin,''])
				                                       ,Corp2_Mapping.fValidateDate(input.dtOrigin,'CCYYMMDD').PastDate ,'');				self.corp_ra_full_name					:= Corp2_Mapping.fCleanBusinessName(state_origin,state_desc,input.nmAgt).BusinessName;
				self.corp_ra_addl_info          := case(corp2.t2u(input.cdAgtType),
																								'B' => 'BUSINESS',
				                                        'I' => 'INDIVIDUAL',
																								'S' => 'SECRETARY OF STATE', '');
        self.corp_ra_resign_date        := Corp2_Mapping.fValidateDate(input.dtAgtResign,'CCYYMMDD').PastDate;
				self.corp_orig_org_structure_cd	:= corp2.t2u(input.cdSubType);
				self.corp_orig_org_structure_desc	:= Corp2_Raw_CT.Functions.GetOrgStrucDesc(input.cdSubType);
				self.corp_status_cd							:= corp2.t2u(input.cdStatus);
				self.corp_status_desc						:= Corp2_Raw_CT.Functions.GetStatusDesc(input.cdStatus);
				
				corp1str := Corp2_Raw_CT.Functions.FixStreet(input.adStr1,input.adStr2,input.adstr3);
				corp2str := Corp2_Raw_CT.Functions.FixStreet(input.adMailStr1,input.adMailStr2,input.adMailStr3);
				MailingOnly := if(Corp2_Mapping.fAddressExists(state_origin,state_desc,corp1str,'',input.adCity,input.adState,input.adZip5 + input.adZip4,input.adCntry).ifAddressExists,'N','Y'); 

				self.corp_address1_type_cd      := if(MailingOnly = 'N'
																							,if (Corp2_Mapping.fAddressExists(state_origin,state_desc,corp1str,'',input.adCity,input.adState,input.adZip5 + input.adZip4,input.adCntry).ifAddressExists,'B','')
																							,if (Corp2_Mapping.fAddressExists(state_origin,state_desc,input.adMailStr1,input.adMailStr2 + input.adMailStr3,input.adMailCity,input.adMailState,input.adMailZip5 + input.adMailZip4,input.adMailCntry).ifAddressExists,'M','')
																							);
				self.corp_address1_type_desc    := if(MailingOnly = 'N'
																							,if (Corp2_Mapping.fAddressExists(state_origin,state_desc,corp1str,'',input.adCity,input.adState,input.adZip5 + input.adZip4,input.adCntry).ifAddressExists,'BUSINESS','')
																							,if (Corp2_Mapping.fAddressExists(state_origin,state_desc,input.adMailStr1,input.adMailStr2 + input.adMailStr3,input.adMailCity,input.adMailState,input.adMailZip5 + input.adMailZip4,input.adMailCntry).ifAddressExists,'MAILING','')
																							);
				self.corp_address1_line1        := if(MailingOnly = 'N'
																							,Corp2_Mapping.fCleanAddress (state_origin,state_desc,corp1str,'',input.adCity,input.adState,input.adZip5 + input.adZip4,input.adCntry).AddressLine1
																							,Corp2_Mapping.fCleanAddress (state_origin,state_desc,corp2str,'',input.adMailCity,input.adMailState,input.adMailZip5 + input.adMailZip4,input.adMailCntry).AddressLine1
																							);
				self.corp_address1_line2        := if(MailingOnly = 'N'
																							,Corp2_Mapping.fCleanAddress (state_origin,state_desc,corp1str,'',input.adCity,input.adState,input.adZip5 + input.adZip4,input.adCntry).AddressLine2
																							,Corp2_Mapping.fCleanAddress (state_origin,state_desc,corp2str,'',input.adMailCity,input.adMailState,input.adMailZip5 + input.adMailZip4,input.adMailCntry).AddressLine2
																							);				
				self.corp_address1_line3        := if(MailingOnly = 'N'
																							,Corp2_Mapping.fCleanAddress (state_origin,state_desc,corp1str,'',input.adCity,input.adState,input.adZip5 + input.adZip4,input.adCntry).AddressLine3
																							,Corp2_Mapping.fCleanAddress (state_origin,state_desc,corp2str,'',input.adMailCity,input.adMailState,input.adMailZip5 + input.adMailZip4,input.adMailCntry).AddressLine3
																							);	
				self.corp_prep_addr1_line1        := if(MailingOnly = 'N'
																							,Corp2_Mapping.fCleanAddress (state_origin,state_desc,corp1str,'',input.adCity,input.adState,input.adZip5,input.adCntry).PrepAddrLine1
																							,Corp2_Mapping.fCleanAddress (state_origin,state_desc,corp2str,'',input.adMailCity,input.adMailState,input.adMailZip5,input.adMailCntry).PrepAddrLine1
																							);	
				self.corp_prep_addr1_last_line        := if(MailingOnly = 'N'
																							,Corp2_Mapping.fCleanAddress (state_origin,state_desc,corp1str,'',input.adCity,input.adState,input.adZip5,input.adCntry).PrepAddrLastLine
																							,Corp2_Mapping.fCleanAddress (state_origin,state_desc,corp2str,'',input.adMailCity,input.adMailState,input.adMailZip5,input.adMailCntry).PrepAddrLastLine
																							);																							
				
				self.corp_address2_type_cd      := if(MailingOnly = 'N' ,if (Corp2_Mapping.fAddressExists(state_origin,state_desc,input.adMailStr1,input.adMailStr2 + input.adMailStr3,input.adMailCity,input.adMailState,input.adMailZip5 + input.adMailZip4,input.adMailCntry).ifAddressExists,'M','') ,'');	
				self.corp_address2_type_desc    := if(MailingOnly = 'N' ,if (Corp2_Mapping.fAddressExists(state_origin,state_desc,input.adMailStr1,input.adMailStr2 + input.adMailStr3,input.adMailCity,input.adMailState,input.adMailZip5 + input.adMailZip4,input.adMailCntry).ifAddressExists,'MAILING','') ,'');
				self.corp_address2_line1			  := if(MailingOnly = 'N' ,Corp2_Mapping.fCleanAddress (state_origin,state_desc,corp2str,'',input.adMailCity,input.adMailState,input.adMailZip5 + input.adMailZip4,input.adMailCntry).AddressLine1 ,'');
				self.corp_address2_line2				:= if(MailingOnly = 'N' ,Corp2_Mapping.fCleanAddress (state_origin,state_desc,corp2str,'',input.adMailCity,input.adMailState,input.adMailZip5 + input.adMailZip4,input.adMailCntry).AddressLine2 ,'');
				self.corp_address2_line3				:= if(MailingOnly = 'N' ,Corp2_Mapping.fCleanAddress (state_origin,state_desc,corp2str,'',input.adMailCity,input.adMailState,input.adMailZip5 + input.adMailZip4,input.adMailCntry).AddressLine3 ,'');			
				self.corp_prep_addr2_line1			:= if(MailingOnly = 'N' ,Corp2_Mapping.fCleanAddress (state_origin,state_desc,corp2str,'',input.adMailCity,input.adMailState,input.adMailZip5,input.adMailCntry).PrepAddrLine1 ,'');			
				self.corp_prep_addr2_last_line	:= if(MailingOnly = 'N' ,Corp2_Mapping.fCleanAddress (state_origin,state_desc,corp2str,'',input.adMailCity,input.adMailState,input.adMailZip5,input.adMailCntry).PrepAddrLastLine ,'');
								
				rastr := Corp2_Raw_CT.Functions.FixStreet(input.AdAgtMailStr1,input.AdAgtMailStr2,input.AdAgtMailStr3);
			  self.corp_ra_address_type_cd    := if (Corp2_Mapping.fAddressExists(state_origin,state_desc,rastr,'',input.AdAgtMailCity,input.AdAgtMailSt,input.AdAgtMailZip5 + input.AdAgtMailZip4,input.adAgtMailCntry).ifAddressExists,'M','');
				self.corp_ra_address_type_desc  := if (Corp2_Mapping.fAddressExists(state_origin,state_desc,rastr,'',input.AdAgtMailCity,input.AdAgtMailSt,input.AdAgtMailZip5 + input.AdAgtMailZip4,input.adAgtMailCntry).ifAddressExists,'AGENT MAILING ADDRESS','');
				self.corp_ra_address_line1		  := Corp2_Mapping.fCleanAddress (state_origin,state_desc,rastr,'',input.AdAgtMailCity,input.AdAgtMailSt,input.AdAgtMailZip5 + input.AdAgtMailZip4,input.adAgtMailCntry).AddressLine1;
				self.corp_ra_address_line2		  := Corp2_Mapping.fCleanAddress (state_origin,state_desc,rastr,'',input.AdAgtMailCity,input.AdAgtMailSt,input.AdAgtMailZip5 + input.AdAgtMailZip4,input.adAgtMailCntry).AddressLine2;
				self.corp_ra_address_line3		  := Corp2_Mapping.fCleanAddress (state_origin,state_desc,rastr,'',input.AdAgtMailCity,input.AdAgtMailSt,input.AdAgtMailZip5 + input.AdAgtMailZip4,input.adAgtMailCntry).AddressLine3;			
				self.ra_prep_addr_line1					:= Corp2_Mapping.fCleanAddress (state_origin,state_desc,rastr,'',input.AdAgtMailCity,input.AdAgtMailSt,input.AdAgtMailZip5,input.adAgtMailCntry).PrepAddrLine1;			
				self.ra_prep_addr_last_line 		:= Corp2_Mapping.fCleanAddress (state_origin,state_desc,rastr,'',input.AdAgtMailCity,input.AdAgtMailSt,input.AdAgtMailZip5,input.adAgtMailCntry).PrepAddrLastLine;

				self.corp_term_exist_exp				:= Corp2_Mapping.fValidateDate(input.dtCanOpnLaw,'CCYYMMDD').GeneralDate;
				self.corp_term_exist_cd					:= if(self.corp_term_exist_exp <> '', 'D', '');
				self.corp_term_exist_desc				:= if(self.corp_term_exist_cd = 'D', 'EXPIRATION DATE', '');
				self 														:= [];
			end;
			
			mapGeneral				:= project(jTempLay_GeneralWithMaster,  corpGeneralTrf(left));
		
			//-----------------------------------------		  
			// Map FORSTAT input file to MAIN
			//-----------------------------------------	
			jTempLay_ForStatWithMaster := join(	ForStat, NormBusMaster,
																			corp2.t2u(left.idBus) = corp2.t2u(right.idBus),
																			transform(Corp2_Raw_CT.Layouts.TempLay_ForStatWithMaster, self := left; self := right;),
																			left outer, local);		
		
			Corp2_Mapping.LayoutsCommon.Main corpForStatTrf(Corp2_Raw_CT.Layouts.TempLay_ForStatWithMaster input) := transform
									,skip(corp2.t2u(input.nmName) in ['','TEST TEST 123'] or input.idBus='0000000')
				self.corp_key										:= state_fips + '-' + corp2.t2u(input.idBus);
				self.corp_orig_sos_charter_nbr	:= corp2.t2u(input.idBus);
				self.corp_legal_name						:= Corp2_Mapping.fCleanBusinessName(state_origin,state_desc,input.nmName).BusinessName;
				self.corp_ln_name_type_cd				:= '01';
				self.corp_ln_name_type_desc			:= 'LEGAL';
				self.corp_additional_principals := if (corp2.t2u(input.flAddlPrinc) in ['Y','N']
				                                      ,corp2.t2u(input.flAddlPrinc) ,'');
				self.corp_for_profit_ind        := if (corp2.t2u(input.cdSubType) = 'B', 'N', '');																			
				self.corp_foreign_domestic_ind  := map(corp2.t2u(input.cdSubType) = 'C' and corp2.t2u(input.cdPlOfForm) in [state_origin,''] => 'D',
				                                       corp2.t2u(input.cdSubType) = 'C' and corp2.t2u(input.cdPlOfForm) not in [state_origin,''] => 'F',
																							 corp2.t2u(input.cdSubType) in domestic => 'D',
				                                       corp2.t2u(input.cdSubType) in foreign  => 'F',
																							 '');
				self.corp_inc_date              := if (corp2.t2u(input.cdSubType) in domestic or 
																							 (corp2.t2u(input.cdSubType) = 'C' and corp2.t2u(input.cdPlOfForm) in [state_origin,'']) 
																							   ,Corp2_Mapping.fValidateDate(input.dtOrigin,'CCYYMMDD').PastDate ,'');																			 
				self.corp_forgn_date            := if (corp2.t2u(input.cdSubType) in foreign or 
																							 (corp2.t2u(input.cdSubType) = 'C' and corp2.t2u(input.cdPlOfForm) not in [state_origin,''])
				                                       ,Corp2_Mapping.fValidateDate(input.dtOrigin,'CCYYMMDD').PastDate ,'');				self.corp_ra_full_name					:= Corp2_Mapping.fCleanBusinessName(state_origin,state_desc,input.nmAgt).BusinessName;
				self.corp_ra_addl_info          := case(corp2.t2u(input.cdAgtType),
																								'B' => 'BUSINESS',
				                                        'I' => 'INDIVIDUAL',
																								'S' => 'SECRETARY OF STATE', '');
        self.corp_ra_resign_date        := Corp2_Mapping.fValidateDate(input.dtAgtResign,'CCYYMMDD').PastDate;
				self.corp_filing_date				    := Corp2_Mapping.fValidateDate(input.dtComncBus,'CCYYMMDD').GeneralDate;
				self.corp_filing_cd             := if (self.corp_filing_date <> '' ,'X' ,'');
				self.corp_filing_desc           := if (self.corp_filing_date <> '' ,'COMMENCE BUSINESS DATE' ,'');				
				self.corp_orig_org_structure_cd	:= corp2.t2u(input.cdSubType);
				self.corp_orig_org_structure_desc	:= Corp2_Raw_CT.Functions.GetOrgStrucDesc(input.cdSubType);
				self.corp_status_cd							:= corp2.t2u(input.cdStatus);
				self.corp_status_desc						:= Corp2_Raw_CT.Functions.GetStatusDesc(input.cdStatus);
				
				corp1str := Corp2_Raw_CT.Functions.FixStreet(input.adStr1,input.adStr2,input.adstr3);
				corp2str := Corp2_Raw_CT.Functions.FixStreet(input.adMailStr1,input.adMailStr2,input.adMailStr3);
				MailingOnly := if(Corp2_Mapping.fAddressExists(state_origin,state_desc,corp1str,'',input.adCity,input.adState,input.adZip5 + input.adZip4,input.adCntry).ifAddressExists,'N','Y'); 

				self.corp_address1_type_cd      := if(MailingOnly = 'N'
																							,if (Corp2_Mapping.fAddressExists(state_origin,state_desc,corp1str,'',input.adCity,input.adState,input.adZip5 + input.adZip4,input.adCntry).ifAddressExists,'B','')
																							,if (Corp2_Mapping.fAddressExists(state_origin,state_desc,input.adMailStr1,input.adMailStr2 + input.adMailStr3,input.adMailCity,input.adMailState,input.adMailZip5 + input.adMailZip4,input.adMailCntry).ifAddressExists,'M','')
																							);
				self.corp_address1_type_desc    := if(MailingOnly = 'N'
																							,if (Corp2_Mapping.fAddressExists(state_origin,state_desc,corp1str,'',input.adCity,input.adState,input.adZip5 + input.adZip4,input.adCntry).ifAddressExists,'BUSINESS','')
																							,if (Corp2_Mapping.fAddressExists(state_origin,state_desc,input.adMailStr1,input.adMailStr2 + input.adMailStr3,input.adMailCity,input.adMailState,input.adMailZip5 + input.adMailZip4,input.adMailCntry).ifAddressExists,'MAILING','')
																							);
				self.corp_address1_line1        := if(MailingOnly = 'N'
																							,Corp2_Mapping.fCleanAddress (state_origin,state_desc,corp1str,'',input.adCity,input.adState,input.adZip5 + input.adZip4,input.adCntry).AddressLine1
																							,Corp2_Mapping.fCleanAddress (state_origin,state_desc,corp2str,'',input.adMailCity,input.adMailState,input.adMailZip5 + input.adMailZip4,input.adMailCntry).AddressLine1
																							);
				self.corp_address1_line2        := if(MailingOnly = 'N'
																							,Corp2_Mapping.fCleanAddress (state_origin,state_desc,corp1str,'',input.adCity,input.adState,input.adZip5 + input.adZip4,input.adCntry).AddressLine2
																							,Corp2_Mapping.fCleanAddress (state_origin,state_desc,corp2str,'',input.adMailCity,input.adMailState,input.adMailZip5 + input.adMailZip4,input.adMailCntry).AddressLine2
																							);				
				self.corp_address1_line3        := if(MailingOnly = 'N'
																							,Corp2_Mapping.fCleanAddress (state_origin,state_desc,corp1str,'',input.adCity,input.adState,input.adZip5 + input.adZip4,input.adCntry).AddressLine3
																							,Corp2_Mapping.fCleanAddress (state_origin,state_desc,corp2str,'',input.adMailCity,input.adMailState,input.adMailZip5 + input.adMailZip4,input.adMailCntry).AddressLine3
																							);	
				self.corp_prep_addr1_line1        := if(MailingOnly = 'N'
																							,Corp2_Mapping.fCleanAddress (state_origin,state_desc,corp1str,'',input.adCity,input.adState,input.adZip5,input.adCntry).PrepAddrLine1
																							,Corp2_Mapping.fCleanAddress (state_origin,state_desc,corp2str,'',input.adMailCity,input.adMailState,input.adMailZip5,input.adMailCntry).PrepAddrLine1
																							);	
				self.corp_prep_addr1_last_line        := if(MailingOnly = 'N'
																							,Corp2_Mapping.fCleanAddress (state_origin,state_desc,corp1str,'',input.adCity,input.adState,input.adZip5,input.adCntry).PrepAddrLastLine
																							,Corp2_Mapping.fCleanAddress (state_origin,state_desc,corp2str,'',input.adMailCity,input.adMailState,input.adMailZip5,input.adMailCntry).PrepAddrLastLine
																							);																							
				
				self.corp_address2_type_cd      := if(MailingOnly = 'N' ,if (Corp2_Mapping.fAddressExists(state_origin,state_desc,input.adMailStr1,input.adMailStr2 + input.adMailStr3,input.adMailCity,input.adMailState,input.adMailZip5 + input.adMailZip4,input.adMailCntry).ifAddressExists,'M','') ,'');	
				self.corp_address2_type_desc    := if(MailingOnly = 'N' ,if (Corp2_Mapping.fAddressExists(state_origin,state_desc,input.adMailStr1,input.adMailStr2 + input.adMailStr3,input.adMailCity,input.adMailState,input.adMailZip5 + input.adMailZip4,input.adMailCntry).ifAddressExists,'MAILING','') ,'');
				self.corp_address2_line1			  := if(MailingOnly = 'N' ,Corp2_Mapping.fCleanAddress (state_origin,state_desc,corp2str,'',input.adMailCity,input.adMailState,input.adMailZip5 + input.adMailZip4,input.adMailCntry).AddressLine1 ,'');
				self.corp_address2_line2				:= if(MailingOnly = 'N' ,Corp2_Mapping.fCleanAddress (state_origin,state_desc,corp2str,'',input.adMailCity,input.adMailState,input.adMailZip5 + input.adMailZip4,input.adMailCntry).AddressLine2 ,'');
				self.corp_address2_line3				:= if(MailingOnly = 'N' ,Corp2_Mapping.fCleanAddress (state_origin,state_desc,corp2str,'',input.adMailCity,input.adMailState,input.adMailZip5 + input.adMailZip4,input.adMailCntry).AddressLine3 ,'');			
				self.corp_prep_addr2_line1			:= if(MailingOnly = 'N' ,Corp2_Mapping.fCleanAddress (state_origin,state_desc,corp2str,'',input.adMailCity,input.adMailState,input.adMailZip5,input.adMailCntry).PrepAddrLine1 ,'');			
				self.corp_prep_addr2_last_line	:= if(MailingOnly = 'N' ,Corp2_Mapping.fCleanAddress (state_origin,state_desc,corp2str,'',input.adMailCity,input.adMailState,input.adMailZip5,input.adMailCntry).PrepAddrLastLine ,'');
							
        rastr := Corp2_Raw_CT.Functions.FixStreet(input.normRAAddr1,input.normRAAddr2,input.normRAAddr3);				
				self.corp_ra_address_type_cd    := if (Corp2_Mapping.fAddressExists(state_origin,state_desc,rastr,'',input.normRACity,input.normRAState,input.normRAZip5 + input.normRAZip4,input.normRACountry).ifAddressExists,input.normRAAddrType,'');
				self.corp_ra_address_type_desc  := if (Corp2_Mapping.fAddressExists(state_origin,state_desc,rastr,'',input.normRACity,input.normRAState,input.normRAZip5 + input.normRAZip4,input.normRACountry).ifAddressExists,input.normRAAddrDesc,'');
				self.corp_ra_address_line1		  := Corp2_Mapping.fCleanAddress (state_origin,state_desc,rastr,'',input.normRACity,input.normRAState,input.normRAZip5 + input.normRAZip4,input.normRACountry).AddressLine1;
				self.corp_ra_address_line2		  := Corp2_Mapping.fCleanAddress (state_origin,state_desc,rastr,'',input.normRACity,input.normRAState,input.normRAZip5 + input.normRAZip4,input.normRACountry).AddressLine2;
				self.corp_ra_address_line3		  := Corp2_Mapping.fCleanAddress (state_origin,state_desc,rastr,'',input.normRACity,input.normRAState,input.normRAZip5 + input.normRAZip4,input.normRACountry).AddressLine3;			
				self.ra_prep_addr_line1					:= Corp2_Mapping.fCleanAddress (state_origin,state_desc,rastr,'',input.normRACity,input.normRAState,input.normRAZip5,input.normRACountry).PrepAddrLine1;			
				self.ra_prep_addr_last_line 		:= Corp2_Mapping.fCleanAddress (state_origin,state_desc,rastr,'',input.normRACity,input.normRAState,input.normRAZip5,input.normRACountry).PrepAddrLastLine;

				self.corp_country_of_formation  := Corp2_Raw_CT.Functions.Decode_Country(input.cdPlOfForm);
				self.corp_forgn_state_cd				:= if (corp2.t2u(input.cdPlOfForm) not in [state_origin,''] ,corp2.t2u(input.cdPlOfForm) ,'');
				self.corp_forgn_state_desc			:= if(self.corp_forgn_state_cd <> ''
																							,Corp2_Raw_CT.Functions.GetStateDesc(self.corp_forgn_state_cd) ,'');
				self.corp_home_state_name       := corp2.t2u(input.nmForeign);																			
				self 														:= [];
			end;
			
			mapForStat				:= project(jTempLay_ForStatWithMaster,  corpForStatTrf(left));
			
			//-----------------------------------------		  
			// Map BUSRESERVE input file to MAIN
			//-----------------------------------------	
			jBusReserve := join(	BusReserve, NormBusMaster,
														corp2.t2u(left.idBus) = corp2.t2u(right.idBus),
														transform(Corp2_Raw_CT.Layouts.TempLay_BusResvWithMaster, self := left; self := right;),
														left outer, local);	
																			
			Corp2_Mapping.LayoutsCommon.Main corpReserveTrf(Corp2_Raw_CT.Layouts.TempLay_BusResvWithMaster input) := transform
										,skip(corp2.t2u(input.nmNameExp) in ['','TEST TEST 123'] or input.idBus='0000000')
				self.corp_key										:= state_fips + '-' + corp2.t2u(input.idBus);
				self.corp_orig_sos_charter_nbr	:= corp2.t2u(input.idBus);
				self.corp_legal_name						:= Corp2_Mapping.fCleanBusinessName(state_origin,state_desc,input.nmNameExp).BusinessName;
				self.corp_ln_name_type_cd				:= '07';
				self.corp_ln_name_type_desc			:= 'RESERVED'; 
				self.corp_name_reservation_expiration_date := Corp2_Mapping.fValidateDate(input.dtExp,'CCYYMMDD').GeneralDate;
				// The following three field mappings are retained from the old mapper
			  self.corp_term_exist_exp				:= Corp2_Mapping.fValidateDate(input.dtExp,'CCYYMMDD').GeneralDate;
				self.corp_term_exist_cd					:= if(self.corp_term_exist_exp <> '', 'D', '');
				self.corp_term_exist_desc				:= if(self.corp_term_exist_cd = 'D', 'EXPIRATION DATE', '');
				self.corp_inc_date              := if (corp2.t2u(input.cdSubType) in domestic or 
																							 (corp2.t2u(input.cdSubType) = 'C' and corp2.t2u(input.cdPlOfForm) in [state_origin,'']) 
																							 ,Corp2_Mapping.fValidateDate(input.dtOrigin,'CCYYMMDD').PastDate ,'');																			 
				self.corp_forgn_date            := if (corp2.t2u(input.cdSubType) in foreign or 
																							 (corp2.t2u(input.cdSubType) = 'C' and corp2.t2u(input.cdPlOfForm) not in [state_origin,''])
				                                       ,Corp2_Mapping.fValidateDate(input.dtOrigin,'CCYYMMDD').PastDate ,'');
				self 														:= [];
			end; 
			
			mapReserve := project(jBusReserve, corpReserveTrf(left));
			
			//-----------------------------------------		  
			// Map NAMECHG input file to MAIN
			//-----------------------------------------	
			jNameChg :=     join(	NameChg, NormBusMaster,
														corp2.t2u(left.idBus) = corp2.t2u(right.idBus),
														transform(Corp2_Raw_CT.Layouts.TempLay_NameChgWithMaster, self := left; self := right;),
														left outer, local);	
														
			Corp2_Mapping.LayoutsCommon.Main NameChgTrf(Corp2_Raw_CT.Layouts.TempLay_NameChgWithMaster input) := transform
								,skip(corp2.t2u(input.nmOld) in ['','TEST TEST 123'] or input.idBus='0000000')
				self.corp_key										:= state_fips + '-' + corp2.t2u(input.idBus);
				self.corp_orig_sos_charter_nbr	:= corp2.t2u(input.idBus);
				self.corp_legal_name						:= Corp2_Mapping.fCleanBusinessName(state_origin,state_desc,input.nmOld).BusinessName;
				self.corp_ln_name_type_cd				:= 'I';
				self.corp_ln_name_type_desc			:= 'OLD NAME';
				self.corp_name_status_date      := Corp2_Mapping.fValidateDate(input.dtChanged,'CCYYMMDD').PastDate;
				self.corp_name_status_desc      := if (self.corp_name_status_date <> '' ,'DATE NAME CHANGED' ,'');
				self.corp_inc_date              := if (corp2.t2u(input.cdSubType) in domestic or 
																							 (corp2.t2u(input.cdSubType) = 'C' and corp2.t2u(input.cdPlOfForm) in [state_origin,'']) 
																							   ,Corp2_Mapping.fValidateDate(input.dtOrigin,'CCYYMMDD').PastDate ,'');																			 
				self.corp_forgn_date            := if (corp2.t2u(input.cdSubType) in foreign or 
																							 (corp2.t2u(input.cdSubType) = 'C' and corp2.t2u(input.cdPlOfForm) not in [state_origin,''])
				                                       ,Corp2_Mapping.fValidateDate(input.dtOrigin,'CCYYMMDD').PastDate ,'');
				self 														:= [];
		  end; 		
		
		 mapNameChg	:= project(jNameChg, NameChgTrf(left));
		
		//---------- End CORP Mapping --------------------------------------------------------------//
		
    		
		//---------- Begin CONT Mapping --------------------------------------------------------------//		
			
			//-----------------------------------------		  
			// Map PRNCIPAL input file to MAIN
			//-----------------------------------------	
			// Join PRNCIPAL with BUSMASTER to get corporation name for corp_legal_name 
			jPrinc2CorpName	:= join(Prncipal,NormBusMaster,
															corp2.t2u(left.idBus) = corp2.t2u(right.idBus),
															transform(Corp2_Raw_CT.Layouts.TempLay_OfficerLayout, self.nmCorpName := right.nmName; self := left; self := right;),
															left outer, local);
	
			// Denormalize to get all titles in one record  
			sortOffFile		:= sort(jPrinc2CorpName,idBus,nmName,adBusStr1);		
			distofficers 	:= distribute(sortOffFile,hash(idBus,nmName,adBusStr1));

			Corp2_Raw_CT.Layouts.TempLay_OfficerLayout DenormOfficers(Corp2_Raw_CT.Layouts.TempLay_OfficerLayout L, Corp2_Raw_CT.Layouts.TempLay_OfficerLayout R, INTEGER C) := TRANSFORM
				self.txTitle1 	:= IF (C=1, R.txTitle,L.txTitle1);                  
				self.txTitle2		:= IF (C=2, R.txTitle,L.txTitle2);
				self.txTitle3		:= IF (C=3, R.txTitle,L.txTitle3); 
				self.txTitle4		:= IF (C=4, R.txTitle,L.txTitle4); 
				self.txTitle5		:= IF (C=5, R.txTitle,L.txTitle5); 
				self 						:= L;
			END;
	
			dedupNewOfficerFile := dedup(sort(distofficers,idBus,nmName,adBusStr1,txTitle), idBus,nmName,adBusStr1,txTitle);
					
			DenormalizedFile := sort(denormalize(dedupNewOfficerFile, dedupNewOfficerFile,
																					corp2.t2u(left.idBus) 		= corp2.t2u(right.idBus) and
																					corp2.t2u(left.nmName) 		= corp2.t2u(right.nmName) and
																					corp2.t2u(left.adBusStr1) = corp2.t2u(right.adBusStr1) and
																					corp2.t2u(left.adResStr1) = corp2.t2u(right.adResStr1),
																					DenormOfficers(left,right,COUNTER)),
																idBus,nmName,adBusStr1,adResStr1,txTitle);
		
			ContactsLegal := dedup(DenormalizedFile, RECORD, EXCEPT idSeqNbr, dtTermEnd, dtTermStr, txTitle, nmCorpName);	
		
			//Normalize the ContactsLegal file on both Contact Addresses:  Business & Residential
			Corp2_Raw_CT.Layouts.TempLay_OfficerLayout normContacts(Corp2_Raw_CT.Layouts.TempLay_OfficerLayout l, unsigned1 cnt) := transform
           ,skip(cnt=2 and corp2.t2u(l.adResStr1 + l.adResStr2 + l.adResStr3 + l.adResCity + l.adResState + l.adResZip5) = '')				
				self.normAddr1		:= choose(cnt ,l.adBusStr1  ,l.adResStr1 );
				self.normAddr2	 	:= choose(cnt ,l.adBusStr2  ,l.adResStr2 );
				self.normAddr3		:= choose(cnt ,l.adBusStr3  ,l.adResStr3 );
				self.normCity			:= choose(cnt ,l.adBusCity  ,l.adResCity );
				self.normState		:= choose(cnt ,l.adBusState ,l.adResState);		
				self.normZip5			:= choose(cnt ,l.adBusZip5  ,l.adResZip5 );
				self.normZip4			:= choose(cnt ,l.adBusZip4  ,l.adResZip4 );
				self.normCountry	:= choose(cnt ,l.adBusCntry ,l.adResCntry);
				self.normAddrType	:= choose(cnt ,'B'          ,'C');
				self.normAddrDesc	:= choose(cnt ,'BUSINESS'   ,'RESIDENTIAL');			
				self 						  := l;
			end;

			NormContactsLegal	:= normalize(ContactsLegal, 2, normContacts(left, counter));	
		
			Corp2_Mapping.LayoutsCommon.Main ContLegalTrf(Corp2_Raw_CT.Layouts.TempLay_OfficerLayout input) := transform
							,skip(corp2.t2u(input.nmCorpName) in ['','TEST TEST 123'] or input.idBus='0000000' or
							      corp2.t2u(input.nmName) in ['','X'])
				self.corp_key										:= state_fips + '-' + corp2.t2u(input.idBus);
				self.corp_orig_sos_charter_nbr	:= corp2.t2u(input.idBus);				
			  self.corp_legal_name						:= Corp2_Mapping.fCleanBusinessName(state_origin,state_desc,input.nmCorpName).BusinessName; 
				self.cont_type_cd               := 'F';
				self.cont_type_desc             := 'OFFICER';
				self.cont_full_name							:= Corp2_Mapping.fCleanBusinessName(state_origin,state_desc,input.nmName).BusinessName; 
				
				concatFields										:= 	corp2.t2u(input.txTitle1) + ';' + 
																						corp2.t2u(input.txTitle2) + ';' +  
																						corp2.t2u(input.txTitle3) + ';' + 
																						corp2.t2u(input.txTitle4) + ';' + 
																						corp2.t2u(input.txTitle5);
			  tempExp													:= regexreplace('[;]*$',concatFields,'',NOCASE);
				tempExp2												:= regexreplace('^[;]*',tempExp,'',NOCASE);
				self.cont_title1_desc           := regexreplace('[;]+',tempExp2,';',NOCASE);  
			  
				contstr := Corp2_Raw_CT.Functions.FixStreet(input.normAddr1,input.normAddr2,input.normAddr3);
				self.cont_address_type_cd       := if (Corp2_Mapping.fAddressExists(state_origin,state_desc,contstr,'',input.normCity,input.normState,input.normZip5 + input.normZip4,input.normCountry).ifAddressExists,input.normAddrType,'');
				self.cont_address_type_desc     := if (Corp2_Mapping.fAddressExists(state_origin,state_desc,contstr,'',input.normCity,input.normState,input.normZip5 + input.normZip4,input.normCountry).ifAddressExists,input.normAddrDesc,'');
				self.cont_address_line1			    := Corp2_Mapping.fCleanAddress(state_origin,state_desc,contstr,'',input.normCity,input.normState,input.normZip5 + input.normZip4,input.normCountry).AddressLine1;
				self.cont_address_line2			    := Corp2_Mapping.fCleanAddress(state_origin,state_desc,contstr,'',input.normCity,input.normState,input.normZip5 + input.normZip4,input.normCountry).AddressLine2;
				self.cont_address_line3			    := Corp2_Mapping.fCleanAddress(state_origin,state_desc,contstr,'',input.normCity,input.normState,input.normZip5 + input.normZip4,input.normCountry).AddressLine3;
				self.cont_prep_addr_line1			  := Corp2_Mapping.fCleanAddress(state_origin,state_desc,contstr,'',input.normCity,input.normState,input.normZip5,input.normCountry).PrepAddrLine1;
				self.cont_prep_addr_last_line	  := Corp2_Mapping.fCleanAddress(state_origin,state_desc,contstr,'',input.normCity,input.normState,input.normZip5,input.normCountry).PrepAddrLastLine;
				self.cont_effective_date				:= Corp2_Mapping.fValidateDate(input.dtTermStr,'CCYYMMDD').GeneralDate;
				self.cont_effective_cd          := if (self.cont_effective_date <> '', 'S', '');
				self.cont_effective_desc        := if (self.cont_effective_date <> '', 'TERM START DATE', '');
				self.recordOrigin               := 'T';																					
				self 														:= [];
	  end;	
		
		mapLegalCont		:= project(NormContactsLegal, ContLegalTrf(left));
		
		//-----------------------------------------		  
		// Map BUSRESERVE input file to MAIN
		//-----------------------------------------
		Corp2_Mapping.LayoutsCommon.Main ContReserveTrf(Corp2_Raw_CT.Layouts.BusReserveLayoutIN input) := transform
								,skip(corp2.t2u(input.nmApplc)='' or corp2.t2u(input.nmNameExp) in ['','TEST TEST 123'] or input.idBus='0000000'or
							      corp2.t2u(input.nmApplc) = '')
				self.corp_key									  := state_fips + '-' + corp2.t2u(input.idBus);
				self.corp_orig_sos_charter_nbr	:= corp2.t2u(input.idBus);				
				self.corp_legal_name						:= Corp2_Mapping.fCleanBusinessName(state_origin,state_desc,input.nmNameExp).BusinessName;
				self.cont_type_cd							  := '01';
				self.cont_type_desc						  := 'RESERVER';
				self.cont_full_name						  := Corp2_Mapping.fCleanBusinessName(state_origin,state_desc,input.nmApplc).BusinessName;	
				
				contstr := Corp2_Raw_CT.Functions.FixStreet(input.adStr1,input.adStr2,input.adStr3);
				self.cont_address_type_cd       := if (Corp2_Mapping.fAddressExists(state_origin,state_desc,contstr,'',input.adCity,input.adState,input.adZip5 + input.adZip4,input.adCntry).ifAddressExists,'T','');
				self.cont_address_type_desc     := if (Corp2_Mapping.fAddressExists(state_origin,state_desc,contstr,'',input.adCity,input.adState,input.adZip5 + input.adZip4,input.adCntry).ifAddressExists,'CONTACT','');
				self.cont_address_line1			    := Corp2_Mapping.fCleanAddress(state_origin,state_desc,contstr,'',input.adCity,input.adState,input.adZip5 + input.adZip4,input.adCntry).AddressLine1;
				self.cont_address_line2			    := Corp2_Mapping.fCleanAddress(state_origin,state_desc,contstr,'',input.adCity,input.adState,input.adZip5 + input.adZip4,input.adCntry).AddressLine2;
				self.cont_address_line3			    := Corp2_Mapping.fCleanAddress(state_origin,state_desc,contstr,'',input.adCity,input.adState,input.adZip5 + input.adZip4,input.adCntry).AddressLine3;
				self.cont_prep_addr_line1			  := Corp2_Mapping.fCleanAddress(state_origin,state_desc,contstr,'',input.adCity,input.adState,input.adZip5,input.adCntry).PrepAddrLine1;
				self.cont_prep_addr_last_line	  := Corp2_Mapping.fCleanAddress(state_origin,state_desc,contstr,'',input.adCity,input.adState,input.adZip5,input.adCntry).PrepAddrLastLine;
				self.recordOrigin               := 'T';
				self 														:= [];
		end;	
		
		mapReserveCont  := project(BusReserve, ContReserveTrf(left));
			
		//---------- End CONT Mapping --------------------------------------------------------------//
		
		//-----------------------------------------		  
		// Map Constant fields on all MAIN records
		//-----------------------------------------
		Corp2_Mapping.LayoutsCommon.Main ConstantTrf(Corp2_Mapping.LayoutsCommon.Main input) := transform
				self.dt_first_seen							:= (integer)fileDate;
				self.dt_last_seen								:= (integer)fileDate;
				self.dt_vendor_first_reported		:= (integer)fileDate;
				self.dt_vendor_last_reported		:= (integer)fileDate;
				self.corp_ra_dt_first_seen			:= (integer)fileDate;
				self.corp_ra_dt_last_seen				:= (integer)fileDate;	
				self.corp_vendor								:= state_fips;
				self.corp_state_origin					:= state_origin;
				self.corp_inc_state             := state_origin;
				self.corp_process_date					:= fileDate;
				self.recordOrigin               := if (input.recordOrigin = 'T', 'T', 'C');
        self                            := input;				
				self 														:= [];
		end;	
		
		//---------- End MAIN Mapping --------------------------------------------------------------//

		
		//---------- Begin EVENTS Mapping ----------------------------------------------------------//
		
		//--------------------------------------------------		  
		// Map BUSFILING and FILMINDX input files to EVENTS
		//--------------------------------------------------
		
		//Normalize the BusFiling file on both event dates:  Effective Date and Filing Date
		Corp2_Raw_CT.Layouts.normalizedBusFiling normBusFil(Corp2_Raw_CT.Layouts.BusFilingLayoutIN l, unsigned1 cnt) := transform
					,skip ((cnt = 1 and Corp2_Mapping.fValidateDate(l.dtEffect,'CCYYMMDD').PastDate = '') or
								 (cnt = 2 and Corp2_Mapping.fValidateDate(l.dtFiling,'CCYYMMDD').PastDate = '') or
								 (cnt = 2 and l.dtFiling = l.dtEffect))
				self.normEventDate	:= choose(cnt ,l.dtEffect ,l.dtFiling );
				self.normType      	:= choose(cnt ,'E'        ,'F');
				self 						    := l;
			end;

			NormBusFiling	:= normalize(BusFiling, 2, normBusFil(left, counter));		
			
			NormBusFilingDist	 := distribute(NormBusFiling,  hash(idBusFlng));
 			
		  jNormBusFilingDist	:= join(NormBusFilingDist, FilmIndx, 
														corp2.t2u(left.idBusFlng) = corp2.t2u(right.idFlngNbr) , 
														transform(Corp2_Raw_CT.Layouts.TempLay_FilmIndxWithBusFiling, self := left; self := right;),
														left outer, local);
		
		Corp2_Mapping.LayoutsCommon.Events EventFilingTrf(Corp2_Raw_CT.Layouts.TempLay_FilmIndxWithBusFiling input):=transform
					,skip(corp2.t2u(input.cdTransType) in ['CFRN','CFRS','CRLC','CRLCF','CRLLP','CRLLPF','CRLP','CRLPF','CRN','CRS']
					      or input.idBus in ['','0000000'])
			self.corp_key											:= state_fips + '-' + corp2.t2u(input.idBus);	
			self.corp_sos_charter_nbr	        := corp2.t2u(input.idBus);
			self.corp_vendor									:= state_fips;		
			self.corp_state_origin						:= state_origin;
			self.corp_process_date						:= fileDate;
			self.event_filing_date						:= Corp2_Mapping.fValidateDate(input.normEventDate,'CCYYMMDD').PastDate;
      self.event_date_type_cd           := case(input.normType, 'E' => 'EFF'      , 'F' => 'FIL', '');
			self.event_date_type_desc         := case(input.normType, 'E' => 'EFFECTIVE', 'F' => 'FILING', '');																				 
			self.event_filing_cd              := corp2.t2u(input.cdtranstype);
		  self.event_filing_desc						:= corp2.t2u(input.txCertif);
			self.event_filing_reference_nbr		:= corp2.t2u(input.idBusFlng);
			self.event_book_nbr               := corp2.t2u(input.cdVolume);	
			self.event_frame									:= corp2.t2u(input.cdVolume); // retaining from old mapper because event_book_nbr is a new field
	    self.event_microfilm_nbr					:= corp2.t2u(input.idImgObj);
			self.event_page_nbr               := corp2.t2u(input.cdStartPage);
			self.event_start									:= corp2.t2u(input.cdStartPage); // retaining from old mapper because event_page_nbr is a new field
			self.event_roll										:= corp2.t2u(input.idImgFldr); 
			self															:=[];
	  end;		
    
		mapEventMain		:= project(jNormBusFilingDist, EventFilingTrf(left));
		
		//-----------------------------------------		  
		// Map NAMECHG input file to EVENTS
		//-----------------------------------------
		Corp2_Mapping.LayoutsCommon.Events EventNameChgTrf(Corp2_Raw_CT.Layouts.NameChgLayoutIN input):=transform
						,skip((input.nmOld='' and input.dtChanged='' and input.idBusFlng='') or input.idBus in ['','0000000'])
			self.corp_key											:= state_fips + '-' + corp2.t2u(input.idBus);	
			self.corp_sos_charter_nbr	        := corp2.t2u(input.idBus);
			self.corp_vendor									:= state_fips;		
			self.corp_state_origin						:= state_origin;
			self.corp_process_date						:= fileDate;
      self.event_desc                   := if(input.nmOld <> '' and input.nmNew <> ''
		                                          ,'NAME CHANGED FROM ' + corp2.t2u(input.nmOld) + ' TO ' + corp2.t2u(input.nmNew)
																							,'');
			self.event_filing_date						:= Corp2_Mapping.fValidateDate(input.dtChanged,'CCYYMMDD').PastDate;
			self.event_filing_desc						:= 'NAME CHANGE';
			self.event_filing_reference_nbr		:= corp2.t2u(input.idBusFlng);
			self															:=[];
		end;
		
		mapEventNameChg	:= project(NameChg, EventNameChgTrf(left));
		
		//-----------------------------------------		  
		// Map BUSMERGER input file to EVENTS
		//-----------------------------------------
		// CI doesn't say to do this mapping below.  These fields are now being mapped in the CORP record 
		// in corp_merger_merged_corporation_id, corp_merger_id, and corp_merger_desc.  But since those
		// are new fields in the layout, we need to keep this mapping in place.
		Corp2_Mapping.LayoutsCommon.Events EventMergerTrf(Corp2_Raw_CT.Layouts.BusMergerLayoutIN input):= transform
		     ,skip(input.idSurvBus in ['','0000000'])
			self.corp_key											:= state_fips + '-' + corp2.t2u(input.idSurvBus);	
			self.corp_sos_charter_nbr	        := corp2.t2u(input.idSurvBus);
			self.corp_vendor									:= state_fips;		
			self.corp_state_origin						:= state_origin;
			self.corp_process_date						:= fileDate;
    	self.event_filing_date						:= Corp2_Mapping.fValidateDate(input.dtFiling,'CCYYMMDD').PastDate;
			self.event_filing_reference_nbr		:= corp2.t2u(input.idBusFlng);
			self.event_filing_desc						:= map(corp2.t2u(input.idSurvBus) <> '' and corp2.t2u(input.idTermBus) <> '' => 
																								   'SURVIVING CORPORATION: ' + corp2.t2u(input.idSurvBus) + '; MERGED CORPORATION: ' + corp2.t2u(input.idTermBus),
																							 corp2.t2u(input.idSurvBus) <> '' => 'SURVIVING CORPORATION: ' + corp2.t2u(input.idSurvBus),
																							 corp2.t2u(input.idTermBus) <> '' => 'MERGED CORPORATION: ' + corp2.t2u(input.idTermBus),
																								'');
      self.event_date_type_cd						:= 'MER';
			self.event_date_type_desc					:= 'MERGER';
			self															:= [];
	  end;		
	  
		mapEventMerger	:= project(BusMerger, EventMergerTrf(left));
	
	
		//-----------------------------------------		  
		// Map BUSOTHER input file to EVENTS
		//-----------------------------------------
		Corp2_Mapping.LayoutsCommon.Events EventBusOtherTrf(Corp2_Raw_CT.Layouts.BusOtherLayoutIN input):=transform
						,skip(Corp2_Mapping.fValidateDate(input.dtOrgMtg,'CCYYMMDD').GeneralDate = '' or input.idBus in ['','0000000'])
			self.corp_key											:= state_fips + '-' + corp2.t2u(input.idBus);	
			self.corp_sos_charter_nbr	        := corp2.t2u(input.idBus);
			self.corp_vendor									:= state_fips;		
			self.corp_state_origin						:= state_origin;
			self.corp_process_date						:= fileDate;
			self.event_filing_date            := Corp2_Mapping.fValidateDate(input.dtOrgMtg,'CCYYMMDD').GeneralDate;
			self.event_filing_desc            := 'ORG REPORT';
      self															:=[];
		end;
		
		mapEventBusOther	:= project(BusOther, EventBusOtherTrf(left));		
		
		//-----------------------------------------		  
		// Map CORP input file to EVENTS
		//-----------------------------------------
		Corp2_Mapping.LayoutsCommon.Events EventCorpTrf(Corp2_Raw_CT.Layouts.CorpsLayoutIN input):=transform
						,skip(Corp2_Mapping.fValidateDate(input.dtOrgMtg,'CCYYMMDD').GeneralDate = '' or input.idBus in ['','0000000'])
			self.corp_key											:= state_fips + '-' + corp2.t2u(input.idBus);	
			self.corp_sos_charter_nbr	        := corp2.t2u(input.idBus);
			self.corp_vendor									:= state_fips;		
			self.corp_state_origin						:= state_origin;
			self.corp_process_date						:= fileDate;
			self.event_filing_date            := Corp2_Mapping.fValidateDate(input.dtOrgMtg,'CCYYMMDD').GeneralDate;
			self.event_filing_desc            := 'ORG REPORT';
      self															:=[];
		end;
		
		mapEventCorp	:= project(Corps, EventCorpTrf(left));
		
		//---------- End Events Mapping --------------------------------------------------------------//
		
		
		//---------- Begin AR Mapping ----------------------------------------------------------------//
		
		//-----------------------------------------		  
		// Map BUSFILING input file to AR
		//-----------------------------------------
		Corp2_Mapping.LayoutsCommon.AR ARFilingTrf(Corp2_Raw_CT.Layouts.BusFilingLayoutIN input):=transform
						,skip(corp2.t2u(input.cdTransType) not in ['CFRN','CFRS','CRLC','CRLCF','CRLLP',
																														 'CRLLPF','CRLP','CRLPF','CRN','CRS'] 
																														 or input.idBus in ['','0000000'])
			self.corp_key											:= state_fips + '-' + corp2.t2u(input.idBus);	
			self.corp_sos_charter_nbr	        := corp2.t2u(input.idBus);
			self.corp_vendor									:= state_fips;		
			self.corp_state_origin						:= state_origin;
			self.corp_process_date						:= fileDate;
		  		
			yrIndex														:= StringLib.StringFind(input.txCertif,'(', 1);
			self.ar_year											:= if (yrIndex <> 0, corp2.t2u(input.txCertif)[yrIndex+1..yrIndex+4],'');
			self.ar_comment                   := if (self.ar_year <> '', 'ANNUAL REPORT', '');
			self.ar_filed_dt									:= Corp2_Mapping.fValidateDate(input.dtFiling,'CCYYMMDD').PastDate; // retained from old mapper
			self.ar_report_nbr								:= corp2.t2u(input.idBusFlng); // retained from old mapper
			self															:=[];
		end;		
		
		mapARFiling			:= project(BusFiling, ARFilingTrf(left));
		
		//-----------------------------------------		  
		// Map CORPS input file to AR
		//-----------------------------------------
		Corp2_Mapping.LayoutsCommon.AR ARCorpTrf(Corp2_Raw_CT.Layouts.CorpsLayoutIN input):=transform
						,skip((Corp2_Mapping.fValidateDate(input.dtRptDue,'CCYYMMDD').GeneralDate = '' and corp2.t2u(input.dtOrgMtg)='')
						          or input.idBus in ['','0000000'])
			self.corp_key											:= state_fips + '-' + corp2.t2u(input.idBus);	
			self.corp_sos_charter_nbr	        := corp2.t2u(input.idBus);
			self.corp_vendor									:= state_fips;		
			self.corp_state_origin						:= state_origin;
			self.corp_process_date						:= fileDate;
  		self.ar_due_dt										:= Corp2_Mapping.fValidateDate(input.dtRptDue,'CCYYMMDD').GeneralDate;
			self.ar_comment										:=	if (Corp2_Mapping.fValidateDate(input.dtOrgMtg,'CCYYMMDD').GeneralDate <> ''
																							  ,'ORGANIZATION MEETING: ' + input.dtOrgMtg[5..6] +'/'+ input.dtOrgMtg[7..8] +'/'+ input.dtOrgMtg[1..4],''); 
  		self															:=[];
		end;		
		
		mapARCorp				:= project(Corps,  ARCorpTrf(left));
		
		//-----------------------------------------		  
		// Map DLMTPART input file to AR
		//-----------------------------------------
		Corp2_Mapping.LayoutsCommon.AR ARDLMTPartTrf(Corp2_Raw_CT.Layouts.DlmtPartLayoutIN input):=transform
											,skip(Corp2_Mapping.fValidateDate(input.dtRptDue,'CCYYMMDD').GeneralDate = '' or input.idBus in ['','0000000'])
			self.corp_key											:= state_fips + '-' + corp2.t2u(input.idBus);	
			self.corp_sos_charter_nbr	        := corp2.t2u(input.idBus);
			self.corp_vendor									:= state_fips;		
			self.corp_state_origin						:= state_origin;
			self.corp_process_date						:= fileDate;
			self.ar_due_dt										:= Corp2_Mapping.fValidateDate(input.dtRptDue,'CCYYMMDD').GeneralDate;
			self															:=[];
		end;						
		
		mapARDLMTPart		:= project(DLMTPart,  ARDLMTPartTrf(left));		
		
		//-----------------------------------------		  
		// Map FLMTPART input file to AR
		//-----------------------------------------
		Corp2_Mapping.LayoutsCommon.AR ARFLMTPartTrf(Corp2_Raw_CT.Layouts.FlmtPartLayoutIN input):=transform
											,skip(Corp2_Mapping.fValidateDate(input.dtRptDue,'CCYYMMDD').GeneralDate = '' or input.idBus in ['','0000000'])
			self.corp_key											:= state_fips + '-' + corp2.t2u(input.idBus);	
			self.corp_sos_charter_nbr	        := corp2.t2u(input.idBus);
			self.corp_vendor									:= state_fips;		
			self.corp_state_origin						:= state_origin;
			self.corp_process_date						:= fileDate;
		  self.ar_due_dt										:= Corp2_Mapping.fValidateDate(input.dtRptDue,'CCYYMMDD').GeneralDate;
  		self															:=[];
		end;	
		
		mapARFLMTPart		:= project(FLMTPart,  ARFLMTPartTrf(left));
		
		//-----------------------------------------		  
		// Map DLMTCORP input file to AR
		//-----------------------------------------
		Corp2_Mapping.LayoutsCommon.AR ARDLMTCorpTrf(Corp2_Raw_CT.Layouts.DlmtCorpLayoutIN input):=transform
												,skip(Corp2_Mapping.fValidateDate(input.dtRptDue,'CCYYMMDD').GeneralDate = '' or input.idBus in ['','0000000'])
			self.corp_key											:= state_fips + '-' + corp2.t2u(input.idBus);	
			self.corp_sos_charter_nbr	        := corp2.t2u(input.idBus);
			self.corp_vendor									:= state_fips;		
		  self.corp_state_origin						:= state_origin;
			self.corp_process_date						:= fileDate;
			self.ar_due_dt										:= Corp2_Mapping.fValidateDate(input.dtRptDue,'CCYYMMDD').GeneralDate;  
			self															:=[];
		end;	
		
		mapARDLMTCorp		:= project(DLMTCorp,  ARDLMTCorpTrf(left));
		
		//-----------------------------------------		  
		// Map FLMTCORP input file to AR
		//-----------------------------------------
		Corp2_Mapping.LayoutsCommon.AR ARFLMTCorpTrf(Corp2_Raw_CT.Layouts.FlmtCorpLayoutIN input):=transform
											,skip(Corp2_Mapping.fValidateDate(input.dtRptDue,'CCYYMMDD').GeneralDate = '' or input.idBus in ['','0000000'])
			self.corp_key											:= state_fips + '-' + corp2.t2u(input.idBus);	
			self.corp_sos_charter_nbr	        := corp2.t2u(input.idBus);
			self.corp_vendor									:= state_fips;		
			self.corp_state_origin						:= state_origin;
			self.corp_process_date						:= fileDate;
			self.ar_due_dt										:= Corp2_Mapping.fValidateDate(input.dtRptDue,'CCYYMMDD').GeneralDate;  
			self															:=[];
		end;	
		
		mapARFLMTCorp		:= project(FLMTCorp,  ARFLMTCorpTrf(left));
		
		//-----------------------------------------		  
		// Map BUSOTHER input file to AR
		//-----------------------------------------
		Corp2_Mapping.LayoutsCommon.AR ARBusOtherTrf(Corp2_Raw_CT.Layouts.BusOtherLayoutIN input):=transform
									,skip(Corp2_Mapping.fValidateDate(input.dtRptDue,'CCYYMMDD').GeneralDate = '' or input.idBus in ['','0000000'])
			self.corp_key											:= state_fips + '-' + corp2.t2u(input.idBus);	
			self.corp_sos_charter_nbr	        := corp2.t2u(input.idBus);
			self.corp_vendor									:= state_fips;		
			self.corp_state_origin						:= state_origin;
			self.corp_process_date						:= fileDate;
			self.ar_due_dt										:= Corp2_Mapping.fValidateDate(input.dtRptDue,'CCYYMMDD').GeneralDate; 
			self															:=[];
		end;
		
		mapARBusOther		:= project(BusOther,  ARBusOtherTrf(left));
		
		//-----------------------------------------		  
		// Map DLMLPART input file to AR
		//-----------------------------------------
		Corp2_Mapping.LayoutsCommon.AR ARDLMLPartTrf(Corp2_Raw_CT.Layouts.DlmlPartLayoutIN input):=transform
									,skip(Corp2_Mapping.fValidateDate(input.dtRptDue,'CCYYMMDD').GeneralDate = '' or input.idBus in ['','0000000'])
			self.corp_key											:= state_fips + '-' + corp2.t2u(input.idBus);	
			self.corp_sos_charter_nbr	        := corp2.t2u(input.idBus);
			self.corp_vendor									:= state_fips;		
			self.corp_state_origin						:= state_origin;
			self.corp_process_date						:= fileDate;
		  self.ar_due_dt										:= Corp2_Mapping.fValidateDate(input.dtRptDue,'CCYYMMDD').GeneralDate;  
			self															:=[];
		end;		
		
		mapARDLMLPart		:= project(DLMLPart,  ARDLMLPartTrf(left));
		
		//-----------------------------------------		  
		// Map FLMLPART input file to AR
		//-----------------------------------------
		Corp2_Mapping.LayoutsCommon.AR ARFLMLPartTrf(Corp2_Raw_CT.Layouts.FlmlPartLayoutIN input):=transform
											,skip(Corp2_Mapping.fValidateDate(input.dtRptDue,'CCYYMMDD').GeneralDate = '' or input.idBus in ['','0000000'])
			self.corp_key											:= state_fips + '-' + corp2.t2u(input.idBus);	
			self.corp_sos_charter_nbr	        := corp2.t2u(input.idBus);
			self.corp_vendor									:= state_fips;		
			self.corp_state_origin						:= state_origin;
			self.corp_process_date						:= fileDate;
			self.ar_due_dt										:= Corp2_Mapping.fValidateDate(input.dtRptDue,'CCYYMMDD').GeneralDate;  
			self															:=[];
		end;	
		
		mapARFLMLPart		:= project(FLMLPart,  ARFLMLPartTrf(left));	
		
		//---------- End AR Mapping -------------------------------------------------------------------//
		
		//---------- Begin STOCK Mapping --------------------------------------------------------------//
		
		//-----------------------------------------		  
		// Map STOCK input file to STOCK
		//-----------------------------------------
  	Corp2_Mapping.LayoutsCommon.Stock StockTrf(Corp2_Raw_CT.Layouts.StockLayoutIN input):=transform
		      ,skip(input.idBus in ['','0000000'])
			self.corp_key											:= state_fips + '-' + corp2.t2u(input.idBus);	
			self.corp_vendor									:= state_fips;		
			self.corp_state_origin						:= state_origin;
			self.corp_process_date						:= fileDate;
			self.corp_sos_charter_nbr	        := corp2.t2u(input.idBus);
			self.stock_par_value							:= regexreplace(' ',corp2.t2u(input.amParValue),'.',NOCASE);
			self.stock_shares_issued					:= if ((string)(integer)input.amShares <> '0' ,corp2.t2u(input.amShares) ,''); 
		  
			shortenClass := regexreplace('CUMMULATIVE',(regexreplace('CUMULATIVE',(regexreplace('CONVERSION',
			               (regexreplace('CONVERTIBLE',(regexreplace('VOTING',(regexreplace('PREFERRED',
										 (regexreplace('COMMON', corp2.t2u(input.cdShareCls),
										 'COMM.')),'PREF.')),'VOT.')),'CONVERT.')),'CONVERS.')),'CUMUL.')),'CUMUL.');
			
			self.stock_type										:= if (length(corp2.t2u(input.cdShareCls)) < 21
			                                         ,corp2.t2u(input.cdShareCls)
																							 ,shortenClass);
			self															:= [];
		end;
		
		mapStockFile		:= project(Stock, StockTrf(left));
		
		//-----------------------------------------		  
		// Map BUSMASTER input file to STOCK
		//-----------------------------------------
		Corp2_Mapping.LayoutsCommon.Stock StockMasterTrf(Corp2_Raw_CT.Layouts.BusMasterLayoutIN input):=transform
		       ,skip(input.idBus in ['','0000000'] or (integer)input.amTotShares = 0)
		  self.corp_key											:= state_fips + '-' + corp2.t2u(input.idBus);	
			self.corp_sos_charter_nbr	        := corp2.t2u(input.idBus);
			self.corp_vendor									:= state_fips;		
			self.corp_state_origin						:= state_origin;
			self.corp_process_date						:= fileDate;
			self.stock_addl_info              := if (corp2.t2u(input.cdCnvt) = 'C', 'NO DATA FROM CONVERSION', '');
			self.stock_shares_issued					:= corp2.t2u((string)(integer)input.amTotShares); 
			self															:=[];
		end;	
		
		mapStockMaster	:= project(BusMaster, StockMasterTrf(left));
	
		//---------- End STOCK Mapping --------------------------------------------------------------//
		
		//------------------------------------------------------------------------------//
		// Build the Final Mapped Files
		//------------------------------------------------------------------------------//
		mapMain  := dedup(sort(distribute(
								  project(mapCorp     + mapOther     + mapDLMTPart    + mapFLMTPart + 
													mapDLMTCorp + mapFLMTCorp  + mapDLMLPart    + mapFLMLPart +
													mapGeneral  + mapBusMaster + mapForStat     + mapReserve  + 
													mapNameChg  + mapLegalCont + mapReserveCont ,ConstantTrf(left)) 
										,hash(corp_key)), record,local), record,local) : independent;
												
		mapEvent := dedup(sort(distribute(
												mapEventMain     + mapEventNameChg  + mapEventMerger + 
												mapEventBusOther + mapEventCorp
									,hash(corp_key)), record,local), record,local) : independent;											
		
		mapAR		 := dedup(sort(distribute(
												mapARFiling   + mapARCorp        + mapARDLMTPart  + 
												mapARFLMTPart + mapARDLMTCorp    + mapARFLMTCorp  + 
												mapARBusOther + mapARDLMLPart    + mapARFLMLPart
									,hash(corp_key)), record,local), record,local) : independent;
								
		mapStock := dedup(sort(distribute(mapStockFile + mapStockMaster
									,hash(corp_key)), record,local), record,local) : independent;
		
	
  //--------------------------------------------------------------------	
  // Scrubs for MAIN
  //--------------------------------------------------------------------
		Main_F := MapMain;
		Main_S := Scrubs_Corp2_Mapping_CT_Main.Scrubs;        // Scrubs module
		Main_N := Main_S.FromNone(Main_F); 										// Generate the error flags
		Main_T := Main_S.FromBits(Main_N.BitmapInfile);     	// Use the FromBits module; makes my bitmap datafile easier to get to
		Main_U := Main_S.FromExpanded(Main_N.ExpandedInFile); // Pass the expanded error flags into the Expanded module

	//Outputs reports
		Main_ErrorSummary					:= output(Main_U.SummaryStats, named('Main_ErrorSummary_CT'+filedate));
		Main_ScrubErrorReport 		:= output(choosen(Main_U.AllErrors, 1000), named('Main_ScrubErrorReport_CT'+filedate));
		Main_SomeErrorValues			:= output(choosen(Main_U.BadValues, 1000), named('Main_SomeErrorValues_CT'+filedate));
		Main_IsScrubErrors		 		:= IF(count(Main_U.AllErrors)<> 0,true,false);

		// Orbit Stats
		Main_OrbitStats						:= Main_U.OrbitStats();
		
		//Outputs files
		Main_CreateBitMaps				:= output(Main_N.BitmapInfile,,'~thor_data::corp_CT_main_scrubs_bits',overwrite,compressed);	//long term storage
		Main_TranslateBitMap			:= output(Main_T);
	
	  //Submits Profile's stats to Orbit
		Main_SubmitStats 					:= Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_CT_Main','ScrubsAlerts', Main_OrbitStats, version,'Corp_CT_Main').SubmitStats;
	
	  Main_ScrubsWithExamples		:= Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_CT_Main','ScrubsAlerts', Main_OrbitStats, version,'Corp_CT_Main').CompareToProfile_with_Examples;
		
		Main_ScrubsAlert					:= Main_ScrubsWithExamples(RejectWarning = 'Y');
		Main_ScrubsAttachment			:= Scrubs.fn_email_attachment(Main_ScrubsAlert);
		Main_SendEmailFile				:= FileServices.SendEmailAttachData( corp2.Email_Notification_Lists.AttachedList
																																	 ,'Scrubs CorpMain_CT Report' //subject
																																	 ,'Scrubs CorpMain_CT Report' //body
																																	 ,(data)Main_ScrubsAttachment
																																	 ,'text/csv'
																																	 ,'CorpCTMainScrubsReport.csv'
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
																							corp_inc_date_invalid 			       <> 0 or
																							corp_term_exist_exp_invalid 			 <> 0 or
																							corp_merger_date_invalid           <> 0 or
																							corp_status_date_invalid      		 <> 0 or
																							corp_orig_sos_charter_nbr_invalid  <> 0 or
																							corp_legal_name_invalid 			     <> 0 or
																							corp_foreign_domestic_ind_invalid  <> 0 or
																							corp_for_profit_ind_invalid 			 <> 0 or
																							corp_ln_name_type_cd_invalid 			 <> 0 or
																							corp_ln_name_type_desc_invalid		 <> 0 or
																							corp_forgn_state_desc_invalid      <> 0 or
																							corp_orig_org_structure_cd_invalid <> 0 or
																							corp_status_cd_invalid             <> 0 or
																							corp_orig_bus_type_cd_invalid      <> 0 or
																							corp_filing_date_invalid           <> 0 or
																							corp_ra_resign_date_invalid        <> 0 or
																							corp_name_status_date_invalid      <> 0 or
																							corp_dissolved_date_invalid        <> 0 or
																							cont_effective_date_invalid        <> 0 or
																							corp_country_of_formation_invalid  <> 0 or
																							corp_name_reservation_expiration_date_invalid <> 0  );

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
																								corp_inc_date_invalid 			       = 0 and
																								corp_term_exist_exp_invalid 			 = 0 and
																								corp_merger_date_invalid           = 0 and
																								corp_status_date_invalid      		 = 0 and
																								corp_orig_sos_charter_nbr_invalid  = 0 and
																								corp_legal_name_invalid 			     = 0 and
																								corp_foreign_domestic_ind_invalid  = 0 and
																								corp_for_profit_ind_invalid 			 = 0 and
																								corp_ln_name_type_cd_invalid 			 = 0 and
																								corp_ln_name_type_desc_invalid 		 = 0 and
																								corp_forgn_state_desc_invalid      = 0 and
																								corp_orig_org_structure_cd_invalid = 0 and
																								corp_status_cd_invalid             = 0 and
																								corp_orig_bus_type_cd_invalid      = 0 and
																								corp_filing_date_invalid           = 0 and
																								corp_ra_resign_date_invalid        = 0 and
																								corp_name_status_date_invalid      = 0 and
																								corp_dissolved_date_invalid        = 0 and
																								cont_effective_date_invalid        = 0 and
																								corp_country_of_formation_invalid  = 0 and
																								corp_name_reservation_expiration_date_invalid = 0);																									 																	
		
		Main_FailBuild	:= map(corp2_mapping.fCalcPercent(count(Main_N.ExpandedInFile(corp_orig_sos_charter_nbr_invalid<>0)),count(Main_N.ExpandedInFile),false) > Scrubs_Corp2_Mapping_CT_Main.Threshold_Percent.CORP_ORIG_SOS_CHARTER_NBR => true,
													 corp2_mapping.fCalcPercent(count(Main_N.ExpandedInFile(corp_legal_name_invalid<>0)),					 count(Main_N.ExpandedInFile),false) > Scrubs_Corp2_Mapping_CT_Main.Threshold_Percent.CORP_LEGAL_NAME 					=> true,
													 corp2_mapping.fCalcPercent(count(Main_N.ExpandedInFile(corp_key_invalid<>0)),						     count(Main_N.ExpandedInFile),false) > Scrubs_Corp2_Mapping_CT_Main.Threshold_Percent.CORP_KEY      						=> true,
													 count(Main_GoodRecords) = 0																																																																																				          => true,
													 false );

		Main_ApprovedRecords := project(Main_GoodRecords,transform(Corp2_Mapping.LayoutsCommon.Main,self := left));
	
		Main_RejFile_Exists		:= IF(FileServices.FileExists(Corp2_Mapping._dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::main_' + state_origin),true,false);			
	  Main_ALL		 					:= sequential(IF(count(Main_BadRecords) <> 0
																					,IF (poverwrite
																							,OUTPUT(Main_BadRecords,,Corp2_Mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::main_CT',overwrite,__compressed__,named('Sample_Rejected_MainRecs_CT'+filedate))
																							,sequential (IF(Main_RejFile_Exists,fileservices.deletelogicalfile(Corp2_Mapping._dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::main_'+ state_origin)),
																													 OUTPUT(Main_BadRecords,,Corp2_Mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::main_'+ state_origin,__compressed__,named('Sample_Rejected_MainRecs_CT'+filedate)))))
																		,output(Main_ScrubsWithExamples, ALL, NAMED('CorpMainCTScrubsReportWithExamples'+filedate))																		
																		//Send Alerts if Scrubs exceeds thresholds
																		,IF(COUNT(Main_ScrubsAlert) > 0, Main_SendEmailFile, OUTPUT('CORP2_MAPPING.CT - No "MAIN" Corp Scrubs Alerts'))
																		,Main_ErrorSummary
																		,Main_ScrubErrorReport
																		,Main_SomeErrorValues
																		,Main_SubmitStats);
																		
	
 //-------------------- Version Control -----------------------------------------------------//	
	VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+version+'::main_ct'			,Main_ApprovedRecords ,main_out		     ,,,pOverwrite);		
	VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+version+'::stock_ct'			,MapStock	            ,stock_out	     ,,,pOverwrite);
	VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+version+'::event_ct'			,MapEvent             ,event_out	     ,,,pOverwrite);
	VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+version+'::ar_ct'				,MapAR		            ,ar_out			     ,,,pOverwrite);
	
	VersionControl.macBuildNewLogicalFile('~thor_data400::failed::corp2::'+version+'::main_ct'	,MapMain              ,write_fail_main ,,,pOverwrite);		
		
	mapCT:= sequential(   if(pshouldspray = true,Corp2_mapping.fSprayFiles(state_origin ,version,pOverwrite := pOverwrite))
											  // ,Corp2_Raw_CT.Build_Bases(filedate,version,pUseProd).All  // Determined building of bases is not needed
												,main_out
												,event_out
												,ar_out
												,stock_out										
												,IF(Main_FailBuild <> true
														,sequential( fileservices.addsuperfile(Corp2_Mapping._Dataset().thor_cluster_Files + 'in::'+Corp2_Mapping._Dataset().NameMapped+'::sprayed::ar'		,Corp2_Mapping._Dataset().thor_cluster_Files + 'in::corp2::'+version+'::ar_CT')
																				,fileservices.addsuperfile(Corp2_Mapping._Dataset().thor_cluster_Files + 'in::'+Corp2_Mapping._Dataset().NameMapped+'::sprayed::event',Corp2_Mapping._Dataset().thor_cluster_Files + 'in::corp2::'+version+'::event_CT')
																				,fileservices.addsuperfile(Corp2_Mapping._Dataset().thor_cluster_Files + 'in::'+Corp2_Mapping._Dataset().NameMapped+'::sprayed::main'	,Corp2_Mapping._Dataset().thor_cluster_Files + 'in::corp2::'+version+'::main_CT')																		 
																				,fileservices.addsuperfile(Corp2_Mapping._Dataset().thor_cluster_Files + 'in::'+Corp2_Mapping._Dataset().NameMapped+'::sprayed::stock',Corp2_Mapping._Dataset().thor_cluster_Files + 'in::corp2::'+version+'::stock_CT')
																				,if (count(Main_BadRecords) <> 0 
																						 ,Corp2_Mapping.Send_Email(state_origin ,version,count(Main_BadRecords)<>0,,,,count(Main_BadRecords),,,,count(Main_ApprovedRecords),count(mapAR),count(mapEvent),count(mapStock)).RecordsRejected																				 
																						 ,Corp2_Mapping.Send_Email(state_origin ,version,count(Main_BadRecords)<>0,,,,count(Main_BadRecords),,,,count(Main_ApprovedRecords),count(mapAR),count(mapEvent),count(mapStock)).MappingSuccess																				 
																						 )	 
																			)
														 ,sequential( write_fail_main//if it fails on  main file threshold ,still writing mapped files!
																				 ,Corp2_Mapping.Send_Email(state_origin ,version).MappingFailed
																				)
													)
												,if (Main_IsScrubErrors
														,Corp2_Mapping.Send_Email(state_origin ,version,Main_IsScrubErrors).FieldsInvalidPerScrubs)
												,Main_All	
										);
															
 		isFileDateValid := if((string)Std.Date.Today() between ut.date_math(filedate,-31) and ut.date_math(filedate,31),true,false);
		return sequential (if (isFileDateValid
														,mapCT
														,sequential (Corp2_Mapping.Send_Email(state_origin,filedate).InvalidFileDateParm
																				,FAIL('Corp2_Mapping.CT failed.  An invalid filedate was passed in as a parameter.')))); 	

 End; //Update Function

End;//End CT Module