/*--SOAP--
<message name="BDID_Update_Batch_Service" wuTimeout="300000">
	<part name="batch_in" type="tns:XmlDataSet" cols="70" rows="25"/>
</message>
*/
/*--INFO-- Returns updated BDID.*/


IMPORT Business_Header;


EXPORT BDID_Update_Batch_Service() := FUNCTION

	// Key
	rcidKey := Business_Header.Key_Business_Header_RCID;


	// Records
	LayoutIn := Layout_BDID_Update_In;
	LayoutOut := Layout_BDID_Update_Out;


	// Main
	data_in := DATASET([], LayoutIn) : STORED('batch_in', FEW);
	rslt := JOIN(data_in, rcidKey,
							 KEYED(LEFT.bdid = RIGHT.rcid),
							 TRANSFORM(LayoutOut, SELF.current_bdid := RIGHT.bdid, SELF := LEFT),
							 KEEP(1));
	RETURN OUTPUT(rslt, NAMED('Results'), ALL);
END;
