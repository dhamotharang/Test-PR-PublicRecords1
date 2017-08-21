/*--SOAP--
<message name="Wheel_city_clean_Service">
<part name="prefix" type="xsd:string"/>
<part name="count" type="xsd:integer"/>
<part name="WheelThreshold" type="xsd:integer"/>
</message>
*/
IMPORT SALT33,BizLinkFull_HS;
EXPORT Wheel_city_clean_Service() := FUNCTION
    SALT33.StrType Input_prefix := '' : STORED('prefix');
    UNSIGNED Input_count := 1 : STORED('count');
    UNSIGNED Input_WheelThreshold := BizLinkFull_HS.Config_BIP.city_clean_WheelThreshold : STORED('WheelThreshold');
    results := BizLinkFull_HS.Wheel.Fetch_city_clean(SALT33.StringToUppercase(Input_prefix), Input_count, Input_WheelThreshold);
    RETURN OUTPUT(results);
END;
