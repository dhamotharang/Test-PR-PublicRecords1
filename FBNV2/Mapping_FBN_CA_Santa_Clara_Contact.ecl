﻿import ut,fbnv2,_validate;

dFiling			            := dedup(
																 File_CA_Santa_clara_in.Cleaned,all);
layout_common.contact_AID tFiling(dFiling pInput)
   :=TRANSFORM
      string17 orig_filing          := trim(if(pInput.ORIG_FBN_NUM='',pInput.FBN_NUM,pInput.ORIG_FBN_NUM));
			string8  orig_filing_date     := if(pInput.ORIG_FBN_NUM='',pInput.FILED_DATE,pInput.ORIG_filed_DATE);
		
			self.tmsid					   				:= 'CSC'+trim(orig_filing+orig_filing_date[1..4],all);
			self.rmsid					  			  :=  pInput.FBN_NUM;
			self.dt_first_seen      			:= if(_validate.date.fIsValid((string) orig_filing_date), (integer) orig_filing_date,0); 
			self.dt_last_seen       			:= if(_validate.date.fIsValid((string) pInput.FILED_DATE), (integer) pInput.FILED_DATE,0); 
			self.dt_vendor_first_reported := if(_validate.date.fIsValid((string) pInput.Process_date), (integer) pInput.Process_date,0); 
			self.dt_vendor_last_reported  := if(_validate.date.fIsValid((string) pInput.Process_date), (integer) pInput.Process_date,0); 
			self.contact_type	    				:= if(pInput.OWNER_TYPE <> '', pInput.OWNER_TYPE, 'O');
			self.contact_status       		:= map(pInput.fBN_type = 'A'   => 'ABANDONED',
																					 pInput.fBN_type = 'W'   => 'WITHDRAWN',
                                           pInput.fBN_type = 'FBN'   => 'ACTIVE',
                                           pInput.fBN_type = 'FBNAB' => 'ABANDONED',
                                           pInput.fBN_type = 'FBNWD' => 'WITHDRAWN',
                                           'ACTIVE');
			self.CONTACT_NAME_FORMAT 		 	:=  IF(trim(pInput.Owner_fname) = '' and trim(pInput.Owner_lname) = '','C','P');
			self.CONTACT_ADDr  			 		 	:=  if(trim(pInput.prep_owner_addr_line1 + pInput.prep_owner_addr_line_last) = '',
                                           trim(pInput.Business_ADDR1,right)+' '+trim(pInput.Business_ADDR2,right),
                                           pInput.OWNER_ADDR1);
			self.CONTACT_CITY 						:=  if(trim(pInput.prep_owner_addr_line1 + pInput.prep_owner_addr_line_last) = '',
                                           pInput.BUS_CITY,
                                           pInput.OWNER_CITY);
			self.CONTACT_STATE 						:=  if(trim(pInput.prep_owner_addr_line1 + pInput.prep_owner_addr_line_last) = '',
                                           pInput.BUS_St,
                                           pInput.OWNER_ST);
			self.CONTACT_ZIP 							:=  if(trim(pInput.prep_owner_addr_line1 + pInput.prep_owner_addr_line_last) = '',
                                           (integer)pInput.BUS_ZIP,
                                           (integer)pInput.OWNER_ZIP[1..5]);
			self.WITHDRAWAL_DATE     		 	:=  IF(pInput.fBN_type = 'A' or pInput.fBN_type = 'W'
																					,if(_validate.date.fIsValid((string) pInput.filed_date), (integer) pInput.filed_date,0)
																					,0);									   
			self.contact_name			  		  :=  pInput.owner_Name ;
			self.title										:=	pInput.Owner_title;
			self.fname										:=	pInput.Owner_fname;
			self.mname										:=	pInput.Owner_mname;
			self.lname					   			 	:=	pInput.Owner_lname;
			self.name_suffix							:=	pInput.Owner_name_suffix;
			self.name_score			    		  :=	pInput.Owner_name_score;
			self.Prep_Addr_Line1 			:= pInput.prep_owner_addr_line1;
			self.Prep_Addr_Line_Last  := pInput.prep_owner_addr_line_last;
			self               				:= pinput;
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
	
dProj   	:=dedup(project(dfiling,tfiling(left))
									,all);
			
dSort       :=SORT(Distribute(dProj, hash(tmsid)),
                   RECORD,except dt_first_seen,dt_last_seen, dt_vendor_first_reported,dt_vendor_last_reported,local); 

dOut    	:=rollup(dSort ,rollupXform(left,right),
					RECORD,except dt_first_seen,dt_last_seen, dt_vendor_first_reported,dt_vendor_last_reported,local)
					:persist(Cluster.cluster_out+'persist::FBNV2::CA::santa::contact');
			
export Mapping_FBN_CA_Santa_Clara_Contact := dOut;