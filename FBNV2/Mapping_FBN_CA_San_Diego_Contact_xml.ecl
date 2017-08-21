import ut,fbnv2,_validate;

dFiling			            := FBNV2.File_CA_San_Diego_xml;
 
layout_common.contact_AID tFiling(dFiling pInput)
   :=TRANSFORM
            string filing_number            := if(pInput.AbandFileNo='' and pInput.OwnerAF='',pInput.filingNumber,
			 									if(pInput.AbandFileNo='',pInput.OwnerAF,pInput.AbandFileNo));
			unsigned4 filing_date           := (integer) IF(pInput.Abandon_Date='0' and pInput.OwnerWDD = '0', pInput.FilingDate,
												 if(pInput.Abandon_Date='0',pInput.OwnerWDD,pInput.Abandon_Date));
			self.tmsid					    := 'CAS'+trim(pinput.FilingNumber+hash(pInput.DBAName[1..25]),all);
			self.rmsid					    :=  filing_number;
			self.dt_first_seen      		:= if(_validate.date.fIsValid((string) pInput.FilingDate),(integer) pInput.FilingDate,0); 
			self.dt_last_seen       		:= if(_validate.date.fIsValid((string) filing_date),(integer) filing_date,0); 
			self.dt_vendor_first_reported  	:= if(_validate.date.fIsValid((string) pInput.DateLastTrans),(integer) pInput.DateLastTrans,0);
			self.dt_vendor_last_reported  	:= if(_validate.date.fIsValid((string) pInput.DateLastTrans),(integer) pInput.DateLastTrans,0);
			self.contact_type	    		:= 'O';
			self.contact_status             := map(pInput.Abandon_Date <>'0'   => 'ABANDONED',
												   pInput.OwnerWDD <>'0'   => 'WITHDRAWN','ACTIVE');
			self.WITHDRAWAL_DATE			:= if(_validate.date.fIsValid((string) pInput.OwnerWDD),(integer) pInput.OwnerWDD,0); 
			self.contact_name			    :=  pInput.Ownerflname ;
			self.title						:=	pInput.pname[1..5];
			self.fname						:=	pInput.pname[6..25];
			self.mname						:=	pInput.pname[26..45];
			self.lname					    :=	pInput.pname[46..65];
			self.name_suffix				:=	pInput.pname[66..70];
			self.name_score			        :=	pInput.pname[71..73];
			
			
	 end;

layout_common.contact_AID  rollupXform(layout_common.contact_AID pLeft, layout_common.contact_AID pRight) 
	:= transform
		
		self.Dt_First_Seen := ut.Min2(pLeft.dt_First_Seen,pRight.dt_First_Seen);
		self.Dt_Last_Seen  := MAX(pLeft.dt_Last_Seen ,pRight.dt_last_seen);
		self.Dt_Vendor_First_Reported := ut.min2(pLeft.dt_Vendor_First_Reported,pRight.dt_Vendor_First_Reported);
		self.Dt_Vendor_Last_Reported  := MAX(pLeft.dt_Vendor_Last_Reported,pRight.dt_Vendor_Last_Reported);
	    self := pLeft;
	END;
	
dProj   	:=dedup(project(dfiling,tfiling(left)),all);
			
dSort       :=SORT(Distribute(dProj, hash(tmsid)),
                   RECORD,except dt_first_seen,dt_last_seen, dt_vendor_first_reported,dt_vendor_last_reported,local); 

dOut    	:=rollup(dSort ,rollupXform(left,right),
					RECORD,except dt_first_seen,dt_last_seen, dt_vendor_first_reported,dt_vendor_last_reported,local):
					persist(cluster.cluster_out+'persist::FBNV2::CA::San_diego::contact::xml');

export Mapping_FBN_CA_San_Diego_Contact_xml := dOut ;