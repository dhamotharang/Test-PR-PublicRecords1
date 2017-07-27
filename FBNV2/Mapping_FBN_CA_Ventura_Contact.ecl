import ut,fbnv2;
		
dFiling			       := dedup(sort(File_CA_ventura_in(BUSINESS_NAME<>''),instrument_id,-process_date),all,except process_date);

layout_common.contact tFiling(dFiling pInput)
   :=TRANSFORM
            self.tmsid					    := 'CAV'+hasH(pInput.BUSINESS_NAME) ;
			self.rmsid					    :=  pINput.instrument_id;    
			self.dt_first_seen      		:= (integer) pInput.process_date ;
			self.dt_last_seen       		:= (integer) pInput.process_date ;
			self.dt_vendor_first_reported  	:= (integer) pInput.recorded_date ;
			self.dt_vendor_last_reported  	:= (integer) pInput.recorded_date ;
			self.contact_type	    		:= 'O';
			self.contact_NAME          		:= if(pInput.Cname='',trim(pInput.owner_firstname)+' '
			                                                      +trim(pInput.owner_name,left,right),
			                                                      pInput.cname);			
			self.contact_NAME_FORMAT        := if(pInput.pname='','C','P');
			self.contact_ADDR           	:= pInput.OWNER_ADDRESS;       
			self.contact_CITY          		:= pInput.OWNER_CITY ;         
			self.contact_STATE          	:= pInput.OWNER_STATE  ;       
			self.contact_ZIP          		:= (integer)pInput.owner_zipcode5  ;    
			self.title						:=	pInput.pname[1..5];
			self.fname						:=	pInput.pname[6..25];
			self.mname						:=	pInput.pname[26..45];
			self.lname					    :=	pInput.pname[46..65];
			self.name_suffix				:=	pInput.pname[66..70];
			self.name_score			        :=	pInput.pname[71..73];
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

	 end;

layout_common.contact  rollupXform(layout_common.contact pLeft, layout_common.contact pRight) 
	:= transform
		
		self.Dt_First_Seen := IF(pLeft.dt_First_Seen > pRight.dt_First_Seen, pRight.dt_First_Seen, pLeft.dt_First_Seen);
		self.Dt_Last_Seen  := IF(pLeft.dt_Last_Seen  < pRight.dt_Last_Seen,  pRight.dt_Last_Seen,  pLeft.dt_Last_Seen);
		self.Dt_Vendor_First_Reported := IF(pLeft.dt_Vendor_First_Reported > pRight.dt_Vendor_First_Reported, 
											pRight.dt_Vendor_First_Reported, pLeft.dt_Vendor_First_Reported);
		self.Dt_Vendor_Last_Reported  := IF(pLeft.dt_Vendor_Last_Reported  < pRight.dt_Vendor_Last_Reported,  
											pRight.dt_Vendor_Last_Reported, pLeft.dt_Vendor_Last_Reported);
		self := pLeft;
	END;
	
dSortFiling	:=SORT(DISTRIBUTE(dedup(project(dfiling,tfiling(left)),all),hash(tmsid))
					,RECORD,except dt_first_seen,dt_last_seen, dt_vendor_first_reported,dt_vendor_last_reported,local); 
					
dout        :=rollup(dSortFiling,rollupXform(left,right),
					RECORD,except dt_first_seen,dt_last_seen, dt_vendor_first_reported,dt_vendor_last_reported,local)
					:persist(cluster.cluster_in+'persist::FBNv2::CA::ventura::CONTACT');
export Mapping_FBN_CA_Ventura_Contact := dOut;