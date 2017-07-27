/*--SOAP--
<message name="NameCleaning_Batch_Service">
  <part name="batch_in" type="tns:XmlDataSet" cols="70" rows="25"/>
</message>
*/
/*--INFO-- This service cleans names always hitting the Unixs cleaner.*/

import Address;
export NameCleaning_Batch_Service := MACRO

in_format := address.Layout_Batch_In_Name;
out_format := address.Layout_Batch_Out_Name;

ds_in := dataset([],in_format) : stored('batch_in',few);

out_format clean_xform(in_format L) := transform

	STRING100 upper_trim_spaces(STRING s) := stringlib.StringToUpperCase(stringlib.StringCleanSpaces(trim(s, left)));
	STRING73 parse_name(STRING str)    := Address.CleanPerson73(str);
	STRING73 parse_nameFML(STRING str) := Address.CleanPersonFML73(str);
	STRING73 parse_nameLFM(STRING str) := Address.CleanPersonLFM73(str);
	STRING73 prepped_name := upper_trim_spaces(L.name);
	STRING73 parsed_name := MAP(L.hint = 'F' => parse_nameFML(prepped_name),
										      		L.hint = 'L' => parse_nameLFM(prepped_name),
	                            parse_name(prepped_name));

	SELF.name_prefix := parsed_name[1..5];
	SELF.name_first  := parsed_name[6..25];
	SELF.name_middle := parsed_name[26..45];
	SELF.name_last   := parsed_name[46..65];
	SELF.name_suffix := parsed_name[66..70];
	SELF.name_score  := parsed_name[71..73];
	SELF := L;
END;

all_recs_cleaned := project(ds_in,clean_xform(left));

result := all_recs_cleaned;

output(result, named('Results'))

ENDMACRO;
