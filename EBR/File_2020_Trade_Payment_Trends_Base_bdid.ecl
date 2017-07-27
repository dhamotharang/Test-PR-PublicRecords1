export File_2020_Trade_Payment_Trends_Base_bdid := project(File_2020_Trade_Payment_Trends_Base, transform(Layout_2020_Trade_Payment_Trends_Base_slim,self.bdid:=left.bdid,self:=left));
