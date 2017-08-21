import ut,fbnv2,_validate;

dFiling_Old							:= File_CA_Orange_in.Cleaned_Old;
dFiling			            := dedup(dFiling_Old +
																 File_CA_Orange_in.Cleaned,all);

layout_common.contact_AID tFiling(dFiling pInput)
   :=TRANSFORM
      self.tmsid					    := 'CAO'+hash(pInput.BUSINESS_NAME);
			self.rmsid					    :=  pInput.REGIS_NBR+pInput.Business_letter;
			self.dt_first_seen      		:= if(_validate.date.fIsValid((string) pInput.FILE_DATE), (integer) pInput.FILE_DATE,0); 
			self.dt_last_seen       		:= if(_validate.date.fIsValid((string) pInput.Process_date), (integer) pInput.Process_date,0); 
			self.dt_vendor_first_reported  	:= if(_validate.date.fIsValid((string) pInput.Process_date), (integer) pInput.Process_date,0); 
			self.dt_vendor_last_reported  	:= if(_validate.date.fIsValid((string) pInput.Process_date), (integer) pInput.Process_date,0); 
			self.contact_type	    		:= 'O';
			self.contact_NAME          		:= if(pInput.Cname='',trim(pInput.FIRST_NAME)+' '
			                                                      +trim(pInput.MIDDLE_Name,left,right)+' '
																  +trim(pInput.LAST_NAME_COMPANY,left,right),
			                                                      pInput.cname);			
			self.contact_NAME_FORMAT        := if(pInput.fname='','C','P');
			self.contact_ADDR           	:= pInput.OWNER_ADDRESS;       
			self.contact_CITY          		:= pInput.OWNER_CITY ;         
			self.contact_STATE          	:= pInput.OWNER_STATE  ;       
			self.contact_ZIP          		:= (integer)pInput.OWNER_ZIP_CODE  ;    
			self.SEQ_NO           				:= (integer)pInput.OWNER_NBR; 
			self.title										:=	pInput.title;
			self.fname										:=	pInput.fname;
			self.mname										:=	pInput.mname;
			self.lname					    			:=	pInput.lname;
			self.name_suffix							:=	pInput.name_suffix;
			self.name_score			       		:=	pInput.name_score;
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
			self.Prep_Addr_Line1			:= pinput.prep_owner_addr_line1;
			self.Prep_Addr_Line_last	:= pinput.prep_owner_addr_line_last;
			self                			:= pinput;
			self                			:= [];

	 end;

layout_common.contact_AID  rollupXform(layout_common.contact_AID pLeft, layout_common.contact_AID pRight) 
	:= transform
		
		self.Dt_First_Seen := ut.Min2(pLeft.dt_First_Seen,pRight.dt_First_Seen);
		self.Dt_Last_Seen  := MAX(pLeft.dt_Last_Seen ,pRight.dt_last_seen);
		self.Dt_Vendor_First_Reported := ut.min2(pLeft.dt_Vendor_First_Reported,pRight.dt_Vendor_First_Reported);
		self.Dt_Vendor_Last_Reported  := MAX(pLeft.dt_Vendor_Last_Reported,pRight.dt_Vendor_Last_Reported);
	    self := pLeft;
	END;
	
dSortFiling	:=SORT(DISTRIBUTE(dedup(project(dfiling,tfiling(left)),all)+FBNV2.Mapping_FBN_CA_Orange_contact_Xml,hash(tmsid))
					,RECORD,except dt_first_seen,dt_last_seen, dt_vendor_first_reported,dt_vendor_last_reported,local); 
					
dout        :=rollup(dSortFiling,rollupXform(left,right),
					RECORD,except dt_first_seen,dt_last_seen, dt_vendor_first_reported,dt_vendor_last_reported,local)
					:persist(cluster.cluster_in+'persist::FBNv2::CA::ORANGE::CONTACT');

export Mapping_FBN_CA_Orange_Contact      :=	dOut;