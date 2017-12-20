/*2013-04-12T14:56:00Z (David Wheelock)
THIS IS THE VERSION WITH ESP CODE ADDED IN
*/
// USE THIS VERSION WHEN DEPLOYING TO ROXIE
/*--SOAP--
<message name="City Search">
  <part name="CitySearchRequest" type="tns:XmlDataSet" cols="80" rows="50"/>
 </message>
*/
/*--HELP-- 
<pre>
&lt;CitySearchRequest&gt;
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
  &lt;City&gt;&lt;/City&gt; 
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
  &lt;CityNamePrefix&gt;&lt/CityNamePrefix&gt;
 &lt;/SearchBy&gt;
 &lt;/Row&gt;
&lt;/CitySearchRequest&gt;
</pre>
*/
IMPORT SALT27,BizLinkFull, iesp;
EXPORT svcWheelCity() := FUNCTION
    ds_in    := dataset([], iesp.CitySearch.t_CitySearchRequest)    : stored('CitySearchRequest', few);
    // From a list of MaxResults length, return records StartingRecord to StartingRecord + ReturnCount
    
    ReturnCount     := if(ds_in[1].Options.ReturnCount=0, 1, ds_in[1].Options.ReturnCount);
    StartingRecord  := if(ds_in[1].Options.StartingRecord=0, 1, ds_in[1].Options.StartingRecord); 
    MaxResults      := if(ds_in[1].Options.MaxResults=0, iesp.Constants.Lookups.SEARCH_MAX_CITYSEARCH_RESPONSE_RECORDS, ds_in[1].Options.MaxResults);
    BOOLEAN Input_fuzzy_editn := ds_in[1].Options.UseEditN;
    SALT27.StrType Input_prefix := REGEXREPLACE('[ ]+',trim(ds_in[1].SearchBy.CityNamePrefix,LEFT,RIGHT),' ');
    results := BizLinkFull.Wheel.Fetch_city_clean(SALT27.StringToUppercase(Input_prefix), min(StartingRecord + ReturnCount,MaxResults),BizLinkFull.Config_BIP.city_clean_WheelThreshold);
    
    iesp.CitySearch.t_CitySearchRecord to_final(recordof(results) le) := TRANSFORM
      self.CityName := le.word_list;
      self.Specificity := le.specificity;
    end;
    
    iesp.CitySearch.t_CitySearchResponse build_esdl_result(DATASET(iesp.CitySearch.t_CitySearchRecord) le) := TRANSFORM
      self._Header := [];
      self.InputEcho := ds_in[1].SearchBy;
      self.RecordCount := count(le);
      self.Records := le;
    END;
    
  paged := choosen(results, ReturnCount, StartingRecord);
  res := ROW(build_esdl_result(project(paged, to_final(left)) ));
  
  RETURN output( res, named( 'Results' ) );
END;


