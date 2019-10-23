// Used in LiensV2.file_liens_main
IMPORT LiensV2_preprocess;

EXPORT Code_lkps := MODULE

	//CA Federal Lookups
	CA_FileDict	:= DICTIONARY(LiensV2_preprocess.Files_lkp.filing_type, {filing_type_cd => filing_type_desc});
	
	EXPORT CA_FileType(string code) := CA_FileDict[code].filing_type_desc;
	
	CA_StatusDict	:= DICTIONARY(LiensV2_preprocess.Files_lkp.filing_status, {filing_status_cd => filing_status_desc});
	
	EXPORT CA_FileStatus(string code) := CA_StatusDict[code].filing_status_desc;

	//Hogan Lookups
	HG_FileDict := DICTIONARY(LiensV2_preprocess.Files_lkp.HGFiling_type, {filetype_cd => filetype_desc});

	EXPORT HG_FileType(string code) := HG_FileDict[code].filetype_desc;
	
	HG_CourtDict	:= DICTIONARY(Files_lkp.HGCourt, {court_cd => court_desc});
	
	EXPORT HG_Court(string code) := HG_CourtDict[code].court_desc;
	
	HG_GenDict	:= DICTIONARY(Files_lkp.HGGeneration, {generation_cd => generation_desc});
	
	EXPORT HG_Gen(string code) := HG_GenDict[code].generation_desc;
	
END;