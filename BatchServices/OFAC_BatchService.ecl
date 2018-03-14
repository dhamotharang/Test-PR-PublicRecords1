
/*--SOAP--
<message name="OFAC_BatchService">
	<part name="batch_in"  type="tns:XmlDataSet"/>
  <part name="OfacOnly" type="xsd:boolean"/>
	<part name="GlobalWatchlistThreshold" type="xsd:real"/>
	<part name="OFACversion" type="xsd:unsignedInt"/>
	<part name="IncludeOfac" type="xsd:boolean"/>
	<part name="IncludeAdditionalWatchLists" type="xsd:boolean"/>
	<part name="gateways" type="tns:XmlDataSet" cols="70" rows="25"/>
</message>
*/

/* Patriot.Layout_batch_in...:
	STRING10  acctno;
	UNSIGNED4 seq := 0;	
	STRING50  name_first;
	STRING50  name_middle;
	STRING50  name_last;
	STRING150 name_unparsed;
	STRING20  search_type;
	string20  country;
	STRING8   dob := '';
*/



IMPORT BatchServices, Patriot;

EXPORT OFAC_BatchService := MACRO

#WEBSERVICE(FIELDS(
  'batch_in',
	'OfacOnly',
	'OFACversion',
	'IncludeOfac',
	'IncludeAdditionalWatchLists',
	'GlobalWatchlistThreshold',
	'gateways'
	));

	in_format := Patriot.Layout_batch_in;
	boolean ofaconly_value := false : STORED('OfacOnly');
	real threshold_value := 0.75 			: stored('GlobalWatchlistThreshold');
	unsigned1 ofac_version      := 1        : stored('OFACVersion');
  boolean   include_ofac       := false    : stored('IncludeOfac');
  boolean   include_additional_watchlists  := false    : stored('IncludeAdditionalWatchLists');
	ds_input := DATASET([],Patriot.Layout_batch_in) : STORED('batch_in', FEW);
  // NOTE: gateways are read from stored in Patriot.Search_Batch_Function line 163
	
	in_format capitalize(in_format le) :=
		TRANSFORM
			SELF.name_first    := Stringlib.StringToUpperCase(le.name_first);
			SELF.name_middle   := Stringlib.StringToUpperCase(le.name_middle);
			SELF.name_last     := Stringlib.StringToUpperCase(le.name_last);
			SELF.name_unparsed := Stringlib.StringToUpperCase(le.name_unparsed);
			SELF.country       := Stringlib.StringToUpperCase(le.country);
			SELF.search_type   := 'BOTH';
			SELF.dob           := le.dob;
			SELF               := le;
		END;

	ds_recs := BatchServices.OFAC_BatchService_Records( GROUP(SORT(PROJECT(ds_input, capitalize(LEFT)),acctno),acctno), ofaconly_value, threshold_value, ofac_version, include_ofac,include_additional_watchlists);

	OUTPUT( SORT(ds_recs, acctno, Name), NAMED('Results'));

ENDMACRO;