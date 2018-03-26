/* **********************************************************************************
	 BWR_Spray_Alpharetta_Base 
	This to spray the regular data from Nancy's Alpharetta Spreadsheet
--------------------------------------------------------------------------------
DONE: Simple spray of CSV layout into HPCC Alpha CSV Base file.
TODO: Next spray the data file into HPCC file with Boca Layout ready now for the build.
--------------------------------------------------------------------------------
NEW! for use by the MapView builds Charles has the following two lines in MapViewExtracts files
PropCharacter_Extract_DS 	:= DATASET(data_services.foreign_prod_boca + 'thor_data400::base::propertyinfo',MapViewExtracts.Layouts.Base,thor);
dYearBuiltFile	:= MapviewExtracts.Files.PropCharacter_Extract_DS(vendor_source = 'A' and latitude <> '' and longitude <> ''); 

This Mapview base file needed - will now be kept up to date by PRTE2_PropertyInfo.Save_MV_Base during the key build

********************************************************************************** */

IMPORT ut, PRTE2_PropertyInfo, PRTE2_Common;
#workunit('name', 'ALPHA PRCT Property Info File Spray');

STRING fileVersion := ut.GetDate+'';
CSVName := 'PropertyInfo_V3_AfterAdds_20170907.csv';

BuildFile := PRTE2_PropertyInfo.Fn_Spray_Alpharetta_Spreadsheet( CSVName, fileVersion ); //, pii_path 

SEQUENTIAL (BuildFile);
