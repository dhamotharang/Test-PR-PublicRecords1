/*--SOAP-- 
<message name="EntityEnhance">
<part name="EntityDefs" type="tns:XmlDataSet" cols="70" rows="25"/>
<part name="MaxDids" type="xsd:integer"/>
<part name="MaxFull" type="xsd:integer"/>
</message>
*/
/*--INFO-- Entity enhancement demonstration code
*/
/*--HELP--

*/

export EntityEnhance(unsigned dummy = 0) := FUNCTION

indata := dataset([],Layout_Entity) : STORED('EntityDefs',few);


	return EntityEnhancer(indata);

END;