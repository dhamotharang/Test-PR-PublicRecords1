/*--SOAP--
<message name="telcordiatpm_Monthly">
</message>
*/

export telcordiatpm_Monthly := MACRO

output(choosen(Risk_Indicators.Key_tpm_slim,10));
output(choosen(Risk_Indicators.Key_Telcordia_tpm,10));
output(choosen(Risk_Indicators.Key_Telcordia_NPA_St,10));
endmacro;