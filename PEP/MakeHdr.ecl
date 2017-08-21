import Worldcheck_Bridger, Accuity;
export MakeHdr := MODULE



shared hdg_xml := '<?xml version="1.0" encoding="utf-8"?>\r\n<Watchlist>\r\n';
shared hdg_Pt1:= hdg_xml+'<BuildInfo>\r\n<ListInfo>\r\n<Type>Entity</Type>\r\n<ID>';
shared hdg_Pt2:= '</ID>\r\n<Name>';
shared hdg_Pt3:= '</Name>\r\n<Description>';
shared hdg_Pt4:= '</Description><Encrypt>True</Encrypt>\r\n<Publication>';
shared hdg_Pt5:= '</Publication>\r\n';
shared hdg_Pt5a := '</ListInfo>\r\n<UserInfo><ClientID>Accuity</ClientID></UserInfo><OutputType>W32Bit</OutputType>\r\n';
shared hdg_Pt5b := '<Entity_List Count="';
shared hdg_Pt6:= '">';

shared SearchCriteria(string sourceCode) := 
		'<SearchCriteria>\r\n'
		+	IF(sourceCode[1]='E',SearchCriteriaEDD.GetSearchCriteria, SearchCriteriaPEP.GetSearchCriteria)
		+ '</SearchCriteria>\r\n';


export string MakeXMLHdr(string SourceCode, integer cnt, string sfExtracts) := 
				hdg_Pt1 
							+Conversions.SourceCodetoBridgerSourceID(TRIM(SourceCode,ALL))
							+hdg_Pt2
							+Conversions.SourceCodetoName(SourceCode)
							+hdg_Pt3
							+Conversions.SourceCodetoDescr(SourceCode)
							+hdg_Pt4
					//		+filedate[1..4]+'-'+filedate[5..6]+'-'+filedate[7..8]+'T12:00:00.0000000Z'
					+ GetPublicationDate(SourceCode, sfExtracts)
							+hdg_Pt5 
							+SearchCriteria(SourceCode)  
							+ hdg_pt5a
							+'</BuildInfo>\r\n'
							+hdg_Pt5b
							+(string)cnt
						+hdg_Pt6;
						
export 	Footer := '</Entity_List></Watchlist>\r\n';

export CreateXMLFileHdr(string code,
		dataset(Worldcheck_Bridger.Layout_Worldcheck_Entity_Exported.routp) infile,
						string sfExtracts) := FUNCTION
	cnt := count(infile);
	hdr := MakeXMLHdr(code, cnt, sfExtracts);
	return hdr;
END;


export OutputDataXMLFile(string code, string filename,
		dataset(Worldcheck_Bridger.Layout_Worldcheck_Entity_Exported.routp) infile,
				string sfExtracts) := FUNCTION

	hdr := CreateXMLFileHdr(code, infile, sfExtracts);
	return OUTPUT(infile,,'~thor::accuity::'+filename,
			xml('Entity', heading(hdr,Footer),trim, OPT), overwrite);
END;

						
END;