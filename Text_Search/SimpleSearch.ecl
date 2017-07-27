/*--SOAP--
<message name="Search and Compare">
  <part name="Search" type="xsd:string" rows="7" cols="40" />
	<part name="Score" type="xsd:boolean"/>
	<part name="Seqnum" type="xsd:unsignedInt"/>
	<part name="ExpEqv" type="xsd:boolean">
		<html>
			<td width="20%"><font face="Verdana" size="2">Expand Equivalences:</font></td>
			<td><input type="checkbox" name="ExpEqv" checked="true"/></td>
		</html>
	</part>
	<part name="DrctExp" type="xsd:boolean">
		<html>
			<td width="20%"><font face="Verdana" size="2">Expand Directionals:</font></td>
			<td><input type="checkbox" name="DrctExp" checked="false"/></td>
		</html>
	</part>
 </message>
*/
/*--USES-- Text_Search.search_form_xslt
*/

EXPORT SimpleSearch() := FUNCTION
	STRING srchString := '' : STORED('Search');
	BOOLEAN score := FALSE : STORED('Score');
	BOOLEAN expEqv := FALSE : STORED('ExpEqv');
	BOOLEAN drctExp := FALSE : STORED('DrctExp');
	UNSIGNED4 seq := 0 : STORED('Seqnum');
	STRING stem := '~THOR::REGRESSION';
	STRING srcType := 'SIMPLE';
	STRING qual := 'SMALL_TEST';

	info := Text_Search.FileName_Info_Instance(stem, srcType, qual);
	tm := Text_Search.Text_Search_Module(info, srchString, score, TRUE,,,, expEqv, drctExp);
	RETURN OUTPUT(Text_Search.pack(srchString, seq, tm.answers));
END; 