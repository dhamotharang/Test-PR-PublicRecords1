export File_5000_Bank_Details_Base_bdid := project(File_5000_Bank_Details_Base, transform(Layout_5000_Bank_Details_Base_slim,self.bdid:=left.bdid,self:=left));
