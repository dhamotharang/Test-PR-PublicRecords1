import ut,fbnv2,_validate;

dFiling			            := FBNV2.File_CA_San_Diego_xml;

layout_common.Business_AID tFiling(dFiling pInput)
   :=TRANSFORM
            string filing_number            := if(pInput.AbandFileNo='' and pInput.OwnerAF='',pInput.filingNumber,
			 									if(pInput.AbandFileNo='',pInput.OwnerAF,pInput.AbandFileNo));
			unsigned4 filing_date           := (integer) IF(pInput.Abandon_Date='0' and pInput.OwnerWDD = '0', pInput.FilingDate,
												 if(pInput.Abandon_Date='0',pInput.OwnerWDD,pInput.Abandon_Date));
			self.tmsid					    := 'CAS'+trim(pinput.FilingNumber+hash(pInput.DBAName[1..25]),all);
			self.rmsid					    :=  filing_number;
			self.dt_first_seen      		:= if(_validate.date.fIsValid((string)pInput.filingdate),(integer) pInput.filingdate,0);
			self.dt_last_seen       		:= if(_validate.date.fIsValid((string)filing_date), filing_date,0);
			self.dt_vendor_first_reported  	:= if(_validate.date.fIsValid((string)pInput.DateLastTrans),(integer) pInput.DateLastTrans,0);
			self.dt_vendor_last_reported  	:= if(_validate.date.fIsValid((string)pInput.DateLastTrans),(integer) pInput.DateLastTrans,0);
			self.Filing_Jurisdiction 		:= 'CAS';
			self.FILING_NUMBER 			    := FILING_NUMBER ;
			self.Filing_date           		:= if(_validate.date.fIsValid((string)filing_date), filing_date,0);
			self.ORIG_FILING_NUMBER 		:= pInput.filingNumber ;
			self.ORIG_FILING_DATE     		:= if(_validate.date.fIsValid((string)pInput.filingdate),(integer) pInput.filingdate,0);
			self.bus_status             	:= IF(pInput.status[2]='B','INACTIVE','ACTIVE');
			self.CANCELLATION_DATE        := if(_validate.date.fIsValid((string)pInput.abandon_date),(integer) pInput.abandon_date,0);
			self.BUS_NAME 					:= pInput.DBAName;
			self.BUS_STATE						:= 'CA';
			self.BUS_COUNTY						:= 'SAN DIEGO';
			SELF.LONG_BUS_NAME              := pInput.DBAName;
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
dOut        :=Project(dgroup,tAddSeq(left, counter)):persist(cluster.cluster_out+'persist::FBNV2::CA::San_diego::Business::XML'); 
export Mapping_FBN_CA_San_Diego_Business_xml := dOut ;