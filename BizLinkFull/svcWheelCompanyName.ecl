/*--SOAP--
<message name="Company Search">
  <part name="CompanySearchRequest" type="tns:XmlDataSet" cols="80" rows="50"/>
 </message>
*/
/*--HELP-- 
<pre>
&lt;CompanySearchRequest&gt;
 &lt;Row&gt;
 &lt;User&gt;
  &lt;ReferenceCode&gt;&lt;/ReferenceCode&gt; 
  &lt;BillingCode&gt;&lt;/BillingCode&gt; 
  &lt;QueryId&gt;&lt;/QueryId&gt; 
  &lt;CompanyId&gt;&lt;/CompanyId&gt; 
  &lt;IP&gt;&lt;/IP&gt; 
  &lt;ResultFormat&gt;&lt;/ResultFormat&gt; 
  &lt;DataRestrictionMask&gt;&lt;/DataRestrictionMask&gt; 
  &lt;DataPermissionMask&gt;&lt;/DataPermissionMask&gt; 
 &lt;EndUser&gt;
  &lt;CompanyName&gt;&lt;/CompanyName&gt; 
  &lt;StreetAddress1&gt;&lt;/StreetAddress1&gt; 
  &lt;Company&gt;&lt;/Company&gt; 
  &lt;State&gt;&lt;/State&gt; 
  &lt;Zip5&gt;&lt;/Zip5&gt; 
  &lt;/EndUser&gt;
  &lt;MaxWaitSeconds&gt;0&lt;/MaxWaitSeconds&gt; 
  &lt;RelatedTransactionId&gt;&lt;/RelatedTransactionId&gt; 
  &lt;AccountNumber&gt;&lt;/AccountNumber&gt; 
  &lt;/User&gt;
  &lt;RemoteLocations&gt;&lt;/RemoteLocations&gt; 
  &lt;ServiceLocations&gt;&lt;/ServiceLocations&gt; 
 &lt;Options&gt;
  &lt;MaxResults&gt;0&lt;/MaxResults&gt; 
  &lt;UseEditN&gt;0&lt;/UseEditN&gt; 
  &lt;StartingRecord&gt;1&lt;/StartingRecord&gt; 
  &lt;ReturnCount&gt;10&lt;/ReturnCount&gt; 
 &lt;/Options&gt;
 &lt;SearchBy&gt;
  &lt;CompanyNamePrefix&gt;&lt/CompanyNamePrefix&gt;
 &lt;/SearchBy&gt;
 &lt;/Row&gt;
&lt;/CompanySearchRequest&gt;
</pre>
*/
IMPORT SALT26,BizLinkFull, iesp;
EXPORT svcWheelCompanyName() := FUNCTION
    ds_in    := dataset([], iesp.CompanySearch.t_CompanySearchRequest)    : stored('CompanySearchRequest', few);
    // From a list of MaxResults length, return records StartingRecord to StartingRecord + ReturnCount
    
    ReturnCount     := if(ds_in[1].Options.ReturnCount=0, 1, ds_in[1].Options.ReturnCount);
    StartingRecord  := if(ds_in[1].Options.StartingRecord=0, 1, ds_in[1].Options.StartingRecord); 
    MaxResults      := if(ds_in[1].Options.MaxResults=0, iesp.Constants.Lookups.SEARCH_MAX_COMPANYSEARCH_RESPONSE_RECORDS, ds_in[1].Options.MaxResults);
    SALT26.StrType Input_prefix := trim(ds_in[1].SearchBy.CompanyNamePrefix, all);
    results := BizLinkFull.Wheel.Fetch_company_name(SALT26.StringToUppercase(Input_prefix), min(StartingRecord + ReturnCount,MaxResults));
    
    iesp.CompanySearch.t_CompanySearchRecord to_final(recordof(results) le) := TRANSFORM
      self.CompanyName := le.word_list;
      self.Specificity := le.specificity;
    end;
    
    iesp.CompanySearch.t_CompanySearchResponse build_esdl_result(DATASET(iesp.CompanySearch.t_CompanySearchRecord) le) := TRANSFORM
      self._Header := [];
      self.InputEcho := ds_in[1].SearchBy;
      self.RecordCount := count(le);
      self.Records := le;
    END;
    
  paged := choosen(results, ReturnCount, StartingRecord);
  res := ROW(build_esdl_result(project(paged, to_final(left)) ));
  
  RETURN output( res, named( 'Results' ) );
END;

