/*--SOAP--
<message name="CheckSearchService" wuTimeout="300000">
  <part name="CheckPersonSearchRequest" type="tns:XmlDataSet" cols="80" rows="30" />
</message>
*/
/*--INFO--*/
/*--HELP-- 
<pre>
&lt;CheckPersonSearchRequest&gt;
    &lt;Row&gt;
        &lt;User&gt;
	        &lt;GLBPurpose&gt;&lt;/GLBPurpose&gt;
	        &lt;DLPurpose&gt;&lt;/DLPurpose&gt;
	        &lt;SSNMask&gt;&lt;/SSNMask&gt;
	        &lt;DOBMask&gt;&lt;/DOBMask&gt;
          &lt;DataRestrictionMask&gt;&lt;/DataRestrictionMask&gt;
        &lt;/User&gt;
        &lt;Options&gt;
            &lt;ReturnCount&gt;&lt;/ReturnCount&gt;
            &lt;StartingRecord&gt;&lt;/StartingRecord&gt;
            &lt;FlipLastFirst&gt;&lt;/FlipLastFirst&gt;
        &lt;/Options&gt;
        &lt;SearchBy&gt;
            &lt;LastName&gt;&lt;/LastName&gt;
            &lt;SSN&gt;&lt;/SSN&gt;
            &lt;DriverLicense&gt;
              &lt;LicenseNumber&gt;&lt;/LicenseNumber&gt;
              &lt;IssueState&gt;&lt;/IssueState&gt;
            &lt;/DriverLicense&gt; 
        &lt;/SearchBy&gt;
    &lt;/Row&gt;
&lt;/CheckPersonSearchRequest&gt;
</pre>
*/

IMPORT iesp; 
EXPORT CheckSearchService () := MACRO
 #constant('SearchLibraryVersion', AutoheaderV2.Constants.LibVersion.LEGACY);
	//The following macro defines the field sequence on WsECL page of query. 
	WSInput.MAC_PersonSearch_Services_CheckSearchService();
	
  rec_in := iesp.checkpersonsearch.t_CheckPersonSearchRequest;
  ds_in := DATASET ([], rec_in) : STORED ('CheckPersonSearchRequest', FEW);
	
	recsMasked := PersonSearch_Services.Check_Records(ds_in).results;
	iesp.ECL2ESP.Marshall.MAC_Marshall_Results(recsMasked, results, 
                                             iesp.checkpersonsearch.t_CheckPersonSearchResponse, Records, 
																						 false, SubjectTotalCount);
  output(results,named('Results'));
ENDMACRO;
//CheckSearchService();