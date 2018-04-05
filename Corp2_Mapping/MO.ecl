Import corp2, corp2_raw_mo, scrubs, scrubs_corp2_mapping_mo_main, scrubs_corp2_mapping_mo_event, scrubs_corp2_mapping_mo_ar, ut, versioncontrol, tools, std ;
  
Export MO:=MODULE;   

Export Update( string fileDate,string version, boolean pShouldSpray = _Dataset().bShouldSpray, boolean pOverwrite = false,pUseProd = Tools._Constants.IsDataland) :=Function
		
	state_origin 							:= 'MO';   
	state_fips	 							:= '29';	
	state_desc	 							:= 'MISSOURI';
	ds_Address   	 						:= dedup(sort(distribute(corp2_raw_mo.files(filedate,pUseProd).Input.Address.logical,hash(CorpID)),record,local),record,local) 				: independent;
	ds_Filing	 			 					:= dedup(sort(distribute(corp2_raw_mo.files(filedate,pUseProd).Input.Filing.logical,hash(CorpID)),record,local),record,local) 				: independent;
	ds_corporation	 					:= dedup(sort(distribute(corp2_raw_mo.files(filedate,pUseProd).Input.Corporation.logical,hash(CorpID)),record,local),record,local)		: independent;
	ds_Name   			  				:= dedup(sort(distribute(corp2_raw_mo.files(filedate,pUseProd).Input.FixedNames,hash(CorpID)),record,local),record,local) 						: independent;
	ds_Officer	   	 					:= dedup(sort(distribute(corp2_raw_mo.files(filedate,pUseProd).Input.Officer.logical,hash(CorpID)),record,local),record,local) 				: independent;
	ds_Stock  								:= dedup(sort(distribute(corp2_raw_mo.files(filedate,pUseProd).Input.Stock.logical,hash(CorpID)),record,local),record,local) 					: independent;
	ds_Merger_SurvivorID  		:= dedup(sort(distribute(corp2_raw_mo.files(filedate,pUseProd).Input.Merger.logical,hash(SurvivorCorpID)),record,local),record,local) : independent;
	DocumentType_Table        := corp2_raw_mo.files(filedate,pUseProd).Input.DocumentType_Table;
	DocumentType_DescLn       := project(DocumentType_Table,transform(corp2_raw_mo.Layouts.Temp_DocTypeTable,self.len:=length(left.typeDesc);self:=left;));
	OfficerPartyType_Table    := corp2_raw_mo.Files(filedate,pUseProd).Input.OfficerPartyType_Table;

	//Document Types-Annual Reports Tab in CI
	export AR_List				    :=['1023','1030','1059','1060','1142','1147','1161','1164','1228','1229','1230','1236','1262','1264','1306','1320',
															 '1371','1372','1379','1380','1471','1476','1548','1605','1611','1685','1686','1692','1693','2023','2024','2029',
															 '2030','2093','2099','2203','2208','2333','2339','2404','2405','2466','2476','2477','2504','2512',
															 '2576','2579','2871','2895','2915','2917'];											 

	joinCorpName 						  := join(ds_corporation, ds_name,
																		corp2.t2u(left.CorpID) = corp2.t2u(right.CorpID),											 
																		transform(corp2_raw_mo.Layouts.TempCorpName,
																							self 		 := left;
																							self 		 := right;),
																		left outer,local):independent;
											 
	joinCorpNameAddr 				  := join(joinCorpname, ds_address,
																		corp2.t2u(left.CorpID) = corp2.t2u(right.CorpID),
																		transform(corp2_raw_mo.Layouts.TempCorpNameAddr,
																							self 		 := left;
																							self 		 := right;),
																		left outer,local):independent;
																	
	//Attaching mergedID's & merg_date's to corp records
	joinCorpNameSurvivor 			:= join(joinCorpNameAddr ,ds_Merger_SurvivorID,
																		corp2.t2u(left.CorpID) =  corp2.t2u(right.SurvivorCorpID),
																		transform(corp2_raw_mo.layouts.TempCorpSurvivor,
																							self.temp_survivor_id  := right.survivorcorpid;
																							self.temp_survivor_name:= corp2.t2u(left.name);
																							self.mergedcorpid			 := right.mergedcorpid; 
																							self.merg_date				 := right.merg_date;
																							self									 := left;),
																		left outer,local):independent;
																
	ds_valid_MergerID    			:=joinCorpNameSurvivor(trim(MergedCorpID,left,right)<>'');		
	ds_blk_MergerId     	  	:=project(joinCorpNameSurvivor(trim(MergedCorpID)=''),transform(corp2_raw_mo.Layouts.TempCorpMerger,self:=left;self:=[];));

	//PER CI:survivor info for valid merged records & attaching merged_names !
	ds_valid_MergerID_dist  	:= distribute(ds_valid_MergerID,hash(MergedCorpID));
	joinCorpNameMerger  			:= join(ds_valid_MergerID_dist ,ds_Name,
																		corp2.t2u(left.MergedCorpID) =  corp2.t2u(right.CorpID),
																		transform(corp2_raw_mo.Layouts.TempCorpMerger,
																							self.merged_name				:= corp2.t2u(right.name);
																							self.merger_indicator		:= if(self.merged_name<>'','N','S');
																							self.survivor_name			:= if(self.merger_indicator='S',left.temp_survivor_name,'');
																							self.survivorcorpid			:= if(self.merger_indicator='S',left.temp_survivor_id,'');
																							self:=left;),
																		left outer,local);
																
	raw_corp             			:= dedup(sort(distribute(ds_blk_MergerId + joinCorpNameMerger ,hash(CorpID,corp_num)),record,local),record,local) :independent;										

	corp2_mapping.LayoutsCommon.Main MO_corpTransform(corp2_raw_mo.Layouts.TempCorpMerger l) := transform 

		self.dt_vendor_first_reported		  := (integer)fileDate;
		self.dt_vendor_last_reported		  := (integer)fileDate;
		self.dt_first_seen							  := (integer)fileDate;
		self.dt_last_seen								  := (integer)fileDate;
		self.corp_ra_dt_first_seen			  := (integer)fileDate;
		self.corp_ra_dt_last_seen				  := (integer)fileDate;					
		self.corp_process_date					  := fileDate;
		self.corp_key										  := state_fips +'-'+ corp2.t2u(l.CorpID);
		self.corp_vendor								  := state_fips ;
		self.corp_state_origin					  := state_origin;
		self.corp_inc_state  					    := state_origin;          
		self.corp_orig_sos_charter_nbr	  := corp2.t2u(l.corp_num); 
		self.corp_orig_org_structure_cd   := map(corp2.t2u(l.corp_typeID) in ['19','1011']=>'',
																						 corp2.t2u(l.corp_typeID) 
																						 );
		self.corp_orig_org_structure_desc := corp2_raw_mo.Functions.Orig_desc(l.corp_typeid);
		self.corp_for_profit_ind				  := map(corp2.t2u(l.corp_typeid)='4'=>'Y',
																						 corp2.t2u(l.corp_typeid) in ['6','1017','1018','1019','1020']=>'N',
																						 '');
		self.corp_status_cd					      := corp2.t2u(l.corp_status);
		self.corp_status_desc				      := corp2_raw_mo.Functions.status_desc(l.corp_status);
		self.corp_standing                := if(trim(l.corp_status,left,right)='0','Y','');
		//Per CI :vendor format in MO data can be either ccyy-mm-dd OR  mm/dd/yyyy "fFormatOfDate" has been added !
		Temp_dissolve_dt                  := corp2_mapping.fValidateDate(l.dissolve_date,Corp2_Mapping.fFormatOfDate(l.dissolve_date)).GeneralDate;
		self.corp_dissolved_date          := Temp_dissolve_dt;
		self.corp_status_comment          := if(trim(Temp_dissolve_dt)<>'','DISSOLUTION DATE: '+ Temp_dissolve_dt[5..6]+'/'+Temp_dissolve_dt[7..8]+'/'+ Temp_dissolve_dt[1..4],'');//Per CI :mapping as 'mm/dd/yyyy'!! 
		self.corp_foreign_domestic_ind	  := map(corp2.t2u(l.citizenship) ='D' =>'D',
																						 corp2.t2u(l.citizenship) ='F' =>'F',
																						 '');
		self.corp_inc_date					      := if(corp2.t2u(l.citizenship) = 'D' , corp2_mapping.fValidateDate(l.date_formed,Corp2_Mapping.fFormatOfDate(l.date_formed)).PastDate,'');
		self.corp_forgn_date					    := if(corp2.t2u(l.citizenship) = 'F' , corp2_mapping.fValidateDate(l.date_formed,Corp2_Mapping.fFormatOfDate(l.date_formed)).PastDate,'');             
		self.corp_term_exist_cd           := map(Regexfind('30 DAYS',l.Duration,nocase)																			  											=>'', //Per CI:don't map if Duration has'30 DAYS'
																						 corp2_mapping.fValidateDate(l.Duration,Corp2_Mapping.fFormatOfDate(l.Duration)).GeneralDate	<>''	=>'D',	
																						 Regexfind('YEARS|YEAR',l.Duration,nocase) and (string)(integer)l.Duration  <>''										=>'N',
																						 corp2.t2u(l.Duration)																											='PERPETUAL'						=>'P',
																							'');	
		self.corp_term_exist_exp          := map(self.corp_term_exist_cd ='D'=>corp2_mapping.fValidateDate(l.Duration,Corp2_Mapping.fFormatOfDate(l.Duration)).GeneralDate,		
																						 self.corp_term_exist_cd ='N'=>(string)(integer)l.Duration,
																						 '');	
		self.corp_term_exist_desc         := map(self.corp_term_exist_cd ='N'=>'NUMBER OF YEARS',
																						 self.corp_term_exist_cd ='P'=>'PERPETUAL',
																						 self.corp_term_exist_cd ='D'=>'EXPIRATION DATE',
																						 '');	
		self.corp_home_incorporated_county:= corp2.t2u(l.county_of_inc);
		self.corp_country_of_formation	  := corp2_mapping.fCleancountry(state_origin,state_desc,'',l.country_of_inc).country;  //full country desc from vendor
		self.corp_forgn_state_cd			   	:= if(corp2.t2u(l.state_of_inc)not in['', 'MO'] ,corp2_raw_mo.Functions.fGetStateCode(l.state_of_inc),''); 
		self.corp_forgn_state_desc				:= if(corp2.t2u(l.state_of_inc)not in['', 'MO'],corp2_raw_mo.Functions.fGetStateDesc(l.state_of_inc),'');
		self.corp_legal_name						  := corp2_mapping.fCleanBusinessName(state_origin,state_desc,l.name).BusinessName;
		self.corp_ln_name_type_cd				  := map(trim(l.name_type,left,right) ='0'=>'01',
																						 trim(l.name_type,left,right) ='2'=>'2',
																						 trim(l.name_type,left,right) ='5'=>'5',
																						 trim(l.name_type,left,right) ='9'=>'9',
																						 trim(l.name_type,left,right) //when scrub catch new types!! please make sure to vist 
																						 ); 													//"corp2_raw_mo.File_names_in" attribute!!
		self.corp_ln_name_type_desc			  := map(trim(l.name_type,left,right) ='0'=>'LEGAL',
																						 trim(l.name_type,left,right) ='2'=>'FICTITIOUS',
																						 trim(l.name_type,left,right) ='5'=>'RESERVED',
																						 trim(l.name_type,left,right) ='9'=>'HOME STATE',
																						 '');
		//overload
		self.corp_orig_bus_type_desc 		 := corp2.t2u(l.purpose);	
		self.corp_address1_line1				 := if(trim(l.addr_type_id,left,right) not in ['1','6'] ,corp2_mapping.fCleanAddress(state_origin,state_desc,l.addr_line_1 +' '+l.addr_line_2,l.addr_line_3,l.addr_city,l.addr_state,l.addr_zip,l.addr_country).AddressLine1,'');
		self.corp_address1_line2				 := if(trim(l.addr_type_id,left,right) not in ['1','6'] ,corp2_mapping.fCleanAddress(state_origin,state_desc,l.addr_line_1 +' '+l.addr_line_2,l.addr_line_3,l.addr_city,l.addr_state,l.addr_zip,l.addr_country).AddressLine2,'');
		self.corp_address1_line3				 := if(trim(l.addr_type_id,left,right) not in ['1','6'] ,corp2_mapping.fCleanAddress(state_origin,state_desc,l.addr_line_1 +' '+l.addr_line_2,l.addr_line_3,l.addr_city,l.addr_state,l.addr_zip,l.addr_country).AddressLine3,'');
		self.corp_prep_addr1_line1			 := if(trim(l.addr_type_id,left,right) not in ['1','6'] ,corp2_mapping.fCleanAddress(state_origin,state_desc,l.addr_line_1 +' '+l.addr_line_2,l.addr_line_3,l.addr_city,l.addr_state,l.addr_zip,l.addr_country).PrepAddrLine1,'');
		self.corp_prep_addr1_last_line	 := if(trim(l.addr_type_id,left,right) not in ['1','6'] ,corp2_mapping.fCleanAddress(state_origin,state_desc,l.addr_line_1 +' '+l.addr_line_2,l.addr_line_3,l.addr_city,l.addr_state,l.addr_zip,l.addr_country).PrepAddrLastLine,'');
		self.corp_address1_type_cd		   := if(trim(l.addr_type_id,left,right) not in ['1','6'] and corp2_mapping.fAddressExists(state_origin,state_desc,l.addr_line_1 +' '+l.addr_line_2,l.addr_line_3,l.addr_city,l.addr_state,l.addr_zip,l.addr_country).ifAddressExists,corp2_raw_mo.Functions.Addr_type_cd(l.addr_type_id),'');
		self.corp_address1_type_desc		 := if(trim(l.addr_type_id,left,right) not in ['1','6'] and corp2_mapping.fAddressExists(state_origin,state_desc,l.addr_line_1 +' '+l.addr_line_2,l.addr_line_3,l.addr_city,l.addr_state,l.addr_zip,l.addr_country).ifAddressExists,corp2_raw_mo.Functions.Addr_type_desc(l.addr_type_id),'');		//Address Types tab in CI 	
		self.corp_address2_line1				 := if(trim(l.addr_type_id,left,right) ='1', corp2_mapping.fCleanAddress(state_origin,state_desc,l.addr_line_1 +' '+l.addr_line_2,l.addr_line_3,l.addr_city,l.addr_state,l.addr_zip,l.addr_country).AddressLine1,'');
		self.corp_address2_line2				 := if(trim(l.addr_type_id,left,right) ='1', corp2_mapping.fCleanAddress(state_origin,state_desc,l.addr_line_1 +' '+l.addr_line_2,l.addr_line_3,l.addr_city,l.addr_state,l.addr_zip,l.addr_country).AddressLine2,'');
		self.corp_address2_line3				 := if(trim(l.addr_type_id,left,right) ='1', corp2_mapping.fCleanAddress(state_origin,state_desc,l.addr_line_1 +' '+l.addr_line_2,l.addr_line_3,l.addr_city,l.addr_state,l.addr_zip,l.addr_country).AddressLine3,'');
		self.corp_prep_addr2_line1			 := if(trim(l.addr_type_id,left,right) ='1', corp2_mapping.fCleanAddress(state_origin,state_desc,l.addr_line_1 +' '+l.addr_line_2,l.addr_line_3,l.addr_city,l.addr_state,l.addr_zip,l.addr_country).PrepAddrLine1,'');
		self.corp_prep_addr2_last_line	 := if(trim(l.addr_type_id,left,right) ='1', corp2_mapping.fCleanAddress(state_origin,state_desc,l.addr_line_1 +' '+l.addr_line_2,l.addr_line_3,l.addr_city,l.addr_state,l.addr_zip,l.addr_country).PrepAddrLastLine,'');
		self.corp_address2_type_cd			 := if(trim(l.addr_type_id,left,right) ='1' and corp2_mapping.fAddressExists(state_origin,state_desc,l.addr_line_1 +' '+l.addr_line_2,l.addr_line_3,l.addr_city,l.addr_state,l.addr_zip,l.addr_country).ifAddressExists ,
																					 'M','');
		self.corp_address2_type_desc		 := if(trim(l.addr_type_id,left,right) ='1' and corp2_mapping.fAddressExists(state_origin,state_desc,l.addr_line_1 +' '+l.addr_line_2,l.addr_line_3,l.addr_city,l.addr_state,l.addr_zip,l.addr_country).ifAddressExists ,
																					 'MAILING','');
		self.corp_addl_info              := if(corp2.t2u(l.addr_county)<>'', 'HOME COUNTY: '+corp2.t2u(l.addr_county),'');	//overload 
		self.corp_status_date				     := corp2_mapping.fValidateDate(l.dissolve_date,Corp2_Mapping.fFormatOfDate(l.dissolve_date)).PastDate;//overload 
		self.corp_inc_county						 := if(trim(l.addr_type_id,left,right) <>'6',corp2.t2u(l.addr_county),'');
		self.corp_ra_full_name					 := corp2_raw_mo.Functions.fgetAgentName(l.agent_name);
		self.corp_ra_address_line1			 := if(trim(l.addr_type_id,left,right) ='6',corp2_mapping.fCleanAddress(state_origin,state_desc,l.addr_line_1 +' '+l.addr_line_2,l.addr_line_3,l.addr_city,l.addr_state,l.addr_zip,l.addr_country).AddressLine1,'');
		self.corp_ra_address_line2			 := if(trim(l.addr_type_id,left,right) ='6',corp2_mapping.fCleanAddress(state_origin,state_desc,l.addr_line_1 +' '+l.addr_line_2,l.addr_line_3,l.addr_city,l.addr_state,l.addr_zip,l.addr_country).AddressLine2,'');
		self.corp_ra_address_line3			 := if(trim(l.addr_type_id,left,right) ='6',corp2_mapping.fCleanAddress(state_origin,state_desc,l.addr_line_1 +' '+l.addr_line_2,l.addr_line_3,l.addr_city,l.addr_state,l.addr_zip,l.addr_country).AddressLine3,'');
		self.ra_prep_addr_line1					 := if(trim(l.addr_type_id,left,right) ='6',corp2_mapping.fCleanAddress(state_origin,state_desc,l.addr_line_1 +' '+l.addr_line_2,l.addr_line_3,l.addr_city,l.addr_state,l.addr_zip,l.addr_country).PrepAddrLine1,'');
		self.ra_prep_addr_last_line			 := if(trim(l.addr_type_id,left,right) ='6',corp2_mapping.fCleanAddress(state_origin,state_desc,l.addr_line_1 +' '+l.addr_line_2,l.addr_line_3,l.addr_city,l.addr_state,l.addr_zip,l.addr_country).PrepAddrLastLine,'');
		self.corp_ra_address_type_cd     := if(trim(l.addr_type_id,left,right) ='6' and corp2_mapping.fAddressExists(state_origin,state_desc,l.addr_line_1 +' '+l.addr_line_2,l.addr_line_3,l.addr_city,l.addr_state,l.addr_zip,l.addr_country).ifAddressExists,
																					 'R','');
		self.corp_ra_address_type_desc   := if(trim(l.addr_type_id,left,right) ='6' and corp2_mapping.fAddressExists(state_origin,state_desc,l.addr_line_1 +' '+l.addr_line_2,l.addr_line_3,l.addr_city,l.addr_state,l.addr_zip,l.addr_country).ifAddressExists,
																					 'REGISTERED OFFICE','');			
		self.corp_agent_county					 := if(trim(l.addr_type_id,left,right) ='6' ,corp2.t2u(l.addr_county),'');
		self.corp_merger_name						 := corp2.t2u(l.merged_name);
		self.corp_merged_corporation_id	 := corp2.t2u(l.mergedcorpid);
		self.corp_survivor_corporation_id:= corp2.t2u(l.survivorcorpid);
		self.corp_merger_date						 := corp2_mapping.fValidateDate(l.merg_date,Corp2_Mapping.fFormatOfDate(l.merg_date)).pastDate;										 
		self.corp_merger_indicator       := l.merger_indicator;
		self.recordorigin								 := 'C';	
		self                      		   := [];
		
	end;

	ds_mapCorp 			:= project(raw_corp,MO_corpTransform(left));
	ds_mapCorp_dis	:= dedup(sort(distribute(ds_mapCorp,hash(corp_key)),record,local),record,local):independent;	

	//Per CI: Only mailing addresses & NO Business address then populating business addresses from Mailing addresses & blanking mailing addresses ;
	ds_mapCorp_blk_addr1 := ds_mapCorp_dis(corp2.t2u(corp_address2_line1 + corp_address2_line2 + corp_address2_line3 ) <>'' and 
																				 corp2.t2u(corp_address1_line1 + corp_address1_line2 + corp_address1_line3 ) ='' 
																				);
	
	corp2_mapping.LayoutsCommon.Main AddressTransform(corp2_mapping.LayoutsCommon.Main l ,corp2_mapping.LayoutsCommon.Main r):=transform

		self.corp_address1_line1							:= if(l.corp_address1_line1 ='',r.corp_address2_line1,l.corp_address1_line1);
		self.corp_address1_line2							:= if(l.corp_address1_line2 ='',r.corp_address2_line2,l.corp_address1_line2);
		self.corp_address1_line3							:= if(l.corp_address1_line3 ='',r.corp_address2_line3,l.corp_address1_line3);
		self.corp_prep_addr1_line1						:= if(l.corp_prep_addr1_line1 ='',r.corp_prep_addr2_line1,l.corp_prep_addr1_line1);
		self.corp_prep_addr1_last_line				:= if(l.corp_prep_addr1_last_line ='',r.corp_prep_addr2_last_line,l.corp_prep_addr1_last_line);	
		self.corp_address1_type_cd		  			:= if(l.corp_address1_type_cd =''and l.corp_address2_type_cd<>'','B',l.corp_address1_type_cd);
		self.corp_address1_type_desc	  			:= if(l.corp_address1_type_desc =''and l.corp_address2_type_desc<>'','BUSINESS',l.corp_address1_type_desc);
		self.corp_address2_line1							:= if(l.corp_address1_line1 ='','',l.corp_address2_line1);
		self.corp_address2_line2							:= if(l.corp_address1_line2 ='','',l.corp_address2_line2);
		self.corp_address2_line3							:= if(l.corp_address1_line3 ='','',l.corp_address2_line3);
		self.corp_prep_addr2_line1						:= if(l.corp_prep_addr1_line1 ='','',l.corp_prep_addr2_line1);
		self.corp_prep_addr2_last_line				:= if(l.corp_prep_addr1_last_line='','',l.corp_prep_addr2_last_line);
		self.corp_address2_type_cd		  			:= if(l.corp_address1_type_cd=''and l.corp_address2_type_cd<>'','',l.corp_address2_type_cd);
		self.corp_address2_type_desc	  			:= if(l.corp_address1_type_desc=''and l.corp_address2_type_desc<>'','',l.corp_address2_type_desc);
		self																	:= l;

	End;

	MappedCorp										:= join(ds_mapCorp_dis ,ds_mapCorp_blk_addr1,
																				left.corp_key   = right.corp_key, 
																				AddressTransform(left,right),
																				left outer,
																				local);	
																						
	Corp2_Mapping.LayoutsCommon.main tGetStandardized(Corp2_Mapping.LayoutsCommon.main  l	,Corp2_Mapping.LayoutsCommon.main  r) :=transform

		self.corp_address1_type_cd   					:= if(r.corp_address1_type_cd <> '', r.corp_address1_type_cd,l.corp_address1_type_cd);
		self.corp_address1_type_desc					:= if(r.corp_address1_type_desc <> '',r.corp_address1_type_desc,l.corp_address1_type_desc);
		self.corp_address1_line1							:= if(r.corp_address1_line1 <> '',	r.corp_address1_line1,l.corp_address1_line1);
		self.corp_address1_line2 							:= if(r.corp_address1_line2 <> '',r.corp_address1_line2,l.corp_address1_line2);
		self.corp_address1_line3 							:= if(r.corp_address1_line3 <> '', r.corp_address1_line3,l.corp_address1_line3);
		self.corp_prep_addr1_line1						:= if(r.corp_prep_addr1_line1 <> '',r.corp_prep_addr1_line1,l.corp_prep_addr1_line1);
		self.corp_prep_addr1_last_line				:= if(r.corp_prep_addr1_last_line<> '',r.corp_prep_addr1_last_line,l.corp_prep_addr1_last_line);
		self.corp_address2_line1		  				:= if(r.corp_address2_line1 <> '',r.corp_address2_line1,l.corp_address2_line1);
		self.corp_address2_line2							:= if(r.corp_address2_line2 <> '',r.corp_address2_line2,l.corp_address2_line2);
		self.corp_address2_line3 							:= if(r.corp_address2_line3 <> '',r.corp_address2_line3,l.corp_address2_line3);
		self.corp_address2_type_cd   					:= if(r.corp_address2_type_cd <> '',r.corp_address2_type_cd,l.corp_address2_type_cd);
		self.corp_address2_type_desc					:= if(r.corp_address2_type_desc <> '',r.corp_address2_type_desc,l.corp_address2_type_desc);
		self.corp_prep_addr2_line1						:= if(r.corp_prep_addr2_line1 <> '',r.corp_prep_addr2_line1,l.corp_prep_addr2_line1);
		self.corp_prep_addr2_last_line				:= if(r.corp_prep_addr2_last_line<> '',r.corp_prep_addr2_last_line,l.corp_prep_addr2_last_line);
		self.corp_dissolved_date		  				:= if(r.corp_dissolved_date <> '',r.corp_dissolved_date, l.corp_dissolved_date);
		self.corp_status_date									:= if(l.corp_status_date ='',r.corp_status_date,l.corp_status_date);
		self.corp_status_comment							:= if(r.corp_status_comment <> '',r.corp_status_comment,l.corp_status_comment);
		self.corp_inc_county 									:= if(r.corp_inc_county <> '',r.corp_inc_county,l.corp_inc_county);
		self.corp_inc_date   									:= if(r.corp_inc_date <> '', r.corp_inc_date,l.corp_inc_date);
		self.corp_forgn_state_cd							:= if(r.corp_forgn_state_cd <> '',r.corp_forgn_state_cd,l.corp_forgn_state_cd);
		self.corp_forgn_state_desc						:= if(r.corp_forgn_state_desc <> '',r.corp_forgn_state_desc,l.corp_forgn_state_desc);
		self.corp_for_profit_ind							:= if(r.corp_for_profit_ind<> '', r.corp_for_profit_ind,l.corp_for_profit_ind);
		self.corp_ra_address_line1						:= if(l.corp_ra_address_line1 ='',r.corp_ra_address_line1,l.corp_ra_address_line1);
		self.corp_ra_address_line2						:= if(l.corp_ra_address_line2 ='',r.corp_ra_address_line2,l.corp_ra_address_line2);
		self.corp_ra_address_line3						:= if(l.corp_ra_address_line3 ='',r.corp_ra_address_line3,l.corp_ra_address_line3);
		self.ra_prep_addr_line1								:= if(l.ra_prep_addr_line1 ='',r.ra_prep_addr_line1,l.ra_prep_addr_line1);
		self.ra_prep_addr_last_line						:= if(l.ra_prep_addr_last_line ='',r.ra_prep_addr_last_line,l.ra_prep_addr_last_line);	
		self.corp_ra_address_type_cd					:= if(l.corp_ra_address_type_cd ='',r.corp_ra_address_type_cd,l.corp_ra_address_type_cd);
		self.corp_ra_address_type_desc				:= if(l.corp_ra_address_type_desc ='',r.corp_ra_address_type_desc,l.corp_ra_address_type_desc);
		self.corp_addl_info										:= if(l.corp_addl_info ='',r.corp_addl_info,l.corp_addl_info);
		self.corp_ra_full_name								:= if(l.corp_ra_full_name ='',r.corp_ra_full_name,l.corp_ra_full_name);
		self.corp_country_of_formation				:= if(l.corp_country_of_formation ='',r.corp_country_of_formation,l.corp_country_of_formation);	
		self.corp_home_incorporated_county		:= if(l.Corp_home_incorporated_county ='',r.Corp_home_incorporated_county,l.Corp_home_incorporated_county);
		self 																	:= l;

 end;
 
 MappedCorp_Addr_denorm	:= denormalize( MappedCorp,
																			  MappedCorp,
																				left.corp_key	= right.corp_key  ,  
																				tGetStandardized(left,right),
																				local
																			) ;

  MappedCorp_Addr	:=dedup(sort(distribute(MappedCorp_Addr_denorm,hash(corp_key)),record,local),record,local):independent;																					
																					
	//mapping event file!
	joinCorpfiling 										:= join(ds_corporation,ds_filing,
																						corp2.t2u(left.CorpID) =  corp2.t2u(right.CorpID),
																						transform(corp2_raw_mo.Layouts.TempCorpFiling,
																											self:=left;
																											self:=right;),
																						left outer,local):independent;
																 
	raw_corp_survivorCorpID						:= distribute(raw_corp,hash(SurvivorCorpID));
	joincorpfilingMerger 							:= join(joinCorpfiling ,raw_corp_survivorCorpID,
																						corp2.t2u(left.CorpID) = corp2.t2u(right.SurvivorCorpID),
																						transform(corp2_raw_mo.Layouts.TempCorpFiling_Merger,
																											self:=left;
																											self:=right;),
																						left outer,local);
								
	corp2_mapping.LayoutsCommon.Events MO_EventTransform(corp2_raw_mo.Layouts.TempCorpFiling_Merger l,integer ctr) := transform,
	skip(trim(l.documenttypeid,left,right) in AR_List or
			 (ctr=2 and corp2_mapping.fvalidatedate(l.effective_date,Corp2_Mapping.fFormatOfDate(l.effective_date)).generaldate='' and  corp2_mapping.fvalidatedate(l.merg_date,Corp2_Mapping.fFormatOfDate(l.merg_date)).pastdate='' ) or 
				ctr=3 and corp2_mapping.fvalidatedate(l.merg_date,Corp2_Mapping.fFormatOfDate(l.merg_date)).pastdate=''
			 )
				
		self.corp_key										:= state_fips +'-'+ corp2.t2u(l.CorpID);
		Self.corp_vendor                := state_fips ;
		Self.corp_state_origin          := state_origin;
		self.corp_sos_charter_nbr				:= corp2.t2u(l.corp_num);										
		Self.corp_process_date          := FileDate;
		self.event_filing_reference_nbr := corp2.t2u(l.filingid); 
		CleanFilingDate                 := corp2_mapping.fValidateDate(l.filing_date,Corp2_Mapping.fFormatOfDate(l.filing_date)).PastDate;
		CleanEffDate	                	:= corp2_mapping.fValidateDate(l.effective_date,Corp2_Mapping.fFormatOfDate(l.effective_date)).generaldate;
		CleanMergeDate	                := corp2_mapping.fValidateDate(l.merg_date,Corp2_Mapping.fFormatOfDate(l.merg_date)).PastDate; 
		//overload -All merger file info! 
		self.event_filing_date				  := choose(ctr,CleanFilingDate,cleanEffDate,CleanMergeDate);
		self.event_date_type_cd         := choose(ctr,if(corp2.t2u(CleanFilingDate)<>'','FIL',''),if(corp2.t2u(cleanEffDate)<>'','EFF',''),if(corp2.t2u(CleanMergeDate)<>'','MER',''));					
		self.event_date_type_desc       := choose(ctr,if(corp2.t2u(CleanFilingDate)<>'','FILING',''),if(corp2.t2u(cleanEffDate)<>'','EFFECTIVE',''),if(corp2.t2u(CleanMergeDate)<>'','MERGER',''));
		self.event_desc                 := if(corp2.t2u(CleanMergeDate)<>'', 
																						if(corp2.t2u(l.survivor_name)<>'' and corp2.t2u(l.Merged_name)<>'' ,'SURVIVOR: '+ corp2.t2u(l.survivor_name)+'; '+'NON-SURVIVOR: '+ corp2.t2u(l.Merged_name),
																							 if(corp2.t2u(l.survivor_name)<>'' ,'SURVIVOR: '+ corp2.t2u(l.survivor_name),if(corp2.t2u(l.Merged_name)<>'' ,'NON-SURVIVOR: '+ corp2.t2u(l.Merged_name),'')))
																					,'');																								
		self.event_filing_cd            := corp2.t2u(l.documenttypeid);
		self													  := [];
		
	end;

	ds_mapEvent_norm 		:= normalize(joincorpfilingMerger,3,mo_eventtransform(left, counter));		
	ds_mapEvent_docType := join(ds_mapEvent_norm,DocumentType_DescLn,
															corp2.t2u(left.event_filing_cd) = corp2.t2u(right.TypeCode), 
															transform(corp2_mapping.LayoutsCommon.Events,
																				//Null/unprintable characters noticed in the data & fitting into 60 length  ,Cleaning â chars through "STD.Uni.CleanAccents" !
																				self.event_filing_desc    := map(corp2.t2u((string)STD.Uni.CleanAccents(regexreplace('\\x00|',right.typeDesc,'')))='REINSTATEMENT A REGISTRATION REPORTS FOR FOREIGN NON-PROFIT' 	 =>'REINSTATEMENT A REG REPORTS FOR FOREIGN NON-PROFIT', 
																																				 corp2.t2u((string)STD.Uni.CleanAccents(regexreplace('\\x00|',right.typeDesc,'')))='REINSTATEMENT A REGISTRATION REPORTS FOR FOREIGN GENERAL BUS.' =>'REINSTATEMENT A REG REPORTS FOR FOREIGN GENERAL BUS.', 
																																				 (right.len =60 or right.len <60) and corp2.t2u(right.typeDesc) 								 <>''																															 =>corp2.t2u((string)STD.Uni.CleanAccents(regexreplace('\\x00|',right.typeDesc,''))),
																																				 //Functions.filing_desc/fitting into 60 lengths due to "event_filing_desc" defined as 60 in common layout
																																				  right.len >60 and corp2.t2u(right.typeDesc) 								  								 <>'' 																														 =>corp2_raw_mo.Functions.filing_desc(left.event_filing_cd), 
																																				 '');
																				self											 :=left;),
															 left outer,lookup);
															 
	ds_mapEvent    			:= ds_mapEvent_docType(corp2.t2u(event_filing_reference_nbr + event_filing_cd + event_filing_date + event_desc)<>'');												 
	ds_mapEvent_dis    	:= dedup(sort(distribute(ds_mapEvent,hash(corp_key)),record,local),record,local):independent;	

	corp2_mapping.LayoutsCommon.AR MO_arTransform(corp2_raw_mo.Layouts.TempCorpFiling l) := transform,
	skip(trim(l.documenttypeid,left,right) not in AR_List or 
			 (corp2_mapping.fValidateDate(l.filing_date,Corp2_Mapping.fFormatOfDate(l.filing_date)).PastDate='' and 
				corp2_mapping.fValidateDate(l.effective_date,Corp2_Mapping.fFormatOfDate(l.effective_date)).GeneralDate='' and
				trim(l.documenttypeid)='')
			)
		
		Self.corp_key 							:= state_fips +'-'+ corp2.t2u(l.CorpID);
		Self.corp_vendor 						:= state_fips ;
		Self.corp_state_origin 			:= state_origin;
		Self.corp_process_date 			:= fileDate;
		self.corp_sos_charter_nbr 	:= corp2.t2u(l.corp_num);							
		self.ar_report_dt						:= corp2_mapping.fValidateDate(l.filing_date,Corp2_Mapping.fFormatOfDate(l.filing_date)).PastDate; 	
		CleanEffectiveDate          := corp2_mapping.fValidateDate(l.effective_date,Corp2_Mapping.fFormatOfDate(l.effective_date)).GeneralDate;	
		fix_format									:= CleanEffectiveDate[5..6] + '/' + CleanEffectiveDate[7..8] + '/' + CleanEffectiveDate[1..4]; //mm/dd/yyyy per CI 
		self.ar_comment             := if(trim(fix_format) <>'','EFFECTIVE DATE: '+ fix_format,'');
		self.ar_type                := corp2.t2u(l.documenttypeid);																	
		self											 	:= [];
		
	end; 

	ds_mapAR_proj 			:= project(joinCorpfiling,MO_arTransform(left));
	ds_mapAR_docType 		:= join(ds_mapAR_proj,DocumentType_Table,
															corp2.t2u(left.ar_type)  =  corp2.t2u(right.TypeCode),
															transform(corp2_mapping.LayoutsCommon.AR,
																				self.ar_type    := map(corp2.t2u(right.typeDesc)<>''=>corp2.t2u((string)STD.Uni.CleanAccents(right.typeDesc)),//Cleaning â characters ,noticed in the data 
																															 corp2.t2u(left.ar_type)  ='' =>'',
																															 '**|'+ corp2.t2u(left.ar_type)
																															 );	//scrubs will catch codes those don't have descriptions 
																				self:=left;),
															left outer, lookup);
												
	ds_mapAR_dedup     := dedup(sort(distribute(ds_mapAR_docType,hash(corp_key)),record ,local),record,local);
	ds_mapAR           := sort(ds_mapAR_dedup,corp_key,-ar_report_dt):independent; //Per CI: sort by descending Ar report order
												
	//if there is no match between officerID & OfficerParty lookup table ,retaining vender "OfficerPartyId" values so that scrubs can catch codes those don't have descriptions in patytype table!													
	ds_officer_title   :=	join(ds_officer,OfficerPartyType_Table,
														 trim(left.OfficerPartyId,left,right) = trim(right.officerID,left,right),
														 transform(corp2_raw_mo.Layouts.OfficerLayoutIn,
																			 self.OfficerPartyId:=if(trim(right.partytypeid)<>'',right.partytypeid,left.OfficerPartyId); 
																			 self			   				:=left;
																			 ),
														 left outer,lookup);
														
	corp2_mapping.LayoutsCommon.Main  contactTransform(corp2_raw_mo.Layouts.OfficerLayoutIn l) := transform,
	skip(corp2_mapping.fCleanBusinessName(state_origin ,state_desc,corp2.t2u(l.Title+ ' '+ l.Salutation + ' '+ l.contName)).BusinessName='')	
		
		self.dt_vendor_first_reported		  := (integer)fileDate;
		self.dt_vendor_last_reported		  := (integer)fileDate;
		self.dt_first_seen							  := (integer)fileDate;
		self.dt_last_seen								  := (integer)fileDate;
		self.corp_ra_dt_first_seen			  := (integer)fileDate;
		self.corp_ra_dt_last_seen				  := (integer)fileDate;					
		self.corp_process_date					  := fileDate;
		self.corp_key											:= state_fips +'-'+ corp2.t2u(l.CorpID);
		self.corp_vendor									:= state_fips ;
		self.corp_state_origin						:= state_origin;
		self.cont_full_name 							:= corp2_mapping.fCleanBusinessName(state_origin ,state_desc,corp2.t2u(l.Title+ ' '+ l.Salutation + ' '+ l.contName)).BusinessName;		
		self.cont_address_line1						:= corp2_mapping.fCleanAddress(state_origin,state_desc,l.Address1 +' '+l.Address2,l.Address3,l.city,l.State,l.Zip,l.countryname).AddressLine1;
		self.cont_address_line2						:= corp2_mapping.fCleanAddress(state_origin,state_desc,l.Address1 +' '+l.Address2,l.Address3,l.city,l.State,l.Zip,l.countryname).AddressLine2;
		self.cont_address_line3						:= corp2_mapping.fCleanAddress(state_origin,state_desc,l.Address1 +' '+l.Address2,l.Address3,l.city,l.State,l.Zip,l.countryname).AddressLine3;
		self.cont_prep_addr_line1				  := corp2_mapping.fCleanAddress(state_origin,state_desc,l.Address1 +' '+l.Address2,l.Address3,l.city,l.State,l.Zip,l.countryname).PrepAddrLine1;
		self.cont_prep_addr_last_line		  := corp2_mapping.fCleanAddress(state_origin,state_desc,l.Address1 +' '+l.Address2,l.Address3,l.city,l.State,l.Zip,l.countryname).PrepAddrLastLine;
		self.cont_address_type_cd     		:= if(corp2_mapping.fAddressExists(state_origin,state_desc,l.Address1 +' '+l.Address2,l.Address3,l.city,l.State,l.Zip,l.countryname).ifAddressExists,
																						'T','');
		self.cont_address_type_desc   		:= if(corp2_mapping.fAddressExists(state_origin,state_desc,l.Address1 +' '+l.Address2,l.Address3,l.city,l.State,l.Zip,l.countryname).ifAddressExists,
																						'CONTACT','');
		valid_owner_addl                  := corp2.t2u(l.ownerprecentage);
		valid_realestate_adl              := corp2.t2u(l.transferrealestate);
		 //overload
		self.cont_addl_info				        := if(corp2.t2u(valid_owner_addl )<> '' and  corp2.t2u(valid_realestate_adl)<>'' , valid_owner_addl  + '; '+ valid_realestate_adl,
																						if(corp2.t2u(valid_realestate_adl)<>'',valid_realestate_adl,valid_owner_addl)
																						);	
		self.cont_title1_desc 					  := corp2_raw_mo.Functions.title_desc(l.OfficerPartyId); //added for scrubs
		self.cont_type_cd					        :='T';			  //overload
		self.cont_type_desc					      :='CONTACT'; //overload
		self.recordorigin								  :='T';	
		self                      		    :=[];
		
	end;	

	MapCont_proj						 := project(ds_officer_title,contactTransform(left));	
	MapCont									 := dedup(sort(distribute(MapCont_proj,hash(corp_key)),record,local),record,local):independent;
	MapCont_Legal_CharterNbr := join(MappedCorp_Addr,MapCont,
																	 trim(left.corp_key)= trim(right.corp_key) ,
																	 transform(corp2_mapping.LayoutsCommon.Main,
																						 self.corp_orig_sos_charter_nbr	:= left.corp_orig_sos_charter_nbr;
																						 self.corp_legal_name						:= left.corp_legal_name;	
																						 self:=right;),
																	 inner,local);
	//Mapping Stock file!
	joinCorpStock := join(ds_corporation,ds_Stock,
												corp2.t2u(left.CorpID)= corp2.t2u(right.CorpID),
												transform(corp2_raw_mo.Layouts.Temp_corporationStock,
																	self:=left;
																	self:=right;),
												inner,local);

	corp2_mapping.LayoutsCommon.Stock  StockTransform(corp2_raw_mo.Layouts.Temp_corporationStock l):=transform			
		
		self.corp_process_date						:= fileDate;
		self.corp_vendor									:= state_fips ;
		self.corp_state_origin						:= state_origin;						
		self.corp_key								      := state_fips +'-'+ corp2.t2u(l.CorpID);
		self.corp_sos_charter_nbr		      := corp2.t2u(l.corp_num);
		self.stock_authorized_nbr					:= if((string)(integer)corp2.t2u(l.AuthorizedShares)<>'0',(string)(integer)corp2.t2u(l.AuthorizedShares),'');		
		self.stock_addl_info       				:= map((string)(integer)corp2.t2u(l.IssuedShares)='0'=>'STOCK NOT ISSUED',
																						 (string)(integer)corp2.t2u(l.IssuedShares)='1'=>'STOCK ISSUED',
																						 ''); 
		self.stock_par_value 							:= if((string)(integer)corp2.t2u(l.ParValue)<>'0',(string)(integer)corp2.t2u(l.ParValue),'');
		self.stock_type                   := map(trim(l.StockClassID,left,right)='1001'=>'COMMOM',
																						 trim(l.StockClassID,left,right)='1011'=>'PREFERRED',
																						 '');		
		self															:= [];
		
	end;

	MapStock_proj := project(joinCorpStock,StockTransform(left))(corp2.t2u(stock_authorized_nbr + stock_addl_info + stock_par_value + stock_type)<>'');
	MapStock  		:= dedup(sort(distribute(MapStock_proj,hash(corp_key)),record,local),record,local);		

	//=============================================SCRUB LOGIC====================================================

	Main_F 										:= dedup(sort(distribute(MappedCorp_Addr + MapCont_Legal_CharterNbr ,hash(corp_key)),record,local),record,local):independent; 
 	Main_S 										:= Scrubs_corp2_mapping_MO_Main.Scrubs;					  // Scrubs module
	Main_N 										:= Main_S.FromNone(Main_F); 										 // Generate the error flags
	Main_T 										:= Main_S.FromBits(Main_N.BitmapInfile);     		// Use the FromBits module; makes my bitmap datafile easier to get to
	Main_U 									  := Main_S.FromExpanded(Main_N.ExpandedInFile); // Pass the expanded error flags into the Expanded module

	//outputs reports
	Main_ErrorSummary					:= output(Main_U.SummaryStats, named('Main_ErrorSummary_MO_'+filedate));
	Main_ScrubErrorReport 		:= output(choosen(Main_U.AllErrors, 1000), named('Main_ScrubErrorReport_MO_'+filedate));
	Main_SomeErrorValues			:= output(choosen(Main_U.BadValues, 1000), named('Main_SomeErrorValues_MO_'+filedate));
	Main_IsScrubErrors		 		:= if(count(Main_U.AllErrors)<> 0,true,false);

	// Orbit Stats
	Main_OrbitStats						:= Main_U.OrbitStats();

	//outputs files
	Main_CreateBitMaps				:= output(Main_N.BitmapInfile,,'~thor_data::corp_MO_main_scrubs_bits',overwrite,compressed);	//long term storage
	Main_TranslateBitMap			:= output(Main_T);
	//Creates Profile's alert template for Orbit - can be copied and imported into Orbit; Only required if rules in Orbit change
	Main_AlertsCSVTemplate		:= Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_'+state_origin+'_Main','ScrubsAlerts', Main_OrbitStats, version,'Corp2_'+state_origin+'_Main').ProfileAlertsTemplate;
	//Submits Profile's stats to Orbit
	Main_SubmitStats 			  	:= Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_'+state_origin+'_Main','ScrubsAlerts', Main_OrbitStats, version,'Corp2_'+state_origin+'_Main').SubmitStats;
	Main_ScrubsWithExamples		:= Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_'+state_origin+'_Main','ScrubsAlerts', Main_OrbitStats, version,'Corp2_'+state_origin+'_Main').CompareToProfile_with_Examples;
	
	Main_ScrubsAlert					:= Main_ScrubsWithExamples(RejectWarning = 'Y');
	Main_ScrubsAttachment			:= Scrubs.fn_email_attachment(Main_ScrubsAlert);
	Main_SendEmailFile				:= FileServices.SendEmailAttachData( corp2.Email_Notification_Lists.spray
																																 ,'Scrubs CorpMain_MO Report' //subject
																																 ,'Scrubs CorpMain_MO Report' //body
																																 ,(data)Main_ScrubsAttachment
																																 ,'text/csv'
																																 ,'CorpMOMainScrubsReport.csv'
																																 ,
																																 ,
																																 ,corp2.Email_Notification_Lists.spray
																															 );

		Main_BadRecords		  		:= Main_N.ExpandedInFile(dt_vendor_first_reported_Invalid 		<> 0 or
																										 dt_vendor_last_reported_Invalid 			<> 0 or
																										 dt_first_seen_Invalid 								<> 0 or
																										 dt_last_seen_Invalid 								<> 0 or
																										 corp_ra_dt_first_seen_Invalid 			  <> 0 or
																										 corp_ra_dt_last_seen_Invalid 			  <> 0 or
																										 corp_key_Invalid 										<> 0 or
																										 corp_vendor_Invalid 									<> 0 or
																										 corp_state_origin_Invalid 						<> 0 or
																										 corp_process_date_Invalid 						<> 0 or
																										 corp_orig_sos_charter_nbr_Invalid 		<> 0 or
																										 corp_legal_name_Invalid 							<> 0 or
																										 corp_ln_name_type_cd_Invalid 				<> 0 or
																										 corp_address1_type_cd_Invalid 				<> 0 or
																										 corp_status_cd_Invalid 							<> 0 or
																										 corp_inc_date_Invalid 								<> 0 or
																										 corp_foreign_domestic_ind_Invalid 		<> 0 or
																										 corp_forgn_state_cd_Invalid 					<> 0 or																										 
																										 corp_forgn_state_desc_Invalid 				<> 0 or
																										 corp_forgn_date_Invalid 							<> 0 or
																										 corp_orig_org_structure_cd_Invalid 	<> 0 or
																										 corp_for_profit_ind_Invalid 					<> 0 or
																										 cont_title1_desc_Invalid 						<> 0 or
																										 recordorigin_Invalid 								<> 0 
																							     );
																																										
	Main_GoodRecords			:=Main_N.ExpandedInFile(dt_vendor_first_reported_Invalid 			= 0 and
																								dt_vendor_last_reported_Invalid 			= 0 and
																								dt_first_seen_Invalid 								= 0 and
																								dt_last_seen_Invalid 								  = 0 and
																								corp_ra_dt_first_seen_Invalid 			  = 0 and
																								corp_ra_dt_last_seen_Invalid 			    = 0 and
																								corp_key_Invalid 											= 0 and
																								corp_vendor_Invalid 									= 0 and
																								corp_state_origin_Invalid 						= 0 and
																								corp_process_date_Invalid 						= 0 and
																								corp_orig_sos_charter_nbr_Invalid 		= 0 and
																								corp_legal_name_Invalid 							= 0 and
																								corp_ln_name_type_cd_Invalid 					= 0 and
																								corp_address1_type_cd_Invalid 				= 0 and
																								corp_status_cd_Invalid 								= 0 and
																								corp_inc_date_Invalid 								= 0 and
																								corp_foreign_domestic_ind_Invalid 		= 0 and
																								corp_forgn_state_cd_Invalid 					= 0 and
																								corp_forgn_state_desc_Invalid 				= 0 and
																								corp_forgn_date_Invalid 							= 0 and
																								corp_orig_org_structure_cd_Invalid 		= 0 and
																								corp_for_profit_ind_Invalid 					= 0 and
																								cont_title1_desc_Invalid 							= 0 and
																								recordorigin_Invalid 									= 0 
																							);

	Main_FailBuild	:= map( corp2_mapping.fCalcPercent(count(Main_N.ExpandedInFile(corp_key_invalid<>0)),count(Main_N.ExpandedInFile),false) 										> Scrubs_corp2_mapping_MO_Main.Threshold_Percent.CORP_KEY										            => true,
													corp2_mapping.fCalcPercent(count(Main_N.ExpandedInFile(corp_orig_sos_charter_nbr_invalid<>0)),count(Main_N.ExpandedInFile),false) 	> Scrubs_corp2_mapping_MO_Main.Threshold_Percent.CORP_ORIG_SOS_CHARTER_NBR 	            => true,
													corp2_mapping.fCalcPercent(count(Main_N.ExpandedInFile(corp_legal_name_invalid<>0)),count(Main_N.ExpandedInFile),false) 						> Scrubs_corp2_mapping_MO_Main.Threshold_Percent.CORP_LEGAL_NAME 						            => true,
													count(Main_GoodRecords) = 0																																																																																											 						=> true,																		
													false
												);

	Main_ApprovedRecords  := project(Main_GoodRecords,transform(corp2_mapping.LayoutsCommon.Main,self := left));
	Main_RejFile_Exists		:= if(FileServices.FileExists(corp2_mapping._dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::main_' + state_origin),true,false);			
	Main_ALL		 					:= sequential(if(count(Main_BadRecords) <> 0
																						,IF (poverwrite
																								 ,output(Main_BadRecords,,corp2_mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::main_MO',overwrite,__compressed__,named('Sample_Rejected_MainRecs_MO_'+filedate))
																								 ,sequential (if(Main_RejFile_Exists,fileservices.deletelogicalfile(corp2_mapping._dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::main_'+ state_origin)),
																														  output(Main_BadRecords,,corp2_mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::main_'+ state_origin,__compressed__,named('Sample_Rejected_MainRecs_MO_'+filedate))
																														 )
																								)
																					)
																			,output(Main_ScrubsWithExamples, ALL, NAMED('CorpMainScrubsReportWithExamples_MO_'+filedate))																		
																			//Send Alerts if Scrubs exceeds thresholds
																			,if(count(Main_ScrubsAlert) > 0,Main_SendEmailFile, output('corp2_mapping.MD - No "MAIN" Corp Scrubs Alerts'))
																			,Main_ErrorSummary
																			,Main_ScrubErrorReport
																			,Main_SomeErrorValues	
																			//,Main_AlertsCSVTemplate
																			,Main_SubmitStats				
																    	);
																		
	//********************************************************************
	// SCRUB EVENT
	//********************************************************************	
	Event_F 									:= ds_mapEvent_dis;
	Event_S 									:= Scrubs_corp2_mapping_MO_Event.Scrubs;						 // Scrubs module
	Event_N 									:= Event_S.FromNone(Event_F); 											// Generate the error flags
	Event_T 									:= Event_S.FromBits(Event_N.BitmapInfile);     		 // Use the FromBits module; makes my bitmap datafile easier to get to
	Event_U 									:= Event_S.FromExpanded(Event_N.ExpandedInFile); 	// Pass the expanded error flags into the Expanded module

	//outputs reports
	Event_ErrorSummary				:= output(Event_U.SummaryStats, named('Event_ErrorSummary_MO'+filedate));
	Event_ScrubErrorReport 		:= output(choosen(Event_U.AllErrors, 1000), named('Event_ScrubErrorReport_MO'+filedate));
	Event_SomeErrorValues			:= output(choosen(Event_U.BadValues, 1000), named('Event_SomeErrorValues_MO'+filedate));
	Event_IsScrubErrors		 		:= if(count(Event_U.AllErrors)<> 0,true,false);

	// Orbit Stats
	Event_OrbitStats					:= Event_U.OrbitStats();

	//outputs files
	Event_CreateBitMaps				:= output(Event_N.BitmapInfile,,'~thor_data::corp_MO_event_scrubs_bits',overwrite,compressed);	//long term storage
	Event_TranslateBitMap			:= output(Event_T);
	//Creates Profile's alert template for Orbit - Can be copied & imported into Orbit; Only required first time & if scrub rules change
	Event_AlertsCSVTemplate	  := Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_'+ state_origin+'_Event','ScrubsAlerts', Event_OrbitStats, version,'Corp2_'+ state_origin+'_Event').ProfileAlertsTemplate;
	//Submits Profile's stats to Orbit
	Event_SubmitStats 				:= Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_'+ state_origin+'_Event','ScrubsAlerts', Event_OrbitStats, version,'Corp2_'+ state_origin+'_Event').SubmitStats;

	Event_ScrubsWithExamples	:= Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_'+ state_origin+'_Event','ScrubsAlerts', Event_OrbitStats, version,'Corp2_'+ state_origin+'_Event').CompareToProfile_with_Examples;
	
	Event_ScrubsAlert					:= Event_ScrubsWithExamples(RejectWarning = 'Y');
	Event_ScrubsAttachment		:= Scrubs.fn_email_attachment(Event_ScrubsAlert);
	Event_MailFile						:= FileServices.SendEmailAttachData( corp2.Email_Notification_Lists.spray
																																 ,'Scrubs CorpEvent_MO Report' //Subject
																																 ,'Scrubs CorpEvent_MO Report' //body
																																 ,(data)Event_ScrubsAttachment
																																 ,'text/csv'
																																 ,'CorpMOEventScrubsReport.csv'
																																 ,
																																 ,
																																 ,corp2.Email_Notification_Lists.spray
																															 );
																															
	Event_BadRecords 			:= Event_T.ExpandedInFile (event_filing_desc_invalid <> 0);	
	Event_GoodRecords			:= Event_T.ExpandedInFile(event_filing_desc_invalid	 = 0 );	
	Event_ApprovedRecords := project(Event_GoodRecords,transform(corp2_mapping.LayoutsCommon.Events,self := left));		

	Event_RejFile_Exists	:= if(FileServices.FileExists(corp2_mapping._dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::event_' + state_origin),true,false);			
	Event_ALL							:= sequential(if(count(Event_BadRecords)<> 0
																				 ,if(poverwrite
																						 ,output(Event_BadRecords,,corp2_mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::event_MO',overwrite,__compressed__,named('Sample_Rejected_Event_Recs_MO_'+filedate))
																						 ,sequential(if(Event_RejFile_Exists,fileservices.deletelogicalfile(corp2_mapping._dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::event_'+ state_origin)),
																												 output(Main_BadRecords,,corp2_mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::event_'+ state_origin,__compressed__,named('Sample_Rejected_Event_Recs_MO_'+filedate))
																												)
																						)
																					)
																			 ,output(Event_ScrubsWithExamples, ALL, NAMED('CorpEventMOScrubsReportWithExamples'+filedate))
																			 //Send Alerts if Scrubs exceeds thresholds
																			 ,if(count(Event_ScrubsAlert) > 0, Event_MailFile, output('corp2_mapping.MO - No "EVENT" Corp Scrubs Alerts'))
																			 ,Event_ErrorSummary
																			 ,Event_ScrubErrorReport
																			 ,Event_SomeErrorValues
																		 //,Event_AlertsCSVTemplate
																			 ,Event_SubmitStats
																		 );
	//********************************************************************
		// SCRUB AR 
	//********************************************************************	
	AR_F 									 := ds_mapAR;
	AR_S 									 := Scrubs_corp2_mapping_MO_AR.Scrubs;				 // Scrubs module
	AR_N 								   := AR_S.FromNone(AR_F); 											// Generate the error flags
	AR_T 									 := AR_S.FromBits(AR_N.BitmapInfile);     	 // Use the FromBits module; makes my bitmap datafile easier to get to
	AR_U 									 := AR_S.FromExpanded(AR_N.ExpandedInFile); // Pass the expanded error flags into the Expanded module

	//outputs reports
	AR_ErrorSummary			 	 := output(AR_U.SummaryStats, named('AR_ErrorSummary_MO'+ filedate));
	AR_ScrubErrorReport 	 := output(choosen(AR_U.AllErrors, 1000), named('AR_ScrubErrorReport_MO'+ filedate));
	AR_SomeErrorValues		 := output(choosen(AR_U.BadValues, 1000), named('AR_SomeErrorValues_MO'+ filedate));
	AR_IsScrubErrors		 	 := if(count(AR_U.AllErrors)<> 0,true,false);

	// Orbit Stats
	AR_OrbitStats				 	 := AR_U.OrbitStats();

	//outputs files
	AR_CreateBitMaps			 := output(AR_N.BitmapInfile,,'~thor_data::corp_MO_ar_scrubs_bits',overwrite,compressed);	//long term storage
	AR_TranslateBitMap		 := output(AR_T);
	//Creates Profile's alert template for Orbit - can be copied and imported into Orbit; Only required if rules in Orbit change
	AR_AlertsCSVTemplate	 := Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_'+state_origin+'_AR','ScrubsAlerts', AR_OrbitStats, version,'Corp2_'+state_origin+'_AR').ProfileAlertsTemplate;
	//Submits Profile's stats to Orbit
	AR_SubmitStats 				 := Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_'+state_origin+'_AR','ScrubsAlerts', AR_OrbitStats, version,'Corp2_'+state_origin+'_AR').SubmitStats;
  AR_ScrubsWithExamples  := Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_'+state_origin+'_AR','ScrubsAlerts', AR_OrbitStats, version,'Corp2_'+state_origin+'_AR').CompareToProfile_with_Examples;
	AR_ScrubsAlert				 := AR_ScrubsWithExamples(RejectWarning = 'Y');
	AR_ScrubsAttachment	   := Scrubs.fn_email_attachment(AR_ScrubsAlert);
	AR_MailFile					   := FileServices.SendEmailAttachData( corp2.Email_Notification_Lists.spray
																															,'Scrubs CorpAR_MO Report' //subject
																															,'Scrubs CorpAR_MO Report' //body
																															,(data)AR_ScrubsAttachment
																															,'text/csv'
																															,'CorpMOARScrubsReport.csv'
																															,
																															,
																															,corp2.Email_Notification_Lists.spray
																													);

	AR_BadRecords 			:= AR_T.ExpandedInFile(ar_type_invalid <> 0);	
	AR_GoodRecords			:= AR_T.ExpandedInFile(ar_type_invalid	= 0);	
	AR_ApprovedRecords  := project(AR_GoodRecords,transform(corp2_mapping.LayoutsCommon.ar,self := left));	

	AR_ALL							:= sequential(if(count(AR_BadRecords) <> 0
																			 ,IF (poverwrite
																						,output(AR_BadRecords,,corp2_mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::ar_'+state_origin,overwrite,__compressed__)
																						,output(AR_BadRecords,,corp2_mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::ar_'+state_origin,__compressed__)
																						)
																			 )
																		 ,output(AR_ScrubsWithExamples, ALL, NAMED('CorpARMOScrubsReportWithExamples'+filedate))
																		 //Send Alerts if Scrubs exceeds thresholds
																		 ,if(count(AR_ScrubsAlert) > 0, AR_MailFile, output('corp2_mapping.MO - No "AR" Corp Scrubs Alerts'))
																		 ,AR_ErrorSummary
																		 ,AR_ScrubErrorReport
																		 ,AR_SomeErrorValues																				 
																	 //,AR_AlertsCSVTemplate
																		 ,AR_SubmitStats
																		);
																																							 
	//==========================================VERSION CONTROL====================================================
	IsScrubErrors	:= if(Main_IsScrubErrors = true or Event_IsScrubErrors = true or AR_IsScrubErrors=true ,true,false);
	versionControl.macBuildNewLogicalFile(corp2_mapping._dataset().thor_cluster_Files + 'in::corp2::'+version+'::main_' + state_origin		,Main_ApprovedRecords  ,main_out	,,,pOverwrite);		
	versionControl.macBuildNewLogicalFile(corp2_mapping._dataset().thor_cluster_Files + 'in::corp2::'+version+'::event_' + state_origin		,Event_ApprovedRecords ,event_out	,,,pOverwrite);
	versionControl.macBuildNewLogicalFile(corp2_mapping._dataset().thor_cluster_Files + 'in::corp2::'+version+'::ar_' + state_origin			,AR_ApprovedRecords	   ,ar_out		,,,pOverwrite);
	versionControl.macBuildNewLogicalFile(corp2_mapping._dataset().thor_cluster_Files + 'in::corp2::'+version+'::stock_' + state_origin		,MapStock						   ,stock_out	,,,pOverwrite);

	VersionControl.macBuildNewLogicalFile(corp2_mapping._dataset().thor_cluster_Files + 'fail::corp2::'+version+'::main_'	+ state_origin  ,Main_F	  ,write_fail_main  ,,,pOverwrite); 
	VersionControl.macBuildNewLogicalFile(corp2_mapping._dataset().thor_cluster_Files + 'fail::corp2::'+version+'::ar_'	+ state_origin  	,AR_F	  	,write_fail_ar		,,,pOverwrite); 
	VersionControl.macBuildNewLogicalFile(corp2_mapping._dataset().thor_cluster_Files + 'fail::corp2::'+version+'::event_'	+ state_origin,Event_F	,write_fail_event ,,,pOverwrite); 

	run_Main := 	sequential(	if( pshouldspray = TRUE,corp2_mapping.fSprayFiles(state_origin ,version,pOverwrite := pOverwrite))
													  //,Corp2_Raw_MO.Build_Bases(filedate,version,pUseProd).All  // Determined building of bases is not needed
														,main_out
														,event_out
														,ar_out	
														,stock_out
														,if(count(Main_BadRecords) <> 0 or count(Event_GoodRecords)<> 0 or count(AR_GoodRecords)<> 0
																,sequential(fileservices.addsuperfile(corp2_mapping._Dataset().thor_cluster_Files + 'in::'+corp2_mapping._Dataset().NameMapped+'::sprayed::ar'		,corp2_mapping._Dataset().thor_cluster_Files + 'in::corp2::'+version+'::ar_mo')
																						,fileservices.addsuperfile(corp2_mapping._Dataset().thor_cluster_Files + 'in::'+corp2_mapping._Dataset().NameMapped+'::sprayed::event',corp2_mapping._Dataset().thor_cluster_Files + 'in::corp2::'+version+'::event_mo')
																						,fileservices.addsuperfile(corp2_mapping._Dataset().thor_cluster_Files + 'in::'+corp2_mapping._Dataset().NameMapped+'::sprayed::main'	,corp2_mapping._Dataset().thor_cluster_Files + 'in::corp2::'+version+'::main_mo')	
																						,fileservices.addsuperfile(corp2_mapping._Dataset().thor_cluster_Files + 'in::'+corp2_mapping._Dataset().NameMapped+'::sprayed::stock',corp2_mapping._Dataset().thor_cluster_Files + 'in::corp2::'+version+'::stock_mo')																		 
                                            ,if (count(Main_BadRecords) <> 0 or count(Event_GoodRecords)<> 0 or count(AR_GoodRecords)<> 0
																								 ,corp2_mapping.Send_Email(state_origin,version,count(Main_Badrecords)<>0,count(AR_Badrecords)<>0,count(Event_Badrecords)<>0,,count(Main_Badrecords),count(AR_Badrecords),count(Event_Badrecords),,count(Main_Approvedrecords),count(AR_Approvedrecords),count(Event_Approvedrecords),count(mapStock)).recordsRejected																				 
																								 ,corp2_mapping.Send_Email(state_origin,version,count(Main_Badrecords)<>0,count(AR_Badrecords)<>0,count(Event_Badrecords)<>0,,count(Main_Badrecords),count(AR_Badrecords),count(Event_Badrecords),,count(Main_Approvedrecords),count(AR_Approvedrecords),count(Event_Approvedrecords),count(mapStock)).mappingSuccess	
																								)
																								
																						,if(IsScrubErrors
																								,corp2_mapping.Send_Email(state_origin ,version,Main_IsScrubErrors,AR_IsScrubErrors,Event_IsScrubErrors,false).FieldsInvalidPerScrubs
																								)		
																					 )
																 ,sequential(  write_fail_main//if it fails on main file threshold ,still writing mapped files!
																							,write_fail_event
																							,write_fail_ar
																							,corp2_mapping.Send_Email(state_origin ,version).MappingFailed
																						)
															)
											
													,Main_All	
													,Event_All
													,AR_All
												);
			
		//Validating the filedate entered is within 30 days	
		isFileDateValid := if((string)Std.Date.Today() between ut.date_math(filedate,-30) and ut.date_math(filedate,30),true,false);												
		result		 			:= if(isFileDateValid
													,run_Main 
													,sequential (corp2_mapping.Send_Email(state_origin ,filedate).InvalidFileDateParm
																			 ,FAIL('corp2_mapping.mo failed.An invalid filedate was passed in as a parameter.')
																			 )
												 );



	return result ;

	End;  // Update Function 

End; //  Module 

