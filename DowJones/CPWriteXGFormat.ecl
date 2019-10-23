import Worldcheck_Bridger, STD;

 hdg_xml := U'<?xml version="1.0" encoding="utf-8"?><Watchlist>';
 hdg_Pt1:= hdg_xml+ U'<BuildInfo>\r\n<ListInfo>\r\n<Type>Entity</Type>\r\n<ID>';
 hdg_Pt2:= U'</ID>\r\n<Name>';
 hdg_Pt3:= U'</Name>\r\n<Description>';
 hdg_Pt4:= U'</Description>\r\n<Encrypt>True</Encrypt>\r\n<Publication>';
 hdg_Pt4a := U'</Publication>\r\n';
 hdg_Pt5:= U'</Publication>\r\n<SearchCriteria>\r\n';
 hdg_Pt5a := U'</SearchCriteria>\r\n';
 hdg_Pt5Special := U'<SpecialListID>';
 hdg_Pt5SpecialEnd := U'</SpecialListID>\r\n';
 hdg_Pt5b := U'</ListInfo>\r\n<UserInfo>\r\n<ClientID>DowJones</ClientID></UserInfo>\r\n<OutputType>W32Bit</OutputType>\r\n</BuildInfo>\r\n';
 

unicode NameToId(string code) := (unicode)DowJones.CapOne_Dictionary.CodeToGuid(code);

unicode NameToFileName(string code) := (unicode)DowJones.CapOne_Dictionary.CodeToFileName(code);

unicode NameToDesc(string code) := U'Dow Jones Watch List - ' + NameToFileName(code);

Footer := '</Entity_List></Watchlist>';

filedate := pubdate : GLOBAL;

unicode MakeXMLHdr(integer cnt, string code) := 
				hdg_Pt1 + NameToId(code)
							+hdg_Pt2 + NameToFileName(code)
							+hdg_Pt3 + NameToDesc(code)
							+hdg_Pt4 + filedate + hdg_Pt4a
							+ hdg_Pt5b
							+ U'<Entity_List Count="' + (unicode)cnt + U'">\r\n';

EXPORT CPWriteXGFormat(dataset(Worldcheck_Bridger.Layout_Worldcheck_Entity_Unicode.routp) infile,
																			string code) := FUNCTION

	string lfn := DowJones.CapOne_Dictionary.CodeToLfn(code);
	return OUTPUT(infile,,lfn,
			xml('Entity', heading(FROMUNICODE(MakeXMLHdr(COUNT(infile), code), 'utf8')
						,Footer),trim, OPT), overwrite);

END;
