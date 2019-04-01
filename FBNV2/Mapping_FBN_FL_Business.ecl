import ut,fbnv2,_validate,STD;
					 
Layout_temp :=RECORD
       STRING8 process_date;
       layout_common.Bus;
		 STRING100  Prep_Addr_Line1;
		 STRING50  	Prep_Addr_Line_Last;
	   STRING3 	 	filing_type_code ;
	   STRING9 	 	ACTION_OLD_FEI                    :='';
	   STRING12		ACTION_OLD_COUNTY                 :='';
	   STRING40 	ACTION_OLD_ADDR1                  :='';
	   STRING40 	ACTION_OLD_ADDR2                  :='';
	   STRING28 	ACTION_OLD_CITY                   :='';
	   STRING2 		ACTION_OLD_STATE                  :='';
       STRING5 		ACTION_OLD_ZIP5                   :='';
	   STRING4 		ACTION_OLD_ZIP4                   :='';
	   STRING40 	ACTION_OLD_COUNTRY                :='';
		 STRING100	Prep_Old_Addr_Line1 := '';
		 STRING50		Prep_Old_Addr_Line_Last :=  '';
	END;

Layout_temp tFiling(File_FL_Filing_in.Cleaned pInput)
   :=TRANSFORM
            
			SELF.FILING_NUMBER 			    := pInput.FIC_FIL_DOC_NUM ;
			SELF.Filing_date            	:= if(_validate.date.fIsValid((string) pInput.FIC_FIL_DATE), (integer) pInput.FIC_FIL_DATE,0);
			SELF.EXPIRATION_DATE  			:= if(_validate.date.fIsValid((string) pInput.FIC_FIL_EXPIRATION_DATE), (integer) pInput.FIC_FIL_EXPIRATION_DATE,0); 
			SELF.CANCELLATION_DATE 			:= if(_validate.date.fIsValid((string) pInput.FIC_FIL_CANCELLATION_DATE), (integer) pInput.FIC_FIL_CANCELLATION_DATE,0); 
			SELF.ORIG_FILING_NUMBER 		:= pInput.FIC_FIL_DOC_NUM;
			SELF.ORIG_FILING_DATE     		:= if(_validate.date.fIsValid((string) pInput.FIC_FIL_DATE), (integer) pInput.FIC_FIL_DATE,0);
			SELF.BUS_NAME 					:= pInput.FIC_FIL_NAME;
			SELF.LONG_BUS_NAME              := pInput.FIC_FIL_NAME;
			SELF.bus_status  				:= pInput.FIC_FIL_STATUS_DEC;
			SELF.orig_FEIN    				:= (INTEGER) pInput.FIC_FIL_FEI_NUM  ;
			SELF.BUS_ADDRESS1 				:= pInput.FIC_FIL_ADDR1;
			SELF.BUS_ADDRESS2 				:= pInput.FIC_FIL_ADDR2;
			SELF.BUS_CITY                 	:= pInput.FIC_FIL_CITY;
			SELF.BUS_COUNTY 				:= pInput.FIC_FIL_COUNTY;
			SELF.BUS_STATE               	:= pInput.FIC_FIL_STATE;
			SELF.BUS_ZIP 					:= (INTEGER) pInput.FIC_FIL_ZIP5;
			SELF.BUS_ZIP4  					:= (INTEGER) pInput.FIC_FIL_ZIP4;
			SELF.BUS_COUNTRY  				:= pInput.FIC_FIL_COUNTRY;
			SELF.SEQ_NO 					:= 0;
			SELF.filing_type_code           := '';
			SELF                            := pInput;
			
      END;

Layout_temp tEvent(File_FL_Event_in.Cleaned  pInput)
   :=TRANSFORM
           
			SELF.FILING_NUMBER 			    := pInput.EVENT_DOC_NUMBER ;
			SELF.filing_type			    := pInput.ACTION_VERBAGE;
			SELF.Filing_date            	:= if(_validate.date.fIsValid((string) pInput.EVENT_DATE), (integer) pInput.EVENT_DATE,0);
			SELF.CANCELLATION_DATE 			:= IF (pInput.action_code='CAN'
																				,if(_validate.date.fIsValid((string) pInput.EVENT_DATE), (integer) pInput.EVENT_DATE,0)
																				,0);
			SELF.ORIG_FILING_NUMBER 		:= pInput.EVENT_ORIG_DOC_NUMBER;
			SELF.BUS_NAME 					:= pinput.EVENT_FIC_NAME;
			SELF.LONG_BUS_NAME              := pInput.EVENT_FIC_NAME;
			SELF.bus_status  				:= IF (pInput.action_code='CAN','CANCELLED','ACTIVE');
			SELF.orig_FEIN    				:= IF (pInput.action_code='CHF',(INTEGER) pinput.ACTION_NEW_FEI,0);
			SELF.BUS_ADDRESS1 				:= pinput.ACTION_NEW_ADDR1;
			SELF.BUS_ADDRESS2 				:= pinput.ACTION_NEW_ADDR2;
			SELF.BUS_CITY                 	:= pinput.ACTION_NEW_CITY;
			SELF.BUS_COUNTY 				:= pinput.ACTION_NEW_COUNTY;
			SELF.BUS_STATE               	:= pinput.ACTION_NEW_STATE;
			SELF.BUS_ZIP 					:= (INTEGER) pinput.ACTION_NEW_ZIP5;
			SELF.BUS_ZIP4  					:= (INTEGER) pinput.ACTION_NEW_ZIP4;
			SELF.BUS_COUNTRY  				:= pinput.ACTION_NEW_COUNTRY;
			SELF.SEQ_NO 					:= 0;
			SELF.filing_type_code           := pinput.action_code;
			SELF.Prep_Old_Addr_Line1        := pInput.Prep_Old_Addr_Line1;
			SELF.Prep_Old_Addr_Line_Last    := pInput.Prep_Old_Addr_Line_Last;
			SELF.Prep_Addr_Line1						:= pInput.prep_new_addr_line1;
			SELF.Prep_Addr_Line_Last				:= pInput.Prep_new_Addr_Line_Last;
			SELF                            := pInput;
			

      END;
	  
Layout_temp tITERATEF (Layout_temp   pLEFT, Layout_temp  PRIGHT, unsigned6 I)
  :=TRANSFORM
           
			SELF.filing_type                := IF (pLEFT.Prep_Addr_Line1<>pRIGHT.Prep_Addr_Line1 AND pLEFT.Prep_Addr_Line1<>'' ,'CHF','INITIAL');
			SELF.expiration_date            := IF (pLEFT.expiration_date=0,pRIGHT.expiration_date,pLEFT.expiration_date);
	        SELF.filing_type_code           := (STRING3) I;
			SELF   	             			:= pRIGHT;
       END;
	   
Layout_temp tITERATEE (Layout_temp   pLEFT, Layout_temp  PRIGHT)
  :=TRANSFORM
  
            Boolean addr_ind            := IF(pRIGHT.Prep_Addr_Line1='' and pRIGHT.Prep_Addr_Line_Last ='',True,False);
			
			SELF.orig_FEIN              := IF (addr_ind, pLEFT.orig_FEIN ,pRIGHT.orig_FEIN );      
	    SELF.Prep_Addr_Line1			:= IF (addr_ind, pLEFT.Prep_Addr_Line1,pRIGHT.Prep_Addr_Line1);
			SELF.Prep_Addr_Line_Last	:= IF (addr_ind, pLEFT.Prep_Addr_Line_Last,pRIGHT.Prep_Addr_Line_Last);
			SELF.BUS_ADDRESS1 				:= IF (addr_ind, pLEFT.BUS_ADDRESS1,pRIGHT.BUS_ADDRESS1);
			SELF.BUS_ADDRESS2 				:= IF (addr_ind, pLEFT.BUS_ADDRESS2,pRIGHT.BUS_ADDRESS2);
			SELF.BUS_CITY               := IF (addr_ind, pLEFT.BUS_CITY,pRIGHT.BUS_CITY);
			SELF.BUS_COUNTY 			:= IF (addr_ind, pLEFT.BUS_COUNTY,pRIGHT.BUS_COUNTY);
			SELF.BUS_STATE              := IF (addr_ind, pLEFT.BUS_STATE,pRIGHT.BUS_STATE);
			SELF.BUS_ZIP 			    := IF (addr_ind, pLEFT.BUS_ZIP,pRIGHT.BUS_ZIP);
			SELF.BUS_ZIP4  			    := IF (addr_ind, pLEFT.BUS_ZIP4,pRIGHT.BUS_ZIP4);
			SELF.BUS_COUNTRY  		    := IF (addr_ind,pLEFT.BUS_COUNTRY,PRIGHT.BUS_COUNTRY);
			SELF             			:= pRIGHT;
       END;

Layout_temp tITERATE  (Layout_temp   pLEFT, Layout_temp  PRIGHT)
  :=TRANSFORM
            Boolean addr_ind            := IF(pRIGHT.Prep_addr_line1='' and pRIGHT.Prep_Addr_Line_Last='',True,False);
			
			SELF.expiration_date        := IF (pLEFT.expiration_date=0,pRIGHT.expiration_date,pLEFT.expiration_date);
			SELF.orig_filing_date       := IF (pLEFT.orig_filing_date=0,pRIGHT.orig_filing_date,pLEFT.orig_filing_date);
			SELF.orig_FEIN              := IF (addr_ind, pLEFT.orig_FEIN ,pRIGHT.orig_FEIN );      
	    SELF.Prep_Addr_Line1			:= IF (addr_ind, pLEFT.Prep_Addr_Line1,pRIGHT.Prep_Addr_Line1);
			SELF.Prep_Addr_Line_Last	:= IF (addr_ind, pLEFT.Prep_Addr_Line_Last,pRIGHT.Prep_Addr_Line_Last);
			SELF.BUS_ADDRESS1 			:= IF (addr_ind, pLEFT.BUS_ADDRESS1,pRIGHT.BUS_ADDRESS1);
			SELF.BUS_ADDRESS2 			:= IF (addr_ind, pLEFT.BUS_ADDRESS2,pRIGHT.BUS_ADDRESS2);
			SELF.BUS_CITY               := IF (addr_ind, pLEFT.BUS_CITY,pRIGHT.BUS_CITY);
			SELF.BUS_COUNTY 			:= IF (addr_ind, pLEFT.BUS_COUNTY,pRIGHT.BUS_COUNTY);
			SELF.BUS_STATE              := IF (addr_ind, pLEFT.BUS_STATE,pRIGHT.BUS_STATE);
			SELF.BUS_ZIP 			    := IF (addr_ind, pLEFT.BUS_ZIP,pRIGHT.BUS_ZIP);
			SELF.BUS_ZIP4  			    := IF (addr_ind, pLEFT.BUS_ZIP4,pRIGHT.BUS_ZIP4);
			SELF.BUS_COUNTRY  		    := IF (addr_ind,pLEFT.BUS_COUNTRY,PRIGHT.BUS_COUNTRY);
		
	    SELF   	             			:= pRIGHT;
   END;
Layout_temp tOldAddress  (Layout_temp   pLEFT, Layout_temp  PRIGHT)
  :=TRANSFORM
            
      Boolean addr_ind            := IF(pRIGHT.Prep_Old_addr_line1='' and pRIGHT.Prep_Old_Addr_Line_Last='',True,False);
							 
			SELF.orig_FEIN              := IF (pRIGHT.orig_FEIN>0, (INTEGER) pRIGHT.ACTION_OLD_FEI,pLEFT.orig_FEIN  );      
	    SELF.Prep_Addr_Line1				:= IF (pRIGHT.Prep_Old_Addr_Line1<>'',pRIGHT.Prep_Old_Addr_Line1,pLEFT.Prep_Addr_Line1);
			SELF.Prep_Addr_Line_Last		:= IF (pRIGHT.Prep_Old_Addr_Line_Last<>'',pRIGHT.Prep_Old_Addr_Line_Last,pLEFT.Prep_Addr_Line_Last);
			SELF.BUS_ADDRESS1 					:= IF (addr_ind,pRIGHT.ACTION_OLD_ADDR1, pLEFT.BUS_ADDRESS1);
			SELF.BUS_ADDRESS2 					:= IF (addr_ind,pRIGHT.ACTION_OLD_ADDR2, pLEFT.BUS_ADDRESS2);
			SELF.BUS_CITY            		:= IF (addr_ind,pRIGHT.ACTION_OLD_CITY, pLEFT.BUS_CITY);
			SELF.BUS_COUNTY 						:= IF (addr_ind,pRIGHT.ACTION_OLD_COUNTY, pLEFT.BUS_COUNTY);
			SELF.BUS_STATE           		:= IF (addr_ind,pRIGHT.ACTION_OLD_STATE  , pLEFT.BUS_STATE);
			SELF.BUS_ZIP 			    			:= IF (addr_ind,(INTEGER) pRIGHT.ACTION_OLD_ZIP5, pLEFT.BUS_ZIP);
			SELF.BUS_ZIP4  			    		:= IF (addr_ind,(INTEGER) pRIGHT.ACTION_OLD_ZIP4, pLEFT.BUS_ZIP4);
			SELF.filing_type_code    		:= '';
		  SELF                   	 	:= pLEFT;
	END;

layout_common.Business_AID tMerge(Layout_temp pInput)
   :=TRANSFORM
            SELF.tmsid					    := 'FL'+pInput.Orig_filing_number;
			SELF.rmsid					    :=  trim(pinput.filing_type_code,all)+pInput.filing_number;
			SELF.dt_first_seen      		:= if(_validate.date.fIsValid((string) pInput.orig_filing_date), (integer) pInput.orig_filing_date,0); 
			SELF.dt_last_seen       		:= if(_validate.date.fIsValid((string) pInput.filing_date), (integer) pInput.filing_date,0); 
			SELF.dt_vENDor_first_reported  	:= if(_validate.date.fIsValid((string) pInput.process_date), (integer) pInput.process_date,0); 
			SELF.dt_vENDor_last_reported  	:= if(_validate.date.fIsValid((string) pInput.process_date), (integer) pInput.process_date,0); 
			SELF.Filing_Jurisdiction 		:= 'FL';
			SELF.bus_status  				:=  IF(pInput.EXPIRATION_DATE<STD.Date.Today(),'INACTIVE',pInput.bus_status);
			self.MAIL_Street                :=  Pinput.bus_ADDRESS1; 
			self.Mail_CITY					:=  pInput.Bus_CITY;
			self.Mail_state					:=  pInput.Bus_state;
			self.Mail_zip					:=  (string)pInput.Bus_zip+pInput.Bus_zip4;
			self.Prep_Addr_Line1					:= pinput.prep_addr_line1;
			self.Prep_Addr_Line_last			:= pinput.prep_addr_line_Last;
			self.Prep_Mail_Addr_Line1			:= pinput.Prep_Addr_Line1;
			self.Prep_Mail_Addr_Line_last	:= pinput.Prep_Addr_Line_Last;			
			SELF						    					:=  pInput;
	END;

layout_common.Business_AID tAddSeq(layout_common.Business_AID pInput ,INTEGER c)	
	:=TRANSFORM
			SELF.seq_no	:=c;
			SELF		:=pinput;
	END;

layout_common.Business_AID  ROLLUPXform(layout_common.Business_AID pLEFT, layout_common.Business_AID pRIGHT) 
	:= TRANSFORM
		
		SELF.Dt_First_Seen := ut.Min2(pLEFT.dt_First_Seen,pRIGHT.dt_First_Seen);
		SELF.Dt_Last_Seen  := MAX(pLEFT.dt_Last_Seen ,pRIGHT.dt_last_seen);
		SELF.Dt_VENDor_First_Reported := ut.min2(pLEFT.dt_VENDor_First_Reported,pRIGHT.dt_VENDor_First_Reported);
		SELF.Dt_VENDor_Last_Reported  := MAX(pLEFT.dt_VENDor_Last_Reported,pRIGHT.dt_VENDor_Last_Reported);
	    SELF := pLEFT;
	END;
	
dFiling		:=GROUP(SORT(DISTRIBUTE(DEDUP(PROJECT(									
									File_FL_Filing_in.Cleaned,tfiling(LEFT )),ALL),
                                 HASH(orig_filing_number)),
							orig_filing_number,EXPIRATION_DATE,LOCAL),
					  orig_filing_number);

dFilingType :=UNGROUP(ITERATE(dFiling, tITERATEf(LEFT,RIGHT,COUNTER)));
                             
dPreInit    :=DEDUP(sort(dFilingType(filing_type[1]='I'),orig_filing_number,-filing_type_code,LOCAL),orig_filing_number,LOCAL);
							 
dGroupEven  :=GROUP(SORT(DISTRIBUTE(DEDUP(PROJECT(
										File_FL_Event_in.Cleaned(action_code<>'REN'), tevent(LEFT)),ALL,EXCEPT filing_date),
                                    HASH(orig_filing_number)),
					     ORIG_FILING_NUMBER,FILING_DATE,IF(FILING_TYPE_CODE='CHF',0,1),LOCAL),
					ORIG_FILING_NUMBER);
					
dDistEvent  :=UNGROUP(DEDUP(ITERATE(dGroupEven, tITERATEE(LEFT,RIGHT)),ALL)); 
				  
doldAddr    :=DEDUP(sort(dDistEvent(filing_type_code='CHF'),orig_filing_number,filing_date,LOCAL),orig_filing_number,LOCAL);

dInit       :=JOIN(dPreinit,doldAddr, LEFT.orig_filing_number=RIGHT.orig_filing_number
							,tOldAddress(LEFT,RIGHT),LEFT OUTER);

dPreMerge   :=GROUP(SORT(DISTRIBUTE(dInit+dDistEvent ,HASH(orig_filing_number)),orig_filing_number,filing_date,LOCAL),orig_filing_number);

dMerge      :=PROJECT(ITERATE(dPreMerge,tITERATE(LEFT,RIGHT)),tmerge(LEFT));


dGroupMerge :=GROUP(SORT(dMerge,orig_filing_number,rmsid),orig_filing_number,rmsid);
					
dROLLUP     :=ROLLUP(dGroupMerge ,ROLLUPXform(LEFT,RIGHT),LEFT.orig_filing_number=RIGHT.orig_filing_number AND 
                             LEFT.rmsid=RIGHT.rmsid);

dGroup      :=GROUP(SORT(dROLLUP
					,ORIG_FILING_NUMBER,filing_date)
			   ,ORIG_FILING_NUMBER);
			  
dOut        :=Project(dgroup,tAddSeq(LEFT, COUNTER)):PERSIST(Cluster.cluster_out+'PERSIST::FBNV2::FL::Business');
 

EXPORT Mapping_FBN_FL_Business      :=	dOut       ;