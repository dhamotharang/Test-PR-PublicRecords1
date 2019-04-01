import ut,fbnv2,address,_validate;

dFiling			            := dedup(FBNV2.File_CA_San_Bernardino_xml(bus_name<>''),all);
		
layout_common.contact_AID tFiling(dFiling pInput)
   :=TRANSFORM
           self.tmsid					    := 'CAB'+trim(pInput.filing_number)+pInput.clean_address[1..10];
			self.rmsid					    :=  pInput.filing_type[1]+hash(pInput.bus_name);
			self.dt_first_seen      		:= if(_validate.date.fIsValid((string)pInput.Filing_date),(integer) pInput.FILing_DATE,0);
			self.dt_last_seen       		:= if(_validate.date.fIsValid((string)pInput.date_last_trans),(integer) pInput.date_last_trans,0);
			self.dt_vendor_first_reported  	:= if(_validate.date.fIsValid((string)pInput.date_last_trans),(integer) pInput.date_last_trans,0);
			self.dt_vendor_last_reported  	:= if(_validate.date.fIsValid((string)pInput.date_last_trans),(integer) pInput.date_last_trans,0);
			self.contact_type	    		:= 'O';
			self.contact_NAME          		:= if(pInput.owner_fl_name='',trim(pInput.owner_first_name)+' '
			                                                       +trim(pInput.owner_last_name,left,right),
			                                                      pInput.owner_fl_name);			
			self.contact_NAME_FORMAT        := if(pInput.owner_fl_name<>'','C','P');
			self.contact_ADDR           	:= pInput.owner_address;       
			self.contact_CITY          		:= pInput.OWNER_CITY ;         
			self.contact_STATE          	:= pInput.OWNER_STATE  ;       
			self.contact_ZIP          		:= (integer)pInput.OWNER_ZIP ;    
			self.SEQ_NO           			:= 0; 
			self.title						:=	pInput.clean_name[1..5];
			self.fname						:=	pInput.clean_name[6..25];
			self.mname						:=	pInput.clean_name[26..45];
			self.lname					    :=	pInput.clean_name[46..65];
			self.name_suffix				:=	pInput.clean_name[66..70];
			self.name_score			        :=	pInput.clean_name[71..73];
			self.prep_addr_line1			:= address.Addr1FromComponents(
																					stringlib.stringtouppercase(trim(pInput.owner_address,left,right))
																					,''
																					,''
																					,''
																					,''
																					,''
																					,'');
			self.prep_addr_line_last	:= address.Addr2FromComponents(
																					stringlib.stringtouppercase(trim(pInput.OWNER_CITY))
																					,stringlib.stringtouppercase(trim(pInput.OWNER_STATE))
																					,pInput.OWNER_ZIP[1..5]);
			self                := pinput;
			self                := [];

	 end;

layout_common.contact_AID  rollupXform(layout_common.contact_AID pLeft, layout_common.contact_AID pRight) 
	:= transform
		
		self.Dt_First_Seen := ut.Min2(pLeft.dt_First_Seen,pRight.dt_First_Seen);
		self.Dt_Last_Seen  := MAX(pLeft.dt_Last_Seen ,pRight.dt_last_seen);
		self.Dt_Vendor_First_Reported := ut.min2(pLeft.dt_Vendor_First_Reported,pRight.dt_Vendor_First_Reported);
		self.Dt_Vendor_Last_Reported  := MAX(pLeft.dt_Vendor_Last_Reported,pRight.dt_Vendor_Last_Reported);
	    self := pLeft;
	END;
	
dSortFiling	:=SORT(DISTRIBUTE(dedup(project(dfiling,tfiling(left)),all),hash(tmsid))
					,RECORD,except dt_first_seen,dt_last_seen, dt_vendor_first_reported,dt_vendor_last_reported,local); 
					
dout        :=rollup(dSortFiling,rollupXform(left,right),
					RECORD,except dt_first_seen,dt_last_seen, dt_vendor_first_reported,dt_vendor_last_reported,local)
					:persist(cluster.cluster_out+'persist::FBNv2::CA::San_Bernardino::CONTACT');

					 
export Mapping_FBN_CA_San_Bernardino_contact      :=	dOut; 