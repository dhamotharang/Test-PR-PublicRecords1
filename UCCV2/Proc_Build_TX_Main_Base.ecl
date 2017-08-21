import address, did_add, didville,ut,header_slimsort,UCCV2,business_header,Business_Header_SS;

dMaster	 			             	:= File_TX_Master_in;
dUcc3      	 			 			:= File_TX_AMENDMENT_in;	
dCollateral                         := File_TX_Collateral_in;
dFile                               := File_TX_Main_Base;

layout_ucc_common.Layout_UCC_new TFiling(dMaster pLeft, dUcc3 pRight) 
   := 
   TRANSFORM
          
			self.tmsid 				 := 'TX'+pLeft.original_filing_number; 
			self.rmsid 				 := 'TX'+if(pRight.ucc3_filing_number='',pLeft.original_filing_number,pRight.ucc3_filing_number); 
			self.Filing_Jurisdiction := 'TX';
			self.orig_filing_number  := pLeft.original_filing_number; 
			self.orig_filing_type    := 'ORIGINAL FILING';
			self.orig_filing_date    := if(pRight.amendment_type='UCC STANDARD',
										   pRight.filing_date ,
										   '');
			self.orig_filing_time    := if(pRight.amendment_type='UCC STANDARD',
										   pRight.filing_time ,
										   '');
			self.filing_number		 := if(pRight.ucc3_filing_number>'0',
										   pRight.ucc3_filing_number,
										   pLeft.original_filing_number);
			self.filing_type		 := pRight.amendment_type;
			self.filing_date		 := pRight.filing_date;
			self.filing_time		 := pRight.filing_time;
			self.page			     := pLeft.page_count;
			self.expiration_date	 := pLeft.expiration_date;
			self.Status_type		 := pLeft.filing_status;
			self.description	     := pRight.filing_history_comment;
			self			         := pleft;
   END; 
   
layout_ucc_common.layout_UCC_new TAddCollateral(layout_ucc_common.layout_UCC_new pLeft, dCollateral pRight) 
   := 
   TRANSFORM
          
		self.collateral_desc     := pRight.all_collateral;
		self			         := pleft;
   END;

Layout_UCC_Common.layout_UCC_new  tRollupDuplicates(Layout_UCC_Common.layout_UCC_new  pLeft,  Layout_UCC_Common.layout_UCC_new  pRight)
  :=
   TRANSFORM
		 self           	 := pLeft;
   End;

	  
dSortMaster            	     := sort(distribute(dedup(sort(dMaster,-page_count),except process_date,page_count,all),
                                     hash(original_filing_number)), original_filing_number,local) ;
dSortUCC3	 				 := sort(distribute(dedup(dUCC3,except process_date,all),
									hash(original_filing_number)), original_filing_number,local) ;
dsortCollateral              := sort(distribute(dedup(dCollateral,except process_date,all), 
									hash(original_filing_number)), original_filing_number,local) ;

dJoinFiling                  := join(dSortMaster,
											dSortUCC3,
											left.original_filing_number=right.original_filing_number ,
											TFiling(left,right),
											left outer,local);
dJoinCollaterl               := sort(distribute(join(dJoinFiling ,
											dsortCollateral ,
											left.orig_filing_number=right.original_filing_number ,
											TAddCollateral(left,right),
											left outer,local)+dFile,
											hash(tmsid)),tmsid,rmsid,local);



Outmain                     := rollup(dJoinCollaterl  ,tRollupDuplicates(left,right),tmsid,rmsid,local);
AddRecordID := uccv2.fnAddPersistentRecordID_Main(Outmain);
 

export Proc_Build_TX_Main_Base :=	AddRecordID;
