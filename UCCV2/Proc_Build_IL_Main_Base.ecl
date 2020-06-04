import address, did_add, didville,ut,header_slimsort,UCCv2,business_header,Business_Header_SS;

Master	:= File_IL_Master_in;
dUcc3		:= File_IL_Transaction_in;	
dfile		:= File_IL_Main_Base;

dMaster	:= sort(distribute(table(Master,{process_date,
													products,												
													proceeds,
													file_no,
													file_date,
													file_time,
													financing_pages,
                          maturity_date,
													status,
													collateral,
													transaction_cnt}),hash(file_no)),file_no,-process_date,local);
													
Layout_UCC_Common.layout_UCC_new TFiling(dMaster pLeft , dUcc3 pRight) 
   := 
   TRANSFORM
			string14  proceeds			:=if(pLeft.proceeds='1',',WITH PROCEEDS','');
			string14  products			:=if(pLeft.products='1',',WITH PRODUCTS','');
			
			self.tmsid							:= 'IL'+pLeft.file_no;
			self.rmsid							:= 'IL'+if(pRight.trans_no='',pLeft.file_no,pRight.trans_no);
			self.orig_filing_number := pLeft.file_no;
			self.orig_filing_type		:= 'UCC-1 Financing Statement';
			self.Filing_Jurisdiction:= 'IL';
			self.orig_filing_date		:= pLeft.file_date;
			self.orig_filing_time	 	:= pLeft.file_time;
			self.filing_number			:= pRight.trans_no;
			self.filing_number_indc	:= 'N';
			self.filing_type				:= pRight.trans_type;
			self.filing_date				:= pRight.trans_date;
			self.filing_time				:= pRight.trans_time;
			self.page								:= pLeft.financing_pages;
			self.expiration_date		:= if(pLeft.maturity_date[1..2]='99','',pLeft.maturity_date);
			self.statements_filed		:= pLeft.transaction_cnt;
			self.continuious_expiration:=if(pLeft.maturity_date[1..2]='99','Y','');
			self.Status_type				:= pLeft.status ;
			self.collateral_desc		:= pLeft.collateral+proceeds+products;
			self										:= pleft;
   END; 
   
recordof(dMAster) tRollupDuplicates(dMaster pLeft,  dMaster pRight)
  :=
   TRANSFORM
	 self.collateral						:= if (pleft.collateral='',pRight.collateral,pleft.collateral);
	 self.file_date							:= if (pLeft.process_date>pRight.process_date,pLeft.file_date,pRight.file_date);
	 self.transaction_cnt				:= if (pLeft.process_date>pRight.process_date,pLeft.transaction_cnt,pRight.transaction_cnt);
	 self.maturity_date					:= if (pLeft.process_date>pRight.process_date,pLeft.maturity_date,pRight.maturity_date);
	 self.financing_pages				:= if (pLeft.process_date>pRight.process_date,pLeft.financing_pages,pRight.financing_pages);
	 self												:= pLeft;
end;

dSortMaster	:= sort(distribute(rollup(dmaster,tRollupDuplicates(left,right),file_no,local),hash(file_no)),file_no,local);
dSortUCC3		:= sort(distribute(dedup(dUCC3,except trans_time, trans_date,process_date,trans_type, all),hash(file_no)),file_no,local);

dMainBase		:= join(dSortMaster,
										dSortUCC3,
										left.file_no=right.file_no,
										TFiling(left,right),
										left outer,local);
											
dFullFile		:= dMainBase+dfile;
											
AddRecordID := uccv2.fnAddPersistentRecordID_Main(dFullFile);											
											
dDedup      := dedup(AddRecordID,except process_date,vendor_entry_date,vendor_upd_date,rmsid, ALL);

export Proc_Build_IL_Main_base	:=	dDedup;