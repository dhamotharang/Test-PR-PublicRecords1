import ut,fbnv2,_validate;


dFiling			            := File_CA_San_Diego_in.Cleaned_old(type_of_record='2' and orig_filing_number<>'') +
													 File_CA_San_diego_in.Cleaned(type_of_record='2' and orig_filing_number<>'');

layout_common.Business_AID tFiling(dFiling pInput)
   :=TRANSFORM
            string filing_number            := if(pInput.NEW_FILING_NUMBER='',pinput.orig_filing_number,pInput.NEW_FILING_NUMBER);
			
			self.tmsid					    := 'CAS'+trim(pinput.orig_filing_number+hash(pInput.Business_name[1..25]),all);
			self.rmsid					    :=  if(pInput.NEW_FILING_NUMBER='',trim(pinput.orig_filing_number,all),pInput.NEW_FILING_NUMBER);
			self.dt_first_seen      		:= if(_validate.date.fIsValid((string)pInput.orig_filing_date),(integer) pInput.orig_filing_date,0);
			self.dt_last_seen       		:= IF(pInput.FILING_DATE<pInput.orig_filing_date
																				,if(_validate.date.fIsValid((string)pInput.orig_filing_date),(integer) pInput.orig_filing_date,0)
																				,if(_validate.date.fIsValid((string)pInput.filing_date),(integer) pInput.filing_date,0) );
			self.dt_vendor_first_reported  	:= if(_validate.date.fIsValid((string)pInput.process_date),(integer) pInput.process_date,0);
			self.dt_vendor_last_reported  	:= if(_validate.date.fIsValid((string)pInput.process_date),(integer) pInput.process_date,0);
			self.Filing_Jurisdiction 		:= 'CAS';
			self.FILING_NUMBER 			    := FILING_NUMBER ;
			self.Filing_date           		:= IF(pInput.NEW_FILING_NUMBER='' and pInput.FILING_DATE<>''
																				,if(_validate.date.fIsValid((string)pInput.filing_date),(integer) pInput.filing_date,0)
																				,if(_validate.date.fIsValid((string)pInput.orig_filing_date),(integer) pInput.orig_filing_date,0) );
			self.ORIG_FILING_NUMBER 		:= pinput.orig_filing_number ;
			self.ORIG_FILING_DATE     		:= (integer) if(pInput.orig_filing_number<>filing_number
																									 ,if(_validate.date.fIsValid((string)pInput.orig_filing_date),(integer) pInput.orig_filing_date,0)
																									 ,if(_validate.date.fIsValid((string)pInput.filing_date),(integer) pInput.filing_date,0) );
			self.bus_status             	:= IF(pInput.fBN_type = 'A','INACTIVE','ACTIVE');
			self.CANCELLATION_DATE          := IF(pInput.fBN_type = 'A'
																						,if(_validate.date.fIsValid((string)pInput.filing_date),(integer) pInput.filing_date,0)
																						,0);
			self.BUS_NAME 					:= pInput.Business_NAME;
			self.BUS_STATE							:= 'CA';
			self.BUS_COUNTY							:= 'SAN DIEGO';
			SELF.LONG_BUS_NAME              := pInput.BUSINESS_NAME;
			self.SEQ_NO 					:= 0;
			
			
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
	

dProj   	:=dedup(project(dfiling,tfiling(left)),all)+FBNV2.Mapping_FBN_CA_San_Diego_Business_xml;

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