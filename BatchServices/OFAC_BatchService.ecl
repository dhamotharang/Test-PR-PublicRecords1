
/*--SOAP--
<message name="OFAC_BatchService">
	<part name="batch_in"  type="tns:XmlDataSet"/>
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

	in_format := Patriot.Layout_batch_in;
	ds_input := DATASET([],Patriot.Layout_batch_in) : STORED('batch_in', FEW);
	
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

	ds_recs := BatchServices.OFAC_BatchService_Records( GROUP(SORT(PROJECT(ds_input, capitalize(LEFT)),acctno),acctno) );

	OUTPUT( SORT(ds_recs, acctno, Name), NAMED('Results'));

ENDMACRO;