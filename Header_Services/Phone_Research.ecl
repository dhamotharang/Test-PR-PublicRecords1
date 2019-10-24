/*--SOAP--
<message name="Phone_Research">
  <part name="AreaCode" type="xsd:string"/>
  <part name="Exchange" type="xsd:string"/>
  <part name="MaxPhoneCount" type="xsd:unsignedInt"/>
</message>
*/
/*--INFO-- This service searches phone numbers that are know to be disconnected now*/

export Phone_Research := MACRO
    import AutoStandardI, Doxie;
    mod_access := Doxie.compliance.GetGlobalDataAccessModuleTranslated(AutoStandardI.GlobalModule());
    integer4 max_phone_val := 10000 : stored('MaxPhoneCount');
    out_recs := Header_Services.Phone_Research_Records(mod_access);
    output(choosen(out_recs, max_phone_val), named('Results'));
ENDMACRO;
