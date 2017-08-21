import gong,ut,header,PRTE2_Header;

//	starting point of most recent build
boolean is_hdrbuild := true; // for header build set to true so it will build the file in new layout 
ds0 := dataset(header.Filename_Header,header.Layout_Header_v2,flat);

header.Mac_File_headers(ds0,is_hdrbuild,outfile);

#IF (PRTE2_Header.constants.PRTE_BUILD) #WARNING(PRTE2_Header.constants.PRTE_BUILD_WARN_MSG);
export file_headers :=  PRTE2_Header.files.file_headers_base;
#ELSE
export file_headers := distribute(outfile,hash(did)); 
#END
