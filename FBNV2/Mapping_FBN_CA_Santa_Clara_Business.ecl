import ut,fbnv2;

dFiling			            := dedup(File_CA_Santa_clara_in,all);

layout_common.Business tFiling(dFiling pInput)
   :=TRANSFORM
            
			string17 orig_filing            := trim(if(pInput.ORIG_FBN_NUM='',pInput.FBN_NUM,pInput.ORIG_FBN_NUM));
			string8  orig_filing_date       := if(pInput.ORIG_FBN_NUM='',pInput.FILED_DATE,pInput.ORIG_filed_DATE);
		
			self.tmsid					    := 'CSC'+trim(orig_filing+orig_filing_date[1..4],all);
			self.rmsid					    :=  pInput.FBN_NUM;
			self.dt_first_seen      		:= (integer) pInput.Process_date;
			self.dt_last_seen       		:= (integer) pInput.Process_date;
			self.dt_vendor_first_reported  	:= (integer) pInput.Process_date;
			self.dt_vendor_last_reported  	:= (integer) pInput.Process_date;
			self.Filing_Jurisdiction 		:= 'CSC';
			self.FILING_NUMBER 			    := pInput.FBN_NUM ;
			self.Filing_date           		:= (integer)pInput.FILED_DATE ; 
			self.ORIG_FILING_NUMBER 		:= orig_filing ;
			self.ORIG_FILING_DATE     		:= (integer) orig_filing_date;
			self.bus_status             	:= IF(pInput.fBN_type = 'A','ABANDONED','ACTIVE');
			self.CANCELLATION_DATE          := IF(pInput.fBN_type = 'A', (integer) pInput.filed_date,0);
			self.BUS_NAME 					:= pInput.Business_NAME;
			SELF.LONG_BUS_NAME              := pInput.BUSINESS_NAME;
			self.BUS_ADDRESS1 				:= pInput.Business_ADDR1;
			self.BUS_ADDRESS2 				:= pInput.Business_ADDR2;
			self.BUS_CITY                 	:= pInput.Bus_CITY;
			//self.BUS_COUNTY 				:= pInput.Business_COUNTY;
			self.BUS_STATE               	:= pInput.Bus_ST;
			self.BUS_ZIP 					:= (integer) pInput.BUS_ZIP[1..5];
			self.BUS_ZIP4  					:= (integer) pInput.BUS_ZIP[6..9];
			//self.BUS_COUNTRY  				:= pInput.Business_COUNTRY;
			self.MAIL_STREET  				:= trim(pInput.Business_ADDR1,right)+' '+trim(pInput.Business_ADDR2,right);
			self.MAIL_CITY 					:= pInput.BUS_CITY;
			self.MAIL_STATE 				:= pInput.BUS_ST;
			self.MAIL_ZIP 					:= pInput.BUS_ZIP;
			self.SEQ_NO 					:= 0;
			self.prim_range 				:=	pInput.clean_address[1..10];			
			self.predir 					:=	pInput.clean_address[11..12];			
			self.prim_name 					:=	pInput.clean_address[13..40];			
			self.addr_suffix				:=	pInput.clean_address[41..44];			
			self.postdir 					:=	pInput.clean_address[45..46];			
			self.unit_desig 				:=	pInput.clean_address[47..56];			
			self.sec_range 					:=	pInput.clean_address[57..64];			
			self.v_city_name 				:=	pInput.clean_address[90..114];			
			self.st 						:=	pInput.clean_address[115..116];			
			self.zip5 						:=	pInput.clean_address[117..121];			
			self.zip4 						:=	pInput.clean_address[122..125];			
			self.addr_rec_type				:=	pInput.clean_address[139..140];			
			self.fips_state 				:=	pInput.clean_address[141..142];			
			self.fips_county 				:=  pInput.clean_address[143..145];				
			self.geo_lat 					:=	pInput.clean_address[146..155];			
			self.geo_long 					:=	pInput.clean_address[156..166];			
			self.cbsa						:=	pInput.clean_address[167..170];			
			self.geo_blk 					:=	pInput.clean_address[171..177];			
			self.geo_match 					:=	pInput.clean_address[178];			
			self.err_stat 					:=	pInput.clean_address[179..182];	
			self.mail_prim_range 			:=	pInput.clean_address[1..10];		
			self.mail_predir 				:=	pInput.clean_address[11..12];		
			self.mail_prim_name 			:=	pInput.clean_address[13..40];		
			self.mail_addr_suffix			:=	pInput.clean_address[41..44];		
			self.mail_postdir 				:=	pInput.clean_address[45..46];		
			self.mail_unit_desig 			:=	pInput.clean_address[47..56];		
			self.mail_sec_range 			:=	pInput.clean_address[57..64];		
			self.mail_v_city_name 			:=	pInput.clean_address[90..114];		
			self.mail_st 					:=	pInput.clean_address[115..116];		
			self.mail_zip5 					:=	pInput.clean_address[117..121];		
			self.mail_zip4 					:=	pInput.clean_address[122..125];		
			self.mail_addr_rec_type			:=	pInput.clean_address[139..140];		
			self.mail_fips_state 			:=	pInput.clean_address[141..142];		
			self.mail_fips_county 			:=  pInput.clean_address[143..145];			
			self.mail_geo_lat 				:=	pInput.clean_address[146..155];		
			self.mail_geo_long 				:=	pInput.clean_address[156..166];		
			self.mail_cbsa					:=	pInput.clean_address[167..170];		
			self.mail_geo_blk 				:=	pInput.clean_address[171..177];		
			self.mail_geo_match 			:=	pInput.clean_address[178];		
			self.mail_err_stat 				:=	pInput.clean_address[179..182];	


	 end;

layout_common.Business tAddSeq(layout_common.Business pInput ,integer c)	
	:=transform
			self.seq_no	:=c;
			self		:=pinput;
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
	

dProj   	:=dedup(project(dfiling,tfiling(left)),all);
			
dSort       :=SORT(Distribute(dProj, hash(Orig_filing_number)),
                   RECORD,except dt_first_seen,dt_last_seen, dt_vendor_first_reported,dt_vendor_last_reported,local); 
dRollup     :=rollup(dSort ,rollupXform(left,right),
					RECORD,except dt_first_seen,dt_last_seen, dt_vendor_first_reported,dt_vendor_last_reported,local);
dGroup      :=group(sort(distribute(dRollup,hash(ORIG_FILING_NUMBER))
					,ORIG_FILING_NUMBER,filing_date,seq_no, local)
			   ,ORIG_FILING_NUMBER);
			   
dOut        :=Project(dgroup,tAddSeq(left, counter)):persist(Cluster.cluster_out+'persist::FBNV2::CA::santa::Business');


export Mapping_FBN_CA_Santa_Clara_Business := dOut;