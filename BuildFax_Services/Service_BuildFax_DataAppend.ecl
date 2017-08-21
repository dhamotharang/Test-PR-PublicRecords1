/*--SOAP--
  <message name="Service_BuildFax_DataAppend">
	<part name="batch_in" type="tns:XmlDataSet" cols="200" rows="20" />
</message>
*/
/*--INFO--
	Input:  BuildFaxRequest
	Output: BuildFaxResult

  This is the BuildFax data append service.  
	
*/
			
EXPORT Service_BuildFax_DataAppend() := FUNCTION
  Request := DATASET([], BuildFax_Services.Layout_BuildFax.input_rec) : STORED('batch_in', FEW);
	RETURN ProcessBuildFaxDataAppend(Request);
END;