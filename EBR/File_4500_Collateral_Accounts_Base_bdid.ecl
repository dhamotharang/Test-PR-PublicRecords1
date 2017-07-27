export File_4500_Collateral_Accounts_Base_bdid := project(File_4500_Collateral_Accounts_Base, transform(Layout_4500_Collateral_Accounts_Base_slim,self.bdid:=left.bdid,self:=left));
