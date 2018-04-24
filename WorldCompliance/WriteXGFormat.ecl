import ut;

EXPORT WriteXGFormat := MODULE


shared hdg_xml := '<?xml version="1.0" encoding="utf-8"?>\r\n<Watchlist>\r\n';
shared hdg_Pt1:= hdg_xml+'<BuildInfo>\r\n<ListInfo>\r\n<Type>Entity</Type>\r\n<ID>';
shared hdg_Pt2:= '</ID>\r\n<Name>';
shared hdg_Pt3:= '</Name>\r\n<Description>';
shared hdg_Pt4:= '</Description><Encrypt>True</Encrypt>\r\n<Publication>';
shared hdg_Pt5:= '</Publication>\r\n';
shared hdg_Pt5a := '</ListInfo>\r\n<UserInfo><ClientID>WorldCompliance</ClientID></UserInfo><OutputType>W32Bit</OutputType>\r\n';
shared hdg_Pt5a64 := '</ListInfo>\r\n<UserInfo><ClientID>WorldCompliance</ClientID></UserInfo><OutputType>W64Bit</OutputType>\r\n';
shared hdg_Pt5b := '<Entity_List Count="';
shared hdg_Pt6:= '">\r\n';

shared SourceCodetoFilter(string SourceCode) := CASE(SourceCode,
'WorldCompliance - Adverse Media' => Filters.fAdverseMedia,
'WorldCompliance - Enforcement' => Filters.fEnforcement,
'WorldCompliance - Expanded Due Diligence' => Filters.fEdd,
'WorldCompliance - State Owned Entities' => Filters.fStateOwned,
'WorldCompliance - Politically Exposed Persons' => Filters.fPep,
'WorldCompliance - Sanctions and Enforcements' => Filters.fSanctionsAndEnforcement,
'WorldCompliance - Sanctions' => Filters.fSanctions,
'WorldCompliance - Full' => Filters.fFull,
'WorldCompliance - Countries' => [],
'Belgium Financial Sector Federation' => Filters.fSanctions,
'WorldCompliance - Registrations' => Filters.fRegistrations,
[]);

shared integer SourceCodetoCountryFilter(string SourceCode) := CASE(SourceCode,
'WorldCompliance - Adverse Media' => 0,
'WorldCompliance - Enforcement' => 0,
'WorldCompliance - Expanded Due Diligence' => 0,
'WorldCompliance - State Owned Entities' => 0,
'WorldCompliance - Politically Exposed Persons' => 0,
'WorldCompliance - Sanctions and Enforcement' => 0,
'WorldCompliance - Sanctions' => 0,
'WorldCompliance - Full' => 0,
'WorldCompliance - Countries' => 0,
'Belgium Financial Sector Federation' => 0,
'WorldCompliance - Registrations' => 0,
0);

	
shared SearchCriteria(string sourceCode) := 
		'<SearchCriteria>\r\n'
		+	GetSearchCriteria(SourceCodetoFilter(sourceCode), SourceCodetoCountryFilter(sourceCode))
		+ '</SearchCriteria>\r\n';
shared SearchCriteriaEx(dataset(Layouts.rEntity) srcfile) := 
		'<SearchCriteria>\r\n'
		+	GetSearchCriteriaEx(srcfile)
		+ '</SearchCriteria>\r\n';

shared SpecialId(string SourceCode) := TRIM(CASE(SourceCode,
	'WorldCompliance United States PEP' =>	'<SpecialListID>33</SpecialListID>\r\n',	//World Compliance United States PEP
	'WorldCompliance International PEP' =>	'<SpecialListID>32</SpecialListID>\r\n',	//World Compliance International PEP
	'USP' =>	'<SpecialListID>33</SpecialListID>\r\n',	//World Compliance United States PEP
	'PEP' =>	'<SpecialListID>32</SpecialListID>\r\n',	//World Compliance International PEP
	''));
	
//pubdate := ut.GetDate;
	
shared GetPublicationDate(string version) := version[1..4] + '-' + version[5..6] + '-' + version[7..8] + 'T05:01:00.0000000Z';

shared SourceCodetoBridgerSourceID(string SourceCode) := CASE(SourceCode,
'WorldCompliance - Adverse Media' => '6AB3729F-36FD-475E-8F83-487C05B7B51F',
'WorldCompliance - Enforcement' => '6FE2FD16-7B0C-4801-85F6-780C53B22AD9',
'WorldCompliance - Expanded Due Diligence' => 'D92E87BF-B610-469D-B780-A3E828074269',
'WorldCompliance - State Owned Entities' => 'BF607088-EDBB-427E-8ACB-6EBE195AFBD7',
'WorldCompliance - Politically Exposed Persons' => '90A1422B-0367-4687-8D2D-558625C8A438',
'WorldCompliance - Sanctions and Enforcements' => 'A3315680-5313-45A2-AD86-7C72CE2882E3',
'WorldCompliance - Sanctions' => 'A1B4E186-B386-4E09-BC95-DCF91651D654',
'WorldCompliance - Full' => '1DE1ECFB-13EE-4263-903F-73D3193E5CB4',
'WorldCompliance - Countries' => '08B8D210-ECD4-49D9-8B41-9380AAB618BC',
'Belgium Financial Sector Federation' => '6E9526E7-A4D0-4AF3-8E47-A017273590F5',
'WorldCompliance - Registrations' => '1C0C4602-9835-4E45-B398-D21858CF43C7',
NameSources.CodeToGuid(SourceCode));
//'00000000-0000-0000-0000-000000000000');

shared SourceCodetoName(string SourceCode) := 
				IF(NameSources.CodeToName(SourceCode)='',SourceCode,NameSources.CodeToName(SourceCode));


shared SourceCodetoDescr(string SourceCode) := CASE(SourceCode,
'WorldCompliance - Adverse Media' => 'WorldCompliance profiles sourced from open-source news media about persons or companies that may pose a regulatory, commercial or reputation risk',
'WorldCompliance - Enforcement' => 'WorldCompliance coverage of warnings and enforcements from around the world',
'WorldCompliance - Expanded Due Diligence' => 'WorldCompliance coverage of global Persons and their associates and/or family members',
'WorldCompliance - State Owned Entities' => 'WorldCompliance profiles about government owned companies or organizations and their officials',
'WorldCompliance - Politically Exposed Persons' => 'WorldCompliance coverage of global Politically Exposed Persons (PEPs) and their associates and/or family members',
'WorldCompliance - Sanctions and Enforcements' => 'WorldCompliance coverage of sanctions, warnings, law enforcement and other lists from around the world',
'WorldCompliance - Sanctions' => 'WorldCompliance coverage of sanctions from around the world',
'WorldCompliance - Full' => 'Full WorldCompliance data set',
'WorldCompliance - Countries' => 'Includes Countries from all WorldCompliance Categories that need additional due diligence',
'Belgium Financial Sector Federation' => 'Belgium Financial Sector Federation',
'WorldCompliance - Registrations' => U'US IRS FATCA – Foreign Financial Institutions; Marijuana Registered Businesses (MRB); IHS (FATF High-Risk Country) Vessels; US Money Services Businesses (MSBs); UAE Money Services Businesses (MSBs)',
NameSources.CodeToDesc(SourceCode));
//SourceCode + ' from World Compliance, a LexisNexis Company');

export unicode MakeXMLHdr(string SourceCode, string version, integer cnt, dataset(Layouts.rEntity) srcfile) := 
				hdg_Pt1 
							+	SourceCodetoBridgerSourceID(SourceCode)		
							+hdg_Pt2
							+	SourceCodetoName(SourceCode)
							+hdg_Pt3
							+ SourceCodetoDescr(SourceCode)
							+hdg_Pt4
					//		+filedate[1..4]+'-'+filedate[5..6]+'-'+filedate[7..8]+'T12:00:00.0000000Z'
					+ GetPublicationDate(version)
							+ hdg_Pt5 
							//+SearchCriteria(SourceCode)  
							+SearchCriteriaEx(srcfile)  
							+ SpecialId(SourceCode)
							+ hdg_pt5a64 //All files 64 bit.
							//+ IF(SourceCode in ['PEP', 'ALL'],hdg_pt5a64, hdg_pt5a) old only PEP and FULL 64
							+'</BuildInfo>\r\n'
							+hdg_Pt5b
							+(string)cnt
						+hdg_Pt6;
						
export 	Footer := '</Entity_List></Watchlist>\r\n';
export 	GeoFooter := '\r\n</Country_List></Watchlist>\r\n';
/*
export CreateXMLFileHdr(string code, string version,
		dataset(Layout_XG.routp) infile) := FUNCTION
	cnt := count(infile);
	hdr := MakeXMLHdr(code, version, cnt);
	return hdr;
END;
*/

export OutputDataXMLFile(string code, string filename, string version,
		dataset(Layout_XG.routp) infile, dataset(Layouts.rEntity) srcfile) := FUNCTION
	
	datafile := infile;		//SAMPLE(infile,400);
	cnt := count(datafile);
	hdr := MakeXMLHdr(code, version, cnt, srcfile);
	return OUTPUT(datafile,,'~thor::WorldCompliance::'+filename,
			xml('Entity', heading(FROMUNICODE(hdr, 'utf8'),Footer),trim, OPT), overwrite);
END;

export unicode MakeGeoXMLHdr(string SourceCode, string version, integer cnt) := 
				hdg_xml+'<BuildInfo><ListInfo><Type>Country</Type><ID>' 
					+ SourceCodetoBridgerSourceID(SourceCode)
					+hdg_Pt2
					+ SourceCodetoName(SourceCode)
					+hdg_Pt3
					+ SourceCodetoDescr(SourceCode)
					+hdg_Pt4
					//+filedate[1..4]+'-'+filedate[5..6]+'-'+filedate[7..8]+'T12:00:00.0000000Z'
					+ GetPublicationDate(version)
					+hdg_Pt5
					+hdg_Pt5a
					+'</BuildInfo>\r\n'
					+'<Country_List Count="'
							+(string)cnt
						+hdg_Pt6;

export CreateGeoXMLFileHdr(string SourceCode, string version,
		dataset(recordof(Layout_XG.rgeo)) infile) := FUNCTION
	cnt := count(infile);
	hdr := MakeGeoXMLHdr(SourceCode, version, cnt);
	return hdr;
END;

export OutputGeoXMLFile(string SourceCode, string filename, string version,
		dataset(Layout_XG.rgeo) infile) := FUNCTION

	hdr := CreateGeoXMLFileHdr(SourceCode, version, infile);
	return OUTPUT(infile,,'~thor::WorldCompliance::'+filename,
			xml('Country', heading(FROMUNICODE(hdr, 'utf8'),GeoFooter),trim, OPT), overwrite);
END;

END;