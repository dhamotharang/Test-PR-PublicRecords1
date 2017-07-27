import ut,fbnv2;

dFiling			            := dedup(sort(File_CA_ventura_in( BUSINESS_NAME<>''),instrument_id,-process_date),all,except process_date);

layout_common.Business tFiling(dFiling pInput)
   :=TRANSFORM
            
            self.tmsid					    := 'CAV'+hasH(pInput.BUSINESS_NAME) ;
			self.rmsid					    := pINput.instrument_id;    
			self.dt_first_seen      		:= (integer) pInput.process_date ;
			self.dt_last_seen       		:= (integer) pInput.process_date ;
			self.dt_vendor_first_reported  	:= (integer) pInput.recorded_date ;
			self.dt_vendor_last_reported  	:= (integer) pInput.recorded_date ;
			self.Filing_Jurisdiction        := 'CAV';
			self.FILING_NUMBER           	:= pINput.instrument_id;           
			self.Filing_date                := (integer) pInput.recorded_date ;  
			self.cancellation_date          := if(pInput.process_date<'2007',(integer) pInput.abandondate,0);
			self.expiration_date            := if(pInput.process_date<'2007',0,(integer) pInput.abandondate);
			self.BUS_NAME           		:= pInput.BUSINESS_NAME ;  
			SELF.LONG_BUS_NAME              := pInput.BUSINESS_NAME;
			self.BUS_ADDRESS1           	:= pInput.business_street;             
			self.BUS_CITY                   := pInput.business_CITY;                
			self.BUS_STATE                  := pInput.business_STATE ;
			self.bus_status             	:= IF(pInput.abandondate<>'','INACTIVE','ACTIVE');
			self.BUS_ZIP           			:= (integer)pInput.business_ZIP5 ;           
			self.bus_comm_dATE              := (integer)pInput.start_date ;
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
			self.mail_prim_range 			:=	pInput.clean_mail_address[1..10];			
			self.mail_predir 				:=	pInput.clean_mail_address[11..12];			
			self.mail_prim_name 			:=	pInput.clean_mail_address[13..40];			
			self.mail_addr_suffix			:=	pInput.clean_mail_address[41..44];			
			self.mail_postdir 				:=	pInput.clean_mail_address[45..46];			
			self.mail_unit_desig 			:=	pInput.clean_mail_address[47..56];			
			self.mail_sec_range 			:=	pInput.clean_mail_address[57..64];			
			self.mail_v_city_name 			:=	pInput.clean_mail_address[90..114];			
			self.mail_st 					:=	pInput.clean_mail_address[115..116];			
			self.mail_zip5 					:=	pInput.clean_mail_address[117..121];			
			self.mail_zip4 					:=	pInput.clean_mail_address[122..125];			
			self.mail_addr_rec_type			:=	pInput.clean_mail_address[139..140];			
			self.mail_fips_state 			:=	pInput.clean_mail_address[141..142];			
			self.mail_fips_county 			:=  pInput.clean_mail_address[143..145];				
			self.mail_geo_lat 				:=	pInput.clean_mail_address[146..155];			
			self.mail_geo_long 				:=	pInput.clean_mail_address[156..166];			
			self.mail_cbsa					:=	pInput.clean_mail_address[167..170];			
			self.mail_geo_blk 				:=	pInput.clean_mail_address[171..177];			
			self.mail_geo_match 			:=	pInput.clean_mail_address[178];			
			self.mail_err_stat 				:=	pInput.clean_mail_address[179..182];
			self.seq_no                     :=  (integer) pINput.file_seq;

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

Layout_Common.Business Trans_Rmsid(Layout_Common.Business pLeft,string2  c ) 
   :=
   TRANSFORM
     self.Rmsid                      :=if(trim(C,left,right)='1',pLeft.rmsid,trim(C,left,right)+pLeft.rmsid);
	 self                            :=pLeft;
	 end;
	 
dSortFiling	:=SORT(DISTRIBUTE(dedup(project(dfiling,tfiling(left)),all),hash(tmsid)),
                  RECORD,except dt_first_seen,dt_last_seen, dt_vendor_first_reported,dt_vendor_last_reported,local);
				  
dRollup     :=rollup(dSortFiling,rollupXform(left,right),
				  RECORD,except dt_first_seen,dt_last_seen, dt_vendor_first_reported,dt_vendor_last_reported,local);

dGroup      :=group(sort(distribute(dRollup,hash(tmsid,rmsid)),
                                             tmsid,rmsid,dt_first_seen,local),
									         tmsid,rmsid,local);

dOut        :=Project(dGroup ,Trans_Rmsid(left,(string2) counter),local)	 
					:persist(cluster.cluster_out+'persist::FBNV2::CA::Ventura::Business');

export Mapping_FBN_CA_Ventura_Business :=dOut  ;