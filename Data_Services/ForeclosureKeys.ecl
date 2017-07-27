/*--SOAP--
<message name="ForeclosureWeekly">
</message>
*/

export ForeclosureKeys := Macro

output(choosen(property.Key_Foreclosure_DID,10));
output(choosen(property.Key_Foreclosures_FID,10));
output(choosen(property.Key_Foreclosures_BDID,10));
output(choosen(property.Key_Foreclosures_Payload,10));
output(choosen(Autokey.Key_Address('~thor_data400::key::foreclosure::autokey::qa::'),10));
output(choosen(Autokey.Key_CityStName('~thor_data400::key::foreclosure::autokey::qa::'),10));
output(choosen(Autokey.Key_Name('~thor_data400::key::foreclosure::autokey::qa::'),10));
output(choosen(Autokey.Key_SSN2('~thor_data400::key::foreclosure::autokey::qa::'),10));
output(choosen(Autokey.Key_StName('~thor_data400::key::foreclosure::autokey::qa::'),10));
output(choosen(Autokey.Key_Zip('~thor_data400::key::foreclosure::autokey::qa::'),10));
output(choosen(AutokeyB2.Key_Address('~thor_data400::key::foreclosure::autokey::qa::'),10));
output(choosen(AutokeyB2.Key_CityStName('~thor_data400::key::foreclosure::autokey::qa::'),10));
output(choosen(AutokeyB2.Key_Name('~thor_data400::key::foreclosure::autokey::qa::'),10));
output(choosen(AutokeyB2.Key_NameWords('~thor_data400::key::foreclosure::autokey::qa::'),10));
output(choosen(AutokeyB2.Key_StName('~thor_data400::key::foreclosure::autokey::qa::'),10));
output(choosen(AutokeyB2.Key_Zip('~thor_data400::key::foreclosure::autokey::qa::'),10));
output(choosen(risk_indicators.Key_FI_Module.Key_FI_Geo11,10));
output(choosen(risk_indicators.Key_FI_Module.Key_FI_Geo12,10));
output(choosen(risk_indicators.Key_FI_Module.Key_FI_fips,10));

// NOD Keys
output(choosen(Property.Key_NOD_DID,10));
output(choosen(Property.Key_NOD_FID,10));
output(choosen(Property.Key_NOD_BDID,10));
output(choosen(Property.Key_NOD_Payload,10));
output(choosen(Autokey.Key_Address('~thor_data400::key::nod::autokey::qa::'),10));
output(choosen(Autokey.Key_CityStName('~thor_data400::key::nod::autokey::qa::'),10));
output(choosen(Autokey.Key_Name('~thor_data400::key::nod::autokey::qa::'),10));
output(choosen(Autokey.Key_SSN2('~thor_data400::key::nod::autokey::qa::'),10));
output(choosen(Autokey.Key_StName('~thor_data400::key::nod::autokey::qa::'),10));
output(choosen(Autokey.Key_Zip('~thor_data400::key::nod::autokey::qa::'),10));
output(choosen(AutokeyB2.Key_Address('~thor_data400::key::nod::autokey::qa::'),10));
output(choosen(AutokeyB2.Key_CityStName('~thor_data400::key::nod::autokey::qa::'),10));
output(choosen(AutokeyB2.Key_Name('~thor_data400::key::nod::autokey::qa::'),10));
output(choosen(AutokeyB2.Key_NameWords('~thor_data400::key::nod::autokey::qa::'),10));
output(choosen(AutokeyB2.Key_StName('~thor_data400::key::nod::autokey::qa::'),10));
output(choosen(AutokeyB2.Key_Zip('~thor_data400::key::nod::autokey::qa::'),10));
output(choosen(Property.Key_Foreclosures_Addr,10));

endmacro;