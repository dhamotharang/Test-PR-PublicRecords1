import ut,fbnv2;
	

dFiling			            := dedup(FBNV2.File_TX_Dallas_xml(filingnumber<>'' ),all);

layout_common.Business tFiling(dFiling pInput)
   :=TRANSFORM
            
			
			self.tmsid					    := 'TXD'+ pInput.filingNumber;
			self.rmsid                      := ''+if(pInput.FILingNUMBER<>'',hash(pInput.FILingNUMBER+pinput.BUSADDRESS),
			                                    			if(pInput.filingDATE<>'',hash(pInput.filingDATE+pinput.BUSADDRESS),hash(pinput.BUSADDRESS)));
			self.dt_first_seen      		:= (integer) pInput.filingdate ;
			self.dt_last_seen       		:= (integer) pInput.filingdate ;
			self.dt_vendor_first_reported  	:= (integer) pInput.filingdate ;
			self.dt_vendor_last_reported  	:= (integer) pInput.filingdate ;
			self.Filing_Jurisdiction        := 'TXD';
			self.FILING_NUMBER           	:= pInput.FILingNUMBER;           
			self.Filing_date                := (integer) pInput.filingdate ;          
			self.BUS_NAME           		:= pInput.dbaName ;      
			self.BUS_ADDRESS1           	:= pInput.Busaddress; 
            SELF.LONG_BUS_NAME              := pInput.dbaNAME;
			self.BUS_CITY                   := pInput.BusCity;                
			self.BUS_STATE                  := pInput.BusSTATE ;              
			self.BUS_ZIP           			:= (integer)pInput.BusZIP[1..5] ; 
			self.BUS_ZIP4           		:= (integer)pInput.BusZIP[6..9] ; 
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
	
Layout_Common.Business Trans_Rmsid(Layout_Common.Business pLeft,string2 c ) 
   :=
   TRANSFORM
     self.Rmsid                      :=if(trim(C,left,right)='1',pleft.rmsid,trim(C,left,right)+trim(pleft.rmsid));
	 self                            :=pLeft;
	 end;
	 
dSortFiling	:=SORT(DISTRIBUTE(dedup(project(dfiling,tfiling(left)),all),hash(ORIG_FILING_NUMBER)),
                  RECORD,except dt_first_seen,dt_last_seen, dt_vendor_first_reported,dt_vendor_last_reported,bus_zip4,local);
dROLLUP     :=rollup(dSortFiling,rollupXform(left,right),
					RECORD,except dt_first_seen,dt_last_seen, dt_vendor_first_reported,dt_vendor_last_reported,bus_zip4,local);
					
dGroup      := group(sort(distribute(dROLLUP,hash(tmsid,rmsid)),
                                       tmsid,rmsid,dt_first_seen,local),
			  			               tmsid,rmsid,local);

dOut        :=Project(dGroup ,Trans_Rmsid(left,(string2) counter),local):persist(cluster.cluster_out+'persist::FBNV2::TXD::Business');					 
export Mapping_FBN_TXD_Business := dout ;