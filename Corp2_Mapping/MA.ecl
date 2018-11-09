import _validate,corp2,corp2_raw_ma,scrubs,scrubs_corp2_mapping_ma_ar,scrubs_corp2_mapping_ma_event,
			 scrubs_corp2_mapping_ma_main,scrubs_corp2_mapping_ma_stock,ut,std,tools,versioncontrol;	

export MA := MODULE 

	export Update(string fileDate, string version, boolean pShouldSpray = _Dataset().bShouldSpray, boolean pOverwrite = false, pUseProd = Tools._Constants.IsDataland) := function

		state_origin			 				:= 'MA';
		state_fips	 				 			:= '25';
		state_desc	 			 				:= 'MASSACHUSETTS';
    
		CorpDataExport		 				:= dedup(sort(distribute(Corp2_Raw_MA.Files(fileDate,puseprod).Input.CorpDataExport.Logical,hash(dataid)),record,local),record,local) : independent;
		CorpIndividualExport			:= dedup(sort(distribute(Corp2_Raw_MA.Files(fileDate,puseprod).Input.CorpIndividualExport.Logical,hash(dataid)),record,local),record,local) : independent;
		CorpNameChange	 					:= dedup(sort(distribute(Corp2_Raw_MA.Files(fileDate,puseprod).Input.CorpNameChange.Logical,hash(dataid)),record,local),record,local) : independent;
		CorpMergerDataID					:= dedup(sort(distribute(Corp2_Raw_MA.Files(fileDate,puseprod).Input.CorpMerger.Logical,hash(dataid)),record,local),record,local) : independent;
		CorpMergerMergedDataID		:= dedup(sort(distribute(Corp2_Raw_MA.Files(fileDate,puseprod).Input.CorpMerger.Logical,hash(mergeddataid)),record,local),record,local) : independent;		
		CorpDetailExport					:= dedup(sort(distribute(Corp2_Raw_MA.Files(fileDate,puseprod).Input.CorpDetailExport.Logical,hash(dataid)),record,local),record,local) : independent;
		CorpStockExport		 				:= dedup(sort(distribute(Corp2_Raw_MA.Files(fileDate,puseprod).Input.CorpStockExport.Logical,hash(dataid)),record,local),record,local) : independent;

		ALPHA := 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';

		//********************************************************************
		// PROCESS MAIN FILE
		//********************************************************************
		//Merge CorpDataExport and CorpMergerDataID File
		DataMergerDataID 						:= join(CorpDataExport,CorpMergerDataID,
																				corp2.t2u(left.dataid) = corp2.t2u(right.dataid),
																				transform(Corp2_Raw_MA.Layouts.Temp_CorpDataExportMerger,
																									self.mergerindicator 		:= 'S'; //SURVIVOR
																									self.mergerfein					:= left.fein;
																									self.inactivedesc				:= '';
																									self.statusdate					:= '';
																									self.statusdesc					:= '';																									
																									self										:= left;
																									self										:= right;
																								 ),
																				left outer,
																				local
																			 );

		DataMergerMerged			  	 	:= join(DataMergerDataID,CorpMergerMergedDataID,
																				corp2.t2u(left.dataid) = corp2.t2u(right.mergeddataid),
																				transform(Corp2_Raw_MA.Layouts.Temp_CorpDataExportMerger,
																									self.mergerindicator 		:= 'N'; //NON-SURVIVOR
																									self.mergerfein					:= left.fein;																									
																									self								 		:= left;																				 
																								),
																				left outer,
																				local
																			 );
																			 	
		HasStatusDates							:= corp2.t2u(DataMergerMerged.inactivedate) <> '' or corp2.t2u(DataMergerMerged.revivaldate) <> ''  or corp2.t2u(DataMergerMerged.lastdatecertain) <> '' ;
		dsHasStatusDates						:= DataMergerMerged(HasStatusDates);
		dsNoStatusDates							:= DataMergerMerged(not(HasStatusDates));

		//Normalize the "joined" CorpDataExport and CorpMerger Data File on "status".
		Corp2_Raw_MA.Layouts.Temp_CorpDataExportMerger NormalizeStatus(Corp2_Raw_MA.Layouts.Temp_CorpDataExportMerger l, unsigned1 cnt) := transform,
		skip(cnt = 1 and Corp2_Mapping.fValidateDate(l.inactivedate,Corp2_Mapping.fFormatOfDate(l.inactivedate)).PastDate 	  	= ''  or
				 cnt = 2 and Corp2_Mapping.fValidateDate(l.revivaldate,Corp2_Mapping.fFormatOfDate(l.revivaldate)).PastDate     		= ''	or
				 cnt = 3 and Corp2_Mapping.fValidateDate(l.lastdatecertain,Corp2_Mapping.fFormatOfDate(l.lastdatecertain)).PastDate = ''
				)
			self.statusdate		:= choose(cnt,corp2.t2u(l.inactivedate),corp2.t2u(l.revivaldate),corp2.t2u(l.lastdatecertain));
			self.statusdesc		:= choose(cnt,'INACTIVEDATE','REVIVALDATE','LASTDATECERTAIN');
			self 							:= l;
		end;

		NormalizedCorpDataExportMerger := normalize(dsHasStatusDates, 3, NormalizeStatus(left, counter));
		dsCorpDataExportMerger				 := NormalizedCorpDataExportMerger + dsNoStatusDates;
		
		//Map the previously normalized CorpDataExport and CorpMerger File
		Corp2_Mapping.LayoutsCommon.Main CorpTransform(Corp2_Raw_MA.Layouts.Temp_CorpDataExportMerger l) := transform
			self.dt_vendor_first_reported							:= (integer)fileDate;
			self.dt_vendor_last_reported							:= (integer)fileDate;
			self.dt_first_seen												:= (integer)fileDate;
			self.dt_last_seen													:= (integer)fileDate;
			self.corp_ra_dt_first_seen								:= (integer)fileDate;
			self.corp_ra_dt_last_seen									:= (integer)fileDate;			
			self.corp_key															:= state_fips + '-' + corp2.t2u(l.dataid);
			self.corp_vendor													:= state_fips;
			self.corp_state_origin										:= state_origin;			
			self.corp_process_date										:= fileDate;
			self.corp_orig_sos_charter_nbr 						:= corp2.t2u(l.fein);
			self.corp_legal_name 											:= Corp2_mapping.fCleanBusinessName(state_origin,state_desc,regexreplace('(\\()+(.*)FICHE(.*)(\\))+',l.entityname,'')).BusinessName;
			self.corp_ln_name_type_cd									:= map(corp2.t2u(l.entitytypedescriptor) = 'FOREIGN DBA' 					              => '02',
																											 Corp2_Raw_MA.Functions.LookupEntityTypeDesc(l.entitytypedescriptor)<>''	=> '01',
																											 ''
																											);
			self.corp_ln_name_type_desc								:= map(corp2.t2u(l.entitytypedescriptor) = 'FOREIGN DBA' 					              => 'DBA',
																											 Corp2_Raw_MA.Functions.LookupEntityTypeDesc(l.entitytypedescriptor)<>''	=> 'LEGAL',
																											 ''
																											);
			self.corp_name_comment										:= Corp2_Raw_MA.Functions.CorpNameComment(l.consentflag);
			self.corp_address1_type_cd								:= if(Corp2_Mapping.fAddressExists(state_origin,state_desc,l.addr1,l.addr2,l.city,l.state,l.postalcode).ifAddressExists, 'B', '');
			self.corp_address1_type_desc							:= if(Corp2_Mapping.fAddressExists(state_origin,state_desc,l.addr1,l.addr2,l.city,l.state,l.postalcode).ifAddressExists, 'BUSINESS', '');																								
			self.corp_address1_line1									:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.addr1,l.addr2,l.city,l.state,l.postalcode,Corp2_Raw_MA.Functions.ValidCountryCode(l.countrycode)).AddressLine1;
			self.corp_address1_line2				 					:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.addr1,l.addr2,l.city,l.state,l.postalcode,Corp2_Raw_MA.Functions.ValidCountryCode(l.countrycode)).AddressLine2;
			self.corp_address1_line3				 					:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.addr1,l.addr2,l.city,l.state,l.postalcode,Corp2_Raw_MA.Functions.ValidCountryCode(l.countrycode)).AddressLine3;
			self.corp_prep_addr1_line1								:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.addr1,l.addr2,l.city,l.state,l.postalcode,Corp2_Raw_MA.Functions.ValidCountryCode(l.countrycode)).PrepAddrLine1;
			self.corp_prep_addr1_last_line						:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.addr1,l.addr2,l.city,l.state,l.postalcode,Corp2_Raw_MA.Functions.ValidCountryCode(l.countrycode)).PrepAddrLastLine;
			self.corp_status_cd												:= if(corp2.t2u(l.activeflag) in ['Y','N'],corp2.t2u(l.activeflag),'');
			self.corp_status_desc											:= map(corp2.t2u(l.activeflag) = 'Y' => 'ACTIVE',
																											 corp2.t2u(l.activeflag) = 'N' => 'INACTIVE',
																											 ''
																											);
			self.corp_status_date											:= Corp2_Mapping.fValidateDate(l.statusdate,Corp2_Mapping.fFormatOfDate(l.statusdate)).PastDate;
			self.corp_status_comment									:= map(corp2.t2u(l.statusdesc) = 'INACTIVEDATE' 		=> Corp2_Raw_MA.Functions.LookupInactiveTypeCodes(l.inactivetype),
																											 corp2.t2u(l.statusdesc) = 'REVIVALDATE' 			=> 'REVIVAL',
																											 corp2.t2u(l.statusdesc) = 'LASTDATECERTAIN' 	=> '',
																											 ''
																										 );
			self.corp_inc_state												:= state_origin;
			//Dates can exist in 3 different formats: MM-DD-CCYY or MM/DD/CCYY or MMM DD CCYY (e.g. JAN 4 1954)
			self.corp_inc_date												:= if(corp2.t2u(l.jurisdictionstate) in ['',state_origin],
																									    Corp2_Mapping.fValidateDate(l.dateoforganization,Corp2_Mapping.fFormatOfDate(l.dateoforganization)).PastDate,
																										  ''
																										 );
			self.corp_fed_tax_id											:= Corp2_Raw_MA.Functions.CorpFedTaxID(l.fein);
			self.corp_foreign_domestic_ind						:= map(Corp2_Raw_MA.Functions.LookupEntityTypeCodes(l.entitytypedescriptor) in ['0500','0602','0705','0802','1017'] => 'F',
																											 Corp2_Raw_MA.Functions.LookupEntityTypeCodes(l.entitytypedescriptor) in ['0200','0601','0703','0801'] 			  => 'D',
																											 corp2.t2u(l.entitytypedescriptor) = 'DOMESTIC BENEFIT CORPORATION' 										               			  => 'D',
																											 ''
																											);																											
			self.corp_forgn_state_cd									:= if(corp2.t2u(l.jurisdictionstate) not in ['',state_origin],Corp2_Raw_MA.Functions.CorpForgnStateCD(state_origin,state_desc,l.jurisdictionstate),'');
			self.corp_forgn_state_desc								:= if(corp2.t2u(l.jurisdictionstate) not in ['',state_origin],Corp2_Raw_MA.Functions.CorpForgnStateDesc(state_origin,state_desc,l.jurisdictionstate),'');
			//Dates can exist in 3 different formats: MM-DD-CCYY or MM/DD/CCYY or MMM DD CCYY (e.g. JAN 4 1954)																											
			self.corp_forgn_date											:= if(corp2.t2u(l.jurisdictionstate) not in ['',state_origin],
																									    Corp2_Mapping.fValidateDate(l.dateoforganization,Corp2_Mapping.fFormatOfDate(l.dateoforganization)).PastDate,
																										  ''
																										 );		
			self.corp_orig_org_structure_cd						:= if(Corp2_Raw_MA.Functions.LookupEntityTypeCodes(l.entitytypedescriptor) not in ['1017','5011','8000','8500'],Corp2_Raw_MA.Functions.LookupEntityTypeCodes(l.entitytypedescriptor),'');
			self.corp_orig_org_structure_desc					:= if(Corp2_Raw_MA.Functions.LookupEntityTypeCodes(l.entitytypedescriptor) not in ['1017','5011','8000','8500'],Corp2_Raw_MA.Functions.LookupEntityTypeDesc(l.entitytypedescriptor),'');
			self.corp_for_profit_ind									:= map(Corp2_Raw_MA.Functions.LookupEntityTypeCodes(l.entitytypedescriptor) = '0200' => 'Y',
																											 Corp2_Raw_MA.Functions.LookupEntityTypeCodes(l.entitytypedescriptor) = '0300' => 'N',
																											 ''
																											);
			self.corp_public_or_private_ind						:= if(corp2.t2u(l.corppublicflag)   = 'Y','1','');
			self.corp_partnership_ind									:= if(corp2.t2u(l.partnershipflag)  = 'Y',corp2.t2u(l.partnershipflag),'');			
			self.corp_mfg_ind													:= if(corp2.t2u(l.manufacturerflag) = 'Y',corp2.t2u(l.manufacturerflag),'');
			self.corp_addl_info												:= Corp2_Raw_MA.Functions.CorpAddlInfo(l.doingbusinessas,l.foreignname,l.partnershipflag,l.manufacturerflag,l.corppublicflag,
																																								 l.profitflag,l.annualrptreqflag,l.mergerallowedflag,l.residentagentflag,l.oldfein);
			self.corp_ra_full_name										:= Corp2_Raw_MA.Functions.CorpRAFullName(state_origin,state_desc,l.agentname,l.agentaddr1+' '+l.agentaddr2+' '+l.agentcity+' '+l.agentstate+' '+l.agentpostalcode);
			isDBA												 	  					:= if(regexfind('DOING BUSINESS AS|DOING BUSINESS BY',l.agentname,0)<>'',true,false);
			self.corp_ra_address_type_cd			 				:= map(isDBA 																																																																			=> '',
																											 Corp2_Mapping.fAddressExists(state_origin,state_desc,l.agentaddr1,l.agentaddr2,l.agentcity,l.agentstate,l.agentpostalcode).ifAddressExists => 'R',
																											 ''
																											 );
			self.corp_ra_address_type_desc		 				:= map(isDBA 																																																																			=> '',
																											 Corp2_Mapping.fAddressExists(state_origin,state_desc,l.agentaddr1,l.agentaddr2,l.agentcity,l.agentstate,l.agentpostalcode).ifAddressExists => 'REGISTERED OFFICE',
																											 ''
																											 );
			self.corp_ra_address_line1			 	  			:= if(isDBA,'',Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.agentaddr1,l.agentaddr2,l.agentcity,l.agentstate,l.agentpostalcode).AddressLine1);
			self.corp_ra_address_line2			 	  			:= if(isDBA,'',Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.agentaddr1,l.agentaddr2,l.agentcity,l.agentstate,l.agentpostalcode).AddressLine2);
			self.corp_ra_address_line3				  			:= if(isDBA,'',Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.agentaddr1,l.agentaddr2,l.agentcity,l.agentstate,l.agentpostalcode).AddressLine3);																										
			self.ra_prep_addr_line1						  			:= if(isDBA,'',Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.agentaddr1,l.agentaddr2,l.agentcity,l.agentstate,l.agentpostalcode).PrepAddrLine1);
			self.ra_prep_addr_last_line				  			:= if(isDBA,'',Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.agentaddr1,l.agentaddr2,l.agentcity,l.agentstate,l.agentpostalcode).PrepAddrLastLine);
			self.corp_consent_flag_for_protected_name := if(corp2.t2u(l.consentflag) = 'Y',corp2.t2u(l.consentflag),'');			
			self.corp_merged_corporation_id						:= corp2.t2u(l.mergerfein);	
			self.corp_merged_fein											:= if(corp2.t2u(l.mergedfein)<>'UNRG1',corp2.t2u(l.mergedfein),''); //non-survivor fein
			self.corp_merger_allowed_flag							:= if(corp2.t2u(l.mergerallowedflag) in ['Y','N'],corp2.t2u(l.mergerallowedflag),'');
			self.corp_merger_date											:= Corp2_Mapping.fValidateDate(l.mergerdate,Corp2_Mapping.fFormatOfDate(l.mergerdate)).PastDate;
			self.corp_merger_desc											:= map(corp2.t2u(l.mergertype) = 'C' => 'CONSOLIDATION',
																											 corp2.t2u(l.mergertype) = 'M' => 'MERGER',
																											 corp2.t2u(l.mergertype) = 'S' => 'MERGER',
																											 corp2.t2u(l.mergertype) = 'V' => 'CONVERTED',
																											 ''
																											);
			self.corp_merger_name											:= Corp2_mapping.fCleanBusinessName(state_origin,state_desc,l.mergerentityname).BusinessName;
			self.corp_organizational_comments					:= if(_Validate.Support.fIntegerInRange((unsigned4)l.fiscalday,1,_Validate.Date.fDaysInMonth(0,(unsigned4)l.fiscalmonth)),
																											'FISCAL MONTH/DAY: '+corp2.t2u(l.fiscalmonth+'/'+l.fiscalday),
																											''
																										 );
			self.corp_ra_required_flag								:= if(corp2.t2u(l.residentagentflag) in ['N','Y'],corp2.t2u(l.residentagentflag),'');																										 
			self.corp_survivor_corporation_id					:= corp2.t2u(l.dataid);		//survivor fein																										 			
			self.recordorigin													:= 'C';			
			self																			:= [];																						
		end;
	
		Map_CorpDataExport_Main    	:= project(dsCorpDataExportMerger,CorpTransform(left));

		//Join CorpDataExport and CorpNameChange in order to get corporation data
		CorpDataNameChange					:= join(CorpDataExport,CorpNameChange,
																				corp2.t2u(left.dataid) = corp2.t2u(right.dataid),
																				transform(Corp2_Raw_MA.Layouts.Temp_CorpDataNameChange,																								
																									self										:= left;
																									self										:= right;
																								 ),
																				inner,
																				local
																			 ) : independent;	
																			 

		//Map CorpNameChange File 
		Corp2_Mapping.LayoutsCommon.Main NameChangeTransform(Corp2_Raw_MA.Layouts.Temp_CorpDataNameChange l) := transform,
		skip(Corp2_mapping.fCleanBusinessName(state_origin,state_desc,l.oldentityname).BusinessName='')
			self.dt_vendor_first_reported							:= (integer)fileDate;
			self.dt_vendor_last_reported							:= (integer)fileDate;
			self.dt_first_seen												:= (integer)fileDate;
			self.dt_last_seen													:= (integer)fileDate;
			self.corp_ra_dt_first_seen								:= (integer)fileDate;
			self.corp_ra_dt_last_seen									:= (integer)fileDate;			
			self.corp_key															:= state_fips + '-' + corp2.t2u(l.dataid);
			self.corp_vendor													:= state_fips;
			self.corp_state_origin										:= state_origin;			
			self.corp_process_date										:= fileDate;
			self.corp_orig_sos_charter_nbr 						:= corp2.t2u(l.fein);
			self.corp_legal_name											:= Corp2_mapping.fCleanBusinessName(state_origin,state_desc,l.oldentityname).BusinessName;
			self.corp_ln_name_type_cd									:= 'P';
			self.corp_ln_name_type_desc								:= 'PRIOR';
			self.corp_name_status_date								:= Corp2_Mapping.fValidateDate(l.namechgdate,Corp2_Mapping.fFormatOfDate(l.namechgdate)).PastDate;
			self.corp_name_status_desc								:= if(self.corp_name_status_date <> '','CHANGE DATE','');
			self.corp_inc_state												:= state_origin;
			//Dates can exist in 3 different formats: MM-DD-CCYY or MM/DD/CCYY or MMM DD CCYY (e.g. JAN 4 1954)
			self.corp_inc_date												:= if(corp2.t2u(l.jurisdictionstate) in ['',state_origin],
																									    Corp2_Mapping.fValidateDate(l.dateoforganization,Corp2_Mapping.fFormatOfDate(l.dateoforganization)).PastDate,
																										  '');
			self.corp_forgn_date											:= if(corp2.t2u(l.jurisdictionstate) not in ['',state_origin],
																									    Corp2_Mapping.fValidateDate(l.dateoforganization,Corp2_Mapping.fFormatOfDate(l.dateoforganization)).PastDate,
																										  '');		
			self.recordorigin													:= 'C';			
			self																			:= [];
		end;
																 
		Map_CorpNameChange_Main	:= project(CorpDataNameChange,NameChangeTransform(left));

		//Normalize the business and resident address in CorpIndividualExport (contact data)
		Corp2_Raw_MA.Layouts.Temp_NormalizedIndividualExport NormalizeAddress(Corp2_Raw_MA.Layouts.CorpIndividualExportLayoutIn l, unsigned1 cnt) := transform,
		skip(cnt = 1 and corp2.t2u(l.busaddr1+l.buscity+l.busstate+l.buspostalcode) = '' or
				 cnt = 2 and corp2.t2u(l.resaddr1+l.rescity+l.resstate+l.respostalcode) = ''
				)
			self.c_address1			:= choose(cnt,corp2.t2u(l.busaddr1),corp2.t2u(l.resaddr1));
			self.c_city					:= choose(cnt,corp2.t2u(l.buscity),corp2.t2u(l.rescity));
			self.c_state				:= choose(cnt,corp2.t2u(l.busstate),corp2.t2u(l.resstate));		
			self.c_zip					:= choose(cnt,corp2.t2u(l.buspostalcode),corp2.t2u(l.respostalcode));
			self.c_country			:= choose(cnt,corp2.t2u(l.buscountrycode),corp2.t2u(l.rescountrycode));
			self.c_addrtype			:= choose(cnt,'B','T');
			self.c_addrdesc			:= choose(cnt,'BUSINESS','CONTACT');
			self 							:= l;
		end;

		NormalizedIndividualExport      := normalize(CorpIndividualExport, 2, NormalizeAddress(left, counter));	
		NormalizedIndividualExportSort 	:= sort(distribute(NormalizedIndividualExport,hash(dataid)),dataid,local) : independent;

		//Join CorpDataExport and CorpNameChange in order to get corporation data for the contacts.
		CorpDataIndividualExport		    := join(CorpDataExport,NormalizedIndividualExportSort,
																			    	corp2.t2u(left.dataid) = corp2.t2u(right.dataid),
																			    	transform(Corp2_Raw_MA.Layouts.Temp_CorpDataIndividualExport,																								
																									self	:= left;
																									self	:= right;
																								     ),
																			    	inner,
																				    local
																			     );	

		//Map CorpIndividualExport (contact) Data
		Corp2_Mapping.LayoutsCommon.Main ContTransform(Corp2_Raw_MA.Layouts.Temp_CorpDataIndividualExport l) := transform
			self.dt_vendor_first_reported							:= (integer)fileDate;
			self.dt_vendor_last_reported							:= (integer)fileDate;
			self.dt_first_seen												:= (integer)fileDate;
			self.dt_last_seen													:= (integer)fileDate;
			self.corp_ra_dt_first_seen								:= (integer)fileDate;
			self.corp_ra_dt_last_seen									:= (integer)fileDate;			
			self.corp_key															:= state_fips + '-' + corp2.t2u(l.dataid);
			self.corp_vendor													:= state_fips;
			self.corp_state_origin										:= state_origin;			
			self.corp_process_date										:= fileDate;
			self.corp_orig_sos_charter_nbr 						:= corp2.t2u(l.fein);
			self.corp_legal_name 											:= Corp2_mapping.fCleanBusinessName(state_origin,state_desc,regexreplace('(\\()+(.*)FICHE(.*)(\\))+',l.entityname,'')).BusinessName;
			self.cont_fname     											:= Corp2_Mapping.fCleanPersonName(state_origin,state_desc,l.firstname,l.middlename,l.lastname).FirstName;
			self.cont_mname     											:= Corp2_Mapping.fCleanPersonName(state_origin,state_desc,l.firstname,l.middlename,l.lastname).MiddleName;
			self.cont_lname     											:= Corp2_Mapping.fCleanPersonName(state_origin,state_desc,l.firstname,l.middlename,l.lastname).LastName;
			self.cont_full_name												:= corp2.t2u(self.cont_fname+' '+self.cont_mname+' '+self.cont_lname);
			self.cont_suffix													:= if(corp2.t2u(self.cont_fname+self.cont_mname+self.cont_lname)<>'',Corp2_Raw_MA.Functions.CleanText(l.suffix),'');
			self.cont_title1_desc											:= Corp2_Raw_MA.Functions.CleanText(l.individualtitle);
			self.cont_addl_info												:= if(Corp2_Raw_MA.Functions.CleanText(l.termexpiration)<>'','TERMS: '+Corp2_Raw_MA.Functions.CleanText(l.termexpiration),'');
			self.cont_address_type_cd									:= if(Corp2_Mapping.fAddressExists(state_origin,state_desc,l.c_address1,'',l.c_city,l.c_state,l.c_zip).ifAddressExists,corp2.t2u(l.c_addrtype), '');
			self.cont_address_type_desc								:= if(Corp2_Mapping.fAddressExists(state_origin,state_desc,l.c_address1,'',l.c_city,l.c_state,l.c_zip).ifAddressExists,corp2.t2u(l.c_addrdesc), '');
			self.cont_address_line1										:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.c_address1,,l.c_city,l.c_state,l.c_zip,l.c_country).AddressLine1;
			self.cont_address_line2										:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.c_address1,,l.c_city,l.c_state,l.c_zip,l.c_country).AddressLine2;
			self.cont_address_line3										:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.c_address1,,l.c_city,l.c_state,l.c_zip,l.c_country).AddressLine3;
			self.cont_prep_addr_line1									:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.c_address1,,l.c_city,l.c_state,l.c_zip,l.c_country).PrepAddrLine1;
			self.cont_prep_addr_last_line							:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.c_address1,,l.c_city,l.c_state,l.c_zip,l.c_country).PrepAddrLastLine;
			self.recordorigin													:= 'T';			
			self																			:= [];																						
		end;

		CorpIndividualExport_Main 		:= project(CorpDataIndividualExport,ContTransform(left));
		Map_CorpIndividualExport_Main := CorpIndividualExport_Main(cont_full_name<>'');
		
		All_Main											:= Map_CorpDataExport_Main + Map_CorpNameChange_Main + Map_CorpIndividualExport_Main;
		Map_Main      								:= dedup(sort(distribute(All_Main,hash(corp_key)),record,local),record,local) : independent;
		
		//********************************************************************
		// PROCESS AR FILE
		//********************************************************************

		//Join CorpDataExport and CorpDetailExport in order to get corporation data for the event records.
		CorpDataDetailExport	 := join(CorpDataExport,CorpDetailExport,
																				corp2.t2u(left.dataid) = corp2.t2u(right.dataid),
																				transform(Corp2_Raw_MA.Layouts.Temp_CorpDataDetailExport,																								
																									self	:= left;
																									self	:= right;
																								 ),
																				inner,
																				local
																			 ) : independent;	
																			 
		//Map CorpDetailExport file
		Corp2_Mapping.LayoutsCommon.AR ARTransform(Corp2_Raw_MA.Layouts.Temp_CorpDataDetailExport l) := transform
			self.corp_key											:= state_fips + '-' + corp2.t2u(l.dataid);		
			self.corp_vendor									:= state_fips;
			self.corp_state_origin						:= state_origin;			
			self.corp_process_date						:= filedate;
			self.corp_sos_charter_nbr 				:= corp2.t2u(l.fein);
			self.ar_year											:= if(length(corp2.t2u(l.fileyear))<>4 or corp2.t2u(l.fileyear) = 'VOID','',corp2.t2u(l.fileyear));
			self.ar_filed_dt									:= Corp2_Mapping.fValidateDate(l.submitdate,Corp2_Mapping.fFormatOfDate(l.submitdate)).PastDate;
			self.ar_report_nbr								:= corp2.t2u(l.filingnum);
			self.ar_comment										:= map(corp2.t2u(l.annualrptreqflag) = 'Y' => 'ANNUAL REPORT REQUIRED: YES',
																							 corp2.t2u(l.annualrptreqflag) = 'N' => 'ANNUAL REPORT REQUIRED: NO',			
																							 ''
																							);			
			self															:= [];
		end;

		//Note: filingcode[5..7] = '004' => "ANNUAL REPORT" and is to be mapped to AR
		All_AR 									:= project(CorpDataDetailExport(filingcode[5..7]='004'),ARTransform(left));
		Map_AR      						:= dedup(sort(distribute(All_AR(corp2.t2u(corp_sos_charter_nbr)<>''),hash(corp_key)),record,local),record,local) : independent;

		//********************************************************************
		// PROCESS EVENT FILE
		//********************************************************************															 
		//Map CorpDetailExport file
		Corp2_Mapping.LayoutsCommon.Events EventTransform(Corp2_Raw_MA.Layouts.Temp_CorpDataDetailExport l) := transform
			self.corp_key											:= state_fips + '-' + corp2.t2u(l.dataid);		
			self.corp_vendor									:= state_fips;
			self.corp_state_origin						:= state_origin;			
			self.corp_process_date						:= filedate;
			self.corp_sos_charter_nbr 				:= corp2.t2u(l.fein);
			self.event_filing_cd							:= corp2.t2u(l.filingcode)[5..7];
			self.event_filing_desc						:= Corp2_Raw_MA.Functions.LookupHistoryTypeCodes(l.filingcode[5..7]);
			self.event_filing_date						:= Corp2_Mapping.fValidateDate(l.submitdate,Corp2_Mapping.fFormatOfDate(l.submitdate)).PastDate;
			self.event_date_type_cd						:= if(self.event_filing_date <> '','SUB','');
			self.event_date_type_desc					:= if(self.event_filing_date <> '','SUBMISSION','');
			self.event_filing_reference_nbr		:= corp2.t2u(l.filingnum);
			self															:= [];
		end;
		
		//Note: filingcode[5..7] = '004' => "ANNUAL REPORT" and is NOT to be mapped to events
		CorpDataDetailExportEvent := project(CorpDataDetailExport(filingcode[5..7]<>'004'),EventTransform(left));

		//Map Merger file
		//Note:  The corp_sos_charter_nbr is intentionally not being mapped here.  This transform will be eliminated
		//			 after the new merger fields are customer facing. 		
		Corp2_Mapping.LayoutsCommon.Events MergerEventTransform(Corp2_Raw_MA.Layouts.CorpMergerLayoutIn l) := transform,
		skip(corp2.t2u(l.mergeddataid+l.mergedfein+l.mergerentityname+Corp2_Mapping.fValidateDate(l.mergerdate,Corp2_Mapping.fFormatOfDate(l.mergerdate)).PastDate)='')
			self.corp_key											:= state_fips + '-' + corp2.t2u(l.dataid);		
			self.corp_vendor									:= state_fips;
			self.corp_state_origin						:= state_origin;			
			self.corp_process_date						:= filedate;
			self.event_filing_date 						:= Corp2_Mapping.fValidateDate(l.mergerdate,Corp2_Mapping.fFormatOfDate(l.mergerdate)).PastDate;
			self.event_filing_desc 						:= 'MERGER';
			self.event_desc 									:= if(corp2.t2u(l.mergedfein)<>'','MERGED FEIN: '+corp2.t2u(l.mergedfein)+';'+if(corp2.t2u(l.mergerentityname)<>'',' ENTITY NAME: '+corp2.t2u(l.mergerentityname),''),'');
			self 															:= [];
		end;

		CorpMergerEvent					  := project(CorpMergerDataID,MergerEventTransform(left));

		//Map Name Change File 
		//Note:  The corp_sos_charter_nbr is intentionally not being mapped here.  This transform will be eliminated
		//			 after the new name change fields are customer facing. 
		Corp2_Mapping.LayoutsCommon.Events  CorpNameChangeEventTransform(Corp2_Raw_MA.Layouts.Temp_CorpDataNameChange l) := transform,
		skip(corp2.t2u(l.namechgid+l.oldentityname+Corp2_Mapping.fValidateDate(l.namechgdate,Corp2_Mapping.fFormatOfDate(l.namechgdate)).PastDate)='')
			self.corp_key											:= state_fips + '-' + corp2.t2u(l.dataid);		
			self.corp_vendor									:= state_fips;
			self.corp_state_origin						:= state_origin;			
			self.corp_process_date						:= filedate;
			self.event_filing_date 						:= Corp2_Mapping.fValidateDate(l.namechgdate,Corp2_Mapping.fFormatOfDate(l.namechgdate)).PastDate;
			self.event_filing_desc 						:= 'NAME CHANGE';
			self.event_microfilm_nbr 					:= '';
			self.event_desc 									:= if(corp2.t2u(l.oldentityname)<>'','OLD ENTITY NAME:' + corp2.t2u(l.oldentityname),'');
			self 															:= [];											 
		end;
		
		CorpNameChangeEvent			  := project(CorpDataNameChange,CorpNameChangeEventTransform(left));
		All_Event								  := CorpDataDetailExportEvent +	CorpMergerEvent + CorpNameChangeEvent;
		Map_Event      						:= dedup(sort(distribute(All_Event,hash(corp_key)),record,local),record,local) : independent;
		
		//********************************************************************
		// PROCESS STOCK FILE
		//********************************************************************
		//Join the CorpDataExport file with the CorpStockExport file to retrieve
		//the corporation data for the stock file.		
		TempCorpStockExport			 	  := join(CorpDataExport,CorpStockExport,
																				corp2.t2u(left.dataid) = corp2.t2u(right.dataid),
																				transform(Corp2_Raw_MA.Layouts.Temp_CorpDataStockExport,
																									self 						:= left;
																									self 						:= right;
																								),
																				inner,
																				local
																			 );
																			 
		//********************************************************************
		// PROCESS STOCK FILE - Map CorpStockExport file
		// Note: A stockclass="STK" does not exist in the LookUpStockTypeCodes 
		//			 file.
		//********************************************************************
		Corp2_Mapping.LayoutsCommon.Stock StockTransform(Corp2_Raw_MA.Layouts.Temp_CorpDataStockExport l) := transform
			self.corp_key											:= state_fips + '-' + corp2.t2u(l.dataid);		
			self.corp_vendor									:= state_fips;				
			self.corp_state_origin						:= state_origin;
			self.corp_process_date						:= filedate;
			self.corp_sos_charter_nbr 				:= corp2.t2u(l.fein);
			self.stock_class									:= Corp2_Raw_MA.Functions.LookupStockTypeCodes(l.stockclass);
			self.stock_authorized_nbr					:= corp2.t2u(l.authorizednumber);																							
			self.stock_par_value							:= corp2.t2u(l.parvaluepershare);
			self.stock_shares_issued					:= corp2.t2u(l.totalissuedoutstanding);
			self															:= [];
		end;
		
		CorpStockExport_Stock 		:= project(TempCorpStockExport,StockTransform(left));
		Map_CorpStockExport_Stock := CorpStockExport_Stock(corp2.t2u(stock_class+stock_authorized_nbr+stock_par_value+stock_shares_issued)<>'');		
		Map_Stock      						:= dedup(sort(distribute(Map_CorpStockExport_Stock,hash(corp_key)),record,local),record,local) : independent;

	//********************************************************************
  // SCRUB AR 
  //********************************************************************	
		AR_F := Map_AR;
		AR_S := Scrubs_Corp2_Mapping_MA_AR.Scrubs;				// Scrubs module
		AR_N := AR_S.FromNone(AR_F); 											// Generate the error flags
		AR_T := AR_S.FromBits(AR_N.BitmapInfile);     		// Use the FromBits module; makes my bitmap datafile easier to get to
		AR_U := AR_S.FromExpanded(AR_N.ExpandedInFile); 	// Pass the expanded error flags into the Expanded module

		//Outputs reports
		AR_ErrorSummary			 	 := output(AR_U.SummaryStats, named('AR_ErrorSummary_MA'+filedate));
		AR_ScrubErrorReport 	 := output(choosen(AR_U.AllErrors, 1000), named('AR_ScrubErrorReport_MA'+filedate));
		AR_SomeErrorValues		 := output(choosen(AR_U.BadValues, 1000), named('AR_SomeErrorValues_MA'+filedate));
		AR_IsScrubErrors		 	 := IF(count(AR_U.AllErrors)<> 0,true,false);

		// Orbit Stats
		AR_OrbitStats				 	 := AR_U.OrbitStats();
		
		//Outputs files
		AR_CreateBitMaps			 := output(AR_N.BitmapInfile,,'~thor_data::corp_MA_ar_scrubs_bits',overwrite,compressed);	//long term storage
		AR_TranslateBitMap		 := output(AR_T);


		//Submits Profile's stats to Orbit
		AR_SubmitStats 			   := Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_MA_AR','ScrubsAlerts', AR_OrbitStats, version,'Corp_MA_AR').SubmitStats;
		AR_ScrubsWithExamples  := Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_MA_AR','ScrubsAlerts', AR_OrbitStats, version,'Corp_MA_AR').CompareToProfile_with_Examples;

		AR_ScrubsAlert				 := AR_ScrubsWithExamples(RejectWarning = 'Y');
		AR_ScrubsAttachment	   := Scrubs.fn_email_attachment(AR_ScrubsAlert);
		AR_MailFile					   := FileServices.SendEmailAttachData(corp2.Email_Notification_Lists.spray
																															,'Scrubs CorpAR_MA Report' //subject
																															,'Scrubs CorpAR_MA Report' //body
																															,(data)AR_ScrubsAttachment
																															,'text/csv'
																															,'CorpMAARScrubsReport.csv'
																															,
																															,
																															,corp2.Email_Notification_Lists.spray);

		AR_BadRecords				 := AR_N.ExpandedInFile(	
																								corp_key_Invalid							  			<> 0 or
																								corp_vendor_Invalid 									<> 0 or
																								corp_state_origin_Invalid 					 	<> 0 or
																								corp_process_date_Invalid						  <> 0 or
																								corp_sos_charter_nbr_Invalid 					<> 0 or
																								ar_filed_dt_Invalid 									<> 0 or
																								ar_report_dt_Invalid 									<> 0
																							 );
																									 																	
		AR_GoodRecords				:= AR_N.ExpandedInFile(
																								corp_key_Invalid							  			= 0 and
																								corp_vendor_Invalid 									= 0 and
																								corp_state_origin_Invalid 					 	= 0 and
																								corp_process_date_Invalid						  = 0 and
																								corp_sos_charter_nbr_Invalid 					= 0 and
																								ar_filed_dt_Invalid 									= 0 and
																								ar_report_dt_Invalid 									= 0
																								);

		AR_FailBuild					 := if(count(AR_GoodRecords) = 0,true,false);

		AR_ApprovedRecords		 := project(AR_GoodRecords,transform(Corp2_Mapping.LayoutsCommon.AR,self := left;));


		AR_ALL								 := sequential(IF(count(AR_BadRecords) <> 0
																								 ,IF (poverwrite
																										 ,OUTPUT(AR_BadRecords,,Corp2_Mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::ar_'+state_origin,overwrite,__compressed__)
																										 ,OUTPUT(AR_BadRecords,,Corp2_Mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::ar_'+state_origin,__compressed__)
																										 )
																								 )
																						  ,output(AR_ScrubsWithExamples, all, named('CorpARMAScrubsReportWithExamples'+filedate))
																							//Send Alerts if Scrubs exceeds thresholds
																							,IF(COUNT(AR_ScrubsAlert) > 0, AR_MailFile, OUTPUT('CORP2_MAPPING.MA - No "AR" Corp Scrubs Alerts'))
																							,AR_ErrorSummary
																							,AR_ScrubErrorReport
																							,AR_SomeErrorValues		
																							,AR_SubmitStats
																					);

	//********************************************************************
  // SCRUB EVENT
  //********************************************************************	
		Event_F := Map_Event;
		Event_S := Scrubs_Corp2_Mapping_MA_Event.Scrubs;						// Scrubs module
		Event_N := Event_S.FromNone(Event_F); 											// Generate the error flags
		Event_T := Event_S.FromBits(Event_N.BitmapInfile);     			// Use the FromBits module; makes my bitmap datafile easier to get to
		Event_U := Event_S.FromExpanded(Event_N.ExpandedInFile); 		// Pass the expanded error flags into the Expanded module
		
		//Outputs reports
		Event_ErrorSummary				:= output(Event_U.SummaryStats, named('Event_ErrorSummary_MA'+filedate));
		Event_ScrubErrorReport 		:= output(choosen(Event_U.AllErrors, 1000), named('Event_ScrubErrorReport_MA'+filedate));
		Event_SomeErrorValues			:= output(choosen(Event_U.BadValues, 1000), named('Event_SomeErrorValues_MA'+filedate));
		Event_IsScrubErrors		 		:= IF(count(Event_U.AllErrors)<> 0,true,false);

		// Orbit Stats
		Event_OrbitStats					:= Event_U.OrbitStats();

		//Outputs files
		Event_CreateBitMaps				:= output(Event_N.BitmapInfile,,'~thor_data::corp_MA_event_scrubs_bits',overwrite,compressed);	//long term storage
		Event_TranslateBitMap			:= output(Event_T);


		//Submits Profile's stats to Orbit
		Event_SubmitStats 			  := Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_MA_Event','ScrubsAlerts', Event_OrbitStats, version,'Corp_MA_Event').SubmitStats;
		Event_ScrubsWithExamples  := Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_MA_Event','ScrubsAlerts', Event_OrbitStats, version,'Corp_MA_Event').CompareToProfile_with_Examples;

		Event_ScrubsAlert					:= Event_ScrubsWithExamples(RejectWarning = 'Y');
		Event_ScrubsAttachment		:= Scrubs.fn_email_attachment(Event_ScrubsAlert);
		Event_MailFile						:= FileServices.SendEmailAttachData(corp2.Email_Notification_Lists.spray
																																 ,'Scrubs CorpEvent_MA Report' //subject
																																 ,'Scrubs CorpEvent_MA Report' //body
																																 ,(data)Event_ScrubsAttachment
																																 ,'text/csv'
																																 ,'CorpMAEventScrubsReport.csv'
																																 ,
																																 ,
																																 ,corp2.Email_Notification_Lists.spray);

		Event_BadRecords				 	:= Event_N.ExpandedInFile(	
																												corp_key_Invalid							  			<> 0 or
																												corp_vendor_Invalid 									<> 0 or																						
																												corp_state_origin_Invalid 					 	<> 0 or
																												corp_process_date_Invalid							<> 0 or
																												corp_sos_charter_nbr_Invalid 					<> 0 or
																												event_filing_reference_nbr_Invalid		<> 0 or
																												event_filing_cd_Invalid 							<> 0 or
																												event_filing_desc_Invalid 						<> 0																			
																											 );
																										 																	
		Event_GoodRecords					:= Event_N.ExpandedInFile(	
																												corp_key_Invalid							  			= 0 and
																												corp_vendor_Invalid 									= 0 and																				
																												corp_state_origin_Invalid 					 	= 0 and
																												corp_process_date_Invalid						  = 0 and
																												corp_sos_charter_nbr_Invalid 					= 0 and
																												event_filing_reference_nbr_Invalid		= 0 and																															 
																												event_filing_cd_Invalid		 						= 0 and
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
																									 ,output(Event_ScrubsWithExamples, all, named('CorpEventMAScrubsReportWithExamples'+filedate))
																									 //Send Alerts if Scrubs exceeds thresholds
																									 ,IF(COUNT(Event_ScrubsAlert) > 0, Event_MailFile, OUTPUT('CORP2_MAPPING.MA - No "EVENT" Corp Scrubs Alerts'))
																									 ,Event_ErrorSummary
																									 ,Event_ScrubErrorReport
																									 ,Event_SomeErrorValues	
																									 ,Event_SubmitStats
																								);

	//********************************************************************
  // SCRUB MAIN
  //********************************************************************	
		Main_F := Map_Main;
		Main_S := Scrubs_Corp2_Mapping_MA_Main.Scrubs;					// Scrubs module
		Main_N := Main_S.FromNone(Main_F); 											// Generate the error flags
		Main_T := Main_S.FromBits(Main_N.BitmapInfile);     		// Use the FromBits module; makes my bitmap datafile easier to get to
		Main_U := Main_S.FromExpanded(Main_N.ExpandedInFile); 	// Pass the expanded error flags into the Expanded module

		//Outputs reports
		Main_ErrorSummary					:= output(Main_U.SummaryStats, named('Main_ErrorSummary_MA'+filedate));
		Main_ScrubErrorReport 		:= output(choosen(Main_U.AllErrors, 1000), named('Main_ScrubErrorReport_MA'+filedate));
		Main_SomeErrorValues			:= output(choosen(Main_U.BadValues, 1000), named('Main_SomeErrorValues_MA'+filedate));
		Main_IsScrubErrors		 		:= IF(count(Main_U.AllErrors)<> 0,true,false);

		// Orbit Stats
		Main_OrbitStats						:= Main_U.OrbitStats();
		
		//Outputs files
		Main_CreateBitMaps				:= output(Main_N.BitmapInfile,,'~thor_data::corp_MA_main_scrubs_bits',overwrite,compressed);	//long term storage
		Main_TranslateBitMap			:= output(Main_T);

		//Submits Profile's stats to Orbit
		Main_SubmitStats 			    := Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_MA_Main','ScrubsAlerts', Main_OrbitStats, version,'Corp_MA_Main').SubmitStats;
		Main_ScrubsWithExamples   := Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_MA_Main','ScrubsAlerts', Main_OrbitStats, version,'Corp_MA_Main').CompareToProfile_with_Examples;

		Main_ScrubsAlert					:= Main_ScrubsWithExamples(RejectWarning = 'Y');
		Main_ScrubsAttachment			:= Scrubs.fn_email_attachment(Main_ScrubsAlert);
		Main_MailFile							:= FileServices.SendEmailAttachData(corp2.Email_Notification_Lists.spray
																																 ,'Scrubs CorpMain_MA Report' //subject
																																 ,'Scrubs CorpMain_MA Report' //body
																																 ,(data)Main_ScrubsAttachment
																																 ,'text/csv'
																																 ,'CorpMAMainScrubsReport.csv'
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
																											 corp_state_origin_Invalid 					 		<> 0 or
																											 corp_process_date_Invalid						  <> 0 or
																											 corp_orig_sos_charter_nbr_Invalid 			<> 0 or
																											 corp_legal_name_Invalid 								<> 0 or																								 
																											 corp_ln_name_type_cd_Invalid 					<> 0 or
																											 corp_ln_name_type_desc_Invalid 				<> 0 or
																											 corp_address1_line3_Invalid 						<> 0 or
																											 corp_inc_date_Invalid 									<> 0 or
																											 corp_fed_tax_id_Invalid								<> 0 or																											 
																											 corp_forgn_state_cd_Invalid 						<> 0 or
																											 corp_forgn_state_desc_Invalid 					<> 0 or
																											 corp_forgn_date_Invalid 								<> 0 or
																											 corp_orig_org_structure_cd_Invalid 		<> 0 or
																											 corp_for_profit_ind_Invalid 						<> 0 or
																											 corp_public_or_private_ind_Invalid 		<> 0 or
																											 corp_merger_date_Invalid 							<> 0 or
																											 corp_name_status_date_Invalid 					<> 0
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
																										 corp_address1_line3_Invalid 						= 0 and
																										 corp_inc_date_Invalid 									= 0 and
																										 corp_fed_tax_id_Invalid								= 0 and																										 
																										 corp_forgn_state_cd_Invalid 						= 0 and
																										 corp_forgn_state_desc_Invalid 					= 0 and
																										 corp_forgn_date_Invalid 								= 0 and
																										 corp_orig_org_structure_cd_Invalid 		= 0 and
																										 corp_for_profit_ind_Invalid 						= 0 and
																										 corp_public_or_private_ind_Invalid 		= 0 and
																										 corp_merger_date_Invalid 							= 0 and
																										 corp_name_status_date_Invalid 					= 0
																								  );

		Main_FailBuild					:= map( corp2_mapping.fCalcPercent(count(Main_N.ExpandedInFile(corp_key_invalid<>0)),count(Main_N.ExpandedInFile),false) 										> Scrubs_Corp2_Mapping_MA_Main.Threshold_Percent.CORP_KEY										 => true,
																		corp2_mapping.fCalcPercent(count(Main_N.ExpandedInFile(corp_orig_sos_charter_nbr_invalid<>0)),count(Main_N.ExpandedInFile),false) 	> Scrubs_Corp2_Mapping_MA_Main.Threshold_Percent.CORP_ORIG_SOS_CHARTER_NBR 	 => true,
																		corp2_mapping.fCalcPercent(count(Main_N.ExpandedInFile(corp_legal_name_invalid<>0)),count(Main_N.ExpandedInFile),false) 						> Scrubs_Corp2_Mapping_MA_Main.Threshold_Percent.CORP_LEGAL_NAME 						 => true,
																		corp2_mapping.fCalcPercent(count(Main_N.ExpandedInFile(corp_ln_name_type_cd_invalid<>0)),count(Main_N.ExpandedInFile),false) 				> Scrubs_Corp2_Mapping_MA_Main.Threshold_Percent.CORP_LN_NAME_TYPE_CD		  	 => true,
																		corp2_mapping.fCalcPercent(count(Main_N.ExpandedInFile(corp_inc_date_invalid<>0)),count(Main_N.ExpandedInFile),false) 							> Scrubs_Corp2_Mapping_MA_Main.Threshold_Percent.CORP_INC_DATE 						 	 => true,
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
																					,output(Main_ScrubsWithExamples, all, named('CorpMainMAScrubsReportWithExamples'+filedate))
																					//Send Alerts if Scrubs exceeds thresholds
																					,IF(COUNT(Main_ScrubsAlert) > 0, Main_MailFile, OUTPUT('CORP2_MAPPING.MA - No "MAIN" Corp Scrubs Alerts'))
																					,Main_ErrorSummary
																					,Main_ScrubErrorReport
																					,Main_SomeErrorValues		
																					,Main_SubmitStats
																			);

	//********************************************************************
  // SCRUB STOCK
  //********************************************************************	
		Stock_F := Map_Stock;
		Stock_S := Scrubs_Corp2_Mapping_MA_Stock.Scrubs;						// Scrubs module
		Stock_N := Stock_S.FromNone(Stock_F); 											// Generate the error flags
		Stock_T := Stock_S.FromBits(Stock_N.BitmapInfile);     			// Use the FromBits module; makes my bitmap datafile easier to get to
		Stock_U := Stock_S.FromExpanded(Stock_N.ExpandedInFile); 		// Pass the expanded error flags into the Expanded module

		//Outputs reports
		Stock_ErrorSummary			 	:= output(Stock_U.SummaryStats, named('Stock_ErrorSummary_MA'+filedate));
		Stock_ScrubErrorReport 	 	:= output(choosen(Stock_U.AllErrors, 1000), named('Stock_ScrubErrorReport_MA'+filedate));
		Stock_SomeErrorValues		 	:= output(choosen(Stock_U.BadValues, 1000), named('Stock_SomeErrorValues_MA'+filedate));
		Stock_IsScrubErrors		 	 	:= IF(count(Stock_U.AllErrors)<> 0,true,false);

		// Orbit Stats
		Stock_OrbitStats				 	:= Stock_U.OrbitStats();
		
		//Outputs files
		Stock_CreateBitMaps				:= output(Stock_N.BitmapInfile,,'~thor_data::corp_MA_scrubs_bits',overwrite,compressed);	//long term storage
		Stock_TranslateBitMap			:= output(Stock_T);

		//Submits Profile's stats to Orbit
		Stock_SubmitStats 			  := Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_MA_Stock','ScrubsAlerts', Stock_OrbitStats, version,'Corp_MA_Stock').SubmitStats;
		Stock_ScrubsWithExamples  := Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_MA_Stock','ScrubsAlerts', Stock_OrbitStats, version,'Corp_MA_Stock').CompareToProfile_with_Examples;

		Stock_ScrubsAlert					:= Stock_ScrubsWithExamples(RejectWarning = 'Y');
		Stock_ScrubsAttachment		:= Scrubs.fn_email_attachment(Stock_ScrubsAlert);
		Stock_MailFile						:= FileServices.SendEmailAttachData(corp2.Email_Notification_Lists.spray
																																 ,'Scrubs CorpStock_MA Report' //subject
																																 ,'Scrubs CorpStock_MA Report' //body
																																 ,(data)Stock_ScrubsAttachment
																																 ,'text/csv'
																																 ,'CorpMAEventScrubsReport.csv'
																																 ,
																																 ,
																																 ,corp2.Email_Notification_Lists.spray);

		Stock_BadRecords					:= Stock_N.ExpandedInFile(	
																												corp_key_Invalid							  			<> 0 or
																												corp_vendor_Invalid 									<> 0 or
																												corp_state_origin_Invalid 					 	<> 0 or
																												corp_process_date_Invalid						  <> 0 or
																												corp_sos_charter_nbr_Invalid					<> 0 or
																												stock_class_Invalid										<> 0 or
																												stock_shares_issued_Invalid						<> 0 or																			
																												stock_authorized_nbr_Invalid	 				<> 0 or
																												stock_par_value_Invalid	 						  <> 0 
																											 );
																																														
		Stock_GoodRecords					:= Stock_N.ExpandedInFile(	
																												corp_key_Invalid							  			= 0 and
																												corp_vendor_Invalid 									= 0 and
																												corp_state_origin_Invalid 					 	= 0 and
																												corp_process_date_Invalid						  = 0 and
																												corp_sos_charter_nbr_Invalid					= 0 and
																												stock_class_Invalid										= 0 and
																												stock_shares_issued_Invalid						= 0 and																			
																												stock_authorized_nbr_Invalid	 				= 0 and
																												stock_par_value_Invalid	 						  = 0 																											 );
																														
		Stock_FailBuild						:= if(count(Stock_GoodRecords) = 0,true,false);

		Stock_ApprovedRecords			:= project(Stock_GoodRecords,transform(Corp2_Mapping.LayoutsCommon.Stock,self := left));

		Stock_ALL									:= sequential( IF(count(Stock_BadRecords) <> 0
																							,IF (poverwrite
																									,OUTPUT(Stock_BadRecords,,Corp2_Mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::stock_'+state_origin,overwrite,__compressed__)
																									,OUTPUT(Stock_BadRecords,,Corp2_Mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::stock_'+state_origin,__compressed__)
																									)
																							)
																					,output(Stock_ScrubsWithExamples, all, named('CorpStockMAScrubsReportWithExamples'+filedate))
																					//Send Alerts if Scrubs exceeds thresholds
																					,IF(COUNT(Stock_ScrubsAlert) > 0, Stock_MailFile, OUTPUT('CORP2_MAPPING.MA - No "Stock" Corp Scrubs Alerts'))
																					,Stock_ErrorSummary
																					,Stock_ScrubErrorReport
																					,Stock_SomeErrorValues	
																					,Stock_SubmitStats
																					);	

	//********************************************************************
  // UPDATE
  //********************************************************************

	Fail_Build						:= IF(AR_FailBuild = true or Event_FailBuild = true or Main_FailBuild = true or Stock_FailBuild = true,true,false);
	IsScrubErrors					:= IF(AR_IsScrubErrors = true or Event_IsScrubErrors = true or Main_IsScrubErrors = true or Stock_IsScrubErrors = true,true,false);

	VersionControl.macBuildNewLogicalFile(Corp2_Mapping._dataset().thor_cluster_Files + 'in::corp2::' 	+ version + '::AR_' 		+ state_origin, AR_ApprovedRecords	 , write_ar,,,pOverwrite);
	VersionControl.macBuildNewLogicalFile(Corp2_Mapping._dataset().thor_cluster_Files + 'in::corp2::' 	+ version + '::Event_' 	+ state_origin, Event_ApprovedRecords, write_event,,,pOverwrite);
	VersionControl.macBuildNewLogicalFile(Corp2_Mapping._dataset().thor_cluster_Files + 'in::corp2::' 	+ version + '::Main_' 	+ state_origin, Main_ApprovedRecords , write_main,,,pOverwrite);
	VersionControl.macBuildNewLogicalFile(Corp2_Mapping._dataset().thor_cluster_Files + 'in::corp2::' 	+ version + '::Stock_' 	+ state_origin, Stock_ApprovedRecords, write_stock,,,pOverwrite);

	VersionControl.macBuildNewLogicalFile(Corp2_Mapping._dataset().thor_cluster_Files + 'fail::corp2::' + version + '::AR_' 		+ state_origin, AR_F		, write_fail_ar,,,pOverwrite);
	VersionControl.macBuildNewLogicalFile(Corp2_Mapping._dataset().thor_cluster_Files + 'fail::corp2::' + version + '::Event_' 	+ state_origin, Event_F	, write_fail_event,,,pOverwrite);
	VersionControl.macBuildNewLogicalFile(Corp2_Mapping._dataset().thor_cluster_Files + 'fail::corp2::' + version + '::Main_' 	+ state_origin, Main_F	, write_fail_main,,,pOverwrite);
	VersionControl.macBuildNewLogicalFile(Corp2_Mapping._dataset().thor_cluster_Files + 'fail::corp2::' + version + '::Stock_' 	+ state_origin, Stock_F	, write_fail_stock,,,pOverwrite);

	mapMA:= sequential ( if(pshouldspray = true,Corp2_mapping.fSprayFiles(state_origin,version,pOverwrite := pOverwrite))
											// ,Corp2_Raw_MA.Build_Bases(filedate,version,puseprod).All  // Determined building of bases is not needed
											,AR_All
											,Event_All
											,Main_All
											,Stock_All									
											,if(Fail_Build <> true	 
												 ,sequential (write_ar
																		 ,write_event
																		 ,write_main
																		 ,write_stock	
																		 ,fileservices.addsuperfile(Corp2_Mapping._Dataset().thor_cluster_Files + 'in::'+Corp2_Mapping._Dataset().NameMapped +'::sprayed::ar'			,Corp2_Mapping._Dataset().thor_cluster_Files + 'in::corp2::'+version+'::ar_'		+state_origin)
																		 ,fileservices.addsuperfile(Corp2_Mapping._Dataset().thor_cluster_Files + 'in::'+Corp2_Mapping._Dataset().NameMapped +'::sprayed::event'	,Corp2_Mapping._Dataset().thor_cluster_Files + 'in::corp2::'+version+'::event_'	+state_origin)
																		 ,fileservices.addsuperfile(Corp2_Mapping._Dataset().thor_cluster_Files + 'in::'+Corp2_Mapping._Dataset().NameMapped +'::sprayed::main'		,Corp2_Mapping._Dataset().thor_cluster_Files + 'in::corp2::'+version+'::main_'	+state_origin)																		 
																		 ,fileservices.addsuperfile(Corp2_Mapping._Dataset().thor_cluster_Files + 'in::'+Corp2_Mapping._Dataset().NameMapped +'::sprayed::stock'	,Corp2_Mapping._Dataset().thor_cluster_Files + 'in::corp2::'+version+'::stock_'	+state_origin)
																		 ,if (count(Main_BadRecords) <> 0 or count(AR_BadRecords) <> 0 or count(Event_BadRecords) <> 0 or count(Stock_BadRecords)<>0
																				 ,Corp2_Mapping.Send_Email(state_origin,version,count(Main_BadRecords)<>0,count(AR_BadRecords)<>0,count(Event_BadRecords)<>0,count(Stock_BadRecords)<>0,count(Main_BadRecords),count(AR_BadRecords),count(Event_BadRecords),count(Stock_BadRecords),count(Main_ApprovedRecords),count(AR_ApprovedRecords),count(Event_ApprovedRecords),count(Stock_ApprovedRecords)).RecordsRejected																				 
																				 ,Corp2_Mapping.Send_Email(state_origin,version,count(Main_BadRecords)<>0,count(AR_BadRecords)<>0,count(Event_BadRecords)<>0,count(Stock_BadRecords)<>0,count(Main_BadRecords),count(AR_BadRecords),count(Event_BadRecords),count(Stock_BadRecords),count(Main_ApprovedRecords),count(AR_ApprovedRecords),count(Event_ApprovedRecords),count(Stock_ApprovedRecords)).MappingSuccess																				 
																				 )
																		 ,if (IsScrubErrors
																				 ,Corp2_Mapping.Send_Email(state_origin,version,Main_IsScrubErrors,AR_IsScrubErrors,Event_IsScrubErrors,Stock_IsScrubErrors).FieldsInvalidPerScrubs
																				 )
																		 ) //if Fail_Build <> true																			
												 ,SEQUENTIAL (write_fail_ar
																		 ,write_fail_event
																		 ,write_fail_main
																		 ,write_fail_stock												 
																		 ,Corp2_Mapping.Send_Email(state_origin,version).MappingFailed
																		 ) //if Fail_Build = true
												 )
										);
										
	isFileDateValid := if((string)std.date.today() between ut.date_math(filedate,-30) and ut.date_math(filedate,30),true,false);
	return sequential (	 if (isFileDateValid
													,mapMA
													,sequential (Corp2_Mapping.Send_Email(state_origin,filedate).InvalidFileDateParm
																			,FAIL('Corp2_Mapping.'+state_origin+' failed.  An invalid filedate was passed in as a parameter.')
																			)
													)
										);

	end;	// end of Update function

end; //end MA module