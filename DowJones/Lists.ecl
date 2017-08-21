//#DECLARE(FirstTime); 
//#SET(FirstTime,0);
EXPORT Lists := MODULE
#OPTION('multiplePersistInstances',FALSE);

rCountryList := RECORD
	string				code				{xpath('@code'),MAXLENGTH(13)};
	string				name				{xpath('@name'),MAXLENGTH(255)};
	string				IsTerritory		{xpath('@IsTerritory'),MAXLENGTH(5)};
	string				ProfileURL		{xpath('@ProfileURL'),MAXLENGTH(255)};
END;

export CountryList :=
//			DATASET(File_DJ, rCountryList, XML('PFA/CountryList/CountryName')) : PERSIST('~thor::dowjones::lists::countries');
			DATASET('~thor::dowjones::lists::countries', rCountryList, THOR);

rOccupationList := RECORD
	string				code				{xpath('@code'),MAXLENGTH(2)};
	string				name				{xpath('@name'),MAXLENGTH(255)};
END;
export OccupationList := 
//	DATASET(File_DJ, rOccupationList, XML('PFA/OccupationList/Occupation')) : PERSIST('~thor::dowjones::lists::occupations');
	DATASET('~thor::dowjones::lists::occupations', rOccupationList, THOR);

rSanctionsListXML := RECORD
	string				code				{xpath('@code'),MAXLENGTH(2)};
	unicode				name				{xpath('@name'),MAXLENGTH(255)};
	string				status			{xpath('@status'),MAXLENGTH(9)};
	string				Description2Id	{xpath('@Description2Id'),MAXLENGTH(2)};
END;
rSanctionsList := RECORD
	string				code		{MAXLENGTH(2)};
	unicode				name		{MAXLENGTH(255)};
	string				status	{MAXLENGTH(9)};
	string				Description2Id	{MAXLENGTH(2)};
END;
export SanctionsList := 
	PROJECT(SORT(DISTRIBUTE(DATASET(DowJones.File_DJ, rSanctionsListXML, XML('PFA/SanctionsReferencesList/ReferenceName')),(integer)code),code,LOCAL),rSanctionsList)
								: PERSIST('~thor::dowjones::lists::sanctions');
	//DATASET(File_DJ, rSanctionsList, XML('PFA/SanctionsReferencesList/ReferenceName')) : PERSIST('~thor::dowjones::lists::sanctions');
	//DATASET('~thor::dowjones::lists::sanctions', rSanctionsList, THOR);

rRelationshipList := RECORD
	string				code				{xpath('@code'),MAXLENGTH(2)};
	string				name				{xpath('@name'),MAXLENGTH(255)};
END;
export RelationshipList := 
	//DATASET(File_DJ, rRelationshipList, XML('PFA/RelationshipList/Relationship')) : PERSIST('~thor::dowjones::lists::relationship');
	DATASET('~thor::dowjones::lists::relationship', rRelationshipList, THOR);

rDesc1 := RECORD
	integer					Description1Id		{xpath('@Description1Id')};
	string					RecordType				{xpath('@RecordType'),MAXLENGTH(6)};
	string					Name							{xpath(''),MAXLENGTH(255)};
END;
export Description1List := 
	//SORT(DATASET(File_DJ, rDesc1, XML('PFA/Description1List/Description1Name')),Description1Id) : PERSIST('~thor::dowjones::lists::description1');
	DATASET('~thor::dowjones::lists::description1', rDesc1, THOR);

rDesc2XML := RECORD
	integer					Description2Id		{xpath('@Description2Id')};
	integer					Description1Id		{xpath('@Description1Id')};
	string					Name							{xpath(''),MAXLENGTH(255)};
END;
rDesc2 := RECORD
	integer					Description2Id;
	integer					Description1Id;
	string					Name							{MAXLENGTH(255)};
END;
export Description2List := 
	PROJECT(SORT(distribute(DATASET(DowJones.File_DJ, rDesc2XML, XML('PFA/Description2List/Description2Name')), hash(Description2Id)),Description2Id, local),rDesc2)
						: PERSIST('~thor::dowjones::lists::description2');
	//SORT(DATASET(File_DJ, rDesc2, XML('PFA/Description2List/Description2Name')),Description2Id) : PERSIST('~thor::dowjones::lists::description2');
	//DATASET('~thor::dowjones::lists::description2', rDesc2, THOR);

rDesc3XML := RECORD
	integer					Description3Id		{xpath('@Description3Id')};
	integer					Description2Id		{xpath('@Description2Id')};
	string					Name							{xpath(''),MAXLENGTH(255)};
END;
rDesc3 := RECORD
	integer					Description3Id;
	integer					Description2Id;
	string					Name							{MAXLENGTH(255)};
END;
export Description3List := 
	PROJECT(SORT(DATASET(File_DJ, rDesc3XML, XML('PFA/Description3List/Description3Name')),Description3Id),rDesc3)
				: PERSIST('~thor::dowjones::lists::description3');
	//DATASET('~thor::dowjones::lists::description3', rDesc3, THOR);

END;