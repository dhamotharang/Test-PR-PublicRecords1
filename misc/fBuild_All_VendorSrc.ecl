IMPORT ut, VersionControl, lib_stringlib, lib_fileservices, _control, misc,PromoteSupers;

EXPORT fBuild_All_VendorSrc(STRING version) := FUNCTION

//-----------Spray input file
spray_file   := Misc.fSpray_VendorSrc_Files(version);

getOrbitFile := misc.OrbitDataHandling.Orbit3GetDataViewData('FFD No Filters', version);

PromoteSupers.MAC_SF_BuildProcess(Proc_Build_VendorSrc(version),Misc.VendorSrc_SF_List(version).Source_List_Base, BuildBaseFile,2,,true,version);

built := SEQUENTIAL(
                    spray_file,
                    output(getOrbitFile),
                    BuildBaseFile,
					misc.fBuildKey_VendorSrc(version),
					//Archive processed files in history
					FileServices.StartSuperFileTransaction(),
					FileServices.ClearSuperFile(Misc.VendorSrc_SF_List(version).Source_List_Load_Father,true),
					FileServices.ClearSuperFile(Misc.VendorSrc_SF_List(version).CollegeLocator_Father,true),
					FileServices.AddSuperFile(Misc.VendorSrc_SF_List(version).Source_List_Load_Father,Misc.VendorSrc_SF_List(version).Source_List_Load,,true),
					FileServices.AddSuperFile(Misc.VendorSrc_SF_List(version).CollegeLocator_Father,Misc.VendorSrc_SF_List(version).CollegeLocator,,true),
					FileServices.ClearSuperFile(Misc.VendorSrc_SF_List(version).Source_List_Load),
					FileServices.ClearSuperFile(Misc.VendorSrc_SF_List(version).CollegeLocator),
					FileServices.FinishSuperFileTransaction()
                    );

	RETURN built;

END;