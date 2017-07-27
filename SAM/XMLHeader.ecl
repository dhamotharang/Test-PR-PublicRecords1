import Worldcheck_Bridger, ut;

hdg1 := '<?xml version="1.0" ?>\r\n';
hdg2 := '<!DOCTYPE Records SYSTEM "http://www.epls.gov/EPLS.dtd">\r\n';
hdg3 := '<Records>\r\n';
hdg_xml := hdg1 + '<Watchlist>\r\n';
hdg_Pt1:= hdg_xml+'<BuildInfo><ListInfo><Type>Entity</Type><ID>';
hdg_Pt2:= '</ID>\r\n<Name>';
hdg_Pt3:= '</Name>\r\n<Description>';
hdg_Pt4:= '</Description><Encrypt>True</Encrypt>\r\n<Publication>';
hdg_Pt5:= '</Publication></ListInfo><UserInfo><ClientID>SAM</ClientID></UserInfo><OutputType>W32Bit</OutputType></BuildInfo>\r\n';
hdg_Pt5b := '<Entity_List Count="';
hdg_Pt6:= '">\r\n';

pubtime := 'T14:00:00.0000000Z';
GetPublicationDate(string SourceCode) := Ut.ConvertDate(Ut.GetDate,'%Y%m%d','%Y-%m-%d') + pubtime;
SourceCodetoBridgerSourceID(string SourceCode) := 'BE3BDFE4-01D6-43fc-9FA5-A462E8A76F14';
SourceCodetoName(string SourceCode) := 'EPLS';
SourceCodetoDescr(string SourceCode) := 
	'The EPLS is a list that identifies those parties excluded from receiving federal contracts, certain subcontracts, and certain types of federal financial and non-financial assistance and benefits.';

string MakeXMLHdr(string SourceCode, integer cnt) := 
				hdg_Pt1 
							+SourceCodetoBridgerSourceID(TRIM(SourceCode,ALL))
							+hdg_Pt2
							+SourceCodetoName(SourceCode)
							+hdg_Pt3
							+SourceCodetoDescr(SourceCode)
							+hdg_Pt4
					+ GetPublicationDate(SourceCode)
							+hdg_Pt5+hdg_Pt5b
							+(string)cnt
						+hdg_Pt6;

//HeaderXml := hdg1 + hdg3;
Footer := '</Entity_List></Watchlist>\r\n';

CreateXMLFileHdr(string code,
		dataset(recordof(Layout_Bridger)) infile) := FUNCTION
	cnt := Count(infile);
	hdr := MakeXMLHdr(code, cnt);
	return hdr;
END;

export XMLHeader(
		dataset(recordof(Layout_Bridger)) ds) := FUNCTION
	code := 'SAM';
	hdr := CreateXMLFileHdr(code, ds);
	return OUTPUT(ds,,'~thor::out::sam::results',
			xml('Entity', heading(CreateXMLFileHdr(code, ds)
						,Footer),trim, OPT), overwrite);
END;

