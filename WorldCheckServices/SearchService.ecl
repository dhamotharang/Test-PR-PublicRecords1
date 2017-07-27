/*--SOAP--
<message name="WorldCheckSearch">
	<part name="Threshold" type="xsd:real"/>
	
	<part name="FirstName" type="xsd:string"/>
	<part name="MiddleName" type="xsd:string"/>
	<part name="LastName" type="xsd:string"/>
	<part name="UnParsedName" type="xsd:string"/>
	<part name="Country" type="xsd:string"/>
	
	<part name="UseDOBFilter" type="xsd:boolean"/>
	<part name="DateOfBirth" type="xsd:string"/>
	<part name="DOBRadius" type="xsd:unsignedInt"/>	
	
	<part name="SearchType" type="xsd:string"/>
	<part name="Categories" type="tns:EspStringArray"/>
	
	<part name="IncludeOfac" type="xsd:boolean"/>
	
	<part name="MaxResults" type="xsd:unsignedInt"/>
	<part name="MaxResultsThisTime" type="xsd:unsignedInt"/>
	<part name="SkipRecords" type="xsd:unsignedInt"/>
</message>
*/

import GlobalWatchLists, ut;
export Searchservice() := FUNCTION

REAL threshold_val := .84 : STORED('Threshold');
real threshold_value := IF(threshold_val < .80, .80, threshold_val);

STRING50 fname_value := '' : STORED('FirstName');
STRING50 mname_value := '' : STORED('MiddleName');
STRING50 lname_value := '' : STORED('LastName');
STRING150 unparsedname_value := '' : STORED('UnparsedName');
STRING20 country_value := '' : STORED('Country');

BOOLEAN useDOBFilter_value := false : STORED('UseDOBFilter');
string8 dob_value := ''      : stored('DateOfBirth');
integer2 DOBRadius_val := 2 : STORED('DOBRadius');
dob_radius_value := if(useDOBFilter_value,DOBRadius_val,-1);

// I-Individual, N-NonIndividual, B-Both
string20 searchtype_value := 'B' : STORED('SearchType');

SET OF STRING50 categories_val := [] : stored('Categories');
categories_value := format_Categories(categories_val);

BOOLEAN includeOFAC_value := false : STORED('IncludeOfac');

unsigned8 MaxResults_val := 2000 : stored('MaxResults');
unsigned8 MaxResultsThisTime_val := 2000 : stored('MaxResultsThisTime');
unsigned8 SkipRecords_val := 0 : stored('SkipRecords');


GlobalWatchLists.Layout_Batch_In seq(ut.ds_oneRecord le) :=
TRANSFORM
	SELF.seq := 1;
	SELF.name_first := Stringlib.StringToUpperCase(fname_value);
	SELF.name_middle := Stringlib.StringToUpperCase(mname_value);
	SELF.name_last := Stringlib.StringToUpperCase(lname_value);
	SELF.name_unparsed := Stringlib.StringToUpperCase(unparsedname_value);
	SELF.search_type := Stringlib.StringToUpperCase(searchtype_value);
	SELF.country := Stringlib.StringToUpperCase(country_value);
	
	SELF.dob := dob_value;

	SELF.acctno := '';
	
	SELF.version_number := '';
END;
seqd := GROUP(SORTED(PROJECT(ut.ds_oneRecord, seq(LEFT)),seq), seq);

wcheck := worldcheckservices.fn_Search(seqd, threshold_value, 
										usedobfilter_value, dob_radius_value, 
										includeOFAC_value, categories_value);

wcheck_sort := SORT(wcheck,-score);

output(wcheck_sort, NAMED('Results'));

RETURN 0;

END;

