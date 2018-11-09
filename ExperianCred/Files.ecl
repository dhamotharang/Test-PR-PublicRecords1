import ut;
export Files := module;
export File_In    		   := DATASET(SuperFile_List.Source_File, ExperianCred.Layouts.Layout_In, THOR);;

export Base_File_Out       := DATASET(SuperFile_List.Base_File, ExperianCred.Layouts.Layout_Out, THOR);

export Cashed_Names_File   := DATASET(SuperFile_List.Cache_Name_File, ExperianCred.Layouts.Layout_Clean_Name, THOR);

export Cashed_Address_File := DATASET(SuperFile_List.Cache_Address_File, ExperianCred.Layouts.Layout_Clean_Address, THOR);

export File_Delete_In 	   := DATASET(SuperFile_List.Source_Delete_File, ExperianCred.Layouts.Layout_Delete_In, THOR);

export File_Delete_In_Old24  := DATASET(SuperFile_List.Source_Delete_File_Old, ExperianCred.Layouts.Layout_Delete_In_Old, THOR);

export File_Deceased_In			  := DATASET(SuperFile_List.Source_Deceased_File, ExperianCred.Layouts.Layout_Deceased_In, THOR);

export File_History		   := DATASET(SuperFile_List.Source_File_History, ExperianCred.Layouts.Layout_In, THOR);

end;