import ut,fbnv2;
	
dist_corpIn := distribute(FBNV2.File_CORP2_Corp_in(corp_key<>''),hash32(corp_key));
sort_corpIn := sort(dist_corpIn,record,local);
corpIn      := dedup(sort_corpIn,record,local);

getStatusDesc(string inDesc) := function					
  shortDesc  := map(regexfind('ABANDONED',inDesc,nocase)=TRUE=>'ABANDONDED',
					regexfind('INACTIVE',inDesc,nocase)=TRUE=>'INACTIVE',
					regexfind('NOT IN GOOD STANDING',inDesc,nocase)=TRUE=>'INACTIVE',
					regexfind('ACTIVE',inDesc,nocase)=TRUE=>'ACTIVE',
					regexfind('GOOD STANDING',inDesc,nocase)=TRUE=>'ACTIVE',
					regexfind('IN EXISTENCE',inDesc,nocase)=TRUE=>'ACTIVE',
					regexfind('CANCELED',inDesc,nocase)=TRUE=>'CANCELLED',
					regexfind('CANCELLED',inDesc,nocase)=TRUE=>'CANCELLED',
					regexfind('CONVERTED',inDesc,nocase)=TRUE=>'CONVERTED',
					regexfind('DELINQUENT',inDesc,nocase)=TRUE=>'DELINQUENT',
					regexfind('IMPENDING OUTSTER',inDesc,nocase)=TRUE=>'OUTSTER',
					regexfind('PENDING',inDesc,nocase)=TRUE=>'PENDING',				
					regexfind('REINSTATING',inDesc,nocase)=TRUE=>'REINSTATED',
					regexfind('DELETED',inDesc,nocase)=TRUE=>'DELETED',
					regexfind('DISSOLVE',inDesc,nocase)=TRUE=>'DISSOLVED',
					regexfind('EXPIRED',inDesc,nocase)=TRUE=>'EXPIRED',
					regexfind('FORFEITED',inDesc,nocase)=TRUE=>'FORFEITED',
					regexfind('IN PROCESS',inDesc,nocase)=TRUE=>'IN PROCESS',
					regexfind('IN USE',inDesc,nocase)=TRUE=>'IN USE',
					regexfind('MERGED',inDesc,nocase)=TRUE=>'MERGED',
					regexfind('NAME RESERVATION',inDesc,nocase)=TRUE=>'NAME RESRV',
					regexfind('NON-QUALIFIED',inDesc,nocase)=TRUE=>'NON-QUAL',
					regexfind('SUSPENSION',inDesc,nocase)=TRUE=>'SUSPENSION',
					regexfind('OUSTED',inDesc,nocase)=TRUE=>'OUSTED',
					regexfind('PRIOR',inDesc,nocase)=TRUE=>'PRIOR',
					regexfind('RA NOTICE',inDesc,nocase)=TRUE=>'RA NOTICE',
					regexfind('^REGISTERED',inDesc,nocase)=TRUE=>'REGISTERED',
					regexfind('REPORT DUE',inDesc,nocase)=TRUE=>'REPORT DUE',
					regexfind('REPORT NOTICE SENT',inDesc,nocase)=TRUE=>'RPT SENT',
					regexfind('^RESERVED',inDesc,nocase)=TRUE=>'RESERVED',
					regexfind('REVOKED',inDesc,nocase)=TRUE=>'REVOKED',
					regexfind('STRICKEN',inDesc,nocase)=TRUE=>'STRICKEN',
					regexfind('TERMINATED',inDesc,nocase)=TRUE=>'TERMINATED',
					regexfind('TRANSFERRED',inDesc,nocase)=TRUE=>'TRANSFER',
					regexfind('WITHDRAWN',inDesc,nocase)=TRUE=>'WITHDRAWN',
					'');
		return shortDesc;
			   end;

layout_common.Business_AID createFBN(corpIn pInput)
   :=transform
            			
			self.tmsid					    := pinput.corp_key;
			self.rmsid                      := ''+if(pinput.corp_filing_date<>'',
												     hash(pinput.corp_filing_date+pInput.corp_legal_name),
													 if(pinput.corp_filing_reference_nbr<>'',
													    hash(pinput.corp_filing_reference_nbr+pInput.corp_legal_name),
														hash(pInput.corp_legal_name)));
			self.dt_first_seen      		:= (integer) pInput.dt_first_seen;
			self.dt_last_seen       		:= (integer) pInput.dt_last_seen;
			self.dt_vendor_first_reported  	:= (integer) pInput.dt_vendor_first_reported;
			self.dt_vendor_last_reported  	:= (integer) pInput.dt_vendor_last_reported;
			self.filing_jurisdiction        := pinput.corp_inc_state;
			self.filing_number           	:= pInput.corp_orig_sos_charter_nbr;           
			self.Filing_date                := (integer) pInput.corp_inc_date;
			self.filing_type				:= pinput.corp_ln_name_type_desc;
			self.expiration_date			:= (integer)pinput.corp_term_exist_exp;
			self.cancellation_date			:= (integer)pinput.corp_term_exist_exp;
			self.orig_filing_number			:= pinput.corp_filing_reference_nbr;
			self.orig_filing_date			:= (integer)pinput.corp_filing_date;
			self.bus_name           		:= pInput.corp_legal_name;
			self.bus_comm_date				:= (integer)pinput.corp_filing_date;
			self.bus_status					:= getStatusDesc(pinput.corp_status_desc);
			self.orig_fein					:= (integer)pinput.corp_fed_tax_id;
			self.bus_phone_num				:= pinput.corp_phone_number;
			self.sic_code					:= pinput.corp_sic_code;
			self.bus_type_desc				:= if(trim(pinput.corp_orig_bus_type_desc,left,right)<>'',
													pinput.corp_orig_bus_type_desc,
													pinput.corp_orig_org_structure_desc);
			self.bus_address1				:= pinput.corp_address1_line1;
			self.bus_address2				:= pinput.corp_address1_line2;
			self.bus_city                   := pinput.corp_address1_line3;
			self.bus_county					:= pinput.corp_inc_county;
			self.bus_state                  := pinput.corp_address1_line4;              
			self.bus_zip           			:= (integer)pinput.corp_address1_line5[1..5]; 
			self.bus_zip4           		:= (integer)pinput.corp_address1_line5[6..9]; 
			self.bus_country				:= pinput.corp_address1_line6;
			self.mail_street  				:= pinput.corp_address1_line1;
			self.mail_city 					:= pinput.corp_address1_line3;
			self.mail_state 				:= pinput.corp_address1_line4;
			self.mail_zip 					:= pinput.corp_address1_line5;
/*			
			self.prim_range 				:= pinput.corp_addr1_prim_range;			
			self.predir 					:= pinput.corp_addr1_predir;			
			self.prim_name 					:= pinput.corp_addr1_prim_name;	
			self.addr_suffix				:= pinput.corp_addr1_addr_suffix;
			self.postdir 					:= pinput.corp_addr1_postdir;	
			self.unit_desig 				:= pinput.corp_addr1_unit_desig;
			self.sec_range 					:= pinput.corp_addr1_sec_range;
			self.v_city_name 				:= pinput.corp_addr1_v_city_name;
			self.st 						:= pinput.corp_addr1_state;	
			self.zip5 						:= pinput.corp_addr1_zip5;	
			self.zip4 						:= pinput.corp_addr1_zip4;	
			self.addr_rec_type				:= pinput.corp_addr1_rec_type;	
			self.fips_state 				:= pinput.corp_addr1_ace_fips_st;	
			self.fips_county 				:= pinput.corp_addr1_county; 
			self.geo_lat 					:= pinput.corp_addr1_geo_lat;	
			self.geo_long 					:= pinput.corp_addr1_geo_long;	
			self.cbsa						:= pinput.corp_addr1_msa;	
			self.geo_blk 					:= pinput.corp_addr1_geo_blk;	
			self.geo_match 					:= pinput.corp_addr1_geo_match;			
			self.err_stat 					:= pinput.corp_addr1_err_stat;	
			self.mail_prim_range 			:= pinput.corp_addr1_prim_range;			
			self.mail_predir 				:= pinput.corp_addr1_predir;				
			self.mail_prim_name 			:= pinput.corp_addr1_prim_name;				
			self.mail_addr_suffix			:= pinput.corp_addr1_addr_suffix;				
			self.mail_postdir 				:= pinput.corp_addr1_postdir;				
			self.mail_unit_desig 			:= pinput.corp_addr1_unit_desig;				
			self.mail_sec_range 			:= pinput.corp_addr1_sec_range;				
			self.mail_v_city_name 			:= pinput.corp_addr1_v_city_name;			
			self.mail_st 					:= pinput.corp_addr1_state;			
			self.mail_zip5 					:= pinput.corp_addr1_zip5;			
			self.mail_zip4 					:= pinput.corp_addr1_zip4;			
			self.mail_addr_rec_type			:= pinput.corp_addr1_rec_type;				
			self.mail_fips_state 			:= pinput.corp_addr1_ace_fips_st;			
			self.mail_fips_county 			:= pinput.corp_addr1_county; 				
			self.mail_geo_lat 				:= pinput.corp_addr1_geo_lat;				
			self.mail_geo_long 				:= pinput.corp_addr1_geo_long;				
			self.mail_cbsa					:= pinput.corp_addr1_msa;			
			self.mail_geo_blk 				:= pinput.corp_addr1_geo_blk;				
			self.mail_geo_match 			:= pinput.corp_addr1_geo_match;				
			self.mail_err_stat 				:= pinput.corp_addr1_err_stat;
*/
			self.prep_addr_line1					:= pinput.corp_prep_addr1_line1;
			self.prep_addr_line_last			:= pinput.corp_prep_addr1_last_line;
			self.prep_mail_addr_line1			:= pinput.corp_prep_addr1_line1;
			self.prep_mail_addr_line_last	:= pinput.corp_prep_addr1_last_line;
			
			self.bdid											:= pinput.bdid;
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
	
dsFBN		:= project(corpIn,createFBN(left));                          
dist_dsFBN  := distribute(dsFBN,hash32(tmsid));
sort1_dsFBN := sort(dist_dsFBN,RECORD,local);
dedup_dsFBN := dedup(sort1_dsFBN,RECORD,local);
sort2_dsFBN := sort(dedup_dsFBN,RECORD,except dt_first_seen,dt_last_seen, dt_vendor_first_reported,dt_vendor_last_reported,bus_zip4,local);	
	
dRollup     := rollup(sort2_dsFBN,rollupXform(left,right),
					RECORD,except dt_first_seen,dt_last_seen, dt_vendor_first_reported,dt_vendor_last_reported,bus_zip4,local);
					
dGroup      := group(sort(distribute(dROLLUP,hash(tmsid,rmsid)),
                                       tmsid,rmsid,dt_first_seen,local),
			  			               tmsid,rmsid,local);

dOut        :=Project(dGroup,Trans_Rmsid(left,(string2) counter),local):persist(cluster.cluster_out+'persist::FBNV2::CORP2_CORP::Business');

export Mapping_FBN_CORP2_Business := dout;