import ut,fbnv2;

dFiling			            := dedup(File_TX_Harris_in(file_number<>''),all);

layout_common.contact tFiling(dFiling pInput)
   :=TRANSFORM
   
            string date                     :=pInput.DATE_FILED[5..8]+pInput.DATE_FILED[3..4]+pInput.DATE_FILED[1..2];
			
			self.tmsid					    := 'TXH'+ hash(pInput.CITY1+pInput.NAME1);
			self.rmsid                      := 'T'+if(pInput.FILe_NUMBER<>'',hash(pInput.FILE_NUMBER),
			                                    			if(DATE<>'',hash(DATE),hash(pInput.STREET_ADD1 )));
			
			self.dt_first_seen      		:= (integer) date ;
			self.dt_last_seen       		:= (integer) date ;
			self.dt_vendor_first_reported  	:= (integer) date ;
			self.dt_vendor_last_reported  	:= (integer) date ;
			self.contact_type	    		:= 'O';
			self.contact_NAME          		:= pInput.name2;			
			self.contact_NAME_FORMAT        := if(pInput.pname='','C','P');
			self.contact_ADDR           	:= pInput.STREET_ADD2;        
			self.contact_CITY          		:= pInput.CITY2;            
			self.contact_STATE          	:= pInput.STATE2 ;      
			self.contact_ZIP          		:= (integer)pInput.ZIP2 ;     
			self.title						:=	pInput.pname[1..5];
			self.fname						:=	pInput.pname[6..25];
			self.mname						:=	pInput.pname[26..45];
			self.lname					    :=	pInput.pname[46..65];
			self.name_suffix				:=	pInput.pname[66..70];
			self.name_score			        :=	pInput.pname[71..73];
			self.prim_range 				:=	pInput.clean_address1[1..10];			
			self.predir 					:=	pInput.clean_address1[11..12];			
			self.prim_name 					:=	pInput.clean_address1[13..40];			
			self.addr_suffix				:=	pInput.clean_address1[41..44];			
			self.postdir 					:=	pInput.clean_address1[45..46];			
			self.unit_desig 				:=	pInput.clean_address1[47..56];			
			self.sec_range 					:=	pInput.clean_address1[57..64];			
			self.v_city_name 				:=	pInput.clean_address1[90..114];			
			self.st 						:=	pInput.clean_address1[115..116];			
			self.zip5 						:=	pInput.clean_address1[117..121];			
			self.zip4 						:=	pInput.clean_address1[122..125];			
			self.addr_rec_type				:=	pInput.clean_address1[139..140];			
			self.fips_state 				:=	pInput.clean_address1[141..142];			
			self.fips_county 				:=  pInput.clean_address1[143..145];				
			self.geo_lat 					:=	pInput.clean_address1[146..155];			
			self.geo_long 					:=	pInput.clean_address1[156..166];			
			self.cbsa						:=	pInput.clean_address1[167..170];			
			self.geo_blk 					:=	pInput.clean_address1[171..177];			
			self.geo_match 					:=	pInput.clean_address1[178];			
			self.err_stat 					:=	pInput.clean_address1[179..182];	
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
					:persist(cluster.cluster_in+'persist::FBNV2::TXH::CONTACT');
export Mapping_FBN_TX_Harris_Contact :=dOut;