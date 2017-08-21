/*--SOAP-- 
<message name="ReportService">
	<part name="BookingID" type="xsd:string"/>
  <part name="DID" type="xsd:string"/>
  <part name="GLBPurpose" type="xsd:byte"/>
  <part name="DPPAPurpose" type="xsd:byte"/>
	<part name="ApplicationType" type="xsd:string"/>
	<part name="JailBookingReportRequest" type="tns:XmlDataSet" cols="80" rows="10"/>
</message>
*/
/*--HELP--
<pre>
&lt;JailBookingRequest&gt;
	&lt;row&gt;
		&lt;User&gt;
			&lt;GLBPurpose&gt;1&lt;/GLBPurpose&gt;
			&lt;DLPurpose&gt;1&lt;/DLPurpose&gt;
			&lt;EndUser/&gt;
		&lt;/User&gt;
		&lt;ReportBy&gt;
			&lt;CaseNumber&gt;&lt;/CaseNumber&gt;
			&lt;UniqueId&gt;&lt;/UniqueId&gt;
		&lt;/ReportBy&gt;	
	&lt;/row&gt;
&lt;/JailBookingRequest&gt;
</pre>
*/

import iesp;
#warning('Service no longer used as of 09/26/2012.')
EXPORT ReportService := MACRO
	ds_in := DATASET([], iesp.jailbooking.t_JailBookingReportRequest) : STORED('JailBookingReportRequest');
	first_row := ds_in[1] : INDEPENDENT;
	iesp.ECL2ESP.SetInputBaseRequest(first_row);
	JailBooking_Services.IParam.SetInputReportBy(first_row.ReportBy);
	JailBooking_Services.IParam.SetInputReportOptions(first_row.Options);
	
	tempMod := JailBooking_Services.IParam.getReportModule(first_row.ReportBy);
	bookingReport := JailBooking_Services.ReportRecords.val(tempMod);
	
	iesp.ECL2ESP.Marshall.MAC_Marshall_Results(bookingReport, results, 
                iesp.jailbooking.t_JailBookingReportResponse, Records, true);
								
	output(results, named('Results'));
ENDMACRO;
