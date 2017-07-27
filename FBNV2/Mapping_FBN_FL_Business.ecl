import ut,fbnv2;
					 
Layout_temp :=RECORD
       layout_common.Bus;
	   string182 	Clean_address;
	   string3 	 	filing_type_code ;
	   string9 	 	ACTION_OLD_FEI                    :='';
	   string12		ACTION_OLD_COUNTY                 :='';
	   string40 	ACTION_OLD_ADDR1                  :='';
	   string40 	ACTION_OLD_ADDR2                  :='';
	   string28 	ACTION_OLD_CITY                   :='';
	   string2 		ACTION_OLD_STATE                  :='';
       string5 		ACTION_OLD_ZIP5                   :='';
	   string4 		ACTION_OLD_ZIP4                   :='';
	   string40 	ACTION_OLD_COUNTRY                :='';
	   string182 	Clean_Old_address				  :='';
	   End;

Layout_temp tFiling(File_FL_Filing_in pInput)
   :=TRANSFORM
            
			Self.FILING_NUMBER 			    := pInput.FIC_FIL_DOC_NUM ;
			self.Filing_date            	:= (integer) pInput.FIC_FIL_DATE;
			self.EXPIRATION_DATE  			:= (integer) pInput.FIC_FIL_EXPIRATION_DATE;
			self.CANCELLATION_DATE 			:= (integer) pInput.FIC_FIL_CANCELLATION_DATE;
			self.ORIG_FILING_NUMBER 		:= pInput.FIC_FIL_DOC_NUM;
			self.ORIG_FILING_DATE     		:= (integer) pInput.FIC_FIL_DATE;
			self.BUS_NAME 					:= pInput.FIC_FIL_NAME;
			SELF.LONG_BUS_NAME              := pInput.FIC_FIL_NAME;
			self.bus_status  				:= pInput.FIC_FIL_STATUS_DEC;
			self.orig_FEIN    				:= (integer) pInput.FIC_FIL_FEI_NUM  ;
			self.BUS_ADDRESS1 				:= pInput.FIC_FIL_ADDR1;
			self.BUS_ADDRESS2 				:= pInput.FIC_FIL_ADDR2;
			self.BUS_CITY                 	:= pInput.FIC_FIL_CITY;
			self.BUS_COUNTY 				:= pInput.FIC_FIL_COUNTY;
			self.BUS_STATE               	:= pInput.FIC_FIL_STATE;
			self.BUS_ZIP 					:= (integer) pInput.FIC_FIL_ZIP5;
			self.BUS_ZIP4  					:= (integer) pInput.FIC_FIL_ZIP4;
			self.BUS_COUNTRY  				:= pInput.FIC_FIL_COUNTRY;
			self.SEQ_NO 					:= 0;
			self.filing_type_code           := '';
			self                            := pInput;
			
      end;

Layout_temp tEvent(File_FL_Event_in  pInput)
   :=TRANSFORM
           
			self.FILING_NUMBER 			    := pInput.EVENT_DOC_NUMBER ;
			self.filing_type			    := pInput.ACTION_VERBAGE;
			self.Filing_date            	:= (integer) pInput.EVENT_DATE;
			self.CANCELLATION_DATE 			:= if (pInput.action_code='CAN',(integer) pInput.EVENT_DATE,0);
			self.ORIG_FILING_NUMBER 		:= pInput.EVENT_ORIG_DOC_NUMBER;
			self.BUS_NAME 					:= pinput.EVENT_FIC_NAME;
			self.bus_status  				:= if (pInput.action_code='CAN','CANCELLED','ACTIVE');
			self.orig_FEIN    				:= if (pInput.action_code='CHF',(integer) pinput.ACTION_NEW_FEI,0);
			self.BUS_ADDRESS1 				:= pinput.ACTION_NEW_ADDR1;
			self.BUS_ADDRESS2 				:= pinput.ACTION_NEW_ADDR2;
			self.BUS_CITY                 	:= pinput.ACTION_NEW_CITY;
			self.BUS_COUNTY 				:= pinput.ACTION_NEW_COUNTY;
			self.BUS_STATE               	:= pinput.ACTION_NEW_STATE;
			self.BUS_ZIP 					:= (integer) pinput.ACTION_NEW_ZIP5;
			self.BUS_ZIP4  					:= (integer) pinput.ACTION_NEW_ZIP4;
			self.BUS_COUNTRY  				:= pinput.ACTION_NEW_COUNTRY;
			self.SEQ_NO 					:= 0;
			self.filing_type_code           := pinput.action_code;
			self.clean_old_address          := pInput.clean_action_old_address;
			self                            := pInput;
			

      end;
	  
Layout_temp tIterateF (Layout_temp   pLeft, Layout_temp  Pright, unsigned6 I)
  :=TRANSFORM
           
			self.filing_type                := if (pleft.clean_address<>pright.clean_address and pleft.clean_address<>'' ,'CHF','INITIAL');
			self.expiration_date            := if (pleft.expiration_date=0,pright.expiration_date,pleft.expiration_date);
	        self.filing_type_code           := (string3) I;
			self   	             			:= pRight;
       END;
	   
Layout_temp tIterateE (Layout_temp   pLeft, Layout_temp  Pright)
  :=TRANSFORM
  
            Boolean addr_ind            := if(pright.clean_address='',True,False);
			
			self.orig_FEIN              := if (addr_ind, pleft.orig_FEIN ,pright.orig_FEIN );      
	        self.clean_address			:= if (addr_ind, pleft.clean_address,pright.clean_address);
			self.BUS_ADDRESS1 			:= if (addr_ind, pLeft.BUS_ADDRESS1,pRight.BUS_ADDRESS1);
			self.BUS_ADDRESS2 			:= if (addr_ind, pLeft.BUS_ADDRESS2,pRight.BUS_ADDRESS2);
			self.BUS_CITY               := if (addr_ind, pLeft.BUS_CITY,pRight.BUS_CITY);
			self.BUS_COUNTY 			:= if (addr_ind, pLeft.BUS_COUNTY,pRight.BUS_COUNTY);
			self.BUS_STATE              := if (addr_ind, pLeft.BUS_STATE,pRight.BUS_STATE);
			self.BUS_ZIP 			    := IF (addr_ind, pLeft.BUS_ZIP,pRight.BUS_ZIP);
			self.BUS_ZIP4  			    := IF (addr_ind, pLeft.BUS_ZIP4,pRight.BUS_ZIP4);
			self.BUS_COUNTRY  		    := IF (addr_ind,pLeft.BUS_COUNTRY,PrIGHT.BUS_COUNTRY);
			self             			:= pRight;
       END;

Layout_temp tIterate  (Layout_temp   pLeft, Layout_temp  Pright)
  :=TRANSFORM
            Boolean addr_ind            := if(pright.clean_address='',True,False);
			
			self.expiration_date        := if (pleft.expiration_date=0,pright.expiration_date,pleft.expiration_date);
			self.orig_filing_date       := if (pleft.orig_filing_date=0,pright.orig_filing_date,pleft.orig_filing_date);
			self.orig_FEIN              := if (addr_ind, pleft.orig_FEIN ,pright.orig_FEIN );      
	        self.clean_address			:= if (addr_ind, pleft.clean_address,pright.clean_address);
			self.BUS_ADDRESS1 			:= if (addr_ind, pLeft.BUS_ADDRESS1,pRight.BUS_ADDRESS1);
			self.BUS_ADDRESS2 			:= if (addr_ind, pLeft.BUS_ADDRESS2,pRight.BUS_ADDRESS2);
			self.BUS_CITY               := if (addr_ind, pLeft.BUS_CITY,pRight.BUS_CITY);
			self.BUS_COUNTY 			:= if (addr_ind, pLeft.BUS_COUNTY,pRight.BUS_COUNTY);
			self.BUS_STATE              := if (addr_ind, pLeft.BUS_STATE,pRight.BUS_STATE);
			self.BUS_ZIP 			    := IF (addr_ind, pLeft.BUS_ZIP,pRight.BUS_ZIP);
			self.BUS_ZIP4  			    := IF (addr_ind, pLeft.BUS_ZIP4,pRight.BUS_ZIP4);
			self.BUS_COUNTRY  		    := IF (addr_ind,pLeft.BUS_COUNTRY,PrIGHT.BUS_COUNTRY);
		
	      	self   	             			:= pRight;
       END;
Layout_temp tOldAddress  (Layout_temp   pLeft, Layout_temp  Pright)
  :=TRANSFORM
            
			
			self.orig_FEIN              := if (pright.orig_FEIN>0, (integer) pright.ACTION_OLD_FEI,pleft.orig_FEIN  );      
	        self.clean_address			:= if (pright.clean_Old_address<>'',pright.clean_Old_address,pleft.clean_address);
			self.BUS_ADDRESS1 			:= if (pright.clean_Old_address<>'',pRight.ACTION_OLD_ADDR1, pLeft.BUS_ADDRESS1);
			self.BUS_ADDRESS2 			:= if (pright.clean_Old_address<>'',pRight.ACTION_OLD_ADDR2, pLeft.BUS_ADDRESS2);
			self.BUS_CITY               := if (pright.clean_Old_address<>'',pRight.ACTION_OLD_CITY, pLeft.BUS_CITY);
			self.BUS_COUNTY 			:= if (pright.clean_Old_address<>'',pRight.ACTION_OLD_COUNTY, pLeft.BUS_COUNTY);
			self.BUS_STATE              := if (pright.clean_Old_address<>'',pRight.ACTION_OLD_STATE  , pLeft.BUS_STATE);
			self.BUS_ZIP 			    := IF (pright.clean_Old_address<>'',(integer) pRight.clean_Old_address[117..121], pLeft.BUS_ZIP);
			self.BUS_ZIP4  			    := IF (pright.clean_Old_address<>'',(integer) pRight.clean_Old_address[122..125], pLeft.BUS_ZIP4);
			self.filing_type_code       := '';
		   	self                        := pleft;
			END;

layout_common.Business tMerge(Layout_temp pInput)
   :=TRANSFORM
            self.tmsid					    := 'FL'+pInput.Orig_filing_number;
			self.rmsid					    :=  trim(pinput.filing_type_code)+pInput.filing_number;
			self.dt_first_seen      		:= (integer) pInput.orig_filing_date;
			self.dt_last_seen       		:= (integer) pInput.filing_date;
			self.dt_vendor_first_reported  	:= (integer) pInput.orig_filing_date;
			self.dt_vendor_last_reported  	:= (integer) pInput.filing_DATE;
			self.Filing_Jurisdiction 		:= 'FL';
			self.bus_status  				:=  if(pInput.EXPIRATION_DATE<(unsigned6)(ut.GetDate),'INACTIVE',pInput.bus_status);
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
			self.mail_prim_range 			:=	pInput.clean_address[1..10];		
			self.mail_predir 				:=	pInput.clean_address[11..12];		
			self.mail_prim_name 			:=	pInput.clean_address[13..40];		
			self.mail_addr_suffix			:=	pInput.clean_address[41..44];		
			self.mail_postdir 				:=	pInput.clean_address[45..46];		
			self.mail_unit_desig 			:=	pInput.clean_address[47..56];		
			self.mail_sec_range 			:=	pInput.clean_address[57..64];		
			self.mail_v_city_name 			:=	pInput.clean_address[90..114];		
			self.mail_st 					:=	pInput.clean_address[115..116];		
			self.mail_zip5 					:=	pInput.clean_address[117..121];		
			self.mail_zip4 					:=	pInput.clean_address[122..125];		
			self.mail_addr_rec_type			:=	pInput.clean_address[139..140];		
			self.mail_fips_state 			:=	pInput.clean_address[141..142];		
			self.mail_fips_county 			:=  pInput.clean_address[143..145];			
			self.mail_geo_lat 				:=	pInput.clean_address[146..155];		
			self.mail_geo_long 				:=	pInput.clean_address[156..166];		
			self.mail_cbsa					:=	pInput.clean_address[167..170];		
			self.mail_geo_blk 				:=	pInput.clean_address[171..177];		
			self.mail_geo_match 			:=	pInput.clean_address[178];		
			self.mail_err_stat 				:=	pInput.clean_address[179..182];	
			Self						    :=  pInput;
      end;

layout_common.Business tAddSeq(layout_common.Business pInput ,integer c)	
	:=transform
			self.seq_no	:=c;
			self		:=pinput;
	end;

layout_common.Business  rollupXform(layout_common.Business pLeft, layout_common.Business pRight) 
	:= transform
		
		self.Dt_First_Seen := IF(pLeft.dt_First_Seen > pRight.dt_First_Seen, pRight.dt_First_Seen, pLeft.dt_First_Seen);
		self.Dt_Last_Seen  := IF(pLeft.dt_Last_Seen  < pRight.dt_Last_Seen,  pRight.dt_Last_Seen,  pLeft.dt_Last_Seen);
		self.Dt_Vendor_First_Reported := IF(pLeft.dt_Vendor_First_Reported > pRight.dt_Vendor_First_Reported, 
											pRight.dt_Vendor_First_Reported, pLeft.dt_Vendor_First_Reported);
		self.Dt_Vendor_Last_Reported  := IF(pLeft.dt_Vendor_Last_Reported  < pRight.dt_Vendor_Last_Reported,  
											pRight.dt_Vendor_Last_Reported, pLeft.dt_Vendor_Last_Reported);
		self := pLeft;
	END;
	
dFiling		:=group(sort(DISTRIBUTE(DEDUP(PROJECT(File_FL_Filing_in,tfiling(left )),all),
                                 HASH(orig_filing_number)),
							orig_filing_number,EXPIRATION_DATE,local),
					  orig_filing_number);

dFilingType :=ungroup(iterate(dFiling, tIteratef(left,right,counter)));
                             
dPreInit    :=dedup(sort(dFilingType(filing_type[1]='I'),orig_filing_number,-filing_type_code,local),orig_filing_number,local);
							 
dGroupEven  :=Group(sort(DISTRIBUTE(DEDUP(PROJECT(File_FL_Event_in(action_code<>'REN'), tevent(left)),all,except filing_date),
                                    HASH(orig_filing_number)),
					     ORIG_FILING_NUMBER,FILING_DATE,if(FILING_TYPE_CODE='CHF',0,1),local),
					ORIG_FILING_NUMBER);
					
dDistEvent  :=ungroup(dedup(iterate(dGroupEven, tIterateE(left,right)),all)); 
				  
doldAddr    :=dedup(sort(dDistEvent(filing_type_code='CHF'),orig_filing_number,filing_date,local),orig_filing_number,local);

dInit       :=join(dPreinit,doldAddr, left.orig_filing_number=right.orig_filing_number
							,tOldAddress(left,right),left outer);

dPreMerge   :=group(SORT(DISTRIBUTE(dInit+dDistEvent ,HASH(orig_filing_number)),orig_filing_number,filing_date,local),orig_filing_number);

dMerge      :=PROJECT(ITERATE(dPreMerge,tIterate(LEFT,RIGHT)),tmerge(left));


dGroupMerge :=group(SORT(dMerge,orig_filing_number,rmsid),orig_filing_number,rmsid);
					
drollup     :=rollup(dGroupMerge ,rollupXform(left,right),left.orig_filing_number=right.orig_filing_number and 
                             left.rmsid=right.rmsid);

dGroup      :=group(sort(dRollup
					,ORIG_FILING_NUMBER,filing_date)
			   ,ORIG_FILING_NUMBER);
			  
dOut        :=Project(dgroup,tAddSeq(left, counter)):persist(Cluster.cluster_out+'persist::FBNV2::FL::Business');
 

export Mapping_FBN_FL_Business      :=	dOut       ;