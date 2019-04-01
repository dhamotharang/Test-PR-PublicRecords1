import ut,fbnv2,_validate;

dFiling2			          := FBNV2.File_CA_San_Diego_in.Cleaned(type_of_name = 'O');

layout_common.contact_AID tFiling2(dFiling2 pInput, integer c):= TRANSFORM 

      //In the case where there is only information in the second/mailing address we don't want to create a record with a blank address
      integer cnt                   := if (trim(pInput.prep_addr_line1,left,right) <> '', c, 2);
      self.tmsid					          := 'CAS'+trim(pinput.prev_file_number + hash(pInput.Business_name),all);
			self.rmsid					          := if(pInput.FILE_NUMBER = '',trim(pinput.prev_file_number,all),pInput.FILE_NUMBER);
			self.dt_first_seen      		  := if(_validate.date.fIsValid((string) pInput.prev_file_date),(integer) pInput.prev_file_date,0);
			self.dt_last_seen       		  := IF(pInput.FILE_DATE < pInput.prev_file_date
																			   ,if(_validate.date.fIsValid((string) pInput.prev_file_date),(integer) pInput.prev_file_date,0) 
																			   ,if(_validate.date.fIsValid((string) pInput.FILE_DATE),(integer) pInput.FILE_DATE,0) ); 
			self.dt_vendor_first_reported := if(_validate.date.fIsValid((string) pInput.Process_date),(integer) pInput.Process_date,0); 
			self.dt_vendor_last_reported  := if(_validate.date.fIsValid((string) pInput.Process_date),(integer) pInput.Process_date,0); 
			self.contact_type	    		    := 'OWNER NAME';
			self.contact_name			        := pInput.Business_Name ;
			self.contact_addr			        := choose(cnt ,trim(pInput.STREET_ADDRESS1,left,right) + ' ' + trim(pInput.STREET_ADDRESS2,left,right)
																						      ,trim(pInput.MAILING_ADDRESS1,left,right) + ' ' + trim(pInput.MAILING_ADDRESS2,left,right));
		  self.contact_city			        := choose(cnt	,trim(pInput.CITY,left,right), trim(pInput.MAILING_CITY,left,right));
		  self.contact_state			      := choose(cnt	,trim(pInput.STATE,left,right), trim(pInput.MAILING_STATE,left,right));
		  self.contact_zip				      := choose(cnt	,(integer)trim(pInput.ZIP_CODE,left,right), (integer)trim(pInput.MAILING_ZIP_CODE,left,right));
		  self.contact_country		      := choose(cnt	,trim(pInput.COUNTRY,left,right), trim(pInput.MAILING_COUNTRY,left,right));
      self.title						        := pInput.pname[1..5];
			self.fname						        := pInput.pname[6..25];
			self.mname						        := pInput.pname[26..45];
			self.lname					          := pInput.pname[46..65];
			self.name_suffix				      := pInput.pname[66..70];
			self.name_score			          := pInput.pname[71..73];
		  self.Prep_Addr_Line1					:= choose(cnt	,trim(pInput.prep_addr_line1,left,right), trim(pInput.prep_mail_addr_line1,left,right));
		  self.Prep_Addr_Line_Last			:= choose(cnt	,trim(pInput.prep_addr_line_last,left,right), trim(pInput.prep_mail_addr_line_last,left,right));
	
end;


layout_common.contact_AID  rollupXform(layout_common.contact_AID pLeft, layout_common.contact_AID pRight) 
	:= transform
		
		self.Dt_First_Seen := ut.Min2(pLeft.dt_First_Seen,pRight.dt_First_Seen);
		self.Dt_Last_Seen  := MAX(pLeft.dt_Last_Seen ,pRight.dt_last_seen);
		self.Dt_Vendor_First_Reported := ut.min2(pLeft.dt_Vendor_First_Reported,pRight.dt_Vendor_First_Reported);
		self.Dt_Vendor_Last_Reported  := MAX(pLeft.dt_Vendor_Last_Reported,pRight.dt_Vendor_Last_Reported);
	  self := pLeft;
	END;

dNorm     := normalize(dFiling2,if(trim(left.prep_addr_line1,left,right) <> '' and
                                                     trim(left.prep_mail_addr_line1,left,right) <> '' 
                                                  ,2,1),tFiling2(left,counter));
							 
			
dSort       :=SORT(Distribute(
									 dNorm, hash(tmsid)),
                   RECORD,except dt_first_seen,dt_last_seen, dt_vendor_first_reported,dt_vendor_last_reported,local); 

dOut    	:=rollup(dSort ,rollupXform(left,right),
					RECORD,except dt_first_seen,dt_last_seen, dt_vendor_first_reported,dt_vendor_last_reported,local):
					persist(cluster.cluster_out+'persist::FBNV2::CA::San_diego::contact');

export Mapping_FBN_CA_San_Diego_Contact := dOut ;