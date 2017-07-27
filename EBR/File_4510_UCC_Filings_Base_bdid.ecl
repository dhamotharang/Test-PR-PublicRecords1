export File_4510_UCC_Filings_Base_bdid := project(File_4510_UCC_Filings_Base, transform(Layout_4510_UCC_Filings_Base_slim,self.bdid:=left.bdid,self:=left));
