import ut;
export Files := module;
export File_In     	   := DATASET( SuperFile_List.IRSG_Source_File, ExperianIRSG_Build.Layouts.Layout_In, THOR);;

export Base_File_Out       := DATASET( SuperFile_List.IRSG_Base_File, ExperianIRSG_Build.Layouts.Layout_Out, THOR);

export Cashed_Names_File   := DATASET( SuperFile_List.IRSG_Cache_Name_File, ExperianIRSG_Build.Layouts.Layout_Clean_Name, THOR);

export Cashed_Address_File := DATASET( SuperFile_List.IRSG_Cache_Address_File, ExperianIRSG_Build.Layouts.Layout_Clean_Address, THOR);

end;