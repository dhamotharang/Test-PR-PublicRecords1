/*HACKCompareService*/
/*--SOAP--
<message name="ProxidCompareService">
<part name="ProxidOne" type="xsd:string"/>
<part name="ProxidTwo" type="xsd:string"/>
</message>
*/
/*--INFO-- Compare two IDs to see if they should be joined.<p>If it is easier you may place the two IDs on the first line and they will be parsed into first and second.</p>*/
EXPORT ProxidCompareService := MACRO
IMPORT SALT24,BIPV2_ProxID,ut,tools;
STRING50 Proxidonestr := '1234'  : STORED('ProxidOne');
STRING20 Proxidtwostr := '12345'  : STORED('Proxidtwo');
combo := 'qa';

BIPV2_ProxID._fun_CompareService((unsigned6)Proxidonestr,(unsigned6)Proxidtwostr,combo);
ENDMACRO;

