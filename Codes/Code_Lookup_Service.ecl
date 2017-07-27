/*--SOAP--
<message name="Code_Lookup_Service">
	<part name="file_name" type="xsd:string"/>
	<part name="field_name" type="xsd:string"/>
	<part name="source_name" type="xsd:string"/>
	<part name="code" type="xsd:string"/>
	<part name="CodeLookupRequest" type="tns:XmlDataSet" cols="80" rows="40" />
 </message>
*/

import ut,iesp;

export Code_Lookup_Service := MACRO

string filename := '' : stored('file_name');
string fieldname := ''   : stored('field_name');
string SourceName := ''   : stored('source_name');
string code1 := ''   : stored('code');

	rec_in := iesp.codelookup.t_CodeLookupRequest;
	ds_in := DATASET([],rec_in) : STORED('CodeLookupRequest',FEW);
	request := ds_in[1] : INDEPENDENT;

	// set XML input
	SearchBy := GLOBAL(request.SearchBy);

	// Search criteria
	file_name := if(filename!='',filename,SearchBy.filename);
	field_name := if (fieldname!='',fieldname,SearchBy.fieldname);
	Source_Name := if(SourceName != '', SourceName,SearchBy.SourceName);
	code := if(code1!='',code1,SearchBy.code);

input_rec := RECORD(Codes.Layout_Codes_V3 and not [field_name2,long_flag ]) 
   typeof(codes.Layout_Codes_V3.field_name2) Source_name;
END;

// input := project(//  do things like getResponse below () ut.ds_oneRecord, 
input_rec formatInput() :=	transform
		self.file_name := trim(stringlib.stringtouppercase(file_name));
		self.field_name := trim(stringlib.stringtouppercase(field_name));
		self.Source_Name := trim(stringlib.stringtouppercase(Source_Name));
		self.code := trim(stringlib.stringtouppercase(code));
		self.long_desc := '';
end;		

input := dataset([formatInput()]);

result := join(input, Codes.Key_Codes_V3,
	keyed(right.file_name=left.file_name) and 
	keyed(right.field_name=left.field_name)
	and (left.Source_Name = '' or right.field_name2 = left.Source_Name)
	and (left.code = '' or right.code = left.code)
	,
	transform(iesp.codelookup.t_CodeRecord, 
		self.FileName := right.file_name,
		self.Fieldname := right.field_name,
		self.SourceName := right.field_name2,
		self.code := right.code,
		self.description := right.long_desc
		),
					limit(0),keep(iesp.Constants.MaxCountCodeRecords));
			
iesp.codelookup.t_CodeLookupResponse GetResponse() := TRANSFORM
		SELF._Header := iesp.ECL2ESP.GetHeaderRow();
		SELF.result.codeRecords := result;  
END;
					
finalResult := DATASET([GetResponse()]);					
output(finalResult, named('Results'));

ENDMACRO;

 // Codes.Code_Lookup_Service();