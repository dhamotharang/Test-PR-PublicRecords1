import ut,fbnv2,_validate;

dFiling			            := File_CA_San_Diego_in.Cleaned_old(type_of_record='2' and orig_filing_number<>'') +
													 File_CA_San_diego_in.Cleaned(type_of_record='2' and orig_filing_number<>'');

layout_common.contact_AID tFiling(dFiling pInput)
   :=TRANSFORM
            self.tmsid					    := 'CAS'+trim(pinput.orig_filing_number+hash(pInput.Business_name[1..25]),all);
			self.rmsid					    :=  if(pInput.NEW_FILING_NUMBER='',trim(pinput.orig_filing_number,all),pInput.NEW_FILING_NUMBER);
			self.dt_first_seen      		:= if(_validate.date.fIsValid((string) pInput.orig_filing_date),(integer) pInput.orig_filing_date,0);
			self.dt_last_seen       		:= IF(pInput.FILING_DATE<pInput.orig_filing_date
																				,if(_validate.date.fIsValid((string) pInput.orig_filing_date),(integer) pInput.orig_filing_date,0) 
																				,if(_validate.date.fIsValid((string) pInput.FILING_DATE),(integer) pInput.FILING_DATE,0) ); 
			self.dt_vendor_first_reported  	:= if(_validate.date.fIsValid((string) pInput.Process_date),(integer) pInput.Process_date,0); 
			self.dt_vendor_last_reported  	:= if(_validate.date.fIsValid((string) pInput.Process_date),(integer) pInput.Process_date,0); 
			self.contact_type	    		:= 'O';
			self.contact_status             := map(pInput.fBN_type = 'A'   => 'ABANDONED',
												   pInput.fBN_type = 'W'   => 'WITHDRAWN','ACTIVE');
			self.WITHDRAWAL_DATE			:=  if(_validate.date.fIsValid((string) pInput.FILING_DATE),(integer) pInput.FILING_DATE,0);
			self.contact_name			    :=  pInput.owner_Name ;
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
	
dProj   	:=dedup(project(dfiling,tfiling(left)),all)+FBNV2.Mapping_FBN_CA_San_Diego_Contact_xml;
			
dSort       :=SORT(Distribute(dProj, hash(tmsid)),
                   RECORD,except dt_first_seen,dt_last_seen, dt_vendor_first_reported,dt_vendor_last_reported,local); 

dOut    	:=rollup(dSort ,rollupXform(left,right),
					RECORD,except dt_first_seen,dt_last_seen, dt_vendor_first_reported,dt_vendor_last_reported,local):
					persist(cluster.cluster_out+'persist::FBNV2::CA::San_diego::contact');

export Mapping_FBN_CA_San_Diego_Contact := dOut ;