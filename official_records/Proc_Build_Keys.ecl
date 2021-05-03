IMPORT RoxieKeyBuild,dx_Official_Records,std,$;

EXPORT	proc_build_keys(STRING version = (STRING8)Std.Date.Today(), BOOLEAN isDelta = FALSE)	:=	FUNCTION
//key logical file
Knames     := $.keynames(version);
//DF-27859: Delta Updates
RoxieKeyBuild.Mac_SK_BuildProcess_v3_local(dx_Official_Records.Key_Party_ORID																//index
																								,official_records.Data_Keys(isDelta).i_party				//dataset	
																								,''						//key superfile
																								,Knames.k_party.new //key logical file
																								,bkParty
																								);
																								
RoxieKeyBuild.Mac_SK_BuildProcess_v3_local(dx_Official_Records.Key_Document_ORID                            //index
																								,official_records.Data_Keys(isDelta).i_document		//dataset	
																								,''
																								,Knames.k_document.new //key logical file
																								,bkDocument
																								);																																																																					
	RETURN ordered(parallel(
	bkParty,
	bkDocument));
 

END;																						
																														