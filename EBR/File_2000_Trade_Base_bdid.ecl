export File_2000_Trade_Base_bdid := project(File_2000_Trade_Base, transform(Layout_2000_Trade_Base_slim,self.bdid:=left.bdid,self:=left));
