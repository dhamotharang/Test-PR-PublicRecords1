/*--SOAP--
<message name="WorldCheckInternational">
	<part name="Names" type="tns:XmlDataSet"/>
	<part name="Threshold" type="xsd:real"/>
	<part name="IncludeOFAC" type="xsd:boolean"/>
	<part name="UseDOBFilter" type="xsd:boolean"/>
	<part name="DOBRadius" type="xsd:unsignedInt"/>		
	<part name="SearchType" type="xsd:string"/>
	<part name="Categories" type="tns:EspStringArray"/>
	<part name="Keywords" type="tns:EspStringArray"/>
</message>
*/

export InternationalService := MACRO

in_format := GlobalWatchlists.Layout_Batch_In;
f := dataset([],in_format) : stored('Names',few);

REAL threshold_val := .84 : STORED('Threshold');
real threshold_value := IF(threshold_val < .80, .80, threshold_val);

BOOLEAN useDOBFilter_value := false : STORED('UseDOBFilter');
integer2 DOBRadius_val := 2 : STORED('DOBRadius');
dob_radius_value := if(useDOBFilter_value,DOBRadius_val,-1);

string20 searchtype_value := 'B' : STORED('SearchType');

SET OF STRING50 categories_val := [] : stored('Categories');
categories_value := worldcheckservices.format_Categories(categories_val);

SET OF STRING30 keywords_val := [] : stored('Keywords');
keywords_value := worldcheckservices.format_Keywords(keywords_val);

// I-Individual, N-NonIndividual, B-Both
BOOLEAN includeOFAC_value := false : STORED('IncludeOFAC');


in_format seq(in_format le) :=
TRANSFORM
	SELF.seq := 1;
	SELF.name_first := trim(Stringlib.StringToUpperCase(le.name_first));
	SELF.name_middle := trim(Stringlib.StringToUpperCase(le.name_middle));
	SELF.name_last := trim(Stringlib.StringToUpperCase(le.name_last));
	SELF.name_unparsed := trim(Stringlib.StringToUpperCase(le.name_unparsed));
	stype := IF(le.search_type<>'',le.search_type,searchtype_value);
	SELF.search_type := trim(Stringlib.StringToUpperCase(stype));
	SELF.country := trim(Stringlib.StringToUpperCase(le.country));
	SELF := le;
END;
seqd := PROJECT(f, seq(LEFT));

wcheck := worldcheckservices.fn_SearchIntl(seqd, threshold_value, 
										usedobfilter_value, dob_radius_value, 
										includeOFAC_value, categories_value, keywords_value);

output(wcheck, NAMED('Results'));

ENDMACRO;