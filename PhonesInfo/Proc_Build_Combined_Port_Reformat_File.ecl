import _control, Std;

//iConectiv Ported Phone File

EXPORT Proc_Build_Combined_Port_Reformat_File(string version, string eclsourceip, string thor_name, string contacts):= FUNCTION
	
	//DF-28572: Stop Processing the Telo Files on 11/17/20; Keep Telo history as of 11/15/20. 		
	//DF-28845: Remove Old PhonesMetadata Keys from Daily Build			
			
	//Build iConectiv PortData Validate File
	//Start Processing the iConectiv PortData Validate Files on 11/17/20.  Begin using files from 11/16/20.	
	buildPDVBase			:= PhonesInfo.Proc_Build_PortData_Valid_File(version, eclsourceip, thor_name);	
	
	emailBuildNotice 	:= if(count(PhonesInfo.File_iConectiv.Main_PortData_Valid(phone<>'')) > 0
																,fileservices.SendEmail(contacts, 'Phones Metadata: iConectiv Ported Phone File', 'Phones Metadata: iConectiv Ported Phone File Is Now Available.  Please see: ' + 'http://uspr-prod-thor-esp.risk.regn.net:8010/WsWorkunits/WUInfo?Wuid='+ workunit + '&Widget=WUDetailsWidget#/stub/Results-DL/Grid')
																,fileservices.SendEmail(contacts, 'Phones Metadata: No iConectiv Ported Phone File', 'There Were No iConectiv Ported Phone Records In This Build')
																);		
	
	RETURN buildPDVBase; 

END;