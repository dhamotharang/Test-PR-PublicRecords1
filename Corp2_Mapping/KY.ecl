import corp2, corp2_raw_ky, scrubs, scrubs_corp2_mapping_ky_main,scrubs_corp2_mapping_ky_stock, std, tools, ut, versioncontrol;

export KY := MODULE; 

	export Update(string filedate, string version, boolean pShouldSpray = _dataset().bShouldSpray, boolean pOverwrite = false, boolean pUseProd = Tools._Constants.IsDataland) := function

		state_origin			 := 'KY';
		state_fips	 			 := '21';	
		state_desc	 			 := 'KENTUCKY';
		
	  Companies 				 := dedup(sort(distribute(Corp2_Raw_KY.Files(filedate,puseprod).Input.Companies,hash(id)),record,local),record,local)   		: independent;
	  Officer						 := dedup(sort(distribute(Corp2_Raw_KY.Files(filedate,puseprod).Input.Officer,hash(id)),record,local),record,local) 				: independent;
	  InitialOfficers		 := dedup(sort(distribute(Corp2_Raw_KY.Files(filedate,puseprod).Input.InitialOfficers,hash(id)),record,local),record,local) : independent;
		
		//Clean up and standardize the address
		Company						 := project(Companies,
																  transform(Corp2_Raw_KY.Layouts.TempCompanyLayoutIn,
																					  self.pocity 	 	:= Corp2_Raw_KY.Functions.CleanCity(left.pocity,left.postate,left.pozip);
																					  self.postate 	 	:= Corp2_Raw_KY.Functions.CleanState(left.pocity,left.postate,left.pozip);
																					  self.pozip		 	:= Corp2_Raw_KY.Functions.CleanZip(left.pocity,left.postate,left.pozip);
																					  self.pocountry 	:= Corp2_Raw_KY.Functions.Country(left.pocity,left.postate,left.pozip);
																					  self.racountry 	:= Corp2_Raw_KY.Functions.Country(left.racity,left.rastate,left.razip);
																						temporgdate			:= if(corp2.t2u(left.orgdate)<>'',Corp2_Mapping.fValidateDate(left.orgdate,'MM/DD/CCYY').PastDate,'');
																						tempauthdate		:= if(corp2.t2u(left.authdate)<>'',Corp2_Mapping.fValidateDate(left.authdate,'MM/DD/CCYY').PastDate,'');
																						//Note: if both orgdate & authdate exists, this will be handled in the NormCompanyTransform.
																						self.filingdate	:= map(corp2.t2u(temporgdate)<>''		=> corp2.t2u(temporgdate),
																																	 corp2.t2u(tempauthdate)<>''	=> corp2.t2u(tempauthdate),
																																	 ''	
																																  );
																						self.filingdesc	:= map(corp2.t2u(temporgdate)<>'' 	=> 'ORGANIZATION',
																																	 corp2.t2u(tempauthdate)<>''	=> 'AUTHORITY',
																																	 ''
																																  );
																					  self 					 := left;
																					 )
															 	 ) : independent;
																 
		//Keep only those officers that have an associated company record
		CompanyOfficers		 := join(Company,Officer,
															 left.id 				= right.id 			 and
															 left.comptype 	= right.comptype and
															 left.compseq 	= right.compseq,
															 transform(Corp2_Raw_KY.Layouts.TempCompanyOfficerLayoutIn,
																				 self 					:= right;
																				 self 					:= left;
																				),
															 inner,
															 local
															) : independent;

		//Keep only those initial officer's records that have an associated company record
		CompanyInitOfficers:= join(Company,InitialOfficers,
															 left.id 				= right.id,
															 transform(Corp2_Raw_KY.Layouts.TempCompanyInitOfficersLayoutIn,
																				 self 					:= right;
																				 self 					:= left;
																				),
															 inner,
															 local
															) : independent;

		assumed_codes := ['ACA','AKL','ALC','ALL','ANN','ASC','ASP','AST','GPA','LPA'];
		foreign_codes	:= ['FBT','FCA','FCO','FCP','FGP','FLC','FLL','FLP','FMI','FNB','FNG','FNL','FNP','FNT','FPS','FSP','FST'];
		name_types		:= ['01','02','03','04','07','11','12','13','14','23','24'];


		NeedsNormalized	:= Company(corp2.t2u(orgdate) <> '' and corp2.t2u(authdate) <> '');
		NotNormalized		:= Company(corp2.t2u(orgdate) = '' 	 or corp2.t2u(authdate) =  '');
		
		//********************************************************************
		//Normalize the Company records that have both an orgdate and an authdate.
		//********************************************************************
		Corp2_Raw_KY.Layouts.TempCompanyLayoutIn NormCompanyTransform(Corp2_Raw_KY.Layouts.TempCompanyLayoutIn  l, integer c):= transform
			self.filingdate				  				 					:= choose(c,Corp2_Mapping.fValidateDate(l.orgdate,'MM/DD/CCYY').PastDate,
																														Corp2_Mapping.fValidateDate(l.authdate,'MM/DD/CCYY').PastDate
																												 );
			self.filingdesc														:= choose(c,if(corp2.t2u(self.filingdate)<>'','ORGANIZATION',''),
																														if(corp2.t2u(self.filingdate)<>'','AUTHORITY','')
																												 );																											 
			self 																		 	:= l;
		end;
		
		NormCompany			:= normalize(NeedsNormalized,2,NormCompanyTransform(left,counter)) : independent;			
		
		FinalCompany		:= NormCompany + NotNormalized : independent;	
		
		//********************************************************************
		//Begin MAIN File processing. 
		//********************************************************************
		Corp2_mapping.LayoutsCommon.Main CorpTransform(Corp2_Raw_KY.Layouts.TempCompanyLayoutIn  l):= transform
			self.dt_vendor_first_reported							:= (integer)fileDate;
			self.dt_vendor_last_reported							:= (integer)fileDate;
			self.dt_first_seen												:= (integer)fileDate;
			self.dt_last_seen													:= (integer)fileDate;
			self.corp_ra_dt_first_seen								:= (integer)fileDate;
			self.corp_ra_dt_last_seen									:= (integer)fileDate;			
			self.corp_key															:= state_fips + '-' + corp2.t2u(l.id);
			self.corp_vendor													:= state_fips;
			self.corp_state_origin										:= state_origin;			
			self.corp_process_date										:= fileDate;
			self.corp_orig_sos_charter_nbr						:= corp2.t2u(l.id);													  						
			self.corp_legal_name											:= Corp2_mapping.fCleanBusinessName(state_origin,state_desc,l.name).BusinessName;
			self.corp_ln_name_type_cd      						:= map(corp2.t2u(l.type1) = 'REG'							=> '09',
																											 corp2.t2u(l.type1) = 'RES'							=> '07',
																											 corp2.t2u(l.type1) in [assumed_codes]	=> '06',
																											 corp2.t2u(l.type1) = 'NCR'							=> 'I',
																											 '01'
																											);
			self.corp_ln_name_type_desc     					:= map(corp2.t2u(l.type1) = 'REG'							=> 'REGISTRATION',
																											 corp2.t2u(l.type1) = 'RES'							=> 'RESERVED',
																											 corp2.t2u(l.type1) in [assumed_codes] 	=> 'ASSUMED',
																											 corp2.t2u(l.type1) = 'NCR'							=> 'OTHER',
																											 'LEGAL'
																											);
			self.corp_address1_type_cd						 		:= if(Corp2_Mapping.fAddressExists(state_origin,state_desc,l.poaddr1,l.poaddr2+' '+l.poaddr3+' '+l.poaddr4,l.pocity,l.postate,l.pozip,l.pocountry).ifAddressExists,'B','');
			self.corp_address1_type_desc					 		:= if(Corp2_Mapping.fAddressExists(state_origin,state_desc,l.poaddr1,l.poaddr2+' '+l.poaddr3+' '+l.poaddr4,l.pocity,l.postate,l.pozip,l.pocountry).ifAddressExists,'BUSINESS','');
			self.corp_address1_line1									:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.poaddr1,l.poaddr2+' '+l.poaddr3+' '+l.poaddr4,l.pocity,l.postate,l.pozip,l.pocountry).AddressLine1;
			self.corp_address1_line2				 					:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.poaddr1,l.poaddr2+' '+l.poaddr3+' '+l.poaddr4,l.pocity,l.postate,l.pozip,l.pocountry).AddressLine2;
			self.corp_address1_line3				 					:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.poaddr1,l.poaddr2+' '+l.poaddr3+' '+l.poaddr4,l.pocity,l.postate,l.pozip,l.pocountry).AddressLine3;
			self.corp_prep_addr1_line1								:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.poaddr1,l.poaddr2+' '+l.poaddr3+' '+l.poaddr4,l.pocity,l.postate,l.pozip,l.pocountry).PrepAddrLine1;
			self.corp_prep_addr1_last_line						:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.poaddr1,l.poaddr2+' '+l.poaddr3+' '+l.poaddr4,l.pocity,l.postate,l.pozip,l.pocountry).PrepAddrLastLine;
			self.corp_filing_date	  				 					:= corp2.t2u(l.filingdate);
			self.corp_filing_desc											:= corp2.t2u(l.filingdesc);
			self.corp_status_cd												:= corp2.t2u(l.status); //scrubbed												   
			self.corp_status_desc											:= Corp2_Raw_KY.Functions.CorpStatusDesc(l.status);
			self.corp_standing              					:= map(corp2.t2u(l.standing) in ['G']			=> 'Y', 
																											 corp2.t2u(l.standing) in ['B','X'] => 'N',
																											 ''
																											);
			self.corp_inc_state												:= state_origin;
			self.corp_inc_date				  							:= if(corp2.t2u(l.state) in [state_origin,'NA',''],Corp2_Mapping.fValidateDate(l.filedate,'MM/DD/CCYY').PastDate,'');			
			self.corp_term_exist_cd         					:= map(corp2.t2u(l.expdte) = ''																						=> 'P',
																											 Corp2_Mapping.fValidateDate(l.expdte,'MM/DD/CCYY').GeneralDate<>'' => 'D',
																											 ''
																											);
			self.corp_term_exist_exp        					:= Corp2_Mapping.fValidateDate(l.expdte,'MM/DD/CCYY').GeneralDate;
			self.corp_term_exist_desc       					:= map(self.corp_term_exist_cd = 'D' => 'EXPIRATION DATE',
																											 self.corp_term_exist_cd = 'P' => 'PERPETUAL',			
																											 ''
																											);
			self.corp_foreign_domestic_ind						:= map(corp2.t2u(l.state) 		in [state_origin,''] 		 and corp2.t2u(l.type1) not in [foreign_codes] =>'D',
																											 corp2.t2u(l.state) not in [state_origin,'NA',''] or corp2.t2u(l.type1) 		in [foreign_codes] =>'F',
																											 ''
																											);																										
			self.corp_forgn_state_cd        					:= if(corp2.t2u(l.state) not in [state_origin,'NA',''],Corp2_Raw_KY.Functions.CorpForgnStateCD(l.state),'');
			self.corp_forgn_state_desc        				:= if(corp2.t2u(l.state) not in [state_origin,'NA',''],Corp2_Raw_KY.Functions.CorpForgnStateDesc(l.state),'');
			self.corp_forgn_date				  						:= if(corp2.t2u(l.state) not in [state_origin,'NA',''],Corp2_Mapping.fValidateDate(l.filedate,'MM/DD/CCYY').PastDate,'');
			self.corp_forgn_term_exist_exp   					:= if(corp2.t2u(l.state) not in [state_origin,''],Corp2_Mapping.fValidateDate(l.expdte,'MM/DD/CCYY').GeneralDate,'');
			self.corp_forgn_term_exist_cd   					:= if(self.corp_term_exist_exp<>'' and corp2.t2u(l.state) not in [state_origin,''],'D','');
			self.corp_forgn_term_exist_desc 					:= if(self.corp_term_exist_exp<>'' and corp2.t2u(l.state) not in [state_origin,''],'EXPIRATION DATE','');
			self.corp_orig_org_structure_cd 					:= Corp2_Raw_KY.Functions.CorpOrigOrgStructureCD(l.type1); //scrubbed
			self.corp_orig_org_structure_desc					:= Corp2_Raw_KY.Functions.CorpOrigOrgStructureDesc(l.type1);
			self.corp_for_profit_ind      					  := map(corp2.t2u(l.profit) ='P' => 'Y',
																											 corp2.t2u(l.profit) ='N' => 'N',
																											 ''
																										  );			
			//corp_addl_info is an overloaded field
			self.corp_addl_info												:= map(corp2.t2u(l.mangnum) = '1' => 'MANAGED BY: MEMBERS',
																											 corp2.t2u(l.mangnum) = '2' => 'MANAGED BY: MANAGERS',
																											 ''
																											);
			self.corp_ra_full_name										:= Corp2_Mapping.fCleanBusinessName(state_origin,state_desc,l.raname).BusinessName;
			self.corp_ra_resign_date				  				:= Corp2_Mapping.fValidateDate(l.raresdte,'MM/DD/CCYY').PastDate;			
			self.corp_ra_address_type_cd			  			:= if(Corp2_Mapping.fAddressExists(state_origin,state_desc,l.raaddr1,l.raaddr2+l.raaddr3+l.raaddr4,l.racity,l.rastate,l.razip,l.racountry).ifAddressExists,'R','');
			self.corp_ra_address_type_desc		  			:= if(Corp2_Mapping.fAddressExists(state_origin,state_desc,l.raaddr1,l.raaddr2+l.raaddr3+l.raaddr4,l.racity,l.rastate,l.razip,l.racountry).ifAddressExists,'REGISTERED OFFICE','');
			self.corp_ra_address_line1				 				:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.raaddr1,l.raaddr2+l.raaddr3+l.raaddr4,l.racity,l.rastate,l.razip,l.racountry).AddressLine1,
			self.corp_ra_address_line2				 				:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.raaddr1,l.raaddr2+l.raaddr3+l.raaddr4,l.racity,l.rastate,l.razip,l.racountry).AddressLine2,
			self.corp_ra_address_line3				 				:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.raaddr1,l.raaddr2+l.raaddr3+l.raaddr4,l.racity,l.rastate,l.razip,l.racountry).AddressLine3,
			self.ra_prep_addr_line1						  			:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.raaddr1,l.raaddr2+l.raaddr3+l.raaddr4,l.racity,l.rastate,l.razip,l.racountry).PrepAddrLine1,
			self.ra_prep_addr_last_line				  			:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.raaddr1,l.raaddr2+l.raaddr3+l.raaddr4,l.racity,l.rastate,l.razip,l.racountry).PrepAddrLastLine,
			self.corp_country_of_formation						:= Corp2_Mapping.fCleanCountry(state_origin,state_desc,l.country).Country;
			self.corp_management_desc									:= if((integer)l.mangnum<>0,'NUMBER OF MANAGING MEMBERS/MANAGERS: '+ (integer)l.mangnum,'');		
			self.corp_organizational_comments					:= if((integer)l.numofcr<>0,'NUMBER OF OFFICERS: '+ (integer)l.numofcr,'');
			self.corp_renewal_date										:= Corp2_Mapping.fValidateDate(l.rendte,'MM/DD/CCYY').GeneralDate;
			self.internalfield1												:= corp2.t2u(l.comptype);  //scrubbed
			self.internalfield2												:= corp2.t2u(l.type1); 		 //scrubbed			
			self.recordorigin													:= 'C';
			self 																		 	:= [];
		end;

		MapCompanies		:= project(FinalCompany,CorpTransform(left)) : independent;

		//********************************************************************
		//Map Officers.
		//********************************************************************
		Corp2_mapping.LayoutsCommon.Main Contact1Transform(Corp2_Raw_KY.Layouts.TempCompanyOfficerLayoutIn l):= transform,
		skip(corp2.t2u(l.fname+l.mname+l.lname)='')
			self.dt_vendor_first_reported							:= (integer)fileDate;
			self.dt_vendor_last_reported							:= (integer)fileDate;
			self.dt_first_seen												:= (integer)fileDate;
			self.dt_last_seen													:= (integer)fileDate;
			self.corp_ra_dt_first_seen								:= (integer)fileDate;
			self.corp_ra_dt_last_seen									:= (integer)fileDate;			
			self.corp_key															:= state_fips + '-' + corp2.t2u(l.id);
			self.corp_vendor													:= state_fips;
			self.corp_state_origin										:= state_origin;			
			self.corp_process_date										:= fileDate;
			self.corp_orig_sos_charter_nbr						:= corp2.t2u(l.id);													  						
			self.corp_legal_name											:= Corp2_mapping.fCleanBusinessName(state_origin,state_desc,l.name).BusinessName;
			self.corp_inc_state												:= state_origin;
			self.cont_type_cd													:= 'F';
			self.cont_type_desc												:= 'OFFICER';
			self.cont_title1_desc											:= Corp2_Raw_KY.Functions.ContTitle1Desc(l.type1);
			self.cont_full_name												:= Corp2_mapping.fCleanBusinessName(state_origin,state_desc,l.fname+' '+l.mname+' '+l.lname).BusinessName;
			self.cont_fname														:= if(corp2.t2u(l.fname)<>'',Corp2_Mapping.fCleanPersonName(state_origin,state_desc,l.fname,l.mname,l.lname).FirstName,'');
			self.cont_mname														:= if(corp2.t2u(l.fname)<>'',Corp2_Mapping.fCleanPersonName(state_origin,state_desc,l.fname,l.mname,l.lname).MiddleName,'');
			self.cont_lname														:= if(corp2.t2u(l.fname)<>'',Corp2_Mapping.fCleanPersonName(state_origin,state_desc,l.fname,l.mname,l.lname).LastName,'');
			self.cont_filing_date											:= Corp2_Mapping.fValidateDate(l.chgdate,'MM/DD/CCYY').GeneralDate;
			self.cont_filing_cd												:= if(Corp2_Mapping.fValidateDate(l.chgdate,'MM/DD/CCYY').GeneralDate<>'','X','');
			self.cont_filing_desc											:= if(self.cont_filing_cd<>'','ADDED OR EDITED','');
			self.internalfield1												:= corp2.t2u(l.comptype);  //scrubbed
			self.recordorigin													:= 'T';
			self 																		 	:= [];
		end;

		OfficersMapped:= project(CompanyOfficers,Contact1Transform(left)) : independent;
		MapOfficers		:= OfficersMapped(corp2.t2u(cont_full_name)<>'');
		
		//********************************************************************
		//Map Inital Officers. 
		//********************************************************************
		Corp2_mapping.LayoutsCommon.Main Contact2Transform(Corp2_Raw_KY.Layouts.TempCompanyInitOfficersLayoutIn l):= transform,
		skip(corp2.t2u(l.initialofficername)='')
			self.dt_vendor_first_reported							:= (integer)fileDate;
			self.dt_vendor_last_reported							:= (integer)fileDate;
			self.dt_first_seen												:= (integer)fileDate;
			self.dt_last_seen													:= (integer)fileDate;
			self.corp_ra_dt_first_seen								:= (integer)fileDate;
			self.corp_ra_dt_last_seen									:= (integer)fileDate;			
			self.corp_key															:= state_fips + '-' + corp2.t2u(l.id);
			self.corp_vendor													:= state_fips;
			self.corp_state_origin										:= state_origin;			
			self.corp_process_date										:= fileDate;
			self.corp_orig_sos_charter_nbr						:= corp2.t2u(l.id);													  						
			self.corp_legal_name											:= Corp2_mapping.fCleanBusinessName(state_origin,state_desc,l.name).BusinessName;
			self.corp_inc_state												:= state_origin;
			self.cont_type_cd													:= 'F';
			self.cont_type_desc												:= 'OFFICER';
			self.cont_title1_desc											:= Corp2_Raw_KY.Functions.ContTitle1Desc(l.type1);
			self.cont_full_name												:= Corp2_mapping.fCleanBusinessName(state_origin,state_desc,l.initialofficername).BusinessName;
			self.cont_filing_date											:= Corp2_Mapping.fValidateDate(l.dateadded,'MM/DD/CCYY').GeneralDate;
			self.internalfield1												:= corp2.t2u(l.comptype);  //scrubbed
			self.recordorigin													:= 'T';
			self 																		 	:= [];
		end;

		InitOfficersMapped	:= project(CompanyInitOfficers,Contact2Transform(left)) : independent;
		MapInitOfficers			:= InitOfficersMapped(corp2.t2u(cont_full_name)<>'');
		
		MapMain							:= dedup(sort(distribute(MapCompanies + MapOfficers + MapInitOfficers,hash(corp_key)),record,local),record,local) : independent;		
		
		//********************************************************************
		//Begin STOCK File processing. 
		//********************************************************************
		Corp2_mapping.LayoutsCommon.Stock StockTransform(Corp2_Raw_KY.Layouts.TempCompanyLayoutIn l) := transform,
		skip(corp2.t2u(l.numofshr) in ['','0000000000'])     
			self.corp_key															:= state_fips +'-' + corp2.t2u(l.id);
			self.corp_vendor													:= state_fips;
			self.corp_state_origin										:= state_origin;			
			self.corp_process_date										:= fileDate;
			self.corp_sos_charter_nbr									:= corp2.t2u(l.id);
			self.stock_shares_issued									:= Corp2_Raw_KY.Functions.StockSharesIssued(l.numofshr);
			self                            					:= [];
		end;
		
		Stock					:= project(Company,StockTransform(left)) : independent;
		MapStock			:= dedup(sort(distribute(Stock(corp2.t2u(stock_shares_issued)<>''),hash(corp_key)),record,local),record,local) : independent;

	//********************************************************************
  // SCRUB MAIN
  //********************************************************************	
		Main_F := MapMain;
		Main_S := Scrubs_Corp2_Mapping_KY_Main.Scrubs;					// Scrubs module
		Main_N := Main_S.FromNone(Main_F); 											// Generate the error flags
		Main_T := Main_S.FromBits(Main_N.BitmapInfile);     		// Use the FromBits module; makes my bitmap datafile easier to get to
		Main_U := Main_S.FromExpanded(Main_N.ExpandedInFile); 	// Pass the expanded error flags into the Expanded module

		//Outputs reports
		Main_ErrorSummary					:= output(Main_U.SummaryStats, named('Main_ErrorSummary_KY'+filedate));
		Main_ScrubErrorReport 		:= output(choosen(Main_U.AllErrors, 1000), named('Main_ScrubErrorReport_KY'+filedate));
		Main_SomeErrorValues			:= output(choosen(Main_U.BadValues, 1000), named('Main_SomeErrorValues_KY'+filedate));
		Main_IsScrubErrors		 		:= if(count(Main_U.AllErrors)<> 0,true,false);

		// Orbit Stats
		Main_OrbitStats						:= Main_U.OrbitStats();

		//Outputs files
		Main_CreateBitMaps				:= output(Main_N.BitmapInfile,,'~thor_data::corp_ky_main_scrubs_bits',overwrite,compressed);	//long term storage
		Main_TranslateBitMap			:= output(Main_T);

		//Submits Profile's stats to Orbit
		Main_SubmitStats 			  := Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_KY_Main','ScrubsAlerts', Main_OrbitStats, version,'Corp_KY_Main').SubmitStats;
		Main_ScrubsWithExamples := Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_KY_Main','ScrubsAlerts', Main_OrbitStats, version,'Corp_KY_Main').CompareToProfile_with_Examples;

		Main_ScrubsAlert					:= Main_ScrubsWithExamples(RejectWarning = 'Y');
		Main_ScrubsAttachment			:= Scrubs.fn_email_attachment(Main_ScrubsAlert);
		Main_MailFile							:= FileServices.SendEmailAttachData(corp2.Email_Notification_Lists.AttachedList
																																 ,'Scrubs CorpMain_KY Report' //subject
																																 ,'Scrubs CorpMain_KY Report' //body
																																 ,(data)Main_ScrubsAttachment
																																 ,'text/csv'
																																 ,'CorpKYMainScrubsReport.csv'
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
																											 corp_state_origin_Invalid 					 		<> 0 or
																											 corp_process_date_Invalid						  <> 0 or
																											 corp_orig_sos_charter_nbr_Invalid 			<> 0 or
																											 corp_legal_name_Invalid 								<> 0 or
																											 corp_ln_name_type_cd_Invalid 					<> 0 or
																											 corp_ln_name_type_desc_Invalid 				<> 0 or
																											 corp_filing_desc_Invalid 							<> 0 or
																											 corp_status_cd_Invalid 								<> 0 or
																											 corp_status_desc_Invalid 							<> 0 or
																											 corp_standing_Invalid 									<> 0 or
																											 corp_inc_date_Invalid 									<> 0 or
																											 corp_term_exist_cd_Invalid 						<> 0 or
																											 corp_term_exist_exp_Invalid 						<> 0 or
																											 corp_term_exist_desc_Invalid 					<> 0 or
																											 corp_foreign_domestic_ind_Invalid 			<> 0 or
																											 corp_forgn_state_cd_Invalid 						<> 0 or
																											 corp_forgn_state_desc_Invalid 					<> 0 or 
																											 corp_forgn_date_Invalid 								<> 0 or
																											 corp_forgn_term_exist_cd_Invalid 			<> 0 or
																											 corp_forgn_term_exist_exp_Invalid 			<> 0 or
																											 corp_forgn_term_exist_desc_Invalid 		<> 0 or
																											 corp_orig_org_structure_cd_Invalid 		<> 0 or
																											 corp_for_profit_ind_Invalid 						<> 0 or
																											 cont_filing_date_Invalid 							<> 0 or
																											 cont_filing_cd_Invalid									<> 0 or
																											 cont_filing_desc_Invalid 							<> 0 or
																											 cont_type_cd_Invalid 									<> 0 or
																											 cont_type_desc_Invalid									<> 0 or
																											 corp_renewal_date_Invalid 							<> 0 or
																											 recordorigin_Invalid 									<> 0 or
																											 internalfield1_Invalid 								<> 0 or
																											 internalfield2_Invalid 								<> 0
																										);

		Main_GoodRecords				:= Main_N.ExpandedInFile(	
																											 dt_vendor_first_reported_Invalid 			= 0 and
																											 dt_vendor_last_reported_Invalid 				= 0 and
																											 dt_first_seen_Invalid 									= 0 and
																											 dt_last_seen_Invalid 									= 0 and
																											 corp_ra_dt_first_seen_Invalid 					= 0 and
																											 corp_ra_dt_last_seen_Invalid 					= 0 and
																											 corp_key_Invalid 											= 0 and
																											 corp_vendor_Invalid 										= 0 and
																											 corp_state_origin_Invalid 					 		= 0 and
																											 corp_process_date_Invalid						  = 0 and
																											 corp_orig_sos_charter_nbr_Invalid 			= 0 and
																											 corp_legal_name_Invalid 								= 0 and
																											 corp_ln_name_type_cd_Invalid 					= 0 and
																											 corp_ln_name_type_desc_Invalid 				= 0 and
																											 corp_filing_desc_Invalid 							= 0 and
																											 corp_status_cd_Invalid 								= 0 and
																											 corp_status_desc_Invalid 							= 0 and
																											 corp_standing_Invalid 									= 0 and
																											 corp_inc_date_Invalid 									= 0 and
																											 corp_term_exist_cd_Invalid 						= 0 and
																											 corp_term_exist_exp_Invalid 						= 0 and
																											 corp_term_exist_desc_Invalid 					= 0 and
																											 corp_foreign_domestic_ind_Invalid 			= 0 and
																											 corp_forgn_state_cd_Invalid 						= 0 and
																											 corp_forgn_state_desc_Invalid 					= 0 and 
																											 corp_forgn_date_Invalid 								= 0 and
																											 corp_forgn_term_exist_cd_Invalid 			= 0 and
																											 corp_forgn_term_exist_exp_Invalid 			= 0 and
																											 corp_forgn_term_exist_desc_Invalid 		= 0 and
																											 corp_orig_org_structure_cd_Invalid 		= 0 and
																											 corp_for_profit_ind_Invalid 						= 0 and
																											 cont_filing_date_Invalid 							= 0 and
																											 cont_filing_cd_Invalid									= 0 and
																											 cont_filing_desc_Invalid 							= 0 and
																											 cont_type_cd_Invalid 									= 0 and
																											 cont_type_desc_Invalid									= 0 and
																											 corp_renewal_date_Invalid 							= 0 and
																											 recordorigin_Invalid 									= 0 and
																											 internalfield1_Invalid 								= 0 and
																											 internalfield2_Invalid 								= 0																											 
																								  );

		Main_FailBuild					:= map( corp2_mapping.fCalcPercent(count(Main_N.ExpandedInFile(corp_key_invalid<>0)),count(Main_N.ExpandedInFile),false) 										> Scrubs_Corp2_Mapping_KY_Main.Threshold_Percent.CORP_KEY										 => true,
																		corp2_mapping.fCalcPercent(count(Main_N.ExpandedInFile(corp_orig_sos_charter_nbr_invalid<>0)),count(Main_N.ExpandedInFile),false) 	> Scrubs_Corp2_Mapping_KY_Main.Threshold_Percent.CORP_ORIG_SOS_CHARTER_NBR 	 => true,
																		corp2_mapping.fCalcPercent(count(Main_N.ExpandedInFile(corp_legal_name_invalid<>0)),count(Main_N.ExpandedInFile),false) 						> Scrubs_Corp2_Mapping_KY_Main.Threshold_Percent.CORP_LEGAL_NAME 						 => true,
																	  count(Main_GoodRecords) = 0																																																																																											 => true,																		
																		false
																	);

		Main_ApprovedRecords		:= project(Main_GoodRecords,transform(Corp2_Mapping.LayoutsCommon.Main,self := left));


		Main_ALL		 						:= sequential( if(count(Main_BadRecords) <> 0
																						 ,IF (poverwrite
																								 ,OUTPUT(Main_BadRecords,,Corp2_Mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::main_'+state_origin,overwrite,__compressed__)
																								 ,OUTPUT(Main_BadRecords,,Corp2_Mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::main_'+state_origin,__compressed__)
																								 )
																						 )
																					,output(Main_ScrubsWithExamples, all, named('CorpMainKYScrubsReportWithExamples'+filedate))
																					//Send Alerts if Scrubs exceeds thresholds
																					,if(COUNT(Main_ScrubsAlert) > 0, Main_MailFile, OUTPUT('CORP2_MAPPING.KY - No "MAIN" Corp Scrubs Alerts'))
																					,Main_ErrorSummary
																					,Main_ScrubErrorReport
																					,Main_SomeErrorValues	
																					,Main_SubmitStats
																				 );

	//********************************************************************
  // SCRUB STOCK
  //********************************************************************	
		Stock_F := MapStock;
		Stock_S := Scrubs_Corp2_Mapping_KY_Stock.Scrubs;						// Scrubs module
		Stock_N := Stock_S.FromNone(Stock_F); 											// Generate the error flags
		Stock_T := Stock_S.FromBits(Stock_N.BitmapInfile);     			// Use the FromBits module; makes my bitmap datafile easier to get to
		Stock_U := Stock_S.FromExpanded(Stock_N.ExpandedInFile); 		// Pass the expanded error flags into the Expanded module

		//Outputs reports
		Stock_ErrorSummary			 	:= output(Stock_U.SummaryStats, named('Stock_ErrorSummary_KY'+filedate));
		Stock_ScrubErrorReport 	 	:= output(choosen(Stock_U.AllErrors, 1000), named('Stock_ScrubErrorReport_KY'+filedate));
		Stock_SomeErrorValues		 	:= output(choosen(Stock_U.BadValues, 1000), named('Stock_SomeErrorValues_KY'+filedate));
		Stock_IsScrubErrors		 	 	:= if(count(Stock_U.AllErrors)<> 0,true,false);

		// Orbit Stats
		Stock_OrbitStats				 	:= Stock_U.OrbitStats();

		//Outputs files
		Stock_CreateBitMaps				:= output(Stock_N.BitmapInfile,,'~thor_data::corp_ky_scrubs_bits',overwrite,compressed);	//long term storage
		Stock_TranslateBitMap			:= output(Stock_T);

		//Submits Profile's stats to Orbit
		Stock_SubmitStats 			 := Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_KY_Stock','ScrubsAlerts', Stock_OrbitStats, version,'Corp_KY_Stock').SubmitStats;
		Stock_ScrubsWithExamples := Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_KY_Stock','ScrubsAlerts', Stock_OrbitStats, version,'Corp_KY_Stock').CompareToProfile_with_Examples;

		Stock_ScrubsAlert					:= Stock_ScrubsWithExamples(RejectWarning = 'Y');
		Stock_ScrubsAttachment		:= Scrubs.fn_email_attachment(Stock_ScrubsAlert);
		Stock_MailFile						:= FileServices.SendEmailAttachData(corp2.Email_Notification_Lists.spray
																																 ,'Scrubs CorpStock_KY Report' //subject
																																 ,'Scrubs CorpStock_KY Report' //body
																																 ,(data)Stock_ScrubsAttachment
																																 ,'text/csv'
																																 ,'CorpKYStockScrubsReport.csv'
																																 ,
																																 ,
																																 ,corp2.Email_Notification_Lists.spray);

		Stock_BadRecords					:= Stock_N.ExpandedInFile(	
																												corp_key_Invalid							  			<> 0 or
																												corp_vendor_Invalid 									<> 0 or
																												corp_state_origin_Invalid 					 	<> 0 or
																												corp_process_date_Invalid						  <> 0 or
																												corp_sos_charter_nbr_Invalid					<> 0 or
																												stock_shares_issued_Invalid	 					<> 0 
																											 );
																																							
		Stock_GoodRecords					:= Stock_N.ExpandedInFile(	
																												corp_key_Invalid							  			= 0 and
																												corp_vendor_Invalid 									= 0 and
																												corp_state_origin_Invalid 					 	= 0 and
																												corp_process_date_Invalid						  = 0 and
																												corp_sos_charter_nbr_Invalid					= 0 and
																												stock_shares_issued_Invalid		 				= 0 
																											 );
																														
		Stock_FailBuild						:= if(count(Stock_GoodRecords) = 0,true,false);

		Stock_ApprovedRecords			:= project(Stock_GoodRecords,transform(Corp2_Mapping.LayoutsCommon.Stock,self := left));

		Stock_ALL									:= sequential( if(count(Stock_BadRecords) <> 0
																							 ,IF (poverwrite
																									 ,OUTPUT(Stock_BadRecords,,Corp2_Mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::stock_'+state_origin,overwrite,__compressed__)
																									 ,OUTPUT(Stock_BadRecords,,Corp2_Mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::stock_'+state_origin,__compressed__)
																									 )
																							)
																						,output(Stock_ScrubsWithExamples, all, named('CorpStockKYScrubsReportWithExamples'+filedate))
																						//Send Alerts if Scrubs exceeds thresholds
																						,if(COUNT(Stock_ScrubsAlert) > 0, Stock_MailFile, OUTPUT('CORP2_MAPPING.KY - No "Stock" Corp Scrubs Alerts'))
																						,Stock_ErrorSummary
																						,Stock_ScrubErrorReport
																						,Stock_SomeErrorValues	
																						,Stock_SubmitStats
																					 );	
 
	//********************************************************************
  // UPDATE
  //********************************************************************
	Fail_Build						:= if(Main_FailBuild = true or Stock_FailBuild = true,true,false);
	IsScrubErrors					:= if(Main_IsScrubErrors = true or Stock_IsScrubErrors = true,true,false);

	VersionControl.macBuildNewLogicalFile(Corp2_Mapping._dataset().thor_cluster_Files + 'in::corp2::' 	+ version + '::Main_' 	+ state_origin, Main_ApprovedRecords , write_main,,,pOverwrite);
	VersionControl.macBuildNewLogicalFile(Corp2_Mapping._dataset().thor_cluster_Files + 'in::corp2::' 	+ version + '::Stock_' 	+ state_origin, Stock_ApprovedRecords, write_stock,,,pOverwrite);

	VersionControl.macBuildNewLogicalFile(Corp2_Mapping._dataset().thor_cluster_Files + 'fail::corp2::' + version + '::Main_' 	+ state_origin, Main_F	, write_fail_main,,,pOverwrite);
	VersionControl.macBuildNewLogicalFile(Corp2_Mapping._dataset().thor_cluster_Files + 'fail::corp2::' + version + '::Stock_' 	+ state_origin, Stock_F	, write_fail_stock,,,pOverwrite);

	mapKY:= sequential ( if(pshouldspray = true,Corp2_mapping.fSprayFiles(state_origin,version,pOverwrite := pOverwrite))
											// ,Corp2_Raw_KY.Build_Bases(filedate,version,puseprod).All									
											,Main_All
											,Stock_All									
											,if(Fail_Build <> true	 
												 ,sequential (write_main
																		 ,write_stock	
																		 ,fileservices.addsuperfile(Corp2_Mapping._Dataset().thor_cluster_Files + 'in::'+Corp2_Mapping._Dataset().NameMapped +'::sprayed::main'		,Corp2_Mapping._Dataset().thor_cluster_Files + 'in::corp2::'+version+'::main_'	+state_origin)																		 
																		 ,fileservices.addsuperfile(Corp2_Mapping._Dataset().thor_cluster_Files + 'in::'+Corp2_Mapping._Dataset().NameMapped +'::sprayed::stock'	,Corp2_Mapping._Dataset().thor_cluster_Files + 'in::corp2::'+version+'::stock_'	+state_origin)
																		 ,if(count(Main_BadRecords) <> 0 or count(Stock_BadRecords)<>0
																				 ,Corp2_Mapping.Send_Email(state_origin,version,count(Main_BadRecords)<>0,,,count(Stock_BadRecords)<>0,count(Main_BadRecords),,,count(Stock_BadRecords),count(Main_ApprovedRecords),,,count(Stock_ApprovedRecords)).RecordsRejected																				 
																				 ,Corp2_Mapping.Send_Email(state_origin,version,count(Main_BadRecords)<>0,,,count(Stock_BadRecords)<>0,count(Main_BadRecords),,,count(Stock_BadRecords),count(Main_ApprovedRecords),,,count(Stock_ApprovedRecords)).MappingSuccess																				 
																				 )
																		 ,if(IsScrubErrors
																				 ,Corp2_Mapping.Send_Email(state_origin,version,Main_IsScrubErrors,,,Stock_IsScrubErrors).FieldsInvalidPerScrubs
																				 )
																		 ) //if Fail_Build <> true																			
												 ,sequential (write_fail_main
																		 ,write_fail_stock												 
																		 ,Corp2_Mapping.Send_Email(state_origin,version).MappingFailed
																		 ) //if Fail_Build = true
												 )
										);
										
	isFileDateValid := if((string)std.date.today() between ut.date_math(filedate,-40) and ut.date_math(filedate,40),true,false);
	return sequential ( if(isFileDateValid
												,mapKY
												,sequential (Corp2_Mapping.Send_Email(state_origin,filedate).InvalidFileDateParm
																		,fail('Corp2_Mapping.'+state_origin+' failed.  An invalid filedate was passed in as a parameter.')
																		)
												)
										);

	end;	// end of Update function

end;  // end of Module
	