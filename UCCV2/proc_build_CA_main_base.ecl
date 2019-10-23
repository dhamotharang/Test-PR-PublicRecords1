import address, did_add, didville,ut,header_slimsort,UccV2,business_header,Business_Header_SS;

dMaster	 			             	:= sort(distribute(file_ca_Filing_Master_in,hash(initial_filing_number)),initial_filing_number,filing_status,-process_date,local);
dUcc3      	 			 			:= sort(distribute(file_ca_ucc3_in,hash(initial_filing_number)),initial_filing_number,ucc3_filing,-process_date,local);
dCollateral	 			            := file_ca_Collateral_in;
dfile								:= File_CA_Main_Base;


layout_collateral 
   :=record
       	string31 	tmsid;	
		string512 	collateral_desc ;
		dCollateral.ucc3_filing_number;
 end;
	 

Layout_UCC_Common.Filing  TFiling(dMaster pLeft, dUcc3 pRight) 
   := 
   TRANSFORM
          
			self.tmsid 				 := 'CA'+pLeft.initial_filing_number;
			self.rmsid 				 := 'CA'+pLeft.filing_status+if(pRight.ucc3_filing='',pLeft.initial_filing_number,pRight.ucc3_filing);
			self.static_value		 :=	if((integer) pLeft.static>0,pLeft.static,'');
			self.Filing_Jurisdiction := 'CA';
			self.orig_filing_number  := pLeft.initial_filing_number;
			self.orig_filing_type	 := pLeft.ucc_filing_type_desc;
			self.orig_filing_date	 := pLeft.filing_date;
			self.orig_filing_time    := pLeft.filing_time;
			self.filing_number		 := pRight.ucc3_filing;
			self.filing_type		 := pRight.ucc3_filing_desc;
			self.filing_date		 := pRight.ucc3_filing_date;
			self.filing_time		 := pRight.ucc3_filing_time;
			self.page				 := pRight.ucc3_page_count;
			self.expiration_date	 := pLeft.lapse_date;
			self.Status_type		 := pLeft.ucc_status_desc;
			self.filing_status       := pLeft.filing_status;
			self.microfilm_number	 := pRight.ucc3_internal_document_no;
			self			         := pleft;
   END; 

layout_collateral  tCollateral(dCollateral pInput) 
   := 
   TRANSFORM
          
			self.tmsid 				 := 'CA'+pInput.initial_filing_number;			
			self.collateral_desc	 := pInput.all_collateral;
			self.ucc3_filing_number  := pInput.ucc3_filing_number;
   END; 
   
  

Layout_UCC_Common.layout_ucc_new Tadd_collateral(Layout_UCC_Common.Filing pLeft, layout_collateral pRight)
   :=
   TRANSFORM
          self                       := pLeft;
		  self						 := pRight; 
   
   END;
recordof(dMAster) tRollupDuplicates(dMaster pLeft,  dMaster pRight)
  :=
   TRANSFORM
	 	 self           	  		 := pLeft;
	 
	End;

recordof(dUCC3) tRollupdedup(dUCC3 pLeft,  dUCC3 pRight)
  :=
   TRANSFORM
	 	 self           	  		 := pLeft;
	 
	End;
Layout_UCC_Common.layout_ucc_new tRollupStatus(Layout_UCC_Common.layout_ucc_new pLeft,Layout_UCC_Common.layout_ucc_new Pright)
   :=
    TRANSFORM
	 	 self.filing_status          := if (pLeft.filing_status='L' or pLeft.filing_status='' ,pLeft.filing_status,pright.filing_status);
		 self.Status_type            := if (pLeft.Status_type[1]='L' or pLeft.Status_type[1]='',pLeft.Status_type,pright.Status_type);
		 self                        := pleft; 
	 
	End;


dSortMaster                   		 := rollup(dmaster,tRollupDuplicates(left,right),initial_filing_number,filing_status,local);
dSortUCC3                   		 := rollup(ducc3,tRollupdedup(left,right),initial_filing_number,ucc3_filing,local);
   
dSortCollateral                      := distribute(dedup(project(dCollateral, tCollateral(left)),all),hash(tmsid)) ;
											   
dJoinFiling                          := distribute(join(dSortMaster ,
											dSortUCC3,
											left.initial_filing_number=right.initial_filing_number ,
											TFiling(left,right),
											left outer,local),hash(tmsid)) ;
											
dMainBase                            := join(dJoinFiling(filing_number <> '') ,
											dSortCollateral ,
											left.tmsid=right.tmsid and 
											left.filing_number=right.ucc3_filing_number,
											Tadd_collateral(left,right),
											left outer,local);
											
// *******************************************************
// Collateral data is not getting populated
// So this  section of the code is more like a patch to the existing code

nofilingnumber := dJoinFiling(filing_number = '');

dMainBase1                            := join(nofilingnumber ,
											dSortCollateral ,
											left.tmsid=right.tmsid,
											Tadd_collateral(left,right),
											left outer,local);

dfinalBase := dMainBase1 + dMainBase + dfile;

// *******************************************************
AddRecordID := uccv2.fnAddPersistentRecordID_Main(dfinalBase);

dDedup                               :=  dedup(AddRecordID,except process_date,vendor_entry_date,vendor_upd_date,rmsid, ALL);																
dsort                                :=  sort(distribute(dDedup,hash(tmsid,filing_number)),record,local);
Outmain                              :=  rollup(dsort(tmsid<>'CA057017217898'),tRollupStatus(left,right),except filing_status,Status_type,rmsid,process_date,local);

export proc_build_CA_main_base       :=	Outmain;