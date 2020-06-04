/*--SOAP--
<message name="LGID3CompareService">
<part name="LGID3One" type="xsd:string"/>
<part name="LGID3Two" type="xsd:string"/>
</message>
*/
/*--INFO-- Compare two IDs to see if they should be joined.<p>If it is easier you may place the two IDs on the first line and they will be parsed into first and second.</p>*/
EXPORT LGID3CompareService := MACRO
  IMPORT SALT30,BIPV2_LGID3,ut;
STRING50 LGID3onestr := ''  : STORED('LGID3One');
STRING20 LGID3twostr := '*'  : STORED('LGID3two');
BIPV2_LGID3._fn_CompareService((unsigned6)LGID3onestr,(unsigned6)LGID3twostr);
ENDMACRO;
