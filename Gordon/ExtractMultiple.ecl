/*--SOAP-- 
<message name="ContentAnalysis">
<part name="Contents" type="tns:EspStringArray" cols="70" rows="25"/>
<part name="Categories" type="tns:EspStringArray"/>
<part name="Format" type="xsd:string"/>
<part name="MaxDids" type="xsd:integer"/>
<part name="MaxFull" type="xsd:integer"/>
</message>
*/
/*--INFO-- Entity extraction demonstration code
*/
/*--HELP--

*/

export ExtractMultiple(unsigned dummy = 0) := FUNCTION

  set of string instrings := [] : stored('Contents');
	StringRec := RECORD string s; END;
	
	indataset := dataset(instrings, StringRec) ;

	DocContentsRecord cpt(StringRec L, integer c) := TRANSFORM
	  SELF.docId := c;
		SELF.docContents := L.s;
	END;
	
	inData := PROJECT(indataset, cpt(LEFT, COUNTER));
	return EntityExtractor(indata);

END;