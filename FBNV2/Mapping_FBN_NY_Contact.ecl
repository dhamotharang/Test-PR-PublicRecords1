import ut,fbnv2,address,_validate;

dFiling			            := dedup(File_NYC_in,all);

layout_common.contact_AID tFiling(dFiling pInput)
   :=TRANSFORM
           
		    string  clean_address           := if(pInput.clean_owner_address='',pInput.clean_address,pInput.clean_owner_address);
			string  o_address               := if(pInput.owner_address='',
			                                      regexreplace('[ ]+',pInput.STREET_NUMBER+' '+pInput.DIRECTION+
			                                                    pInput.STREET_NAME+' '+pinput.STREET_TYPE+' '+pInput.APARTMENT_NUMBER,' '),
												  regexreplace('[ ]+',pInput.owner_address,' '));			
			string Filing_Jurisdiction      :=Map(pInput.COURT_CODE='1011007'=>'NBX',
												   pInput.COURT_CODE='1011018'=>'NYN',
												   pInput.COURT_CODE='1011028'=>'NKI',
												   pInput.COURT_CODE='1011035'=>'NYN',
												   pInput.COURT_CODE='1011040'=>'NYN',
												   pInput.COURT_CODE='1011048'=>'NQU',
												   pInput.COURT_CODE='1011046'=>'NRI',
												   pInput.COURT_CODE='1011057'=>'NYN',
												   pInput.COURT_CODE='1011060'=>'NYN','');
			
			self.tmsid					    := Filing_Jurisdiction+hash(pInput.business_name);
			self.rmsid					    := pInput.DOCKET_NUMBER ;
			self.dt_first_seen      		:= if(_validate.date.fIsValid((string) pInput.FILE_DATE), (integer) pInput.FILE_DATE,0); 
			self.dt_last_seen       		:= if(_validate.date.fIsValid((string) pInput.FILE_DATE), (integer) pInput.FILE_DATE,0); 
			self.dt_vendor_first_reported  	:= if(_validate.date.fIsValid((string) pInput.process_DATE), (integer) pInput.process_DATE,0); 
			self.dt_vendor_last_reported  	:= if(_validate.date.fIsValid((string) pInput.process_DATE), (integer) pInput.process_DATE,0); 
			self.contact_type	    		:= 'O';
			self.contact_name_format		:= IF(pinput.pname='','C','P');
			self.contact_name			    := pInput.owner_Name ;
			self.contact_addr 				:= o_address;
			self.contact_CITY          		:= IF(pInput.Owner_address='',pInput.CITY,clean_address[57..64] );         
			self.contact_STATE          	:= clean_address[115..116];   
			self.contact_ZIP          		:= (integer)clean_address[117..121]; 
			
			self.title						:=	pInput.pname[1..5];
			self.fname						:=	pInput.pname[6..25];
			self.mname						:=	pInput.pname[26..45];
			self.lname					    :=	pInput.pname[46..65];
			self.name_suffix				:=	pInput.pname[66..70];
			self.name_score			        :=	pInput.pname[71..73];
			self.prep_addr_line1			:= address.Addr1FromComponents(
																					stringlib.stringtouppercase(trim(o_address,left,right))
																					,''
																					,''
																					,''
																					,''
																					,''
																					,'');
			self.prep_addr_line_last	:= address.Addr2FromComponents(
																					stringlib.stringtouppercase(trim(self.contact_CITY))
																					,stringlib.stringtouppercase(trim(self.contact_STATE))
																					,((STRING)self.contact_ZIP)[1..5]);
			self                := pinput;

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
					:persist(cluster.cluster_out+'persist::FBNV2::NY::contact');
					
export Mapping_FBN_NY_Contact := dout;