/*--SOAP--
<message name="SearchService">
  <part name="Phone" type="xsd:string"/>
  <part name="DID" type="xsd:string" required="1"/>
	<part name="PhonesfeedbackReportRequest" type="tns:XmlDataSet" cols="50" rows="10" />
</message>
*/
/*--INFO-- This service Returns Phones Feedback Information.*/

import PhonesFeedback,autostandardI,iesp;
export ReportService := macro

	rec_in := iesp.phonesfeedback.t_PhonesFeedbackReportRequest;
	ds_in := DATASET ([], rec_in) : STORED ('PhonesfeedbackReportRequest', FEW);
	first_row := ds_in[1] : independent;

    //set options
    
    iesp.ECL2ESP.SetInputBaseRequest (first_row);

    //set main search criteria:
     report_by := global (first_row.ReportBy);
	#stored('phone', report_by.Phone);
	#stored('DID', report_by.UniqueId);
     input_params := AutoStandardI.GlobalModule();
	tempmod := module(project(input_params,PhonesFeedback_Services.ReportService_Records.params,opt))
			EXPORT string15 Phone_number :='' :STORED('Phone');
			EXPORT string12 in_DID :='' :STORED('DID');
	end;

	tmp := PhonesFeedback_Services.ReportService_Records.val(tempmod);
		// iesp.ECL2ESP.Marshall.MAC_Marshall_Results(tmp, results, iesp.phonesfeedback.t_PhonesFeedbackSearchResponse);
		// output(results, named('Results'));	
	output(tmp, named('Results'));	
		// output(tempmod);
endmacro;
// ReportService();
/*
<PhonesfeedbackReportRequest>
<row>
<SearchBy>
  <Phone>8643222844</Phone>
  <UniqueID></UniqueID>
</SearchBy>
</row>
</PhonesfeedbackReportRequest>
*/
