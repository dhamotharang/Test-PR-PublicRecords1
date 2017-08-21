import ut,fbnv2,address,_Validate;

dist_busIn := distribute(FBNV2.File_BUSREG_Company_in,hash64(bdid));
sort_busIn := sort(dist_busIn,record,local);
busIn      := dedup(sort_busIn,RECORD,local);

trimUpper(string s) := function
			return trim(stringlib.StringToUppercase(s),left,right);
			end;
		
setValidStatus := ['AB','AC','AD','AR','CA','BR','CC','CH','CL','CN',
				   'CO','CR','DL','DS','EN','EP','EX','FR','GS','IA',
				   'IN','MG','MO','MS','NW','PD','RF','RG','RJ','RV',
				   'RS','SS','TF','TR','WD'];				

getBusStatus(string inCode) := function
		   workCode   := trimUpper(inCode);
		   busStatus  := case(workCode,							
								'AB'=>'ABANDONED',
								'AC'=>'CURRENT',
								'AD'=>'AMENDED',
								'AR'=>'ANNUAL RPT',
								'CA'=>'ADDR. CHGE',
								'BR'=>'BANKRUPTCY',
								'CC'=>'CANCELLED',
								'CH'=>'CHANGE',
								'CL'=>'CLOSED',
								'CN'=>'NAME CHGE',
								'CO'=>'OWNER CHGE', 
								'CR'=>'CORRECTION',
								'DL'=>'DELINQUENT',
								'DS'=>'DISSOLVED',
								'EN'=>'ENTRY',
								'EP'=>'EXPUNGED',
								'EX'=>'EXPIRED',
								'FR'=>'FORFEITURE',
								'GS'=>'GOOD STNDG',
								'IA'=>'INACTIVE',
								'IN'=>'INCOMPLETE',
								'MG'=>'MERGED IN',
								'MO'=>'MERGED OUT',
								'MS'=>'MERGE SURV',
								'NW'=>'NEW',
								'PD'=>'PENDING',
								'RF'=>'RENEWAL',
								'RG'=>'REGISTER',
								'RJ'=>'REJECTED',
								'RV'=>'REVOKED',
								'RS'=>'REINSTATED',
								'SS'=>'SUSPENDED',
								'TF'=>'TRANSFER',
								'TR'=>'TERMINATED',
								'WD'=>'WITHDRAWAL',
								'');
				return busStatus;
				end;

getCorpCode(string inCode) := function
			workCode := trimUpper(inCode);
			corpCode := case(workCode,
								'AN'=>'ASSUMED NAME',
								'BL'=>'BUSINESS LICENSE',
								'DB'=>'DBA',
								'FN'=>'FICTITIOUS NAME',
								'TN'=>'TRADENAME',
								'VL'=>'VENDOR LICENSE',								
								'');
				return corpCode;
				end;
			
getSosType(string inCode) := function
		   workCode := trimUpper(inCode);
		   sosType  := case(workCode,
								'AN'=>'ASSUMED NAME',
								'AG'=>'AGRICULTURE',
								'AT'=>'AUTHORITY',
								'BT'=>'BUSINESS TRUST',
								'CTY'=>'CITY',
								'COL'=>'COLLECTION AGENCY',
								'COOP'=>'COOPERATIVE',
								'CP'=>'CORPORATION',
								'DB'=>'DBA NAME',
								'FARM'=>'FARM',
								'FIN'=>'FINANCIAL INSTITUTIONS (BANKS)',
								'FIRE'=>'FIRE PROTECTION',
								'FN'=>'FICTITIOUS NAME',
								'FP'=>'FOR PROFIT',
								'GP'=>'GENERAL PARTNER',
								'HOS'=>'HOSPITAL',
								'HW'=>'HUSBAND & WIFE',
								'IND'=>'INDIVIDUAL',
								'INS'=>'INSURANCE',
								'JV'=>'JOINT VENTURE',
								'LLC'=>'LIMITED LIABILITY COMPANY',
								'LLP'=>'LIMITED LIABILITY PARTNERSHIP',
								'LP'=>'LIMITED PARTNER',
								'NP'=>'NON PROFIT',
								'NR'=>'NAME RESERVATION',
								'NRG'=>'NAME REGISTRATION',
								'PCP'=>'PROFESSIONAL CORPORATION',
								'PLLC'=>'PROFESSIONAL LLC',
								'PLLP'=>'PROFESSIONAL LLP',
								'PTR'=>'PARTNER',
								'RCP'=>'RESERVED CORPORATION',
								'RNP'=>'RESERVED NON PROFIT',
								'RLLC'=>'RESERVED LLC',
								'RLLP'=>'RESERVED LLP',
								'RLP'=>'RESERVED LP',
								'REL'=>'RELIGIOUS',
								'RR'=>'RAILROAD',
								'SAN'=>'SANITARY',
								'SCH'=>'SCHOOL',
								'SM'=>'SERVICE MARK',
								'SP'=>'SOLE PROPRIETOR',
								'SOIL'=>'SOIL',
								'TM'=>'TRADE MARK',
								'TN'=>'TRADE NAME',
								'TR'=>'TRUST',
								'UTY'=>'UTILITY',
								'WTR'=>'WATER',
								'');
				return sosType;
				end; 				

layout_common.Business_AID createFBN(busIn pInput)
   :=transform
            			
			self.tmsid					    			:= 'ACU'+hash64(trim(pInput.mail_zip_orig,left,right) + trim(pInput.company_name,left,right) );
			self.rmsid                    := ''+if(trim(pInput.dt_last_seen,left,right)<>'',
																						 trim(pInput.dt_last_seen,left,right),													 
																						 if(trim(pInput.dt_first_seen,left,right)<>'',
																								trim(pinput.dt_first_seen,left,right),
																								''));									
			self.dt_first_seen      			:= if(_validate.date.fIsValid((string)pInput.dt_first_seen),(integer) pInput.dt_first_seen,0);
			self.dt_last_seen      			  := if(_validate.date.fIsValid((string)pInput.dt_last_seen),(integer) pInput.dt_last_seen,0);
			self.dt_vendor_first_reported := if(_validate.date.fIsValid((string)pInput.record_date), (integer) pInput.record_date,0);
			self.dt_vendor_last_reported  := if(_validate.date.fIsValid((string)pInput.record_date), (integer) pInput.record_date,0);
			self.filing_jurisdiction      := if(TRIM(pinput.loc_state) <> '', trimUpper(pinput.loc_state), 
                                          if(TRIM(pinput.mail_state) <> '', trimUpper(pinput.mail_state), trimUpper(pinput.mail_st)));
			self.filing_number           	:= pInput.filing_num;           
			self.Filing_date              := if(trim(pInput.ccyymmdd,left,right)<>'',
																					if(_validate.date.fIsValid((string)pInput.ccyymmdd), (integer) (pInput.ccyymmdd),0),			
																					if(_validate.date.fIsValid((string)pInput.file_date),(integer) (pInput.file_date),0));
			tempCorpCode             		:= getCorpCode(pinput.corpcode);
			useCorpCode									:= if(trimUpper(pinput.corpcode) = 'DB' and
																				trimUpper(pinput.sos_code) = 'AN',
																				'',
																				tempCorpCode);
			tempSosType             	  := getSosType(pinput.sos_code);
			useSosType					    		:= if((trimUpper(pinput.corpcode) = trimUpper(pinput.sos_code)) or
																				(trimUpper(pinput.corpcode) = 'AN' and
																				trimUpper(pinput.sos_code) = 'DB'),
																				'', tempSosType);
			self.filing_type			    	:= MAP(useCorpCode<>'' => trim(useCorpCode,left,right) +
																				if(useSosType<>'', 
																				'; ' + 
																				trim(useSosType,left,right),
																				''),
																				useSosType<>''  => trim(useSosType,left,right),
																				'');			
			self.expiration_date				:= if(_validate.date.fIsValid((string)pinput.exp_date),(integer)pinput.exp_date,0);
			self.cancellation_date			:= if(_validate.date.fIsValid((string)pinput.disol_date),(integer)pinput.disol_date,0);
			self.orig_filing_date				:= if(_validate.date.fIsValid((string)pinput.form_date),(integer)pinput.form_date,0);
			self.bus_name           		:= pInput.company_name;
			self.bus_comm_date					:= if(_validate.date.fIsValid((string)pinput.start_date),(integer)pinput.start_date,0);
			self.bus_status							:= if(trimUpper(pinput.status)='',
																				pinput.chang_date,
																				if(trimUpper(pinput.status) in setValidStatus,
																					getBusStatus(pinput.status), 													   
																					''));		
			self.bus_phone_num					:= pinput.biz_ac + pinput.biz_phone;
			self.sic_code								:= pinput.sic;
			self.bus_type_desc					:= pinput.descript;
			self.bus_address1						:= pinput.loc_add;
			self.bus_address2						:= pinput.loc_suite;
			self.bus_city          			:= pinput.loc_city;
			self.bus_county							:= pinput.county;
			self.bus_state        			:= pinput.loc_state;              
			self.bus_zip           			:= (integer)pinput.loc_zip_orig; 
			self.bus_zip4           		:= (integer)pinput.loc_zip4_orig; 
			self.bus_country						:= pinput.country;
			self.mail_street  					:= pinput.mail_add + ' ' + pinput.mail_suite;
			self.mail_city 							:= pinput.mail_city;
			self.mail_state 						:= pinput.mail_state;
			self.mail_zip 							:= pinput.mail_zip;	
/*				
			self.prim_range 						:= pinput.loc_prim_range;			
			self.predir 								:= pinput.loc_predir;			
			self.prim_name 							:= pinput.loc_prim_name;	
			self.addr_suffix						:= pinput.loc_addr_suffix;
			self.postdir 								:= pinput.loc_postdir;	
			self.unit_desig 						:= pinput.loc_unit_desig;
			self.sec_range 							:= pinput.loc_sec_range;
			self.v_city_name 						:= pinput.loc_v_city_name;
			self.st 										:= pinput.loc_state;	
			self.zip5 									:= pinput.loc_zip;	
			self.zip4 									:= pinput.loc_zip4;	
			self.addr_rec_type					:= pinput.loc_record_type;	
			self.fips_state 						:= pinput.loc_ace_fips_st;	
			self.fips_county 						:= pinput.loc_fipscounty; 
			self.geo_lat 								:= pinput.loc_geo_lat;	
			self.geo_long 							:= pinput.loc_geo_long;	
			self.cbsa										:= pinput.loc_msa;	
			self.geo_blk 								:= pinput.loc_geo_blk;	
			self.geo_match 							:= pinput.loc_geo_match;			
			self.err_stat 							:= pinput.loc_err_stat;	
			self.mail_prim_range 				:= pinput.mail_prim_range;			
			self.mail_predir 						:= pinput.mail_predir;				
			self.mail_prim_name 				:= pinput.mail_prim_name;				
			self.mail_addr_suffix				:= pinput.mail_addr_suffix;				
			self.mail_postdir 					:= pinput.mail_postdir;				
			self.mail_unit_desig 				:= pinput.mail_unit_desig;				
			self.mail_sec_range 				:= pinput.mail_sec_range;				
			self.mail_v_city_name 			:= pinput.mail_v_city_name;			
			self.mail_st 								:= pinput.mail_state;			
			self.mail_zip5 							:= pinput.mail_zip;			
			self.mail_zip4 							:= pinput.mail_zip4;			
			self.mail_addr_rec_type			:= pinput.mail_record_type;				
			self.mail_fips_state 				:= pinput.mail_ace_fips_st;			
			self.mail_fips_county 			:= pinput.mail_fipscounty; 				
			self.mail_geo_lat 					:= pinput.mail_geo_lat;				
			self.mail_geo_long 					:= pinput.mail_geo_long;				
			self.mail_cbsa							:= pinput.mail_msa;			
			self.mail_geo_blk 					:= pinput.mail_geo_blk;				
			self.mail_geo_match 				:= pinput.mail_geo_match;				
			self.mail_err_stat 					:= pinput.mail_err_stat;
*/
			self.bdid										:= pinput.bdid;
			self.prep_addr_line1				:= pinput.Clean_location_address1;
			self.prep_addr_line_last		:= pinput.Clean_location_address2;
			self.prep_mail_addr_line1				:= pinput.Clean_mailing_address1;
			self.prep_mail_addr_line_last		:= pinput.Clean_mailing_address2;
			self.RawAID									:= pinput.Append_LocRawAID;
			self.ACEAID									:= pinput.Append_LocACEAID;
			self.Mail_RawAID						:= pinput.Append_MailRawAID;
			self.Mail_ACEAID						:= pinput.Append_MailACEAID;
			
			self												:= pinput;
			self												:= [];
			end;

layout_common.Business_AID  rollupXform(layout_common.Business_AID pLeft, layout_common.Business_AID pRight) 
	:= transform
		self.dt_first_seen := ut.min2(pleft.dt_first_seen,pright.dt_first_seen);
		self.dt_last_seen  := MAX(pleft.dt_last_seen ,pright.dt_last_seen);
		self.dt_vendor_first_reported := ut.min2(pleft.dt_vendor_first_reported,pright.dt_vendor_first_reported);
		self.dt_vendor_last_reported  := MAX(pleft.dt_vendor_last_reported,pright.dt_vendor_last_reported);
		self := pLeft;
     	end;
	
layout_common.Business_AID Trans_Rmsid(layout_common.Business_AID pLeft,string2 c ) 
   := transform  
     self.rmsid          :=if(trim(C,left,right)='1',pleft.rmsid,trim(C,left,right)+trim(pleft.rmsid));
	 self                :=pLeft;
	 end;
				  
dsFBN		:= project(busIn,createFBN(left));                          
dist_dsFBN  := distribute(dsFBN,hash64(tmsid));
sort1_dsFBN := sort(dist_dsFBN,RECORD,local);
dedup_dsFBN := dedup(sort1_dsFBN,RECORD,local);
sort2_dsFBN := sort(dedup_dsFBN,RECORD,except dt_first_seen,dt_last_seen, dt_vendor_first_reported,dt_vendor_last_reported,bus_zip4,local);
				  
dRollup     := rollup(sort2_dsFBN,rollupXform(left,right),
					RECORD,except dt_first_seen,dt_last_seen, dt_vendor_first_reported,dt_vendor_last_reported,bus_zip4,local);

dGroup      := group(sort(distribute(dROLLUP,hash64(tmsid,rmsid)),
                                       tmsid,rmsid,dt_first_seen,local),
			  			               tmsid,rmsid,local);
									   			  			              					
dOut        :=Project(dGroup,Trans_Rmsid(left,(string2) counter),local):persist(cluster.cluster_out+'persist::FBNV2::BUSREG::Business');

export Mapping_FBN_BUSREG_Business := dOut;
