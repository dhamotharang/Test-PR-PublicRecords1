/*--SOAP--
<message name="CLIA_SearchService">
	<part name="CLIASearchRequest" type="tns:XmlDataSet" cols="80" rows="30" />
</message>
*/
/*--INFO--
<pre>
This service will return a set of CLIA records matching the input criteria.

The service requires a either a CLIA number, BDID or Company Name and Address information as input.

</pre>
*/
/*--HELP-- 
<pre>

&lt;CLIASearchRequest&gt;
&lt;Row&gt;
 &lt;SearchBy&gt;
  &lt;BusinessId/&gt;
  &lt;CompanyName&gt;&lt;/CompanyName&gt;
  &lt;Address&gt;
   &lt;StreetNumber/&gt;
   &lt;StreetPreDirection/&gt;
   &lt;StreetName/&gt;
   &lt;StreetSuffix/&gt;
   &lt;StreetPostDirection/&gt;
   &lt;UnitDesignation/&gt;
   &lt;UnitNumber/&gt;
   &lt;StreetAddress1/&gt;
   &lt;StreetAddress2/&gt;
   &lt;City&gt;&lt;/City&gt;
   &lt;State&gt;&lt;/State&gt;
   &lt;Zip5/&gt;
   &lt;Zip4/&gt;
   &lt;County/&gt;
   &lt;PostalCode/&gt;
   &lt;StateCityZip/&gt;
  &lt;/Address&gt;
  &lt;CLIANumber&gt;&lt;/CLIANumber&gt;
 &lt;/SearchBy&gt;
&lt;/Row&gt;
&lt;/CLIASearchRequest&gt;

</pre>
*/

import iesp, AutoStandardI, address;
EXPORT CLIA_SearchService := MACRO
	ds_in := DATASET ([], iesp.cliasearch.t_cliaSearchRequest) : STORED('CLIASearchRequest', FEW);
	
	first_row := ds_in[1] : INDEPENDENT;	
	iesp.ECL2ESP.Marshall.Mac_Set(first_row.Options);
	iesp.ECL2ESP.SetInputSearchOptions(first_row.Options);	  
	addr := address.GetCleanAddress(first_row.SearchBy.Address.StreetAddress1,first_row.SearchBy.Address.City+' '+first_row.SearchBy.Address.State+' '+first_row.SearchBy.Address.Zip5,address.Components.Country.US).str_addr;
	clnAddr := Address.CleanFields(addr);
	//Clean Address1 id supplied
	isClean := length(trim(first_row.SearchBy.Address.StreetAddress1,all))>0;

	STRING50 _CompanyName := trim(first_row.SearchBy.CompanyName);
	string10 _StreetNumber := if(isClean,clnAddr.prim_range,trim(first_row.SearchBy.Address.StreetNumber));
	string2 _StreetPreDirection := if(isClean,clnAddr.predir,trim(first_row.SearchBy.Address.StreetPreDirection));
	string28 _StreetName := if(isClean,clnAddr.prim_name,trim(first_row.SearchBy.Address.StreetName));
	string4 _StreetSuffix := if(isClean,clnAddr.addr_suffix,trim(first_row.SearchBy.Address.StreetSuffix));
	string2 _StreetPostDirection := if(isClean,clnAddr.postdir,trim(first_row.SearchBy.Address.StreetPostDirection));
	string10 _UnitDesignation := if(isClean,clnAddr.unit_desig,trim(first_row.SearchBy.Address.UnitDesignation));
	string8 _UnitNumber := if(isClean,clnAddr.sec_range,trim(first_row.SearchBy.Address.UnitNumber));
	string60 _StreetAddress1 := trim(first_row.SearchBy.Address.StreetAddress1);
	string60 _StreetAddress2 := trim(first_row.SearchBy.Address.StreetAddress2);
	string25 _City := if(isClean,clnAddr.p_city_name,trim(first_row.SearchBy.Address.City));
	string2 _State := if(isClean,clnAddr.st,trim(first_row.SearchBy.Address.State));
	string5 _Zip5 := if(isClean,clnAddr.zip,trim(first_row.SearchBy.Address.Zip5));
	string4 _Zip4 := if(isClean,clnAddr.zip4,trim(first_row.SearchBy.Address.Zip4));
	string _BusinessId := trim(first_row.SearchBy.BusinessId);
	string15 _CLIANumber := stringlib.StringToUpperCase(trim(first_row.SearchBy.CLIANumber));

	//Build single records dataset to pass into records

	batch_in_cleaned := dataset([{1,
															 _CompanyName,
															 _StreetNumber,
															 _StreetPreDirection,
															 _StreetName,
															 _StreetSuffix,
															 _StreetPostDirection,
															 _UnitDesignation,
															 _UnitNumber,
															 _City,
															 _State,
															 _Zip5,
															 _CLIANumber,
															(unsigned6) _BusinessId}
															 ],Healthcare_Provider_Services.CLIA_Layouts.batch_in);

 	
	in_mod := module (Healthcare_Provider_Services.CLIA_Interfaces.clia_config)
		export unsigned4 MaxRecordsPerRow := 2000; //Really intended for limiting output as part of batch so set very high
		export unsigned4 penalty_threshold := 10 : stored('penalty_threshold');
		export string applicationType				:= AutoStandardI.InterfaceTranslator.application_type_val.val(project(AutoStandardI.GlobalModule(),AutoStandardI.InterfaceTranslator.application_type_val.params));
	end;
	
	results := Healthcare_Provider_Services.CLIA_SearchService_Records(batch_in_cleaned,in_mod).records;
	//Move to Clia_Transforms and handle the internal batch layout and iesp layout differences.
	formatted_results := project(choosen(results,iesp.Constants.HPR.MaxCLIA),Healthcare_Provider_Services.CLIA_Transforms.esdlRecords(left)); 
	
	iesp.ECL2ESP.Marshall.MAC_Marshall_Results(formatted_results,final_results,iesp.cliasearch.t_CLIASearchResponse,CLIARecords,false,RecordCount,InputEcho,first_row.SearchBy);

	output(final_results, named('Results'));

ENDMACRO;
 