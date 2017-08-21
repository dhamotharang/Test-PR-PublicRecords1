import ut,fbnv2;

contIn	  := FBNV2.File_CORP2_Cont_in(corp_key<>'');

dsRA 	  := fbnv2.File_CORP2_Corp_in(corp_key<>'',trim(corp_ra_name,left,right)<>'');

layout_common.contact_AID createFBN(contIn pInput)
   :=TRANSFORM
           			
			self.tmsid					    := pinput.corp_key;
			self.rmsid                      := ''+if(pInput.cont_filing_date<>'',
													 hash(pInput.cont_filing_date+pinput.cont_name),
			                                    	 if(pInput.corp_process_date<>'',
														hash(pInput.corp_process_date+pinput.cont_name),
														hash(pinput.cont_name)));
			self.dt_first_seen      		:= (integer) pInput.dt_first_seen;
			self.dt_last_seen       		:= (integer) pInput.dt_last_seen;
			self.dt_vendor_first_reported  	:= (integer) pInput.dt_vendor_first_reported;
			self.dt_vendor_last_reported  	:= (integer) pInput.dt_vendor_last_reported;		
			self.contact_type	    		:= if(regexfind('OWNER',pinput.cont_type_desc,nocase)=true,
												 'O',
												 'C');
			self.contact_name_format        := if(trim(pinput.cont_name,left,right)='',
													'C',
													'P');
			self.contact_name			    := pinput.cont_name;													
			self.contact_status    			:= pinput.cont_status_desc;
			self.contact_phone				:= pinput.cont_phone_number;															
			self.contact_addr 				:= pinput.cont_address_line1;																
			self.contact_city				:= pinput.cont_address_line2;													
			self.contact_state				:= pinput.cont_state;																										
			self.contact_zip				:= (integer)pinput.cont_address_line4;															
			self.contact_country			:= pinput.cont_address_line5;													
			self.contact_fei_num			:= (integer)pinput.cont_fein;
			self.contact_charter_num		:= pinput.corp_orig_sos_charter_nbr;
			self.ssn						:= pinput.cont_ssn;																
			self.seq_no						:= 0;
			self.withdrawal_date			:= if(pinput.cont_effective_cd='W',
												 (integer)pinput.cont_effective_date,
												 0);																																				 
			self.title						:= pInput.cont_title;
			self.fname						:= pInput.cont_fname;
			self.mname						:= pInput.cont_mname;
			self.lname					    := pInput.cont_lname;
			self.name_suffix				:= pInput.cont_name_suffix;
			self.name_score			        := pInput.cont_score;
/*
			self.prim_range 				:= pInput.cont_prim_range;
			self.predir 					:= pInput.cont_predir;			
			self.prim_name 					:= pInput.cont_prim_name;
			self.addr_suffix				:= pInput.cont_addr_suffix;
			self.postdir 					:= pInput.cont_postdir;
			self.unit_desig 				:= pInput.cont_unit_desig;
			self.sec_range 					:= pInput.cont_sec_range;
			self.v_city_name 				:= pInput.cont_v_city_name;
			self.st 						:= pInput.cont_state;
			self.zip5 						:= pInput.cont_zip5;
			self.zip4 						:= pInput.cont_zip4;
			self.addr_rec_type				:= pInput.cont_rec_type;
			self.fips_state 				:= pInput.cont_ace_fips_st;
			self.fips_county 				:= pInput.cont_county;
			self.geo_lat 					:= pInput.cont_geo_lat;
			self.geo_long 					:= pInput.cont_geo_long;
			self.cbsa						:= pInput.cont_msa;
			self.geo_blk 					:= pInput.cont_geo_blk;
			self.geo_match 					:= pInput.cont_geo_match;
			self.err_stat 					:= pInput.cont_err_stat;
*/
			self.prep_addr_line1			:= pInput.cont_prep_addr_line1;
			self.prep_addr_line_last	:= pInput.cont_prep_addr_last_line;
			self.did						:= pinput.did;
			self.bdid						:= pinput.bdid;
			end;
			
layout_common.contact_AID createFBN_RA(dsRA pInput)
   :=TRANSFORM
           			
			self.tmsid					    := pinput.corp_key;
			self.rmsid                      := ''+if(pInput.corp_filing_date<>'',
													 hash(pInput.corp_filing_date+pinput.corp_ra_name),
			                                    	 if(pInput.corp_process_date<>'',
														hash(pInput.corp_process_date+pinput.corp_ra_name),
														hash(pinput.corp_ra_name)));
			self.dt_first_seen      		:= (integer) pInput.dt_first_seen;
			self.dt_last_seen       		:= (integer) pInput.dt_last_seen;
			self.dt_vendor_first_reported  	:= (integer) pInput.dt_vendor_first_reported;
			self.dt_vendor_last_reported  	:= (integer) pInput.dt_vendor_last_reported;
			self.contact_type	    		:= 'G';  // Registered Agent
			self.contact_name_format        := if(trim(pinput.corp_ra_name,left,right)='',
													'C',
													'P');
			self.contact_name			    := trim(pinput.corp_ra_name,left,right);													
			self.contact_status    			:= pinput.corp_ra_effective_date;
			self.contact_phone				:= pinput.corp_ra_phone_number;																
			self.contact_addr 				:= trim(pinput.corp_ra_address_line1,left,right);																
			self.contact_city				:= trim(pinput.corp_ra_address_line2,left,right);													
			self.contact_state				:= pinput.corp_ra_state;																									
			self.contact_zip				:= (integer)trim(pinput.corp_ra_address_line4,left,right);															
			self.contact_country			:= trim(pinput.corp_ra_address_line5,left,right);
			self.contact_fei_num			:= (integer)pinput.corp_ra_fein;
			self.contact_charter_num		:= pinput.corp_orig_sos_charter_nbr;
			self.ssn						:= trim(pinput.corp_ra_ssn,left,right);																
			self.seq_no						:= 0;
			self.withdrawal_date			:= (integer)pinput.corp_ra_resign_date;							 
			self.title						:= pInput.corp_ra_title1;
			self.fname						:= pInput.corp_ra_fname1;
			self.mname						:= pInput.corp_ra_mname1;
			self.lname					    := pInput.corp_ra_lname1;
			self.name_suffix				:= pInput.corp_ra_name_suffix1;
			self.name_score			        := pInput.corp_ra_score1;
			self.prim_range 				:= pInput.corp_ra_prim_range;
			self.predir 					:= pInput.corp_ra_predir;			
			self.prim_name 					:= pInput.corp_ra_prim_name;
			self.addr_suffix				:= pInput.corp_ra_addr_suffix;
			self.postdir 					:= pInput.corp_ra_postdir;
			self.unit_desig 				:= pInput.corp_ra_unit_desig;
			self.sec_range 					:= pInput.corp_ra_sec_range;
			self.v_city_name 				:= pInput.corp_ra_v_city_name;
			self.st 						:= pInput.corp_ra_state;
			self.zip5 						:= pInput.corp_ra_zip5;
			self.zip4 						:= pInput.corp_ra_zip4;
			self.addr_rec_type				:= pInput.corp_ra_rec_type;
			self.fips_state 				:= pInput.corp_ra_ace_fips_st;
			self.fips_county 				:= pInput.corp_ra_county;
			self.geo_lat 					:= pInput.corp_ra_geo_lat;
			self.geo_long 					:= pInput.corp_ra_geo_long;
			self.cbsa						:= pInput.corp_ra_msa;
			self.geo_blk 					:= pInput.corp_ra_geo_blk;
			self.geo_match 					:= pInput.corp_ra_geo_match;
			self.err_stat 					:= pInput.corp_ra_err_stat;
			self.bdid						:= pinput.bdid;
			end;
			
layout_common.contact_AID  rollupXform(layout_common.contact_AID pLeft, layout_common.contact_AID pRight) 
	:= transform
		
		self.Dt_First_Seen := ut.Min2(pLeft.dt_First_Seen,pRight.dt_First_Seen);
		self.Dt_Last_Seen  := MAX(pLeft.dt_Last_Seen ,pRight.dt_last_seen);
		self.Dt_Vendor_First_Reported := ut.min2(pLeft.dt_Vendor_First_Reported,pRight.dt_Vendor_First_Reported);
		self.Dt_Vendor_Last_Reported  := MAX(pLeft.dt_Vendor_Last_Reported,pRight.dt_Vendor_Last_Reported);
		self := pLeft;
	END;

//Get the most current RA information for use in creating Contact record
ds2d  := distribute(dsRA,hash32(corp_key));
ds2s  := sort(ds2d,corp_key,-dt_last_seen,local);
ds2dd := dedup(ds2s,corp_key,local);

dsFBN		:= project(contIn,createFBN(left));                          
dist_dsFBN  := distribute(dsFBN,hash32(tmsid));
sort1_dsFBN := sort(dist_dsFBN,RECORD,local);
dedup_dsFBN := dedup(sort1_dsFBN,RECORD,local);
sort2_dsFBN := sort(dedup_dsFBN,RECORD,except dt_first_seen,dt_last_seen, dt_vendor_first_reported,dt_vendor_last_reported,contact_zip,local);

dRA_FBN		  := project(ds2dd,createFBN_RA(left));
dist_dRA_FBN  := distribute(dRA_FBN,hash32(tmsid));
sort1_dRA_FBN := sort(dist_dRA_FBN,RECORD,local);
dedup_dRA_FBN := dedup(sort1_dRA_FBN,RECORD,local);
sort2_dRA_FBN := sort(dedup_dRA_FBN,RECORD,except dt_first_seen,dt_last_seen, dt_vendor_first_reported,dt_vendor_last_reported,contact_zip,local);
			
dSortfbn     := sort(distribute(sort2_dsFBN + sort2_dRA_FBN,hash(tmsid)),
                   RECORD,except dt_first_seen,dt_last_seen, dt_vendor_first_reported,dt_vendor_last_reported,local); 

dOut    	 := rollup(dSortfbn ,rollupXform(left,right),
			   		 RECORD,except dt_first_seen,dt_last_seen, dt_vendor_first_reported,dt_vendor_last_reported,local)
					 :persist(cluster.cluster_out+'persist::FBNV2::CORP2_CONT::Contact');
					
export Mapping_FBN_CORP2_Contact := dout;
