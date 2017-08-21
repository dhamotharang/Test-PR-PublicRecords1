Base := File_Calbus_Base;

export File_Calbus_Base_For_BID_Keys := project(base, transform(Calbus.Layouts_Calbus.Layout_keys, self.bdid := left.bid, self := left));
