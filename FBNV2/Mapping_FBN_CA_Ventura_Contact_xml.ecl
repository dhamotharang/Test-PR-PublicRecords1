import ut,fbnv2,address,_validate;
		
dFiling			       := File_CA_Ventura_xml;

layout_common.contact_AID tFiling(dFiling pInput)
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
			self.contact_type	    		:= 'O';
			self.contact_NAME          		:= if(pInput.Ownerflname='',trim(pInput.ownerfirstname)+' '
																	+trim(pInput.ownerMname)+' '
			                                                      +trim(pInput.ownerLastname,left,right),
			                                                      pInput.Ownerflname);			
			self.contact_NAME_FORMAT        := if(pInput.pname='','C','P');
			self.contact_ADDR           	:= pInput.OWNERADDRESS;       
			self.contact_CITY          		:= pInput.OWNERCITY ;         
			self.contact_STATE          	:= pInput.OWNERSTATE  ;       
			self.contact_ZIP          		:= (integer)pInput.ownerzip[1..5]  ;    
			self.title						:=	pInput.pname[1..5];
			self.fname						:=	pInput.pname[6..25];
			self.mname						:=	pInput.pname[26..45];
			self.lname					    :=	pInput.pname[46..65];
			self.name_suffix				:=	pInput.pname[66..70];
			self.name_score			        :=	pInput.pname[71..73];
/*			
			self.prim_range 				:=	pInput.clean_owner_address[1..10];			
			self.predir 					:=	pInput.clean_owner_address[11..12];			
			self.prim_name 					:=	pInput.clean_owner_address[13..40];			
			self.addr_suffix				:=	pInput.clean_owner_address[41..44];			
			self.postdir 					:=	pInput.clean_owner_address[45..46];			
			self.unit_desig 				:=	pInput.clean_owner_address[47..56];			
			self.sec_range 					:=	pInput.clean_owner_address[57..64];			
			self.v_city_name 				:=	pInput.clean_owner_address[90..114];			
			self.st 						:=	pInput.clean_owner_address[115..116];			
			self.zip5 						:=	pInput.clean_owner_address[117..121];			
			self.zip4 						:=	pInput.clean_owner_address[122..125];			
			self.addr_rec_type				:=	pInput.clean_owner_address[139..140];			
			self.fips_state 				:=	pInput.clean_owner_address[141..142];			
			self.fips_county 				:=  pInput.clean_owner_address[143..145];				
			self.geo_lat 					:=	pInput.clean_owner_address[146..155];			
			self.geo_long 					:=	pInput.clean_owner_address[156..166];			
			self.cbsa						:=	pInput.clean_owner_address[167..170];			
			self.geo_blk 					:=	pInput.clean_owner_address[171..177];			
			self.geo_match 					:=	pInput.clean_owner_address[178];			
			self.err_stat 					:=	pInput.clean_owner_address[179..182];
*/
			self.prep_addr_line1			:= address.Addr1FromComponents(
																					stringlib.stringtouppercase(trim(pInput.OWNERADDRESS,left,right))
																					,''
																					,''
																					,''
																					,''
																					,''
																					,'');
			self.prep_addr_line_last	:= address.Addr2FromComponents(
																					stringlib.stringtouppercase(trim(pInput.OWNERCITY))
																					,stringlib.stringtouppercase(trim(pInput.OWNERSTATE))
																					,pInput.ownerzip[1..5]);
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
	
dSortFiling	:=SORT(DISTRIBUTE(dedup(project(dfiling,tfiling(left)),all),hash(tmsid))
					,RECORD,except dt_first_seen,dt_last_seen, dt_vendor_first_reported,dt_vendor_last_reported,local); 
					
dout        :=rollup(dSortFiling,rollupXform(left,right),
					RECORD,except dt_first_seen,dt_last_seen, dt_vendor_first_reported,dt_vendor_last_reported,local)
					:persist(cluster.cluster_in+'persist::FBNv2::CA::ventura::CONTACT::xml');
export Mapping_FBN_CA_Ventura_Contact_xml := dOut;