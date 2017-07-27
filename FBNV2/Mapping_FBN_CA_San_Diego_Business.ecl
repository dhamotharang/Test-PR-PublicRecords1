import ut,fbnv2;

dFiling			            := dedup(File_CA_San_diego_in(type_of_record='2'),all,except process_date);

layout_common.Business tFiling(dFiling pInput)
   :=TRANSFORM
            string filing_number            := if(pInput.NEW_FILING_NUMBER='',pinput.orig_filing_number,pInput.NEW_FILING_NUMBER);
			
			self.tmsid					    := 'CAS'+trim(pinput.orig_filing_number+hash(pInput.Business_name[1..25]));
			self.rmsid					    :=  if(pInput.NEW_FILING_NUMBER='',trim(pinput.orig_filing_number,all),pInput.NEW_FILING_NUMBER);
			self.dt_first_seen      		:= (integer) pInput.Process_date;
			self.dt_last_seen       		:= (integer) pInput.Process_date;
			self.dt_vendor_first_reported  	:= (integer) pInput.orig_filing_date ;
			self.dt_vendor_last_reported  	:= IF(pInput.FILING_DATE<pInput.orig_filing_date, (integer) pInput.orig_filing_date,(integer) pInput.FILING_DATE );
			self.Filing_Jurisdiction 		:= 'CAS';
			self.FILING_NUMBER 			    := FILING_NUMBER ;
			self.Filing_date           		:= IF(pInput.NEW_FILING_NUMBER='' and pInput.FILING_DATE<>'',(integer) pInput.FILING_DATE,(integer) pInput.orig_filing_date);
			self.ORIG_FILING_NUMBER 		:= pinput.orig_filing_number ;
			self.ORIG_FILING_DATE     		:= (integer) pInput.orig_filing_date;
			self.bus_status             	:= IF(pInput.fBN_type = 'A','INACTIVE','ACTIVE');
			self.CANCELLATION_DATE          := IF(pInput.fBN_type = 'A', (integer) pInput.FILING_DATE,0);
			self.BUS_NAME 					:= pInput.Business_NAME;
			SELF.LONG_BUS_NAME              := pInput.BUSINESS_NAME;
			self.SEQ_NO 					:= 0;
			
			
	 end;

layout_common.Business tAddSeq(layout_common.Business pInput ,integer c)	
	:=transform
			self.seq_no	:=c;
			self		:=pinput;
	end;

layout_common.Business  rollupXform(layout_common.Business pLeft, layout_common.Business pRight) 
	:= transform
		
		self.Dt_First_Seen := IF(pLeft.dt_First_Seen > pRight.dt_First_Seen, pRight.dt_First_Seen, pLeft.dt_First_Seen);
		self.Dt_Last_Seen  := IF(pLeft.dt_Last_Seen  < pRight.dt_Last_Seen,  pRight.dt_Last_Seen,  pLeft.dt_Last_Seen);
		self.Dt_Vendor_First_Reported := IF(pLeft.dt_Vendor_First_Reported > pRight.dt_Vendor_First_Reported and pLeft.dt_Vendor_First_Reported>0 , 
											pRight.dt_Vendor_First_Reported, pLeft.dt_Vendor_First_Reported);
		self.Dt_Vendor_Last_Reported  := IF(pLeft.dt_Vendor_Last_Reported  < pRight.dt_Vendor_Last_Reported,  
											pRight.dt_Vendor_Last_Reported, pLeft.dt_Vendor_Last_Reported);
		self := pLeft;
	END;
	

dProj   	:=dedup(project(dfiling,tfiling(left)),all);

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