import ut,fbnv2,address,_validate;

dFiling			            := File_NY_xml;
layout_common.Business_AID tFiling(dFiling pInput)
   :=TRANSFORM
   
           
			self.tmsid					    := pInput.fileid[1..3]+hash(pInput.DBAName);
			self.rmsid					    :=  pInput.FilingNumber ;
			self.dt_first_seen      		:= if(_validate.date.fIsValid((string) pInput.FilingDate), (integer) pInput.FilingDate,0);
			self.dt_last_seen       		:= if(_validate.date.fIsValid((string) pInput.FilingDate), (integer) pInput.FilingDate,0);
			self.dt_vendor_first_reported  	:= if(_validate.date.fIsValid((string) pInput.DateLastTrans), (integer) pInput.DateLastTrans,0);
			self.dt_vendor_last_reported  	:= if(_validate.date.fIsValid((string) pInput.DateLastTrans), (integer) pInput.DateLastTrans,0);
			self.Filing_Jurisdiction 		:= pInput.fileid[1..3];
			self.FILING_NUMBER 			    := pInput.FilingNumber;
			self.Filing_date           		:= if(_validate.date.fIsValid((string) pInput.FilingDate), (integer) pInput.FilingDate,0);
			self.BUS_NAME 					:= pInput.DBAName;
			SELF.LONG_BUS_NAME              := pInput.DBAName;
			self.BUS_ADDRESS1 				:= pInput.Busaddress;
			self.BUS_CITY                 	:= pInput.busCITY;
			self.BUS_STATE               	:= pInput.BUSSTATE;
			self.BUS_ZIP 					:= (integer) pInput.BusZIP[1..5];
			self.BUS_ZIP4 					:= (integer) pInput.BusZIP[6..9];
			self.SEQ_NO 					:= 0;
			self.MAIL_STREET  				:= trim(pInput.Busaddress,right);
			self.MAIL_CITY 					:= pInput.BUSCITY;
			self.MAIL_STATE 				:= pInput.BUSState;
			self.MAIL_ZIP 					:= pInput.BUSZIP;
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
																					stringlib.stringtouppercase(trim(pInput.Busaddress,left,right))
																					,''
																					,''
																					,''
																					,''
																					,''
																					,'');
			self.prep_addr_line_last	:= address.Addr2FromComponents(
																					stringlib.stringtouppercase(trim(pInput.busCITY ))
																					,stringlib.stringtouppercase(trim(pInput.BUSSTATE))
																					,pInput.BusZIP[1..5]);

			self.prep_mail_addr_line1			:= address.Addr1FromComponents(
																					stringlib.stringtouppercase(trim(pInput.Busaddress,left,right))
																					,''
																					,''
																					,''
																					,''
																					,''
																					,'');
			self.prep_mail_addr_line_last	:= address.Addr2FromComponents(
																					stringlib.stringtouppercase(trim(pInput.busCITY ))
																					,stringlib.stringtouppercase(trim(pInput.BUSSTATE))
																					,pInput.BusZIP[1..5]);
																					
			self											:= pInput;

	 end;

layout_common.Business_AID Trans_Rmsid(layout_common.Business_AID pLeft,string2 c ) 
   :=
   TRANSFORM
     self.Rmsid                      :=if(trim(C,left,right)='1',pleft.rmsid,trim(C,left,right)+trim(pleft.rmsid));
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
	

dProj   	:=dedup(project(dfiling,tfiling(left)),all);
			
dSort       :=SORT(Distribute(dProj, hash(tmsid)),
                   RECORD,except dt_first_seen,dt_last_seen, dt_vendor_first_reported,dt_vendor_last_reported,local); 
drollup     :=rollup(dSort ,rollupXform(left,right),
					RECORD,except dt_first_seen,dt_last_seen, dt_vendor_first_reported,dt_vendor_last_reported,local);
				
dGroup      := group(sort(distribute(dROLLUP,hash(tmsid,rmsid)),
                                       tmsid,rmsid,dt_first_seen,local),
			  			               tmsid,rmsid,local);

dOut        :=Project(dGroup ,Trans_Rmsid(left,(string2) counter),local)
					:persist(cluster.cluster_out+'persist::FBNV2::NY::Business::xml');

export Mapping_FBN_NY_Business_xml := dOut;