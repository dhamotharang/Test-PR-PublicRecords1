import ut,fbnv2,_validate;
																 
dFiling			            := dedup(File_CA_Orange_in.Cleaned,all);

layout_common.Business_AID tFiling(dFiling pInput):=TRANSFORM
      self.tmsid					            := 'CAO'+hash(pInput.BUSINESS_NAME);
			self.rmsid					            :=  pInput.REGIS_NBR+pInput.Business_letter;
			self.dt_first_seen      		    := if(_validate.date.fIsValid((string) pInput.FILE_DATE), (integer) pInput.FILE_DATE,0); 
			self.dt_last_seen       		    := if(_validate.date.fIsValid((string) pInput.Process_date), (integer) pInput.Process_date,0); 
			self.dt_vendor_first_reported  	:= if(_validate.date.fIsValid((string) pInput.Process_date), (integer) pInput.Process_date,0); 
			self.dt_vendor_last_reported  	:= if(_validate.date.fIsValid((string) pInput.Process_date), (integer) pInput.Process_date,0); 
			self.Filing_Jurisdiction        := 'CAO';
			self.FILING_NUMBER           	  := pInput.REGIS_NBR;           
			self.Filing_date                := if(_validate.date.fIsValid((string) pInput.FILE_DATE), (integer) pInput.FILE_DATE,0);          
			self.BUS_NAME           		    := pInput.BUSINESS_NAME ;
			SELF.LONG_BUS_NAME              := pInput.BUSINESS_NAME;
			self.BUS_PHONE_NUM            	:= stringlib.stringfilter(pInput.PHONE_NBR,'0123456789') ;          
			self.BUS_ADDRESS1           	  := pInput.ADDRESS;             
			self.BUS_CITY                   := pInput.CITY;                
			self.BUS_STATE                  := 'CA';  
			self.BUS_COUNTY					        := 'ORANGE';
			self.BUS_ZIP           			    := (integer)pInput.ZIP_CODE[1..5] ; 
			self.BUS_ZIP4          			    := (integer)pInput.ZIP_CODE[6..9] ;
			self.MAIL_street           		  := pInput.OWNER_ADDRESS;             
			self.MAIL_CITY                  := pInput.OWNER_CITY;                
			self.MAIL_STATE                 := pInput.OWNER_STATE ;              
			self.MAIL_ZIP           		    := pInput.OWNER_ZIP_CODE; 
			self.SEQ_NO           			    := (integer)pInput.BUSINESS_LETTER ;  		
			self.Prep_Addr_Line1					:= pinput.prep_bus_addr_line1;
			self.Prep_Addr_Line_Last			:= pinput.prep_bus_addr_line_last;
			self.Prep_Mail_Addr_Line1			:= pinput.prep_owner_addr_line1;
			self.Prep_Mail_Addr_Line_Last	:= pinput.prep_owner_addr_line_last;
			self													:= pinput;
	 end;

layout_common.Business_AID  rollupXform(layout_common.Business_AID pLeft, layout_common.Business_AID pRight) 
	:= transform
		
		self.Dt_First_Seen := ut.Min2(pLeft.dt_First_Seen,pRight.dt_First_Seen);
		self.Dt_Last_Seen  := MAX(pLeft.dt_Last_Seen ,pRight.dt_last_seen);
		self.Dt_Vendor_First_Reported := ut.min2(pLeft.dt_Vendor_First_Reported,pRight.dt_Vendor_First_Reported);
		self.Dt_Vendor_Last_Reported  := MAX(pLeft.dt_Vendor_Last_Reported,pRight.dt_Vendor_Last_Reported);
	    self := pLeft;

	END;
	

dSortFiling	:=SORT(DISTRIBUTE(dedup(project(dfiling,tfiling(left)),all)
										 ,hash(ORIG_FILING_NUMBER)),
                      RECORD,except dt_first_seen,dt_last_seen, dt_vendor_first_reported,dt_vendor_last_reported,local);
dout        :=rollup(dSortFiling,rollupXform(left,right),
                      RECORD,except dt_first_seen,dt_last_seen, dt_vendor_first_reported,dt_vendor_last_reported,local)
                      :persist(cluster.cluster_out+'persist::FBNV2::CA::Orange::Business');
					 
export Mapping_FBN_CA_Orange_Business      :=	dOut; 