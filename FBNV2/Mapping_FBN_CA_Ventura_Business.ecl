import ut,fbnv2,_validate;

dFiling			            := dedup(sort(
																			File_CA_ventura_in.Cleaned( BUSINESS_NAME<>''),instrument_id,-process_date),all,except process_date);

layout_common.Business_AID tFiling(dFiling pInput)
   :=TRANSFORM
      string8  dtFirst := (string) ut.Min2((integer) pInput.recorded_date,(integer) pInput.start_date);   
      string8  dtLast  := (string) MAX((integer) pInput.recorded_date,(integer) pInput.start_date);
			 self.tmsid					    := 'CAV'+hasH(pInput.BUSINESS_NAME) ;
			self.rmsid					    := pINput.instrument_id;    
			self.dt_first_seen      		:= if(_validate.date.fIsValid((string) dtFirst), (integer) dtFirst,0); 
			self.dt_last_seen       		:= if(_validate.date.fIsValid((string) dtLast), (integer) dtLast,0); 
			self.dt_vendor_first_reported  	:= if(_validate.date.fIsValid((string) pInput.recorded_date), (integer) pInput.recorded_date,0); 
			self.dt_vendor_last_reported  	:= if(_validate.date.fIsValid((string) pInput.recorded_date), (integer) pInput.recorded_date,0); 
			self.Filing_Jurisdiction        := 'CAV';
			self.FILING_NUMBER           	:= pINput.instrument_id;           
			self.Filing_date                := if(_validate.date.fIsValid((string) pInput.recorded_date), (integer) pInput.recorded_date,0);   
			self.cancellation_date          := if(pInput.process_date<'2007'
																						,if(_validate.date.fIsValid((string) pInput.abandondate), (integer) pInput.abandondate,0) 
																						,0);
			self.expiration_date            := if(pInput.process_date<'2007'
																						,0
																						,if(_validate.date.fIsValid((string) pInput.abandondate), (integer) pInput.abandondate,0)); 
			self.BUS_NAME           		:= pInput.BUSINESS_NAME ;  
			SELF.LONG_BUS_NAME              := pInput.BUSINESS_NAME;
			self.BUS_ADDRESS1           	:= pInput.business_street;             
			self.BUS_CITY                   := pInput.business_CITY;                
			self.BUS_STATE                  := 'CA';
			self.BUS_COUNTY								:= 'VENTURA';
			self.bus_status             	:= IF(pInput.abandondate<>'','INACTIVE','ACTIVE');
			self.BUS_ZIP           			:= (integer)pInput.business_ZIP5 ;           
			self.bus_comm_dATE              := if(_validate.date.fIsValid((string) pInput.start_date), (integer) pInput.start_date,0); 
			self.MAIL_STREET				:=  pInput.Mail_street;
		    self.MAIL_STATE				    :=  pInput.mail_STATE;
			self.MAIL_ZIP				    :=  pInput.mail_ZIP5+Pinput.mail_zip4;
			self.Prep_Addr_Line1					:= pinput.prep_bus_addr_line1;
			self.Prep_Addr_Line_last			:= pinput.prep_bus_addr_line_Last;
			self.Prep_Mail_Addr_Line1			:= pinput.Prep_Mail_Addr_Line1;
			self.Prep_Mail_Addr_Line_last	:= pinput.Prep_mail_Addr_Line_Last;
			self.seq_no                   :=  (integer) pINput.file_seq;
			self													:= pinput;
	 end;

layout_common.Business_AID  rollupXform(layout_common.Business_AID pLeft, layout_common.Business_AID pRight) 
	:= transform
		
		
		self.Dt_First_Seen := ut.Min2(pLeft.dt_First_Seen,pRight.dt_First_Seen);
		self.Dt_Last_Seen  := MAX(pLeft.dt_Last_Seen ,pRight.dt_last_seen);
		self.Dt_Vendor_First_Reported := ut.min2(pLeft.dt_Vendor_First_Reported,pRight.dt_Vendor_First_Reported);
		self.Dt_Vendor_Last_Reported  := MAX(pLeft.dt_Vendor_Last_Reported,pRight.dt_Vendor_Last_Reported);
	    self := pLeft;
	END;

layout_common.Business_AID Trans_Rmsid(layout_common.Business_AID pLeft,string2  c ) 
   :=
   TRANSFORM
     self.Rmsid                      :=if(trim(C,left,right)='1',pLeft.rmsid,trim(C,left,right)+pLeft.rmsid);
	 self                            :=pLeft;
	 end;
	 
dSortFiling	:=SORT(DISTRIBUTE(dedup(project(dfiling,tfiling(left))
							,all),hash(tmsid)),
                  RECORD,except dt_first_seen,dt_last_seen, dt_vendor_first_reported,dt_vendor_last_reported,local);
				  
dRollup     :=rollup(dSortFiling,rollupXform(left,right),
				  RECORD,except dt_first_seen,dt_last_seen, dt_vendor_first_reported,dt_vendor_last_reported,local);

dGroup      :=group(sort(distribute(dRollup,hash(tmsid,rmsid)),
                                             tmsid,rmsid,dt_first_seen,local),
									         tmsid,rmsid,local);

dOut        :=Project(dGroup ,Trans_Rmsid(left,(string2) counter),local)	 
					:persist(cluster.cluster_out+'persist::FBNV2::CA::Ventura::Business');

export Mapping_FBN_CA_Ventura_Business :=dOut  ;