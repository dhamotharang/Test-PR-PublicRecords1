
/*--SOAP--
<message name="OFAC_BatchService">
	<part name="batch_in"  type="tns:XmlDataSet"/>
	<part name="OFACversion" type="xsd:unsignedInt"/>
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
	'OFACversion',
	'gateways'
	));

	in_format := Patriot.Layout_batch_in;
  unsigned1 ofac_version      := 1        : stored('OFACVersion');
  real threshold_value := if(ofac_version = 4, 0.85, 0.75);
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

	ds_recs := BatchServices.OFAC_BatchService_Records( GROUP(SORT(PROJECT(ds_input, capitalize(LEFT)),acctno),acctno), ofac_version, threshold_value);

	OUTPUT( SORT(ds_recs, acctno, Name), NAMED('Results'));

ENDMACRO;