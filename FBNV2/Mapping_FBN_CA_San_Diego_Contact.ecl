import ut,fbnv2;

dFiling			            := dedup(File_CA_San_diego_in(type_of_record='2'),all);

layout_common.contact tFiling(dFiling pInput)
   :=TRANSFORM
            self.tmsid					    := 'CAS'+trim(pinput.orig_filing_number+hash(pInput.Business_name[1..25]));
			self.rmsid					    :=  if(pInput.NEW_FILING_NUMBER='',trim(pinput.orig_filing_number,all),pInput.NEW_FILING_NUMBER);
			self.dt_first_seen      		:= (integer) pInput.Process_date;
			self.dt_last_seen       		:= (integer) pInput.Process_date;
			self.dt_vendor_first_reported  	:= (integer) pInput.orig_filing_date ;
			self.dt_vendor_last_reported  	:= IF(pInput.FILING_DATE<pInput.orig_filing_date, (integer) pInput.orig_filing_date,(integer) pInput.FILING_DATE );
			self.contact_type	    		:= 'O';
			self.contact_status             := map(pInput.fBN_type = 'A'   => 'ABANDONED',
												   pInput.fBN_type = 'W'   => 'WITHDRAWN','ACTIVE');
			self.WITHDRAWAL_DATE			:=  (integer)pInput.filing_date;
			self.contact_name			    :=  pInput.owner_Name ;
			self.title						:=	pInput.pname[1..5];
			self.fname						:=	pInput.pname[6..25];
			self.mname						:=	pInput.pname[26..45];
			self.lname					    :=	pInput.pname[46..65];
			self.name_suffix				:=	pInput.pname[66..70];
			self.name_score			        :=	pInput.pname[71..73];
			
			
	 end;

layout_common.contact  rollupXform(layout_common.contact pLeft, layout_common.contact pRight) 
	:= transform
		
		self.Dt_First_Seen := IF(pLeft.dt_First_Seen > pRight.dt_First_Seen, pRight.dt_First_Seen, pLeft.dt_First_Seen);
		self.Dt_Last_Seen  := IF(pLeft.dt_Last_Seen  < pRight.dt_Last_Seen,  pRight.dt_Last_Seen,  pLeft.dt_Last_Seen);
		self.Dt_Vendor_First_Reported := IF(pLeft.dt_Vendor_First_Reported > pRight.dt_Vendor_First_Reported, 
											pRight.dt_Vendor_First_Reported, pLeft.dt_Vendor_First_Reported);
		self.Dt_Vendor_Last_Reported  := IF(pLeft.dt_Vendor_Last_Reported  < pRight.dt_Vendor_Last_Reported,  
											pRight.dt_Vendor_Last_Reported, pLeft.dt_Vendor_Last_Reported);
		self := pLeft;
	END;
	
dProj   	:=dedup(project(dfiling,tfiling(left)),all);
			
dSort       :=SORT(Distribute(dProj, hash(tmsid)),
                   RECORD,except dt_first_seen,dt_last_seen, dt_vendor_first_reported,dt_vendor_last_reported,local); 

dOut    	:=rollup(dSort ,rollupXform(left,right),
					RECORD,except dt_first_seen,dt_last_seen, dt_vendor_first_reported,dt_vendor_last_reported,local):
					persist(cluster.cluster_out+'persist::FBNV2::CA::San_diego::contact');

export Mapping_FBN_CA_San_Diego_Contact := dOut ;