import ut,fbnv2,address,_validate;

dFiling			            :=File_CA_Ventura_xml;

layout_common.Business_AID tFiling(dFiling pInput)
   :=TRANSFORM
            
            self.tmsid					    := 'CAV'+hasH(pInput.DBAName) ;
			self.rmsid					    := pINput.FilingNumber;    
			self.dt_first_seen      		:= if(_validate.date.fIsValid((string) pInput.FilingDate), (integer) pInput.FilingDate,0);
			self.dt_last_seen       		:= (integer) IF(pInput.abandon_date='0' and pInput.ExpirationDate='0'
																									,if(_validate.date.fIsValid((string) pInput.FilingDate), (integer) pInput.FilingDate,0)
																									,if(pInput.abandon_date='0'
																										,if(_validate.date.fIsValid((string) pInput.ExpirationDate), (integer) pInput.ExpirationDate,0)
																										,if(_validate.date.fIsValid((string) pInput.abandon_date), (integer) pInput.abandon_date,0)));
			self.dt_vendor_first_reported  	:= if(_validate.date.fIsValid((string) pInput.DateLastTrans), (integer) pInput.DateLastTrans,0); 
			self.dt_vendor_last_reported  	:= if(_validate.date.fIsValid((string) pInput.DateLastTrans), (integer) pInput.DateLastTrans,0); 
			self.Filing_Jurisdiction        := 'CAV';	
			self.FILING_NUMBER           	:= pINput.FilingNumber;           
			self.Filing_date                := if(_validate.date.fIsValid((string) pInput.FilingDate), (integer) pInput.FilingDate,0);  
			self.cancellation_date          := if(pInput.DateLastTrans<'2007'
																						,if(_validate.date.fIsValid((string) pInput.abandon_date), (integer) pInput.abandon_date,0)
																						,0);
			self.expiration_date            := if(_validate.date.fIsValid((string) pInput.ExpirationDate), (integer) pInput.ExpirationDate,0);
			self.BUS_NAME           		:= pInput.DBANAME ;  
			SELF.LONG_BUS_NAME              := pInput.DBANAME;
			self.BUS_ADDRESS1           	:= pInput.busAddress;             
			self.BUS_CITY                   := pInput.busCITY; 
			self.BUS_STATE                  := 'CA';
			self.BUS_COUNTY								:= 'VENTURA';
			self.bus_status             	:= IF(pInput.abandon_date<>'','INACTIVE','ACTIVE');
			self.BUS_ZIP           			:= (integer)pInput.busZIP[1..5] ;  
			self.BUS_ZIP4                   := (integer)pInput.busZIP[6..9] ;  
			self.bus_comm_dATE              := if(_validate.date.fIsValid((string) pInput.BusCommDate), (integer) pInput.BusCommDate,0); 
/*
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
*/
			self.MAIL_STREET				:=  pInput.Maddress;
		    self.MAIL_CITY				    :=  pInput.mCITY;
			self.MAIL_STATE				    :=  pInput.mSTATE;
			self.MAIL_ZIP				    :=  pInput.mZIP;
/*			
			SELF.Mail_prim_range 			:=	pInput.clean_maddress[1..10];			
			SELF.Mail_predir 				:=	pInput.clean_maddress[11..12];			
			SELF.Mail_prim_name 			:=	pInput.clean_maddress[13..40];			
			SELF.Mail_addr_suffix			:=	pInput.clean_maddress[41..44];			
			SELF.Mail_postdir 				:=	pInput.clean_maddress[45..46];			
			SELF.Mail_unit_desig 			:=	pInput.clean_maddress[47..56];			
			SELF.Mail_sec_range 			:=	pInput.clean_maddress[57..64];			
			SELF.Mail_v_city_name 			:=	pInput.clean_maddress[90..114];			
			SELF.Mail_st 					:=	pInput.clean_maddress[115..116];			
			SELF.Mail_zip5 					:=	pInput.clean_maddress[117..121];			
			SELF.Mail_zip4 					:=	pInput.clean_maddress[122..125];			
			SELF.Mail_addr_rec_type			:=	pInput.clean_maddress[139..140];			
			SELF.Mail_fips_state 			:=	pInput.clean_maddress[141..142];			
			SELF.Mail_fips_county 			:=  pInput.clean_maddress[143..145];				
			SELF.Mail_geo_lat 				:=	pInput.clean_maddress[146..155];			
			SELF.Mail_geo_long 				:=	pInput.clean_maddress[156..166];			
			SELF.Mail_cbsa					:=	pInput.clean_maddress[167..170];			
			SELF.Mail_geo_blk 				:=	pInput.clean_maddress[171..177];			
			SELF.Mail_geo_match 			:=	pInput.clean_maddress[178];			
			SELF.Mail_err_stat 				:=	pInput.clean_maddress[179..182];
*/
			self.prep_addr_line1			:= address.Addr1FromComponents(
																					stringlib.stringtouppercase(trim(pInput.busAddress,left,right))
																					,''
																					,''
																					,''
																					,''
																					,''
																					,'');
			self.prep_addr_line_last	:= address.Addr2FromComponents(
																					stringlib.stringtouppercase(trim(pInput.busCITY ))
																					,stringlib.stringtouppercase(trim(self.BUS_STATE))
																					,pInput.busZIP[1..5]);

			self.prep_mail_addr_line1			:= address.Addr1FromComponents(
																					stringlib.stringtouppercase(trim(pInput.Maddress,left,right))
																					,''
																					,''
																					,''
																					,''
																					,''
																					,'');
			self.prep_mail_addr_line_last	:= address.Addr2FromComponents(
																					stringlib.stringtouppercase(trim(pInput.mCITY ))
																					,stringlib.stringtouppercase(trim(pInput.mSTATE))
																					,pInput.mZIP[1..5]);
			self.seq_no                     :=  0;
			self								:= pinput;
			self								:= [];

	 end;

layout_common.Business_AID  rollupXform(layout_common.Business_AID pLeft, layout_common.Business_AID pRight) 
	:= transform
		self.Dt_First_Seen := ut.Min2(pLeft.dt_First_Seen,pRight.dt_First_Seen);
		self.Dt_Last_Seen  := MAX(pLeft.dt_Last_Seen ,pRight.dt_last_seen);
		self.Dt_Vendor_First_Reported := ut.min2(pLeft.dt_Vendor_First_Reported,pRight.dt_Vendor_First_Reported);
		self.Dt_Vendor_Last_Reported  := MAX(pLeft.dt_Vendor_Last_Reported,pRight.dt_Vendor_Last_Reported);
	    self := pLeft;
	END;

layout_common.Business_AID Trans_Rmsid(layout_common.Business_AID pLeft,string2  c ) 
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
					:persist(cluster.cluster_out+'persist::FBNV2::CA::Ventura::Business::xml');

export Mapping_FBN_CA_Ventura_business_xml :=dOut  ;