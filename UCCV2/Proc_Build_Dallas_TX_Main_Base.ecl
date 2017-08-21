import address, did_add, didville,ut,header_slimsort,UCCV2,business_header,Business_Header_SS;

dMaster	 			             	:= File_Dallas_TX_in;

Layout_UCC_Common.layout_UCC_new pFiling(dMaster pinput) 
   := 
   TRANSFORM
          
		    self.tmsid 				 := 'TXD'+pInput.BLACK_NUM+pInput.FILE_DATE ;
			self.rmsid 				 := 'TXD'+pInput.BLACK_NUM+pInput.FILE_DATE;
			self.Filing_Jurisdiction := 'TXD';
			self.date_vendor_removed := if(pInput.DELETE_BYTE ='D',workunit[2..9],'');
			self.orig_filing_date    := if(pInput.ORIG_FILE_DATE!= pInput.FILE_DATE,pInput.ORIG_FILE_DATE,'');
			self.filing_number       := pInput.BLACK_NUM;
			self.filing_type         := pInput.REF_TYPE  ;
			self.filing_date         := pInput.FILE_DATE  ;
			self.collateral_desc     := pInput.COLLATERAL_CODE;
		    self.county              := '48113';
			self.volume			     := pInput.vol;
			self.page			     := pInput.page_num;
			self			         := pInput;
   END; 
												
Layout_UCC_Common.layout_UCC_new  tRollupDuplicates(Layout_UCC_Common.layout_UCC_new  pLeft,  Layout_UCC_Common.layout_UCC_new  pRight)
  :=
   TRANSFORM
		 self           	 := pLeft;
   End;

dSortProjSorce               := Sort(distribute(project(dMaster, pFiling(left)),hash(tmsid)),tmsid,rmsid,local);
dMainBase                    := rollup(dSortProjSorce ,tRollupDuplicates(left,right),tmsid,rmsid,local);

ut.MAC_SF_BuildProcess(dMainBase,cluster.cluster_out+'base::UCC::main::TD',Outmain, 2);

export Proc_Build_Dallas_TX_Main_Base      :=Outmain;