import  tools, ut, std, versioncontrol, Corp2, Corp2_Raw_AZ, Scrubs_Corp2_Mapping_AZ_Main, Scrubs_Corp2_Mapping_AZ_Event, Scrubs;

Export AZ := MODULE; 

 Export Update(String fileDate, String version, boolean pShouldSpray = _Dataset().bShouldSpray, boolean pOverwrite = false, pUseProd = Tools._Constants.IsDataland, boolean pRunFlag = false) := function
 
  state_origin		 := 'AZ' ;
  state_fips	 		 := '04';
  state_desc	 		 := 'ARIZONA';
 
	// Vendor Input Files	 - Distribute on id field then sort and dedup on the whole record
	CorExt := dedup(sort(distribute(Corp2_Raw_AZ.Files(filedate,pUseProd).Input.COREXT.logical,hash(Entity_Number)),record,local), record,local) : independent;		
	ChgExt := dedup(sort(distribute(Corp2_Raw_AZ.Files(filedate,pUseProd).Input.CHGEXT.logical,hash(Entity_Number)),record,local), record,local) : independent;	
	FlmExt := dedup(sort(distribute(Corp2_Raw_AZ.Files(filedate,pUseProd).Input.FLMEXT.logical,hash(Entity_Number)),record,local), record,local) : independent;	
	OffExt := dedup(sort(distribute(Corp2_Raw_AZ.Files(filedate,pUseProd).Input.OFFEXT.logical,hash(Entity_Number)),record,local), record,local) : independent;	
  Inactv := dedup(sort(distribute(Corp2_Raw_AZ.Files(filedate,pUseProd).Input.INACTV.logical,hash(Entity_Number)),record,local), record,local) : independent;	
  
	//The vendor may or may not include the Inactive File when they send the data
	//Concatenate the active master records and the inactive master records whenever the vendor sends the Inactive master records
	//otherwise only use the active master records
	dAllCor := if(pRunFlag = false, CorExt, CorExt + Inactv);
 
  //------------------	
	//Begin Corp Mapping
	//------------------

	// Normalize on the two RA Addresses:  statutory agent physical and statutory agent mailing addresses											 
	Corp2_Raw_AZ.Layouts.normLayout normTrf(Corp2_Raw_AZ.Layouts.COREXT_LayoutIn l, unsigned1 cnt) := transform
	      ,skip ((cnt=2 and corp2.t2u(l.STATUTORY_AGENT_MAILING_STREET_ADDRESS_1 + l.STATUTORY_AGENT_MAILING_STREET_ADDRESS_2 +  
																	  l.STATUTORY_AGENT_MAILING_ADDRESS_CITY     + l.STATUTORY_AGENT_MAILING_ADDRESS_STATE    + 
																	  l.STATUTORY_AGENT_MAILING_ADDRESS_ZIP_CODE) = '') OR
								cnt=2 and corp2.t2u(l.STATUTORY_AGENT_MAILING_STREET_ADDRESS_1 + l.STATUTORY_AGENT_MAILING_STREET_ADDRESS_2 +  
																		l.STATUTORY_AGENT_MAILING_ADDRESS_CITY     + l.STATUTORY_AGENT_MAILING_ADDRESS_STATE    + 
																		l.STATUTORY_AGENT_MAILING_ADDRESS_ZIP_CODE) = 																	 
													corp2.t2u(l.STATUTORY_AGENT_PHYSICAL_STREET_ADDRESS_1 + l.STATUTORY_AGENT_PHYSICAL_STREET_ADDRESS_2 +  
																		l.STATUTORY_AGENT_PHYSICAL_ADDRESS_CITY     + l.STATUTORY_AGENT_PHYSICAL_ADDRESS_STATE    + 
																		l.STATUTORY_AGENT_PHYSICAL_ADDRESS_ZIP_CODE))	
												
		self.Norm_Street1 := choose(cnt ,l.STATUTORY_AGENT_PHYSICAL_STREET_ADDRESS_1 ,l.STATUTORY_AGENT_MAILING_STREET_ADDRESS_1);  
		self.Norm_Street2 := choose(cnt ,l.STATUTORY_AGENT_PHYSICAL_STREET_ADDRESS_2 ,l.STATUTORY_AGENT_MAILING_STREET_ADDRESS_2);  															 
   	self.Norm_City	  := choose(cnt ,l.STATUTORY_AGENT_PHYSICAL_ADDRESS_CITY  	 ,l.STATUTORY_AGENT_MAILING_ADDRESS_CITY);
		self.Norm_State   := choose(cnt ,l.STATUTORY_AGENT_PHYSICAL_ADDRESS_STATE    ,l.STATUTORY_AGENT_MAILING_ADDRESS_STATE);
		self.Norm_Zip     := choose(cnt ,l.STATUTORY_AGENT_PHYSICAL_ADDRESS_ZIP_CODE ,l.STATUTORY_AGENT_MAILING_ADDRESS_ZIP_CODE);
		self.Norm_Type    := choose(cnt ,'PHYS' ,'MAIL'); 
		self			        := l;
	end;
	
	normCOREXT	:= normalize(dAllCor, 2, normTrf(left, counter));		

 	 //COREXT Transform
	 corp2_Mapping.LayoutsCommon.Main CorextTrf(Corp2_Raw_AZ.Layouts.normLayout  input):=transform
	    self.dt_first_seen					   := (integer)fileDate;
			self.dt_last_seen					     := (integer)fileDate;
			self.dt_vendor_first_reported	 := (integer)fileDate;
			self.dt_vendor_last_reported	 := (integer)fileDate;
			self.corp_ra_dt_first_seen		 := (integer)fileDate;
			self.corp_ra_dt_last_seen			 := (integer)fileDate;
			self.corp_key					         := state_fips + '-' + corp2.t2u(input.ENTITY_NUMBER);
			self.corp_vendor					     := state_fips;
		  self.corp_state_origin         := state_origin;
			self.corp_process_date				 := fileDate;    
			self.corp_orig_sos_charter_nbr := corp2.t2u(input.ENTITY_NUMBER);
			self.corp_inc_state            := state_origin;
			self.corp_legal_name           := Corp2_Mapping.fCleanBusinessName(state_origin,state_desc,input.ENTITY_NAME).BusinessName;	
			self.corp_ln_name_type_cd      := '01';
			self.corp_ln_name_type_desc    := 'LEGAL';
			self.corp_inc_county           := corp2.t2u(input.KNOWN_PLACE_OF_BUSINESS_COUNTY);
			self.corp_for_profit_ind       := Corp2_Raw_AZ.Functions.GetForProfit(corp2.t2u(input.BUSINESS_TYPE));
			self.corp_foreign_domestic_ind := map(corp2.t2u(input.BUSINESS_TYPE)[1..8] = 'DOMESTIC' => 'D',
			                                      corp2.t2u(input.BUSINESS_TYPE)[1..7] = 'FOREIGN'  => 'F',
																						'');
			self.corp_status_desc          := if(corp2.t2u(input.STATUS) in ['ACTIVE','PENDING INACTIVE','INACTIVE']
																					,corp2.t2u(input.STATUS) ,'**|'+corp2.t2u(input.STATUS));
			self.corp_inc_date             := if(self.corp_foreign_domestic_ind in ['D',''] ,Corp2_Mapping.fValidateDate(input.FORMATION_DATE,'CCYY-MM-DD').PastDate ,'');
   		self.corp_forgn_date           := if(self.corp_foreign_domestic_ind = 'F' ,Corp2_Mapping.fValidateDate(input.FORMATION_DATE,'CCYY-MM-DD').PastDate ,'');
      self.corp_filing_date          := Corp2_Mapping.fValidateDate(input.APPROVAL_DATE,'CCYY-MM-DD').PastDate;
			self.corp_filing_cd            := if(self.corp_filing_date <> '' ,'P' ,'');
			self.corp_filing_desc          := if(self.corp_filing_date <> '' ,'APPROVED' ,'');
      self.corp_forgn_state_cd       := Corp2_Raw_AZ.Functions.GetStateCode(input.DOMICILE);
			self.corp_forgn_state_desc     := Corp2_Raw_AZ.Functions.GetStateDesc(input.DOMICILE);
			self.corp_orig_org_structure_desc := Corp2_Raw_AZ.Functions.GetOrgStrucDesc(corp2.t2u(input.BUSINESS_TYPE)); // Scrub to catch new types
			self.corp_purpose              := corp2.t2u(input.CHARACTER_OF_BUSINESS);
			
			bstreet1 := Corp2_Raw_AZ.Functions.FixAddrField(input.KNOWN_PLACE_OF_BUSINESS_STREET_ADDRESS_1);
			bstreet2 := Corp2_Raw_AZ.Functions.FixAddrField(input.KNOWN_PLACE_OF_BUSINESS_STREET_ADDRESS_2);
			bcity    := Corp2_Raw_AZ.Functions.FixAddrField(input.KNOWN_PLACE_OF_BUSINESS_CITY);
			bstate   := Corp2_Raw_AZ.Functions.FixAddrField(input.KNOWN_PLACE_OF_BUSINESS_STATE);
			bzip     := Corp2_Raw_AZ.Functions.FixAddrField(input.KNOWN_PLACE_OF_BUSINESS_ZIP_CODE);
			self.corp_address1_type_cd     := if(Corp2_Mapping.fAddressExists(state_origin,state_desc,bstreet1,bstreet2,bcity,bstate,bzip).ifAddressExists,'B','');	
			self.corp_address1_type_desc   := if(Corp2_Mapping.fAddressExists(state_origin,state_desc,bstreet1,bstreet2,bcity,bstate,bzip).ifAddressExists,'BUSINESS','');
			self.corp_address1_line1			 := Corp2_Mapping.fCleanAddress(state_origin,state_desc,bstreet1,bstreet2,bcity,bstate,bzip).AddressLine1;
			self.corp_address1_line2			 := Corp2_Mapping.fCleanAddress(state_origin,state_desc,bstreet1,bstreet2,bcity,bstate,bzip).AddressLine2;
			self.corp_address1_line3			 := Corp2_Mapping.fCleanAddress(state_origin,state_desc,bstreet1,bstreet2,bcity,bstate,bzip).AddressLine3;			
			self.corp_prep_addr1_line1		 := Corp2_Mapping.fCleanAddress(state_origin,state_desc,bstreet1,bstreet2,bcity,bstate,bzip).PrepAddrLine1;			
			self.corp_prep_addr1_last_line := Corp2_Mapping.fCleanAddress(state_origin,state_desc,bstreet1,bstreet2,bcity,bstate,bzip).PrepAddrLastLine;
	
			mstreet1 := Corp2_Raw_AZ.Functions.FixAddrField(input.PRINCIPAL_STREET_ADDRESS_1);
			mstreet2 := Corp2_Raw_AZ.Functions.FixAddrField(input.PRINCIPAL_STREET_ADDRESS_2);
			mcity    := Corp2_Raw_AZ.Functions.FixAddrField(input.PRINCIPAL_ADDRESS_CITY);
			mstate   := Corp2_Raw_AZ.Functions.FixAddrField(input.PRINCIPAL_ADDRESS_STATE);
			mzip     := Corp2_Raw_AZ.Functions.FixAddrField(input.PRINCIPAL_ADDRESS_ZIP_CODE);
			self.corp_address2_type_cd     := if(Corp2_Mapping.fAddressExists(state_origin,state_desc,mstreet1,mstreet2,mcity,mstate,mzip).ifAddressExists,'M','');	
			self.corp_address2_type_desc   := if(Corp2_Mapping.fAddressExists(state_origin,state_desc,mstreet1,mstreet2,mcity,mstate,mzip).ifAddressExists,'MAILING','');
			self.corp_address2_line1			 := Corp2_Mapping.fCleanAddress(state_origin,state_desc,mstreet1,mstreet2,mcity,mstate,mzip).AddressLine1;
			self.corp_address2_line2			 := Corp2_Mapping.fCleanAddress(state_origin,state_desc,mstreet1,mstreet2,mcity,mstate,mzip).AddressLine2;
			self.corp_address2_line3			 := Corp2_Mapping.fCleanAddress(state_origin,state_desc,mstreet1,mstreet2,mcity,mstate,mzip).AddressLine3;			
			self.corp_prep_addr2_line1		 := Corp2_Mapping.fCleanAddress(state_origin,state_desc,mstreet1,mstreet2,mcity,mstate,mzip).PrepAddrLine1;			
			self.corp_prep_addr2_last_line := Corp2_Mapping.fCleanAddress(state_origin,state_desc,mstreet1,mstreet2,mcity,mstate,mzip).PrepAddrLastLine;
	
			self.corp_ra_full_name         := Corp2_Mapping.fCleanBusinessName(state_origin,state_desc,input.STATUTORY_AGENT_NAME).BusinessName; 
		  self.corp_ra_effective_date    := if(corp2.t2u(input.STATUTORY_AGENT_STATUS) ='ACTIVE' 
																						,Corp2_Mapping.fValidateDate(input.STATUTORY_AGENT_STATUS_DATE,'MM/DD/CCYY').PastDate ,'');			
			self.corp_ra_resign_date       := if(corp2.t2u(input.STATUTORY_AGENT_STATUS) ='RESIGNED' 
																						,Corp2_Mapping.fValidateDate(input.STATUTORY_AGENT_STATUS_DATE,'MM/DD/CCYY').PastDate ,'');			
   		self.corp_agent_status_desc    := corp2.t2u(input.STATUTORY_AGENT_STATUS);
			self.corp_ra_addl_info         := if(corp2.t2u(input.STATUTORY_AGENT_STATUS) <> '' ,'AGENT\'S STATUS: ' + corp2.t2u(input.STATUTORY_AGENT_STATUS) ,'');
			
			rstreet1 := Corp2_Raw_AZ.Functions.FixAddrField(input.Norm_Street1);
			rstreet2 := Corp2_Raw_AZ.Functions.FixAddrField(input.Norm_Street2);
			rcity    := Corp2_Raw_AZ.Functions.FixAddrField(input.Norm_City);
			rstate   := Corp2_Raw_AZ.Functions.FixAddrField(input.Norm_State);
			rzip     := Corp2_Raw_AZ.Functions.FixAddrField(input.Norm_Zip);
	    ra_AddrExists                  := Corp2_Mapping.fAddressExists(state_origin,state_desc,rstreet1,rstreet2,rcity,rstate,rzip).ifAddressExists; 
			self.corp_ra_address_type_cd	 := if(ra_AddrExists ,case(input.Norm_type, 'PHYS'=>'R', 'MAIL'=>'M', '') ,'');
			self.corp_ra_address_type_desc := if(ra_AddrExists ,case(input.Norm_type, 'PHYS'=>'REGISTERED OFFICE', 'MAIL'=>'MAILING ADDRESS', '') ,'');
			self.corp_ra_address_line1		 := Corp2_Mapping.fCleanAddress(state_origin,state_desc,rstreet1,rstreet2,rcity,rstate,rzip).AddressLine1;
			self.corp_ra_address_line2		 := Corp2_Mapping.fCleanAddress(state_origin,state_desc,rstreet1,rstreet2,rcity,rstate,rzip).AddressLine2;
			self.corp_ra_address_line3		 := Corp2_Mapping.fCleanAddress(state_origin,state_desc,rstreet1,rstreet2,rcity,rstate,rzip).AddressLine3;			
			self.ra_prep_addr_line1				 := Corp2_Mapping.fCleanAddress(state_origin,state_desc,rstreet1,rstreet2,rcity,rstate,rzip).PrepAddrLine1;			
			self.ra_prep_addr_last_line	   := Corp2_Mapping.fCleanAddress(state_origin,state_desc,rstreet1,rstreet2,rcity,rstate,rzip).PrepAddrLastLine;

			self.recordOrigin              := 'C';
			self                           := [];
  end;  
 
  MapCOREXT := project(normCOREXT, CorextTrf(left)) ;
	
  //CHGEXT Transform
		jCHGEXT	:= join(CHGEXT, dAllCor, 
										corp2.t2u(left.ENTITY_NUMBER) = corp2.t2u(right.ENTITY_NUMBER),
										transform(Corp2_Raw_AZ.Layouts.CHGEXT_TempLay, self:=left; self:=right; self:=[];),
										left outer,local) : independent;
										
    corp2_Mapping.LayoutsCommon.Main ChgextTrf(Corp2_Raw_AZ.Layouts.CHGEXT_TempLay  input):=transform, 
		      skip( (corp2.t2u(input.ENTITY_NAME) = corp2.t2u(input.CURRENT_NAME) and 
								 corp2.t2u(input.CHANGE_TYPE) not in ['DOMESTICATED FROM','DOMESTICATED TO']) 
						or   corp2.t2u(input.ENTITY_NAME) = '' )
						
			self.dt_first_seen					   := (integer)fileDate;
			self.dt_last_seen					     := (integer)fileDate;
			self.dt_vendor_first_reported	 := (integer)fileDate;
			self.dt_vendor_last_reported	 := (integer)fileDate;
			self.corp_ra_dt_first_seen		 := (integer)fileDate;
			self.corp_ra_dt_last_seen			 := (integer)fileDate;
			self.corp_key					         := state_fips + '-' + corp2.t2u(input.ENTITY_NUMBER);
			self.corp_vendor					     := state_fips;
		  self.corp_state_origin         := state_origin;
			self.corp_process_date				 := fileDate;    
			self.corp_orig_sos_charter_nbr := corp2.t2u(input.ENTITY_NUMBER);
			self.corp_inc_state            := state_origin;    
			self.corp_legal_name           := Corp2_Mapping.fCleanBusinessName(state_origin,state_desc,input.ENTITY_NAME).BusinessName;
			self.corp_ln_name_type_cd      := map(corp2.t2u(input.CHANGE_TYPE) in ['CHANGED FROM',
																																						 'CHANGED TO',
																																						 'CONSOLIDATED FROM',
																																						 'CONVERTED FROM',
																																						 'DOMESTICATED FROM'] => 'P',
																						corp2.t2u(input.CHANGE_TYPE) in ['CONSOLIDATED TO',
																						                                 'MERGED TO']         => 'S',
																						corp2.t2u(input.CHANGE_TYPE) in ['MERGED FROM']       => 'NS',
																						corp2.t2u(input.CHANGE_TYPE) in ['CONVERTED TO']      => 'C',
																						corp2.t2u(input.CHANGE_TYPE) in ['DIVIDED TO']        => 'D',
																						corp2.t2u(input.CHANGE_TYPE) in ['DOMESTICATED TO']   => 'DT',
																						corp2.t2u(input.CHANGE_TYPE) in ['DIVIDED FROM']      => 'I',
			  																		'');
			self.corp_ln_name_type_desc    := map(self.corp_ln_name_type_cd = 'P'  => 'PRIOR',
																						self.corp_ln_name_type_cd = 'S'  => 'SURVIVOR',
																						self.corp_ln_name_type_cd = 'NS' => 'NON-SURVIVOR',
																						self.corp_ln_name_type_cd = 'C'  => 'CONVERTED TO',
																						self.corp_ln_name_type_cd = 'D'  => 'DIVIDED TO',
																						self.corp_ln_name_type_cd = 'DT' => 'DOMESTICATED TO',
																						self.corp_ln_name_type_cd = 'I'  => 'OTHER',
			  																		'**|'+corp2.t2u(input.CHANGE_TYPE));   
  		self.corp_filing_date          := Corp2_Mapping.fValidateDate(input.CHANGE_DATE,'CCYY-MM-DD').PastDate; // retained from old mapper
			self.corp_inc_date             := if(corp2.t2u(input.BUSINESS_TYPE)[1..7] <> 'FOREIGN' ,Corp2_Mapping.fValidateDate(input.FORMATION_DATE,'CCYY-MM-DD').PastDate ,'');
   		self.corp_forgn_date           := if(corp2.t2u(input.BUSINESS_TYPE)[1..7]  = 'FOREIGN' ,Corp2_Mapping.fValidateDate(input.FORMATION_DATE,'CCYY-MM-DD').PastDate ,'');
      self.recordOrigin              := 'C';
			self                           := [];
	 end; 
	 
	 MapCHGEXT := dedup(sort(distribute(project(jCHGEXT , ChgextTrf(left)),hash(corp_key)), record,local), record,local) : independent;
	
	 MapCorp := MapCOREXT + MapCHGEXT;
	 	  
  //End Corp Mapping


	//---------------------	
	//Begin Contact Mapping
	//---------------------
		
		// Join the COREXT and OFFEXT files
		joinOffextCorext 	:= join(dAllCor, OFFEXT,
												 corp2.t2u(left.ENTITY_NUMBER) = corp2.t2u(right.ENTITY_NUMBER),											
												 transform(Corp2_Raw_AZ.Layouts.OFFEXT_COREXT,
												 self := left;	self := right; self := [];),
												 inner, local) ;
	
		corp2_Mapping.LayoutsCommon.Main ContactTrf(Corp2_Raw_AZ.Layouts.OFFEXT_COREXT  input):=transform
		    ,skip(Corp2_Mapping.fCleanBusinessName(state_origin,state_desc,input.OFFICER_NAME).BusinessName = '' or
				      corp2.t2u(input.ENTITY_NUMBER) = '')
		  self.dt_first_seen					   := (integer)fileDate;
			self.dt_last_seen					     := (integer)fileDate;
			self.dt_vendor_first_reported	 := (integer)fileDate;
			self.dt_vendor_last_reported	 := (integer)fileDate;
			self.corp_ra_dt_first_seen		 := (integer)fileDate;
			self.corp_ra_dt_last_seen			 := (integer)fileDate;
		  self.corp_key					         := state_fips + '-' + corp2.t2u(input.ENTITY_NUMBER);
			self.corp_vendor				       := state_fips;
			self.corp_state_origin		     := state_origin;
			self.corp_inc_state            := state_origin;
			self.corp_process_date		     := fileDate;
			self.corp_orig_sos_charter_nbr := corp2.t2u(input.ENTITY_NUMBER);
			self.corp_legal_name           := Corp2_Mapping.fCleanBusinessName(state_origin,state_desc,input.ENTITY_NAME).BusinessName; 
			self.cont_title1_desc					 := corp2.t2u(input.OFFICER_TITLE);
	    self.cont_full_name            := Corp2_Mapping.fCleanBusinessName(state_origin,state_desc,input.OFFICER_NAME).BusinessName;
			self.cont_type_cd              := 'F';
     	self.cont_type_desc            := 'OFFICER';
			
			cstreet1 := Corp2_Raw_AZ.Functions.FixAddrField(input.OFFICER_ADDRESS_1);
			cstreet2 := Corp2_Raw_AZ.Functions.FixAddrField(input.OFFICER_ADDRESS_2);
			ccity    := Corp2_Raw_AZ.Functions.FixAddrField(input.OFFICER_CITY);
			cstate   := Corp2_Raw_AZ.Functions.FixAddrField(input.OFFICER_STATE);
			czip     := Corp2_Raw_AZ.Functions.FixAddrField(input.OFFICER_ZIP_CODE);
			self.cont_address_type_cd      := if (Corp2_Mapping.fAddressExists(state_origin,state_desc,cstreet1,cstreet2,ccity,cstate,czip).ifAddressExists,'T','');
			self.cont_address_type_desc    := if (Corp2_Mapping.fAddressExists(state_origin,state_desc,cstreet1,cstreet2,ccity,cstate,czip).ifAddressExists,'CONTACT','');
			self.cont_address_line1			   := Corp2_Mapping.fCleanAddress(state_origin,state_desc,cstreet1,cstreet2,ccity,cstate,czip).AddressLine1;
			self.cont_address_line2			   := Corp2_Mapping.fCleanAddress(state_origin,state_desc,cstreet1,cstreet2,ccity,cstate,czip).AddressLine2;
			self.cont_address_line3			   := Corp2_Mapping.fCleanAddress(state_origin,state_desc,cstreet1,cstreet2,ccity,cstate,czip).AddressLine3;
			self.cont_prep_addr_line1			 := Corp2_Mapping.fCleanAddress(state_origin,state_desc,cstreet1,cstreet2,ccity,cstate,czip).PrepAddrLine1;
			self.cont_prep_addr_last_line	 := Corp2_Mapping.fCleanAddress(state_origin,state_desc,cstreet1,cstreet2,ccity,cstate,czip).PrepAddrLastLine;
			self.recordOrigin              := 'T';
			self                           := [];
		end;  
		
		MapCont 	:= project(joinOffextCorext, ContactTrf(left));
  //End Contact Mapping

		
	//-------------------
	//Begin Event Mapping
	//-------------------
																			 
    //CHGEXT Event records
		//--------------------
		corp2_Mapping.LayoutsCommon.Events EventTrfCHG(Corp2_Raw_AZ.Layouts.CHGEXT_LayoutIn input):=transform,
      skip( (corp2.t2u(input.ENTITY_NAME) = corp2.t2u(input.CURRENT_NAME) and 
						 corp2.t2u(input.CHANGE_TYPE) not in ['DOMESTICATED FROM','DOMESTICATED TO']) )			
						 
		  self.corp_key					    := state_fips + '-' + corp2.t2u(input.ENTITY_NUMBER);
			self.corp_vendor				  := state_fips;
			self.corp_state_origin		:= state_origin;
			self.corp_process_date		:= fileDate;
			self.corp_sos_charter_nbr	:= corp2.t2u(input.ENTITY_NUMBER);
			self.event_desc           := corp2.t2u(input.CHANGE_TYPE + ' ' + Corp2_Mapping.fCleanBusinessName(state_origin,state_desc,input.ENTITY_NAME).BusinessName);
			self.event_filing_date    := Corp2_Mapping.fValidateDate(input.CHANGE_DATE,'CCYY-MM-DD').PastDate;
			self.event_date_type_cd		:= if(self.event_filing_date <> ''
																			,map(corp2.t2u(input.CHANGE_TYPE)[1..7]  = 'CHANGED'      => 'C',
																					 corp2.t2u(input.CHANGE_TYPE)[1..12] = 'CONSOLIDATED' => 'N',
																					 corp2.t2u(input.CHANGE_TYPE)[1..9]  = 'CONVERTED'    => 'V',
																					 corp2.t2u(input.CHANGE_TYPE)[1..7]  = 'DIVIDED'      => 'D',
																					 corp2.t2u(input.CHANGE_TYPE)[1..12] = 'DOMESTICATED' => 'O',
																					 corp2.t2u(input.CHANGE_TYPE)[1..6]  = 'MERGED'       => 'M',
																			     '')
																			, '');
			self.event_date_type_desc	:= if(self.event_filing_date <> ''
																			,map(corp2.t2u(input.CHANGE_TYPE)[1..7]  = 'CHANGED'      => 'NAME CHANGE',
																					 corp2.t2u(input.CHANGE_TYPE)[1..12] = 'CONSOLIDATED' => 'CONSOLIDATION',
																					 corp2.t2u(input.CHANGE_TYPE)[1..9]  = 'CONVERTED'    => 'CONVERSION',
																					 corp2.t2u(input.CHANGE_TYPE)[1..7]  = 'DIVIDED'      => 'DIVISION',
																					 corp2.t2u(input.CHANGE_TYPE)[1..12] = 'DOMESTICATED' => 'DOMESTICATION',
																					 corp2.t2u(input.CHANGE_TYPE)[1..6]  = 'MERGED'       => 'MERGER',
																					 '')
																			, '');
			self                      := [];
		end; 
			
		MapEvent_CHG 	:= project(CHGEXT, EventTrfCHG(left));

	
	  //FLMEXT Event records	
		//---------------------
		corp2_Mapping.LayoutsCommon.Events EventTrfFLM(Corp2_Raw_AZ.Layouts.FLMEXT_LayoutIn input):=transform
					    ,skip(StringLib.StringFind(corp2.t2u(input.DOCUMENT_DESCRIPTION),'ANNUAL REPORT', 1)  <> 0  or
										StringLib.StringFind(corp2.t2u(input.DOCUMENT_DESCRIPTION),'ANNUAL RPT'   , 1)  <> 0  or
										StringLib.StringFind(corp2.t2u(input.DOCUMENT_DESCRIPTION),'ANN RPT'      , 1)  <> 0  or
										StringLib.StringFind(corp2.t2u(input.DOCUMENT_DESCRIPTION),'ANNUEL REPORT', 1)  <> 0  or
										StringLib.StringFind(corp2.t2u(input.DOCUMENT_DESCRIPTION),'ANNAUL REPORT', 1)  <> 0  or
										StringLib.StringFind(corp2.t2u(input.DOCUMENT_DESCRIPTION),'ANNUAL RPEORT', 1)  <> 0  or
										StringLib.StringFind(corp2.t2u(input.DOCUMENT_DESCRIPTION),'ANNUAL REPROT', 1)  <> 0  )
			self.corp_key					    				:= state_fips + '-' + corp2.t2u(input.ENTITY_NUMBER);
			self.corp_vendor				  				:= state_fips;
			self.corp_state_origin						:= state_origin;
			self.corp_process_date						:= fileDate;
			self.corp_sos_charter_nbr					:= corp2.t2u(input.ENTITY_NUMBER);
			self.event_filing_reference_nbr  	:= corp2.t2u(input.MICROFILM_LOCATION);
			self.event_desc           				:= corp2.t2u(input.DOCUMENT_DESCRIPTION);
			self.event_filing_date    				:= if(length(corp2.t2u(input.DATE_DOCUMENT_RECEIVED)) = 8
																						,Corp2_Mapping.fValidateDate(input.DATE_DOCUMENT_RECEIVED,'MM/DD/YY').PastDate
																						,Corp2_Mapping.fValidateDate(input.DATE_DOCUMENT_RECEIVED,'MM/DD/CCYY').PastDate);
			self.event_date_type_cd						:= 'FIL';
			self.event_date_type_desc 				:= 'FILING';
			self                      				:= [];
		end; 
			
		MapEvent_FLM 	:= project(FLMEXT(corp2.t2u(ENTITY_NUMBER) <> ''), EventTrfFLM(left));
 
	//End of Event Mapping
	
	//----------------
	//Begin AR Mapping
	//----------------
	  corp2_Mapping.LayoutsCommon.AR ARTrf(Corp2_Raw_AZ.Layouts.FLMEXT_LayoutIn input):=transform
		     ,skip((StringLib.StringFind(corp2.t2u(input.DOCUMENT_DESCRIPTION),'ANNUAL REPORT', 1) = 0  and
				        StringLib.StringFind(corp2.t2u(input.DOCUMENT_DESCRIPTION),'ANNUAL RPT'   , 1) = 0  and
							  StringLib.StringFind(corp2.t2u(input.DOCUMENT_DESCRIPTION),'ANN RPT'      , 1) = 0  and
							  StringLib.StringFind(corp2.t2u(input.DOCUMENT_DESCRIPTION),'ANNUEL REPORT', 1) = 0  and
							  StringLib.StringFind(corp2.t2u(input.DOCUMENT_DESCRIPTION),'ANNAUL REPORT', 1) = 0  and
							  StringLib.StringFind(corp2.t2u(input.DOCUMENT_DESCRIPTION),'ANNUAL RPEORT', 1) = 0  and
							  StringLib.StringFind(corp2.t2u(input.DOCUMENT_DESCRIPTION),'ANNUAL REPROT', 1) = 0) or
								corp2.t2u(input.ENTITY_NUMBER) = '')
											
			self.corp_key					    := state_fips + '-' + corp2.t2u(input.ENTITY_NUMBER);
			self.corp_vendor				  := state_fips;
			self.corp_state_origin		:= state_origin;
			self.corp_process_date		:= fileDate;
			self.corp_sos_charter_nbr	:= corp2.t2u(input.ENTITY_NUMBER);
			self.ar_comment           := if(corp2.t2u(input.MICROFILM_LOCATION) <> '', 'MICROFILM LOCATION: ' + corp2.t2u(input.MICROFILM_LOCATION), '');
		  self.ar_filed_dt          := if(length(corp2.t2u(input.DATE_DOCUMENT_RECEIVED)) = 8
																						,Corp2_Mapping.fValidateDate(input.DATE_DOCUMENT_RECEIVED,'MM/DD/YY').PastDate
																						,Corp2_Mapping.fValidateDate(input.DATE_DOCUMENT_RECEIVED,'MM/DD/CCYY').PastDate);
			self.ar_type              := corp2.t2u(input.DOCUMENT_DESCRIPTION);
			self                      := [] ;
  	end;  
	//End of AR Mapping
	
	
	//-----------------------------------------------------------//
	// Build the Final Mapped Files
	//-----------------------------------------------------------//
		MapMain  := dedup(sort(distribute(MapCorp + MapCont,hash(corp_key)), record,local), record,local) : independent;
		MapEvent := dedup(sort(distribute(MapEvent_CHG + MapEvent_FLM,hash(corp_key)), record,local), record,local) : independent;
	  MapAR    := dedup(sort(distribute(project(FLMEXT, ARTrf(left)),hash(corp_key)), record,local), record,local) : independent;
	

	//--------------------------------------------------------------------	
  // Scrubs for MAIN
  //--------------------------------------------------------------------
		Main_F := MapMain;
		Main_S := Scrubs_Corp2_Mapping_AZ_Main.Scrubs;        // Scrubs module
		Main_N := Main_S.FromNone(Main_F); 										// Generate the error flags
		Main_T := Main_S.FromBits(Main_N.BitmapInfile);     	// Use the FromBits module; makes my bitmap datafile easier to get to
		Main_U := Main_S.FromExpanded(Main_N.ExpandedInFile); // Pass the expanded error flags into the Expanded module

	//Outputs reports
		Main_ErrorSummary					:= output(Main_U.SummaryStats, named('Main_ErrorSummary_AZ'+filedate));
		Main_ScrubErrorReport 		:= output(choosen(Main_U.AllErrors, 1000), named('Main_ScrubErrorReport_AZ'+filedate));
		Main_SomeErrorValues			:= output(choosen(Main_U.BadValues, 1000), named('Main_SomeErrorValues_AZ'+filedate));
		Main_IsScrubErrors		 		:= IF(count(Main_U.AllErrors)<> 0,true,false);

		// Orbit Stats
		Main_OrbitStats						:= Main_U.OrbitStats();
		
		//Outputs files
		Main_CreateBitMaps				:= output(Main_N.BitmapInfile,,'~thor_data::corp_AZ_main_scrubs_bits',overwrite,compressed);	//long term storage
		Main_TranslateBitMap			:= output(Main_T);
	
 	  //Submits Profile's stats to Orbit
		Main_SubmitStats 					:= Scrubs.OrbitProfileStatsPost310('Scrubs_Corp2_Mapping_AZ_Main','ScrubsAlerts', Main_OrbitStats, version,'Corp_AZ_Main').SubmitStats;

	  Main_ScrubsWithExamples		:= Scrubs.OrbitProfileStatsPost310('Scrubs_Corp2_Mapping_AZ_Main','ScrubsAlerts', Main_OrbitStats, version,'Corp_AZ_Main').CompareToProfile_with_Examples;
	
		Main_ScrubsAlert					:= Main_ScrubsWithExamples(RejectWarning = 'Y');
		Main_ScrubsAttachment			:= Scrubs.fn_email_attachment(Main_ScrubsAlert);
		Main_SendEmailFile				:= FileServices.SendEmailAttachData( corp2.Email_Notification_Lists.AttachedList
																																	 ,'Scrubs CorpMain_AZ Report' //subject
																																	 ,'Scrubs CorpMain_AZ Report' //body
																																   ,(data)Main_ScrubsAttachment
																																	 ,'text/csv'
																																	 ,'CorpAZMainScrubsReport.csv'
																																	);		
																																 
		Main_BadRecords := Main_T.ExpandedInFile(	dt_vendor_first_reported_invalid 			 <> 0 or
																							dt_vendor_last_reported_invalid 			 <> 0 or
																							dt_first_seen_invalid 							 	 <> 0 or
																							dt_last_seen_invalid 									 <> 0 or
																							corp_ra_dt_first_seen_invalid 				 <> 0 or
																							corp_ra_dt_last_seen_invalid 					 <> 0 or
																							corp_key_invalid 							 				 <> 0 or
																							corp_vendor_invalid 									 <> 0 or
																							corp_state_origin_invalid 						 <> 0 or
																							corp_process_date_invalid 						 <> 0 or
																							corp_orig_sos_charter_nbr_invalid 		 <> 0 or
																							corp_legal_name_invalid 							 <> 0 or
																							corp_filing_date_invalid               <> 0 or
																							corp_status_desc_invalid               <> 0 or
																							corp_inc_state_invalid 								 <> 0 or
																							corp_inc_date_invalid 								 <> 0 or
																							corp_foreign_domestic_ind_invalid 		 <> 0 or
																							corp_forgn_date_invalid 							 <> 0 or
																							corp_for_profit_ind_invalid 					 <> 0 or
																							corp_ra_effective_date_invalid         <> 0 or
																							corp_ra_resign_date_invalid            <> 0 or
																						  corp_forgn_state_desc_invalid          <> 0 or
																							corp_ln_name_type_desc_invalid         <> 0 or
																							corp_orig_org_structure_desc_invalid   <> 0 or
																							corp_agent_status_desc_invalid         <> 0);

		Main_GoodRecords	:= Main_T.ExpandedInFile( dt_vendor_first_reported_invalid 			 = 0 and
																								dt_vendor_last_reported_invalid 			 = 0 and
																								dt_first_seen_invalid 							 	 = 0 and
																								dt_last_seen_invalid 									 = 0 and
																								corp_ra_dt_first_seen_invalid 				 = 0 and
																								corp_ra_dt_last_seen_invalid 					 = 0 and
																								corp_key_invalid 							 				 = 0 and
																								corp_vendor_invalid 									 = 0 and
																								corp_state_origin_invalid 						 = 0 and
																								corp_process_date_invalid 						 = 0 and
																								corp_orig_sos_charter_nbr_invalid 		 = 0 and
																								corp_legal_name_invalid 							 = 0 and
																								corp_filing_date_invalid               = 0 and
																								corp_status_desc_invalid               = 0 and
																								corp_inc_state_invalid 								 = 0 and
																								corp_inc_date_invalid 								 = 0 and
																								corp_foreign_domestic_ind_invalid 		 = 0 and
																								corp_forgn_date_invalid 							 = 0 and
																								corp_for_profit_ind_invalid 					 = 0 and
																								corp_ra_effective_date_invalid         = 0 and
																								corp_ra_resign_date_invalid            = 0 and
																								corp_forgn_state_desc_invalid          = 0 and
																								corp_ln_name_type_desc_invalid         = 0 and
																							  corp_orig_org_structure_desc_invalid   = 0 and
																							  corp_agent_status_desc_invalid         = 0);
			
		Main_FailBuild	:= map(corp2_mapping.fCalcPercent(count(Main_N.ExpandedInFile(corp_orig_sos_charter_nbr_invalid<>0)),count(Main_N.ExpandedInFile),false) > Scrubs_Corp2_Mapping_AZ_Main.Threshold_Percent.CORP_ORIG_SOS_CHARTER_NBR => true,
													 corp2_mapping.fCalcPercent(count(Main_N.ExpandedInFile(corp_legal_name_invalid<>0)),					 count(Main_N.ExpandedInFile),false) > Scrubs_Corp2_Mapping_AZ_Main.Threshold_Percent.CORP_LEGAL_NAME 					=> true,
													 corp2_mapping.fCalcPercent(count(Main_N.ExpandedInFile(corp_key_invalid<>0)),						     count(Main_N.ExpandedInFile),false) > Scrubs_Corp2_Mapping_AZ_Main.Threshold_Percent.CORP_KEY      						=> true,
													 count(Main_GoodRecords) = 0																																																																																				          => true,
													 false );

		Main_ApprovedRecords := project(Main_GoodRecords,transform(Corp2_Mapping.LayoutsCommon.Main,self := left));
	
		Main_RejFile_Exists		:= IF(FileServices.FileExists(Corp2_Mapping._dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::main_' + state_origin),true,false);			
	  Main_ALL		 					:= sequential(IF(count(Main_BadRecords) <> 0
																					,IF (poverwrite
																							,OUTPUT(Main_BadRecords,,Corp2_Mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::main_AZ',overwrite,__compressed__,named('Sample_Rejected_MainRecs_AZ'+filedate))
																							,sequential (IF(Main_RejFile_Exists,fileservices.deletelogicalfile(Corp2_Mapping._dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::main_'+ state_origin)),
																													 OUTPUT(Main_BadRecords,,Corp2_Mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::main_'+ state_origin,__compressed__,named('Sample_Rejected_MainRecs_AZ'+filedate)))))
																		,output(Main_ScrubsWithExamples, ALL, NAMED('CorpMainAZScrubsReportWithExamples'+filedate))																		
																		//Send Alerts if Scrubs exceeds thresholds
																		,IF(COUNT(Main_ScrubsAlert) > 0, Main_SendEmailFile, OUTPUT('CORP2_MAPPING.AZ - No "MAIN" Corp Scrubs Alerts'))
																		,Main_ErrorSummary
																		,Main_ScrubErrorReport
																		,Main_SomeErrorValues	
																		/*,Main_SubmitStats*/);
																		
	//--------------------------------------------------------------------	
  // Scrubs for Event
  //--------------------------------------------------------------------
		Event_F := MapEvent;
		Event_S := Scrubs_Corp2_Mapping_AZ_Event.Scrubs;        // AZ scrubs module
		Event_N := Event_S.FromNone(Event_F); 									// Generate the error flags
		Event_T := Event_S.FromBits(Event_N.BitmapInfile);     	// Use the FromBits module; mAZes my bitmap datafile easier to get to
		Event_U := Event_S.FromExpanded(Event_N.ExpandedInFile);// Pass the expanded error flags into the Expanded module

	//Outputs reports
		Event_ErrorSummary				:= output(Event_U.SummaryStats, named('Event_ErrorSummary_AZ'+filedate));
		Event_ScrubErrorReport 		:= output(choosen(Event_U.AllErrors, 1000), named('Event_ScrubErrorReport_AZ'+filedate));
		Event_SomeErrorValues			:= output(choosen(Event_U.BadValues, 1000), named('Event_SomeErrorValues_AZ'+filedate));
		Event_IsScrubErrors		 		:= IF(count(Event_U.AllErrors)<> 0,true,false);

		// Orbit Stats
		Event_OrbitStats						:= Event_U.OrbitStats();
		
		//Outputs files
		Event_CreateBitMaps				:= output(Event_N.BitmapInfile,,'~thor_data::corp_AZ_Event_scrubs_bits',overwrite,compressed);	//long term storage
		Event_TranslateBitMap			:= output(Event_T);
 	
    //Submits Profile's stats to Orbit
		Event_SubmitStats 				:= Scrubs.OrbitProfileStatsPost310('Scrubs_Corp2_Mapping_AZ_Event','ScrubsAlerts', Event_OrbitStats, version,'Corp_AZ_Event').SubmitStats;
			
		Event_ScrubsWithExamples	:= Scrubs.OrbitProfileStatsPost310('Scrubs_Corp2_Mapping_AZ_Event','ScrubsAlerts', Event_OrbitStats, version,'Corp_AZ_Event').CompareToProfile_with_Examples;
		
		Event_ScrubsAlert					:= Event_ScrubsWithExamples(RejectWarning = 'Y');
		Event_ScrubsAttachment		:= Scrubs.fn_email_attachment(Event_ScrubsAlert);
		Event_SendEmailFile				:= FileServices.SendEmailAttachData( corp2.Email_Notification_Lists.spray
																																	 ,'Scrubs CorpEvent_AZ Report' //subject
																																	 ,'Scrubs CorpEvent_AZ Report' //body
																																	 ,(data)Event_ScrubsAttachment
																																	 ,'text/csv'
																																	 ,'CorpAZEventScrubsReport.csv'
																																	 ,
																																	 ,
																																	 ,corp2.Email_Notification_Lists.spray
																																 );		
																																 
		Event_BadRecords := Event_T.ExpandedInFile(	corp_key_invalid  		         <> 0 or
																								corp_sos_charter_nbr_invalid   <> 0 or
																								event_date_type_cd_invalid 		 <> 0 );	

		Event_GoodRecords	:= Event_T.ExpandedInFile(corp_key_invalid  		         = 0 and
																								corp_sos_charter_nbr_invalid   = 0 and
																								event_date_type_cd_invalid		 = 0 );																					 																	
		
		Event_FailBuild	:= if(count(Event_GoodRecords) = 0,true,false);

		Event_ApprovedRecords := project(Event_GoodRecords,transform(Corp2_Mapping.LayoutsCommon.Events,self := left));		
		
		Event_RejFile_Exists			:= IF(FileServices.FileExists(Corp2_Mapping._dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::event_' + state_origin),true,false);			
	  Event_ALL									:= sequential(IF(count(Event_BadRecords)<> 0
																						 ,if(poverwrite
																								,OUTPUT(Event_BadRecords,,Corp2_Mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::event_AZ',overwrite,__compressed__,named('Sample_Rejected_Event_Recs_AZ'+filedate))
																								,sequential (IF(Event_RejFile_Exists,fileservices.deletelogicalfile(Corp2_Mapping._dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::event_'+ state_origin)),
																														 OUTPUT(Main_BadRecords,,Corp2_Mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::event_'+ state_origin,__compressed__,named('Sample_Rejected_Event_Recs_AZ'+filedate)))))
																					 ,output(Event_ScrubsWithExamples, ALL, NAMED('CorpEventAZScrubsReportWithExamples'+filedate))
																					 //Send Alerts if Scrubs exceeds thresholds
																					 ,IF(COUNT(Event_ScrubsAlert) > 0, Event_SendEmailFile, OUTPUT('CORP2_MAPPING.AZ - No "EVENT" Corp Scrubs Alerts'))
																					 ,Event_ErrorSummary
																					 ,Event_ScrubErrorReport
																					 ,Event_SomeErrorValues
																					 ,Event_SubmitStats);
																				 
	
 //-------------------- Version Control -----------------------------------------------------//	
	VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+version+'::main_az'			,Main_ApprovedRecords ,main_out		     ,,,pOverwrite);		
	VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+version+'::event_az'			,Event_ApprovedRecords,event_out	     ,,,pOverwrite);
	VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+version+'::ar_az'				,MapAR		            ,ar_out			     ,,,pOverwrite);
	
	VersionControl.macBuildNewLogicalFile('~thor_data400::failed::corp2::'+version+'::main_az'	,MapMain              ,write_fail_main ,,,pOverwrite);		
	VersionControl.macBuildNewLogicalFile('~thor_data400::failed::corp2::'+version+'::event_az'	,MapEvent	            ,write_fail_event,,,pOverwrite);
		
	mapAZ:= sequential(   if(pshouldspray = true,Corp2_mapping.fSprayFiles(state_origin ,version,pOverwrite := pOverwrite))
											 	,main_out
												,event_out
												,ar_out
												,IF(Main_FailBuild <> true or Event_FailBuild <> true
														,sequential( fileservices.addsuperfile(Corp2_Mapping._Dataset().thor_cluster_Files + 'in::'+Corp2_Mapping._Dataset().NameMapped+'::sprayed::ar'		,Corp2_Mapping._Dataset().thor_cluster_Files + 'in::corp2::'+version+'::ar_AZ')
																				,fileservices.addsuperfile(Corp2_Mapping._Dataset().thor_cluster_Files + 'in::'+Corp2_Mapping._Dataset().NameMapped+'::sprayed::event',Corp2_Mapping._Dataset().thor_cluster_Files + 'in::corp2::'+version+'::event_AZ')
																				,fileservices.addsuperfile(Corp2_Mapping._Dataset().thor_cluster_Files + 'in::'+Corp2_Mapping._Dataset().NameMapped+'::sprayed::main'	,Corp2_Mapping._Dataset().thor_cluster_Files + 'in::corp2::'+version+'::main_AZ')																		 
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
														,Corp2_Mapping.Send_Email(state_origin,version,Main_IsScrubErrors,,Event_IsScrubErrors).FieldsInvalidPerScrubs)
  											,Event_All
												,Main_All	
										);
		
 		isFileDateValid := if((string)Std.Date.Today() between ut.date_math(filedate,-35) and ut.date_math(filedate,35),true,false);
		return sequential (if (isFileDateValid
														,mapAZ
														,sequential (Corp2_Mapping.Send_Email(state_origin,filedate).InvalidFileDateParm
																				,FAIL('Corp2_Mapping.AZ failed.  An invalid filedate was passed in as a parameter.')))); 	

 End; //Update Function

End;//End AZ Module