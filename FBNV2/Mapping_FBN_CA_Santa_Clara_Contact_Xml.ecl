import ut,fbnv2,address,_validate;

dFiling			            := File_CA_Santa_clara_xml; 

string1 	CONTACT_TYPE			:='';
			

layout_common.contact_AID tFiling(dFiling pInput)
   :=TRANSFORM
            string17 orig_filing            := trim(if(pInput.FilingNumber='',pInput.AbandFileNo,pInput.FilingNumber));
			
		    string   filing_number			:= IF(pInput.AME=''and pInput.AbandFileNo='',pInput.FilingNumber,
			                                      IF(pInput.AbandFileNo='',pInput.AME,pInput.AbandFileNo));
			self.tmsid					    := 'CSC'+trim(orig_filing+pInput.filingdate[1..4],all);
			self.rmsid					    :=  filing_number;
			self.dt_first_seen      		:= if(_validate.date.fIsValid((string) pInput.FilingDate), (integer) pInput.FilingDate,0); 
			self.dt_last_seen       		:= (integer) IF(pInput.abandon_date='0' and pInput.FilingdateH='0'
															,if(_validate.date.fIsValid((string) pInput.FilingDate), (integer) pInput.FilingDate,0) 
															,if(pInput.abandon_date='0'
																				  ,if(_validate.date.fIsValid((string) pInput.FilingdateH), (integer) pInput.FilingdateH,0) 
																				  ,if(_validate.date.fIsValid((string) pInput.abandon_date), (integer) pInput.abandon_date,0))); 
			self.dt_vendor_first_reported  	:= if(_validate.date.fIsValid((string) pInput.DateLastTrans), (integer) pInput.DateLastTrans,0); 
			self.dt_vendor_last_reported  	:= if(_validate.date.fIsValid((string) pInput.DateLastTrans), (integer) pInput.DateLastTrans,0); 
		

		    self.contact_type	    		:= 'O';
			self.CONTACT_NAME_FORMAT        :=  IF(pInput.pname='','C','P');
			self.CONTACT_ADDr  			    := trim(pInput.Busaddress,right);
			self.CONTACT_CITY 				:= pInput.BUSCITY;
			self.CONTACT_STATE 				:= pInput.BUSState;
			self.CONTACT_ZIP 				:= (integer) pInput.BUSZIP;
			self.contact_status             :=  map(pInput.Abandon_Date <>'0'   => 'ABANDONED',
												   pInput.OwnerWDD <>'0'   => 'WITHDRAWN','ACTIVE');
			self.WITHDRAWAL_DATE            := if(_validate.date.fIsValid((string) pInput.OwnerWDD), (integer) pInput.OwnerWDD,0); 
			self.contact_name			    :=  pInput.ownerFlName ;
			self.title						:=	pInput.pName[1..5];
			self.fname						:=	pInput.pName[6..25];
			self.mname						:=	pInput.pName[26..45];
			self.lname					    :=	pInput.pName[46..65];
			self.name_suffix				:=	pInput.pName[66..70];
			self.name_score			        :=	pInput.pName[71..73];
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
			self.prep_addr_line1			:= address.Addr1FromComponents(
																					stringlib.stringtouppercase(trim(pInput.Busaddress,left,right))
																					,''
																					,''
																					,''
																					,''
																					,''
																					,'');
			self.prep_addr_line_last	:= address.Addr2FromComponents(
																					stringlib.stringtouppercase(trim(pInput.BUSCITY))
																					,stringlib.stringtouppercase(trim(pInput.BUSState))
																					,pInput.BUSZIP[1..5]);
			self                := pinput;
			self                := [];

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
					:persist(Cluster.cluster_out+'persist::FBNV2::CA::santa::contact::xml');
			
export Mapping_FBN_CA_Santa_Clara_Contact_xml := dOut;