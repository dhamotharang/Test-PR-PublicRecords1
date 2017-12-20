/*--SOAP--
<message name="Wheel_company_name_Service">
<part name="prefix" type="xsd:string"/>
<part name="count" type="xsd:integer"/>
</message>
*/
IMPORT SALT28,BizLinkFull;
EXPORT Wheel_company_name_Service() := FUNCTION
    SALT28.StrType Input_prefix := '' : STORED('prefix');
    UNSIGNED Input_count := 1 : STORED('count');
    results := BizLinkFull.Wheel.Fetch_company_name(SALT28.StringToUppercase(Input_prefix), Input_count);
    RETURN OUTPUT(results);
END;

