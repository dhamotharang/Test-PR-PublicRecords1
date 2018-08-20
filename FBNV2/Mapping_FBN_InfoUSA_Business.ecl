import ut,Census_Data,fbnv2,address,_validate;

dFiling			            := dedup(File_InfoUSA_in,all,except process_date);

layout_common.Business_AID tFiling(dFiling pInput)
   :=TRANSFORM
          
			/*self.tmsid					    := 'INF'+if(length(trim(pInput.BUS_PHONE_NUM))=10,HASH(pInput.BUS_PHONE_NUM),
														    hash(pInput.BUS_CITY+pInput.Bus_NAME));*/
			self.tmsid					    := 'INF'+hash(pInput.BUS_ZIP+pInput.Bus_NAME[1..25]);												
			self.rmsid                      :=  pInput.Bus_STATE+if(pInput.FILING_NUMBER<>'',hash(pInput.FILING_NUMBER),
			                                    if(pInput.FILing_DATE<>'',hash(pInput.FILing_DATE+pInput.BUS_ZIP),
												if(length(trim(pInput.BUS_PHONE_NUM))=10,hash(pInput.BUS_PHONE_NUM),hash(pInput.BUS_ZIP+pInput.Bus_NAME[1..25]))));
			self.dt_first_seen      		:= if(_validate.date.fIsValid((string) pInput.Filing_date), (integer) pInput.Filing_date,0); 
			self.dt_last_seen       		:= if(_validate.date.fIsValid((string) pInput.Filing_date), (integer) pInput.Filing_date,0); 
			self.dt_vendor_first_reported  	:= if(_validate.date.fIsValid((string) pInput.Process_date), (integer) pInput.Process_date,0); 
			self.dt_vendor_last_reported  	:= if(_validate.date.fIsValid((string) pInput.Process_date), (integer) pInput.Process_date,0); 
			self.Filing_Jurisdiction 		:= pInput.Bus_state;
			self.FILING_NUMBER 			    := pInput.FILING_NUMBER;
			self.Filing_date           		:= if(_validate.date.fIsValid((string) pInput.FILing_DATE), (integer) pInput.FILing_DATE,0);  
			self.filing_type                := pInput.filing_type;
			self.bus_status             	:= '';
			self.BUS_NAME 					:= pInput.Bus_NAME;
			SELF.LONG_BUS_NAME              := pInput.BUS_NAME;
			self.BUS_ADDRESS1 				:= pInput.BUS_STR_ADDR;
			self.BUS_CITY                 	:= pInput.Bus_CITY;
			self.BUS_COUNTY 				:= pInput.FIPS_CNTY_CODE;
			self.BUS_STATE               	:= pInput.Bus_STATE;
			self.BUS_PHONE_NUM              := pInput.BUS_PHONE_NUM;
			self.BUS_ZIP 					:= (integer) pInput.BUS_ZIP;
			self.BUS_ZIP4  					:= (integer) pInput.BUS_ZIP4;
			self.SIC_code			        := pInput.SIC_CODE;
			self.BUS_TYPE_DESC              := pInput.BUS_DESCRIPTION;
			self.MAIL_STREET  				:= pInput.BUS_STR_ADDR;
			self.MAIL_CITY 					:= pInput.BUS_CITY;
			self.MAIL_STATE 				:= pInput.BUS_STATE;
			self.MAIL_ZIP 					:= pInput.BUS_ZIP+pInput.BUS_ZIP4;
			self.SEQ_NO 					:= 0;
/*			
			self.prim_range 			  	:=	pInput.clean_address[1..10];			
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
			self.prep_addr_line1		 := address.Addr1FromComponents(
																					stringlib.stringtouppercase(trim(pInput.BUS_STR_ADDR,left,right))
																					,''
																					,''
																					,''
																					,''
																					,''
																					,'');
			self.prep_addr_line_last := address.Addr2FromComponents(
																					stringlib.stringtouppercase(trim(pInput.Bus_CITY))
																					,stringlib.stringtouppercase(trim(pInput.Bus_STATE))
																					,pInput.BUS_ZIP[1..5]);
			
			self.prep_mail_addr_line1		 := address.Addr1FromComponents(
																					stringlib.stringtouppercase(trim(pInput.BUS_STR_ADDR,left,right))
																					,''
																					,''
																					,''
																					,''
																					,''
																					,'');
			self.prep_mail_addr_line_last := address.Addr2FromComponents(
																					stringlib.stringtouppercase(trim(pInput.BUS_CITY))
																					,stringlib.stringtouppercase(trim(pInput.Bus_STATE))
																					,pInput.BUS_ZIP[1..5]);
																					
			self											:= pInput;
	 end;
	 

layout_common.Business_AID get_county(layout_common.Business_AID pLeft, Census_Data.Key_Fips2County pRight) := transform
  self.BUS_COUNTY := pRight.county_name;
  self := pLeft;
end;

layout_common.Business_AID Trans_Rmsid(layout_common.Business_AID pLeft,string2 c ) 
   :=
   TRANSFORM
     self.Rmsid                      :=if(trim(C,left,right)='1',pLeft.Rmsid,trim(C,left,right)+pLeft.Rmsid);
	 self                            :=pLeft;
	 end;
	 
layout_common.Business_AID  rollupXform(layout_common.Business_AID pLeft, layout_common.Business_AID pRight) 
	:= transform
		
		self.Dt_First_Seen := ut.Min2(pLeft.dt_First_Seen,pRight.dt_First_Seen);
		self.Dt_Last_Seen  := MAX(pLeft.dt_Last_Seen ,pRight.dt_last_seen);
		self.Dt_Vendor_First_Reported := ut.min2(pLeft.dt_Vendor_First_Reported,pRight.dt_Vendor_First_Reported);
		self.Dt_Vendor_Last_Reported  := MAX(pLeft.dt_Vendor_Last_Reported,pRight.dt_Vendor_Last_Reported);
	    self := pLeft;
	END;
	
dProj   	:= dedup(project(dfiling,tfiling(left)),all);
dGetCounty  := join(dProj,Census_Data.Key_Fips2County,
                        left.BUS_state = right.state_code and
                        left.BUS_COUNTY = right.county_fips,
						get_county(left, right));
						// +Mapping_FBN_InfoUSA_Business_Xml;
			
dSort       := SORT(Distribute(dGetCounty , hash(bus_name)), 
                   RECORD,except dt_first_seen,dt_last_seen, dt_vendor_first_reported,dt_vendor_last_reported,local); 
dROLLUP  	:= rollup(dSort ,rollupXform(left,right),
					RECORD,except dt_first_seen,dt_last_seen, dt_vendor_first_reported,dt_vendor_last_reported,local);
dGroup      :=  group(sort(distribute(dROLLUP,hash(tmsid,rmsid)),
                                       tmsid,rmsid,dt_first_seen,local),
			  			               tmsid,rmsid,local);
				
					
dout        := Project(dGroup ,Trans_Rmsid(left,(string2) counter),local)
				:PERSIST(Cluster.cluster_out+'persist::FBNV2::infousa::Business');

export Mapping_FBN_InfoUSA_Business := dOut;