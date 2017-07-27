/*2015-06-24T16:52:16Z (Sai Nagula)
Open State search and Drivers exchange report grouping.
*/
/*--SOAP--

<message name="SearchService" wuTimeout="300000">
 <separator />  
  <part name="FirstName" type="xsd:string"/>
  <part name="AllowNickNames" type="xsd:boolean"/>
  <part name="LastName" type="xsd:string"/>
  <part name="PhoneticMatch" type="xsd:boolean"/>
  <part name="MiddleName" type="xsd:string"/>
  <part name="DateOfLoss" type="xsd:string"/>
	<part name="StartDate" type="xsd:string"/>
	<part name="EndDate" type="xsd:string"/>
 <separator />  
  <part name="RequestHashKey" type="xsd:boolean"/>
  <part name="ReportNumber" type="xsd:string"/>
  <part name="AgencyORI" type="xsd:string"/>
  <part name="Jurisdiction" type="xsd:string"/>
  <part name="JurisdictionState" type="xsd:string"/>
  <part name="AccidentLocationStreet" type="xsd:string"/>
  <part name="AccidentLocationCrossStreet" type="xsd:string"/>
  <part name="UserType" type="xsd:string"/>
 <separator />  
  <part name="Addr" type="xsd:string"/>
  <part name="City" type="xsd:string"/>
  <part name="State" type="xsd:string"/>
  <part name="Zip" type="xsd:string"/>
 <separator />  
  <part name="StartingRecord" type="xsd:unsignedInt"/>
  <part name="ReturnCount" type="xsd:unsignedInt"/>
	<part name="GroupRecords" type="xsd:boolean"/>
  <part name="MaxLimit" type="xsd:int"/>
  <part name="MaxResultsThisTime" type="xsd:unsignedInt"/>
  <part name="SkipRecords" type="xsd:unsignedInt"/>
  <part name="DPPAPurpose" type="xsd:byte"/>
  <part name="GLBPurpose" type="xsd:byte"/> 
  <part name="DataRestrictionMask" type="xsd:string" default="00000000000"/>
	<part name="SortOrder" type="xsd:string"/>
	<part name="SortField" type="xsd:string"/>
	<part name="SubscriptionReports" type="xsd:boolean"/>
  
  <part name="eCrashSearchRequest" type="tns:XmlDataSet" cols="80" rows="30" />
	<part name="Gateways" type="tns:XmlDataSet" cols="70" rows="25"/>
</message>
*/
/*--INFO-- Searches for eCrash Accident Report*/
/*--HELP-- 
<pre>
&lt;eCrashSearchRequest&gt;
 &lt;Row&gt;
   &lt;User&gt;
    &lt;GLBPurpose&gt;&lt;/GLBPurpose&gt;
    &lt;DLPurpose&gt;&lt;/DLPurpose&gt;
   &lt;/User&gt;
  &lt;Options&gt;
   &lt;StartingRecord&gt;&lt;/StartingRecord&gt;
   &lt;ReturnCount&gt;&lt;/ReturnCount&gt;
   &lt;GroupRecords&gt;&lt;/GroupRecords&gt;
	 &lt;SortOrder&gt;&lt;/SortOrder&gt;
	 &lt;SortField&gt;&lt;/SortField&gt;
	 &lt;SubscriptionReports&gt;&lt;/SubscriptionReports&gt;
	 &lt;MaxLimit&gt;&lt;/MaxLimit&gt;
  &lt;/Options&gt;	 
   &lt;SearchBy&gt;
     &lt;RequestHashKey&gt;&lt;/RequestHashKey&gt;
     &lt;ReportNumber&gt;&lt;/ReportNumber&gt;
     &lt;JurisdictionState&gt;&lt;/JurisdictionState&gt;
     &lt;Jurisdiction&gt;&lt;/Jurisdiction&gt;
     &lt;AgencyORI&gt;&lt;/AgencyORI&gt;
     &lt;UserType&gt;&lt;/UserType&gt;
     &lt;DateOfLoss&gt;  
       &lt;Year&gt;&lt;/Year&gt;
       &lt;Month&gt;&lt;/Month&gt;
       &lt;Day&gt;&lt;/Day&gt;
     &lt;/DateOfLoss&gt;
		 &lt;StartDate&gt;  
       &lt;Year&gt;&lt;/Year&gt;
       &lt;Month&gt;&lt;/Month&gt;
       &lt;Day&gt;&lt;/Day&gt;
     &lt;/StartDate&gt;
		 &lt;EndDate&gt;  
       &lt;Year&gt;&lt;/Year&gt;
       &lt;Month&gt;&lt;/Month&gt;
       &lt;Day&gt;&lt;/Day&gt;
     &lt;/EndDate&gt;
     &lt;Name&gt; 
       &lt;Full&gt;&lt;/Full&gt; 
     	 &lt;First&gt;&lt;/First&gt; 
     	 &lt;Middle&gt;&lt;/Middle&gt; 
     	 &lt;Last&gt;&lt;/Last&gt;
     	 &lt;Suffix&gt;&lt;/Suffix&gt;
       &lt;Prefix&gt;&lt;/Prefix&gt;
     &lt;/Name&gt;
     &lt;Address&gt; 
       &lt;StreetName&gt;&lt;/StreetName&gt;
     	 &lt;StreetNumber&gt;&lt;/StreetNumber&gt;
     	 &lt;StreetPreDirection&gt;&lt;/StreetPreDirection&gt;
     	 &lt;StreetPostDirection&gt;&lt;/StreetPostDirection&gt;
     	 &lt;StreetSuffix&gt;&lt;/StreetSuffix&gt;
     	 &lt;UnitDesignation&gt;&lt;/UnitDesignation&gt;
     	 &lt;UnitNumber&gt;&lt;/UnitNumber&gt;
     	 &lt;StreetAddress1&gt;&lt;/StreetAddress1&gt;
     	 &lt;StreetAddress2&gt;&lt;/StreetAddress2&gt;
     	 &lt;State&gt;&lt;/State&gt;
     	 &lt;City&gt;&lt;/City&gt;
     	 &lt;Zip5&gt;&lt;/Zip5&gt;
     	 &lt;Zip4&gt;&lt;/Zip4&gt;
     	 &lt;County&gt;&lt;/County&gt;
     	 &lt;PostalCode&gt;&lt;/PostalCode&gt;
	     &lt;StateCityZip&gt;&lt;/StateCityZip&gt;
     &lt;/Address&gt; 
     &lt;AccidentLocation&gt;
       &lt;Street&gt;&lt;/Street&gt;
       &lt;CrossStreet&gt;&lt;/CrossStreet&gt;
     &lt;/AccidentLocation&gt;
   &lt;/SearchBy&gt;
 &lt;/Row&gt;
&lt;/eCrashSearchRequest&gt;
</pre>
*/


import AutoStandardI,iesp;
EXPORT SearchService := MACRO

	 	#constant('StrictMatch', false);

    //get XML input 
		initial_default_ESP_URL := '';
		initial_default_ESP_NAME := 'DeltaBaseSql';
		gateways_record := Risk_Indicators.Layout_Gateways_In;
		
    rec_in := iesp.ecrash.t_ECrashSearchRequest;
    ds_in := DATASET ([], rec_in) : STORED ('eCrashSearchRequest', FEW);
		gateways_in := dataset([], gateways_record) : stored ('Gateways', FEW);
		
    first_row := ds_in[1] : independent;
		string tmpURLString := gateways_in[1].url;
		// 7/16 - Tino said they are populating servicename with 'delta_ec' which will not work for the servicename.
		// string tmpNAMEString := gateways_in[1].servicename;
		// OUTPUT(gateways_in[1].servicename);
		string tmpNAMEString := initial_default_ESP_NAME;
		// remove the temporary definition above and go back to the gateway if they fix the populated value
		
		string SQL_SEARCH_ESP_URL := if(tmpURLString <> '', tmpURLString, initial_default_ESP_URL);
		string SQL_SEARCH_ESP_NAME := if(tmpNAMEString <> '', tmpNAMEString, initial_default_ESP_NAME);

    //set options
    iesp.ECL2ESP.SetInputBaseRequest (first_row);
    Search_opt := global (first_row.Options);

    //set search criteria
    search_by := global (first_row.searchBy);
    #stored ('AccidentLocationCrossStreet', stringlib.stringtouppercase(search_by.AccidentLocation.CrossStreet));
    #stored ('AccidentLocationStreet', stringlib.stringtouppercase(search_by.AccidentLocation.Street));
		#stored ('ReportNumber', search_by.ReportNumber);
		#stored ('Jurisdiction', stringlib.stringtouppercase(search_by.Jurisdiction));
		#stored ('JurisdictionState', stringlib.stringtouppercase(search_by.JurisdictionState));
		#stored ('UserType', stringlib.stringtouppercase(search_by.UserType));
		#stored ('AgencyORI', stringlib.stringtouppercase(search_by.AgencyORI));
		#stored ('RequestHashKey', search_by.RequestHashKey);
		
		#stored ('GroupRecords', Search_opt.GroupRecords);
		
		#stored ('SortOrder', Search_opt.SortOrder);
		#stored ('SortField', Search_opt.SortField);
		#stored ('SubscriptionReports', Search_opt.SubscriptionReports);
		#stored ('MaxResults', Search_opt.MaxResults);  

		iesp.ECL2ESP.SetInputName (search_by.Name);
    iesp.ECL2ESP.SetInputAddress (search_by.Address);
		iesp.ECL2ESP.Marshall.Mac_Set(Search_opt);
		
		dol_date_calc:=search_by.DateOfLoss.Year*10000 + search_by.DateOfLoss.Month*100 + search_by.DateOfLoss.Day;
		dol_date := if(dol_date_calc=0,'',(string)dol_date_calc);

		dol_start_date_calc:=search_by.StartDate.Year*10000 + search_by.StartDate.Month*100 + search_by.StartDate.Day;
		dol_start_date := if(dol_start_date_calc=0,'',(string)dol_start_date_calc);
		
		dol_end_date_calc:=search_by.EndDate.Year*10000 + search_by.EndDate.Month*100 + search_by.EndDate.Day;
		dol_end_date := if(dol_end_date_calc=0,'',(string)dol_end_date_calc);
		
		#stored('DateOfLoss', dol_date);
		#stored('DolStartdate', dol_start_date);
		#stored('DolEnddate', dol_end_date);

    tempmod := MODULE(PROJECT(AutoStandardI.GlobalModule(),eCrash_Services.IParam.searchrecords,opt));
        export string AccidentLocationCrossStreet  := '' : stored('AccidentLocationCrossStreet');
        export string AccidentLocationStreet  := '' : stored('AccidentLocationStreet');
				export string ReportNumber_raw 			:= '' : stored('ReportNumber');
        export string ReportNumber 			:= stringlib.stringfilter(stringlib.stringtouppercase(ReportNumber_raw), 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789');
				export string Jurisdiction_tmp 			:= '' : stored('Jurisdiction');
				export string Jurisdiction 			:= stringlib.stringtouppercase(Jurisdiction_tmp);
				export string JurisdictionState_tmp 			:= '' : stored('JurisdictionState');
				export string JurisdictionState 			:= stringlib.stringtouppercase(JurisdictionState_tmp);
				export string DateOfLoss 				:= '' : stored('DateOfLoss');
				export string DolStartdate 				:= '' : stored('DolStartdate');
				export string DolEnddate 				:= '' : stored('DolEnddate');
				export string UserType 				:= '' : stored('UserType');
				export string AgencyORI 				:= '' : stored('AgencyORI');
				export boolean RequestHashKey := false : stored('RequestHashKey');
				export boolean GroupRecords 				:= false : stored('GroupRecords');
				export boolean SubscriptionReports 				:= false : stored('SubscriptionReports');
				export string SortOrder 				:= '' : stored('SortOrder');
				export string SortField 				:= '' : stored('SortField');
				export integer MaxLimit 				:= 750 : stored('MaxResults');
				export string200 SqlSearchEspURL := SQL_SEARCH_ESP_URL;
				export string SqlSearchEspNAME := SQL_SEARCH_ESP_NAME;
    END;
		
		Recs_in := eCrash_Services.Records(tempmod);
		
		recs := if (tempmod.SubscriptionReports = true, Recs_in.getSubscriptionRecords(), Recs_in.getSearchRecords());

//look to pass Max limit in Macro. 
//could be this maxRetCnt:=MaxLimit
		iesp.ECL2ESP.Marshall.MAC_Marshall_Results(recs, results,iesp.eCrash.t_ECrashSearchResponse, Records, false);
     output(results,named('Results'));

ENDMACRO;
 // SearchService();