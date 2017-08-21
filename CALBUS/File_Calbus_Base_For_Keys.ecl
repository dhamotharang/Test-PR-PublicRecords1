import Calbus;

Base := Calbus.File_Calbus_Base;

export File_Calbus_Base_For_Keys := project(base, transform(Calbus.Layouts_Calbus.Layout_keys, self := left));