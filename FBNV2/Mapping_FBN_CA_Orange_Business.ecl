import ut,fbnv2;

dFiling			            := dedup(File_CA_Orange_in,all);

layout_common.Business tFiling(dFiling pInput)
   :=TRANSFORM
            self.tmsid					    := 'CAO'+hash(pInput.BUSINESS_NAME);
			self.rmsid					    :=  pInput.REGIS_NBR+pInput.Business_letter;
			self.dt_first_seen      		:= (integer) pInput.FILE_DATE;
			self.dt_last_seen       		:= (integer) pInput.Process_date;
			self.dt_vendor_first_reported  	:= (integer) pInput.Process_date;
			self.dt_vendor_last_reported  	:= (integer) pInput.Process_date;
			self.Filing_Jurisdiction        := 'CAO';
			self.FILING_NUMBER           	:= pInput.REGIS_NBR;           
			self.Filing_date                := (integer) pInput.FILE_DATE ;          
			self.BUS_NAME           		:= pInput.BUSINESS_NAME ;
			SELF.LONG_BUS_NAME              := pInput.BUSINESS_NAME;
			self.BUS_PHONE_NUM           	:= stringlib.stringfilter(pInput.PHONE_NBR,'0123456789') ;          
			self.BUS_ADDRESS1           	:= pInput.ADDRESS;             
			self.BUS_CITY                   := pInput.CITY;                
			self.BUS_STATE                  := pInput.STATE ;              
			self.BUS_ZIP           			:= (integer)pInput.ZIP_CODE[1..5] ; 
			self.BUS_ZIP4          			:= (integer)pInput.ZIP_CODE[6..9] ;
			self.SEQ_NO           			:= (integer)pInput.BUSINESS_LETTER ;  
			self.prim_range 				:=	pInput.clean_Business_address[1..10];			
			self.predir 					:=	pInput.clean_Business_address[11..12];			
			self.prim_name 					:=	pInput.clean_Business_address[13..40];			
			self.addr_suffix				:=	pInput.clean_Business_address[41..44];			
			self.postdir 					:=	pInput.clean_Business_address[45..46];			
			self.unit_desig 				:=	pInput.clean_Business_address[47..56];			
			self.sec_range 					:=	pInput.clean_Business_address[57..64];			
			self.v_city_name 				:=	pInput.clean_Business_address[90..114];			
			self.st 						:=	pInput.clean_Business_address[115..116];			
			self.zip5 						:=	pInput.clean_Business_address[117..121];			
			self.zip4 						:=	pInput.clean_Business_address[122..125];			
			self.addr_rec_type				:=	pInput.clean_Business_address[139..140];			
			self.fips_state 				:=	pInput.clean_Business_address[141..142];			
			self.fips_county 				:=  pInput.clean_Business_address[143..145];				
			self.geo_lat 					:=	pInput.clean_Business_address[146..155];			
			self.geo_long 					:=	pInput.clean_Business_address[156..166];			
			self.cbsa						:=	pInput.clean_Business_address[167..170];			
			self.geo_blk 					:=	pInput.clean_Business_address[171..177];			
			self.geo_match 					:=	pInput.clean_Business_address[178];			
			self.err_stat 					:=	pInput.clean_Business_address[179..182];
			self.mail_prim_range 			:=	pInput.clean_Business_address[1..10];			
			self.mail_predir 				:=	pInput.clean_Business_address[11..12];			
			self.mail_prim_name 			:=	pInput.clean_Business_address[13..40];			
			self.mail_addr_suffix			:=	pInput.clean_Business_address[41..44];			
			self.mail_postdir 				:=	pInput.clean_Business_address[45..46];			
			self.mail_unit_desig 			:=	pInput.clean_Business_address[47..56];			
			self.mail_sec_range 			:=	pInput.clean_Business_address[57..64];			
			self.mail_v_city_name 			:=	pInput.clean_Business_address[90..114];			
			self.mail_st 					:=	pInput.clean_Business_address[115..116];			
			self.mail_zip5 					:=	pInput.clean_Business_address[117..121];			
			self.mail_zip4 					:=	pInput.clean_Business_address[122..125];			
			self.mail_addr_rec_type			:=	pInput.clean_Business_address[139..140];			
			self.mail_fips_state 			:=	pInput.clean_Business_address[141..142];			
			self.mail_fips_county 			:=  pInput.clean_Business_address[143..145];				
			self.mail_geo_lat 				:=	pInput.clean_Business_address[146..155];			
			self.mail_geo_long 				:=	pInput.clean_Business_address[156..166];			
			self.mail_cbsa					:=	pInput.clean_Business_address[167..170];			
			self.mail_geo_blk 				:=	pInput.clean_Business_address[171..177];			
			self.mail_geo_match 			:=	pInput.clean_Business_address[178];			
			self.mail_err_stat 				:=	pInput.clean_Business_address[179..182];

	 end;

layout_common.Business  rollupXform(layout_common.Business pLeft, layout_common.Business pRight) 
	:= transform
		
		self.Dt_First_Seen := IF(pLeft.dt_First_Seen > pRight.dt_First_Seen, pRight.dt_First_Seen, pLeft.dt_First_Seen);
		self.Dt_Last_Seen  := IF(pLeft.dt_Last_Seen  < pRight.dt_Last_Seen,  pRight.dt_Last_Seen,  pLeft.dt_Last_Seen);
		self.Dt_Vendor_First_Reported := IF(pLeft.dt_Vendor_First_Reported > pRight.dt_Vendor_First_Reported, 
											pRight.dt_Vendor_First_Reported, pLeft.dt_Vendor_First_Reported);
		self.Dt_Vendor_Last_Reported  := IF(pLeft.dt_Vendor_Last_Reported  < pRight.dt_Vendor_Last_Reported,  
											pRight.dt_Vendor_Last_Reported, pLeft.dt_Vendor_Last_Reported);
		self := pLeft;
	END;
	

dSortFiling	:=SORT(DISTRIBUTE(dedup(project(dfiling,tfiling(left)),all),hash(ORIG_FILING_NUMBER)),
                  RECORD,except dt_first_seen,dt_last_seen, dt_vendor_first_reported,dt_vendor_last_reported,local);
dout        :=rollup(dSortFiling,rollupXform(left,right),
					RECORD,except dt_first_seen,dt_last_seen, dt_vendor_first_reported,dt_vendor_last_reported,local)
					:persist(cluster.cluster_out+'persist::FBNV2::CA::Orange::Business');
					 
export Mapping_FBN_CA_Orange_Business      :=	dOut; 