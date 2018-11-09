import ut;
export MakeHdr := MODULE

shared hdg_xml := '<?xml version="1.0" encoding="utf-8"?>\r\n<Watchlist>\r\n';
shared hdg_Pt1:= hdg_xml+'<BuildInfo>\r\n<ListInfo>\r\n<Type>';
shared hdg_Pt1a := '</Type>\r\n<ID>';
shared hdg_Pt2:= '</ID>\r\n<Name>';
shared hdg_Pt3:= '</Name>\r\n<Description>';
shared hdg_Pt4:= '</Description><Encrypt>True</Encrypt>\r\n<Publication>';
shared hdg_Pt5:= '</Publication>\r\n';
shared hdg_Pt5a := '</ListInfo>\r\n<UserInfo><ClientID>BIXG</ClientID></UserInfo><OutputType>W32Bit</OutputType>\r\n';
shared hdg_Pt5b := '<Entity_List Count="';
shared hdg_Pt6:= '">';


shared SearchCriteria := 
	'<SearchCriteria>\r\n' +
	'<group id="1" name="Country">\r\n' +
	'<value id="1" name="Afghanistan"/>\r\n' +
	'<value id="2" name="Aland Islands"/>\r\n' +
	'</group>\r\n' +
	'<group id="4" name="Negative News Alert">\r\n' +
		'<value id="9" name="No Value"/>\r\n' +
		'<value id="1" name="Negative News Alert for Entity"/>\r\n' +
	'</group>\r\n' +
	'</SearchCriteria>\r\n';
	
shared SpecialId(string Watchlistname) := TRIM(CASE(Watchlistname,
'FINANCIAL SANCTIONS' => '<SpecialListID>25</SpecialListID>',
'MORTGAGE SANCTIONS' => '<SpecialListID>26</SpecialListID>',
'OFAC SDN ADDITIONS AND MODIFICATIONS' => '<SpecialListID>28</SpecialListID>',
'REGISTERED MONEY SERVICES BUSINESSES' => '<SpecialListID>29</SpecialListID>',
''));

shared string HdrSearchCriteria(string Watchlistname) := TRIM(
			IF(Watchlistname = 'UN CONSOLIDATED LIST',
				'<SearchCriteria>\r\n<group id="1" name="Sanctions">\r\n' 
				+	'<value id="16" name="1988 Sanctions"/>\r\n'
				+ '<value id="13" name="Central African Republic"/>\r\n'
				+	'<value id="2" name="Cote d\'Ivoire - Ivory Coast"/>\r\n'
				+	'<value id="3" name="Democratic Republic of the Congo"/>\r\n'
				+	'<value id="12" name="Guinea-Bissau Travel Ban"/>\r\n'
				+	'<value id="4" name="Iran"/>\r\n'
				+	'<value id="5" name="Iraq"/>\r\n'
				+ '<value id="1" name="ISIL (Da\'esh) and Al-Qaida Sanctions"/>\r\n'
				+	'<value id="7" name="Lebanon"/>\r\n'
				+	'<value id="6" name="Liberia"/>\r\n'
				+	'<value id="11" name="Libya"/>\r\n'
				+	'<value id="8" name="North Korea - Democratic People\'s Republic of Korea"/>\r\n'
				+	'<value id="19" name="Resolution 1718 (2006) and Resolution 2270 (2016)"/>\r\n'
				+	'<value id="17" name="Resolution 2270 (2016)-Annex III"/>\r\n'
				+	'<value id="20" name="Resolution 2321 (2016) - Paragraph 12(a)"/>\r\n'
				+	'<value id="21" name="Resolution 2321 (2016) - Paragraph 12(d)"/>\r\n'
				+	'<value id="18" name="Resolution 2375 (2017)"/>\r\n'
				+	'<value id="9" name="Somalia and Eritrea"/>\r\n'
				+ '<value id="15" name="South Sudan"/>\r\n'
				+	'<value id="10" name="Sudan"/>\r\n'
				+ '<value id="14" name="Yemen"/>\r\n'				
			
				+ '</group>\r\n</SearchCriteria>\r\n',
				''));



export string MakeXMLHdr(string Watchlistname, integer cnt, string element) := 
				hdg_Pt1 + IF(element='Country_List','Country','Entity') + hdg_Pt1a
							+Conversions.SourceCodetoBridgerSourceID(Watchlistname)
							+hdg_Pt2
							+Conversions.SourceCodetoName(Watchlistname)
							+hdg_Pt3
							+Conversions.SourceCodetoDescr(Watchlistname)
									+ IF(GetDisclaimer(Watchlistname)='','',' '+GetDisclaimer(Watchlistname))
							+hdg_Pt4
					//		+filedate[1..4]+'-'+filedate[5..6]+'-'+filedate[7..8]+'T12:00:00.0000000Z'
					+ GetPublicationDate(Watchlistname)
							+hdg_Pt5
							+ SpecialId(Watchlistname)
							+ HdrSearchCriteria(Watchlistname)
							+ hdg_pt5a
							+'</BuildInfo>\r\n'
							+	'<' + element +  ' Count="'	//							hdg_Pt5b
							+(string)cnt
						+hdg_Pt6;
						
export 	Footer := '</Entity_List></Watchlist>\r\n';

export OutputDataXMLFile(dataset(recordof(Layout_Watchlist.routp)) infile
		,string Watchlistname, string filename)
		:= FUNCTION

	cnt := count(infile);
	hdr := MakeXMLHdr(Watchlistname, cnt, 'Entity_List');
	return OUTPUT(infile,,'~thor::uniqueid::'+filename,
			xml('Entity', heading(hdr,Footer),trim, OPT), overwrite);
END;

export 	GeoFooter := '</Country_List></Watchlist>\r\n';


export OutputGeoXMLFile(dataset(recordof(Layout_Watchlist.rgeo)) infile
		,string Watchlistname, string filename)
		:= FUNCTION

	cnt := count(infile);
	outfile := PROJECT(infile, Layout_Watchlist.rgeoOut);

	hdr := MakeXMLHdr(Watchlistname, cnt, 'Country_List');
	return OUTPUT(outfile,,'~thor::uniqueid::'+filename,
			xml('Country', heading(hdr,GeoFooter),trim, OPT), overwrite);
END;

						
END;