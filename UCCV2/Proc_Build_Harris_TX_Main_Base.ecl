import address, did_add, didville,ut,header_slimsort,UCCV2,business_header,Business_Header_SS;

dMaster	 			             	:= File_Harris_TX_in;
dfile								 :=File_TX_Harris_Main_Base;

Layout_UCC_Common.layout_UCC_new pFiling(dMaster pinput) 
   := 
   TRANSFORM
          
		    string orig_number  :=  (string) if(stringlib.stringfilterout(pInput.UCCNumber,'012356789')>'a' or stringlib.stringfilterout(pInput.UCCNumber,'012356789')='', 
			                             (integer) (pInput.FileNumber),(integer) (pInput.UCCNumber));
			
			self.tmsid 				 := 'TXH'+orig_number;
			self.rmsid 				 := 'TXH'+(integer) pInput.fileNumber;
			self.Filing_Jurisdiction := 'TXH';
			self.orig_filing_number  := orig_number;
			self.orig_filing_type    := 'INITIAL FILING' ;
			self.orig_filing_date    := pInput.DateFiled;
			self.filing_number       := pInput.FileNumber;
			self.filing_type         := pInput.description;
			self.filing_date         := pInput.DateInstrFiled;
			self.microfilm_number    := pInput.MicrofilmNumber;
		    self.county              := '48201';
			self.description		 := '';
			self.collateral_desc     := '';//waiting  waiting on updated vendor layout
			self			         := pInput;
   END; 
Layout_UCC_Common.layout_UCC_new  tRollupDuplicates(Layout_UCC_Common.layout_UCC_new  pLeft,  Layout_UCC_Common.layout_UCC_new  pRight)
  :=
   TRANSFORM
		 self           	 := pLeft;
   End;

dSortProject                         := sort(distribute(project(dMaster, pFiling(left))+dfile,hash(tmsid)),tmsid,rmsid,-filing_type,local);
dMainBase                     		 := rollup(dSortProject ,tRollupDuplicates(left,right),tmsid,rmsid,local);
AddRecordID := uccv2.fnAddPersistentRecordID_Main(dMainBase);
												
//ut.MAC_SF_BuildProcess(dMainBase,cluster.cluster_out+,Outmain, 2);
export Proc_Build_Harris_TX_Main_Base:=	AddRecordID;