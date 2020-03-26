import ut,fbnv2,_validate;

dFiling			            := dedup(File_CA_Orange_in.Cleaned,all);

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
	
dSortFiling	:=SORT(DISTRIBUTE(dedup(project(dfiling,tfiling(left)),all)
					,hash(tmsid))
					,RECORD,except dt_first_seen,dt_last_seen, dt_vendor_first_reported,dt_vendor_last_reported,local); 
					
dout        :=rollup(dSortFiling,rollupXform(left,right),
					RECORD,except dt_first_seen,dt_last_seen, dt_vendor_first_reported,dt_vendor_last_reported,local)
					:persist(cluster.cluster_out+'persist::FBNv2::CA::ORANGE::CONTACT');

export Mapping_FBN_CA_Orange_Contact      :=	dOut;