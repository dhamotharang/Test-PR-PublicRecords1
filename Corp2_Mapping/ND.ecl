import ut, std, Corp2, Corp2_Mapping, Scrubs, Corp2_Raw_ND, Scrubs_Corp2_Mapping_ND_Main, _control, Tools, versioncontrol; 

 export ND:= MODULE;   
 
  export Update(string fileDate, string version, boolean pShouldSpray = _Dataset().bShouldSpray, boolean pOverwrite = false, pUseProd = Tools._Constants.IsDataland) := function
 		
		state_origin	 := 'ND';
		state_fips	 	 := '38';	
		state_desc	 	 := 'NORTH DAKOTA';	  
		
		// Vendor Input Files  
		dCorp1    	 := dedup(sort(distribute(Corp2_Raw_ND.Files(filedate,pUseProd).Input.Corp1.Logical,      hash(CBSID)),record,local),record,local) : independent;
		dCorp2     	 := dedup(sort(distribute(Corp2_Raw_ND.Files(filedate,pUseProd).Input.Corp2.Logical,      hash(CBSID)),record,local),record,local) : independent;
		dFictName1   := dedup(sort(distribute(Corp2_Raw_ND.Files(filedate,pUseProd).Input.FictName1.Logical,  hash(ESID)),record,local),record,local)  : independent;
		dFictName2   := dedup(sort(distribute(Corp2_Raw_ND.Files(filedate,pUseProd).Input.FictName2.Logical,  hash(ESID)),record,local),record,local)  : independent;														
		dPartnership := dedup(sort(distribute(Corp2_Raw_ND.Files(filedate,pUseProd).Input.Partnership.Logical,hash(PAID)),record,local),record,local)  : independent;
		dTradeMark1  := dedup(sort(distribute(Corp2_Raw_ND.Files(filedate,pUseProd).Input.TradeMark1.Logical, hash(RSID)),record,local),record,local)  : independent;
		dTradeMark2  := dedup(sort(distribute(Corp2_Raw_ND.Files(filedate,pUseProd).Input.TradeMark2.Logical, hash(RSID)),record,local),record,local)  : independent;												
		dTradeName1  := dedup(sort(distribute(Corp2_Raw_ND.Files(filedate,pUseProd).Input.TradeName1.Logical, hash(PSID)),record,local),record,local)  : independent; 
		dTradeName2  := dedup(sort(distribute(Corp2_Raw_ND.Files(filedate,pUseProd).Input.TradeName2.Logical, hash(PSID)),record,local),record,local)  : independent;										 

    // Combine Vendor Input files 		
		fCorporations := dCorp1      + dCorp2      : independent;
		fFictNames    := dFictName1  + dFictName2  : independent;
    fTrademarks   := dTradeMark1 + dTradeMark2 : independent;
		fTradenames   := dTradeName1 + dTradeName2 : independent;
			
		//------- Begin CORP Mapping ---------------------------------------------------------------------//	
			
		// Map Corp from Corporations 	
	  Corp2_Mapping.LayoutsCommon.Main corp1Trf(Corp2_Raw_ND.Layouts.CorpLayoutIn input):=transform
	   	self.dt_vendor_first_reported	    := (integer)fileDate;
			self.dt_vendor_last_reported	    := (integer)fileDate;
			self.dt_first_seen				        := (integer)fileDate;
			self.dt_last_seen				          := (integer)fileDate;
			self.corp_ra_dt_first_seen		    := (integer)fileDate;
			self.corp_ra_dt_last_seen		      := (integer)fileDate;
			self.corp_key					            := state_fips + '-' + corp2.t2u(input.CBSID);
			self.corp_vendor					        := state_fips;
		  self.corp_state_origin            := state_origin;
			self.corp_inc_state               := state_origin;
			self.corp_process_date				    := fileDate;  
			self.corp_orig_sos_charter_nbr    := corp2.t2u(input.CBSID);
			self.corp_legal_name              := Corp2_mapping.fCleanBusinessName(state_origin,state_desc,input.NNAM).BusinessName;
			self.corp_ln_name_type_cd         := '01';
  		self.corp_ln_name_type_desc       := 'LEGAL';
		 	self.corp_orig_org_structure_cd   := corp2.t2u(input.CBCTYP);
      self.corp_orig_org_structure_desc := Corp2_Raw_ND.Functions.GetStructureDesc(input.CBCTYP,'C');
			self.corp_status_cd               := corp2.t2u(input.CBCST);
      self.corp_status_desc             := Corp2_Raw_ND.Functions.GetStatusDesc(input.CBCST,'C');
			self.corp_for_profit_ind          := if (corp2.t2u(input.CBCTYP) in ['FNP','CNPD','NP','NPLC'], 'N', '');	
      self.corp_status_date             := Corp2_Mapping.fValidateDate(input.CBCSTD,'CCYYMMDD').PastDate;				
			
			foreignTyp := ['F','FC','FLC','FPC','FPLC','FNP'];
			self.corp_inc_date                := if (corp2.t2u(input.CBSOO) in [state_origin,''] and corp2.t2u(input.CBCTYP) not in foreignTyp
																							,Corp2_Mapping.fValidateDate(input.CBODF,'CCYYMMDD').PastDate ,'');	
			self.corp_forgn_date              := if (corp2.t2u(input.CBSOO) not in [state_origin,''] and corp2.t2u(input.CBCTYP) in foreignTyp
																							,Corp2_Mapping.fValidateDate(input.CBODF,'CCYYMMDD').PastDate ,'');	
			self.corp_foreign_domestic_ind    := map(corp2.t2u(input.CBSOO) in [state_origin,''] and corp2.t2u(input.CBCTYP) not in foreignTyp => 'D',
																							 corp2.t2u(input.CBSOO) not in [state_origin,''] and corp2.t2u(input.CBCTYP) in foreignTyp => 'F',
																							 '');		
			self.corp_forgn_state_cd          := if (corp2.t2u(input.CBSOO) not in [state_origin,''] and corp2.t2u(input.CBCTYP) in foreignTyp
																							,corp2.t2u(input.CBSOO) ,'');
			self.corp_forgn_state_desc        := Corp2_Raw_ND.Functions.GetForgnDesc(self.corp_forgn_state_cd);
			self.corp_country_of_formation    := Corp2_Raw_ND.Functions.GetCountry(input.CBSOO);
			self.corp_address1_type_cd        := if (Corp2_Mapping.fAddressExists(state_origin,state_desc,input.NADD1,input.NADD2,input.NCITY,input.NSTAT,input.NZIP).ifAddressExists,'B','');
			self.corp_address1_type_desc      := if (Corp2_Mapping.fAddressExists(state_origin,state_desc,input.NADD1,input.NADD2,input.NCITY,input.NSTAT,input.NZIP).ifAddressExists,'BUSINESS','');
			self.corp_address1_line1					:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.NADD1,input.NADD2,input.NCITY,input.NSTAT,input.NZIP).AddressLine1;
			self.corp_address1_line2					:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.NADD1,input.NADD2,input.NCITY,input.NSTAT,input.NZIP).AddressLine2;
			self.corp_address1_line3					:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.NADD1,input.NADD2,input.NCITY,input.NSTAT,input.NZIP).AddressLine3;			
			self.corp_prep_addr1_line1				:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.NADD1,input.NADD2,input.NCITY,input.NSTAT,input.NZIP).PrepAddrLine1;			
			self.corp_prep_addr1_last_line	  := Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.NADD1,input.NADD2,input.NCITY,input.NSTAT,input.NZIP).PrepAddrLastLine;
			
			self.corp_ra_address_type_cd      := if (Corp2_Mapping.fAddressExists(state_origin,state_desc,input.CRADR1,input.CRADR2,input.CRACTY,input.CRAST,input.CRAZIP).ifAddressExists, 'R', '');			
			self.corp_ra_address_type_desc    := if (Corp2_Mapping.fAddressExists(state_origin,state_desc,input.CRADR1,input.CRADR2,input.CRACTY,input.CRAST,input.CRAZIP).ifAddressExists, 'REGISTERED OFFICE', '');
			self.corp_ra_address_line1				:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.CRADR1,input.CRADR2,input.CRACTY,input.CRAST,input.CRAZIP).AddressLine1;
			self.corp_ra_address_line2				:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.CRADR1,input.CRADR2,input.CRACTY,input.CRAST,input.CRAZIP).AddressLine2;
			self.corp_ra_address_line3				:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.CRADR1,input.CRADR2,input.CRACTY,input.CRAST,input.CRAZIP).AddressLine3;			
			self.ra_prep_addr_line1						:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.CRADR1,input.CRADR2,input.CRACTY,input.CRAST,input.CRAZIP).PrepAddrLine1;			
			self.ra_prep_addr_last_line 			:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.CRADR1,input.CRADR2,input.CRACTY,input.CRAST,input.CRAZIP).PrepAddrLastLine;
		  
			self.corp_ra_full_name            := Corp2_Raw_ND.Functions.GetRAName(input.CRANM1,input.CRANM2);
			self.corp_orig_bus_type_desc      := corp2.t2u(StringLib.StringFindReplace(StringLib.StringFindReplace(StringLib.StringFindReplace(corp2.t2u(input.CNNOB),'\n',''),'.',' '),'0 0 0',''));
			self.recordOrigin                 := 'C';
		  self                              := [];
    end;  

		// Map Corp from FictNames 
		jFictNames	:= join(fFictNames, fCorporations, 
											corp2.t2u(left.ESID) = corp2.t2u(right.CBSID),
											transform(Corp2_Raw_ND.Layouts.FictName_TempLay, 
																 self.CBSOO   := right.CBSOO;
																 self.CBCTYP 	:= right.CBCTYP;
																 self.CBODF 	:= right.CBODF;
																 self := left; self := right; self := [];),
											left outer,local) : independent;
											
		Corp2_Mapping.LayoutsCommon.Main corp2Trf(Corp2_Raw_ND.Layouts.FictName_TempLay input):=transform
					,skip(corp2.t2u(input.ESID)='')
      self.dt_vendor_first_reported	    := (integer)fileDate;
			self.dt_vendor_last_reported	    := (integer)fileDate;
			self.dt_first_seen				        := (integer)fileDate;
			self.dt_last_seen				          := (integer)fileDate;
			self.corp_ra_dt_first_seen		    := (integer)fileDate;
			self.corp_ra_dt_last_seen		      := (integer)fileDate;
			self.corp_key					      			:= state_fips + '-' + corp2.t2u(input.ESID);
			self.corp_vendor					  			:= state_fips;
		  self.corp_state_origin            := state_origin;
			self.corp_inc_state               := state_origin;
			self.corp_process_date				    := fileDate; 
     	self.corp_orig_sos_charter_nbr    := corp2.t2u(input.ESID);
			self.corp_legal_name              := Corp2_mapping.fCleanBusinessName(state_origin,state_desc,input.FICNNAM).BusinessName;
			self.corp_ln_name_type_cd         := 'F';
			self.corp_ln_name_type_desc       := 'FBN';
		  self.corp_status_cd               := corp2.t2u(input.ECLST);
      self.corp_status_desc             := Corp2_Raw_ND.Functions.GetStatusDesc(input.ECLST,'F');
			self.corp_status_date             := Corp2_Mapping.fValidateDate(input.ECSDT,'CCYYMMDD').PastDate;
			self.corp_filing_date             := Corp2_Mapping.fValidateDate(input.EOLDT,'CCYYMMDD').PastDate;	
			self.corp_filing_cd               := if (self.corp_filing_date <> '' ,'X' ,'');
			self.corp_filing_desc             := if (self.corp_filing_date <> '' ,'ORIGINAL LICENSE DATE' ,'');	
			self.corp_last_renewal_date       := Corp2_Mapping.fValidateDate(input.ELRFD,'CCYYMMDD').PastDate;	
			self.corp_addl_info               := if (Corp2_Mapping.fValidateDate(input.ELAD,'CCYYMMDD').PastDate <> ''
																							 ,'LAST AMENDED DATE: ' + Corp2_Mapping.fValidateDate(input.ELAD,'CCYYMMDD').PastDate[5..6] + '/' + 
																																				Corp2_Mapping.fValidateDate(input.ELAD,'CCYYMMDD').PastDate[7..8] + '/' + 
																																				Corp2_Mapping.fValidateDate(input.ELAD,'CCYYMMDD').PastDate[1..4] ,'');	
			self.corp_address1_type_cd        := if (Corp2_Mapping.fAddressExists(state_origin,state_desc,input.FICNADD1,input.FICNADD2,input.FICNCITY,input.FICNSTAT,input.FICNZIP).ifAddressExists, 'B', '');			
			self.corp_address1_type_desc      := if (Corp2_Mapping.fAddressExists(state_origin,state_desc,input.FICNADD1,input.FICNADD2,input.FICNCITY,input.FICNSTAT,input.FICNZIP).ifAddressExists, 'BUSINESS', '');
			self.corp_address1_line1					:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.FICNADD1,input.FICNADD2,input.FICNCITY,input.FICNSTAT,input.FICNZIP).AddressLine1;
			self.corp_address1_line2					:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.FICNADD1,input.FICNADD2,input.FICNCITY,input.FICNSTAT,input.FICNZIP).AddressLine2;
			self.corp_address1_line3					:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.FICNADD1,input.FICNADD2,input.FICNCITY,input.FICNSTAT,input.FICNZIP).AddressLine3;			
			self.corp_prep_addr1_line1				:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.FICNADD1,input.FICNADD2,input.FICNCITY,input.FICNSTAT,input.FICNZIP).PrepAddrLine1;			
			self.corp_prep_addr1_last_line	  := Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.FICNADD1,input.FICNADD2,input.FICNCITY,input.FICNSTAT,input.FICNZIP).PrepAddrLastLine;
			
			foreignTyp := ['F','FC','FLC','FPC','FPLC','FNP'];
			self.corp_inc_date                := if (corp2.t2u(input.CBSOO) in [state_origin,''] and corp2.t2u(input.CBCTYP) not in foreignTyp
																							,Corp2_Mapping.fValidateDate(input.CBODF,'CCYYMMDD').PastDate ,'');	
			self.corp_forgn_date              := if (corp2.t2u(input.CBSOO) not in [state_origin,''] and corp2.t2u(input.CBCTYP) in foreignTyp
																							,Corp2_Mapping.fValidateDate(input.CBODF,'CCYYMMDD').PastDate ,'');	
			self.recordOrigin                 := 'C';
      self                              := [];
   end;  
		
		// Map Corp from Partnership 
		Corp2_Mapping.LayoutsCommon.Main corp3Trf(Corp2_Raw_ND.Layouts.PartnershipLayoutIN input):=transform
						,skip(corp2.t2u(input.PAID)='')
     	self.dt_vendor_first_reported	    := (integer)fileDate;
			self.dt_vendor_last_reported	    := (integer)fileDate;
			self.dt_first_seen				        := (integer)fileDate;
			self.dt_last_seen				          := (integer)fileDate;
			self.corp_ra_dt_first_seen		    := (integer)fileDate;
			self.corp_ra_dt_last_seen		      := (integer)fileDate;
			self.corp_key					            := state_fips + '-' + corp2.t2u(input.PAID);
			self.corp_vendor					  			:= state_fips;
		  self.corp_state_origin            := state_origin;
			self.corp_inc_state               := state_origin;
			self.corp_process_date				    := fileDate;
     	self.corp_orig_sos_charter_nbr    := corp2.t2u(input.PAID);
			self.corp_ln_name_type_cd         := '01';
			self.corp_ln_name_type_desc       := 'LEGAL';
		  self.corp_legal_name              := Corp2_mapping.fCleanBusinessName(state_origin,state_desc,input.PANAME).BusinessName;
			self.corp_orig_org_structure_cd   := corp2.t2u(input.PATYPE);
      self.corp_orig_org_structure_desc := Corp2_Raw_ND.Functions.GetStructureDesc(input.PATYPE,'P');
			self.corp_status_cd               := corp2.t2u(input.PASTS);
      self.corp_status_desc             := Corp2_Raw_ND.Functions.GetStatusDesc(input.PASTS,'P');
			self.corp_status_date             := Corp2_Mapping.fValidateDate(input.PASTDT,'CCYYMMDD').PastDate;	
	  	self.corp_foreign_domestic_ind    := map (corp2.t2u(input.PASTAO) in [state_origin,'']     => 'D',
																								corp2.t2u(input.PASTAO) not in [state_origin,''] => 'F',
																								'');		
			self.corp_forgn_state_cd          := if (corp2.t2u(input.PASTAO) not in [state_origin,''] ,corp2.t2u(input.PASTAO) ,'');
			self.corp_forgn_state_desc        := Corp2_Raw_ND.Functions.GetForgnDesc(self.corp_forgn_state_cd);
			self.corp_inc_date                := if (corp2.t2u(input.PASTAO) in [state_origin,''] 
																							 ,Corp2_Mapping.fValidateDate(input.PADATE,'CCYYMMDD').PastDate ,'');	
			self.corp_forgn_date              := if (corp2.t2u(input.PASTAO) not in [state_origin,''] 
																							 ,Corp2_Mapping.fValidateDate(input.PADATE,'CCYYMMDD').PastDate ,'');	
			self.corp_country_of_formation    := Corp2_Raw_ND.Functions.GetCountry(input.PASTAO);
			self.corp_last_renewal_date       := Corp2_Mapping.fValidateDate(input.PALRFD,'CCYYMMDD').PastDate;	
			self.corp_addl_info               := if (Corp2_Mapping.fValidateDate(input.PALAD,'CCYYMMDD').PastDate <> ''
																							 ,'LAST AMENDED DATE: ' + Corp2_Mapping.fValidateDate(input.PALAD,'CCYYMMDD').PastDate[5..6] + '/' + 
																																				Corp2_Mapping.fValidateDate(input.PALAD,'CCYYMMDD').PastDate[7..8] + '/' + 
																																				Corp2_Mapping.fValidateDate(input.PALAD,'CCYYMMDD').PastDate[1..4] ,'');	
			self.corp_comment                 := if (Corp2_Mapping.fValidateDate(input.PALRD,'CCYYMMDD').PastDate <> ''
																							 ,'LAST RESTATEMENT DATE: ' + Corp2_Mapping.fValidateDate(input.PALRD,'CCYYMMDD').PastDate[5..6] + '/' + 
																																				    Corp2_Mapping.fValidateDate(input.PALRD,'CCYYMMDD').PastDate[7..8] + '/' + 
																																				    Corp2_Mapping.fValidateDate(input.PALRD,'CCYYMMDD').PastDate[1..4] ,'');																					 
			
			self.corp_address1_type_cd        := if (Corp2_Mapping.fAddressExists(state_origin,state_desc,input.PAADD1,input.PAADD2,input.PACITY,input.PASTAT,input.PAZIP).ifAddressExists, 'B', '');			
			self.corp_address1_type_desc      := if (Corp2_Mapping.fAddressExists(state_origin,state_desc,input.PAADD1,input.PAADD2,input.PACITY,input.PASTAT,input.PAZIP).ifAddressExists, 'BUSINESS', '');
			self.corp_address1_line1					:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.PAADD1,input.PAADD2,input.PACITY,input.PASTAT,input.PAZIP).AddressLine1;
			self.corp_address1_line2					:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.PAADD1,input.PAADD2,input.PACITY,input.PASTAT,input.PAZIP).AddressLine2;
			self.corp_address1_line3					:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.PAADD1,input.PAADD2,input.PACITY,input.PASTAT,input.PAZIP).AddressLine3;			
			self.corp_prep_addr1_line1				:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.PAADD1,input.PAADD2,input.PACITY,input.PASTAT,input.PAZIP).PrepAddrLine1;			
			self.corp_prep_addr1_last_line	  := Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.PAADD1,input.PAADD2,input.PACITY,input.PASTAT,input.PAZIP).PrepAddrLastLine;
			
			self.corp_ra_address_type_cd      := if (Corp2_Mapping.fAddressExists(state_origin,state_desc,input.PAADDR1,input.PAADDR2,input.PACITYR,input.PASTATR,input.PAZIPR).ifAddressExists, 'R', '');			
			self.corp_ra_address_type_desc    := if (Corp2_Mapping.fAddressExists(state_origin,state_desc,input.PAADDR1,input.PAADDR2,input.PACITYR,input.PASTATR,input.PAZIPR).ifAddressExists, 'REGISTERED OFFICE', '');
			self.corp_ra_address_line1				:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.PAADDR1,input.PAADDR2,input.PACITYR,input.PASTATR,input.PAZIPR).AddressLine1;
			self.corp_ra_address_line2				:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.PAADDR1,input.PAADDR2,input.PACITYR,input.PASTATR,input.PAZIPR).AddressLine2;
			self.corp_ra_address_line3				:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.PAADDR1,input.PAADDR2,input.PACITYR,input.PASTATR,input.PAZIPR).AddressLine3;			
			self.ra_prep_addr_line1						:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.PAADDR1,input.PAADDR2,input.PACITYR,input.PASTATR,input.PAZIPR).PrepAddrLine1;			
			self.ra_prep_addr_last_line 			:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.PAADDR1,input.PAADDR2,input.PACITYR,input.PASTATR,input.PAZIPR).PrepAddrLastLine;

			self.corp_ra_full_name            := Corp2_Raw_ND.Functions.GetRAName(input.PANAMER,input.PANAMER2);
			self.recordOrigin                 := 'C';																			
      self                              := [];
		end;  

    // Map Corp from Trademarks 
	  jTrademarks	:= join(fTrademarks, fCorporations, 
											corp2.t2u(left.RSID) = corp2.t2u(right.CBSID),
											transform(Corp2_Raw_ND.Layouts.TradeMark_TempLay, 
																 self.CBSOO   := right.CBSOO;
																 self.CBCTYP 	:= right.CBCTYP;
																 self.CBODF 	:= right.CBODF;
																 self := left; self := right; self := [];),
											left outer,local) : independent;
											
		Corp2_Mapping.LayoutsCommon.Main corp4Trf(Corp2_Raw_ND.Layouts.TradeMark_TempLay input):=transform
					,skip(corp2.t2u(input.RSID)='')
     	self.dt_vendor_first_reported	         := (integer)fileDate;
			self.dt_vendor_last_reported	         := (integer)fileDate;
			self.dt_first_seen				             := (integer)fileDate;
			self.dt_last_seen				               := (integer)fileDate;
			self.corp_ra_dt_first_seen		         := (integer)fileDate;
			self.corp_ra_dt_last_seen		           := (integer)fileDate;
			self.corp_key					     				     := state_fips + '-' + corp2.t2u(input.RSID);
			self.corp_vendor					  			     := state_fips;
		  self.corp_state_origin                 := state_origin;
			self.corp_inc_state                    := state_origin;
			self.corp_process_date				  	     := fileDate; 
 	    self.corp_orig_sos_charter_nbr         := corp2.t2u(input.RSID);
			self.corp_ln_name_type_cd              := '03';
			self.corp_ln_name_type_desc            := 'TRADEMARK';
		  self.corp_legal_name                   := Corp2_mapping.fCleanBusinessName(state_origin,state_desc,input.TM_NNAM).BusinessName;
			self.corp_status_cd                    := corp2.t2u(input.RCLST);
      self.corp_status_desc                  := Corp2_Raw_ND.Functions.GetStatusDesc(input.RCLST,'TM');
			self.corp_status_date                  := Corp2_Mapping.fValidateDate(input.RCSDT,'CCYYMMDD').PastDate;												   
			self.corp_filing_date             		 := Corp2_Mapping.fValidateDate(input.ROLDT,'CCYYMMDD').PastDate;
			self.corp_filing_cd                    := if (self.corp_filing_date <> '' ,'X' ,'');
			self.corp_filing_desc                  := if (self.corp_filing_date <> '' ,'ORIGINAL LICENSE DATE' ,'');	
			self.corp_forgn_state_cd               := if (corp2.t2u(input.RSTAT) not in [state_origin,''] ,corp2.t2u(input.RSTAT) ,'');
			self.corp_forgn_state_desc             := Corp2_Raw_ND.Functions.GetForgnDesc(self.corp_forgn_state_cd);
			self.corp_foreign_domestic_ind         := map (corp2.t2u(input.RSTAT) in [state_origin,'']     => 'D',
																							     	corp2.t2u(input.RSTAT) not in [state_origin,''] => 'F',	'');	
			self.corp_addl_info                    := if (Corp2_Mapping.fValidateDate(input.RLAD,'CCYYMMDD').PastDate <> ''
																							      ,'LAST AMENDED DATE: ' + Corp2_Mapping.fValidateDate(input.RLAD,'CCYYMMDD').PastDate[5..6] + '/' + 
																																						 Corp2_Mapping.fValidateDate(input.RLAD,'CCYYMMDD').PastDate[7..8] + '/' + 
																																						 Corp2_Mapping.fValidateDate(input.RLAD,'CCYYMMDD').PastDate[1..4] ,'');	
			self.corp_address1_type_cd             := if (Corp2_Mapping.fAddressExists(state_origin,state_desc,input.OADD1,input.OADD2,input.OCITY,input.OSTAT,input.OZIP).ifAddressExists, 'B', '');			
			self.corp_address1_type_desc           := if (Corp2_Mapping.fAddressExists(state_origin,state_desc,input.OADD1,input.OADD2,input.OCITY,input.OSTAT,input.OZIP).ifAddressExists, 'BUSINESS', '');
			self.corp_address1_line1					     := Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.OADD1,input.OADD2,input.OCITY,input.OSTAT,input.OZIP).AddressLine1;
			self.corp_address1_line2					     := Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.OADD1,input.OADD2,input.OCITY,input.OSTAT,input.OZIP).AddressLine2;
			self.corp_address1_line3					     := Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.OADD1,input.OADD2,input.OCITY,input.OSTAT,input.OZIP).AddressLine3;			
			self.corp_prep_addr1_line1				     := Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.OADD1,input.OADD2,input.OCITY,input.OSTAT,input.OZIP).PrepAddrLine1;			
			self.corp_prep_addr1_last_line	       := Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.OADD1,input.OADD2,input.OCITY,input.OSTAT,input.OZIP).PrepAddrLastLine;

			self.corp_trademark_status             := self.corp_status_desc;
			self.corp_trademark_class_desc1        := corp2.t2u(input.RDSCL);
			self.corp_trademark_filing_date        := Corp2_Mapping.fValidateDate(input.ROLDT,'CCYYMMDD').PastDate;
			self.corp_trademark_renewal_date       := Corp2_Mapping.fValidateDate(input.RLRFD,'CCYYMMDD').PastDate;	
			self.corp_trademark_classification_nbr := corp2.t2u(input.ICLASS);
			
			foreignTyp := ['F','FC','FLC','FPC','FPLC','FNP'];
			self.corp_inc_date                     := if (corp2.t2u(input.CBSOO) in [state_origin,''] and corp2.t2u(input.CBCTYP) not in foreignTyp
																										,Corp2_Mapping.fValidateDate(input.CBODF,'CCYYMMDD').PastDate ,'');	
			self.corp_forgn_date                   := if (corp2.t2u(input.CBSOO) not in [state_origin,''] and corp2.t2u(input.CBCTYP) in foreignTyp
																										,Corp2_Mapping.fValidateDate(input.CBODF,'CCYYMMDD').PastDate ,'');	
			self.recordOrigin                 		 := 'C';
		  self                                   := [];
    end;  

		// Map Corp from Tradenames 
		jTradenames	:= join(fTradenames, fCorporations, 
											corp2.t2u(left.PSID) = corp2.t2u(right.CBSID),
											transform(Corp2_Raw_ND.Layouts.Tradename_TempLay, 
																 self.CBSOO   := right.CBSOO;
																 self.CBCTYP 	:= right.CBCTYP;
																 self.CBODF 	:= right.CBODF;
																 self := left; self := right; self := [];),
											left outer,local) : independent;
											
		Corp2_Mapping.LayoutsCommon.Main corp5Trf(Corp2_Raw_ND.Layouts.Tradename_TempLay input):=transform
							,skip(corp2.t2u(input.PSID)='')
     	self.dt_vendor_first_reported	    := (integer)fileDate;
			self.dt_vendor_last_reported	    := (integer)fileDate;
			self.dt_first_seen				        := (integer)fileDate;
			self.dt_last_seen				          := (integer)fileDate;
			self.corp_ra_dt_first_seen		    := (integer)fileDate;
			self.corp_ra_dt_last_seen		      := (integer)fileDate;
			self.corp_key					      			:= state_fips + '-' + corp2.t2u(input.PSID);
			self.corp_vendor					  			:= state_fips;
		  self.corp_state_origin            := state_origin;
			self.corp_inc_state               := state_origin;
			self.corp_process_date				  	:= fileDate; 
    	self.corp_orig_sos_charter_nbr    := corp2.t2u(input.PSID);
			self.corp_ln_name_type_cd         := '04';
			self.corp_ln_name_type_desc       := 'TRADENAME';
		  self.corp_legal_name              := Corp2_mapping.fCleanBusinessName(state_origin,state_desc,input.TN_NNAM).BusinessName;
			self.corp_status_cd               := corp2.t2u(input.PCLST);
      self.corp_status_desc             := Corp2_Raw_ND.Functions.GetStatusDesc(input.PCLST,'TN');
			self.corp_status_date             := Corp2_Mapping.fValidateDate(input.PCSD8,'CCYYMMDD').PastDate;			
			self.corp_filing_date             := Corp2_Mapping.fValidateDate(input.POLD8,'CCYYMMDD').PastDate;
			self.corp_filing_cd               := if (self.corp_filing_date <> '' ,'X' ,'');
			self.corp_filing_desc             := if (self.corp_filing_date <> '' ,'ORIGINAL LICENSE DATE' ,'');	
			self.corp_last_renewal_date       := Corp2_Mapping.fValidateDate(input.PLRD8,'CCYYMMDD').PastDate;	
			self.corp_addl_info               := if (Corp2_Mapping.fValidateDate(input.PLAD8,'CCYYMMDD').PastDate <> ''
																							 ,'LAST AMENDED DATE: ' + Corp2_Mapping.fValidateDate(input.PLAD8,'CCYYMMDD').PastDate[5..6] + '/' + 
																																				Corp2_Mapping.fValidateDate(input.PLAD8,'CCYYMMDD').PastDate[7..8] + '/' + 
																																				Corp2_Mapping.fValidateDate(input.PLAD8,'CCYYMMDD').PastDate[1..4] ,'');	
			self.corp_address1_type_cd        := if (Corp2_Mapping.fAddressExists(state_origin,state_desc,input.OADD1,input.OADD2,input.OCITY,input.OSTAT,input.OZIP).ifAddressExists, 'B', '');			
			self.corp_address1_type_desc      := if (Corp2_Mapping.fAddressExists(state_origin,state_desc,input.OADD1,input.OADD2,input.OCITY,input.OSTAT,input.OZIP).ifAddressExists, 'BUSINESS', '');
			self.corp_address1_line1					:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.OADD1,input.OADD2,input.OCITY,input.OSTAT,input.OZIP).AddressLine1;
			self.corp_address1_line2					:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.OADD1,input.OADD2,input.OCITY,input.OSTAT,input.OZIP).AddressLine2;
			self.corp_address1_line3					:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.OADD1,input.OADD2,input.OCITY,input.OSTAT,input.OZIP).AddressLine3;			
			self.corp_prep_addr1_line1				:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.OADD1,input.OADD2,input.OCITY,input.OSTAT,input.OZIP).PrepAddrLine1;			
			self.corp_prep_addr1_last_line	  := Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.OADD1,input.OADD2,input.OCITY,input.OSTAT,input.OZIP).PrepAddrLastLine;
		
		  foreignTyp := ['F','FC','FLC','FPC','FPLC','FNP'];
			self.corp_inc_date                := if (corp2.t2u(input.CBSOO) in [state_origin,''] and corp2.t2u(input.CBCTYP) not in foreignTyp
																							,Corp2_Mapping.fValidateDate(input.CBODF,'CCYYMMDD').PastDate ,'');	
			self.corp_forgn_date              := if (corp2.t2u(input.CBSOO) not in [state_origin,''] and corp2.t2u(input.CBCTYP) in foreignTyp
																							,Corp2_Mapping.fValidateDate(input.CBODF,'CCYYMMDD').PastDate ,'');	
			self.recordOrigin                 := 'C';																			
			self                              := [];
    end;  		
		//---------- End CORP Mapping --------------------------------------------------------------//

    
		//------- Begin CONTACTS Mapping ---------------------------------------------------------------------//	
		
		// Normalize on the 32 sets of Partnership contact name and address data 	

		Corp2_Raw_ND.Layouts.normContLayout normContTrf(Corp2_Raw_ND.Layouts.PartnershipLayoutIN l, unsigned1 cnt) := transform
			,skip((cnt= 1 and corp2.t2u(l.P01Name) = '') or	(cnt= 2 and corp2.t2u(l.P02Name) = '') or
						(cnt= 3 and corp2.t2u(l.P03Name) = '') or	(cnt= 4 and corp2.t2u(l.P04Name) = '') or
						(cnt= 5 and corp2.t2u(l.P05Name) = '') or	(cnt= 6 and corp2.t2u(l.P06Name) = '') or
						(cnt= 7 and corp2.t2u(l.P07Name) = '') or	(cnt= 8 and corp2.t2u(l.P08Name) = '') or
						(cnt= 9 and corp2.t2u(l.P09Name) = '') or	(cnt=10 and corp2.t2u(l.P10Name) = '') or
						(cnt=11 and corp2.t2u(l.P11Name) = '') or	(cnt=12 and corp2.t2u(l.P12Name) = '') or
						(cnt=13 and corp2.t2u(l.P13Name) = '') or	(cnt=14 and corp2.t2u(l.P14Name) = '') or
						(cnt=15 and corp2.t2u(l.P15Name) = '') or	(cnt=16 and corp2.t2u(l.P16Name) = '') or
						(cnt=17 and corp2.t2u(l.P17Name) = '') or	(cnt=18 and corp2.t2u(l.P18Name) = '') or
						(cnt=19 and corp2.t2u(l.P19Name) = '') or	(cnt=20 and corp2.t2u(l.P20Name) = '') or
						(cnt=21 and corp2.t2u(l.P21Name) = '') or	(cnt=22 and corp2.t2u(l.P22Name) = '') or
						(cnt=23 and corp2.t2u(l.P23Name) = '') or	(cnt=24 and corp2.t2u(l.P24Name) = '') or
						(cnt=25 and corp2.t2u(l.P25Name) = '') or	(cnt=26 and corp2.t2u(l.P26Name) = '') or
						(cnt=27 and corp2.t2u(l.P27Name) = '') or	(cnt=28 and corp2.t2u(l.P28Name) = '') or
						(cnt=29 and corp2.t2u(l.P29Name) = '') or	(cnt=30 and corp2.t2u(l.P30Name) = '') or
						(cnt=31 and corp2.t2u(l.P31Name) = '') or	(cnt=32 and corp2.t2u(l.P32Name) = ''))
			self.norm_Name := choose(cnt, corp2.t2u(l.P01Name), corp2.t2u(l.P02Name), corp2.t2u(l.P03Name), corp2.t2u(l.P04Name), corp2.t2u(l.P05Name), corp2.t2u(l.P06Name), corp2.t2u(l.P07Name), corp2.t2u(l.P08Name),
			                              corp2.t2u(l.P09Name), corp2.t2u(l.P10Name), corp2.t2u(l.P11Name), corp2.t2u(l.P12Name), corp2.t2u(l.P13Name), corp2.t2u(l.P14Name), corp2.t2u(l.P15Name), corp2.t2u(l.P16Name),
																		corp2.t2u(l.P17Name), corp2.t2u(l.P18Name), corp2.t2u(l.P19Name), corp2.t2u(l.P20Name), corp2.t2u(l.P21Name), corp2.t2u(l.P22Name), corp2.t2u(l.P23Name), corp2.t2u(l.P24Name),
																		corp2.t2u(l.P25Name), corp2.t2u(l.P26Name), corp2.t2u(l.P27Name), corp2.t2u(l.P28Name), corp2.t2u(l.P29Name), corp2.t2u(l.P30Name), corp2.t2u(l.P31Name), corp2.t2u(l.P32Name));
			self.norm_Add1 := choose(cnt, corp2.t2u(l.P01Add1), corp2.t2u(l.P02Add1), corp2.t2u(l.P03Add1), corp2.t2u(l.P04Add1), corp2.t2u(l.P05Add1), corp2.t2u(l.P06Add1), corp2.t2u(l.P07Add1), corp2.t2u(l.P08Add1),
			                              corp2.t2u(l.P09Add1), corp2.t2u(l.P10Add1), corp2.t2u(l.P11Add1), corp2.t2u(l.P12Add1), corp2.t2u(l.P13Add1), corp2.t2u(l.P14Add1), corp2.t2u(l.P15Add1), corp2.t2u(l.P16Add1),
																		corp2.t2u(l.P17Add1), corp2.t2u(l.P18Add1), corp2.t2u(l.P19Add1), corp2.t2u(l.P20Add1), corp2.t2u(l.P21Add1), corp2.t2u(l.P22Add1), corp2.t2u(l.P23Add1), corp2.t2u(l.P24Add1),
																		corp2.t2u(l.P25Add1), corp2.t2u(l.P26Add1), corp2.t2u(l.P27Add1), corp2.t2u(l.P28Add1), corp2.t2u(l.P29Add1), corp2.t2u(l.P30Add1), corp2.t2u(l.P31Add1), corp2.t2u(l.P32Add1)); 
			self.norm_Add2 := choose(cnt, corp2.t2u(l.P01Add2), corp2.t2u(l.P02Add2), corp2.t2u(l.P03Add2), corp2.t2u(l.P04Add2), corp2.t2u(l.P05Add2), corp2.t2u(l.P06Add2), corp2.t2u(l.P07Add2), corp2.t2u(l.P08Add2),
			                              corp2.t2u(l.P09Add2), corp2.t2u(l.P10Add2), corp2.t2u(l.P11Add2), corp2.t2u(l.P12Add2), corp2.t2u(l.P13Add2), corp2.t2u(l.P14Add2), corp2.t2u(l.P15Add2), corp2.t2u(l.P16Add2),
																		corp2.t2u(l.P17Add2), corp2.t2u(l.P18Add2), corp2.t2u(l.P19Add2), corp2.t2u(l.P20Add2), corp2.t2u(l.P21Add2), corp2.t2u(l.P22Add2), corp2.t2u(l.P23Add2), corp2.t2u(l.P24Add2),
																		corp2.t2u(l.P25Add2), corp2.t2u(l.P26Add2), corp2.t2u(l.P27Add2), corp2.t2u(l.P28Add2), corp2.t2u(l.P29Add2), corp2.t2u(l.P30Add2), corp2.t2u(l.P31Add2), corp2.t2u(l.P32Add2)); 	
			self.norm_City := choose(cnt, corp2.t2u(l.P01City), corp2.t2u(l.P02City), corp2.t2u(l.P03City), corp2.t2u(l.P04City), corp2.t2u(l.P05City), corp2.t2u(l.P06City), corp2.t2u(l.P07City), corp2.t2u(l.P08City),
			                              corp2.t2u(l.P09City), corp2.t2u(l.P10City), corp2.t2u(l.P11City), corp2.t2u(l.P12City), corp2.t2u(l.P13City), corp2.t2u(l.P14City), corp2.t2u(l.P15City), corp2.t2u(l.P16City),
																		corp2.t2u(l.P17City), corp2.t2u(l.P18City), corp2.t2u(l.P19City), corp2.t2u(l.P20City), corp2.t2u(l.P21City), corp2.t2u(l.P22City), corp2.t2u(l.P23City), corp2.t2u(l.P24City),
																		corp2.t2u(l.P25City), corp2.t2u(l.P26City), corp2.t2u(l.P27City), corp2.t2u(l.P28City), corp2.t2u(l.P29City), corp2.t2u(l.P30City), corp2.t2u(l.P31City), corp2.t2u(l.P32City)); 	
			self.norm_Stat := choose(cnt, corp2.t2u(l.P01Stat), corp2.t2u(l.P02Stat), corp2.t2u(l.P03Stat), corp2.t2u(l.P04Stat), corp2.t2u(l.P05Stat), corp2.t2u(l.P06Stat), corp2.t2u(l.P07Stat), corp2.t2u(l.P08Stat),
			                              corp2.t2u(l.P09Stat), corp2.t2u(l.P10Stat), corp2.t2u(l.P11Stat), corp2.t2u(l.P12Stat), corp2.t2u(l.P13Stat), corp2.t2u(l.P14Stat), corp2.t2u(l.P15Stat), corp2.t2u(l.P16Stat),
																		corp2.t2u(l.P17Stat), corp2.t2u(l.P18Stat), corp2.t2u(l.P19Stat), corp2.t2u(l.P20Stat), corp2.t2u(l.P21Stat), corp2.t2u(l.P22Stat), corp2.t2u(l.P23Stat), corp2.t2u(l.P24Stat),
																		corp2.t2u(l.P25Stat), corp2.t2u(l.P26Stat), corp2.t2u(l.P27Stat), corp2.t2u(l.P28Stat), corp2.t2u(l.P29Stat), corp2.t2u(l.P30Stat), corp2.t2u(l.P31Stat), corp2.t2u(l.P32Stat));
			self.norm_Zip  := choose(cnt, corp2.t2u(l.P01Zip),  corp2.t2u(l.P02Zip),  corp2.t2u(l.P03Zip),  corp2.t2u(l.P04Zip),  corp2.t2u(l.P05Zip),  corp2.t2u(l.P06Zip),  corp2.t2u(l.P07Zip),  corp2.t2u(l.P08Zip),
			                              corp2.t2u(l.P09Zip),  corp2.t2u(l.P10Zip),  corp2.t2u(l.P11Zip),  corp2.t2u(l.P12Zip),  corp2.t2u(l.P13Zip),  corp2.t2u(l.P14Zip),  corp2.t2u(l.P15Zip),  corp2.t2u(l.P16Zip),
																		corp2.t2u(l.P17Zip),  corp2.t2u(l.P18Zip),  corp2.t2u(l.P19Zip),  corp2.t2u(l.P20Zip),  corp2.t2u(l.P21Zip),  corp2.t2u(l.P22Zip),  corp2.t2u(l.P23Zip),  corp2.t2u(l.P24Zip),
																		corp2.t2u(l.P25Zip),  corp2.t2u(l.P26Zip),  corp2.t2u(l.P27Zip),  corp2.t2u(l.P28Zip),  corp2.t2u(l.P29Zip),  corp2.t2u(l.P30Zip),  corp2.t2u(l.P31Zip),  corp2.t2u(l.P32Zip));
		  self           := l;
			self 					 := [];
		end;
		
		normPartnership	:= normalize(dPartnership, 32, normContTrf(left, counter));	
		
		// Map Contacts from Partnership 	
		Corp2_Mapping.LayoutsCommon.Main cont1Trf(Corp2_Raw_ND.Layouts.normContLayout input):=transform
				,skip(Corp2_Mapping.fCleanBusinessName(state_origin,state_desc,input.norm_Name).BusinessName = '')
      self.dt_vendor_first_reported	  := (integer)fileDate;
			self.dt_vendor_last_reported	  := (integer)fileDate;
			self.dt_first_seen				      := (integer)fileDate;
			self.dt_last_seen				        := (integer)fileDate;
			self.corp_ra_dt_first_seen		  := (integer)fileDate;
			self.corp_ra_dt_last_seen		    := (integer)fileDate;
			self.corp_key					          := state_fips + '-' + corp2.t2u(input.PAID);
			self.corp_vendor					      := state_fips;
		  self.corp_state_origin          := state_origin;
			self.corp_inc_state             := state_origin;
			self.corp_process_date				  := fileDate;    
     	self.corp_orig_sos_charter_nbr  := corp2.t2u(input.PAID);
			self.corp_legal_name            := Corp2_Mapping.fCleanBusinessName(state_origin,state_desc,input.PANAME).BusinessName;
			self.cont_full_name			        := Corp2_Mapping.fCleanBusinessName(state_origin,state_desc,input.norm_Name).BusinessName;
			self.cont_address_type_cd       := if (Corp2_Mapping.fAddressExists(state_origin,state_desc,input.norm_Add1,input.norm_Add2,input.norm_City,input.norm_Stat,input.norm_Zip).ifAddressExists, 'M', '');			
			self.cont_address_type_desc     := if (Corp2_Mapping.fAddressExists(state_origin,state_desc,input.norm_Add1,input.norm_Add2,input.norm_City,input.norm_Stat,input.norm_Zip).ifAddressExists, 'MEMBER/MANAGER/PARTNER', '');
			self.cont_address_line1					:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.norm_Add1,input.norm_Add2,input.norm_City,input.norm_Stat,input.norm_Zip).AddressLine1;
			self.cont_address_line2					:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.norm_Add1,input.norm_Add2,input.norm_City,input.norm_Stat,input.norm_Zip).AddressLine2;
			self.cont_address_line3					:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.norm_Add1,input.norm_Add2,input.norm_City,input.norm_Stat,input.norm_Zip).AddressLine3;			
			self.cont_prep_addr_line1				:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.norm_Add1,input.norm_Add2,input.norm_City,input.norm_Stat,input.norm_Zip).PrepAddrLine1;			
			self.cont_prep_addr_last_line	  := Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.norm_Add1,input.norm_Add2,input.norm_City,input.norm_Stat,input.norm_Zip).PrepAddrLastLine;
			self.recordOrigin               := 'T';																			
			self                            := [];
	  end;  
	
		 // Map Contacts from FictNames 	
		 Corp2_Mapping.LayoutsCommon.Main cont2Trf(Corp2_Raw_ND.Layouts.FictNameLayoutIn input):=transform
					,skip(Corp2_Mapping.fCleanBusinessName(state_origin,state_desc,corp2.t2u(StringLib.StringFindReplace(corp2.t2u(input.FICNNAM01),'SEE PHYSICAL FILE FOR ADDITIONAL PARTNERS',''))).BusinessName = '')
      self.dt_vendor_first_reported	    := (integer)fileDate;
			self.dt_vendor_last_reported	    := (integer)fileDate;
			self.dt_first_seen				        := (integer)fileDate;
			self.dt_last_seen				          := (integer)fileDate;
			self.corp_ra_dt_first_seen		    := (integer)fileDate;
			self.corp_ra_dt_last_seen		      := (integer)fileDate;
			self.corp_key					            := state_fips + '-' + corp2.t2u(input.ESID);
			self.corp_vendor					        := state_fips;
		  self.corp_state_origin            := state_origin;
			self.corp_inc_state               := state_origin;
			self.corp_process_date				    := fileDate;    
     	self.corp_orig_sos_charter_nbr    := corp2.t2u(input.ESID);
			self.corp_legal_name              := Corp2_Mapping.fCleanBusinessName(state_origin,state_desc,input.FICNNAM).BusinessName;
			self.cont_full_name			          := Corp2_Mapping.fCleanBusinessName(state_origin,state_desc,corp2.t2u(StringLib.StringFindReplace(corp2.t2u(input.FICNNAM01),'SEE PHYSICAL FILE FOR ADDITIONAL PARTNERS',''))).BusinessName;			
			self.cont_type_cd         	      := if (self.cont_full_name <> '','O','');
			self.cont_type_desc       	      := if (self.cont_full_name <> '','OWNER','');
			self.cont_address_line1					  := Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.FICNADD1,input.FICNADD2,input.FICNCITY,input.FICNSTAT,input.FICNZIP).AddressLine1;
			self.cont_address_line2					  := Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.FICNADD1,input.FICNADD2,input.FICNCITY,input.FICNSTAT,input.FICNZIP).AddressLine2;
			self.cont_address_line3					  := Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.FICNADD1,input.FICNADD2,input.FICNCITY,input.FICNSTAT,input.FICNZIP).AddressLine3;			
			self.cont_prep_addr_line1				  := Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.FICNADD1,input.FICNADD2,input.FICNCITY,input.FICNSTAT,input.FICNZIP).PrepAddrLine1;			
			self.cont_prep_addr_last_line	    := Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.FICNADD1,input.FICNADD2,input.FICNCITY,input.FICNSTAT,input.FICNZIP).PrepAddrLastLine;
			self.recordOrigin                 := 'T';	
			self                              := [];
		 end;  

	  // Map Contacts from Trademarks 		 
	  Corp2_Mapping.LayoutsCommon.Main cont3Trf(Corp2_Raw_ND.Layouts.TradeMarkLayoutIn  input):=transform
					,skip(Corp2_Mapping.fCleanBusinessName(state_origin,state_desc,input.NNAM01).BusinessName = '')
      self.dt_vendor_first_reported	    := (integer)fileDate;
			self.dt_vendor_last_reported	    := (integer)fileDate;
			self.dt_first_seen				        := (integer)fileDate;
			self.dt_last_seen				          := (integer)fileDate;
			self.corp_ra_dt_first_seen		    := (integer)fileDate;
			self.corp_ra_dt_last_seen		      := (integer)fileDate;
			self.corp_key					            := state_fips + '-' + corp2.t2u(input.RSID);
			self.corp_vendor					        := state_fips;
		  self.corp_state_origin            := state_origin;
			self.corp_inc_state               := state_origin;
			self.corp_process_date				    := fileDate;    
     	self.corp_orig_sos_charter_nbr    := corp2.t2u(input.RSID);
			self.corp_legal_name              := Corp2_Mapping.fCleanBusinessName(state_origin,state_desc,input.TM_NNAM).BusinessName;
			self.cont_full_name			          := Corp2_Mapping.fCleanBusinessName(state_origin,state_desc,input.NNAM01).BusinessName;
			self.cont_type_cd         	      := if (self.cont_full_name<>'','O','');
			self.cont_type_desc       	      := if (self.cont_full_name<>'','OWNER','');
			self.cont_address_line1					  := Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.OADD1,input.OADD2,input.OCITY,input.OSTAT,input.OZIP).AddressLine1;
			self.cont_address_line2					  := Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.OADD1,input.OADD2,input.OCITY,input.OSTAT,input.OZIP).AddressLine2;
			self.cont_address_line3					  := Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.OADD1,input.OADD2,input.OCITY,input.OSTAT,input.OZIP).AddressLine3;			
			self.cont_prep_addr_line1				  := Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.OADD1,input.OADD2,input.OCITY,input.OSTAT,input.OZIP).PrepAddrLine1;			
			self.cont_prep_addr_last_line	    := Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.OADD1,input.OADD2,input.OCITY,input.OSTAT,input.OZIP).PrepAddrLastLine;
			self.recordOrigin                 := 'T';																			
			self                              := [];
	  end;
 
		// Map Contacts from Tradenames 	
		Corp2_Mapping.LayoutsCommon.Main cont4Trf(Corp2_Raw_ND.Layouts.TradeNameLayoutIn  input):=transform
					,skip(Corp2_Mapping.fCleanBusinessName(state_origin,state_desc,input.NNAM01).BusinessName = '')
      self.dt_vendor_first_reported	    := (integer)fileDate;
			self.dt_vendor_last_reported	    := (integer)fileDate;
			self.dt_first_seen				        := (integer)fileDate;
			self.dt_last_seen				          := (integer)fileDate;
			self.corp_ra_dt_first_seen		    := (integer)fileDate;
			self.corp_ra_dt_last_seen		      := (integer)fileDate;
			self.corp_key					            := state_fips + '-' + corp2.t2u(input.PSID);
			self.corp_vendor					        := state_fips;
		  self.corp_state_origin            := state_origin;
			self.corp_inc_state               := state_origin;
			self.corp_process_date				    := fileDate;    
     	self.corp_orig_sos_charter_nbr    := corp2.t2u(input.PSID);
			self.corp_legal_name              := Corp2_Mapping.fCleanBusinessName(state_origin,state_desc,input.TN_NNAM).BusinessName;
			self.cont_full_name			          := Corp2_Mapping.fCleanBusinessName(state_origin,state_desc,input.NNAM01).BusinessName;
			self.cont_type_cd         	      := if (self.cont_full_name<>'','O','');
			self.cont_type_desc       	      := if (self.cont_full_name<>'','OWNER','');
			self.cont_address_type_cd         := if (Corp2_Mapping.fAddressExists(state_origin,state_desc,input.OADD1,input.OADD2,input.OCITY,input.OSTAT,input.OZIP).ifAddressExists,'T','');
		  self.cont_address_type_desc       := if (Corp2_Mapping.fAddressExists(state_origin,state_desc,input.OADD1,input.OADD2,input.OCITY,input.OSTAT,input.OZIP).ifAddressExists,'CONTACT','');
			self.cont_address_line1					  := Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.OADD1,input.OADD2,input.OCITY,input.OSTAT,input.OZIP).AddressLine1;
			self.cont_address_line2					  := Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.OADD1,input.OADD2,input.OCITY,input.OSTAT,input.OZIP).AddressLine2;
			self.cont_address_line3					  := Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.OADD1,input.OADD2,input.OCITY,input.OSTAT,input.OZIP).AddressLine3;			
			self.cont_prep_addr_line1				  := Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.OADD1,input.OADD2,input.OCITY,input.OSTAT,input.OZIP).PrepAddrLine1;			
			self.cont_prep_addr_last_line	    := Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.OADD1,input.OADD2,input.OCITY,input.OSTAT,input.OZIP).PrepAddrLastLine;
			self.recordOrigin                 := 'T';																			
			self                              := [];
			
		 end;	
	  //---------- End CONTACTS Mapping --------------------------------------------------------------//
		
	 
	  //---------- Begin STOCKS Mapping --------------------------------------------------------------//	 
		 
		// Normalize on the 6 sets of Stock data 	
	

		Corp2_Raw_ND.Layouts.normLayout normTrf(Corp2_Raw_ND.Layouts.CorpLayoutIN l, unsigned1 cnt) := transform
					,skip((cnt=1 and corp2.t2u(l.cshcls)   in ['','0'] and corp2.t2u(l.cshno)   in ['','0'] and
			                     corp2.t2u(l.cshpv)    in ['','0'] and corp2.t2u(l.cshnp)   in ['','0'])       
						 or (cnt=2 and corp2.t2u(l.cshcls01) in ['','0'] and corp2.t2u(l.cshno01) in ['','0'] and
			                     corp2.t2u(l.cshpv01)  in ['','0'] and corp2.t2u(l.cshnp01) in ['','0'])      
						 or (cnt=3 and corp2.t2u(l.cshcls02) in ['','0'] and corp2.t2u(l.cshno02) in ['','0'] and
			                     corp2.t2u(l.cshpv02)  in ['','0'] and corp2.t2u(l.cshnp02) in ['','0'])      
						 or (cnt=4 and corp2.t2u(l.cshcls03) in ['','0'] and corp2.t2u(l.cshno03) in ['','0'] and
			                     corp2.t2u(l.cshpv03)  in ['','0'] and corp2.t2u(l.cshnp03) in ['','0'])      
						 or (cnt=5 and corp2.t2u(l.cshcls04) in ['','0'] and corp2.t2u(l.cshno04) in ['','0'] and
			                     corp2.t2u(l.cshpv04)  in ['','0'] and corp2.t2u(l.cshnp04) in ['','0'])      
						 or (cnt=6 and corp2.t2u(l.cshcls05) in ['','0'] and corp2.t2u(l.cshno05) in ['','0'] and
			                     corp2.t2u(l.cshpv05)  in ['','0'] and corp2.t2u(l.cshnp05) in ['','0']))
			self.norm_class	    := choose(cnt, corp2.t2u(l.cshcls), corp2.t2u(l.cshcls01), corp2.t2u(l.cshcls02), corp2.t2u(l.cshcls03), corp2.t2u(l.cshcls04), corp2.t2u(l.cshcls05));
			self.norm_shares    := choose(cnt, corp2.t2u(l.cshno),  corp2.t2u(l.cshno01),  corp2.t2u(l.cshno02),  corp2.t2u(l.cshno03),  corp2.t2u(l.cshno04),  corp2.t2u(l.cshno05));	
			self.norm_par_value := choose(cnt, corp2.t2u(l.cshpv),  corp2.t2u(l.cshpv01),  corp2.t2u(l.cshpv02),  corp2.t2u(l.cshpv03),  corp2.t2u(l.cshpv04),  corp2.t2u(l.cshpv05));
			self.norm_non_par   := choose(cnt, corp2.t2u(l.cshnp),  corp2.t2u(l.cshnp01),  corp2.t2u(l.cshnp02),  corp2.t2u(l.cshnp03),  corp2.t2u(l.cshnp04),  corp2.t2u(l.cshnp05));
			self 						   	:= l;
		end;
		
		normStock	:= normalize(fCorporations, 6, normTrf(left, counter));
	  keepStock := dedup(sort(normStock, record,local), record,local);		
		 
		// Map Stock from Corporations file normlized on the 6 sets of stock data
	  Corp2_Mapping.LayoutsCommon.Stock stockTrf(Corp2_Raw_ND.Layouts.normLayout input):=transform
							,skip(corp2.t2u(input.CBSID) = '')
			self.corp_key					        := state_fips + '-' + corp2.t2u(input.CBSID);
			self.corp_vendor				      := state_fips;
			self.corp_state_origin			  := state_origin;
			self.corp_process_date			  := fileDate;
			self.corp_sos_charter_nbr		  := corp2.t2u(input.CBSID);
			self.stock_class              := corp2.t2u(input.norm_class);
									
			decimal20_6 stocksharesissued := if ((integer)corp2.t2u(input.norm_shares)= 0 or corp2.t2u(input.norm_shares) = '' 
																						,0 ,(unsigned6)corp2.t2u(input.norm_shares)/1000000);
			self.stock_shares_issued      := if ((string) stocksharesissued = '0' 
																						,'' ,corp2.t2u(StringLib.StringFindReplace((string)stocksharesissued,'*','')));
			decimal20_6 parvalue          := if ((integer)corp2.t2u(input.norm_par_value)= 0 or corp2.t2u(input.norm_par_value) = '' 
			                                  		,0 ,(unsigned6)corp2.t2u(input.norm_par_value)/1000000);
     	self.stock_par_value          := if ((string)parvalue ='0' ,'' ,corp2.t2u(StringLib.StringFindReplace((string)parvalue,'*','')));
			self.stock_non_par_value_flag := if (corp2.t2u(input.norm_non_par) in ['Y','N'] ,corp2.t2u(input.norm_non_par), '');
			self.stock_addl_info          := if (corp2.t2u(input.norm_non_par) = 'Y' ,'NO PAR VALUE SHARES' ,''); // Retained from old mapper since stock_non_par_value_flag is a new field
			self                          := [];
		end;   
		//---------- End STOCKS Mapping --------------------------------------------------------------//
			
		//---------- Begin EVENTS Mapping --------------------------------------------------------------//	 
	
	  Corp2_Mapping.LayoutsCommon.Events event1Trf(Corp2_Raw_ND.Layouts.FictNameLayoutIn input) := transform
			 ,skip(Corp2_Mapping.fValidateDate(input.ELRFD,'CCYYMMDD').PastDate = '' or
			       corp2.t2u(input.ESID) = '')
				 self.corp_key               := state_fips+'-'+corp2.t2u(input.ESID); 
				 self.corp_vendor            := state_fips;
				 self.corp_state_origin      := state_origin;
				 self.corp_process_date      := fileDate;
				 self.corp_sos_charter_nbr   := corp2.t2u(input.ESID);
				 self.event_filing_date      := Corp2_Mapping.fValidateDate(input.ELRFD,'CCYYMMDD').PastDate;
				 self.event_date_type_cd     := 'REN';																				 
				 self.event_date_type_desc   := 'RENEWAL';
				 self                        := [];
			end; 
	
		MapEvent1 := project(fFictNames, event1Trf(left));
				
	  Corp2_Mapping.LayoutsCommon.Events event2Trf(Corp2_Raw_ND.Layouts.TradeNameLayoutIn input) := transform
			 ,skip(Corp2_Mapping.fValidateDate(input.PLRD8,'CCYYMMDD').PastDate = '' or
			       corp2.t2u(input.PSID) = '')
				 self.corp_key               := state_fips+'-'+corp2.t2u(input.PSID); 
				 self.corp_vendor            := state_fips;
				 self.corp_state_origin      := state_origin;
				 self.corp_process_date      := fileDate;
				 self.corp_sos_charter_nbr   := corp2.t2u(input.PSID);
				 self.event_filing_date      := Corp2_Mapping.fValidateDate(input.PLRD8,'CCYYMMDD').PastDate;
				 self.event_date_type_cd     := 'REN';																				 
				 self.event_date_type_desc   := 'RENEWAL';
				 self                        := [];
			end; 
	
	 MapEvent2 := project(fTradenames, event2Trf(left));
	 
	 Corp2_Mapping.LayoutsCommon.Events event3Trf(Corp2_Raw_ND.Layouts.TradeMarkLayoutIn input) := transform
			 ,skip(Corp2_Mapping.fValidateDate(input.RLRFD,'CCYYMMDD').PastDate = '' or
			       corp2.t2u(input.RSID) = '')
				 self.corp_key               := state_fips+'-'+corp2.t2u(input.RSID); 
				 self.corp_vendor            := state_fips;
				 self.corp_state_origin      := state_origin;
				 self.corp_process_date      := fileDate;
				 self.corp_sos_charter_nbr   := corp2.t2u(input.RSID);
				 self.event_filing_date      := Corp2_Mapping.fValidateDate(input.RLRFD,'CCYYMMDD').PastDate;
				 self.event_date_type_cd     := 'REN';																				 
				 self.event_date_type_desc   := 'RENEWAL';
				 self                        := [];
			end; 
	
	 MapEvent3 := project(fTrademarks, event3Trf(left));
	 //---------- End EVENTS Mapping --------------------------------------------------------------//

		MapCorp1  := project(fCorporations, corp1Trf(left)) ;
		MapCorp2  := project(jFictNames,    corp2Trf(left)) ;
		MapCorp3  := project(dPartnership,  corp3Trf(left)) ;
		MapCorp4  := project(jTrademarks,   corp4Trf(left)) ;
		MapCorp5  := project(jTradenames,   corp5Trf(left)) ;
		MapCorp   := MapCorp1 + MapCorp2 + Mapcorp3 + MapCorp4 + MapCorp5;
		
		MapCont1 	:= project(normPartnership, cont1Trf(left));
	  MapCont2 	:= project(fFictNames,      cont2Trf(left));
		MapCont3 	:= project(fTrademarks,     cont3Trf(left));
		MapCont4	:= project(fTradenames,     cont4Trf(left));
		MapCont 	:= MapCont1 + MapCont2 + MapCont3 + MapCont4;
    
		
		//-----------------------------------------------------------//
		// Build the Final Mapped Files
		//-----------------------------------------------------------//
		MapMain  := dedup(sort(distribute(MapCorp + MapCont,hash(corp_key)), record,local), record,local) : independent;	
		MapStock := dedup(sort(distribute(project(keepStock, stockTrf(left)),hash(corp_key)), record,local), record,local) : independent;
	  MapEvent := dedup(sort(distribute(MapEvent1 + MapEvent2 + MapEvent3,hash(corp_key)), record,local), record,local) : independent;	

 //--------------------------------------------------------------------	
  // Scrubs for MAIN
  //--------------------------------------------------------------------
		Main_F := MapMain;
		Main_S := Scrubs_Corp2_Mapping_ND_Main.Scrubs;        // ND scrubs module
		Main_N := Main_S.FromNone(Main_F); 										// Generate the error flags
		Main_T := Main_S.FromBits(Main_N.BitmapInfile);     	// Use the FromBits module; makes my bitmap datafile easier to get to
		Main_U := Main_S.FromExpanded(Main_N.ExpandedInFile); // Pass the expanded error flags into the Expanded module

	//Outputs reports
		Main_ErrorSummary					:= output(Main_U.SummaryStats, named('Main_ErrorSummary_ND'+filedate));
		Main_ScrubErrorReport 		:= output(choosen(Main_U.AllErrors, 1000), named('Main_ScrubErrorReport_ND'+filedate));
		Main_SomeErrorValues			:= output(choosen(Main_U.BadValues, 1000), named('Main_SomeErrorValues_ND'+filedate));
		Main_IsScrubErrors		 		:= IF(count(Main_U.AllErrors)<> 0,true,false);

		// Orbit Stats
		Main_OrbitStats						:= Main_U.OrbitStats();
		
		//Outputs files
		Main_CreateBitMaps				:= output(Main_N.BitmapInfile,,'~thor_data::corp_ND_main_scrubs_bits',overwrite,compressed);	//long term storage
		Main_TranslateBitMap			:= output(Main_T);
		
    //Submits Profile's stats to Orbit
    Main_SubmitStats          := Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_ND_Main','ScrubsAlerts', Main_OrbitStats, version,'Corp_ND_Main').SubmitStats;
		
		Main_ScrubsWithExamples		:= Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_ND_Main','ScrubsAlerts', Main_OrbitStats, version,'Corp_ND_Main').CompareToProfile_with_Examples;
		
		Main_ScrubsAlert					:= Main_ScrubsWithExamples(RejectWarning = 'Y');
		Main_ScrubsAttachment			:= Scrubs.fn_email_attachment(Main_ScrubsAlert);
		Main_SendEmailFile				:= FileServices.SendEmailAttachData( corp2.Email_Notification_Lists.AttachedList
																																	 ,'Scrubs CorpMain_ND Report' //subject
																																	 ,'Scrubs CorpMain_ND Report' //body
																																	 ,(data)Main_ScrubsAttachment
																																	 ,'text/csv'
																																	 ,'CorpNDMainScrubsReport.csv'
																																	);		
																																 																													
		Main_BadRecords := Main_T.ExpandedInFile(	dt_vendor_first_reported_invalid 	  <> 0 or
																							dt_vendor_last_reported_invalid 	  <> 0 or
																							dt_first_seen_invalid 			        <> 0 or
																							dt_last_seen_invalid 			          <> 0 or
																							corp_ra_dt_first_seen_invalid 		  <> 0 or
																							corp_ra_dt_last_seen_invalid 			  <> 0 or
																							corp_trademark_renewal_date_invalid <> 0 or
																							corp_trademark_filing_date_invalid  <> 0 or
																							corp_last_renewal_date_invalid      <> 0 or
																							corp_key_invalid 			              <> 0 or
																							corp_vendor_invalid 			          <> 0 or
																							corp_state_origin_invalid 			    <> 0 or
																							corp_process_date_invalid 			    <> 0 or
																							corp_orig_sos_charter_nbr_invalid   <> 0 or
																							corp_legal_name_invalid 			      <> 0 or
																							corp_filing_date_invalid            <> 0 or
																							corp_status_cd_invalid 						  <> 0 or
																							corp_status_date_invalid            <> 0 or
																							corp_inc_state_invalid 			        <> 0 or
																							corp_inc_date_invalid               <> 0 or
																							corp_foreign_domestic_ind_invalid   <> 0 or
																							corp_forgn_date_invalid             <> 0 or
																							corp_orig_org_structure_cd_invalid  <> 0 or
																							corp_for_profit_ind_invalid 			  <> 0 or
																							corp_ln_name_type_cd_invalid        <> 0 or
																							corp_forgn_state_desc_invalid       <> 0 or
																							corp_ln_name_type_desc_invalid      <> 0 );


		Main_GoodRecords	:= Main_T.ExpandedInFile( dt_vendor_first_reported_invalid 	  = 0 and
																								dt_vendor_last_reported_invalid 	  = 0 and
																								dt_first_seen_invalid 			        = 0 and
																								dt_last_seen_invalid 			          = 0 and
																								corp_ra_dt_first_seen_invalid 		  = 0 and
																								corp_ra_dt_last_seen_invalid 			  = 0 and
																								corp_trademark_renewal_date_invalid = 0 and
																								corp_trademark_filing_date_invalid  = 0 and
																								corp_last_renewal_date_invalid      = 0 and
																								corp_key_invalid 			              = 0 and
																								corp_vendor_invalid 			          = 0 and
																								corp_state_origin_invalid 			    = 0 and
																								corp_process_date_invalid 			    = 0 and
																								corp_orig_sos_charter_nbr_invalid   = 0 and
																								corp_legal_name_invalid 			      = 0 and
																								corp_filing_date_invalid            = 0 and
																								corp_status_cd_invalid 						  = 0 and
																								corp_status_date_invalid            = 0 and
																								corp_inc_state_invalid 			        = 0 and
																								corp_inc_date_invalid               = 0 and
																								corp_foreign_domestic_ind_invalid   = 0 and
																								corp_forgn_date_invalid             = 0 and
																								corp_orig_org_structure_cd_invalid  = 0 and
																								corp_for_profit_ind_invalid 			  = 0 and
																								corp_ln_name_type_cd_invalid        = 0 and
																								corp_forgn_state_desc_invalid       = 0 and
																								corp_ln_name_type_desc_invalid      = 0 );																														 																	
																																																																						
		Main_FailBuild	:= map(corp2_mapping.fCalcPercent(count(Main_N.ExpandedInFile(corp_orig_sos_charter_nbr_invalid<>0)),count(Main_N.ExpandedInFile),false) > Scrubs_Corp2_Mapping_ND_Main.Threshold_Percent.CORP_ORIG_SOS_CHARTER_NBR => true,
													 corp2_mapping.fCalcPercent(count(Main_N.ExpandedInFile(corp_legal_name_invalid<>0)),					 count(Main_N.ExpandedInFile),false) > Scrubs_Corp2_Mapping_ND_Main.Threshold_Percent.CORP_LEGAL_NAME 					=> true,
													 corp2_mapping.fCalcPercent(count(Main_N.ExpandedInFile(corp_key_invalid<>0)),						     count(Main_N.ExpandedInFile),false) > Scrubs_Corp2_Mapping_ND_Main.Threshold_Percent.CORP_KEY 					 	      => true,
													 count(Main_GoodRecords) = 0																																																																																				          => true,
													 false );

		Main_ApprovedRecords := project(Main_GoodRecords,transform(Corp2_Mapping.LayoutsCommon.Main,self := left));
			
		Main_ALL		 						:= sequential( IF(count(Main_BadRecords) <> 0
																										,IF (poverwrite
																												,OUTPUT(Main_BadRecords,,Corp2_Mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::main_'+state_origin,overwrite,__compressed__)
																												,OUTPUT(Main_BadRecords,,Corp2_Mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::main_'+state_origin,__compressed__)
																												)
																							)
																					,output(Main_ScrubsWithExamples, all, named('CorpMainNDScrubsReportWithExamples'+filedate))
																					//Send Alerts if Scrubs exceeds thresholds
																					,IF(COUNT(Main_ScrubsAlert) > 0, Main_SendEmailFile, OUTPUT('CORP2_MAPPING.ND - No "MAIN" Corp Scrubs Alerts'))
																					,Main_ErrorSummary
																					,Main_ScrubErrorReport
																					,Main_SomeErrorValues
																					,Main_SubmitStats
																				);																	
																			
		//-------------------- Version Control -----------------------------------------------------//	
	  VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+version+'::main_ND'	  ,Main_ApprovedRecords,main_out ,,,pOverwrite);		
 	  VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+version+'::stock_ND'		,MapStock		         ,stock_out,,,pOverwrite);
		VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+version+'::event_ND'		,MapEvent		         ,event_out,,,pOverwrite);
	
	  VersionControl.macBuildNewLogicalFile('~thor_data400::failed::corp2::'+version+'::main_ND',MapMain     ,write_fail_main	,,,pOverwrite);		
			
	  mapND:= sequential(if(pshouldspray = true,Corp2_mapping.fSprayFiles(state_origin ,version,pOverwrite := pOverwrite))
												// ,Corp2_Raw_ND.Build_Bases(filedate,version,pUseProd).All  // Determined that build bases is not needed
												,main_out
												,stock_out
												,event_out
												,IF(Main_FailBuild <> true  
														,sequential( fileservices.addsuperfile(Corp2_Mapping._Dataset().thor_cluster_Files + 'in::'+Corp2_Mapping._Dataset().NameMapped+'::sprayed::stock',Corp2_Mapping._Dataset().thor_cluster_Files + 'in::corp2::'+version+'::stock_ND')
																				,fileservices.addsuperfile(Corp2_Mapping._Dataset().thor_cluster_Files + 'in::'+Corp2_Mapping._Dataset().NameMapped+'::sprayed::event',Corp2_Mapping._Dataset().thor_cluster_Files + 'in::corp2::'+version+'::event_ND')
																				,fileservices.addsuperfile(Corp2_Mapping._Dataset().thor_cluster_Files + 'in::'+Corp2_Mapping._Dataset().NameMapped+'::sprayed::main'	,Corp2_Mapping._Dataset().thor_cluster_Files + 'in::corp2::'+version+'::main_ND')																		 
																				,if (count(Main_BadRecords) <> 0 
																						 ,Corp2_Mapping.Send_Email(state_origin ,version,count(Main_BadRecords)<>0,,,,count(Main_BadRecords),,,,count(Main_ApprovedRecords),,count(mapEvent),count(mapStock)).RecordsRejected																				 
																						 ,Corp2_Mapping.Send_Email(state_origin ,version,count(Main_BadRecords)<>0,,,,count(Main_BadRecords),,,,count(Main_ApprovedRecords),,count(mapEvent),count(mapStock)).MappingSuccess	
																						 )	 
																			)
														 ,sequential( write_fail_main//if it fails on  main file threshold ,still writing mapped files!
																				 ,Corp2_Mapping.Send_Email(state_origin ,version).MappingFailed
																				)
													)
												,IF(Main_IsScrubErrors
													 ,Corp2_Mapping.Send_Email(state_origin ,version,Main_IsScrubErrors).FieldsInvalidPerScrubs)	
												,Main_All	
										);
		// File is not always received within exactly one month, so setting the file date check to allow for 35 days													
 		isFileDateValid := if((string)Std.Date.Today() between ut.date_math(filedate,-35) and ut.date_math(filedate,35),true,false);
    return sequential (if (isFileDateValid
														,mapND
														,sequential (Corp2_Mapping.Send_Email(state_origin,filedate).InvalidFileDateParm
																				,FAIL('Corp2_Mapping.ND failed.  An invalid filedate was passed in as a parameter.')))); 	

 End; //Update Function

End;//End ND Module
