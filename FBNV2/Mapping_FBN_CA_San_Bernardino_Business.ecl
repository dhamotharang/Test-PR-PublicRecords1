import ut,fbnv2,address,_validate;

dFiling			            := dedup(FBNV2.File_CA_San_Bernardino_xml(bus_name<>''),all);

layout_common.Business_AID tFiling(dFiling pInput)
   :=TRANSFORM
            self.tmsid					    := 'CAB'+trim(pInput.filing_number)+pInput.clean_address[1..10];
			self.rmsid					    :=  pInput.filing_type[1]+hash(pInput.bus_name);
			self.dt_first_seen      		:= if(_validate.date.fIsValid((string)pInput.Filing_date),(integer) pInput.FILing_DATE,0);
			self.dt_last_seen       		:= if(_validate.date.fIsValid((string)pInput.date_last_trans),(integer) pInput.date_last_trans,0);
			self.dt_vendor_first_reported  	:= if(_validate.date.fIsValid((string)pInput.date_last_trans),(integer) pInput.date_last_trans,0);
			self.dt_vendor_last_reported  	:= if(_validate.date.fIsValid((string)pInput.date_last_trans),(integer) pInput.date_last_trans,0);
			self.Filing_Jurisdiction        := 'CAB';
			self.FILING_NUMBER           	:= pInput.filing_number;           
			self.Filing_date                := if(_validate.date.fIsValid((string)pInput.Filing_date),(integer) pInput.FILing_DATE,0);          
			self.BUS_PHONE_NUM           	:= pInput.bus_PHONE ; 
			SELF.LONG_BUS_NAME              := pInput.BUS_NAME;
			self.BUS_ADDRESS1           	:= pInput.bus_ADDRESS;  
			self.BUS_STATE								:= 'CA';
			self.BUS_COUNTY								:= 'SAN BERNARDI';
			self.MAIL_Street                := Pinput.bus_ADDRESS; 
			self.Mail_CITY					:= pInput.Bus_CITY;
			self.Mail_state					:= pInput.Bus_state;
			self.Mail_zip					:= pInput.Bus_zip;
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
*/

			self.prep_addr_line1			:= address.Addr1FromComponents(
																					stringlib.stringtouppercase(trim(pInput.bus_ADDRESS,left,right))
																					,''
																					,''
																					,''
																					,''
																					,''
																					,'');
			self.prep_addr_line_last	:= address.Addr2FromComponents(
																					stringlib.stringtouppercase(trim(pInput.Bus_CITY ))
																					,stringlib.stringtouppercase(trim(pInput.Bus_state))
																					,pInput.Bus_zip[1..5]);

			self.prep_mail_addr_line1			:= address.Addr1FromComponents(
																					stringlib.stringtouppercase(trim(pInput.Bus_ADDRESS,left,right))
																					,''
																					,''
																					,''
																					,''
																					,''
																					,'');
			self.prep_mail_addr_line_last	:= address.Addr2FromComponents(
																					stringlib.stringtouppercase(trim(pInput.Bus_CITY ))
																					,stringlib.stringtouppercase(trim(pInput.Bus_STATE))
																					,pInput.Bus_zip[1..5]);

			self.bus_zip                    :=  (integer) pInput.bus_zip;
			self                            :=  pInput;
			self											:= [];

	 end;

layout_common.Business_AID  rollupXform(layout_common.Business_AID pLeft, layout_common.Business_AID pRight) 
	:= transform
		
		self.Dt_First_Seen := ut.Min2(pLeft.dt_First_Seen,pRight.dt_First_Seen);
		self.Dt_Last_Seen  := MAX(pLeft.dt_Last_Seen ,pRight.dt_last_seen);
		self.Dt_Vendor_First_Reported := ut.min2(pLeft.dt_Vendor_First_Reported,pRight.dt_Vendor_First_Reported);
		self.Dt_Vendor_Last_Reported  := MAX(pLeft.dt_Vendor_Last_Reported,pRight.dt_Vendor_Last_Reported);
	    self := pLeft;
	END;
	

dSortFiling	:=SORT(DISTRIBUTE(dedup(project(dfiling,tfiling(left)),all),hash(ORIG_FILING_NUMBER)),
                  RECORD,except dt_first_seen,dt_last_seen, dt_vendor_first_reported,dt_vendor_last_reported,bus_zip4,local);
dout        :=rollup(dSortFiling,rollupXform(left,right),
					RECORD,except dt_first_seen,dt_last_seen, dt_vendor_first_reported,dt_vendor_last_reported,bus_zip4,local)
					:persist(cluster.cluster_out+'persist::FBNV2::CA::San_Bernadino::Business');
					 
export Mapping_FBN_CA_San_Bernardino_Business      :=	dout 	; 