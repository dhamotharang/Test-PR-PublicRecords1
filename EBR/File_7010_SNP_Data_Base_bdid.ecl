export File_7010_SNP_Data_Base_bdid := project(File_7010_SNP_Data_Base, transform(Layout_7010_SNP_Data_Base_slim,self.bdid:=left.bdid,self:=left));

