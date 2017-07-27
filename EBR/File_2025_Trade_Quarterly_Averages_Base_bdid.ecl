export File_2025_Trade_Quarterly_Averages_Base_bdid := project(File_2025_Trade_Quarterly_Averages_Base, transform(Layout_2025_Trade_Quarterly_Averages_Base_slim,self.bdid:=left.bdid,self:=left));
