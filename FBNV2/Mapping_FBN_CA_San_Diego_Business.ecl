import ut,fbnv2,_validate;

dFiling2			          := FBNV2.File_CA_San_Diego_in.Cleaned(type_of_name = 'B');
	
	 layout_common.Business_AID tFiling2(dFiling2 pInput) := TRANSFORM
      string filing_number          := if(pInput.FILE_NUMBER='',pinput.prev_file_number,pInput.FILE_NUMBER);
	    self.tmsid					          := 'CAS' + trim(pinput.prev_file_number + hash(pInput.Business_name),all);
			self.rmsid					          :=  if(pInput.FILE_NUMBER = '',trim(pinput.prev_file_number,all),pInput.FILE_NUMBER);
			self.dt_first_seen      		  := if(_validate.date.fIsValid((string)pInput.prev_file_date),(integer) pInput.prev_file_date,0);
			self.dt_last_seen       		  := IF(pInput.FILE_DATE < pInput.prev_file_date
																				,if(_validate.date.fIsValid((string)pInput.prev_file_date),(integer) pInput.prev_file_date,0)
																				,if(_validate.date.fIsValid((string)pInput.file_date),(integer) pInput.file_date,0) );
			self.dt_vendor_first_reported	:= if(_validate.date.fIsValid((string)pInput.process_date),(integer) pInput.process_date,0);
			self.dt_vendor_last_reported  := if(_validate.date.fIsValid((string)pInput.process_date),(integer) pInput.process_date,0);
			self.Filing_Jurisdiction 		  := 'CAS';
			self.FILING_NUMBER 			      := pInput.FILE_NUMBER;
			self.Filing_date           		:= if(_validate.date.fIsValid((string)pInput.file_date), (integer) pInput.file_date,0);
			self.ORIG_FILING_NUMBER 		  := pInput.prev_file_number;
			self.ORIG_FILING_DATE     		:= if(_validate.date.fIsValid((string)pInput.prev_file_date), (integer) pInput.prev_file_date, 0);
      self.EXPIRATION_DATE          := if(_validate.date.fIsValid((string)pInput.EXPIRATION_DATE), (integer) pInput.EXPIRATION_DATE, 0);
			self.FILING_TYPE   			      := map(trim(pInput.FILING_TYPE,left,right) = 'FBN' => 'FICTITIOUS BUSINESS NAME',
																					 trim(pInput.FILING_TYPE,left,right) = 'FBA' => 'STATEMENT OF ABANDONMENT',
																					 trim(pInput.FILING_TYPE,left,right) = 'FBW' => 'STATEMENT OF WITHDRAWAL FROM PARTNERSHIP',
																					 '');    	
			self.BUS_NAME						      := pInput.BUSINESS_NAME;
			self.bus_comm_date 			      := if(_validate.date.fIsValid((string)pInput.BUSINESS_START_DATE), (integer) pInput.BUSINESS_START_DATE,0) ;
			self.bus_status					      := map(trim(pInput.FILING_TYPE,left,right) = 'FBA' => 'ABANDONED',
																					 trim(pInput.FILING_TYPE,left,right) = 'FBW' => 'WITHDRAWN',
																					 '');   
			self.BUS_TYPE_DESC				    := map(trim(pInput.OWNERSHIP_TYPE,left,right) = 'C'   => 'CORPORATION',
																					 trim(pInput.OWNERSHIP_TYPE,left,right) = 'CP'  => 'CO-PARTNERS',
																					 trim(pInput.OWNERSHIP_TYPE,left,right) = 'GP'  => 'GENERAL PARTNERSHIP',
																					 trim(pInput.OWNERSHIP_TYPE,left,right) = 'I'   => 'INDIVIDUAL',
																					 trim(pInput.OWNERSHIP_TYPE,left,right) = 'JV'  => 'JOINT VENTURE',
																					 trim(pInput.OWNERSHIP_TYPE,left,right) = 'LLC' => 'LIMITED LIABILITY COMPANY',
																					 trim(pInput.OWNERSHIP_TYPE,left,right) = 'LLP' => 'LIMITED LIABILITY PARTNERSHIP',
																					 trim(pInput.OWNERSHIP_TYPE,left,right) = 'LP'  => 'LIMITED PARTNERSHIP',
																					 trim(pInput.OWNERSHIP_TYPE,left,right) = 'MC'  => 'MARRIED COUPLE',
																					 trim(pInput.OWNERSHIP_TYPE,left,right) = 'RDP' => 'STATE OR LOCAL REGISTERED DOMESTIC PARTNERS',
																					 trim(pInput.OWNERSHIP_TYPE,left,right) = 'T'   => 'TRUST',
																					 trim(pInput.OWNERSHIP_TYPE,left,right) = 'UA'  => 'UNINCORPORATED ASSOCIATION-OTHER THAN A PARTNERSHIP',
																					 '');
			self.BUS_ADDRESS1				      := trim(pInput.STREET_ADDRESS1,left,right);
			self.BUS_ADDRESS2				      := trim(pInput.STREET_ADDRESS2,left,right);
			self.BUS_CITY     				    := trim(pInput.CITY,left,right);           	
			self.BUS_STATE  					    := trim(pInput.STATE,left,right);             	
			self.BUS_ZIP							    := (integer) pInput.ZIP_CODE[1..5];
			self.BUS_ZIP4						      := (integer) pInput.ZIP_CODE[6..9];
			self.BUS_COUNTRY					    := trim(pInput.COUNTRY,left,right);
			self.MAIL_STREET					    := trim(pInput.MAILING_ADDRESS1,left,right) + ' ' + trim(pInput.MAILING_ADDRESS2,left,right);
			self.MAIL_CITY						    := trim(pInput.MAILING_CITY,left,right);
			self.MAIL_STATE					      := trim(pInput.MAILING_STATE,left,right);
			self.MAIL_ZIP						      := trim(pInput.MAILING_ZIP_CODE,left,right);			
			self.Prep_Addr_Line1					:= pInput.prep_addr_line1;
		  self.Prep_Addr_Line_Last			:= pInput.prep_addr_line_last;
		  self.Prep_Mail_Addr_Line1		  := pInput.prep_mail_addr_line1;
		  self.Prep_Mail_Addr_Line_Last := pInput.prep_mail_addr_line_last;	
			self.SEQ_NO							      := 0;
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
	

dProj   	:= 
             dedup(project(dfiling2,tfiling2(left)),all)
						 ;


dAbandoned  :=dProj(bus_status[2]='B');
 
dActive     :=join(dProj,dAbandoned,left.tmsid=right.tmsid,lookup,left only);
 
dSort       :=SORT(Distribute(dActive+dAbandoned, hash(tmsid)),
                   RECORD,except dt_first_seen,dt_last_seen, dt_vendor_first_reported,dt_vendor_last_reported,local); 
dRollup     :=rollup(dSort ,rollupXform(left,right),
					RECORD,except bus_status,dt_first_seen,dt_last_seen, dt_vendor_first_reported,dt_vendor_last_reported,local);
dGroup      :=group(sort(distribute(dRollup,hash(tmsid))
					,tmsid,filing_date,seq_no, local)
			   ,tmsid);
dOut        :=Project(dgroup,tAddSeq(left, counter)):persist(cluster.cluster_out+'persist::FBNV2::CA::San_diego::Business'); 
export Mapping_FBN_CA_San_Diego_Business := dOut ;
