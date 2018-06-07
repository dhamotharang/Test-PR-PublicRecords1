import corp2, corp2_mapping, corp2_raw_or, scrubs_corp2_mapping_or_ar, scrubs, scrubs_corp2_mapping_or_event,
			 scrubs_corp2_mapping_or_main, std, tools, ut, versioncontrol;
			 
export OR := MODULE; 

	export Update(string fileDate, string version, boolean pShouldSpray = _Dataset().bShouldSpray, boolean pOverwrite = false, boolean pUseProd = Tools._Constants.IsDataland) := function

		state_origin			 					:= 'OR';
		state_fips	 				 				:= '41';
		state_desc	 			 					:= 'OREGON';

		CountyDBExtract							:= dedup(sort(distribute(Corp2_Raw_OR.Files(filedate,puseprod).Input.CountyDBExtract.Logical,hash(entity_rsn)),record,local),record) : independent;
		EntityDBExtract							:= dedup(sort(distribute(Corp2_Raw_OR.Files(filedate,puseprod).Input.EntityDBExtract.Logical,hash(entity_rsn)),record,local),record) : independent;
		MergerShareDBExtractTranRSN	:= dedup(sort(distribute(Corp2_Raw_OR.Files(filedate,puseprod).Input.MergerShareDBExtract.Logical,hash(tran_rsn)),record,local),record) : independent;	
		NameDBExtract							 	:= dedup(sort(distribute(Corp2_Raw_OR.Files(filedate,puseprod).Input.NameDBExtract.Logical,hash(entity_rsn)),record,local),record) : independent;
		RelAssocNameDBExtract				:= dedup(sort(distribute(Corp2_Raw_OR.Files(filedate,puseprod).Input.RelAssocNameDBExtract.Logical,hash(entity_rsn)),record,local),record) : independent;
		TranDBExtract								:= dedup(sort(distribute(Corp2_Raw_OR.Files(filedate,puseprod).Input.TranDBExtract.Logical,hash(entity_rsn)),record,local),record) : independent;
		TranDBExtractTranRSN				:= dedup(sort(distribute(Corp2_Raw_OR.Files(filedate,puseprod).Input.TranDBExtract.Logical,hash(tran_rsn)),record,local),record) : independent;

		AnnualReportTypeList 	 			:= ['ANNUAL REPORT','ANNUAL REPORT PAYMENT','AMENDED ANNUAL REPORT','AMNDMT TO ANNUAL RPT/INFO STATEMENT','CORRECTION OF ANNUAL','IMAGE ANNUAL REPORT','NOTICE LATE ANNUAL'];
		BusinessTypesList						:= ['MAILING ADDRESS','PRINCIPAL PLACE OF BUSINESS','RECORDS OFFICE','RESERVED NAME','REGISTERED NAME','VALID RECORD'];
		RATypesList									:= ['AUTHORIZED REPRESENTATIVE','REGISTERED AGENT'];
		BusinessRAList							:= BusinessTypesList + RATypesList;
		ContactTypesList						:= ['APPLICANT','CORRESPONDENT','GENERAL PARTNER','INDIVIDUAL WITH DIRECT KNOWLEDGE','MANAGER','MANAGING PARTNER','MEMBER','NONFILEABLE CORRESPONDENT','PARTNER','PRESIDENT','REGISTRANT','SECRETARY','TRUSTEE'];
		AllTypesList								:= AnnualReportTypeList + BusinessTypesList + RATypesList + ContactTypesList;

		//********************************************************************
		//The input file "MergerShareDBExtract" contains some records with a
		//"blank" entity_rsn (primary "key"). In order to populate this missing
		//key, the "tran_rsn" is used to join with the "TranDBExtract" file.
		//The associated "entity_rsn" in the "TranDBExtract" file is mapped
		//to the "MergerShareDBExtract" file.
		//********************************************************************
	  MergerShareDBExtractFixed		 := join(MergerShareDBExtractTranRSN,TranDBExtractTranRSN,
																			   corp2.t2u(left.tran_rsn) = corp2.t2u(right.tran_rsn),
																				 transform(Corp2_Raw_OR.Layouts.MergerShareDBExtractLayoutIn,
																				  				 self.entity_rsn									:= if((integer)left.entity_rsn = 0,right.entity_rsn,left.entity_rsn);
																									 self 														:= left;
																								  ),
																			   left outer,
																				 local
																			   ) : independent;
																		 
		//********************************************************************
		//The input file "RelAssocNameDBExtract" has a field named
		//"business_of_record_rsn" that is sometimes populated with an 
		//"entity_rsn".  This "entity_rsn" ties the record in the 
		//"RelAssocNameDBExtract" file to a record in the NameDBExtract file
		//where the business name is retrieved.  After the business name is
		//obtained, the record is joined with the master file EntityDBExtract.
		//********************************************************************
		Need_Business_Name   	 		:= corp2.t2u(RelAssocNameDBExtract.business_of_record_rsn) <> '' 									and					//must have a value in business_of_record_rsn
																 corp2.t2u(RelAssocNameDBExtract.associated_name_type) not in BusinessTypesList and					//must be an RA or Contact
																 regexfind('[^[:digit:]]',corp2.t2u(RelAssocNameDBExtract.business_of_record_rsn)) = false;	//must be a digit (no alpha or special characters)

		Not_Need_Business_Name 		:= not(Need_Business_Name);

		RelAssocNameNotNeedName		:= RelAssocNameDBExtract(Not_Need_Business_Name);
		RelAssocNameNeedName			:= RelAssocNameDBExtract(Need_Business_Name);
		RelAssocNameNeedNameDist	:= distribute(RelAssocNameNeedName,hash(business_of_record_rsn)) : independent;

		NameDBExtractFiltered  		:= NameDBExtract(corp2.t2u(name_status) = 'CURRENT'); //Only one "CURRENT" record; Multiple "PREVIOUS" records
		NameDBExtractCurrentDist 	:= distribute(NameDBExtractFiltered,hash(entity_rsn)) : independent;

	  RelAssocNameGetBusName 		:= join(RelAssocNameNeedNameDist,NameDBExtractCurrentDist,
																			corp2.t2u(left.business_of_record_rsn) = corp2.t2u(right.entity_rsn),
																			transform(Corp2_Raw_OR.Layouts.RelAssocNameDBExtractLayoutIn,
																								self.not_of_record_business_name := right.bus_name;
																								self 														 := left;
																							 ),
																			left outer,
																			local
																		 ) : independent;

		RelAssocNameAllDist				:= distribute(RelAssocNameGetBusName + RelAssocNameNotNeedName,hash(entity_rsn)) : independent;

	  EntityNameDBExtract 			:= join(EntityDBExtract,NameDBExtract,
																			corp2.t2u(left.entity_rsn) = corp2.t2u(right.entity_rsn),
																			transform(Corp2_Raw_OR.Layouts.TempEntityNameRelAssocLayoutIn,
																								self := left;
																								self := right;
																								self := [];
																							 ),																								
																			left outer,
																			local
																		 ) : independent;
																		 
		EntityNameDBExtractDist   := distribute(EntityNameDBExtract,hash(entity_rsn)) : independent;

		//Note:  Scrubs is checking associated_name_type and in some cases no "RelAssocNameDBExtract" record exists which
		//			 contains the associated_name_type. However, record with both an entity and namedb record are still valid.
		//			 In order for Scrubs not to reject these records, the assocated_name_type is being set to "VALID RECORD".
	  EntityNameRelAssocExtract	:= join(EntityNameDBExtractDist,RelAssocNameAllDist,
																			corp2.t2u(left.entity_rsn) = corp2.t2u(right.entity_rsn),
																			transform(Corp2_Raw_OR.Layouts.TempEntityNameRelAssocLayoutIn,
																								self.associated_name_rsn				 := right.associated_name_rsn;
																								self.agent_resign_date					 := right.agent_resign_date;
																								self.associated_name_type				 := if(right.associated_name_type='','VALID RECORD',right.associated_name_type);
																								self.individual_name						 := right.individual_name;
																								self.individual_suffix					 := right.individual_suffix;
																								self.business_of_record_rsn			 := right.business_of_record_rsn;
																								self.not_of_record_business_name := right.not_of_record_business_name;
																								self.mail_address1							 := right.mail_address1;
																								self.mail_address2							 := right.mail_address2;
																								self.zip_code5									 := right.zip_code5;
																								self.zip_code4									 := right.zip_code4;
																								self.city												 := right.city;
																								self.state											 := right.state;
																								self.country										 := right.country;
																								self 														 := left;
																							 ),
																			left outer,
																			local
																		 ) : independent;

		Total_Counties_By_Entity_Dist 	:= distribute(table(CountyDBExtract,{entity_rsn,total_counties_by_entity_rsn := count(group)},entity_rsn),hash(entity_rsn)) : independent;
		
		Update_CountyDBExtract	 	      := join(CountyDBExtract,Total_Counties_By_Entity_Dist,
																			    	corp2.t2u(left.entity_rsn) = corp2.t2u(right.entity_rsn),
																				    transform(Corp2_Raw_OR.Layouts.TempCountyDBExtractLayoutIn,
																									    self.total_counties_by_entity_rsn := right.total_counties_by_entity_rsn;
																									    self 															:= left;
																									    self															:= [];
																								      ),
																				    left outer,
																				    lookup,
																				    local
																				    ) : independent;
																				
		//Note:  There are 36 counties in the state of Oregon
		Corp2_Raw_OR.Layouts.TempCountyDBExtractLayoutIn DenormCounties(Update_CountyDBExtract l, Update_CountyDBExtract r, integer c) := transform
				self.county_name1		 	:= if(c=1,  corp2.t2u(r.county_name),corp2.t2u(l.county_name1));        
				self.county_name2		 	:= if(c=2,  corp2.t2u(r.county_name),corp2.t2u(l.county_name2));
				self.county_name3		 	:= if(c=3,  corp2.t2u(r.county_name),corp2.t2u(l.county_name3));
				self.county_name4		 	:= if(c=4,  corp2.t2u(r.county_name),corp2.t2u(l.county_name4));
				self.county_name5		 	:= if(c=5,  corp2.t2u(r.county_name),corp2.t2u(l.county_name5));
				self.county_name6		 	:= if(c=6,  corp2.t2u(r.county_name),corp2.t2u(l.county_name6));
				self.county_name7		 	:= if(c=7,  corp2.t2u(r.county_name),corp2.t2u(l.county_name7));
				self.county_name8		 	:= if(c=8,  corp2.t2u(r.county_name),corp2.t2u(l.county_name8));
				self.county_name9		 	:= if(c=9,  corp2.t2u(r.county_name),corp2.t2u(l.county_name9));
				self.county_name10	 	:= if(c=10, corp2.t2u(r.county_name),corp2.t2u(l.county_name10));
				self.county_name11	 	:= if(c=11, corp2.t2u(r.county_name),corp2.t2u(l.county_name11));
				self.county_name12	 	:= if(c=12, corp2.t2u(r.county_name),corp2.t2u(l.county_name12));
				self.county_name13	 	:= if(c=13, corp2.t2u(r.county_name),corp2.t2u(l.county_name13));
				self.county_name14	 	:= if(c=14, corp2.t2u(r.county_name),corp2.t2u(l.county_name14));
				self.county_name15	 	:= if(c=15, corp2.t2u(r.county_name),corp2.t2u(l.county_name15));
				self.county_name16	 	:= if(c=16, corp2.t2u(r.county_name),corp2.t2u(l.county_name16));
				self.county_name17	 	:= if(c=17, corp2.t2u(r.county_name),corp2.t2u(l.county_name17));
				self.county_name18	 	:= if(c=18, corp2.t2u(r.county_name),corp2.t2u(l.county_name18));
				self.county_name19	 	:= if(c=19, corp2.t2u(r.county_name),corp2.t2u(l.county_name19));
				self.county_name20	 	:= if(c=20, corp2.t2u(r.county_name),corp2.t2u(l.county_name20));
				self.county_name21	 	:= if(c=21, corp2.t2u(r.county_name),corp2.t2u(l.county_name21));
				self.county_name22	 	:= if(c=22, corp2.t2u(r.county_name),corp2.t2u(l.county_name22));
				self.county_name23	 	:= if(c=23, corp2.t2u(r.county_name),corp2.t2u(l.county_name23));
				self.county_name24	 	:= if(c=24, corp2.t2u(r.county_name),corp2.t2u(l.county_name24));
				self.county_name25	 	:= if(c=25, corp2.t2u(r.county_name),corp2.t2u(l.county_name25));
				self.county_name26	 	:= if(c=26, corp2.t2u(r.county_name),corp2.t2u(l.county_name26));
				self.county_name27	 	:= if(c=27, corp2.t2u(r.county_name),corp2.t2u(l.county_name27));
				self.county_name28	 	:= if(c=28, corp2.t2u(r.county_name),corp2.t2u(l.county_name28));
				self.county_name29	 	:= if(c=29, corp2.t2u(r.county_name),corp2.t2u(l.county_name29));
				self.county_name30	 	:= if(c=30, corp2.t2u(r.county_name),corp2.t2u(l.county_name30));
				self.county_name31	 	:= if(c=31, corp2.t2u(r.county_name),corp2.t2u(l.county_name31));
				self.county_name32	 	:= if(c=32, corp2.t2u(r.county_name),corp2.t2u(l.county_name32));
				self.county_name33	 	:= if(c=33, corp2.t2u(r.county_name),corp2.t2u(l.county_name33));
				self.county_name34	 	:= if(c=34, corp2.t2u(r.county_name),corp2.t2u(l.county_name34));
				self.county_name35	 	:= if(c=35, corp2.t2u(r.county_name),corp2.t2u(l.county_name35));
				self.county_name36	 	:= if(c=36, corp2.t2u(r.county_name),corp2.t2u(l.county_name36));
				self 								 	:= l;
		end;

		CountyDBExtractSorted		 	:= sort(Update_CountyDBExtract,entity_rsn,county_name,local);
				
		DenormCountyDBExtract		 	:= denormalize(CountyDBExtractSorted, CountyDBExtractSorted,
																						 corp2.t2u(left.entity_rsn) = corp2.t2u(right.entity_rsn),
																						 DenormCounties(left,right,counter),
																						 local
																					  );
																						
		AllCountiesByEntiy			 	:= sort(dedup(distribute(DenormCountyDBExtract,hash(entity_rsn)),entity_rsn,local),entity_rsn,local) : independent;
		
		//Note:  There are 36 counties in the state of Oregon
	  EntityNameRelAssocCounty	:= join(EntityNameRelAssocExtract,AllCountiesByEntiy,
																			corp2.t2u(left.entity_rsn) = corp2.t2u(right.entity_rsn),
																			transform(Corp2_Raw_OR.Layouts.TempEntityNameRelAssocLayoutIn,
																								self.county_rsn 									:= right.county_rsn;
																								self.county_name 									:= right.county_name;
																								self.total_counties_by_entity_rsn := right.total_counties_by_entity_rsn;
																								self.county_name1		 							:= right.county_name1;        
																								self.county_name2		 							:= right.county_name2; 
																								self.county_name3		 							:= right.county_name3; 
																								self.county_name4		 							:= right.county_name4; 
																								self.county_name5		 							:= right.county_name5; 
																								self.county_name6		 							:= right.county_name6; 
																								self.county_name7		 							:= right.county_name7; 
																								self.county_name8		 							:= right.county_name8; 
																								self.county_name9		 							:= right.county_name9;
																								self.county_name10		 						:= right.county_name10; 
																								self.county_name11		 						:= right.county_name11; 
																								self.county_name12		 						:= right.county_name12; 
																								self.county_name13		 						:= right.county_name13; 
																								self.county_name14		 						:= right.county_name14; 
																								self.county_name15		 						:= right.county_name15; 
																								self.county_name16		 						:= right.county_name16; 
																								self.county_name17		 						:= right.county_name17; 
																								self.county_name18		 						:= right.county_name18; 
																								self.county_name19		 						:= right.county_name19; 
																								self.county_name20		 						:= right.county_name20; 
																								self.county_name21		 						:= right.county_name21; 
																								self.county_name22		 						:= right.county_name22; 
																								self.county_name23		 						:= right.county_name23; 
																								self.county_name24		 						:= right.county_name24; 
																								self.county_name25		 						:= right.county_name25; 
																								self.county_name26		 						:= right.county_name26; 
																								self.county_name27		 						:= right.county_name27; 
																								self.county_name28		 						:= right.county_name28; 
																								self.county_name29		 						:= right.county_name29; 
																								self.county_name30		 						:= right.county_name30; 
																								self.county_name31		 						:= right.county_name31; 
																								self.county_name32		 						:= right.county_name32; 
																								self.county_name33		 						:= right.county_name33; 
																								self.county_name34		 						:= right.county_name34; 
																								self.county_name35		 						:= right.county_name35; 
																								self.county_name36		 						:= right.county_name36; 
																								self 															:= left;
																							 ),
																			left outer,
																			local
																		 ) : independent;

	  TotalMasterFile						    := join(EntityNameRelAssocCounty,MergerShareDBExtractFixed,
																		      corp2.t2u(left.entity_rsn) = corp2.t2u(right.entity_rsn),
																		    	transform(Corp2_Raw_OR.Layouts.TempEntityNameRelAssocLayoutIn,
																										self.merger_share_rsn 					:= right.merger_share_rsn;
																										self.parent_rsn 								:= right.parent_rsn;
																										self.share_exchange 						:= right.share_exchange;
																										self.not_of_record_name 				:= right.not_of_record_name;
																										self.not_of_record_jurisdiction := right.not_of_record_jurisdiction;
																										self 														:= left;
																									 ),
																					left outer,
																					local
																				 ) : independent;
																		 
		MasterFileDedup 							:= dedup(sort(distribute(TotalMasterFile,hash(entity_rsn)),record,local),record,local) : independent;

		Corp2_Raw_OR.Layouts.TempEntityNameRelAssocLayoutIn  RollupXform(Corp2_Raw_OR.Layouts.TempEntityNameRelAssocLayoutIn l, Corp2_Raw_OR.Layouts.TempEntityNameRelAssocLayoutIn r) := transform
				self.merger_share_rsn		  				:= if(corp2.t2u(r.merger_share_rsn) <> '', corp2.t2u(r.merger_share_rsn), corp2.t2u(l.merger_share_rsn));
				self.parent_rsn										:= if(corp2.t2u(r.parent_rsn) <> '', corp2.t2u(r.parent_rsn), corp2.t2u(l.parent_rsn));
				self.not_of_record_name						:= if(corp2.t2u(r.not_of_record_name) <> '', corp2.t2u(r.not_of_record_name), corp2.t2u(l.not_of_record_name));
				self.not_of_record_jurisdiction		:= if(corp2.t2u(r.not_of_record_jurisdiction) <> '', corp2.t2u(r.not_of_record_jurisdiction), corp2.t2u(l.not_of_record_jurisdiction));				
				self 															:= l;
		end;

		//This rollup adds the not_of_record_name and not_of_record_jurisdiction to the corp records
		MasterFile 										:= rollup(MasterFileDedup,RollupXform(left,right),record,
																						except 	merger_share_rsn,
																										parent_rsn,
																										not_of_record_name, 
																										not_of_record_jurisdiction,
																										local
																					 ) : independent;
													
		//********************************************************************
		// PROCESS CORPORATE (MASTER) DATA
		//********************************************************************
		Corp2_Mapping.LayoutsCommon.Main EntityNameRelAssocCorpTransform(Corp2_Raw_OR.Layouts.TempEntityNameRelAssocLayoutIn l) := transform		
				self.dt_vendor_first_reported							:= (integer)fileDate;
				self.dt_vendor_last_reported							:= (integer)fileDate;
				self.dt_first_seen												:= (integer)fileDate;
				self.dt_last_seen													:= (integer)fileDate;
				self.corp_ra_dt_first_seen								:= (integer)fileDate;
				self.corp_ra_dt_last_seen									:= (integer)fileDate;			
				self.corp_key															:= state_fips + '-' + corp2.t2u(l.entity_rsn);
				self.corp_vendor													:= state_fips;
				self.corp_state_origin										:= state_origin;			
				self.corp_process_date										:= fileDate;
				self.corp_orig_sos_charter_nbr        		:= corp2.t2u(l.registry);
				self.corp_legal_name 											:= Corp2_mapping.fCleanBusinessName(state_origin,state_desc,l.bus_name).BusinessName;
				self.corp_ln_name_type_cd 								:= Corp2_Raw_OR.Functions.CorpLNNameTypeCD(l.name_type,l.bus_type);
				self.corp_ln_name_type_desc 							:= Corp2_Raw_OR.Functions.CorpLNNameTypeDesc(l.name_type,l.bus_type);
				self.corp_address1_type_cd 								:= if(Corp2_Mapping.fAddressExists(state_origin,state_desc,l.mail_address1,l.mail_address2,l.city,l.state,l.zip_code5 + l.zip_code4,l.country).ifAddressExists,Corp2_Raw_OR.Functions.CorpAddress1TypeCD(l.associated_name_type),'');
				self.corp_address1_type_desc 							:= if(self.corp_address1_type_cd<>'',Corp2_Raw_OR.Functions.CorpAddress1TypeDesc(l.associated_name_type),'');
				self.corp_address1_line1 									:= if(self.corp_address1_type_cd<>'',Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.mail_address1,l.mail_address2,l.city,l.state,l.zip_code5 + l.zip_code4,l.country).AddressLine1,'');
				self.corp_address1_line2 									:= if(self.corp_address1_type_cd<>'',Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.mail_address1,l.mail_address2,l.city,l.state,l.zip_code5 + l.zip_code4,l.country).AddressLine2,'');
				self.corp_address1_line3 									:= if(self.corp_address1_type_cd<>'',Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.mail_address1,l.mail_address2,l.city,l.state,l.zip_code5 + l.zip_code4,l.country).AddressLine3,'');
				self.corp_prep_addr1_line1 								:= if(self.corp_address1_type_cd<>'',Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.mail_address1,l.mail_address2,l.city,l.state,l.zip_code5 + l.zip_code4,l.country).PrepAddrLine1,'');
				self.corp_prep_addr1_last_line 						:= if(self.corp_address1_type_cd<>'',Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.mail_address1,l.mail_address2,l.city,l.state,l.zip_code5 + l.zip_code4,l.country).PrepAddrLastLine,'');
				self.corp_filing_reference_nbr 						:= corp2.t2u(l.entity_rsn);//overloaded field 
				self.corp_filing_date 										:= Corp2_Mapping.fValidateDate(l.start_date).PastDate;//overloaded field 
				self.corp_filing_desc 										:= corp2.t2u(l.name_status) + ' ' + corp2.t2u(l.name_type);//overloaded field 
				self.corp_status_desc 										:= corp2.t2u(l.bus_status);
				self.corp_inc_state												:= state_origin;
				self.corp_inc_county 											:= map(l.total_counties_by_entity_rsn = 36 => 'ALL COUNTIES', //There are a total of 36 counties in Oregon
																												 l.total_counties_by_entity_rsn = 1	 => corp2.t2u(l.county_name), //see corp_registered_counties
																												 ''
																												);//overloaded field 
				self.corp_inc_date 												:= if(corp2.t2u(l.jurisdiction) in [state_desc,''],Corp2_Mapping.fValidateDate(l.registration_date).PastDate,'');
				self.corp_term_exist_cd 									:= if(Corp2_Mapping.fValidateDate(l.duration_date).GeneralDate <> '','D','');
				self.corp_term_exist_exp 									:= Corp2_Mapping.fValidateDate(l.duration_date).GeneralDate;
				self.corp_term_exist_desc									:= if(Corp2_Mapping.fValidateDate(l.duration_date).GeneralDate <> '','EXPIRATION DATE', '');
				self.corp_foreign_domestic_ind 						:= Corp2_Raw_OR.Functions.CorpForgnDomesticInd(l.bus_type);
				self.corp_forgn_state_cd 									:= if(corp2.t2u(l.jurisdiction) not in [state_desc,''],Corp2_Raw_OR.Functions.CorpForgnStateCD(l.jurisdiction),''); 
				self.corp_forgn_state_desc 								:= if(corp2.t2u(l.jurisdiction) not in [state_desc,''],Corp2_Raw_OR.Functions.CorpForgnStateDesc(l.jurisdiction),'');
				self.corp_forgn_date 											:= if(corp2.t2u(l.jurisdiction) not in [state_desc,''],Corp2_Mapping.fValidateDate(l.registration_date).PastDate,'');
				self.corp_orig_org_structure_desc 				:= Corp2_Raw_OR.Functions.CorpOrigOrgStructureDesc(l.bus_type);
				self.corp_for_profit_ind 									:= Corp2_Raw_OR.Functions.CorpForProfitInd(l.bus_type);
				self.corp_orig_bus_type_desc 							:= corp2.t2u(l.non_profit_type);
				self.corp_addl_info												:= if(Corp2_Mapping.fValidateDate(l.end_date,'MM/DD/CCYY').GeneralDate<>'','INACTIVE: '+corp2.t2u(l.end_date),'');//Leaving in mm/dd/ccyy format
				self.corp_ra_full_name 										:= if(corp2.t2u(l.associated_name_type) in RATypesList,Corp2_Raw_OR.Functions.CorpRAFullName(state_origin,state_desc,l.individual_name,l.individual_suffix,l.not_of_record_business_name),'');
			  self.corp_ra_resign_date 									:= Corp2_Mapping.fValidateDate(l.agent_resign_date).GeneralDate;
				self.corp_ra_address_type_cd							:= if(corp2.t2u(l.associated_name_type) in RATypesList and Corp2_Mapping.fAddressExists(state_origin,state_desc,l.mail_address1,l.mail_address2,l.city,l.state,l.zip_code5 + l.zip_code4,l.country).ifAddressExists,'R','');
				self.corp_ra_address_type_desc						:= if(self.corp_ra_address_type_cd<>'','REGISTERED OFFICE','');			
				self.corp_ra_address_line1								:= if(self.corp_ra_address_type_cd<>'',Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.mail_address1,l.mail_address2,l.city,l.state,l.zip_code5 + l.zip_code4,l.country).AddressLine1,'');
				self.corp_ra_address_line2								:= if(self.corp_ra_address_type_cd<>'',Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.mail_address1,l.mail_address2,l.city,l.state,l.zip_code5 + l.zip_code4,l.country).AddressLine2,'');
				self.corp_ra_address_line3								:= if(self.corp_ra_address_type_cd<>'',Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.mail_address1,l.mail_address2,l.city,l.state,l.zip_code5 + l.zip_code4,l.country).AddressLine3,'');
				self.ra_prep_addr_line1										:= if(self.corp_ra_address_type_cd<>'',Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.mail_address1,l.mail_address2,l.city,l.state,l.zip_code5 + l.zip_code4,l.country).PrepAddrLine1,'');
				self.ra_prep_addr_last_line								:= if(self.corp_ra_address_type_cd<>'',Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.mail_address1,l.mail_address2,l.city,l.state,l.zip_code5 + l.zip_code4,l.country).PrepAddrLastLine,'');
				self.corp_merger_desc						 					:= if(corp2.t2u(l.not_of_record_name) <> '','NON-SURVIVOR','');
				self.corp_merger_name						 					:= corp2.t2u(l.not_of_record_name);
				self.corp_name_effective_date							:= Corp2_Mapping.fValidateDate(l.start_date).GeneralDate;
				self.corp_name_status_date 								:= Corp2_Mapping.fValidateDate(l.end_date).PastDate;				
				self.corp_name_status_desc								:= corp2.t2u(l.name_status);
				self.corp_registered_counties							:= if(l.total_counties_by_entity_rsn = 36, //There are a total of 36 counties in Oregon
																												'ALL COUNTIES',
																												Corp2_Raw_OR.Functions.CorpRegisteredCounties(l.county_name1, l.county_name2, l.county_name3, l.county_name4, l.county_name5, l.county_name6, l.county_name7, l.county_name7, l.county_name9, l.county_name10,
																																																			l.county_name11,l.county_name12,l.county_name13,l.county_name14,l.county_name15,l.county_name16,l.county_name17,l.county_name18,l.county_name19,l.county_name20,
																																																			l.county_name21,l.county_name22,l.county_name23,l.county_name24,l.county_name25,l.county_name26,l.county_name27,l.county_name28,l.county_name29,l.county_name30,
																																																			l.county_name31,l.county_name32,l.county_name33,l.county_name34,l.county_name35,l.county_name36)
																											 );
				self.corp_renewal_date										:= Corp2_Mapping.fValidateDate(l.renewal_due_date).GeneralDate;
				self.internalfield1												:= corp2.t2u(l.associated_name_type); //added for scrub purposes; must be populated
				self.internalfield2												:= corp2.t2u(l.name_type); 						//added for scrub purposes; must be populated
				self.internalfield3												:= corp2.t2u(l.bus_type); 						//added for scrub purposes; must be populated
				self.recordorigin													:= 'C';
				self 																			:= [];
	  end;

		MapBusinesses																	:= project(MasterFile,EntityNameRelAssocCorpTransform(left));

		HasRA																					:= MapBusinesses(corp_ra_address_type_cd  = 'R');
		HasNoRA																				:= MapBusinesses(corp_ra_address_type_cd <> 'R');
		
		//This join places the corporation record and the ra record (that exists in two different records
		//into one record.
	  MapRA2Corporation															:= join(HasNoRA,HasRA,
																													left.corp_key 				= right.corp_key and
																													left.corp_filing_date = right.corp_filing_date,
																													transform(Corp2_Mapping.LayoutsCommon.Main,
																																		self.dt_vendor_first_reported							:= if(left.dt_vendor_first_reported<>0,left.dt_vendor_first_reported,right.dt_vendor_first_reported);
																																		self.dt_vendor_last_reported							:= if(left.dt_vendor_last_reported<>0,left.dt_vendor_last_reported,right.dt_vendor_last_reported);
																																		self.dt_first_seen												:= if(left.dt_first_seen<>0,left.dt_first_seen,right.dt_first_seen);
																																		self.dt_last_seen													:= if(left.dt_last_seen<>0,left.dt_last_seen,right.dt_last_seen);
																																		self.corp_ra_dt_first_seen								:= if(left.corp_ra_dt_first_seen<>0,left.corp_ra_dt_first_seen,right.corp_ra_dt_first_seen);
																																		self.corp_ra_dt_last_seen									:= if(left.corp_ra_dt_last_seen<>0,left.corp_ra_dt_last_seen,right.corp_ra_dt_last_seen);
																																		self.corp_key															:= if(left.corp_key<>'',left.corp_key,right.corp_key);
																																		self.corp_vendor													:= if(left.corp_vendor<>'',left.corp_vendor,right.corp_vendor);
																																		self.corp_state_origin										:= if(left.corp_state_origin<>'',left.corp_state_origin,right.corp_state_origin);
																																		self.corp_process_date										:= if(left.corp_process_date<>'',left.corp_process_date,right.corp_process_date);
																																		self.corp_orig_sos_charter_nbr        		:= if(left.corp_orig_sos_charter_nbr<>'',left.corp_orig_sos_charter_nbr,right.corp_orig_sos_charter_nbr);
																																		self.corp_legal_name 											:= if(left.corp_legal_name<>'',left.corp_legal_name,right.corp_legal_name);
																																		self.corp_ln_name_type_cd 								:= if(left.corp_ln_name_type_cd<>'',left.corp_ln_name_type_cd,right.corp_ln_name_type_cd);
																																		self.corp_ln_name_type_desc 							:= if(left.corp_ln_name_type_desc<>'',left.corp_ln_name_type_desc,right.corp_ln_name_type_desc);
																																		self.corp_address1_type_cd 								:= if(left.corp_address1_type_cd<>'',left.corp_address1_type_cd,right.corp_address1_type_cd);
																																		self.corp_address1_type_desc 							:= if(left.corp_address1_type_desc<>'',left.corp_address1_type_desc,right.corp_address1_type_desc);
																																		self.corp_address1_line1 									:= if(left.corp_address1_line1<>'',left.corp_address1_line1,right.corp_address1_line1);
																																		self.corp_address1_line2 									:= if(left.corp_address1_line2<>'',left.corp_address1_line2,right.corp_address1_line2);
																																		self.corp_address1_line3 									:= if(left.corp_address1_line3<>'',left.corp_address1_line3,right.corp_address1_line3);
																																		self.corp_filing_reference_nbr 						:= if(left.corp_filing_reference_nbr<>'',left.corp_filing_reference_nbr,right.corp_filing_reference_nbr);
																																		self.corp_filing_date 										:= if(left.corp_filing_date<>'',left.corp_filing_date,right.corp_filing_date);
																																		self.corp_filing_desc 										:= if(left.corp_filing_desc<>'',left.corp_filing_desc,right.corp_filing_desc);
																																		self.corp_status_desc 										:= if(left.corp_status_desc<>'',left.corp_status_desc,right.corp_status_desc);
																																		self.corp_status_date 										:= if(left.corp_status_date<>'',left.corp_status_date,right.corp_status_date);
																																		self.corp_inc_state												:= if(left.corp_inc_state<>'',left.corp_inc_state,right.corp_inc_state);
																																		self.corp_inc_county 											:= if(left.corp_inc_county<>'',left.corp_inc_county,right.corp_inc_county);
																																		self.corp_inc_date 												:= if(left.corp_inc_date<>'',left.corp_inc_date,right.corp_inc_date);
																																		self.corp_term_exist_cd 									:= if(left.corp_term_exist_cd<>'',left. corp_term_exist_cd ,right.corp_term_exist_cd);
																																		self.corp_term_exist_exp 									:= if(left.corp_term_exist_exp<>'',left.corp_term_exist_exp,right.corp_term_exist_exp);
																																		self.corp_term_exist_desc									:= if(left.corp_term_exist_desc<>'',left. corp_term_exist_desc ,right.corp_term_exist_desc);
																																		self.corp_foreign_domestic_ind 						:= if(left.corp_foreign_domestic_ind<>'',left.corp_foreign_domestic_ind,right.corp_foreign_domestic_ind);
																																		self.corp_forgn_state_cd 									:= if(left.corp_forgn_state_cd<>'',left.corp_forgn_state_cd,right.corp_forgn_state_cd);
																																		self.corp_forgn_state_desc 								:= if(left.corp_forgn_state_desc<>'',left.corp_forgn_state_desc,right.corp_forgn_state_desc);
																																		self.corp_forgn_date 											:= if(left.corp_forgn_date<>'',left.corp_forgn_date,right.corp_forgn_date);
																																		self.corp_orig_org_structure_desc 				:= if(left.corp_orig_org_structure_desc<>'',left.corp_orig_org_structure_desc,right.corp_orig_org_structure_desc);
																																		self.corp_for_profit_ind 									:= if(left.corp_for_profit_ind<>'',left.corp_for_profit_ind,right.corp_for_profit_ind);
																																		self.corp_orig_bus_type_desc 							:= if(left.corp_orig_bus_type_desc<>'',left.corp_orig_bus_type_desc,right.corp_orig_bus_type_desc);
																																		self.corp_addl_info												:= if(left.corp_addl_info<>'',left.corp_addl_info,right.corp_addl_info);
																																		self.corp_ra_full_name 										:= if(left.corp_ra_full_name<>'',left.corp_ra_full_name,right.corp_ra_full_name);
																																		self.corp_ra_resign_date 									:= if(left.corp_ra_resign_date<>'',left.corp_ra_resign_date,right.corp_ra_resign_date);
																																		self.corp_ra_address_type_cd							:= if(left.corp_ra_address_type_cd<>'',left.corp_ra_address_type_cd,right.corp_ra_address_type_cd);
																																		self.corp_ra_address_type_desc						:= if(left.corp_ra_address_type_desc<>'',left.corp_ra_address_type_desc,right.corp_ra_address_type_desc);
																																		self.corp_ra_address_line1								:= if(left.corp_ra_address_line1<>'',left.corp_ra_address_line1,right.corp_ra_address_line1);
																																		self.corp_ra_address_line2								:= if(left.corp_ra_address_line2<>'',left.corp_ra_address_line2,right.corp_ra_address_line2);
																																		self.corp_ra_address_line3								:= if(left.corp_ra_address_line3<>'',left.corp_ra_address_line3,right.corp_ra_address_line3);
																																		self.corp_prep_addr1_line1 								:= if(left.corp_prep_addr1_line1<>'',left.corp_prep_addr1_line1,right.corp_prep_addr1_line1);
																																		self.corp_prep_addr1_last_line 						:= if(left.corp_prep_addr1_last_line<>'',left.corp_prep_addr1_last_line,right.corp_prep_addr1_last_line);
																																		self.ra_prep_addr_line1										:= if(left.ra_prep_addr_line1<>'',left.ra_prep_addr_line1,right.ra_prep_addr_line1);
																																		self.ra_prep_addr_last_line								:= if(left.ra_prep_addr_last_line<>'',left.ra_prep_addr_last_line,right.ra_prep_addr_last_line);
																																		self.corp_merger_desc						 					:= if(left.corp_merger_desc<>'',left.corp_merger_desc,right.corp_merger_desc);
																																		self.corp_merger_name						 					:= if(left.corp_merger_name<>'',left.corp_merger_name,right.corp_merger_name);
																																		self.corp_name_effective_date							:= if(left.corp_name_effective_date<>'',left.corp_name_effective_date,right.corp_name_effective_date);
																																		self.corp_name_status_desc								:= if(left.corp_name_status_desc<>'',left.corp_name_status_desc,right.corp_name_status_desc);
																																		self.corp_registered_counties							:= if(left.corp_registered_counties<>'',left.corp_registered_counties,right.corp_registered_counties);
																																		self.corp_renewal_date										:= if(left.corp_renewal_date<>'',left.corp_renewal_date,right.corp_renewal_date);
																																		self.internalfield1												:= if(left.internalfield1<>'',left.internalfield1,right.internalfield1);
																																		self.internalfield2												:= if(left.internalfield2<>'',left.internalfield2,right.internalfield2);
																																		self.internalfield3												:= if(left.internalfield3<>'',left.internalfield3,right.internalfield3);
																																		self.recordorigin													:= if(left.recordorigin<>'',left.recordorigin,right.recordorigin);
																																		self																			:= left;
																																	 ),																																	 
																													full outer,
																													local
																												 ) : independent;
																												 
		RA2Corporation																:= dedup(sort(distribute(MapRA2Corporation,hash(corp_key)),record,local),record,local) : independent;

		//Currently all addresses exist in corp_address1_* fields.  Filtering out
		//"mailing" addresses from "other" address
		MailingAddress 		:= RA2Corporation(corp_address1_type_cd 		in ['M']);
		NonMailingAddress := RA2Corporation(corp_address1_type_cd not in ['','M']);
		HasNoAddress		  := RA2Corporation(corp_address1_type_cd 		in ['']);

		//This project moves all mailing address to the corp_address2_* fields.
	  MoveMailAddress																:= project(MailingAddress,
																													   transform(Corp2_Mapping.LayoutsCommon.Main,
																																			 self.corp_address1_type_cd			:= '';
																																			 self.corp_address1_type_desc 	:= '';
																																			 self.corp_address1_line1				:= '';
																																			 self.corp_address1_line2				:= '';
																																			 self.corp_address1_line3				:= '';
																																			 self.corp_prep_addr1_line1			:= '';
																																			 self.corp_prep_addr1_last_line	:= '';																														 
																																			 self.corp_address2_type_cd			:= left.corp_address1_type_cd;
																																			 self.corp_address2_type_desc 	:= left.corp_address1_type_desc;
																																			 self.corp_address2_line1				:= left.corp_address1_line1;
																																			 self.corp_address2_line2				:= left.corp_address1_line2;
																																			 self.corp_address2_line3				:= left.corp_address1_line3;
																																			 self.corp_prep_addr2_line1			:= left.corp_prep_addr1_line1;
																																			 self.corp_prep_addr2_last_line	:= left.corp_prep_addr1_last_line;
																																			 self 													:= left;
																																			)
																														);
																														
		//This join contains the corporation records that has either 1 or greater than 2 business addresses (mailing, business, or filing)
		//that exists on separate records.  Since some of these have 6+ addresses, these are being left alone with their respective addresses
		//on separate records.
		Corp2_Mapping.LayoutsCommon.Main MailingTransform(Corp2_Mapping.LayoutsCommon.Main l, Corp2_Mapping.LayoutsCommon.Main r):= transform
				self.dt_vendor_first_reported							:= if(l.dt_vendor_first_reported<>0,l.dt_vendor_first_reported,r.dt_vendor_first_reported);
				self.dt_vendor_last_reported							:= if(l.dt_vendor_last_reported<>0,l.dt_vendor_last_reported,r.dt_vendor_last_reported);
				self.dt_first_seen												:= if(l.dt_first_seen<>0,l.dt_first_seen,r.dt_first_seen);
				self.dt_last_seen													:= if(l.dt_last_seen<>0,l.dt_last_seen,r.dt_last_seen);
				self.corp_ra_dt_first_seen								:= if(l.corp_ra_dt_first_seen<>0,l.corp_ra_dt_first_seen,r.corp_ra_dt_first_seen);
				self.corp_ra_dt_last_seen									:= if(l.corp_ra_dt_last_seen<>0,l.corp_ra_dt_last_seen,r.corp_ra_dt_last_seen);
				self.corp_key															:= if(l.corp_key<>'',l.corp_key,r.corp_key);
				self.corp_vendor													:= if(l.corp_vendor<>'',l.corp_vendor,r.corp_vendor);
				self.corp_state_origin										:= if(l.corp_state_origin<>'',l.corp_state_origin,r.corp_state_origin);
				self.corp_process_date										:= if(l.corp_process_date<>'',l.corp_process_date,r.corp_process_date);
				self.corp_orig_sos_charter_nbr        		:= if(l.corp_orig_sos_charter_nbr<>'',l.corp_orig_sos_charter_nbr,r.corp_orig_sos_charter_nbr);
				self.corp_legal_name 											:= if(l.corp_legal_name<>'',l.corp_legal_name,r.corp_legal_name);
				self.corp_ln_name_type_cd 								:= if(l.corp_ln_name_type_cd<>'',l.corp_ln_name_type_cd,r.corp_ln_name_type_cd);
				self.corp_ln_name_type_desc 							:= if(l.corp_ln_name_type_desc<>'',l.corp_ln_name_type_desc,r.corp_ln_name_type_desc);
				self.corp_address1_type_cd 								:= if(l.corp_address1_type_cd<>'',l.corp_address1_type_cd,r.corp_address1_type_cd);
				self.corp_address1_type_desc 							:= if(l.corp_address1_type_desc<>'',l.corp_address1_type_desc,r.corp_address1_type_desc);
				self.corp_address1_line1									:= if(l.corp_address1_line1<>'',l.corp_address1_line1,r.corp_address1_line1);
				self.corp_address1_line2									:= if(l.corp_address1_line2<>'',l.corp_address1_line2,r.corp_address1_line2);
				self.corp_address1_line3									:= if(l.corp_address1_line3<>'',l.corp_address1_line3,r.corp_address1_line3);
			  self.corp_prep_addr1_line1								:= if(l.corp_prep_addr1_line1<>'',l.corp_prep_addr1_line1,r.corp_prep_addr1_line1);
			  self.corp_prep_addr1_last_line						:= if(l.corp_prep_addr1_last_line<>'',l.corp_prep_addr1_last_line,r.corp_prep_addr1_last_line);
			  self.corp_address2_type_cd								:= if(l.corp_address2_type_cd<>'',l.corp_address2_type_cd,r.corp_address2_type_cd);
			  self.corp_address2_type_desc 							:= if(l.corp_address2_type_desc<>'',l.corp_address2_type_desc,r.corp_address2_type_desc);
			  self.corp_address2_line1									:= if(l.corp_address2_line1<>'',l.corp_address2_line1,r.corp_address2_line1);
			  self.corp_address2_line2									:= if(l.corp_address2_line2<>'',l.corp_address2_line2,r.corp_address2_line2);
			  self.corp_address2_line3									:= if(l.corp_address2_line3<>'',l.corp_address2_line3,r.corp_address2_line3);
			  self.corp_prep_addr2_line1								:= if(l.corp_prep_addr2_line1<>'',l.corp_prep_addr2_line1,r.corp_prep_addr2_line1);
			  self.corp_prep_addr2_last_line						:= if(l.corp_prep_addr2_last_line<>'',l.corp_prep_addr2_last_line,r.corp_prep_addr2_last_line);
				self.corp_filing_reference_nbr 						:= if(l.corp_filing_reference_nbr<>'',l.corp_filing_reference_nbr,r.corp_filing_reference_nbr);
				self.corp_filing_date 										:= if(l.corp_filing_date<>'',l.corp_filing_date,r.corp_filing_date);
				self.corp_filing_desc 										:= if(l.corp_filing_desc<>'',l.corp_filing_desc,r.corp_filing_desc);
				self.corp_status_desc 										:= if(l.corp_status_desc<>'',l.corp_status_desc,r.corp_status_desc);
				self.corp_status_date 										:= if(l.corp_status_date<>'',l.corp_status_date,r.corp_status_date);
				self.corp_inc_state												:= if(l.corp_inc_state<>'',l.corp_inc_state,r.corp_inc_state);
				self.corp_inc_county 											:= if(l.corp_inc_county<>'',l.corp_inc_county,r.corp_inc_county);
				self.corp_inc_date 												:= if(l.corp_inc_date<>'',l.corp_inc_date,r.corp_inc_date);
				self.corp_term_exist_cd 									:= if(l.corp_term_exist_cd<>'',l. corp_term_exist_cd ,r.corp_term_exist_cd);
				self.corp_term_exist_exp 									:= if(l.corp_term_exist_exp<>'',l.corp_term_exist_exp,r.corp_term_exist_exp);
				self.corp_term_exist_desc									:= if(l.corp_term_exist_desc<>'',l. corp_term_exist_desc ,r.corp_term_exist_desc);
				self.corp_foreign_domestic_ind 						:= if(l.corp_foreign_domestic_ind<>'',l.corp_foreign_domestic_ind,r.corp_foreign_domestic_ind);
				self.corp_forgn_state_cd 									:= if(l.corp_forgn_state_cd<>'',l.corp_forgn_state_cd,r.corp_forgn_state_cd);
				self.corp_forgn_state_desc 								:= if(l.corp_forgn_state_desc<>'',l.corp_forgn_state_desc,r.corp_forgn_state_desc);
				self.corp_forgn_date 											:= if(l.corp_forgn_date<>'',l.corp_forgn_date,r.corp_forgn_date);
				self.corp_orig_org_structure_desc 				:= if(l.corp_orig_org_structure_desc<>'',l.corp_orig_org_structure_desc,r.corp_orig_org_structure_desc);
				self.corp_for_profit_ind 									:= if(l.corp_for_profit_ind<>'',l.corp_for_profit_ind,r.corp_for_profit_ind);
				self.corp_orig_bus_type_desc 							:= if(l.corp_orig_bus_type_desc<>'',l.corp_orig_bus_type_desc,r.corp_orig_bus_type_desc);
				self.corp_addl_info												:= if(l.corp_addl_info<>'',l.corp_addl_info,r.corp_addl_info);
				self.corp_ra_full_name 										:= if(l.corp_ra_full_name<>'',l.corp_ra_full_name,r.corp_ra_full_name);
				self.corp_ra_resign_date 									:= if(l.corp_ra_resign_date<>'',l.corp_ra_resign_date,r.corp_ra_resign_date);
				self.corp_ra_address_type_cd							:= if(l.corp_ra_address_type_cd<>'',l.corp_ra_address_type_cd,r.corp_ra_address_type_cd);
				self.corp_ra_address_type_desc						:= if(l.corp_ra_address_type_desc<>'',l.corp_ra_address_type_desc,r.corp_ra_address_type_desc);
				self.corp_ra_address_line1								:= if(l.corp_ra_address_line1<>'',l.corp_ra_address_line1,r.corp_ra_address_line1);
				self.corp_ra_address_line2								:= if(l.corp_ra_address_line2<>'',l.corp_ra_address_line2,r.corp_ra_address_line2);
				self.corp_ra_address_line3								:= if(l.corp_ra_address_line3<>'',l.corp_ra_address_line3,r.corp_ra_address_line3);
				self.ra_prep_addr_line1										:= if(l.ra_prep_addr_line1<>'',l.ra_prep_addr_line1,r.ra_prep_addr_line1);
				self.ra_prep_addr_last_line								:= if(l.ra_prep_addr_last_line<>'',l.ra_prep_addr_last_line,r.ra_prep_addr_last_line);
				self.corp_merger_desc						 					:= if(l.corp_merger_desc<>'',l.corp_merger_desc,r.corp_merger_desc);
				self.corp_merger_name						 					:= if(l.corp_merger_name<>'',l.corp_merger_name,r.corp_merger_name);
				self.corp_name_effective_date							:= if(l.corp_name_effective_date<>'',l.corp_name_effective_date,r.corp_name_effective_date);
				self.corp_name_status_desc								:= if(l.corp_name_status_desc<>'',l.corp_name_status_desc,r.corp_name_status_desc);
				self.corp_registered_counties							:= if(l.corp_registered_counties<>'',l.corp_registered_counties,r.corp_registered_counties);
				self.corp_renewal_date										:= if(l.corp_renewal_date<>'',l.corp_renewal_date,r.corp_renewal_date);
				self.internalfield1												:= if(l.internalfield1<>'',l.internalfield1,r.internalfield1);
				self.internalfield2												:= if(l.internalfield2<>'',l.internalfield2,r.internalfield2);
				self.internalfield3												:= if(l.internalfield3<>'',l.internalfield3,r.internalfield3);				
				self.recordorigin													:= if(l.recordorigin<>'',l.recordorigin,r.recordorigin);
			  self 																			:= l;
		end;
		
		//This join places the non-mailing addresses that is on separate records from the mailing addresses into one record.
		JoinedAddresses																:= join(MoveMailAddress, NonMailingAddress,
																													left.corp_key 				= right.corp_key and
																													left.corp_filing_date = right.corp_filing_date,
																													MailingTransform(left,right),
																													full outer,
																													local
																												 );

		//Find those addresses that only have a mailing address which exist in the corp_address2_* fields.
		NoAddr1HasAddr2			:= JoinedAddresses.corp_address1_line1 + JoinedAddresses.corp_address1_line2 + JoinedAddresses.corp_address1_line3 ='' and
													 JoinedAddresses.corp_address2_line1 + JoinedAddresses.corp_address2_line2 + JoinedAddresses.corp_address2_line3<>'';
		
		//Find those addresses that only have a mailing address which exist in the corp_address2_* fields
		//because they need to be remapped to the corp_address1_* fields. 
		ReMapMailingAddr		:= JoinedAddresses(NoAddr1HasAddr2);
		DontReMapMailingAddr:= JoinedAddresses(not(NoAddr1HasAddr2));	  

		//This project takes those records that do not have an address in the corp_address1_* fields but have
		//a mailing address in the corp_address2_* fields and maps the mailing address to the corp_address1_* fields.  
		ReMappedMailingAddr :=													 project(ReMapMailingAddr,
																													   transform(Corp2_Mapping.LayoutsCommon.Main,
																																			 self.corp_address1_type_cd			:= left.corp_address2_type_cd;
																																			 self.corp_address1_type_desc 	:= left.corp_address2_type_desc;
																																			 self.corp_address1_line1				:= left.corp_address2_line1;
																																			 self.corp_address1_line2				:= left.corp_address2_line2;
																																			 self.corp_address1_line3				:= left.corp_address2_line3;
																																			 self.corp_prep_addr1_line1			:= left.corp_prep_addr2_line1;
																																			 self.corp_prep_addr1_last_line	:= left.corp_prep_addr2_last_line;																											 
																																			 self.corp_address2_type_cd			:= '';
																																			 self.corp_address2_type_desc 	:= '';
																																			 self.corp_address2_line1				:= '';
																																			 self.corp_address2_line2				:= '';
																																			 self.corp_address2_line3				:= '';
																																			 self.corp_prep_addr2_line1			:= '';
																																			 self.corp_prep_addr2_last_line	:= '';
																																			 self 													:= left;
																																			)
																														);

		AllCorporationData := sort(distribute(ReMappedMailingAddr + DontReMapMailingAddr + HasNoAddress,hash(corp_key)),record,local) : independent;
	
		//This rollup collapses the corporation records and combines the corporation addresses.
		Corp2_Mapping.LayoutsCommon.Main RollupAddresses(Corp2_Mapping.LayoutsCommon.Main l, Corp2_Mapping.LayoutsCommon.Main r) := transform
				self.corp_address1_type_cd 								:= if(l.corp_address1_type_cd<>'',l.corp_address1_type_cd,r.corp_address1_type_cd);
				self.corp_address1_type_desc 							:= if(l.corp_address1_type_desc<>'',l.corp_address1_type_desc,r.corp_address1_type_desc);
				self.corp_address1_line1 									:= if(l.corp_address1_line1<>'',l.corp_address1_line1,r.corp_address1_line1);
				self.corp_address1_line2 									:= if(l.corp_address1_line2<>'',l.corp_address1_line2,r.corp_address1_line2);
				self.corp_address1_line3 									:= if(l.corp_address1_line3<>'',l.corp_address1_line3,r.corp_address1_line3);
				self.corp_prep_addr1_line1 								:= if(l.corp_prep_addr1_line1<>'',l.corp_prep_addr1_line1,r.corp_prep_addr1_line1);
				self.corp_prep_addr1_last_line 						:= if(l.corp_prep_addr1_last_line<>'',l.corp_prep_addr1_last_line,r.corp_prep_addr1_last_line);
				self.corp_address2_type_cd 								:= if(l.corp_address2_type_cd<>'',l.corp_address2_type_cd,r.corp_address2_type_cd);
				self.corp_address2_type_desc 							:= if(l.corp_address2_type_desc<>'',l.corp_address2_type_desc,r.corp_address2_type_desc);
				self.corp_address2_line1 									:= if(l.corp_address2_line1<>'',l.corp_address2_line1,r.corp_address2_line1);
				self.corp_address2_line2 									:= if(l.corp_address2_line2<>'',l.corp_address2_line2,r.corp_address2_line2);
				self.corp_address2_line3 									:= if(l.corp_address2_line3<>'',l.corp_address2_line3,r.corp_address2_line3);
				self.corp_prep_addr2_line1 								:= if(l.corp_prep_addr2_line1<>'',l.corp_prep_addr2_line1,r.corp_prep_addr2_line1);
				self.corp_prep_addr2_last_line 						:= if(l.corp_prep_addr2_last_line<>'',l.corp_prep_addr2_last_line,r.corp_prep_addr2_last_line);
				self.internalfield1 											:= if(l.internalfield1<>'',l.internalfield1,r.internalfield1);
				self.internalfield2 											:= if(l.internalfield2<>'',l.internalfield2,r.internalfield2);
				self.internalfield3 											:= if(l.internalfield3<>'',l.internalfield3,r.internalfield3);				
				self 																			:= l;
		end;
		
		MapEntityNameRelAssocCorp										  := rollup(AllCorporationData,RollUpAddresses(left, right),
																														except corp_address1_type_cd,
																																	 corp_address1_type_desc,
																																	 corp_address1_line1,
																																	 corp_address1_line2,
																																	 corp_address1_line3,
																																	 corp_prep_addr1_line1,
																																	 corp_prep_addr1_last_line,
																																	 corp_address2_type_cd,
																																	 corp_address2_type_desc,
																																	 corp_address2_line1,
																																	 corp_address2_line2,
																																	 corp_address2_line3,
																																	 corp_prep_addr2_line1,
																																	 corp_prep_addr2_last_line,																																	 
																																	 internalfield1,
																																	 internalfield2,
																																	 internalfield3,																																	 
																																	 local
																														);
		
		//********************************************************************
		// PROCESS CONTACT (MASTER) DATA
		//********************************************************************
		Corp2_Mapping.LayoutsCommon.Main EntityNameRelAssocContactsTransform(Corp2_Raw_OR.Layouts.TempEntityNameRelAssocLayoutIn l) := transform		
				self.dt_vendor_first_reported							:= (integer)fileDate;
				self.dt_vendor_last_reported							:= (integer)fileDate;
				self.dt_first_seen												:= (integer)fileDate;
				self.dt_last_seen													:= (integer)fileDate;
				self.corp_ra_dt_first_seen								:= (integer)fileDate;
				self.corp_ra_dt_last_seen									:= (integer)fileDate;			
				self.corp_key															:= state_fips + '-' + corp2.t2u(l.entity_rsn);
				self.corp_vendor													:= state_fips;
				self.corp_state_origin										:= state_origin;			
				self.corp_process_date										:= fileDate;
				self.corp_orig_sos_charter_nbr        		:= corp2.t2u(l.registry);
				self.corp_legal_name 											:= Corp2_mapping.fCleanBusinessName(state_origin,state_desc,l.bus_name).BusinessName;				
				self.corp_inc_state												:= state_origin;
				self.cont_full_name 											:= Corp2_Raw_OR.Functions.CorpRAFullName(state_origin,state_desc,l.individual_name,l.individual_suffix,l.not_of_record_business_name);
				self.cont_title1_desc											:= Corp2_Raw_OR.Functions.ContTitle1Desc(l.associated_name_type);
				self.cont_address_type_cd									:= if(Corp2_Mapping.fAddressExists(state_origin,state_desc,l.mail_address1,l.mail_address2,l.city,l.state,l.zip_code5 + l.zip_code4,l.country).ifAddressExists,'T','');
				self.cont_address_type_desc								:= if(Corp2_Mapping.fAddressExists(state_origin,state_desc,l.mail_address1,l.mail_address2,l.city,l.state,l.zip_code5 + l.zip_code4,l.country).ifAddressExists,'CONTACT','');
				self.cont_address_line1										:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.mail_address1,l.mail_address2,l.city,l.state,l.zip_code5 + l.zip_code4,l.country).AddressLine1;
				self.cont_address_line2										:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.mail_address1,l.mail_address2,l.city,l.state,l.zip_code5 + l.zip_code4,l.country).AddressLine2;
				self.cont_address_line3										:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.mail_address1,l.mail_address2,l.city,l.state,l.zip_code5 + l.zip_code4,l.country).AddressLine3;				
				self.cont_prep_addr_line1 								:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.mail_address1,l.mail_address2,l.city,l.state,l.zip_code5 + l.zip_code4,l.country).PrepAddrLine1;
				self.cont_prep_addr_last_line 						:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.mail_address1,l.mail_address2,l.city,l.state,l.zip_code5 + l.zip_code4,l.country).PrepAddrLastLine;
				self.internalfield1												:= corp2.t2u(l.associated_name_type); //added for scrub purposes; must be populated
				self.internalfield2												:= corp2.t2u(l.name_type); 						//added for scrub purposes; must be populated
				self.internalfield3												:= corp2.t2u(l.bus_type); 						//added for scrub purposes; must be populated
				self.recordorigin													:= 'T';
				self 																			:= [];
		end;

		MapContacts																		:= MasterFile(associated_name_type not in BusinessRAList);
		MapEntityNameRelAssocCont											:= project(MapContacts,EntityNameRelAssocContactsTransform(left));

		MapMainAll																		:= MapEntityNameRelAssocCorp + MapEntityNameRelAssocCont;
		MapMain																				:= dedup(sort(distribute(MapMainAll,hash(corp_key)),record,local),record,local) : independent;

		//********************************************************************
		// PROCESS CORPORATE ANNUAL REPORT DATA
		//********************************************************************
	  EntityTranDBExtract 													:= join(EntityDBExtract,TranDBExtract,
																													corp2.t2u(left.entity_rsn) = corp2.t2u(right.entity_rsn),
																													transform(Corp2_Raw_OR.Layouts.TempEntityTranDBExtractLayoutIn,
																																		self := left;
																																		self := right;
																																	 ),																								
																													inner,
																													local
																												 ) : independent;

		Corp2_mapping.LayoutsCommon.AR TranDBExtractARTransform(Corp2_Raw_OR.Layouts.TempEntityTranDBExtractLayoutIn l) := transform
				self.corp_key															:= state_fips + '-' + corp2.t2u(l.entity_rsn);
				self.corp_vendor													:= state_fips;
				self.corp_state_origin										:= state_origin;			
				self.corp_process_date										:= fileDate;
				self.corp_sos_charter_nbr			        		:= corp2.t2u(l.registry);
				self.ar_filed_dt 													:= Corp2_Mapping.fValidateDate(l.tran_date).PastDate;
				self.ar_type															:= corp2.t2u(l.tran_type);
				self 																			:= [];
	  end;
		 
		TranDBExtractARData 													:= EntityTranDBExtract(tran_type in AnnualReportTypeList);
		MapTranDBExtractAR														:= project(TranDBExtractARData,TranDBExtractARTransform(left));
		MapAR																					:= dedup(sort(distribute(MapTranDBExtractAR,hash(corp_key)),record,local),record,local) : independent;
																 
		//********************************************************************
		// PROCESS CORPORATE EVENT DATA
		//********************************************************************
		Corp2_mapping.LayoutsCommon.Events TranDBExtractEventTransform(Corp2_Raw_OR.Layouts.TempEntityTranDBExtractLayoutIn l,integer c) := transform,
		skip(c = 1 and Corp2_Mapping.fValidateDate(l.tran_date).PastDate = '' or
				 c = 2 and Corp2_Mapping.fValidateDate(l.eff_date).PastDate = ''
				)
				self.corp_key															:= state_fips + '-' + corp2.t2u(l.entity_rsn);
				self.corp_vendor													:= state_fips;
				self.corp_state_origin										:= state_origin;			
				self.corp_process_date										:= fileDate;
				self.corp_sos_charter_nbr   			     		:= corp2.t2u(l.registry);
				self.event_filing_date										:= choose(c,Corp2_Mapping.fValidateDate(l.tran_date).PastDate,
																															Corp2_Mapping.fValidateDate(l.eff_date).PastDate
																													 );				
				self.event_date_type_cd										:= choose(c,'FIL',
																															'EFF'
																													 );
				self.event_date_type_desc									:= choose(c,'FILING',
																															'EFFECTIVE'
																													 );
				self.event_filing_desc										:= corp2.t2u(l.tran_type);
				self.event_desc														:= if(corp2.t2u(l.terminated_by)<>'','VOLUNTARY DISSOLUTION BY: ' + corp2.t2u(l.terminated_by),'');
				self																			:= [];
		end;
		
		TranDBExtractEventData 												:= EntityTranDBExtract(corp2.t2u(tran_type) not in AnnualReportTypeList);
		MapTranDBExtractEvents 												:= normalize(TranDBExtractEventData, 2, TranDBExtractEventTransform(left,counter));
		MapEvents																			:= dedup(sort(distribute(MapTranDBExtractEvents,hash(corp_key)),record,local),record,local) : independent;

		//********************************************************************
		// SCRUB AR 
		//********************************************************************	
		AR_F := MapAR;
		AR_S := Scrubs_Corp2_Mapping_OR_AR.Scrubs;				// Scrubs module
		AR_N := AR_S.FromNone(AR_F); 											// Generate the error flags
		AR_T := AR_S.FromBits(AR_N.BitmapInfile);     		// Use the FromBits module; makes my bitmap datafile easier to get to
		AR_U := AR_S.FromExpanded(AR_N.ExpandedInFile); 	// Pass the expanded error flags into the Expanded module

		//Outputs reports
		AR_ErrorSummary			 	 := output(AR_U.SummaryStats, named('AR_ErrorSummary_OR'+filedate));
		AR_ScrubErrorReport 	 := output(choosen(AR_U.AllErrors, 1000), named('AR_ScrubErrorReport_OR'+filedate));
		AR_SomeErrorValues		 := output(choosen(AR_U.BadValues, 1000), named('AR_SomeErrorValues_OR'+filedate));
		AR_IsScrubErrors		 	 := IF(count(AR_U.AllErrors)<> 0,true,false);

		// Orbit Stats
		AR_OrbitStats				 	 := AR_U.OrbitStats();

		//Outputs files
		AR_CreateBitMaps			 := output(AR_N.BitmapInfile,,'~thor_data::corp_OR_ar_scrubs_bits',overwrite,compressed);	//long term storage
		AR_TranslateBitMap		 := output(AR_T);
		
		//Submits Profile's stats to Orbit
		AR_SubmitStats 			   := Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_OR_AR','ScrubsAlerts', AR_OrbitStats, version,'Corp_OR_AR').SubmitStats;
		AR_ScrubsWithExamples  := Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_OR_AR','ScrubsAlerts', AR_OrbitStats, version,'Corp_OR_AR').CompareToProfile_with_Examples;

		AR_ScrubsAlert				 := AR_ScrubsWithExamples(RejectWarning = 'Y');
		AR_ScrubsAttachment	   := Scrubs.fn_email_attachment(AR_ScrubsAlert);
		AR_MailFile					   := FileServices.SendEmailAttachData(corp2.Email_Notification_Lists.spray
																															,'Scrubs CorpAR_OR Report' //subject
																															,'Scrubs CorpAR_OR Report' //body
																															,(data)AR_ScrubsAttachment
																															,'text/csv'
																															,'Corp'+state_origin+'ARScrubsReport.csv'																															
																															,
																															,
																															,corp2.Email_Notification_Lists.spray);

		AR_BadRecords				 := AR_N.ExpandedInFile(	
																								corp_key_Invalid							  			<> 0 or
																								corp_vendor_Invalid							  		<> 0 or
																								corp_state_origin_Invalid							<> 0 or
																								corp_process_date_Invalid							<> 0 or
																								corp_sos_charter_nbr_Invalid					<> 0 or
																								ar_filed_dt_Invalid							  		<> 0 or
																								ar_type_Invalid												<> 0
																							 );

		AR_GoodRecords			 := AR_N.ExpandedInFile(
																								corp_key_Invalid							  			= 0 and
																								corp_vendor_Invalid							  		= 0 and
																								corp_state_origin_Invalid							= 0 and
																								corp_process_date_Invalid							= 0 and
																								corp_sos_charter_nbr_Invalid					= 0 and
																								ar_filed_dt_Invalid					  				= 0 and
																								ar_type_Invalid 											= 0	
																								);

		AR_FailBuild					 := if(count(AR_GoodRecords) = 0,true,false);

		AR_ApprovedRecords		 := project(AR_GoodRecords,transform(Corp2_Mapping.LayoutsCommon.AR,self := left;));


		AR_ALL								 := sequential(IF(count(AR_BadRecords) <> 0
																								 ,IF (poverwrite
																										 ,OUTPUT(AR_BadRecords,,Corp2_Mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::ar_'+state_origin,overwrite,__compressed__)
																										 ,OUTPUT(AR_BadRecords,,Corp2_Mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::ar_'+state_origin,__compressed__)
																										 )
																								 )
																						  ,output(AR_ScrubsWithExamples, all, named('CorpAR'+state_origin+'ScrubsReportWithExamples'+filedate))
																							//Send Alerts if Scrubs exceeds thresholds
																							,IF(COUNT(AR_ScrubsAlert) > 0, AR_MailFile, OUTPUT('CORP2_MAPPING.OR - No "AR" Corp Scrubs Alerts'))
																							,AR_ErrorSummary
																							,AR_ScrubErrorReport
																							,AR_SomeErrorValues	
																						  ,AR_SubmitStats
																					);

		//********************************************************************
		// SCRUB EVENT
		//********************************************************************	
		Event_F := MapEvents;
		Event_S := Scrubs_Corp2_Mapping_OR_Event.Scrubs;						// Scrubs module
		Event_N := Event_S.FromNone(Event_F); 											// Generate the error flags
		Event_T := Event_S.FromBits(Event_N.BitmapInfile);     			// Use the FromBits module; makes my bitmap datafile easier to get to
		Event_U := Event_S.FromExpanded(Event_N.ExpandedInFile); 		// Pass the expanded error flags into the Expanded module
		
		//Outputs reports
		Event_ErrorSummary				:= output(Event_U.SummaryStats, named('Event_ErrorSummary_OR'+filedate));
		Event_ScrubErrorReport 		:= output(choosen(Event_U.AllErrors, 1000), named('Event_ScrubErrorReport_OR'+filedate));
		Event_SomeErrorValues			:= output(choosen(Event_U.BadValues, 1000), named('Event_SomeErrorValues_OR'+filedate));
		Event_IsScrubErrors		 		:= IF(count(Event_U.AllErrors)<> 0,true,false);

		// Orbit Stats
		Event_OrbitStats					:= Event_U.OrbitStats();
		
		//Outputs files
		Event_CreateBitMaps				:= output(Event_N.BitmapInfile,,'~thor_data::corp_OR_event_scrubs_bits',overwrite,compressed);	//long term storage
		Event_TranslateBitMap			:= output(Event_T);

		//Submits Profile's stats to Orbit
		Event_SubmitStats 			 := Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_OR_Event','ScrubsAlerts', Event_OrbitStats, version,'Corp_OR_Event').SubmitStats;
		Event_ScrubsWithExamples := Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_OR_Event','ScrubsAlerts', Event_OrbitStats, version,'Corp_OR_Event').CompareToProfile_with_Examples;

		Event_ScrubsAlert					:= Event_ScrubsWithExamples(RejectWarning = 'Y');
		Event_ScrubsAttachment		:= Scrubs.fn_email_attachment(Event_ScrubsAlert);

		Event_MailFile						:= FileServices.SendEmailAttachData(corp2.Email_Notification_Lists.spray
																																 ,'Scrubs CorpEvent_OR Report' //subject
																																 ,'Scrubs CorpEvent_OR Report' //body
																																 ,(data)Event_ScrubsAttachment
																																 ,'text/csv'
																																 ,'Corp'+state_origin+'EventScrubsReport.csv'
																																 ,
																																 ,
																																 ,corp2.Email_Notification_Lists.spray);

		Event_BadRecords				 	:= Event_N.ExpandedInFile(	
																												corp_key_Invalid							  			<> 0 or
																												corp_vendor_Invalid							  		<> 0 or
																												corp_state_origin_Invalid							<> 0 or
																												corp_process_date_Invalid							<> 0 or
																												corp_sos_charter_nbr_Invalid					<> 0 or
																												event_filing_date_Invalid							<> 0 or
																												event_date_type_cd_Invalid						<> 0 or
																												event_date_type_desc_Invalid					<> 0 or
																												event_filing_desc_Invalid							<> 0
																											 );
		
		Event_GoodRecords					:= Event_N.ExpandedInFile(	
																												corp_key_Invalid							  			= 0 and
																												corp_vendor_Invalid							  		= 0 and
																												corp_state_origin_Invalid							= 0 and
																												corp_process_date_Invalid							= 0 and
																												corp_sos_charter_nbr_Invalid					= 0 and
																												event_filing_date_Invalid							= 0 and
																												event_date_type_cd_Invalid						= 0 and
																												event_date_type_desc_Invalid					= 0 and
																												event_filing_desc_Invalid							= 0																												
																											);

		Event_FailBuild					  := if(count(Event_GoodRecords) = 0,true,false);

		Event_ApprovedRecords			:= project(Event_GoodRecords,transform(Corp2_Mapping.LayoutsCommon.Events,self := left));
	
		Event_ALL									:= sequential(IF(count(Event_BadRecords) <> 0
																											,IF (poverwrite
																													,OUTPUT(Event_BadRecords,,Corp2_Mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::event_'+state_origin,overwrite,__compressed__)
																													,OUTPUT(Event_BadRecords,,Corp2_Mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::event_'+state_origin,__compressed__)
																													)
																											)
																									 ,output(Event_ScrubsWithExamples, all, named('CorpEvent'+state_origin+'ScrubsReportWithExamples'+filedate))
																									 //Send Alerts if Scrubs exceeds thresholds
																									 ,IF(COUNT(Event_ScrubsAlert) > 0, Event_MailFile, OUTPUT('CORP2_MAPPING.OR - No "EVENT" Corp Scrubs Alerts'))
																									 ,Event_ErrorSummary
																									 ,Event_ScrubErrorReport
																									 ,Event_SomeErrorValues	
																									 ,Event_SubmitStats
																								);

	//********************************************************************
  // SCRUB MAIN
  //********************************************************************	
		Main_F := MapMain;
		Main_S := Scrubs_Corp2_Mapping_OR_Main.Scrubs;					// Scrubs module
		Main_N := Main_S.FromNone(Main_F); 											// Generate the error flags
		Main_T := Main_S.FromBits(Main_N.BitmapInfile);     		// Use the FromBits module; makes my bitmap datafile easier to get to
		Main_U := Main_S.FromExpanded(Main_N.ExpandedInFile); 	// Pass the expanded error flags into the Expanded module
		
		//Outputs reports
		Main_ErrorSummary					:= output(Main_U.SummaryStats, named('Main_ErrorSummary_OR'+filedate));
		Main_ScrubErrorReport 		:= output(choosen(Main_U.AllErrors, 1000), named('Main_ScrubErrorReport_OR'+filedate));
		Main_SomeErrorValues			:= output(choosen(Main_U.BadValues, 1000), named('Main_SomeErrorValues_OR'+filedate));
		Main_IsScrubErrors		 		:= IF(count(Main_U.AllErrors)<> 0,true,false);

		// Orbit Stats
		Main_OrbitStats						:= Main_U.OrbitStats();
		
		//Outputs files
		Main_CreateBitMaps				:= output(Main_N.BitmapInfile,,'~thor_data::corp_OR_main_scrubs_bits',overwrite,compressed);	//long term storage
		Main_TranslateBitMap			:= output(Main_T);

		//Submits Profile's stats to Orbit
		Main_SubmitStats 			  := Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_OR_Main','ScrubsAlerts', Main_OrbitStats, version,'Corp_OR_Main').SubmitStats;
		Main_ScrubsWithExamples := Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_OR_Main','ScrubsAlerts', Main_OrbitStats, version,'Corp_OR_Main').CompareToProfile_with_Examples;

		Main_ScrubsAlert					:= Main_ScrubsWithExamples(RejectWarning = 'Y');
		Main_ScrubsAttachment			:= Scrubs.fn_email_attachment(Main_ScrubsAlert);
		Main_MailFile							:= FileServices.SendEmailAttachData(corp2.Email_Notification_Lists.spray
																																 ,'Scrubs CorpMain_OR Report' //subject
																																 ,'Scrubs CorpMain_OR Report' //body
																																 ,(data)Main_ScrubsAttachment
																																 ,'text/csv'
																																 ,'Corp'+state_origin+'MainScrubsReport.csv'
																																 ,
																																 ,
																																 ,corp2.Email_Notification_Lists.spray);

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
																											 corp_filing_reference_nbr_Invalid 			<> 0 or
																											 corp_filing_date_Invalid 							<> 0 or
																											 corp_status_date_Invalid								<> 0 or
																											 corp_inc_state_Invalid 								<> 0 or
																											 corp_inc_date_Invalid 									<> 0 or
																											 corp_term_exist_cd_Invalid							<> 0 or
																											 corp_term_exist_exp_Invalid						<> 0 or
																											 corp_term_exist_desc_Invalid						<> 0 or
																											 corp_foreign_domestic_ind_Invalid			<> 0 or
																											 corp_forgn_state_cd_Invalid						<> 0 or
																											 corp_forgn_state_desc_Invalid					<> 0 or
																											 corp_forgn_date_Invalid 								<> 0 or
																											 corp_orig_org_structure_desc_Invalid 	<> 0 or
																											 corp_for_profit_ind_Invalid						<> 0 or
																											 cont_title1_desc_Invalid 							<> 0 or
																											 recordorigin_Invalid					 					<> 0 or
																											 internalfield1_Invalid 								<> 0 or
																											 internalfield2_Invalid 								<> 0 or
																											 internalfield3_Invalid 								<> 0																											 
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
																											 corp_filing_reference_nbr_Invalid 			= 0 and
																											 corp_filing_date_Invalid 							= 0 and
																											 corp_status_date_Invalid								= 0 and
																											 corp_inc_state_Invalid 								= 0 and
																											 corp_inc_date_Invalid 									= 0 and
																											 corp_term_exist_cd_Invalid							= 0 and
																											 corp_term_exist_exp_Invalid						= 0 and
																											 corp_term_exist_desc_Invalid						= 0 and
																											 corp_foreign_domestic_ind_Invalid			= 0 and
																											 corp_forgn_state_cd_Invalid						= 0 and
																											 corp_forgn_state_desc_Invalid					= 0 and
																											 corp_forgn_date_Invalid 								= 0 and
																											 corp_orig_org_structure_desc_Invalid		= 0 and
																											 corp_for_profit_ind_Invalid						= 0 and
																											 cont_title1_desc_Invalid								= 0 and
																											 recordorigin_Invalid					 					= 0 and
																											 internalfield1_Invalid 								= 0 and
																											 internalfield2_Invalid 								= 0 and
																											 internalfield3_Invalid 								= 0																											 
																								  );

		Main_FailBuild					:= map( corp2_mapping.fCalcPercent(count(Main_N.ExpandedInFile(corp_key_invalid<>0)),count(Main_N.ExpandedInFile),false) 										> Scrubs_Corp2_Mapping_OR_Main.Threshold_Percent.CORP_KEY										 => true,
																		corp2_mapping.fCalcPercent(count(Main_N.ExpandedInFile(corp_orig_sos_charter_nbr_invalid<>0)),count(Main_N.ExpandedInFile),false) 	> Scrubs_Corp2_Mapping_OR_Main.Threshold_Percent.CORP_ORIG_SOS_CHARTER_NBR 	 => true,
																		corp2_mapping.fCalcPercent(count(Main_N.ExpandedInFile(corp_legal_name_invalid<>0)),count(Main_N.ExpandedInFile),false) 						> Scrubs_Corp2_Mapping_OR_Main.Threshold_Percent.CORP_LEGAL_NAME 						 => true,
																		corp2_mapping.fCalcPercent(count(Main_N.ExpandedInFile(corp_inc_date_invalid<>0)),count(Main_N.ExpandedInFile),false) 							> Scrubs_Corp2_Mapping_OR_Main.Threshold_Percent.CORP_INC_DATE 						 	 => true,
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
																					,output(Main_ScrubsWithExamples, all, named('CorpMain'+state_origin+'ScrubsReportWithExamples'+filedate))
																					//Send Alerts if Scrubs exceeds thresholds
																					,IF(COUNT(Main_ScrubsAlert) > 0, Main_MailFile, OUTPUT('CORP2_MAPPING.OR - No "MAIN" Corp Scrubs Alerts'))
																					,Main_ErrorSummary
																					,Main_ScrubErrorReport
																					,Main_SomeErrorValues	
																					,Main_SubmitStats
																			);

		//********************************************************************
		// UPDATE
		//********************************************************************

		Fail_Build						:= IF(AR_FailBuild or Event_FailBuild or Main_FailBuild,true,false);
		IsScrubErrors					:= IF(AR_IsScrubErrors or Event_IsScrubErrors or Main_IsScrubErrors,true,false);
		
		VersionControl.macBuildNewLogicalFile(Corp2_Mapping._dataset().thor_cluster_Files + 'in::corp2::' 	+ version + '::AR_' 		+ state_origin, AR_ApprovedRecords	 , write_ar,,,pOverwrite);
		VersionControl.macBuildNewLogicalFile(Corp2_Mapping._dataset().thor_cluster_Files + 'in::corp2::' 	+ version + '::Event_' 	+ state_origin, Event_ApprovedRecords, write_event,,,pOverwrite);
		VersionControl.macBuildNewLogicalFile(Corp2_Mapping._dataset().thor_cluster_Files + 'in::corp2::' 	+ version + '::Main_' 	+ state_origin, Main_ApprovedRecords , write_main,,,pOverwrite);

		VersionControl.macBuildNewLogicalFile(Corp2_Mapping._dataset().thor_cluster_Files + 'fail::corp2::' + version + '::AR_' 		+ state_origin, AR_F		, write_fail_ar,,,pOverwrite);
		VersionControl.macBuildNewLogicalFile(Corp2_Mapping._dataset().thor_cluster_Files + 'fail::corp2::' + version + '::Event_' 	+ state_origin, Event_F	, write_fail_event,,,pOverwrite);
		VersionControl.macBuildNewLogicalFile(Corp2_Mapping._dataset().thor_cluster_Files + 'fail::corp2::' + version + '::Main_' 	+ state_origin, Main_F	, write_fail_main,,,pOverwrite);

		mapOR := sequential (if(pshouldspray = true,Corp2_mapping.fSprayFiles(state_origin,version,pOverwrite := pOverwrite))
												// ,Corp2_Raw_OR.Build_Bases(filedate,version,puseprod).All
												,AR_All
												,Event_All
												,Main_All
												,if(Fail_Build <> true	 
													 ,sequential (write_ar
																			 ,write_event
																			 ,write_main
																			 ,fileservices.addsuperfile(Corp2_Mapping._Dataset().thor_cluster_Files + 'in::'+Corp2_Mapping._Dataset().NameMapped +'::sprayed::ar'			,Corp2_Mapping._Dataset().thor_cluster_Files + 'in::corp2::'+version+'::ar_'		+state_origin)
																			 ,fileservices.addsuperfile(Corp2_Mapping._Dataset().thor_cluster_Files + 'in::'+Corp2_Mapping._Dataset().NameMapped +'::sprayed::event'	,Corp2_Mapping._Dataset().thor_cluster_Files + 'in::corp2::'+version+'::event_'	+state_origin)
																			 ,fileservices.addsuperfile(Corp2_Mapping._Dataset().thor_cluster_Files + 'in::'+Corp2_Mapping._Dataset().NameMapped +'::sprayed::main'		,Corp2_Mapping._Dataset().thor_cluster_Files + 'in::corp2::'+version+'::main_'	+state_origin)																		 
																			 ,if (count(Main_BadRecords) <> 0 or count(AR_BadRecords) <> 0 or count(Event_BadRecords) <> 0
																					 ,Corp2_Mapping.Send_Email(state_origin,version,count(Main_BadRecords)<>0,count(AR_BadRecords)<>0,count(Event_BadRecords)<>0,,count(Main_BadRecords),count(AR_BadRecords),count(Event_BadRecords),,count(Main_ApprovedRecords),count(AR_ApprovedRecords),count(Event_ApprovedRecords)).RecordsRejected																				 
																					 ,Corp2_Mapping.Send_Email(state_origin,version,count(Main_BadRecords)<>0,count(AR_BadRecords)<>0,count(Event_BadRecords)<>0,,count(Main_BadRecords),count(AR_BadRecords),count(Event_BadRecords),,count(Main_ApprovedRecords),count(AR_ApprovedRecords),count(Event_ApprovedRecords)).MappingSuccess																				 
																					 )
																			 ,if (IsScrubErrors
																					 ,Corp2_Mapping.Send_Email(state_origin,version,Main_IsScrubErrors,AR_IsScrubErrors,Event_IsScrubErrors).FieldsInvalidPerScrubs
																					 )
																			 ) //if Fail_Build <> true																			
													 ,sequential (write_fail_main
																			 ,write_fail_ar
																			 ,write_fail_event
																			 ,write_fail_main
																			 ,Corp2_Mapping.Send_Email(state_origin,version).MappingFailed
																			 ) //if Fail_Build = true
													 )
											);
											
		isFileDateValid := if((string)std.date.today() between ut.date_math(filedate,-60) and ut.date_math(filedate,60),true,false);
		return sequential (if(isFileDateValid
												 ,mapOR
												 ,sequential (Corp2_Mapping.Send_Email(state_origin,filedate).InvalidFileDateParm
																		 ,FAIL('Corp2_Mapping.'+state_origin+' failed.  An invalid filedate was passed in as a parameter.')
																		 )
												 )
											);

	end;	// end of Update function

end; //end OR module      