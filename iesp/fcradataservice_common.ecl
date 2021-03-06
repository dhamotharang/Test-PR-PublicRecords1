/*** Not to be hand edited (changes will be lost on re-generation) ***/
/*** ECL Interface generated by esdl2ecl version 1.0 from fcradataservice_common.xml. ***/
/*===================================================*/

import iesp;

export fcradataservice_common := MODULE
			
export t_FcraDataServiceReportBy := record
	string12 LexId {xpath('LexId')};
end;
		
export t_FcraDataServiceComplianceFlags := record
	boolean IsSuppressed {xpath('IsSuppressed')};
	boolean IsOverwritten {xpath('IsOverwritten')};
	boolean IsOverride {xpath('IsOverride')};
	boolean IsDisputed {xpath('IsDisputed')};
end;
		
export t_FcraDataServiceRecID := record
	string50 RecId1 {xpath('RecId1')};
	string50 RecId2 {xpath('RecId2')};
	string50 RecId3 {xpath('RecId3')};
	string50 RecId4 {xpath('RecId4')};
end;
		
export t_FcraDataServiceMetadata := record
	string12 LexId {xpath('LexId')};
	string25 Datagroup {xpath('Datagroup')};
	t_FcraDataServiceRecID RecID {xpath('RecID')};
	unsigned StatementId {xpath('StatementId')};
	t_FcraDataServiceComplianceFlags ComplianceFlags {xpath('ComplianceFlags')};
end;
		

end;

/*** Not to be hand edited (changes will be lost on re-generation) ***/
/*** ECL Interface generated by esdl2ecl version 1.0 from fcradataservice_common.xml. ***/
/*===================================================*/

