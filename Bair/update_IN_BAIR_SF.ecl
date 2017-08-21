//////////////////////////////////////////////////////////////////////////////////////////////
// -- update_IN_BAIR_SF() function:
//
// -- Updates IN::BAIR superfiles according to the date in the passed parameter as:
// --	   1)Move subfiles of each superfile to the related history superfile
// --    2)Clean superfile
// --    3)Add subfile of temp superfile to the related superfile
// --    4)Remove subfile from the temp superfile
//
// -- 	Parameters:
// --		string pVersion - date in the format YYYYMMDD
////////////////////////////////////////////////////////////////////////////////////////////////

import STD;
EXPORT update_IN_Bair_SF ( STRING pVersion ):= FUNCTION

		filelistrec := RECORD
		 STRING superFileName;
		 STRING historySuperFileName;		 
		 STRING tempSuperFileName;		 
		 STRING fileName;		 
		END;
		
		rgxVersion := '(::[0-9]+_[0-9]+)';
				
		file_list := NOTHOR(STD.File.LogicalFileList('*in::bair*'+pVersion+'*'));

		filelistrec FnFileList(file_list L) :=transform
					SELF.fileName := '~'+L.name;
					SELF.superFileName := '~'+std.str.removesuffix(L.name,regexfind(rgxVersion, L.name, 1));
					SELF.historySuperFileName := '~'+std.str.removesuffix(L.name,regexfind(rgxVersion, L.name, 1)) + '::history';					
					SELF.tempSuperFileName := '~'+std.str.removesuffix(L.name,regexfind(rgxVersion, L.name, 1)) + '::temp';					
		end;
		
		filesList := PROJECT(file_list,FnFileList(LEFT));
    OUTPUT(filesList);
	 
		remFromTempSuperFile(string tmpsfn, string fn) := STD.File.RemoveSuperFile(tmpsfn,fn);
		updateSuperfile(string sfn, string hsfn, string fn) := STD.File.PromoteSuperFileList([sfn, hsfn],fn);
	 	
    SEQUENTIAL(
		             NOTHOR(APPLY(filesList,updateSuperfile(filesList.superFileName,filesList.historySuperFileName,filesList.fileName))),
								 STD.File.StartSuperfileTransaction(),
                     NOTHOR(APPLY(filesList,remFromTempSuperfile(filesList.tempSuperFileName,filesList.fileName))),						 
		             STD.File.FinishSuperfileTransaction()
                             );

    return filesList;
END;	