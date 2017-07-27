/*--SOAP--
<message name="ForeclosureWeekly">
</message>
*/

export Foreclosure_Weekly := Macro

output(choosen(property.Key_Foreclosure_DID,10));
output(choosen(property.Key_Foreclosures_FID,10));

endmacro;