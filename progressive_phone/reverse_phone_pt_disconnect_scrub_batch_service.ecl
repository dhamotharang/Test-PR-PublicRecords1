/*--SOAP--
<message name="Reverse_Phone_PT_Disconnect_Scrub_Batch_Service" wuTimeout="300000">
	<part name="phoneList_in" type="tns:XmlDataSet" cols="70" rows="25"/>
</message>
*/
/*--INFO-- Reverse Phone Potential Temporary Disconnect Scrub Batch*/
/*--RESULT-- xslt.html */

IMPORT progressive_phone;

EXPORT reverse_phone_pt_disconnect_scrub_batch_service := MACRO
	data_in := DATASET([], progressive_phone.layout_reverse_phone_pt_disconnect_scrub_in) : STORED('phoneList_in', FEW);
	OUTPUT(progressive_phone.FN_ReversePhonePTDisconnectScrub(data_in), NAMED('Results'));
ENDMACRO;