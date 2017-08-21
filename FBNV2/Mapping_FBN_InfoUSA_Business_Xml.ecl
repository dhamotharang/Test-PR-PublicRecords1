import ut,Census_Data,fbnv2,address,_validate;

dFiling			            := File_InfoUSA_xml;


layout_common.Business_AID tFiling(dFiling pInput)
   :=TRANSFORM
          
			self.tmsid					    := 'INF'+hash(pInput.BUSZIP[1..5]+pInput.DBANAME[1..25]);												
				
			self.rmsid                      :=  pInput.BusSTATE+if(pInput.FILingDATE<>'',hash(pInput.FILingDATE+pInput.BUSZIP),
												if(length(trim(pInput.telephone))=10,hash(pInput.telephone),hash(pinput.BUSZIP[1..5]+pInput.DBANAME[1..25])));
		    self.dt_first_seen      		:= if(_validate.date.fIsValid((string) pInput.Filingdate), (integer) pInput.Filingdate,0); 
			self.dt_last_seen       		:= if(_validate.date.fIsValid((string) pInput.Filingdate), (integer) pInput.Filingdate,0); 
			self.dt_vendor_first_reported  	:= if(_validate.date.fIsValid((string) pInput.DateLastTrans), (integer) pInput.DateLastTrans,0); 
			self.dt_vendor_last_reported  	:= if(_validate.date.fIsValid((string) pInput.DateLastTrans), (integer) pInput.DateLastTrans,0); 
			self.Filing_Jurisdiction 		:= pInput.fileCode[2..3];
			self.Filing_Date           		:= if(_validate.date.fIsValid((string) pInput.FilingDate), (integer) pInput.FilingDate,0);  
			self.filing_type                := pInput.filingtype;
			self.bus_status             	:= '';
			self.BUS_NAME 					:= pInput.DBANAme;
			SELF.LONG_BUS_NAME              := pInput.DBANAme;
			self.BUS_ADDRESS1 				:= pInput.BUSADDRess;
			self.BUS_CITY                 	:= pInput.BusCITY;
			self.BUS_COUNTY 				:= pInput.county;
			self.BUS_STATE               	:= pInput.BusSTATE;
			self.Bus_phone_num              := pInput.telephone;
			self.BUS_ZIP 					:= (integer) pInput.BUSZIP[1..5];
			self.BUS_ZIP4  					:= (integer) pInput.BUSZIP[6..9];
			self.SIC_code			        := pInput.SIC;
			self.BUS_TYPE_DESC              := pInput.BusinessDesc;
			self.MAIL_STREET  				:= pInput.BUSADDRess;
			self.MAIL_CITY 					:= pInput.BUSCITY;
			self.MAIL_STATE 				:= pInput.BUSSTATE;
			self.MAIL_ZIP 					:= pInput.BUSZIP;
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
																					stringlib.stringtouppercase(trim(pInput.BUSADDRess,left,right))
																					,''
																					,''
																					,''
																					,''
																					,''
																					,'');
			self.prep_addr_line_last := address.Addr2FromComponents(
																					stringlib.stringtouppercase(trim(pInput.BusCITY))
																					,stringlib.stringtouppercase(trim(pInput.BusSTATE))
																					,pInput.BUSZIP[1..5]);
			
			self.prep_mail_addr_line1		 := address.Addr1FromComponents(
																					stringlib.stringtouppercase(trim(pInput.BUSADDRess,left,right))
																					,''
																					,''
																					,''
																					,''
																					,''
																					,'');
			self.prep_mail_addr_line_last := address.Addr2FromComponents(
																					stringlib.stringtouppercase(trim(pInput.BusCITY))
																					,stringlib.stringtouppercase(trim(pInput.BusSTATE))
																					,pInput.BUSZIP[1..5]);
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
			
dSort       := SORT(Distribute(dProj   , hash(bus_name)), 
                   RECORD,except dt_first_seen,dt_last_seen, dt_vendor_first_reported,dt_vendor_last_reported,local); 
dROLLUP  	:= rollup(dSort ,rollupXform(left,right),
					RECORD,except dt_first_seen,dt_last_seen, dt_vendor_first_reported,dt_vendor_last_reported,local);
dGroup      :=  group(sort(distribute(dROLLUP,hash(tmsid,rmsid)),
                                       tmsid,rmsid,dt_first_seen,local),
			  			               tmsid,rmsid,local);
				
					
dout        := Project(dGroup ,Trans_Rmsid(left,(string2) counter),local)
				:PERSIST(Cluster.cluster_out+'persist::FBNV2::infousa::Business::xml');;	  

export Mapping_FBN_InfoUSA_Business_xml := dOut;