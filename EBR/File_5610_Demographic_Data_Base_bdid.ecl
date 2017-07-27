export File_5610_Demographic_Data_Base_bdid := project(File_5610_Demographic_Data_Base, transform(Layout_5610_Demographic_Data_Base_slim,self.bdid:=left.bdid,self:=left));
