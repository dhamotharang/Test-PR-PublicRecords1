/*--SOAP--
<message name="WorldCheckBatch">
	<part name="batch_in" type="tns:XmlDataSet" cols="70" rows="25"/>
	<part name="Threshold" type="xsd:real"/>
	<part name="IncludeOFAC" type="xsd:boolean"/>
	<part name="UseDOBFilter" type="xsd:boolean"/>
	<part name="DOBRadius" type="xsd:unsignedInt"/>		
	<part name="SearchType" type="xsd:string"/>
	<part name="Categories" type="tns:EspStringArray" cols="70" rows="10"/>
  <part name="ReturnDetailedRoyalties" type="xsd:boolean"/>	
</message>
*/

export BatchService := MACRO

in_format := GlobalWatchlists.Layout_Batch_In;
f := dataset([],in_format) : stored('batch_in',few);

REAL threshold_val := .84 : STORED('Threshold');
real threshold_value := IF(threshold_val < .80, .80, threshold_val);

BOOLEAN useDOBFilter_value := false : STORED('UseDOBFilter');
integer2 DOBRadius_val := 2 : STORED('DOBRadius');
dob_radius_value := if(useDOBFilter_value,DOBRadius_val,-1);

string20 searchtype_value := 'B' : STORED('SearchType');

SET OF STRING50 categories_val := [] : stored('Categories');
categories_value := worldcheckservices.format_Categories(categories_val);

// I-Individual, N-NonIndividual, B-Both
BOOLEAN includeOFAC_value := false : STORED('IncludeOFAC');

// TODO: assume uppercase?
in_format seq(in_format le, INTEGER i) :=
TRANSFORM
	SELF.seq := i;
	SELF.name_first := trim(Stringlib.StringToUpperCase(le.name_first));
	SELF.name_middle := trim(Stringlib.StringToUpperCase(le.name_middle));
	SELF.name_last := trim(Stringlib.StringToUpperCase(le.name_last));
	SELF.name_unparsed := trim(Stringlib.StringToUpperCase(le.name_unparsed));
	stype := IF(le.search_type<>'',le.search_type,searchtype_value);
	SELF.search_type := trim(Stringlib.StringToUpperCase(stype));
	SELF.country := trim(Stringlib.StringToUpperCase(le.country));
	SELF := le;
END;
seqd := GROUP(PROJECT(f, seq(LEFT, COUNTER)), seq);

wcheck := worldcheckservices.fn_Search(seqd, threshold_value, 
										usedobfilter_value, dob_radius_value, 
										includeOFAC_value, categories_value);

returnDetailedRoyalties	:= false : stored('ReturnDetailedRoyalties');	
wcheck_royalties := Royalty.RoyaltyWorldCheck.GetBatchRoyaltySet(wcheck,,returnDetailedRoyalties);	

output(wcheck, NAMED('Results'));
output(wcheck_royalties, NAMED('RoyaltySet'));


ENDMACRO;