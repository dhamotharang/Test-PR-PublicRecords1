Base := Txbus.File_Txbus_Base;

export File_Txbus_Base_For_BID_Keys := project(base, transform(Txbus.Layouts_Txbus.Layout_keys, self.bdid := left.bid, self := left));