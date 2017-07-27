/* 2009-03-30T08:48:05 (Magesh Thulasi) */
/*--SOAP--
<message name="Service_SSN">
  <part name="Seq" type="xsd:unsignedInt"/>
  <part name="SSN" type="xsd:string"/>
</message>
*/
/*--INFO-- This service returns address info based on SSN. */
/*--RESULT-- xslt.html */

EXPORT Service_SSN := MACRO

	UNSIGNED4 Seq_Value := 0 		: STORED('Seq');
	STRING11  SSN_Value := ''		: STORED('SSN');

	// Need to set this to allow Driver search
	#STORED ('AllowAll',true);
	#STORED ('LogWorkunit', true);
	
	Result := CompID_Services.Search_SSN.getResultForSSNInquiry(SSN_Value, Seq_Value);
	OUTPUT(Result, NAMED('CompId_SSN'));

ENDMACRO;
