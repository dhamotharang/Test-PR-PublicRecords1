import ut,fbnv2;


LAYOUT_TEMP
   :=RECORD
		STRING12    ORIG_FILING_NUMBER;
		unsigned6 	FILING_DATE;
		STRING12 	FILING_NUMBER;
		fbnv2.layout_common.CONT;
		STRING73   	PNAME;
		STRING182 	CLEAN_ADDRESS;
		string3   	filing_type_code :='';
		unsigned6   orig_filing_date :='';
	
	END;

LAYOUT_TEMP tFiling(fbnv2.File_FL_Filing_in pInput)
   :=TRANSFORM
   
            STRING182        clean_address  := if(pInput.clean_owner_address<>'',
			                                      pInput.clean_owner_address,pInput.clean_address);
   
            
			self.contact_type	    		:= 'O';
			self.contact_name			    := pInput.FIC_owner_Name ;
			self.contact_name_format		:= pInput.fic_owner_name_format;
			self.contact_addr 				:= pInput.FIC_owner_ADDR;
			self.contact_CITY               := pInput.FIC_owner_CITY;
			self.contact_STATE              := pInput.FIC_owner_STATE;
			self.contact_ZIP 				:= (integer) (pInput.FIC_owner_ZIP5+'-'+pInput.FIC_owner_ZIP4);
			self.contact_COUNTRY  			:= pInput.FIC_owner_COUNTRY;
			self.contact_Fei_num  		    := (integer)pInput.FIC_owner_fei_num;
			self.SEQ_NO 					:= (integer) pInput.seq;
			self.contact_charter_num		:= pInput.FIC_OWNER_CHARTER_NUM ;
			SELF.CLEAN_ADDRESS              := CLEAN_ADDRESS;
			Self.FILING_NUMBER 			    := pInput.FIC_FIL_DOC_NUM ;
			self.Filing_date            	:= (integer) pInput.FIC_FIL_DATE;
			self.ORIG_FILING_NUMBER 		:= pInput.FIC_FIL_DOC_NUM;
		    self.pname                      := pInput.p_owner_name ;
			self.orig_filing_date           := (integer) pInput.FIC_FIL_DATE;
			self                            := pInput;
           
	 end;

LAYOUT_TEMP tEvent(fbnv2.File_FL_Event_in pInput)
   :=TRANSFORM
   
            STRING182        clean_address  := if(pInput.clean_owner_address<>'',
			                                      pInput.clean_owner_address,pInput.clean_address);
   
          	self.contact_type	    		:= 'O';
			self.contact_name			    := pInput.Action_own_Name ;
			self.contact_name_format		:= IF(pInput.pname='','C','P');
			self.contact_addr 				:= pInput.Action_own_ADDRESS;
			self.contact_CITY               := pInput.Action_own_CITY;
			self.contact_STATE              := pInput.Action_own_STATE;
			self.contact_ZIP 				:= (integer) pInput.Action_own_ZIP5;
			self.contact_Fei_num  		    := (integer) pInput.Action_own_fei;
			self.SEQ_NO 					:= (integer) pInput.ACTION_NEW_NAME_SEQ;
			self.contact_charter_num		:= pInput.ACTION_OWN_CHARTER_NUMBER ;
            self.withdrawal_date            := if(pInput.action_code='DEL',(integer)pInput.EVENT_DATE,0);
			self.CONTACT_STATUS             := if(pInput.action_code='DEL','INACTIVE','ACTIVE');
			SELF.CLEAN_ADDRESS              := CLEAN_ADDRESS;
			Self.FILING_NUMBER 			    := pInput.EVENT_DOC_NUMBER ;
			self.Filing_date            	:= (integer) pInput.EVENT_DATE;
			self.ORIG_FILING_NUMBER 		:= pInput.EVENT_ORIG_DOC_NUMBER;
			self.filing_type_code           := pInput.action_code;
		    self 	  					    := pInput;
           
	 end; 
	 
LAYOUT_TEMP tJoin(LAYOUT_TEMP pleft,LAYOUT_TEMP pRight)
    :=TRANSFORM
	       
		   SELF:=pLeft;
	END;
	
fbnv2.layout_common.contact tMERGE(LAYOUT_TEMP pInput)	
  :=TRANSFORM
  
            
  			self.tmsid					    := 'FL'+pInput.Orig_filing_number;
			self.rmsid					    :=  trim(pinput.filing_type_code)+pInput.filing_number;
			self.dt_first_seen      		:= (integer) pInput.orig_filing_date;
			self.dt_last_seen       		:= (integer) pInput.filing_date;
			self.dt_vendor_first_reported  	:= (integer) pInput.orig_filing_date;
			self.dt_vendor_last_reported  	:= (integer) pInput.filing_DATE;
			self.title						:=	pInput.pname[1..5];
			self.fname						:=	pInput.pname[6..25];
			self.mname						:=	pInput.pname[26..45];
			self.lname					    :=	pInput.pname[46..65];
			self.name_suffix				:=	pInput.pname[66..70];
			self.name_score			        :=	pInput.pname[71..73];
			self.prim_range 				:=	pInput.clean_address[1..10];			
			self.predir 					:=	pInput.clean_address[11..12];			
			self.prim_name 					:=	pInput.clean_address[13..40];			
			self.addr_suffix				:=	pInput.clean_address[41..44];			
			self.postdir 					:=	pInput.clean_address[45..46];			
			self.unit_desig 				:=	pInput.clean_address[47..56];			
			self.sec_range 					:=	pInput.clean_address[57..64];			
			self.v_city_name 				:=	pInput.clean_address[90..114];			
			self.st 						:=	pInput.clean_address[115..116];			
			self.zip5 						:=	pInput.clean_address[117..121];			
			self.zip4 						:=	pInput.clean_address[122..125];			
			self.addr_rec_type				:=	pInput.clean_address[139..140];			
			self.fips_state 				:=	pInput.clean_address[141..142];			
			self.fips_county 				:=  pInput.clean_address[143..145];				
			self.geo_lat 					:=	pInput.clean_address[146..155];			
			self.geo_long 					:=	pInput.clean_address[156..166];			
			self.cbsa						:=	pInput.clean_address[167..170];			
			self.geo_blk 					:=	pInput.clean_address[171..177];			
			self.geo_match 					:=	pInput.clean_address[178];			
			self.err_stat 					:=	pInput.clean_address[179..182];	
			self                            :=  pInput;
	
	END;


fbnv2.layout_common.contact  rollupXform(fbnv2.layout_common.contact pLeft, fbnv2.layout_common.contact pRight) 
	:= transform
		
		self.Dt_First_Seen := IF(pLeft.dt_First_Seen > pRight.dt_First_Seen, pRight.dt_First_Seen, pLeft.dt_First_Seen);
		self.Dt_Last_Seen  := IF(pLeft.dt_Last_Seen  < pRight.dt_Last_Seen,  pRight.dt_Last_Seen,  pLeft.dt_Last_Seen);
		self.Dt_Vendor_First_Reported := IF(pLeft.dt_Vendor_First_Reported > pRight.dt_Vendor_First_Reported, 
											pRight.dt_Vendor_First_Reported, pLeft.dt_Vendor_First_Reported);
		self.Dt_Vendor_Last_Reported  := IF(pLeft.dt_Vendor_Last_Reported  < pRight.dt_Vendor_Last_Reported,  
											pRight.dt_Vendor_Last_Reported, pLeft.dt_Vendor_Last_Reported);
		self := pLeft;
	END;

dEvent      := distribute(dedup(project(fbnv2.File_FL_Event_in(action_code='ADD' or action_code='DEL' Or action_code='CHO'),
										tevent(left)),
								all),
						  hash(orig_filing_number));
	
dFiling	    := DISTRIBUTE(dedup(project(fbnv2.File_FL_Filing_in(fic_owner_name<>''),
                                        tfiling(left)),
								all),
						  hash(orig_filing_number));

dFilingOnly := join(dFiling,dEVENT,
                   left.ORIG_FILING_NUMBER=right.ORIG_FILING_NUMBER,                   
				   tJOIN(left,right),left ONLY,local);

dEventOnly  := join(dEVENT,dFilingOnly,
                   left.ORIG_FILING_NUMBER=right.ORIG_FILING_NUMBER,                   
				   tJOIN(left,right),left ONLY,local);
				   
dMerge      := sort(PROJECT(dFilingOnly+dEventOnly,tMerge(left)),record,local);
					
dout        := rollup(dMerge,rollupXform(left,right),
					RECORD,except dt_first_seen,dt_last_seen, dt_vendor_first_reported,dt_vendor_last_reported,local)
					:persist(cluster.cluster_in+'persist::FBNV2::FL::contact');
				

export Mapping_FBN_FL_Contact      :=	dOut;