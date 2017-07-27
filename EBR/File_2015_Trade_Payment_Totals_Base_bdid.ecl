export File_2015_Trade_Payment_Totals_Base_bdid := project(File_2015_Trade_Payment_Totals_Base, transform(Layout_2015_Trade_Payment_Totals_Base_slim,self.bdid:=left.bdid,self:=left));
