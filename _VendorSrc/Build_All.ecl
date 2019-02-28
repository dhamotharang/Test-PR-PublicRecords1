IMPORT ut, VersionControl, lib_stringlib, lib_fileservices, _control, _VendorSrc,PromoteSupers;

EXPORT Build_All(STRING pversion, BOOLEAN pUseProd = FALSE) := FUNCTION

//-----------Spray input file
spray_file   :=_VendorSrc.fSpray_VendorSrc_Files(pversion);

getOrbitFile :=_VendorSrc.OrbitDataHandling.Orbit3GetDataViewData('FFD No Filters', pversion);

//PromoteSupers.MAC_SF_BuildProcess(Misc.Proc_Build_VendorSrc(version),Misc.VendorSrc_SF_List(version).Source_List_Base, BuildBaseFile,2,,true,version);

//PromoteSupers.MAC_SF_BuildProcess(_VendorSrc.Proc_Build_VendorSrc(pversion),'~thor_data400::base::vendor_src_info', BuildBaseFile,2,,true,pversion);


built := SEQUENTIAL(
                    // spray_file,
                  output(getOrbitFile),
                  BuildBaseFile,
				   //_VendorSrc.fBuildKey_VendorSrc(version),
					//Archive processed files in history
				//	FileServices.StartSuperFileTransaction(),
				//	FileServices.ClearSuperFile(Misc.VendorSrc_SF_List(version).Source_List_Load_Father,true),
				//	FileServices.ClearSuperFile(Misc.VendorSrc_SF_List(version).CollegeLocator_Father,true),
				//	FileServices.AddSuperFile(Misc.VendorSrc_SF_List(version).Source_List_Load_Father,Misc.VendorSrc_SF_List(version).Source_List_Load,,true),
				//	FileServices.AddSuperFile(Misc.VendorSrc_SF_List(version).CollegeLocator_Father,Misc.VendorSrc_SF_List(version).CollegeLocator,,true),
				//	FileServices.ClearSuperFile(Misc.VendorSrc_SF_List(version).Source_List_Load),
				//	FileServices.ClearSuperFile(Misc.VendorSrc_SF_List(version).CollegeLocator),
				//	FileServices.FinishSuperFileTransaction()
                 );

	RETURN built;

END;