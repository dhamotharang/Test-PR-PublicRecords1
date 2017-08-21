/*--SOAP--
  <message name="Service_BuildFax">
	<part name="BuildFaxRequest" type="tns:XmlDataSet" cols="200" rows="20" />
</message>
*/
/*--INFO--
	Input:  BuildFaxRequest
	Output: BuildFaxResult

  This is the BuildFax data append service.  
	
*/
			
EXPORT Service_BuildFax() := FUNCTION
  Request := ROW([], BuildFax_Services.Layout_BuildFax.input_rec_online) : STORED('BuildFaxRequest', FEW);
	RETURN ProcessBuildFax(Request);
END;