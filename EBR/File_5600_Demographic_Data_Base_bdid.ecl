export File_5600_Demographic_Data_Base_bdid := project(File_5600_Demographic_Data_Base, transform(Layout_5600_Demographic_Data_Base_slim,self.bdid:=left.bdid,self:=left));
