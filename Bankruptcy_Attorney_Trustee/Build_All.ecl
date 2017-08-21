import VersionControl, Address, Ut, lib_stringlib, _Control, business_header,_Validate,
Header, Header_Slimsort, didville, ut, DID_Add,Business_Header_SS, Bankruptcy_Attorney_Trustee;
export Build_all(string filedate) := function

spray_att  		 := VersionControl.fSprayInputFiles(Spray_Input(filedate).Attorney_File);
spray_trustee  := VersionControl.fSprayInputFiles(Spray_Input(filedate).Trustee_File);

Build_Base(Files.Attorneys_In, Layouts.layout_attorneys_out, SuperFile_List.Base_File_Attorney_Out,Files.Attorneys_Base, Attorney_out, 'attorney', filedate);
Build_Base(Files.Trustees_In, Layouts.layout_trustees_out, SuperFile_List.Base_File_Trustee_Out,Files.Trustees_Base, Trustee_out, 'trustee', filedate);

ut.MAC_SF_BuildProcess(Attorney_out,Superfile_List.Base_File_Attorney_Out ,attorney_base,2,,true);
ut.MAC_SF_BuildProcess(Trustee_out,Superfile_List.Base_File_Trustee_Out ,trustee_base,2,,true);

built := sequential(
					spray_att
					,spray_trustee
					,attorney_base
					,trustee_base
					//Archive processed files in history
					,FileServices.StartSuperFileTransaction()
					,FileServices.AddSuperFile(Superfile_List.File_Attorney_Processed,Superfile_List.Source_File_Attorney_In,,true)
					,FileServices.ClearSuperFile(Superfile_List.Source_File_Attorney_In)
					,FileServices.AddSuperFile(Superfile_List.File_Trustee_Processed,Superfile_List.Source_File_Trustee_In,,true)
					,FileServices.ClearSuperFile(Superfile_List.Source_File_Trustee_In)
					,FileServices.FinishSuperFileTransaction()
				);

return built;
end;