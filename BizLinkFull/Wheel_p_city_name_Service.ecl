/*--SOAP--
<message name="Wheel_p_city_name_Service">
<part name="prefix" type="xsd:string"/>
<part name="count" type="xsd:integer"/>
<part name="fuzzy_editn" type="xsd:boolean"/>
<part name="fuzzy_phonetic" type="xsd:boolean"/>
</message>
*/
IMPORT SALT27,BizLinkFull;
EXPORT Wheel_p_city_name_Service() := FUNCTION
    SALT27.StrType Input_prefix := '' : STORED('prefix');
    UNSIGNED Input_count := 1 : STORED('count');
    BOOLEAN Input_fuzzy_editn := false : STORED('fuzzy_editn');
    BOOLEAN Input_fuzzy_phonetic := false : STORED('fuzzy_phonetic');
    results := BizLinkFull.Wheel.Fetch_p_city_name(SALT27.StringToUppercase(Input_prefix), Input_count, Input_fuzzy_editn, Input_fuzzy_phonetic);
    RETURN OUTPUT(results);
END;

