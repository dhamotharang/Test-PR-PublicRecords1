/*--SOAP--
<message name="ReportService">
  <part name="Addr" type="xsd:string"/>
  <part name="City" type="xsd:string"/>
  <part name="State" type="xsd:string"/>
  <part name="Zip" type="xsd:string"/>
  <separator />
  <part name="DID" type="xsd:string" required="1" />
  <separator />
  <part name="AddressfeedbackReportRequest" type="tns:XmlDataSet" cols="80" rows="30"/>
</message>
*/
/*--INFO-- This service returns address feedback information.*/
/*--HELP--
<pre>
&lt;AddressfeedbackReportRequest&gt;
  &lt;Row&gt;
    &lt;ReportBy&gt;
      &lt;Address&gt;
        &lt;StreetNumber&gt;&lt;/StreetNumber&gt;
        &lt;StreetPreDirection&gt;&lt;/StreetPreDirection&gt;
        &lt;StreetName&gt;&lt;/StreetName&gt;
        &lt;StreetSuffix&gt;&lt;/StreetSuffix&gt;
        &lt;StreetPostDirection&gt;&lt;/StreetPostDirection&gt;
        &lt;UnitDesignation&gt;&lt;/UnitDesignation&gt;
        &lt;UnitNumber&gt;&lt;/UnitNumber&gt;
        &lt;StreetAddress1&gt;&lt;/StreetAddress1&gt;
        &lt;StreetAddress2&gt;&lt;/StreetAddress2&gt;
        &lt;City&gt;&lt;/City&gt;
        &lt;State&gt;&lt;/State&gt;
        &lt;Zip5&gt;&lt;/Zip5&gt;
        &lt;Zip4&gt;&lt;/Zip4&gt;
        &lt;StateCityZip&gt;&lt;/StateCityZip&gt;
      &lt;/Address&gt;
      &lt;UniqueId&gt;&lt;/UniqueId&gt;
    &lt;/ReportBy&gt;
  &lt;/Row&gt;
&lt;/AddressfeedbackReportRequest&gt;
</pre>
*/
/*--USES-- ut.input_xslt */

import AddressFeedback,iesp;

export ReportService := macro

//The following macro defines the field sequence on WsECL page of query.
  WSInput.MAC_AddrFeedback_ReportService();

  ds_in := dataset([], iesp.addressfeedback.t_AddressFeedbackReportRequest) : stored('AddressfeedbackReportRequest', FEW);
  first_row := global(ds_in[1]) : independent;
  iesp.ECL2ESP.SetInputBaseRequest(first_row);
  AddressFeedback_Services.IParam.SetInputReportBy(first_row.reportBy);
  
  in_mod := AddressFeedback_Services.IParam.getReportModule(first_row.ReportBy);
  recs := AddressFeedback_Services.Records(in_mod);
  results := AddressFeedback_Services.Functions.formatReport(recs);
                
  output(results, named('Results'));


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
