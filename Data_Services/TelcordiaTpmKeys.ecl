/*--SOAP--
<message name="telcordiatpm_Monthly">
</message>
*/

export TelcordiaTpmKeys := MACRO

output(choosen(Risk_Indicators.Key_tpm_slim,10));
output(choosen(Risk_Indicators.Key_Telcordia_tpm,10));
output(choosen(Risk_Indicators.Key_Telcordia_NPA_St,10));

output(choosen(Risk_Indicators.Key_Telcordia_City_State,10));
output(choosen(Risk_Indicators.Key_Telcordia_State,10));
output(choosen(Risk_Indicators.Key_Telcordia_Zip,10));

endmacro;