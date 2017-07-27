/* 2009-04-17T13:31:00 (Magesh Thulasi) */
/*--SOAP--
<message name="CidCommon_Service">
  <part name="EditsCompIdRequest" type="tns:XmlDataSet" cols="200" rows="20" />
</message>
*/
/*--INFO--  
	Input: EDITS request
	Output: EDITS response
	
	This is the generic CompID service. It invokes one of the four CompID functions and 
	returns the appropriate response. The four functions include SSN-based, DL-based, Address-based
	and Address Enhancement.
*/

IMPORT EditsV2, iesp;

EXPORT CidCommon_Service() := FUNCTION
	Layout_EditsRequest := iesp.cp_internal.t_EditsCompIdRequest;
	Layout_InputSet := iesp.cp_internal.t_EditsInputSet;
	Layout_CompIdResult := Layouts.Layout_CompId_Result;
	
	// AllowAll=true allows GLB and DPPA data to be included
	#STORED ('AllowAll',true);
	#STORED ('LogWorkunit', true);
	
	// Read the request
	EDITS_Request := DATASET([], Layout_EditsRequest) : STORED('EditsCompIdRequest', FEW);
	
	// Retrieve edits records from the request
	Layout_InputSet exSrch(Layout_EditsRequest L) := TRANSFORM
		SELF.EditsInputRecords := L.InputSet.EditsInputRecords;
	END;
	InputSet := PROJECT(CHOOSEN(EDITS_Request,1), exSrch(LEFT));

	// Parse edits records into a convenient layout (t_EditsCompIdResponse)
	EditsResponse := CompId_Services.Search_Common.getResultForEdits(InputSet.EditsInputRecords);
	
	// OUTPUT(EditsResponse,NAMED('EditsResponse'));
	iesp.ECL2ESP.Marshall.MAC_Marshall_Results(EditsResponse[1], Results1, 
			iesp.cp_internal.t_EditsCompIdResponse, Results, TRUE);

	// return action for execution
	RETURN OUTPUT(Results1, named('Results'));
	
END;
