/*--SOAP-- 
<message name="ContentAnalysis">
<part name="Content" type="xsd:string"/>
<part name="Categories" type="tns:EspStringArray"/>
<part name="Format" type="xsd:string"/>
<part name="MaxDids" type="xsd:integer"/>
<part name="MaxFull" type="xsd:integer"/>
<part name="DocId" type="xsd:integer"/>
</message>
*/
/*--INFO-- Entity extractor initial version.
*/
/*--HELP--

*/
import Address,Business_Header,Business_Header_ss,Doxie,Header_Services,Text,Watchdog;

export Extractor(unsigned dummy = 0) := 
	function

integer docId := 0 : stored('DocId');
string2048 in_content := '' : stored('Content');
inData := dataset([{docId, in_content}], DocContentsRecord);

  return EntityExtractor(inData);
End;
