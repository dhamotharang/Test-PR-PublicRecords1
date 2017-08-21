import ut,fbnv2,address,_validate;

dFiling			            := File_NY_xml;

layout_common.contact_AID tFiling(dFiling pInput)
   :=TRANSFORM
  
		    string  clean_address           := if(pInput.clean_owner_address='',pInput.clean_address,pInput.clean_owner_address);
							
			self.tmsid					    := pInput.fileid[1..3]+hash(pInput.DBAName);
			self.rmsid					    :=  pInput.FilingNumber ;
			self.dt_first_seen      		:= if(_validate.date.fIsValid((string) pInput.FilingDate), (integer) pInput.FilingDate,0); 
			self.dt_last_seen       		:= if(_validate.date.fIsValid((string) pInput.FilingDate), (integer) pInput.FilingDate,0); 
			self.dt_vendor_first_reported  	:= if(_validate.date.fIsValid((string) pInput.DateLastTrans), (integer) pInput.DateLastTrans,0); 
			self.dt_vendor_last_reported  	:= if(_validate.date.fIsValid((string) pInput.DateLastTrans), (integer) pInput.DateLastTrans,0); 
			self.contact_type	    		:= 'O';
			self.contact_name_format		:= IF(pinput.pname='','C','P');
			self.contact_name			    := pInput.Ownerflname ;
			self.contact_addr 				:= IF(pInput.Owneraddress='',pInput.BusAddress,pInput.Owneraddress);
			self.contact_CITY          		:= IF(pInput.Owneraddress='',pInput.BusCITY,pInput.OWNERCITY );         
			self.contact_STATE          	:= IF(pInput.Owneraddress='',pInput.BusSTATE,pInput.OWNERSTATE  );    
			self.contact_ZIP          		:=  (integer)IF(pInput.Owneraddress='',pInput.Buszip[1..5],pInput.ownerzip[1..5] ); 
			self.title						:=	pInput.pname[1..5];
			self.fname						:=	pInput.pname[6..25];
			self.mname						:=	pInput.pname[26..45];
			self.lname					    :=	pInput.pname[46..65];
			self.name_suffix				:=	pInput.pname[66..70];
			self.name_score			        :=	pInput.pname[71..73];
/*
			self.prim_range 				:=	clean_address[1..10];			
			self.predir 					:=	clean_address[11..12];			
			self.prim_name 					:=	clean_address[13..40];			
			self.addr_suffix				:=	clean_address[41..44];			
			self.postdir 					:=	clean_address[45..46];			
			self.unit_desig 				:=	clean_address[47..56];			
			self.sec_range 					:=	clean_address[57..64];			
			self.v_city_name 				:=	clean_address[90..114];			
			self.st 						:=	clean_address[115..116];			
			self.zip5 						:=	clean_address[117..121];			
			self.zip4 						:=	clean_address[122..125];			
			self.addr_rec_type				:=	clean_address[139..140];			
			self.fips_state 				:=	clean_address[141..142];			
			self.fips_county 				:=  clean_address[143..145];				
			self.geo_lat 					:=	clean_address[146..155];			
			self.geo_long 					:=	clean_address[156..166];			
			self.cbsa						:=	clean_address[167..170];			
			self.geo_blk 					:=	clean_address[171..177];			
			self.geo_match 					:=	clean_address[178];			
			self.err_stat 					:=	clean_address[179..182];
*/
			self.prep_addr_line1			:= address.Addr1FromComponents(
																					stringlib.stringtouppercase(trim(self.contact_addr,left,right))
																					,''
																					,''
																					,''
																					,''
																					,''
																					,'');
			self.prep_addr_line_last	:= address.Addr2FromComponents(
																					stringlib.stringtouppercase(trim(self.contact_CITY))
																					,stringlib.stringtouppercase(trim(self.contact_STATE))
																					,((STRING)self.contact_ZIP)[1..5]);
			self                := pinput;

	 end;
layout_common.contact_AID  rollupXform(layout_common.contact_AID pLeft, layout_common.contact_AID pRight) 
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

dOut    	:=rollup(dSort ,rollupXform(left,right),
					RECORD,except dt_first_seen,dt_last_seen, dt_vendor_first_reported,dt_vendor_last_reported,local)
					:persist(cluster.cluster_out+'persist::FBNV2::NY::contact::xml');
					
export Mapping_FBN_NY_Contact_xml := dout;