/*--SOAP-- 
<message name="EntityClassify">
<part name="Contents" type="tns:EspStringArray" cols="70" rows="25"/>
<part name="Categories" type="tns:EspStringArray"/>
<part name="Format" type="xsd:string"/>
</message>
*/
/*--INFO-- Entity extraction and classification demonstration code
*/
/*--HELP--

*/

export EntityClassify(unsigned dummy = 0) := FUNCTION

  set of string instrings := [] : stored('Contents');
	StringRec := RECORD string s; END;
	
    valid_chars := ' !"#$%&`()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_\'abcdefghijklmnopqrstuvwxyz{|}~';

	indataset := dataset(instrings, StringRec) ;

	DocContentsRecord cpt(StringRec L, integer c) := TRANSFORM
	  SELF.docId := c;
		SELF.docContents := StringLib.StringFilter(L.s, valid_chars);
	END;
	
	inData := PROJECT(indataset, cpt(LEFT, COUNTER));
	return EntityClassifier(indata);

END;