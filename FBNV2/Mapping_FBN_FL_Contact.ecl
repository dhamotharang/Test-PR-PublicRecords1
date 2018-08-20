import ut,fbnv2,_validate;


LAYOUT_TEMP
   :=RECORD
        string8     Process_date;
		STRING12    ORIG_FILING_NUMBER;
		unsigned6 	FILING_DATE;
		STRING12 	FILING_NUMBER;
		fbnv2.layout_common.CONT_INFO;
		STRING73   	PNAME;
		// string5   title;
		// string20  fname;
		// string20  mname;
		// string20  lname;
		// string5   name_suffix;
		// string3   name_score;
		//STRING182 	CLEAN_ADDRESS;
		
		string100		prep_addr_line1;
		string50		prep_addr_line_last;
		string3   	filing_type_code :='';
		unsigned6   orig_filing_date :=0;
	
	END;

LAYOUT_TEMP tFiling(fbnv2.File_FL_Filing_in.Cleaned pInput)
   :=TRANSFORM
   
			STRING100    Prep_addr_line1  		:= if(pInput.prep_owner_addr_line1 <> '',
																							pInput.prep_owner_addr_line1,pInput.prep_addr_line1);
																			
			STRING100    Prep_addr_line_last  := if(pInput.prep_owner_addr_line_last <> '',
																							pInput.prep_owner_addr_line_last, pInput.prep_addr_line_last);		
   
            
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
			//SELF.CLEAN_ADDRESS              := CLEAN_ADDRESS;
			self.prep_addr_line1				:= prep_addr_line1;
			self.prep_addr_line_last		:= prep_addr_line_last;
			Self.FILING_NUMBER 			    := pInput.FIC_FIL_DOC_NUM ;
			self.Filing_date            	:= if(_validate.date.fIsValid((string) pInput.FIC_FIL_DATE), (integer) pInput.FIC_FIL_DATE,0);
			self.ORIG_FILING_NUMBER 		:= pInput.FIC_FIL_DOC_NUM;
		  self.pname                      := pInput.p_owner_name ;
			self.orig_filing_date       := if(_validate.date.fIsValid((string) pInput.FIC_FIL_DATE), (integer) pInput.FIC_FIL_DATE,0);
			self                        := pInput;
           
	 end;

LAYOUT_TEMP tEvent(fbnv2.File_FL_Event_in.Cleaned pInput)
   :=TRANSFORM
   
            // STRING182        clean_address  := if(pInput.clean_owner_address<>'',
			                                      // pInput.clean_owner_address,pInput.clean_address);
			
			STRING100    Prep_addr_line1  		:= if(pInput.prep_owner_addr_line1 <> '',
																							pInput.prep_owner_addr_line1,pInput.prep_new_addr_line1);
																			
			STRING100    Prep_addr_line_last  := if(pInput.prep_owner_addr_line_last <> '',
																							pInput.prep_owner_addr_line_last, pInput.prep_new_addr_line_last);	
   
          	self.contact_type	    		:= 'O';
			self.contact_name			    := pInput.Action_own_Name ;
			self.contact_name_format		:= IF(pInput.Owner_fname ='' and pInput.Owner_lname ='','C','P');
			self.contact_addr 				:= pInput.Action_own_ADDRESS;
			self.contact_CITY               := pInput.Action_own_CITY;
			self.contact_STATE              := pInput.Action_own_STATE;
			self.contact_ZIP 				:= (integer) pInput.Action_own_ZIP5;
			self.contact_Fei_num  		    := (integer) pInput.Action_own_fei;
			self.SEQ_NO 					:= (integer) pInput.ACTION_NEW_NAME_SEQ;
			self.contact_charter_num		:= pInput.ACTION_OWN_CHARTER_NUMBER ;
      self.withdrawal_date        := if(pInput.action_code='DEL'
																			,if(_validate.date.fIsValid((string) pInput.EVENT_DATE), (integer) pInput.EVENT_DATE,0) 
																			,0);
			self.CONTACT_STATUS             := if(pInput.action_code='DEL','INACTIVE','ACTIVE');
			//SELF.CLEAN_ADDRESS              := CLEAN_ADDRESS;
			self.prep_addr_line1				:= prep_addr_line1;
			self.prep_addr_line_last		:= prep_addr_line_last;
			Self.FILING_NUMBER 			    := pInput.EVENT_DOC_NUMBER ;
			self.Filing_date            	:= if(_validate.date.fIsValid((string) pInput.EVENT_DATE), (integer) pInput.EVENT_DATE,0);
			self.ORIG_FILING_NUMBER 		:= pInput.EVENT_ORIG_DOC_NUMBER;
			self.filing_type_code           := pInput.action_code;
			self.pname									:= pInput.Owner_title + 
																		 pInput.Owner_fname +
																		 pInput.Owner_mname +
																		 pInput.Owner_lname +
																		 pInput.Owner_name_suffix +
																		 pInput.Owner_name_score;
		    self 	  					   			:= pInput;
           
	 end; 
	 
LAYOUT_TEMP tJoin(LAYOUT_TEMP pleft,LAYOUT_TEMP pRight)
    :=TRANSFORM
	       
		   SELF:=pLeft;
	END;
	
fbnv2.layout_common.contact_AID tMERGE(LAYOUT_TEMP pInput)	
  :=TRANSFORM
  
            
  			self.tmsid					    := 'FL'+pInput.Orig_filing_number;
			self.rmsid					    :=  trim(pinput.filing_type_code,all)+pInput.filing_number;
			self.dt_first_seen      		:= if(_validate.date.fIsValid((string) pInput.orig_filing_date), (integer) pInput.orig_filing_date,0); 
			self.dt_last_seen       		:= if(_validate.date.fIsValid((string) pInput.filing_date), (integer) pInput.filing_date,0); 
			self.dt_vendor_first_reported  	:= if(_validate.date.fIsValid((string) pInput.process_date), (integer) pInput.process_date,0); 
			self.dt_vendor_last_reported  	:= if(_validate.date.fIsValid((string) pInput.process_date), (integer) pInput.process_date,0); 
			self.title						:=	pInput.pname[1..5];
			self.fname						:=	pInput.pname[6..25];
			self.mname						:=	pInput.pname[26..45];
			self.lname					    :=	pInput.pname[46..65];
			self.name_suffix				:=	pInput.pname[66..70];
			self.name_score			        :=	pInput.pname[71..73];
/*
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
*/
			self.Prep_Addr_Line1			:= pInput.Prep_Addr_Line1;
			self.Prep_Addr_Line_Last	:= pInput.Prep_Addr_Line_Last;
			self                      :=  pInput;
	
	END;


fbnv2.layout_common.contact_AID  rollupXform(fbnv2.layout_common.contact_AID pLeft, fbnv2.layout_common.contact_AID pRight) 
	:= transform
		
		self.Dt_First_Seen := ut.Min2(pLeft.dt_First_Seen,pRight.dt_First_Seen);
		self.Dt_Last_Seen  := MAX(pLeft.dt_Last_Seen ,pRight.dt_last_seen);
		self.Dt_Vendor_First_Reported := ut.min2(pLeft.dt_Vendor_First_Reported,pRight.dt_Vendor_First_Reported);
		self.Dt_Vendor_Last_Reported  := MAX(pLeft.dt_Vendor_Last_Reported,pRight.dt_Vendor_Last_Reported);
	    self := pLeft;
	END;

// dEvent      := distribute(dedup(project(fbnv2.File_FL_Event_in.Cleaned_Old(action_code='ADD' or action_code='DEL' Or action_code='CHO') +
																				// fbnv2.File_FL_Event_in.Cleaned(action_code='ADD' or action_code='DEL' Or action_code='CHO'),
dEvent      := distribute(dedup(project(fbnv2.File_FL_Event_in.Cleaned(action_code='ADD' or action_code='DEL' Or action_code='CHO'),
										tevent(left)),
								all),
						  hash(orig_filing_number));
	
//dFiling	    := DISTRIBUTE(dedup(project(fbnv2.File_FL_Filing_in.Cleaned_Old(fic_owner_name<>'') +
																				// fbnv2.File_FL_Filing_in.Cleaned(fic_owner_name<>''),
dFiling	    := DISTRIBUTE(dedup(project(fbnv2.File_FL_Filing_in.Cleaned(fic_owner_name<>''),
                                        tfiling(left)),
								all),
						  hash(orig_filing_number));

dFilingOnly := join(dFiling,dEVENT,
                   left.ORIG_FILING_NUMBER=right.ORIG_FILING_NUMBER AND
				   left.FILING_NUMBER=right.FILING_NUMBER,
				   tJOIN(left,right),left ONLY,local);

dEventOnly  := join(dEVENT,dFilingOnly,
                   left.ORIG_FILING_NUMBER=right.ORIG_FILING_NUMBER,                   
				   tJOIN(left,right),left ONLY,local);
				   
dMerge      := sort(PROJECT(dFilingOnly+dEvent  ,tMerge(left)),record,local);
					
dout        := rollup(dMerge,rollupXform(left,right),
					RECORD,except dt_first_seen,dt_last_seen, dt_vendor_first_reported,dt_vendor_last_reported,local)
					:persist(cluster.cluster_out+'persist::FBNV2::FL::contact');
				

export Mapping_FBN_FL_Contact      :=	dOut;