/*--SOAP--
<message name="PatriotSearch">
	<part name="_LoginID" type="xsd:string"/>
  <part name="Threshold" type="xsd:real"/>
  <part name="FirstName" type="xsd:string"/>
  <part name="MiddleName" type="xsd:string"/>
  <part name="LastName" type="xsd:string"/>
  <part name="UnParsedName" type="xsd:string"/>
	<part name="DateOfBirth" type="xsd:string"/>
	<part name="UseDOBFilter" type="xsd:boolean"/>
	<part name="DOBRadius" type="xsd:unsignedInt"/>	
  <part name="SearchType" type="xsd:string"/>
  <part name="OfacOnly" type="xsd:boolean"/>
	<part name="OFACversion" type="xsd:unsignedInt"/>
	<part name="IncludeOfac" type="xsd:boolean"/>
	<part name="IncludeAdditionalWatchLists" type="xsd:boolean"/>
	<part name="WatchList" type="tns:XmlDataSet" cols="90" rows="10"/>
  <part name="Country" type="xsd:string"/>
	<part name="MaxResults" type="xsd:unsignedInt"/>
  <part name="MaxResultsThisTime" type="xsd:unsignedInt"/>
  <part name="SkipRecords" type="xsd:unsignedInt"/>
	<part name="gateways" type="tns:XmlDataSet" cols="110" rows="4"/>
 </message>
*/

import OFAC_XG5;

export Patriot_Search := MACRO

// new temporary input field for KeyBank so that we can change the OFAC version to 3 for them, currently it is defaulted to 2.
// Remove this when CIID enhancements are finished in Aug 2013, as everyone will have version 3 at this time
string32 _LoginID := ''	: stored('_LoginID');

unsigned8 MaxResults_val := 2000 : stored('MaxResults');
unsigned8 MaxResultsThisTime_val := 2000 : stored('MaxResultsThisTime');
unsigned8 SkipRecords_val := 0 : stored('SkipRecords');

unsigned1 OFAC_version_temp := 1 			: stored('OFACversion');
	OFAC_version := if(trim(stringlib.stringtolowercase(_LoginID)) in ['keyxml','keydevxml'], 4, OFAC_version_temp);	// temporary code for Key Bank
	
real global_watchlist_threshold_temp := 0 			: stored('Threshold');
 // need to change once all customers are on Version 4
	global_watchlist_threshold := MAP(trim(stringlib.stringtolowercase(_LoginID)) in ['keyxml','keydevxml'] and global_watchlist_threshold_temp=0 => OFAC_XG5.Constants.DEF_THRESHOLD_KeyBank_REAL,
																		OFAC_version >= 4 and global_watchlist_threshold_temp = 0 		=> OFAC_XG5.Constants.DEF_THRESHOLD_KeyBank_REAL,  // All customers using XG5 - V4 should use .85 as threshold
																		OFAC_version < 4 and global_watchlist_threshold_temp = 0 			=> OFAC_XG5.Constants.DEF_THRESHOLD_REAL, // V1-2 should use .84 as default
																		global_watchlist_threshold_temp);
	
STRING50 firstname_value := '' : STORED('FirstName');
STRING50 middlename_value := '' : STORED('MiddleName');
STRING50 lastname_value := '' : STORED('LastName');
STRING150 unparsed_value := '' : STORED('UnParsedName');
string8 dob_value := ''      : stored('DateOfBirth');
// I-Individual, N-NonIndividual, B-Both
STRING1 searchtype_value := 'B' : STORED('SearchType');
boolean ofaconly_value := false : STORED('OfacOnly');

STRING20 country_value := '' : STORED('Country');
boolean Include_Additional_watchlists := FALSE: stored('IncludeAdditionalWatchlists');
boolean Include_Ofac := FALSE: stored('IncludeOfac');


boolean use_dob_Filter := FALSE :stored('UseDobFilter');
integer2 dob_radius := -1 :stored('DobRadius');

	gateways				:= Gateway.Configuration.Get();
	
if( OFAC_version = 4 and not exists(gateways(servicename = 'bridgerwlc')) , fail(Risk_Indicators.iid_constants.OFAC4_NoGateway));

dob_radius_use := if(use_dob_Filter,dob_radius,-1);

temp := record
		dataset(iesp.share.t_StringArrayItem) WatchList {xpath('WatchList/Name'), MAXCOUNT(iesp.Constants.MaxCountWatchLists)};
end;

watchlist_options := dataset([],temp) :stored('WatchList', few);
watchlists_request := watchlist_options[1].WatchList;

IF( OFAC_version != 4 AND OFAC_XG5.constants.wlALLV4 IN SET(watchlists_request, value),
   FAIL( OFAC_XG5.Constants.ErrorMsg_OFACversion ) );

in_data := GROUP(SORTED(DATASET([{'1',1,Stringlib.StringToUpperCase(firstname_value),
																				Stringlib.StringToUpperCase(middlename_value),
																				Stringlib.StringToUpperCase(lastname_value),
																				Stringlib.StringToUpperCase(unparsed_value), 
																				Stringlib.StringToUpperCase(searchtype_value), 
																				Stringlib.StringToUpperCase(country_value),
																				dob_value}],patriot.Layout_batch_in),acctno),acctno);

a := SORT(patriot.Search_Function(in_data,ofaconly_value,global_watchlist_threshold,ofac_version,include_ofac,include_additional_watchlists,dob_radius_use,watchlists_request),-score,pty_key);
// output(a, named('Results'));


// for debuggging the search function output issue, remove the sort
// a := patriot.Search_Function(in_data,ofaconly_value,global_watchlist_threshold,ofac_version,include_ofac,include_additional_watchlists,dob_radius_use,watchlists_request);
// output(a, named('Results'));

doxie.MAC_Marshall_Results(a, b, 100000);
output(b, named('Results'))

ENDMACRO;