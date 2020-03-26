import Worldcheck_Bridger, STD;

 hdg_xml := U'<?xml version="1.0" encoding="utf-8"?><Watchlist>';
 hdg_Pt1:= hdg_xml+ U'<BuildInfo>\r\n<ListInfo>\r\n<Type>Entity</Type>\r\n<ID>';
 hdg_Pt2:= U'</ID>\r\n<Name>';
 hdg_Pt3:= U'</Name>\r\n<Description>';
 hdg_Pt4:= U'</Description>\r\n<Encrypt>True</Encrypt>\r\n<Publication>';
 hdg_Pt5:= U'</Publication>\r\n<SearchCriteria>\r\n';
 hdg_Pt5a := U'</SearchCriteria>\r\n';
 hdg_Pt5Special := U'<SpecialListID>';
 hdg_Pt5SpecialEnd := U'</SpecialListID>\r\n';
 hdg_Pt5b := U'</ListInfo>\r\n<UserInfo>\r\n<ClientID>DowJones</ClientID></UserInfo>\r\n<OutputType>W32Bit</OutputType>\r\n</BuildInfo>\r\n';
 

unicode FullNameToId(string name) := CASE(name,
'COUNTRY_GROUP_AFR'			=> 'B704FB7C-252C-463A-A5E1-D65B724102E6',
'COUNTRY_GROUP_ASIA'		=> 'F0687F2B-AE71-44C1-89C0-F6BDDF3B0EB2',
'COUNTRY_GROUP_CANADA'	=> '6F2054A7-909D-4FC7-B6D3-452A58F28361',
'COUNTRY_GROUP_EURO'		=> '16BB0735-752E-43DB-A248-5C48B1010F6C',
'COUNTRY_GROUP_ME'			=> '7701F2A8-D673-4663-8417-C7C0AD09D552',
'COUNTRY_GROUP_NA'			=> '34DF3228-EDB3-4452-9C71-FC6D735A4F1E',
'COUNTRY_GROUP_SA'			=> 'E2A301BD-6CD9-4478-A436-4FD31B64B91C',
'COUNTRY_GROUP_UNK'			=> '10EE82C0-48AD-4069-96FD-BFA146F2F539',
'COUNTRY_GROUP_USA'			=> '35A2076E-8901-4989-8F90-C689ED05A71C',
'00000000-0000-0000-0000-000000000000');


unicode NameToId(string name) := CASE(name,
'COUNTRY_GROUP_AFR'			=> '060FF026-1F9D-4995-8F05-2F5C1BE50A48',
'COUNTRY_GROUP_ASIA'		=> 'A0F6633A-D76B-490D-ABDC-3AEC10CC5B54',
'COUNTRY_GROUP_CANADA'	=> '534E97B4-9EC0-4CE0-AEBF-216C37DFA15F',
'COUNTRY_GROUP_EURO'		=> 'BA3612F8-9D3E-402D-94A1-5CDDE1565F24',
'COUNTRY_GROUP_ME'			=> '7682A530-1098-45D3-AFBE-CBE40DC7BD26',
'COUNTRY_GROUP_NA'			=> '89BE50A4-A867-4B1C-A660-CD03220328EA',
'COUNTRY_GROUP_SA'			=> '7797C06D-A7C8-4F8F-B4E1-15CD35AB205B',
'COUNTRY_GROUP_UNK'			=> '4EEFA9E3-EB79-4460-AE2E-E110DCE185BF',
'COUNTRY_GROUP_USA'			=> 'C589B22D-402D-43CA-863C-0C8AAA61F4B4',
'00000000-0000-0000-0000-000000000000');

unicode NameToSpecialId(string name) := TRIM(CASE(name,
'COUNTRY_GROUP_AFR'			=> '1',
'COUNTRY_GROUP_ASIA'		=> '2',
'COUNTRY_GROUP_CANADA'	=> '30',
'COUNTRY_GROUP_EURO'		=> '3',
'COUNTRY_GROUP_ME'			=> '4',
'COUNTRY_GROUP_NA'			=> '5',
'COUNTRY_GROUP_SA'			=> '6',
'COUNTRY_GROUP_UNK'			=> '7',
'COUNTRY_GROUP_USA'			=> '8',
'0'));

unicode NameToFileName(string name) := CASE(name,
'COUNTRY_GROUP_AFR'			=> 'FACTIVA PFA AFRICA DELTA',
'COUNTRY_GROUP_ASIA'		=> 'FACTIVA PFA ASIA DELTA',
'COUNTRY_GROUP_CANADA'	=> 'FACTIVA PFA CANADA DELTA',
'COUNTRY_GROUP_EURO'		=> 'FACTIVA PFA EUROPE DELTA',
'COUNTRY_GROUP_ME'			=> 'FACTIVA PFA MIDDLE EAST DELTA',
'COUNTRY_GROUP_NA'			=> 'FACTIVA PFA NORTH AMERICA DELTA',
'COUNTRY_GROUP_SA'			=> 'FACTIVA PFA SOUTH AMERICA DELTA',
'COUNTRY_GROUP_UNK'			=> 'FACTIVA PFA UNKNOWN DELTA',
'COUNTRY_GROUP_USA'			=> 'FACTIVA PFA USA DELTA',
name);

unicode NameToDesc(string name) := CASE(name,
'COUNTRY_GROUP_AFR'			=> 'Dow Jones Watchlist AFRICA - Records containing data in the residence, citizenship, jurisdiction, or country of affiliation field that indicates a country in Africa.',
'COUNTRY_GROUP_ASIA'		=> 'Dow Jones Watchlist ASIA - Records containing data in the residence, citizenship, jurisdiction, or country of affiliation field that indicates a country in Asia.',
'COUNTRY_GROUP_CANADA'	=> 'Dow Jones Watchlist CANADA - Records containing data in the residence, citizenship, jurisdiction, or country of affiliation field that indicates the country is Canada.',
'COUNTRY_GROUP_EURO'		=> 'Dow Jones Watchlist EUROPE - Records containing data in the residence, citizenship, jurisdiction, or country of affiliation field that indicates a country in Europe.',
'COUNTRY_GROUP_ME'			=> 'Dow Jones Watchlist MIDDLE EAST - Records containing data in the residence, citizenship, jurisdiction, or country of affiliation field that indicates a country in the Middle East.',
'COUNTRY_GROUP_NA'			=> 'Dow Jones Watchlist NORTH AMERICA - Records containing data in the residence, citizenship, jurisdiction, or country of affiliation field that indicates a country in North America.',
'COUNTRY_GROUP_SA'			=> 'Dow Jones Watchlist SOUTH AMERICA - Records containing data in the residence, citizenship, jurisdiction, or country of affiliation field that indicates a country in South America.',
'COUNTRY_GROUP_UNK'			=> 'Dow Jones Watchlist UNKNOWN - Records containing data in the residence, citizenship, jurisdiction, or country of affiliation field that indicates the country is Unknown.',
'COUNTRY_GROUP_USA'			=> 'Dow Jones Watchlist USA - Records containing data in the residence, citizenship, jurisdiction, or country of affiliation field that indicates the country is USA.',
'Dow Jones'							=> 'Dow Jones Watchlist Delta File Replacement',
'' => 'test data',
name);


Footer := '</Entity_List></Watchlist>';

filedate := pubdate : GLOBAL;

unicode MakeXMLHdr(integer cnt, string region) := 
				hdg_Pt1 + NameToId(region)
							+hdg_Pt2 + NameToFileName(region)
							+hdg_Pt3 + FullNameToId(region)			//NameToDesc(region)
							+hdg_Pt4 + filedate
							+hdg_Pt5 // search criteria
								+ SearchCriteria.CriteriaCountries(region) + SearchCriteria.Common
							+ hdg_pt5a // end search criteria
							+ hdg_Pt5Special + NameToSpecialId(region) + hdg_Pt5SpecialEnd
							+ hdg_Pt5b
							+ U'<Entity_List Count="' + (unicode)cnt + U'">\r\n';

EXPORT WriteXGFormatDelta(dataset(recordof(Worldcheck_Bridger.Layout_Worldcheck_Entity_Unicode.routp)) infile,
												string filename, string region='test data') := FUNCTION

	return OUTPUT(infile,,'~thor::dowjones::xg::'+filename,
			xml('Entity', heading(FROMUNICODE(MakeXMLHdr(COUNT(infile), region), 'utf8')
						,Footer),trim, OPT), overwrite);

END;