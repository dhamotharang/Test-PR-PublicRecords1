/*--SOAP--
<message name="BusinessReg">
</message>
*/

export BusinessReg := macro

output(choosen(busreg.key_busreg_company_bdid,10));
//output(choosen(busreg.key_busreg_contact_bdid,10));

endmacro;