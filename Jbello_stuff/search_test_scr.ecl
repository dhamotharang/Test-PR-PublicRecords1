/*--SOAP--
<message name="TEST">
  <part name="p_diff" 					type="xsd:integer"	/>
  <part name="distinct_ssn_cnt"			type="xsd:integer"	/>
  <part name="distinct_conbinations"	type="xsd:integer"	/>
  <part name="intersect_ratio"			type="xsd:integer"	/>
 </message>
*/
/*--INFO-- 
TEST */


export search_test_scr() := MACRO

integer p_diff				:= 2	: STORED('p_diff');
integer ssn_cnt_value		:= 2	: STORED('distinct_ssn_cnt');
integer conbinations_value	:= 1	: STORED('distinct_conbinations');
integer ratio_value			:= 75	: STORED('intersect_ratio');

Fetched := 	JBello_stuff.search_test(p_diff
									,ssn_cnt_value
									,conbinations_value
									,ratio_value);

output(choosen(Fetched, 2000));

ENDMACRO;