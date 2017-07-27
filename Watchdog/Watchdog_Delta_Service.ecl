/*--SOAP--
<message name="Watchdog_Delta_Service">
  <part name="DID" type="xsd:string"/>
</message>
*/

export Watchdog_Delta_Service := MACRO

string did_in := '' : stored('DID');

dels := watchdog.Key_Watchdog_Delta(did=(unsigned)did_in);

output(sort(dels,-run_date));

endmacro;