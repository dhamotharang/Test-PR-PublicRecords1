import Worldcheck_Bridger;
export MakeHdr := MODULE



shared hdg_xml := '<?xml version="1.0" encoding="utf-8"?><Watchlist>';
shared hdg_Pt1:= hdg_xml+'<BuildInfo><ListInfo><Type>Entity</Type><ID>';
shared hdg_Pt2:= '</ID>\r\n<Name>';
shared hdg_Pt3:= '</Name>\r\n<Description>';
shared hdg_Pt4:= '</Description><Encrypt>True</Encrypt>\r\n<Publication>';
shared hdg_Pt5:= '</Publication>';
shared hdg_Pt5a := '</ListInfo><UserInfo><ClientID>Accuity</ClientID></UserInfo><OutputType>W32Bit</OutputType></BuildInfo>\r\n';
shared hdg_Pt5b := '<Entity_List Count="';
shared hdg_Pt6:= '">';

export unicode MakeGeoXMLHdr(string SourceCode, integer cnt) := 
				hdg_xml+'<BuildInfo><ListInfo><Type>Country</Type><ID>' 
					+Conversions.GeoSourceCodetoBridgerSourceID(SourceCode)
					+hdg_Pt2
					+Conversions.GeoSourceCodetoName(SourceCode)
					+hdg_Pt3
					+Conversions.GeoSourceCodetoDescr(SourceCode)
					+hdg_Pt4
					//+filedate[1..4]+'-'+filedate[5..6]+'-'+filedate[7..8]+'T12:00:00.0000000Z'
					+ GetPublicationDate(SourceCode)
					+hdg_Pt5 + hdg_Pt5a + '<Country_List Count="'
							+(string)cnt
						+hdg_Pt6;
export unicode MakeXMLHdr(string SourceCode, integer cnt, boolean createSearchCriteria) := 
				hdg_Pt1 
							+Conversions.SourceCodetoBridgerSourceID(TRIM(SourceCode,ALL))
							+hdg_Pt2
							+Conversions.SourceCodetoName(SourceCode)
							+hdg_Pt3
							+Conversions.SourceCodetoDescr(SourceCode)
									+ IF(GetDisclaimer(SourceCode)='','',' '+GetDisclaimer(SourceCode))
							+hdg_Pt4
					+ GetPublicationDate(SourceCode)
							+hdg_Pt5  +
					IF(NOT createSearchCriteria, '',
						'<SearchCriteria>\n' + $.ExtractSearchCriteria + '</SearchCriteria>\n')
							+ hdg_Pt5a + hdg_Pt5b
							+(string)cnt
						+hdg_Pt6;

export 	Footer := '\r\n</Entity_List></Watchlist>\r\n';
export 	GeoFooter := '\r\n</Country_List></Watchlist>\r\n';

export CreateXMLFileHdr(string code,
		dataset(recordof(Worldcheck_Bridger.Layout_Worldcheck_Entity_Exported.routp)) infile,
		boolean createSearchCriteria = false) := FUNCTION
	cnt := Accuity.Functions.getEntityCount(infile);
	hdr := MakeXMLHdr(code, cnt, createSearchCriteria);
	return hdr;
END;

export CreateGeoXMLFileHdr(string code,
		dataset(recordof(Worldcheck_Bridger.Layout_Worldcheck_Entity_Exported.rgeo)) infile) := FUNCTION
	cnt := count(infile);
	hdr := MakeGeoXMLHdr(code, cnt);
	return hdr;
END;

/*Dummy Record Values:
Set Entity Type to Individual
Set Reason Listed to Ã‚â€œDefault RecordÃ‚â€
Set First Name to Ã‚â€œZZZZZZZÃ‚â€
Set Middle Name to Ã‚â€œZZZZZZZÃ‚â€
Set Last Name to Ã‚â€œZZZZZZZÃ‚â€
*/
dummyRecord(string code) := PROJECT(
	DATASET([
	{'0','Individual','ZZZZZZZ','ZZZZZZZ','ZZZZZZZ','Default Record'}],
		{
			string id;
			string type;
 			string first_name;
			string middle_name;
			string last_name;
			string reason_listed;
		}),
		TRANSFORM(
			Worldcheck_Bridger.Layout_Worldcheck_Entity_Exported.routp,
			SELF.accuityDataSource := code;
			SELF := LEFT;
			SELF := [];
			));


export OutputDataXMLFile(string code, string filename,
		dataset(recordof(Worldcheck_Bridger.Layout_Worldcheck_Entity_Exported.routp)) infile,
		boolean createSearchCriteria = false) 
			:= FUNCTION

	ds := IF(EXISTS(infile),infile,dummyRecord(code));
	cnt := count(infile);
	//hdr := CreateXMLFileHdr(code, ds, createSearchCriteria);
	return OUTPUT(ds,,'~thor::accuity::'+filename,
			xml('Entity', heading(FROMUNICODE(CreateXMLFileHdr(code, ds, createSearchCriteria), 'utf8')
						,Footer),trim, OPT), overwrite);
END;

						
END;