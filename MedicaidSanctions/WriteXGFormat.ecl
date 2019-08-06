import ut;

EXPORT WriteXGFormat := MODULE


shared hdg_xml := '<?xml version="1.0" encoding="utf-8"?>\r\n<Watchlist>\r\n';
shared hdg_Pt1:= hdg_xml+'<BuildInfo>\r\n<ListInfo>\r\n<Type>Entity</Type>\r\n<ID>';
shared hdg_Pt2:= '</ID>\r\n<Name>';
shared hdg_Pt3:= '</Name>\r\n<Description>';
shared hdg_Pt4:= '</Description><Encrypt>True</Encrypt>\r\n<Publication>';
shared hdg_Pt5:= '</Publication>\r\n';
shared hdg_Pt5a := '</ListInfo>\r\n<UserInfo><ClientID>Medicaid Sanctions</ClientID></UserInfo><OutputType>W32Bit</OutputType>\r\n';
shared hdg_Pt5a64 := '</ListInfo>\r\n<UserInfo><ClientID>Medicaid Sanctions</ClientID></UserInfo><OutputType>W64Bit</OutputType>\r\n';
shared hdg_Pt5b := '<Entity_List Count="';
shared hdg_Pt6:= '">\r\n';

shared desc := 'The State Exclusions List contains the names of individuals and businesses excluded by the state from participating in federally funded healthcare programs, including Medicare and Medicaid.';	

shared GetPublicationDate(string version) := version[1..4] + '-' + version[5..6] + '-' + version[7..8] + 'T05:01:00.0000000Z';

guid := 'CCC022A3-C8D3-4F32-9E20-CD206E19D08F';

export unicode MakeXMLHdr(string version, integer cnt, dataset($.Layout_Sanctions) srcfile) := 
				hdg_Pt1 
							+	guid		
							+hdg_Pt2
							+	'Medicaid Sanctions'
							+hdg_Pt3
							+ desc
							+hdg_Pt4
					+ GetPublicationDate(version)
							+ hdg_Pt5 
							//+''
							//+ '1'
							+ hdg_pt5a64 //All files 64 bit.
							+'</BuildInfo>\r\n'
							+hdg_Pt5b
							+(string)cnt
						+hdg_Pt6;
						
export 	Footer := '</Entity_List></Watchlist>\r\n';


export OutputDataXMLFile(string version,
		dataset($.Layout_XG.routp) infile, dataset($.Layout_Sanctions) srcfile) := FUNCTION
	
	datafile := infile;	
	cnt := count(datafile);
	hdr := MakeXMLHdr(version, cnt, srcfile);
	return OUTPUT(datafile,,'~thor::medicaidsanctions::'+version,
			xml('Entity', heading(FROMUNICODE(hdr, 'utf8'),Footer),trim, OPT), overwrite);
END;


END;