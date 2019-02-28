IMPORT _vendorSrc2, ut, address, lib_stringlib, STD,Data_services;

EXPORT UpdateBase (string filedate, boolean pUseProd = false) := MODULE

	EXPORT VendorSrc_Base := FUNCTION
	
   CleanBankFile	          := _VendorSrc2.StandardizeInputFile(filedate, pUseProd).Bank;
	 CleanLienFile	          := _VendorSrc2.StandardizeInputFile(filedate, pUseProd).Lien;
	 FixedRiskViewFile        := _VendorSrc2.StandardizeInputFile(filedate, pUseProd).RiskviewFFD;
	 CleanCourtLocationsFile	:= _VendorSrc2.StandardizeInputFile(filedate, pUseProd).CourtLocations;
	 CollegeLocator          	:= _VendorSrc2.StandardizeInputFile(filedate, pUseProd).CollegeLocator;	
	 MasterList      		      := _VendorSrc2.StandardizeInputFile(filedate, pUseProd).MasterList;
	 

	NewBaseData	:= CleanBankFile + CleanLienFile + FixedRiskViewFile + CleanCourtLocationsFile + MasterList + CollegeLocator;
																																							

SortedNewBaseFile := SORT(distribute(NewBaseData, hash(item_source, source_code)),item_source, source_code,input_file_id,LOCAL);
MyBase := DEDUP (SortedNewBaseFile);


	  RETURN MyBase;
		
	//RETURN CollegeLocator;
	//RETURN SortOldAndNew;
	//RETURN CleanBankFile;
	//RETURN CleanLienFile;
  //RETURN FixedRiskViewFile;
	//RETURN CleanCourtLocationsFile;
	//RETURN CrimSourceData;
	//RETURN MasterList;
  //RETURN CollegeLocator;


END; 

END;