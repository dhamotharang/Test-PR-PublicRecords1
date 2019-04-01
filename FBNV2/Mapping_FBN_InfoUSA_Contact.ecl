import ut,fbnv2,address,_validate;

dFiling			            := dedup(File_InfoUSA_in,all,except process_date);
//There is no owner address stead of using business Address
layout_common.contact_AID tFiling(dFiling pInput)
   :=TRANSFORM
            string182 clean_address         := if(pInput.clean_contact_address<>'',pInput.clean_contact_address,pInput.clean_address);
			self.tmsid					    := 'INF'+hash(pInput.BUS_ZIP+pInput.Bus_NAME[1..25]);												
			self.rmsid                      :=  pInput.Bus_STATE+if(pInput.FILING_NUMBER<>'',hash(pInput.FILING_NUMBER),
			                                    if(pInput.FILing_DATE<>'',hash(pInput.FILing_DATE+pInput.BUS_ZIP),
												if(length(trim(pInput.BUS_PHONE_NUM))=10,hash(pInput.BUS_PHONE_NUM),hash(pInput.BUS_ZIP+pInput.Bus_NAME[1..25]))));
		    self.dt_first_seen      		:= if(_validate.date.fIsValid((string) pInput.Filing_date), (integer) pInput.Filing_date,0); 
			self.dt_last_seen       		:= if(_validate.date.fIsValid((string) pInput.Filing_date), (integer) pInput.Filing_date,0); 
			self.dt_vendor_first_reported  	:= if(_validate.date.fIsValid((string) pInput.Process_date), (integer) pInput.Process_date,0); 
			self.dt_vendor_last_reported  	:= if(_validate.date.fIsValid((string) pInput.Process_date), (integer) pInput.Process_date,0); 
			self.contact_type	    		:= 'C';
			self.CONTACT_NAME_FORMAT        :=  'P';
			self.contact_name			    := pInput.CNTCT_FIRST_NAME+pinput.CNTCT_LAST_NAME ;
			self.contact_addr 				:= pInput.CNTCT_STR_ADDR;
			self.contact_CITY               := pInput.CNTCT_CITY ;
			self.contact_STATE              := pInput.CNTCT_STATE ;
			self.contact_ZIP 				:= (integer) pInput.CNTCT_ZIP;			
			self.contact_phone       		:= pInput.CNTCT_PHONE_NUM; 
			self.title						:=	pInput.pname[1..5];
			self.fname						:=	pInput.pname[6..25];
			self.mname						:=	pInput.pname[26..45];
			self.lname					    :=	pInput.pname[46..65];
			self.name_suffix				:=	pInput.pname[66..70];
			self.name_score			        :=	pInput.pname[71..73];
			self.prep_addr_line1		 := address.Addr1FromComponents(
																					stringlib.stringtouppercase(trim(pInput.BUS_STR_ADDR,left,right))
																					,''
																					,''
																					,''
																					,''
																					,''
																					,'');
			self.prep_addr_line_last := address.Addr2FromComponents(
																					stringlib.stringtouppercase(trim(pInput.BUS_CITY))
																					,stringlib.stringtouppercase(trim(pInput.BUS_STATE))
																					,pInput.BUS_ZIP);
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

dOut  	    :=rollup(dSort ,rollupXform(left,right),
					RECORD,except dt_first_seen,dt_last_seen, dt_vendor_first_reported,dt_vendor_last_reported,local) 
				:PERSIST(Cluster.cluster_out+'persist::FBNV2::infousa::Contact'); 	  

export Mapping_FBN_InfoUSA_Contact := dOut;