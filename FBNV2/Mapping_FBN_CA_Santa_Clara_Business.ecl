import ut,fbnv2,_validate;

dFiling			            := dedup(
																 File_CA_Santa_clara_in.Cleaned,all);

layout_common.Business_AID tFiling(dFiling pInput)
   :=TRANSFORM
            
			string17 orig_filing            := trim(if(pInput.ORIG_FBN_NUM='',pInput.FBN_NUM,pInput.ORIG_FBN_NUM));
			string8  orig_filing_date       := if(pInput.ORIG_FBN_NUM='',pInput.FILED_DATE,pInput.ORIG_filed_DATE);
		
			self.tmsid					    := 'CSC'+trim(orig_filing+orig_filing_date[1..4],all);
			self.rmsid					    :=  pInput.FBN_NUM;
			self.dt_first_seen      		:= if(_validate.date.fIsValid((string) orig_filing_date), (integer) orig_filing_date,0); 
			self.dt_last_seen       		:= if(_validate.date.fIsValid((string) pInput.FILED_DATE), (integer) pInput.FILED_DATE,0); 
			self.dt_vendor_first_reported  	:= if(_validate.date.fIsValid((string) pInput.Process_date), (integer) pInput.Process_date,0); 
			self.dt_vendor_last_reported  	:= if(_validate.date.fIsValid((string) pInput.Process_date), (integer) pInput.Process_date,0);
		
			self.Filing_Jurisdiction 		:= 'CSC';
			self.FILING_NUMBER 			    := pInput.FBN_NUM ;
			self.Filing_date           	:= if(_validate.date.fIsValid((string) pInput.FILED_DATE), (integer) pInput.FILED_DATE,0);  
      self.FILING_TYPE            := map(pInput.FILING_TYPE = '1'     => 'NEW',
																				 pInput.FILING_TYPE = '2'     => 'RENEWAL',
                                         pInput.FILING_TYPE = '3'     => 'RENEWAL - PUBLICATION REQUIRED',
                                         '');
      self.ORIG_FILING_NUMBER 		:= orig_filing ;
			self.ORIG_FILING_DATE     	:= if(_validate.date.fIsValid((string) orig_filing_date), (integer) orig_filing_date,0); 
			self.bus_status             := map(pInput.fBN_type = 'A'     => 'ABANDONED',
																				 pInput.fBN_type = 'W'     => 'WITHDRAWN',
                                         pInput.fBN_type = 'FBN'   => 'FBN STATEMENT',
                                         pInput.fBN_type = 'FBNAB' => 'FBN ABANDONMENT',
                                         pInput.fBN_type = 'FBNWD' => 'FBN STATEMENT OF WITHDRAWAL',
                                         'ACTIVE');
			self.CANCELLATION_DATE      := IF(pInput.fBN_type = 'A'
																						,if(_validate.date.fIsValid((string) pInput.FILED_DATE), (integer) pInput.FILED_DATE,0)
																						,0);
			self.BUS_NAME 					:= pInput.Business_NAME;
      self.BUS_TYPE_DESC      := map(pInput.BUSINESS_TYPE = 'CO'   => 'CORPORATION',
																		 pInput.BUSINESS_TYPE = 'CP'   => 'COPARTNERSHIP',
                                     pInput.BUSINESS_TYPE = 'GP'   => 'GENERAL PARTNERSHIP',
                                     pInput.BUSINESS_TYPE = 'HW'   => 'MARRIED COUPLE',
                                     pInput.BUSINESS_TYPE = 'ID'   => 'INDIVIDUAL',
                                     pInput.BUSINESS_TYPE = 'LC'   => 'LIMITED LIABILITY COMPANY',
                                     '');      
			SELF.LONG_BUS_NAME              := pInput.BUSINESS_NAME;
			self.BUS_ADDRESS1 				:= pInput.Business_ADDR1;
			self.BUS_ADDRESS2 				:= pInput.Business_ADDR2;
			self.BUS_CITY                 	:= pInput.Bus_CITY;
			self.BUS_STATE               	:= 'CA';
			self.BUS_COUNTY						:= 'SANTA CLARA';
			self.BUS_ZIP 					:= (integer) pInput.BUS_ZIP[1..5];
			self.BUS_ZIP4  					:= (integer) pInput.BUS_ZIP[6..9];
			self.MAIL_STREET  				:= trim(pInput.Business_ADDR1,right)+' '+trim(pInput.Business_ADDR2,right);
			self.MAIL_CITY 					:= pInput.BUS_CITY;
			self.MAIL_STATE 				:= pInput.BUS_ST;
			self.MAIL_ZIP 					:= pInput.BUS_ZIP;
			self.SEQ_NO 					:= 0;
			self.Prep_Addr_Line1			:= pinput.Prep_Addr_Line1;
			self.Prep_Addr_Line_last	:= pinput.Prep_Addr_Line_Last;
			
			self											:= pinput;

	 end;

layout_common.Business_AID tAddSeq(layout_common.Business_AID pInput ,integer c)	
	:=transform
			self.seq_no	:=c;
			self		:=pinput;
	end;

layout_common.Business_AID  rollupXform(layout_common.Business_AID pLeft, layout_common.Business_AID pRight) 
	:= transform
		
		self.Dt_First_Seen := ut.Min2(pLeft.dt_First_Seen,pRight.dt_First_Seen);
		self.Dt_Last_Seen  := MAX(pLeft.dt_Last_Seen ,pRight.dt_last_seen);
		self.Dt_Vendor_First_Reported := ut.min2(pLeft.dt_Vendor_First_Reported,pRight.dt_Vendor_First_Reported);
		self.Dt_Vendor_Last_Reported  := MAX(pLeft.dt_Vendor_Last_Reported,pRight.dt_Vendor_Last_Reported);
	    self := pLeft;
	END;
	

dProj   	:=dedup(project(dfiling,tfiling(left))
						,all);
			
dSort       :=SORT(Distribute(dProj, hash(Orig_filing_number)),
                   RECORD,except dt_first_seen,dt_last_seen, dt_vendor_first_reported,dt_vendor_last_reported,local); 
dRollup     :=rollup(dSort ,rollupXform(left,right),
					RECORD,except dt_first_seen,dt_last_seen, dt_vendor_first_reported,dt_vendor_last_reported,local);
dGroup      :=group(sort(distribute(dRollup,hash(ORIG_FILING_NUMBER))
					,ORIG_FILING_NUMBER,filing_date,seq_no, local)
			   ,ORIG_FILING_NUMBER);
			   
dOut        :=Project(dgroup,tAddSeq(left, counter)):persist(Cluster.cluster_out+'persist::FBNV2::CA::santa::Business');


export Mapping_FBN_CA_Santa_Clara_Business := dOut;