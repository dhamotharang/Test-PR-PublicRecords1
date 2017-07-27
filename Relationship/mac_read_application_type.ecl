/* This is only a quick fix to make relatives V3 give data similar to relatives V2. 
   This  will be used by  IDM(Identity Management) teams's KBA (Key based authentication)*/
EXPORT mac_read_application_type := macro
	string32 ApplicationType := '' : stored('ApplicationType');
	isKBA := trim(stringlib.stringtouppercase(ApplicationType)) = 'KBA'; 
	HighConfidenceRelatives_Value :=  isKBA;
	HighConfidenceAssociates_Value := isKBA;
	RelLookbackMonths_Value := 0;
	
endmacro;