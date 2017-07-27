/* 2009-04-17 (Manish Shah) */
/*--SOAP--
<message name="Service_DLN">
  <part name="Seq" type="xsd:unsignedInt"/>
  <part name="DLN" type="xsd:string"/>
  <part name="DLNState" type="xsd:string"/>
</message>
*/
/*--INFO-- This service returns address info based on DLN. */
/*--RESULT-- xslt.html */

EXPORT Service_DLN := MACRO

	UNSIGNED4 Seq_Value 		:= 0 		: STORED('Seq');
	STRING    DLN_Value 		:= ''		: STORED('DLN');
	STRING    State_Value 	:= ''		: STORED('DLNState');

	// Need to set this to allow Driver search
	#STORED ('AllowAll',true);
	#STORED ('LogWorkunit', true);
	
	result := CompID_Services.Search_DLN.getResultForDLNInquiry(DLN_Value, State_Value, Seq_Value);
	
	OUTPUT(result, NAMED('CompId_DLN'));

ENDMACRO;
