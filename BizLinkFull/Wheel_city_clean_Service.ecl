/*--SOAP--
<message name="Wheel_city_clean_Service">
<part name="prefix" type="xsd:string"/>
<part name="count" type="xsd:integer"/>
<part name="WheelThreshold" type="xsd:integer"/>
</message>
*/
IMPORT SALT37,BizLinkFull;
EXPORT Wheel_city_clean_Service() := FUNCTION
    SALT37.StrType Input_prefix := '' : STORED('prefix');
    UNSIGNED Input_count := 1 : STORED('count');
    UNSIGNED Input_WheelThreshold := BizLinkFull.Config_BIP.city_clean_WheelThreshold : STORED('WheelThreshold');
    results := BizLinkFull.Wheel.Fetch_city_clean(SALT37.StringToUppercase(Input_prefix), Input_count, Input_WheelThreshold);
    RETURN OUTPUT(results);
END;
