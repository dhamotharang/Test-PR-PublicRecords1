/*--SOAP--
<message name="PatriotSearch">
	<part name="batch_in" type="tns:XmlDataSet"/>
  <part name="Threshold" type="xsd:real"/>
  <part name="OfacOnly" type="xsd:boolean"/>
	<part name="search_type" type="xsd:string"/>
	<part name="UseDOBFilter" type="xsd:boolean"/>
	<part name="DOBRadius" type="xsd:unsignedInt"/>	
	<part name="OFACversion" type="xsd:unsignedInt"/>
	<part name="IncludeOfac" type="xsd:boolean"/>
	<part name="IncludeAdditionalWatchLists" type="xsd:boolean"/>
	<part name="ExcludeAllAKA" type="xsd:boolean"/>
	<part name="ExcludeWeakAKA" type="xsd:boolean"/>
	<part name="WatchList" type="tns:XmlDataSet" cols="90" rows="10"/>
	<part name="gateways" type="tns:XmlDataSet" cols="110" rows="10"/>
 </message>
*/

import OFAC_XG5, STD, iesp, Patriot, ut;

export Patriot_Batch := MACRO

in_format := patriot.Layout_batch_in;

f := dataset([],in_format) : stored('batch_in',few);
unsigned1 OFAC_version := 1 :STORED('OFACversion');
real threshold_val_temp := 0 : STORED('Threshold');
	threshold_value := MAP(
													OFAC_version >= 4 and threshold_val_temp = 0 		=> OFAC_XG5.Constants.DEF_THRESHOLD_KeyBank_REAL,  // All customers using XG5 - V4 should use .85 as threshold
													OFAC_version < 4 and threshold_val_temp = 0 		=> OFAC_XG5.Constants.DEF_THRESHOLD_REAL, // V1-2 should use .84 as default
													threshold_val_temp);

boolean ofac_only_value := false : STORED('OfacOnly');
string20 search_type_temp := '' : STORED('search_type');
search_type := if(trim(search_type_temp) = '', 'BOTH', search_type_temp);
boolean Include_Additional_watchlists := FALSE: stored('IncludeAdditionalWatchlists');
boolean Include_Ofac := FALSE: stored('IncludeOfac');
boolean exclude_aka := FALSE: stored('ExcludeAllAKA');
boolean exclude_weakaka := FALSE: stored('ExcludeWeakAKA');

boolean use_dob_Filter := FALSE :stored('UseDobFilter');
integer2 dob_radius := -1 :stored('DobRadius');

//CCPA fields
unsigned1 LexIdSourceOptout := 1 : STORED('LexIdSourceOptout');
string TransactionID := '' : STORED('_TransactionId');
string BatchUID := '' : STORED('_BatchUID');
unsigned6 GlobalCompanyId := 0 : STORED('_GCID');

dob_radius_use := if(use_dob_Filter,dob_radius,-1);

temp := record
		dataset(iesp.share.t_StringArrayItem) WatchList {xpath('WatchList/Name'), MAXCOUNT(iesp.Constants.MaxCountWatchLists)};
end;

watchlist_options := dataset([],temp) :stored('WatchList', few);
watchlists_request := watchlist_options[1].WatchList;

IF( OFAC_version != 4 AND OFAC_XG5.constants.wlALLV4 IN SET(watchlists_request, value),
   FAIL( OFAC_XG5.Constants.ErrorMsg_OFACversion ) );

in_format capitalize(in_format le) :=
TRANSFORM

cl := LENGTH(TRIM(le.country));
	country_decoded := IF(cl=2 AND ut.Country_ISO2_To_Name(le.country)<>'',ut.Country_ISO2_To_Name(le.country),
												IF(cl=3 AND ut.Country_ISO3_To_Name(le.country)<>'',ut.Country_ISO3_To_Name(le.country), le.country));

	SELF.name_first := STD.Str.ToUpperCase(le.name_first);
	SELF.name_middle := STD.Str.ToUpperCase(le.name_middle);
	SELF.name_last := STD.Str.ToUpperCase(le.name_last);
	SELF.name_unparsed := if( OFAC_version = 4 and le.name_first = '' and le.name_middle = '' and le.name_last = '' and le.name_unparsed = '' and le.country <> '', 
														STD.Str.ToUpperCase(country_decoded), STD.Str.ToUpperCase(le.name_unparsed));
	SELF.country := STD.Str.ToUpperCase(country_decoded);
	SELF.search_type := STD.Str.ToUpperCase(search_type); 
	SELF.dob := le.dob;	
	SELF := le;
END;


output(Patriot.Search_Batch_Function(GROUP(PROJECT(f,capitalize(LEFT)),acctno), ofac_only_value,threshold_value,
				ofac_version,include_ofac,include_additional_watchlists,dob_radius_use,watchlists_request,exclude_aka,exclude_weakaka,
				LexIdSourceOptout, TransactionID, BatchUID, GlobalCompanyID),NAMED('Results'));

ENDMACRO;
