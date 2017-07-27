export File_6000_Inquiries_Base_bdid := project(File_6000_Inquiries_Base, transform(Layout_6000_Inquiries_Base_slim,self.bdid:=left.bdid,self:=left));
