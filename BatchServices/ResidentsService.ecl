
/*--SOAP--
<message name="ResidentsService">
	<part name="DPPAPurpose"          type="xsd:byte"/>
	<part name="GLBPurpose"           type="xsd:byte"/> 
	<part name="batch_in"             type="tns:XmlDataSet" cols="70" rows="25"/>	
	<part name="MaxRecordsToReturn" 	type="xsd:unsignedint"/>	
	<part name="Max_CurrentResidents" type="xsd:byte"/>
	<part name="Max_PriorResidents"   type="xsd:byte"/>
	<part name="ExcludeDropIndCheck"   type="xsd:boolean"/>
	<part name="ThresholdDateForCurrentResidency"   type="xsd:unsignedint"/>
	<part name="YearsForCurrentResidency"   type="xsd:unsignedint"/>
  <part name="DataRestrictionMask" type="xsd:string" default="00000000000"/>
	<part name="ReturnAddrPhone"   type="xsd:boolean"/>
	<part name="MultiUnitSearch" type="xsd:boolean"/>
</message>
*/
/*--INFO--
<pre>
This service will return a set of current residents and prior residents for a given address.
Current residents are those where the BEST address is the searched address. 
	...and they are still alive
	...and the dt_last_seen is within a given timeframe

The timeframe for current and the number of prior and current residents can be set.
Addresses on the input that are missing a sec range will not have results but will get a response 
	noting that this was missing.
The drop indicator from ADVO when Y can be used as an additional indicator that there is a 
	sec_range missing.

MaxRecordsToReturn can also be used to set the maximum number of current residents. When this option
  is specified, no previous residents will be returned. 
</pre>
*/
/*--HELP-- 
<pre>

&lt;batch_in&gt;
&lt;row&gt;
&lt;acctno&gt;&lt;/acctno&gt;
&lt;addr&gt;&lt;/addr&gt;
&lt;prim_range&gt;&lt;/prim_range&gt;
&lt;predir&gt;&lt;/predir&gt;
&lt;prim_name&gt;&lt;/prim_name&gt;
&lt;addr_suffix&gt;&lt;/addr_suffix&gt;
&lt;postdir&gt;&lt;/postdir&gt;
&lt;sec_range&gt;&lt;/sec_range&gt;
&lt;p_city_name&gt;&lt;/p_city_name&gt;
&lt;st&gt;&lt;/st&gt;
&lt;z5&gt;&lt;/z5&gt;
&lt;/row&gt;
&lt;/batch_in&gt;

</pre>
*/


import address,advo;
export ResidentsService := Macro	
  #constant('SearchLibraryVersion', AutoheaderV2.Constants.LibVersion.SALT);
		boolean ExcludeDropIndCheck := false :stored('ExcludeDropIndCheck');
    rec_batch_in := BatchServices.Layouts.Resident.batch_in;
		rec_cln_batch_in := BatchServices.Layouts.Resident.cln_batch_in;
/*   canned := dataset([{'1','','22690','SW','54','way','', '','BOCA RATON','FL','33433'}
            											,{'2','705 mermaid dr','','','','','', '','','','33441'}
            											,{'3','120 ne 20 ave','','','','','', '','','','33441'}
            											,{'4','1050 sw 14 st','','','','','', '','','','33441'}
            											,{'5','1060 sw 14 st','','','','','', '','','','33441'}
            											,{'6','2060 ne 1 st','','','','','', '','','','33441'}
            											,{'7','1917 ne 5 st','','','','','', '','','','33441'}
            											,{'8','','710','','mermaid','dr','', '201','BOCA RATON','FL','33441'}
         													],rec_batch_in);
*/


	  canned := dataset([],rec_batch_in);
		batch_in := canned : STORED('batch_in', FEW);
 		
		final_batch_in := BatchServices.Residents_refineBatchIn(batch_in ,ExcludeDropIndCheck);
 		
		
		// Bug #85716:
		// The options MaxRecordsToReturn and YearsForCurrentResidency have been added so this query can also be
		// used by Best Address Product to perform a reverse search. These new options will be used only by best addr
		// plug-in, so they should have no impact on the existing residents batch plug-in.
		
		//define a module and then pass it in
 	  in_mod := module (BatchServices.Interfaces.res_config)
			// MaxRecordsToReturn overrides max_currentresidents and max_priorresidents. 
			shared maxRecs := 0 : STORED('MaxRecordsToReturn');
			shared integer CurrRes := 20 : STORED('Max_CurrentResidents');
			shared integer PriorRes := 20 : STORED('Max_PriorResidents'); 						
			export unsigned1 MaxCurrRes := if(maxRecs=0, min(currRes,20), min(maxRecs, 10));
			export unsigned1 MaxPriorRes := if(maxRecs=0, min(PriorRes,20), 0);
			unsigned4 thrForCurRes := BatchServices.constants.Residents.ThresholdDateForCurrentResidency : STORED('ThresholdDateForCurrentResidency');
			// YearsForCurrentResidency overrides thresholddateforcurrentresidency
			yearsForCurRes := 0 : STORED('YearsForCurrentResidency');			
			yearsForCurrentResidency := (BatchServices.constants.Residents.TODAY_YYYYMM - (BatchServices.constants.Residents.ONE_YEAR * yearsForCurRes));
			// any last seen date more current than this date is considered current
			export unsigned4 ThresholdDateForCurrentResidency := if(yearsForCurRes=0, thrForCurRes, yearsForCurrentResidency);
			export boolean ReturnAddrPhone := false : STORED('ReturnAddrPhone');	
			export boolean MultiUnitSearch := false : STORED('MultiUnitSearch');
  	end;

		ds_Residents := BatchServices.Residents_Records(final_batch_in,in_mod);

		OUTPUT(project(ds_Residents,BatchServices.Layouts.Resident.batch_out), NAMED('Results'));
endMacro;
// BatchServices.ResidentsService();
