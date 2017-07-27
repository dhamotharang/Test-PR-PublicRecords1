/*--SOAP--
<message name="BH_QA_Service">
  <part name="SourceTypes" type="tns:EspStringArray" required="1"/>
  <part name="State" type="xsd:string"/>
  <part name="Nth" type="xsd:string"/>
  <part name="Offset" type="xsd:string"/>
 </message>
*/
/*--INFO-- This service pulls sample records from business header file,
based on source type.   Codes must be in upper-case, multiple codes can
be entered, separated by [return].  See the <a href="BH_Source_Description_Service">
Source Description Sevice</a> for the list of codes.*/
/*--HTML-- xslt.bh */
/*--RESULT-- xslt.bh */

export BH_QA_Service() := macro

set of string2 source_types_value := [] : stored('SourceTypes');
string2 state_value := '' : stored('State');
string12 nth_val := '1' : stored('Nth');
string12 offset_val := '0' : stored('Offset');

UNSIGNED6 nth_value := IF((UNSIGNED6) nth_val < 1, 1, (UNSIGNED6) nth_val);
UNSIGNED6 offset_value := IF((UNSIGNED6) offset_val >= nth_value, nth_value - 1, (UNSIGNED6) offset_val);

bhf := Business_Header.File_Business_Header_Base_Plus;
bhks := Business_Header_SS.Key_BH_Source;

TYPEOF(bhf) Take(bhf l) := TRANSFORM
	SELF := l;
END;

fetched := FETCH(bhf, 
	bhks(	source in source_types_value, 
			seq % nth_value = offset_value,
			state_value = state OR state_value = ''), 
	RIGHT.__filepos,
	Take(LEFT));
	
res := SORT(CHOOSEN(fetched, 100), bdid);
OUTPUT(res, ALL)

ENDMACRO;