import ut,fbnv2;

dFiling			            := dedup(FBNV2.File_CA_San_Bernardino_xml(bus_name<>''),all);

layout_common.contact tFiling(dFiling pInput)
   :=TRANSFORM
            self.tmsid					    := 'CAB'+trim(pInput.filing_number)+pInput.clean_address[1..10];
			self.rmsid					    :=  pInput.filing_type[1]+hash(pInput.bus_name);
			self.dt_first_seen      		:= (integer) pInput.filing_date;
			self.dt_last_seen       		:= (integer) pInput.filing_date;
			self.dt_vendor_first_reported  	:= (integer) pInput.filing_date;
			self.dt_vendor_last_reported  	:= (integer) pInput.filing_date;
			self.contact_type	    		:= 'O';
			self.contact_NAME          		:= if(pInput.owner_fl_name='',trim(pInput.owner_first_name)+' '
			                                                       +trim(pInput.owner_last_name,left,right),
			                                                      pInput.owner_fl_name);			
			self.contact_NAME_FORMAT        := if(pInput.clean_name='','C','P');
			self.contact_ADDR           	:= pInput.owner_address;       
			self.contact_CITY          		:= pInput.OWNER_CITY ;         
			self.contact_STATE          	:= pInput.OWNER_STATE  ;       
			self.contact_ZIP          		:= (integer)pInput.OWNER_ZIP ;    
			self.SEQ_NO           			:= 0; 
			self.title						:=	pInput.clean_name[1..5];
			self.fname						:=	pInput.clean_name[6..25];
			self.mname						:=	pInput.clean_name[26..45];
			self.lname					    :=	pInput.clean_name[46..65];
			self.name_suffix				:=	pInput.clean_name[66..70];
			self.name_score			        :=	pInput.clean_name[71..73];
			self.prim_range 				:=	pInput.clean_ow_address[1..10];			
			self.predir 					:=	pInput.clean_ow_address[11..12];			
			self.prim_name 					:=	pInput.clean_ow_address[13..40];			
			self.addr_suffix				:=	pInput.clean_ow_address[41..44];			
			self.postdir 					:=	pInput.clean_ow_address[45..46];			
			self.unit_desig 				:=	pInput.clean_ow_address[47..56];			
			self.sec_range 					:=	pInput.clean_ow_address[57..64];			
			self.v_city_name 				:=	pInput.clean_ow_address[90..114];			
			self.st 						:=	pInput.clean_ow_address[115..116];			
			self.zip5 						:=	pInput.clean_ow_address[117..121];			
			self.zip4 						:=	pInput.clean_ow_address[122..125];			
			self.addr_rec_type				:=	pInput.clean_ow_address[139..140];			
			self.fips_state 				:=	pInput.clean_ow_address[141..142];			
			self.fips_county 				:=  pInput.clean_ow_address[143..145];				
			self.geo_lat 					:=	pInput.clean_ow_address[146..155];			
			self.geo_long 					:=	pInput.clean_ow_address[156..166];			
			self.cbsa						:=	pInput.clean_ow_address[167..170];			
			self.geo_blk 					:=	pInput.clean_ow_address[171..177];			
			self.geo_match 					:=	pInput.clean_ow_address[178];			
			self.err_stat 					:=	pInput.clean_ow_address[179..182];		

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
					:persist(cluster.cluster_in+'persist::FBNv2::CA::San_Bernardino::CONTACT');

					 
export Mapping_FBN_CA_San_Bernardino_contact      :=	dOut; 