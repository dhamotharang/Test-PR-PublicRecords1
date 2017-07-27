import ut,fbnv2;

dFiling			            := dedup(File_CA_Santa_clara_in,all);
//There is no owner address instead of using business Address
layout_common.contact tFiling(dFiling pInput)
   :=TRANSFORM
            string17 orig_filing            := trim(if(pInput.ORIG_FBN_NUM='',pInput.FBN_NUM,pInput.ORIG_FBN_NUM));
			string8  orig_filing_date       := if(pInput.ORIG_FBN_NUM='',pInput.FILED_DATE,pInput.ORIG_filed_DATE);
		
			self.tmsid					    := 'CSC'+trim(orig_filing+orig_filing_date[1..4],all);
			self.rmsid					    :=  pInput.FBN_NUM;
			
			
			self.dt_first_seen      		:= (integer) pInput.Process_date;
			self.dt_last_seen       		:= (integer) pInput.Process_date;
			self.dt_vendor_first_reported  	:= (integer) pInput.Process_date;
			self.dt_vendor_last_reported  	:= (integer) pInput.Process_date;
			self.contact_type	    		:= 'O';
			self.contact_status             := map(pInput.fBN_type = 'A'   => 'ABANDONED',
												   pInput.fBN_type = 'W'   => 'WITHDRAWN','ACTIVE');
			self.WITHDRAWAL_DATE            :=  IF(pInput.fBN_type = 'A' or pInput.fBN_type = 'W', (integer) pInput.filed_date,0);									   
			self.contact_name			    :=  pInput.owner_Name ;
			self.title						:=	pInput.clean_name[1..5];
			self.fname						:=	pInput.clean_name[6..25];
			self.mname						:=	pInput.clean_name[26..45];
			self.lname					    :=	pInput.clean_name[46..65];
			self.name_suffix				:=	pInput.clean_name[66..70];
			self.name_score			        :=	pInput.clean_name[71..73];
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
	
dProj   	:=dedup(project(dfiling,tfiling(left)),all);
			
dSort       :=SORT(Distribute(dProj, hash(tmsid)),
                   RECORD,except dt_first_seen,dt_last_seen, dt_vendor_first_reported,dt_vendor_last_reported,local); 

dOut    	:=rollup(dSort ,rollupXform(left,right),
					RECORD,except dt_first_seen,dt_last_seen, dt_vendor_first_reported,dt_vendor_last_reported,local)
					:persist(Cluster.cluster_out+'persist::FBNV2::CA::santa::contact');
			
export Mapping_FBN_CA_Santa_Clara_Contact := dOut;