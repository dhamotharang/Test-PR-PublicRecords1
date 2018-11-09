IMPORT Corp2, _validate, Address,Tools, _control, versioncontrol, ut, lib_stringlib, Corp2_Raw_GA, Scrubs, Scrubs_Corp2_Mapping_GA_Main, Scrubs_Corp2_Mapping_GA_Event, std;

EXPORT GA 	:= MODULE

EXPORT UPDATE(STRING filedate, STRING version, BOOLEAN pShouldSpray = Corp2_mapping._Dataset().bShouldSpray, BOOLEAN pOverwrite = FALSE,pUseProd = Tools._Constants.IsDataland) := FUNCTION
		 
		state_origin	   := 'GA';
		state_fips	 	   := '13';	
		state_desc	 	   := 'GEORGIA';
	  ds_AddressIn   	 := DEDUP(SORT(DISTRIBUTE(Corp2_Raw_GA.Files(filedate,pUseProd).Input.Address((STRING)(INTEGER)BizEntityId <> '0'),HASH(BizEntityId)),RECORD,LOCAL),RECORD,LOCAL) : INDEPENDENT;		
		ds_CorporationIn := DEDUP(SORT(DISTRIBUTE(Corp2_Raw_GA.Files(filedate,pUseProd).Input.Corporation.logical((STRING)(INTEGER)BizEntityId <> '0'),HASH(BizEntityId)),RECORD,LOCAL),RECORD,LOCAL) : INDEPENDENT;		
		ds_FilingIn   	 := DEDUP(SORT(DISTRIBUTE(Corp2_Raw_GA.Files(filedate,pUseProd).Input.Filing.logical((STRING)(INTEGER)BizEntityId <> '0'),HASH(BizEntityId)),RECORD,LOCAL),RECORD,LOCAL) : INDEPENDENT;		
		ds_OfficerIn   	 := DEDUP(SORT(DISTRIBUTE(Corp2_Raw_GA.Files(filedate,pUseProd).Input.Officer.logical(ControlNumber NOT IN ['0','']),HASH(ControlNumber)),RECORD,LOCAL),RECORD, EXCEPT FileNumber,LOCAL) : INDEPENDENT;		
		ds_RAgentIn   	 := DEDUP(SORT(DISTRIBUTE(Corp2_Raw_GA.Files(filedate,pUseProd).Input.RAgent.logical((STRING)(INTEGER)RegisteredAgentId <> '0'),HASH(RegisteredAgentId)),RECORD,LOCAL),RECORD,LOCAL) : INDEPENDENT;	
		ds_StockIn   		 := DEDUP(SORT(DISTRIBUTE(Corp2_Raw_GA.Files(filedate,pUseProd).Input.Stock.logical((STRING)(INTEGER)BizEntityId <> '0'),HASH(BizEntityId)),RECORD,LOCAL),RECORD,LOCAL) : INDEPENDENT;		
	
	  //********************************************************************
	  // Joining the CORPORATE file with the ADDRESS file
	  //********************************************************************
    join_corpAddr := JOIN(ds_CorporationIn ,ds_AddressIn,
												  corp2.t2u(LEFT.BizEntityId)   = corp2.t2u(RIGHT.BizEntityId) AND
													corp2.t2u(LEFT.ControlNumber) = corp2.t2u(RIGHT.ControlNumber),
												  TRANSFORM(Corp2_Raw_GA.Layouts.TempCorpAddrLayoutIn,
												            SELF := LEFT;
												            SELF := RIGHT;
												            SELF := [];),
												            LEFT OUTER,LOCAL) : INDEPENDENT;
																	
		ds_corpAddr_Has_ID := DISTRIBUTE(join_corpAddr((string)(integer)RegisteredAgentId <>'0'),HASH(RegisteredAgentId)) : INDEPENDENT;
		ds_corpAddr_No_ID	 := join_corpAddr((string)(integer)RegisteredAgentId='0') : INDEPENDENT;
		
    ds_corpAddr_NoID	 := PROJECT(ds_corpAddr_No_ID,TRANSFORM(Corp2_Raw_GA.Layouts.TempCorpAddrAgentLayoutIn,SELF := LEFT;SELF := [];));
																						 
		Corp2_Raw_GA.Layouts.TempCorpAddrAgentLayoutIn 	TCorpAddrAgent(Corp2_Raw_GA.Layouts.RAgentLayoutIn l,	Corp2_Raw_GA.Layouts.TempCorpAddrLayoutIn r ) := TRANSFORM
		 
			SELF.ra_Line1   := corp2.t2u(l.Line1);
			SELF.ra_Line2   := corp2.t2u(l.Line2);
			SELF.ra_Line3   := corp2.t2u(l.Line3);
			SELF.ra_Line4   := corp2.t2u(l.Line4);
			SELF.ra_City    := corp2.t2u(l.City);											
			SELF.ra_State   := corp2.t2u(l.State);	
			SELF.ra_Country := corp2.t2u(l.Country);
			SELF.ra_Zip     := corp2.t2u(l.Zip);

			SELF						:= r;
			SELF            := l;
		END;
	
		//********************************************************************
		// Joining the CORPORATE/ADDRESS file with the REGISTERED AGENT file
		// Note: The RAgentIn is 7 times larger than the ds_corpAddr_Has_ID
		//			 file and is therefore on the left side of the join.
		//********************************************************************
		ds_RAAgents     	 := JOIN(ds_RAgentIn,ds_corpAddr_Has_ID,
															 corp2.t2u(LEFT.RegisteredAgentId) = corp2.t2u(RIGHT.RegisteredAgentId),
															 TCorpAddrAgent(LEFT,RIGHT),RIGHT OUTER,LOCAL): INDEPENDENT;
														 
		ds_corpWithAgents	 := ds_RAAgents + ds_corpAddr_NoID : INDEPENDENT;
	
		ds_NeedsNormalized := ds_corpWithAgents(corp2.t2u(ForeignDateOfOrganization) <> '');
		ds_NotNormalized   := ds_corpWithAgents(corp2.t2u(ForeignDateOfOrganization) =  '');

		US_list 					 := ['USA','US','UNITEDSTATES'];
	
		//********************************************************************
		// Map the CORP data to the MAIN layout
		//********************************************************************
		Corp2_Mapping.LayoutsCommon.Main corpTransform_bus(Corp2_Raw_GA.Layouts.TempCorpAddrAgentLayoutIn l, INTEGER C):= TRANSFORM,
		SKIP(corp2.t2u(l.BusinessName) = '' OR corp2.t2u(l.ControlNumber) IN ['0',''] OR corp2.t2u(l.ControlNumber[1..2])='AD' OR corp2.t2u(l.ControlNumber[1..3])='CTS' OR corp2.t2u(l.ControlNumber[1..4])='CTSD')

			SELF.dt_vendor_first_reported		 	:= (INTEGER)fileDate;
			SELF.dt_vendor_last_reported		 	:= (INTEGER)fileDate;
			SELF.dt_first_seen							 	:= (INTEGER)fileDate;
			SELF.dt_last_seen								 	:= (INTEGER)fileDate;
			SELF.corp_ra_dt_first_seen			 	:= (INTEGER)fileDate;
			SELF.corp_ra_dt_last_seen				 	:= (INTEGER)fileDate;
			SELF.corp_process_date					  := fileDate;
			SELF.corp_key											:= state_fips + '-' + corp2.t2u(l.BizEntityId + l.ControlNumber);
			SELF.corp_orig_sos_charter_nbr    := corp2.t2u(l.ControlNumber);
			SELF.corp_vendor									:= state_fips;
			SELF.corp_state_origin						:= state_origin;
			SELF.corp_legal_name              := Corp2_mapping.fCleanBusinessName(state_origin,state_desc,l.BusinessName).BusinessName;			
			SELF.corp_ln_name_type_cd					:= '01';
			SELF.corp_ln_name_type_desc				:= 'LEGAL';
			SELF.corp_orig_org_structure_desc := Corp2_Raw_GA.Functions.CorpOrigOrgStructureDesc(l.BusinessTypeDesc);	
			SELF.corp_foreign_domestic_ind	  := Corp2_Raw_GA.Functions.ForeignDomesticInd(l.BusinessTypeDesc,l.ForeignCountry);
			SELF.corp_for_profit_ind					:= Corp2_Raw_GA.Functions.ProfitIndicator(l.BusinessTypeDesc);
			SELF.corp_inc_date								:= Corp2_Raw_GA.Functions.Inc_Date(l.ForeignCountry,l.BusinessTypeDesc,l.CommencementDate,l.EffectiveDate);
			SELF.corp_forgn_date							:= Corp2_Raw_GA.Functions.Forgn_Date(l.ForeignCountry,l.BusinessTypeDesc,l.CommencementDate,l.EffectiveDate);
			SELF.corp_term_exist_cd						:= MAP(corp2.t2u(l.isPerpetual) = 'TRUE'												=> 'P',
			                                         Corp2_Mapping.fValidateDate(l.EndDate).GeneralDate <> '' => 'D',
																							 '');
			SELF.corp_term_exist_exp          := Corp2_Mapping.fValidateDate(l.EndDate).GeneralDate;
			SELF.corp_term_exist_desc					:= MAP(corp2.t2u(l.isPerpetual) = 'TRUE'												=> 'PERPETUAL',
			                                         Corp2_Mapping.fValidateDate(l.EndDate).GeneralDate <> '' => 'EXPIRATION DATE',
																							 '');
			SELF.corp_inc_state								:= state_origin;
			SELF.corp_forgn_state_cd				  := IF(corp2.t2u(l.ForeignState) NOT IN [state_origin,state_desc,''],Corp2_Raw_GA.Functions.StateCode(l.ForeignState),'');
			SELF.corp_forgn_state_desc 				:= IF(corp2.t2u(l.ForeignState) NOT IN [state_origin,state_desc,''],Corp2_Raw_GA.Functions.StateDesc(l.ForeignState),'');
			SELF.corp_country_of_formation    := Corp2_Raw_GA.Functions.CountryDesc(l.ForeignCountry);
			EffDate                           := Corp2_Mapping.fValidateDate(l.EffectiveDate).PastDate;
			ForDateOfOrg                      := Corp2_Mapping.fValidateDate(l.ForeignDateOfOrganization).PastDate;
			SELF.corp_filing_date 						:= CHOOSE(C,MAP(EffDate      <> ''  => EffDate,
			                                                  ''),
																										MAP(ForDateOfOrg <> ''  => ForDateOfOrg,
																											  ''));
   		SELF.corp_filing_desc 						:= CHOOSE(C,MAP(EffDate      <> ''  => 'EFFECTIVE DATE',
			                                                  ''),
																										MAP(ForDateOfOrg <> ''  => 'HOME STATE FILING DATE',
																										  	''));
			SELF.corp_status_date 						:= Corp2_Mapping.fValidateDate(stringlib.stringfilter(l.EntityStatusDate,'0123456789'),'CCYYMMDD').PastDate;		
			SELF.corp_standing 								:= MAP(corp2.t2u(l.GoodStanding) = '1'  => 'Y',
																							 corp2.t2u(l.GoodStanding) = '0'  => 'N','');
			SELF.corp_status_desc							:= Corp2_Raw_GA.Functions.CorpStatusDesc(l.EntityStatus);
			SELF.corp_phone_number 				    := Corp2_Raw_GA.Functions.PhoneNo(l.PrimaryPhone);
			SELF.corp_email_address 					:= corp2.t2u(l.EmailAddress);
			Country														:= corp2.t2u(stringlib.stringfilter(l.Country,'ABCDEFGHIJKLMNOPQRSTUVWXYZ')); //remove blanks and special characters
			SELF.corp_address1_line1					:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.StreetAddr1,l.StreetAddr2,l.city,l.state,l.zip,Country).AddressLine1;
			SELF.corp_address1_line2				 	:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.StreetAddr1,l.StreetAddr2,l.city,l.state,l.zip,Country).AddressLine2;
		  SELF.corp_address1_line3				  := MAP(Country = 'CONVINVALIDCOUNTRY' 																			=> '',
																							 corp2.t2u(SELF.corp_address1_line1 + SELF.corp_address1_line2) = '' 	=> '',
																							 Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.StreetAddr1,l.StreetAddr2,l.city,l.state,l.zip,Country).AddressLine3																							 
																							);
		  SELF.corp_prep_addr1_line1				:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.StreetAddr1,l.StreetAddr2,l.city,l.state,l.zip,Country).PrepAddrLine1;
			SELF.corp_prep_addr1_last_line		:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.StreetAddr1,l.StreetAddr2,l.city,l.state,l.zip,Country).PrepAddrLastLine;
 			SELF.corp_address1_type_cd        := IF(Corp2_Mapping.fAddressExists(state_origin,state_desc,l.StreetAddr1,l.StreetAddr2,l.city,l.state,l.zip,Country).ifAddressExists,'B','');
   		SELF.corp_address1_type_desc      := IF(Corp2_Mapping.fAddressExists(state_origin,state_desc,l.StreetAddr1,l.StreetAddr2,l.city,l.state,l.zip,Country).ifAddressExists,'BUSINESS','');
			SELF.corp_ra_full_name						:= Corp2_mapping.fCleanBusinessName(state_origin,state_desc,Corp2_Mapping.fRemoveSpecialChars(l.Name)).BusinessName;
			SELF.corp_agent_county            := corp2.t2u(l.CountyName);
			racountry													:= corp2.t2u(stringlib.stringfilter(l.ra_Country,'ABCDEFGHIJKLMNOPQRSTUVWXYZ')); //remove blanks and special characters
			SELF.corp_agent_country           := IF(racountry IN US_list,'US',racountry);
			SELF.corp_ra_address_line1        := Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.ra_line1,l.ra_line2,l.ra_city,l.ra_State,l.ra_zip).AddressLine1;
			SELF.corp_ra_address_line2				:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.ra_line1,l.ra_line2,l.ra_city,l.ra_State,l.ra_zip).AddressLine2;
			SELF.corp_ra_address_line3				:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.ra_line1,l.ra_line2,l.ra_city,l.ra_State,l.ra_zip).AddressLine3;
			SELF.ra_prep_addr_line1						:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.ra_line1,l.ra_line2,l.ra_city,l.ra_State,l.ra_zip).PrepAddrLine1;
			SELF.ra_prep_addr_last_line				:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.ra_line1,l.ra_line2,l.ra_city,l.ra_State,l.ra_zip).PrepAddrLastLine;
			SELF.corp_ra_address_type_cd		  := IF(Corp2_Mapping.fAddressExists(state_origin,state_desc,l.ra_line1,l.ra_line2,l.ra_city,l.ra_State,l.ra_zip).ifAddressExists ,'R','');
			SELF.corp_ra_address_type_desc		:= IF(Corp2_Mapping.fAddressExists(state_origin,state_desc,l.ra_line1,l.ra_line2,l.ra_city,l.ra_State,l.ra_zip).ifAddressExists ,'REGISTERED OFFICE','');								
			SELF.corp_ra_phone_number 				:= Corp2_Raw_GA.Functions.PhoneNo(l.PhoneNumber);
			SELF.corp_ra_email_address 				:= corp2.t2u(l.Email);
			SELF.recordorigin									:= 'C';			
			SELF                              := [];
			
		END;
		
		//***********************************************************************************************
    // "EffectiveDate"&"ForeignDateOfOrganization"  fields can be populated at the same time!
		// Normalize function being used so that single corp common field can map from those two! 
   	//***********************************************************************************************
		normCorp		:= NORMALIZE(ds_NeedsNormalized,2,corpTransform_bus(LEFT, COUNTER)) : INDEPENDENT;
		projCorp		:= PROJECT(ds_NotNormalized,corpTransform_bus(LEFT, 1)) : INDEPENDENT;
  	mapCorp   	:= normCorp + projCorp;

		//********************************************************************
		// Joining the CORPORATE file with the OFFICERS file
		// Note: The ds_OfficerIn is 11 times larger than the ds_CorpDist
		//			 file and is therefore on the left side of the join.		
		//********************************************************************
  	ds_CorpDist	:= DISTRIBUTE(ds_CorporationIn(ControlNumber not in ['0',''] OR corp2.t2u(ControlNumber[1..2])='AD' OR corp2.t2u(ControlNumber[1..3])='CTS' OR corp2.t2u(ControlNumber[1..4])='CTSD'),HASH(ControlNumber)) : INDEPENDENT;
	 
  	ds_corpOfficers          := JOIN(ds_OfficerIn,ds_CorpDist,
																		corp2.t2u(LEFT.ControlNumber) = corp2.t2u(RIGHT.ControlNumber),
																		TRANSFORM(Corp2_Raw_GA.Layouts.TempCorpOfficerLayoutIn,
																							SELF             := RIGHT;
																							SELF             := LEFT;																							
																							SELF             := [];)
																		,INNER,LOCAL) : INDEPENDENT;

	//********************************************************************
	// Map the CONT data to the MAIN layout by joining the 
	//   CORP records with the OFFICERS records.
	//********************************************************************							
  Corp2_Mapping.LayoutsCommon.Main  contactTransform(Corp2_Raw_GA.Layouts.TempCorpOfficerLayoutIn l) := TRANSFORM,
	SKIP(corp2.t2u(l.firstname+l.lastname+l.companyname) = '') 
   
	        SELF.dt_vendor_first_reported		:= (INTEGER)fileDate;
					SELF.dt_vendor_last_reported		:= (INTEGER)fileDate;
					SELF.dt_first_seen							:= (INTEGER)fileDate;
					SELF.dt_last_seen								:= (INTEGER)fileDate;
					SELF.corp_ra_dt_first_seen			:= (INTEGER)fileDate;
					SELF.corp_ra_dt_last_seen				:= (INTEGER)fileDate;
					SELF.corp_process_date					:= fileDate;
					SELF.corp_key										:= state_fips + '-' + corp2.t2u(l.BizEntityId + l.ControlNumber);
					SELF.corp_orig_sos_charter_nbr  := corp2.t2u(l.ControlNumber);
					SELF.corp_legal_name            := Corp2_mapping.fCleanBusinessName(state_origin,state_desc,l.BusinessName).BusinessName;			
					SELF.corp_vendor								:= state_fips;
					SELF.corp_state_origin					:= state_origin;			
					SELF.corp_inc_state							:= state_origin;
	        fullname                        := IF(corp2.t2u(l.FirstName) <> '' AND corp2.t2u(l.LastName) <> '',corp2.t2u(l.FirstName + ' ' + l.MiddleName + ' ' + l.LastName),corp2.t2u(l.CompanyName));
          SELF.cont_full_name             := Corp2_mapping.fCleanBusinessName(state_origin,state_desc,fullname).BusinessName;
         	SELF.cont_title1_desc     	    := IF(Corp2_Mapping.fAddressExists(state_origin,state_desc,l.Line1,l.Line2,l.city,l.State,l.zip).ifAddressExists OR SELF.cont_full_name <> '',corp2.t2u(l.Description),'');
	        SELF.cont_address_line1				  := Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.Line1,l.Line2,l.city,l.State,l.zip).AddressLine1;
					SELF.cont_address_line2				  := Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.Line1,l.Line2,l.city,l.State,l.zip).AddressLine2;
					SELF.cont_prep_addr_line1			  := Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.Line1,l.Line2,l.city,l.State,l.zip).PrepAddrLine1;
					SELF.cont_prep_addr_last_line   := Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.Line1,l.Line2,l.city,l.State,l.zip).PrepAddrLastLine;
					SELF.cont_address_type_cd       := IF(Corp2_Mapping.fAddressExists(state_origin,state_desc,l.Line1,l.Line2,l.city,l.State,l.zip).ifAddressExists ,'T','');
					SELF.cont_address_type_desc     := IF(Corp2_Mapping.fAddressExists(state_origin,state_desc,l.Line1,l.Line2,l.city,l.State,l.zip).ifAddressExists ,'CONTACT','');
					SELF.cont_type_cd							  := 'F';
					SELF.cont_type_desc						  := 'OFFICER';
					SELF.recordOrigin							  := 'T';
					SELF													  := [];
					
		END;

		mapCont		           := PROJECT(ds_corpOfficers,contactTransform(LEFT));

		mapMain              := DEDUP(SORT(DISTRIBUTE(mapCorp + mapCont,HASH(Corp_Key)),RECORD,LOCAL),RECORD,LOCAL): INDEPENDENT;

		//***********************************************************************
	  // Map the STOCK data by joining the CORPORATION file with the STOCK file
	  //***********************************************************************
	  ds_corpStock         := JOIN(ds_CorporationIn ,ds_StockIn ,
															   corp2.t2u(LEFT.BizEntityId) = corp2.t2u(RIGHT.BizEntityId) ,
																 TRANSFORM(Corp2_Raw_GA.Layouts.TempCorpStockLayoutIn,SELF:=LEFT;SELF:=RIGHT;),INNER,LOCAL): INDEPENDENT;
													 
   	//***********************************************************************
   	//Filter Corp records which do not have valid stock info! 			
		//***********************************************************************
    ds_ValidCorpStock    := ds_corpStock(StockType <> '' OR Quantity <> '' OR ShareValue <> '');	

		corp2_Mapping.LayoutsCommon.stock  StockTransform(Corp2_Raw_GA.Layouts.TempCorpStockLayoutIn  l):= TRANSFORM,
    SKIP(corp2.t2u(l.ControlNumber[1..2])='AD' OR corp2.t2u(l.ControlNumber[1..3])='CTS' OR corp2.t2u(l.ControlNumber[1..4])='CTSD')	
		
			SELF.corp_process_date		:= fileDate;	
			SELF.corp_key							:= state_fips+'-' + corp2.t2u(l.BizEntityId + l.ControlNumber);
			SELF.corp_sos_charter_nbr := corp2.t2u(l.ControlNumber);
			SELF.corp_vendor					:= state_fips;
			SELF.corp_state_origin		:= state_origin;		
			SELF.stock_authorized_nbr	:= IF((INTEGER) TRIM(l.Quantity,LEFT,RIGHT) <> 0,l.Quantity,'');															
			SELF.stock_par_value		  := IF((INTEGER) TRIM(l.ShareValue,LEFT,RIGHT) <> 0,l.ShareValue,'');
			SELF.stock_type 					:= corp2.t2u(l.StockType);
			SELF											:= [];
			
		END;	
		
		MapStock        := DEDUP(SORT(PROJECT(ds_ValidCorpStock,StockTransform(LEFT)),RECORD,LOCAL),RECORD,LOCAL): INDEPENDENT; 


    //*************************************************************************
	  // Map the EVENTS data by joining the CORPORATION file with the FILING file
	  //*************************************************************************
		corp2_Mapping.LayoutsCommon.Events   EventFilingTransform(Corp2_Raw_GA.Layouts.filingLayoutIn l):= TRANSFORM,
		SKIP(corp2.t2u(l.Description) IN ['ANNUAL REGISTRATION','AMENDED ANNUAL REGISTRATION',''] OR corp2.t2u(l.ControlNumber) IN ['0',''] OR 
				 corp2.t2u(l.ControlNumber[1..2])='AD' OR corp2.t2u(l.ControlNumber[1..3])='CTS' OR corp2.t2u(l.ControlNumber[1..4])='CTSD')
			SELF.corp_process_date					:= fileDate;																																																					
			SELF.corp_key										:= state_fips + '-' + corp2.t2u(l.BizEntityId + l.ControlNumber);
			SELF.corp_sos_charter_nbr      	:= corp2.t2u(l.ControlNumber);
			SELF.corp_vendor								:= state_fips;
			SELF.corp_state_origin					:= state_origin;
			SELF.event_filing_desc					:= corp2.t2u(l.Description);
			SELF.event_filing_date					:= Corp2_Mapping.fValidateDate(l.FiledDate).PastDate;																													
			SELF.event_date_type_cd					:= IF(Corp2_Mapping.fValidateDate(l.FiledDate).PastDate <> '','FIL','');																									
			SELF.event_date_type_desc				:= IF(Corp2_Mapping.fValidateDate(l.FiledDate).PastDate <> '','FILING', '');																								
			SELF.event_filing_reference_nbr := IF(corp2.t2u(l.FileNumber) <> 'UNKNOWN', corp2.t2u(l.FileNumber),'');
			SELF														:= [];
			
		END;
		
		MapEvent  := DEDUP(SORT(PROJECT(ds_FilingIn,EventFilingTransform(LEFT)),RECORD,LOCAL),RECORD,LOCAL) : INDEPENDENT;	

    //**********************************************************************
	  // Map the AR data by joining the CORPORATION file with the FILING file
	  //**********************************************************************
		corp2_Mapping.LayoutsCommon.AR ARTransform(Corp2_Raw_GA.Layouts.filingLayoutIn l):= TRANSFORM,
		SKIP(corp2.t2u(l.Description) NOT IN ['ANNUAL REGISTRATION','AMENDED ANNUAL REGISTRATION'] OR corp2.t2u(l.ControlNumber) IN ['0',''] OR
         corp2.t2u(l.ControlNumber[1..2])='AD' OR corp2.t2u(l.ControlNumber[1..3])='CTS' OR corp2.t2u(l.ControlNumber[1..4])='CTSD')
			SELF.corp_process_date		:= fileDate;
			SELF.corp_key							:= state_fips + '-' + corp2.t2u(l.BizEntityId + l.ControlNumber);
			SELF.corp_sos_charter_nbr := corp2.t2u(l.ControlNumber);
			SELF.corp_vendor					:= state_fips;
			SELF.corp_state_origin		:= state_origin;	
			SELF.ar_type              := corp2.t2u(l.Description);
			SELF.ar_filed_dt					:= Corp2_Mapping.fValidateDate(l.FiledDate).PastDate;																																	
			SELF.ar_report_nbr 				:= corp2.t2u(l.FileNumber);
			SELF											:= [];
			
		END;
		
		MapAR  := DEDUP(SORT(PROJECT(ds_FilingIn,ARTransform(LEFT)),RECORD,LOCAL),RECORD,LOCAL) : INDEPENDENT;	
		
	//********************************************************************
  // SCRUB MAIN
  //********************************************************************

		Main_F := mapMain;
		Main_S := Scrubs_Corp2_Mapping_GA_Main.Scrubs;					// Scrubs module
		Main_N := Main_S.FromNone(Main_F); 											// Generate the error flags
		Main_T := Main_S.FromBits(Main_N.BitmapInfile);     		// Use the FromBits module; makes my bitmap datafile easier to get to
		Main_U := Main_S.FromExpanded(Main_N.ExpandedInFile); 	// Pass the expanded error flags into the Expanded module

		//Outputs reports
		Main_ErrorSummary					:= OUTPUT(Main_U.SummaryStats, NAMED('Main_ErrorSummary_GA'+filedate));
		Main_ScrubErrorReport 		:= OUTPUT(CHOOSEN(Main_U.AllErrors, 1000), NAMED('Main_ScrubErrorReport_GA'+filedate));
		Main_SomeErrorValues			:= OUTPUT(CHOOSEN(Main_U.BadValues, 1000), NAMED('Main_SomeErrorValues_GA'+filedate));
		Main_IsScrubErrors		 		:= IF(COUNT(Main_U.AllErrors)<> 0,TRUE,FALSE);

		// Orbit Stats
		Main_OrbitStats						:= Main_U.OrbitStats();
		//Outputs files
		Main_CreateBitMaps				:= OUTPUT(Main_N.BitmapInfile,,'~thor_data::corp_GA_main_scrubs_bits',OVERWRITE,COMPRESSED);	//long term storage
		Main_TranslateBitMap			:= OUTPUT(Main_T);
		//Creates Profile's alert template for Orbit - can be copied and imported into Orbit; Only required if rules in Orbit change
		Main_AlertsCSVTemplate		:= Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_'+state_origin+'_Main','ScrubsAlerts', Main_OrbitStats, version,'Corp2_'+state_origin+'_Main').ProfileAlertsTemplate;
		//Submits Profile's stats to Orbit
		Main_SubmitStats 			  	:= Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_'+state_origin+'_Main','ScrubsAlerts', Main_OrbitStats, version,'Corp2_'+state_origin+'_Main').SubmitStats;
		Main_ScrubsWithExamples		:= Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_'+state_origin+'_Main','ScrubsAlerts', Main_OrbitStats, version,'Corp2_'+state_origin+'_Main').CompareToProfile_with_Examples;
		
		Main_ScrubsAlert					:= Main_ScrubsWithExamples(RejectWarning = 'Y');
		Main_ScrubsAttachment			:= Scrubs.fn_email_attachment(Main_ScrubsAlert);
		Main_MailFile							:= FileServices.SendEmailAttachData( corp2.Email_Notification_Lists.spray
																																	 ,'Scrubs CorpMain_GA Report' //subject
																																	 ,'Scrubs CorpMain_GA Report' //body
																																	 ,(DATA)Main_ScrubsAttachment
																																	 ,'text/csv'
																																	 ,'CorpGAMainScrubsReport.csv'
																																	 ,
																																	 ,
																																	 ,corp2.Email_Notification_Lists.spray);

		Main_BadRecords		        :=Main_N.ExpandedInFile(  dt_vendor_first_reported_Invalid 			<> 0 OR 
																												dt_vendor_last_reported_Invalid 			<> 0 OR 
																												dt_first_seen_Invalid 								<> 0 OR 
																												dt_last_seen_Invalid 									<> 0 OR 
																												corp_ra_dt_first_seen_Invalid 				<> 0 OR 
																												corp_ra_dt_last_seen_Invalid 					<> 0 OR 
																												corp_key_Invalid 											<> 0 OR 
																												corp_vendor_Invalid 									<> 0 OR 
																												corp_state_origin_Invalid 					 	<> 0 OR 
																												corp_process_date_Invalid						  <> 0 OR 
																												corp_orig_sos_charter_nbr_Invalid 		<> 0 OR 
																												corp_legal_name_Invalid 							<> 0 OR
																												corp_ln_name_type_cd_Invalid					<> 0 OR
																												corp_ln_name_type_desc_Invalid				<> 0 OR
																												corp_address1_effective_date_Invalid	<> 0 OR
																												corp_phone_number_Invalid 						<> 0 OR
																												corp_filing_date_Invalid 							<> 0 OR
																												corp_status_date_Invalid 							<> 0 OR
																												corp_inc_state_Invalid 								<> 0 OR 
																												corp_inc_date_Invalid 								<> 0 OR 
																												corp_foreign_domestic_ind_Invalid 		<> 0 OR 
																												corp_forgn_state_cd_Invalid         	<> 0 OR
																												corp_forgn_state_desc_Invalid        	<> 0 OR
																												corp_forgn_date_Invalid								<> 0 OR
																												corp_for_profit_ind_Invalid						<> 0 OR
																												corp_ra_phone_number_Invalid					<> 0 OR
																												corp_agent_assign_date_Invalid				<> 0 OR
																												corp_orig_org_structure_desc_Invalid 	<> 0 OR
																												recordorigin_Invalid 									<> 0
																											);
																																											
		Main_GoodRecords	        := Main_N.ExpandedInFile( dt_vendor_first_reported_Invalid 			= 0 AND
																												dt_vendor_last_reported_Invalid 			= 0 AND 
																												dt_first_seen_Invalid 								= 0 AND 
																												dt_last_seen_Invalid 									= 0 AND 
																												corp_ra_dt_first_seen_Invalid 				= 0 AND 
																												corp_ra_dt_last_seen_Invalid 					= 0 AND 
																												corp_key_Invalid 											= 0 AND 
																												corp_vendor_Invalid 									= 0 AND 
																												corp_state_origin_Invalid 					 	= 0 AND 
																												corp_process_date_Invalid						  = 0 AND 
																												corp_orig_sos_charter_nbr_Invalid 		= 0 AND 
																												corp_legal_name_Invalid 							= 0 AND
																												corp_ln_name_type_cd_Invalid					= 0 AND
																												corp_ln_name_type_desc_Invalid				= 0 AND
																												corp_address1_effective_date_Invalid	= 0 AND
																												corp_phone_number_Invalid 						= 0 AND
																												corp_filing_date_Invalid 							= 0 AND
																												corp_status_date_Invalid 							= 0 AND
																												corp_inc_state_Invalid 								= 0 AND 
																												corp_inc_date_Invalid 								= 0 AND 
																												corp_foreign_domestic_ind_Invalid 		= 0 AND 
																												corp_forgn_state_cd_Invalid         	= 0 AND
																												corp_forgn_state_desc_Invalid        	= 0 AND
																												corp_forgn_date_Invalid								= 0 AND
																												corp_for_profit_ind_Invalid						= 0 AND
																												corp_ra_phone_number_Invalid					= 0 AND
																												corp_agent_assign_date_Invalid				= 0 AND
																												corp_orig_org_structure_desc_Invalid 	= 0 AND
																												recordorigin_Invalid 									= 0
																											);
																												
		Main_FailBuild	          := MAP( Corp2_Mapping.fCalcPercent(COUNT(Main_N.ExpandedInFile(corp_key_invalid<>0)),COUNT(Main_N.ExpandedInFile),FALSE) 										> Scrubs_Corp2_Mapping_GA_Main.Threshold_Percent.CORP_KEY										   => TRUE,
																			Corp2_Mapping.fCalcPercent(COUNT(Main_N.ExpandedInFile(corp_orig_sos_charter_nbr_invalid<>0)),COUNT(Main_N.ExpandedInFile),FALSE) 	> Scrubs_Corp2_Mapping_GA_Main.Threshold_Percent.CORP_ORIG_SOS_CHARTER_NBR 	   => TRUE,
																			Corp2_Mapping.fCalcPercent(COUNT(Main_N.ExpandedInFile(corp_legal_name_invalid<>0)),COUNT(Main_N.ExpandedInFile),FALSE) 						> Scrubs_Corp2_Mapping_GA_Main.Threshold_Percent.CORP_LEGAL_NAME 						   => TRUE,
																			Corp2_Mapping.fCalcPercent(COUNT(Main_N.ExpandedInFile(corp_foreign_domestic_ind_invalid<>0)),COUNT(Main_N.ExpandedInFile),FALSE) 	> Scrubs_Corp2_Mapping_GA_Main.Threshold_Percent.CORP_FOREIGN_DOMESTIC_IND     => TRUE,
																			Corp2_Mapping.fCalcPercent(COUNT(Main_N.ExpandedInFile(CORP_inc_date_invalid<>0)),COUNT(Main_N.ExpandedInFile),FALSE) 							> Scrubs_Corp2_Mapping_GA_Main.Threshold_Percent.CORP_inc_date 								 => TRUE,
																			Corp2_Mapping.fCalcPercent(COUNT(Main_N.ExpandedInFile(corp_forgn_state_cd_Invalid<>0)),COUNT(Main_N.ExpandedInFile),FALSE)         > Scrubs_Corp2_Mapping_GA_Main.Threshold_Percent.corp_forgn_state_cd					 => TRUE,
																			COUNT(Main_GoodRecords) = 0																																																																																											   => TRUE,
																			FALSE
																		);

		Main_ApprovedRecords      := project(Main_GoodRecords,TRANSFORM(Corp2_Mapping.LayoutsCommon.Main,SELF := LEFT));
		
		Main_ALL        		 			:= SEQUENTIAL( IF(COUNT(Main_BadRecords) <> 0
																								,IF (poverwrite
																										,OUTPUT(Main_BadRecords,,Corp2_Mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::main_GA',OVERWRITE,__COMPRESSED__)
																										,OUTPUT(Main_BadRecords,,Corp2_Mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::main_GA',__COMPRESSED__)
																										)
																								)
																							,OUTPUT(Main_ScrubsWithExamples, ALL, NAMED('CorpMainGAScrubsReportWithExamples'+filedate))
																							,IF(COUNT(Main_ScrubsAlert) > 0, Main_MailFile, OUTPUT('CORP2_MAPPING.GA - No "MAIN" Corp Scrubs Alerts'))
																							,Main_ErrorSummary
																							,Main_ScrubErrorReport
																							,Main_SomeErrorValues																			 
																						//,Main_AlertsCSVTemplate
																						  ,Main_SubmitStats				
																					 );
	//********************************************************************
  // SCRUB EVENT
  //********************************************************************	
		Event_F := mapEvent;
		Event_S := Scrubs_Corp2_Mapping_GA_Event.Scrubs;						// Scrubs module
		Event_N := Event_S.FromNone(Event_F); 											// Generate the error flags
		Event_T := Event_S.FromBits(Event_N.BitmapInfile);     			// Use the FromBits module; makes my bitmap datafile easier to get to
		Event_U := Event_S.FromExpanded(Event_N.ExpandedInFile); 		// Pass the expanded error flags into the Expanded module
		
		//Outputs reports
		Event_ErrorSummary				:= OUTPUT(Event_U.SummaryStats, NAMED('Event_ErrorSummary_GA'+filedate));
		Event_ScrubErrorReport 		:= OUTPUT(CHOOSEN(Event_U.AllErrors, 1000), NAMED('Event_ScrubErrorReport_GA'+filedate));
		Event_SomeErrorValues			:= OUTPUT(CHOOSEN(Event_U.BadValues, 1000), NAMED('Event_SomeErrorValues_GA'+filedate));
		Event_IsScrubErrors		 		:= IF(COUNT(Event_U.AllErrors)<> 0,TRUE,FALSE);

		// Orbit Stats
		Event_OrbitStats					:= Event_U.OrbitStats();
		//Outputs files
		Event_CreateBitMaps				:= OUTPUT(Event_N.BitmapInfile,,'~thor_data::corp_GA_event_scrubs_bits',OVERWRITE,COMPRESSED);	//long term storage
		Event_TranslateBitMap			:= OUTPUT(Event_T);
		//Creates Profile's alert template for Orbit - Can be copied & imported into Orbit; Only required first time & if scrub rules change
		Event_AlertsCSVTemplate	  := Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_'+ state_origin+'_Event','ScrubsAlerts', Event_OrbitStats, version,'Corp2_'+ state_origin+'_Event').ProfileAlertsTemplate;
		//Submits Profile's stats to Orbit
		Event_SubmitStats 				:= Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_'+ state_origin+'_Event','ScrubsAlerts', Event_OrbitStats, version,'Corp2_'+ state_origin+'_Event').SubmitStats;

		Event_ScrubsWithExamples	:= Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_'+ state_origin+'_Event','ScrubsAlerts', Event_OrbitStats, version,'Corp2_'+ state_origin+'_Event').CompareToProfile_with_Examples;
	
		Event_ScrubsAlert					:= Event_ScrubsWithExamples(RejectWarning = 'Y');
		Event_ScrubsAttachment		:= Scrubs.fn_email_attachment(Event_ScrubsAlert);
		Event_MailFile						:= FileServices.SendEmailAttachData( corp2.Email_Notification_Lists.spray
																																	 ,'Scrubs CorpEvent_GA Report' //subject
																																	 ,'Scrubs CorpEvent_GA Report' //body
																																	 ,(data)Event_ScrubsAttachment
																																	 ,'text/csv'
																																	 ,'CorpGAEventScrubsReport.csv'
																																	 ,
																																	 ,
																																	 ,corp2.Email_Notification_Lists.spray
																																);

		Event_BadRecords		      := event_N.ExpandedInFile(corp_key_Invalid 							  		 <> 0 OR
																												corp_vendor_Invalid 					  		 <> 0 OR
																												corp_state_origin_Invalid 		  		 <> 0 OR
																												corp_process_date_Invalid		    		 <> 0 OR
																												corp_sos_charter_nbr_Invalid   			 <> 0 OR
																												corp_state_origin_Invalid   	  		 <> 0 OR
																												event_filing_reference_nbr_Invalid 	 <> 0 
																												);
																																											
		Event_GoodRecords	        := event_N.ExpandedInFile(corp_key_Invalid 											= 0 AND
																												corp_vendor_Invalid 									= 0 AND
																												corp_state_origin_Invalid 					 	= 0 AND
																												corp_process_date_Invalid						  = 0 AND
																												corp_sos_charter_nbr_Invalid 					= 0 AND
																												corp_state_origin_Invalid 						= 0 AND 
																												event_filing_reference_nbr_Invalid 		= 0
																												);
								
		Event_FailBuild	          := MAP( Corp2_Mapping.fCalcPercent(COUNT(event_N.ExpandedInFile(corp_key_invalid<>0)),COUNT(event_N.ExpandedInFile),FALSE) 							     > Scrubs_Corp2_Mapping_GA_event.Threshold_Percent.CORP_KEY							 			 => TRUE,
																			Corp2_Mapping.fCalcPercent(COUNT(event_N.ExpandedInFile(corp_sos_charter_nbr_invalid<>0)),COUNT(event_N.ExpandedInFile),FALSE)       > Scrubs_Corp2_Mapping_GA_event.Threshold_Percent.CORP_sos_CHARTER_NBR 	  	 => TRUE,
																			Corp2_Mapping.fCalcPercent(COUNT(event_N.ExpandedInFile(event_filing_reference_nbr_Invalid<>0)),COUNT(event_N.ExpandedInFile),FALSE) > Scrubs_Corp2_Mapping_GA_event.Threshold_Percent.event_filing_reference_nbr  => TRUE,
																			FALSE
																		);

		Event_ApprovedRecords     := PROJECT(Event_GoodRecords,TRANSFORM(Corp2_Mapping.LayoutsCommon.events,SELF := LEFT));

		Event_ALL							    := SEQUENTIAL(IF(COUNT(Event_BadRecords) <> 0
																							,IF (poverwrite
																									 ,OUTPUT(Event_BadRecords,,Corp2_Mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::event_GA',OVERWRITE,__COMPRESSED__)
																									 ,OUTPUT(Event_BadRecords,,Corp2_Mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::event_GA',__COMPRESSED__)
																									)
																								)
																						 ,OUTPUT(Event_ScrubsWithExamples, ALL, NAMED('CorpEventGAScrubsReportWithExamples'+filedate))
																						 ,IF(COUNT(Event_ScrubsAlert) > 0, Event_MailFile, OUTPUT('CORP2_MAPPING.GA - No "EVENT" Corp Scrubs Alerts'))
																						 ,Event_ErrorSummary
																						 ,Event_ScrubErrorReport
																						 ,Event_SomeErrorValues																		 
																					 //,Event_AlertsCSVTemplate
																						 ,Event_SubmitStats
																					);


	//==========================================VERSION CONTROL====================================================
	IsScrubErrors	:= IF(Event_IsScrubErrors OR Main_IsScrubErrors,TRUE,FALSE);
	
	VersionControl.macBuildNewLogicalFile(Corp2_Mapping._dataset().thor_cluster_Files + 'in::corp2::' + version + '::AR_GA', mapar	 , AR_out,,,pOverwrite);
	VersionControl.macBuildNewLogicalFile(Corp2_Mapping._dataset().thor_cluster_Files + 'in::corp2::' + version + '::Event_GA', Event_ApprovedRecords, event_out,,,pOverwrite);
	VersionControl.macBuildNewLogicalFile(Corp2_Mapping._dataset().thor_cluster_Files + 'in::corp2::' + version + '::Main_GA', Main_ApprovedRecords , main_out,,,pOverwrite);
	VersionControl.macBuildNewLogicalFile(Corp2_Mapping._dataset().thor_cluster_Files + 'in::corp2::' + version + '::Stock_GA', mapStock, stock_out,,,pOverwrite);
	
	VersionControl.macBuildNewLogicalFile(Corp2_Mapping._dataset().thor_cluster_Files + 'fail::corp2::'+version+'::Main_' 	+ state_origin	,Main_F	 ,write_fail_main  ,,,pOverwrite); 
  VersionControl.macBuildNewLogicalFile(Corp2_Mapping._dataset().thor_cluster_Files + 'fail::corp2::'+version+'::event_' 	+ state_origin	,Event_F	,write_fail_event  ,,,pOverwrite); 
   	
	mapGA:= SEQUENTIAL( IF(pshouldspray = TRUE,Corp2_mapping.fSprayFiles(state_origin,version,pOverwrite := pOverwrite))
										  //,Corp2_Raw_GA.Build_Bases(filedate,version,pUseProd).All  // Determined building of bases is not needed
											,main_out
											,event_out
											,ar_out
											,stock_out										
											,IF(Main_FailBuild <> TRUE OR Event_FailBuild <> TRUE
													,SEQUENTIAL( fileservices.addsuperfile(Corp2_Mapping._Dataset().thor_cluster_Files + 'in::'+Corp2_Mapping._Dataset().NameMapped+'::sprayed::ar'		,Corp2_Mapping._Dataset().thor_cluster_Files + 'in::corp2::'+version+'::ar_GA')
																			,fileservices.addsuperfile(Corp2_Mapping._Dataset().thor_cluster_Files + 'in::'+Corp2_Mapping._Dataset().NameMapped+'::sprayed::event'	,Corp2_Mapping._Dataset().thor_cluster_Files + 'in::corp2::'+version+'::event_GA')
																			,fileservices.addsuperfile(Corp2_Mapping._Dataset().thor_cluster_Files + 'in::'+Corp2_Mapping._Dataset().NameMapped+'::sprayed::main'	,Corp2_Mapping._Dataset().thor_cluster_Files + 'in::corp2::'+version+'::main_GA')																		 
																			,fileservices.addsuperfile(Corp2_Mapping._Dataset().thor_cluster_Files + 'in::'+Corp2_Mapping._Dataset().NameMapped+'::sprayed::stock'	,Corp2_Mapping._Dataset().thor_cluster_Files + 'in::corp2::'+version+'::stock_GA')
																			,IF(COUNT(Main_BadRecords) <> 0 OR COUNT(Event_BadRecords) <> 0 
																					,Corp2_Mapping.Send_Email(state_origin,version,COUNT(Main_BadRecords) <> 0,,COUNT(Event_BadRecords) <> 0,,COUNT(Main_BadRecords),,COUNT(Event_BadRecords),,COUNT(Main_ApprovedRecords),COUNT(mapAR),COUNT(Event_ApprovedRecords),COUNT(mapStock)).RecordsRejected																				 
																					,Corp2_Mapping.Send_Email(state_origin,version,COUNT(Main_BadRecords) <> 0,,COUNT(Event_BadRecords) <> 0,,COUNT(Main_BadRecords),,COUNT(Event_BadRecords),,COUNT(Main_ApprovedRecords),COUNT(mapAR),COUNT(Event_ApprovedRecords),COUNT(mapStock)).MappingSuccess																				 
																				 )
																			,IF(IsScrubErrors
																				 ,Corp2_mapping.Send_Email(state_origin,version,Main_IsScrubErrors,FALSE,Event_IsScrubErrors,FALSE).FieldsInvalidPerScrubs
																				 )
																		 )
													 ,SEQUENTIAL( write_fail_main		//if it fails on  main file threshold ,still writing mapped files!
																			 ,write_fail_event
																			 ,Corp2_Mapping.Send_Email(state_origin,version).MappingFailed
																			)
												)
											,Event_All
											,Main_All	
										);
										
			isFileDateValid := IF((string)std.date.today() BETWEEN ut.date_math(filedate,-90) AND ut.date_math(filedate,90),TRUE,FALSE);
			result		 			:= IF(isFileDateValid
													 ,mapGA
													 ,SEQUENTIAL (Corp2_Mapping.Send_Email(state_origin,filedate).InvalidFileDateParm
																			 ,FAIL('Corp2_Mapping.GA failed.  An invalid filedate was passed in as a parameter.')
																			 )
													);
      RETURN result;

	END;	// end of Update function

END;  // end of Module