import address, did_add, didville,ut,header_slimsort,UccV2,business_header,Business_Header_SS;

dMaster	 			     	:= sort(distribute(file_ca_Filing_Master_in,hash(initial_filing_number)),initial_filing_number,filing_status,-process_date,local);
dfile								:= File_CA_Main_Base;


Layout_UCC_Common.Filing  TFiling(dMaster pLeft) 
   := 
   TRANSFORM
      
			//The vendor no longer sends the filing status.  The filing status is derived based on the lapse date
			self.tmsid 				 := 'CA'+pLeft.initial_filing_number;
			self.rmsid 				 := 'CA'+pLeft.filing_status+if(pLeft.ucc3_filing='',pLeft.initial_filing_number,pLeft.ucc3_filing);
			self.Filing_Jurisdiction := 'CA';
			self.orig_filing_number  := pLeft.initial_filing_number;
			self.orig_filing_type	   := if(trim(pLeft.ucc_filing_type_desc) = 'LIEN FINANCING STMT' and trim(pLeft.initial_filing_number) = trim(pLeft.ucc3_filing), 
			                               trim(pLeft.filing_type_id) + ' - ' + trim(pLeft.ucc_filing_type_desc), '');
			self.orig_filing_date	   := if(trim(pLeft.ucc_filing_type_desc) = 'LIEN FINANCING STMT' and trim(pLeft.initial_filing_number) = trim(pLeft.ucc3_filing), trim(pLeft.filing_date), '');
			self.orig_filing_time    := if(trim(pLeft.ucc_filing_type_desc) = 'LIEN FINANCING STMT' and trim(pLeft.initial_filing_number) = trim(pLeft.ucc3_filing), trim(pLeft.filing_time), '');
			self.filing_number		   := pLeft.ucc3_filing;
			self.filing_type		     := if(trim(pLeft.ucc_filing_type_desc) <> 'LIEN FINANCING STMT' and trim(pLeft.initial_filing_number) <> trim(pLeft.ucc3_filing), 
			                               trim(pLeft.ucc_filing_type_desc), '');
			self.filing_date		     := if(trim(pLeft.ucc_filing_type_desc) <> 'LIEN FINANCING STMT' and trim(pLeft.initial_filing_number) <> trim(pLeft.ucc3_filing), trim(pLeft.filing_date), '');
			self.filing_time		     := if(trim(pLeft.ucc_filing_type_desc) <> 'LIEN FINANCING STMT' and trim(pLeft.initial_filing_number) <> trim(pLeft.ucc3_filing), trim(pLeft.filing_time), '');
			self.page				         := if((integer)pLeft.page_count <> 0, trim(pLeft.page_count), '');
			self.expiration_date	   := pLeft.lapse_date;
			self.filing_status       := pLeft.filing_status;
			self.status_type         := if(trim(pLeft.filing_status) = 'A', 'ACTIVE','LAPSED');
			self			               := pleft;
   END; 


Layout_UCC_Common.layout_ucc_new Tucc_layout(Layout_UCC_Common.Filing pLeft)
   :=
   TRANSFORM
          self   := pLeft;
		      self	 := []; 
   
   END;
	 
recordof(dMAster) tRollupDuplicates(dMaster pLeft,  dMaster pRight)
  :=
   TRANSFORM
	 	 self           	  		 := pLeft;
	 
	End;

Layout_UCC_Common.layout_ucc_new tRollupStatus(Layout_UCC_Common.layout_ucc_new pLeft,Layout_UCC_Common.layout_ucc_new pRight)
   :=
    TRANSFORM
	 	 self.filing_status          := if (pLeft.filing_status='L' or pLeft.filing_status='' ,pLeft.filing_status,pRight.filing_status);
		 self.Status_type            := if (pLeft.Status_type[1]='L' or pLeft.Status_type[1]='',pLeft.Status_type,pRight.Status_type);
		 self                        := pleft; 
	 
	End;

dSortMaster                    := rollup(dmaster,tRollupDuplicates(left,right),initial_filing_number,filing_status,ucc_filing_type_desc,local);
mapFiling := project(dSortMaster,TFiling(left));
							   
dMainBase                        := project(mapFiling,Tucc_layout(left));
											
dfinalBase := dMainBase + dfile;


// *******************************************************
AddRecordID := uccv2.fnAddPersistentRecordID_Main(dfinalBase);

dDedup                               :=  dedup(AddRecordID,except process_date,vendor_entry_date,vendor_upd_date,rmsid, ALL);																
dsort                                :=  sort(distribute(dDedup,hash(tmsid,filing_number)),record,local);
Outmain                              :=  rollup(dsort(tmsid<>'CA057017217898'),tRollupStatus(left,right),except filing_status,Status_type,rmsid,process_date,local);

export proc_build_CA_main_base       :=	Outmain;