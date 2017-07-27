import ut,fbnv2;

dFiling			            := dedup(File_InfoUSA_in,all,except process_date);
//There is no owner address stead of using business Address
layout_common.contact tFiling(dFiling pInput)
   :=TRANSFORM
            string182 clean_address         := if(pInput.clean_contact_address<>'',pInput.clean_contact_address,pInput.clean_address);
			self.tmsid					    := 'INFOUSA'+if(pInput.BUS_PHONE_NUM<>'',HASH(pInput.BUS_PHONE_NUM),
														    hash(pInput.BUS_CITY+pInput.Bus_NAME));
			self.rmsid                      :=  pInput.Bus_STATE+if(pInput.FILING_NUMBER<>'',hash(pInput.FILING_NUMBER),
			                                    if(pInput.BUS_PHONE_NUM<>'',hash(pInput.BUS_PHONE_NUM),
												if(pInput.FILing_DATE<>'',hash(pInput.FILing_DATE),hash(pInput.BUS_CITY+pInput.Bus_NAME))));
			self.dt_first_seen      		:= (integer) pInput.Process_date;
			self.dt_last_seen       		:= (integer) pInput.Process_date;
			self.dt_vendor_first_reported  	:= (integer) pInput.Process_date;
			self.dt_vendor_last_reported  	:= (integer) pInput.Process_date;
			self.contact_type	    		:= 'C';
			self.contact_name			    := pInput.CNTCT_FIRST_NAME+pinput.CNTCT_LAST_NAME ;
			self.contact_addr 				:= pInput.CNTCT_STR_ADDR;
			self.contact_CITY               := pInput.CNTCT_CITY ;
			self.contact_STATE              := pInput.CNTCT_STATE ;
			self.contact_ZIP 				:= (integer) pInput.CNTCT_ZIP;			
			self.contact_phone       		:= pInput.CNTCT_PHONE_NUM; 
			self.title						:=	pInput.pname[1..5];
			self.fname						:=	pInput.pname[6..25];
			self.mname						:=	pInput.pname[26..45];
			self.lname					    :=	pInput.pname[46..65];
			self.name_suffix				:=	pInput.pname[66..70];
			self.name_score			        :=	pInput.pname[71..73];
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

	 end;
layout_common.contact  rollupXform(layout_common.contact pInput, layout_common.contact pRight) 
	:= transform
		
		self.Dt_First_Seen := IF(pInput.dt_First_Seen > pRight.dt_First_Seen, pRight.dt_First_Seen, pInput.dt_First_Seen);
		self.Dt_Last_Seen  := IF(pInput.dt_Last_Seen  < pRight.dt_Last_Seen,  pRight.dt_Last_Seen,  pInput.dt_Last_Seen);
		self.Dt_Vendor_First_Reported := IF(pInput.dt_Vendor_First_Reported > pRight.dt_Vendor_First_Reported, 
											pRight.dt_Vendor_First_Reported, pInput.dt_Vendor_First_Reported);
		self.Dt_Vendor_Last_Reported  := IF(pInput.dt_Vendor_Last_Reported  < pRight.dt_Vendor_Last_Reported,  
											pRight.dt_Vendor_Last_Reported, pInput.dt_Vendor_Last_Reported);
		self := pInput;
	END;
	
dProj   	:=dedup(project(dfiling,tfiling(left)),all);
			
dSort       :=SORT(Distribute(dProj, hash(tmsid)),
                   RECORD,except dt_first_seen,dt_last_seen, dt_vendor_first_reported,dt_vendor_last_reported,local); 

dOut  	    :=rollup(dSort ,rollupXform(left,right),
					RECORD,except dt_first_seen,dt_last_seen, dt_vendor_first_reported,dt_vendor_last_reported,local) 
				:PERSIST(Cluster.cluster_out+'persist::FBNV2::infousa::Contact'); 	  

export Mapping_FBN_InfoUSA_Contact := dOut;