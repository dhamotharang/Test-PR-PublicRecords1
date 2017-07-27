export File_7000_SNP_Parent_Name_Address_Base_bdid := project(File_7000_SNP_Parent_Name_Address_Base, transform(Layout_7000_SNP_Parent_Name_Address_Base_slim,self.bdid:=left.bdid,self:=left));

