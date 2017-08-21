import address, did_add, didville,ut,header_slimsort,UCCV2,business_header,Business_Header_SS;

dMaster	 			             	:= File_MA_in;
dfile								:=UCCV2.File_MA_Main_Base;

Layout_UCC_Common.layout_UCC_new pFiling(dMaster pinput) 
   := 
   TRANSFORM
          
	Boolean    Orig_tag      :=REGEXFIND('1|Ut|li',pInput.ucc_type_desc );
	self.tmsid 				 := 'MA'+if(pInput.originalfilenum='',pInput.filingnum,pInput.originalfilenum) ;
	self.rmsid 				 := 'MA'+pInput.filingnum+pInput.ucctype;
	self.Filing_Jurisdiction := 'MA';
	self.orig_filing_number  := if(pInput.originalfilenum='',pInput.filingnum,pInput.originalfilenum);
	self.orig_filing_type	 := 'UCC-1 Original ';//if (Orig_tag,pInput.ucc_type_desc,''); 
	self.orig_filing_date    := if(Orig_tag,REGEXREPLACE('-',pInput.approvaldate[1..10],''),''); 
	self.orig_filing_time    := if(Orig_tag,REGEXREPLACE(':',pInput.approvaldate[12..16],''),'');
	self.filing_number		 := pInput.filingnum;
	self.filing_type	     := if (Orig_tag,'',pInput.ucc_type_desc); 
	self.filing_date		 := if(Orig_tag,'',REGEXREPLACE('-',pInput.approvaldate[1..10],''));
	self.filing_time		 := if(Orig_tag,'',REGEXREPLACE(':',pInput.approvaldate[12..16],''));
	self.microfilm_number	 := pInput.filingnum;
	self.Status_type		 := if(pInput.filingstatus='T','TERMINATED','ACTIVE');
	self.city				 :='';
	self.state               :='';
	self			         := pInput;
   END; 

Layout_UCC_Common.layout_UCC_new  tRollupDuplicates(Layout_UCC_Common.layout_UCC_new  pLeft,  Layout_UCC_Common.layout_UCC_new  pRight)
  :=
   TRANSFORM
		 self           	 := pLeft;
   End;

dSortMaster                  := sort(distribute(project(dMaster,pFiling(Left))+dfile,hash(tmsid)),tmsid,rmsid,-filing_date,local);
dMainBase                    := rollup(dSortMaster ,tRollupDuplicates(left,right),tmsid,rmsid,local);
AddRecordID := uccv2.fnAddPersistentRecordID_Main(dMainBase);

//ut.MAC_SF_BuildProcess(dMainBase,cluster.cluster_out+,Outmain, 2);

export Proc_Build_MA_Main_Base      :=	AddRecordID;


