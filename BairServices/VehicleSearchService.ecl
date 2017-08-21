/*--SOAP--
<message name="VehicleSearchService">
  <part name="BAIRVehicleSearchRequest" type="tns:XmlDataSet" cols="70" rows="25"/>  
</message>
*/

/*--INFO--
<hr>
This query will search for vehicles in crash and event datasources.
<br>The search is performed using SALT. 
<br>The results will include all vehicles and parties found in the matching incident(s).
<hr>
<P><b>NOTES:</b> 
<P>The following input options are currently not supported:
<br><ul><li>ReturnAgencyDataOnly</li></ul>
<p>Wildcard search is supported. If WildcardSearch is selected, the following additional fields are used 
to defined how the wildcard search is completed.
<ul>
<li>UseTagBlur</li>
<li>DoContainsSearch</li>
</ul>
<p>If doing a wildcard search, only these fields are used for the search. All others are ignored
<ul>
<li>VIN - wildcards supported</li>
<li>First, Middle and Last name</li>
<li>State</li>
<li>Zip - wildcards supported</li>
<li>Radius - includes all zip codes withing this radius from the Zip entry</li>
<li>Plate - use blur if UseTagBlur is checked (wildcards also supported)</li>
<li>Gender</li>
<li>Age</li>
<li>YearMake</li>
<li>Makes</li>
<li>Models</li>
<li>Color</li>
</ul>
*/
// <p> Wilcard search is supported for the following input parameters:
// <br><ul><li>VIN (e.g. 2MEFM74WX3*5124)</li><li>Plate (e.g. XNN*81)</li><li>Zip (e.g. 334*)</li></ul>

//
// Wildcard searching
// To enable a wildcard search, WildCardSearch flag must be set. If set, the following additional fields define how
// the search is done:
//   * UseTagBlur        - Uses blurring to do additional matching for the input tag number. For example a 3 may match an E if
//                         tag blur is enabled. This is for the plate number only
//   * DoContainsSearch  - For plate number only. If set, the entered value is used to see if the record value contains the input.
//                         For example, if the input is 2N, then if the record plate number contains a 2 and an N, in any order, 
//                         that will constitute a match for the plate.
// Other fields that are used for a wildcard search are
//   * First, middle and last name
//   * VIN
//   * State
//   * Zip
//   * Radius - used to generate a set of zips that are within the radius of the Zip value
//   * Age
//   * YearMake
//   * Make  (list)
//   * Model (list)
//   * Color (list)
//
// The following fields also support a wildcard character in the input to provide a wildcard match. A * will match any number of
// characters, a ? will match a single character. Characters include numbers. Note that a determination will be made in the code if
// the entered wildcards are too complicated.
//   * VIN
//   * Plate
//   * Zip
//
// Any field not mentioned in the description of what is used for a wildcard search is not part of the search.


EXPORT VehicleSearchService := MACRO
	import iesp, BairRx_Common, BairRx_PSS;
	dIn := DATASET([], iesp.bair_vehiclesearch.t_BAIRVehicleSearchRequest) : STORED('BAIRVehicleSearchRequest', FEW);
	first_row := dIn[1] : independent;	
	options := GLOBAL(first_row.options);
	user := GLOBAL(first_row.user);
	searchBy := GLOBAL(first_row.searchBy);
	
	BairRx_PSS.IParam.SetInputOptions(options);	
	BairRx_PSS.IParam.SetInputUser(user);	
	
	wc_params := BairRx_PSS.WParam.GetVehicleWildcardSearchParams(searchBy, options);
	input_params := BairRx_PSS.IParam.GetVehicleSearchParams(searchBy, options, user); 	
	dSrchRecs := BairRx_PSS.VehicleSearchRecords(input_params, wc_params);	
	
	iesp.ECL2ESP.Marshall.MAC_Marshall_Results(dSrchRecs, results, iesp.bair_vehiclesearch.t_BAIRVehicleSearchResponse);
	output(results, named('Results'));

ENDMACRO;