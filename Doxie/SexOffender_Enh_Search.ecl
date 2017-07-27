/*
2005-05-13 Jim Breffni Initial Version
*/
/*--SOAP--
<message name="SexOffender_Enh_Search_Service">
  <part name="Zip"         type="xsd:string" required="1"/>
  <part name="ZipRadius"   type="xsd:unsignedInt"/>	
  <part name="GLBDataUse"  type="xsd:byte"/>	
</message>
*/
/*--INFO-- 
This service returns a list of sex offender addresses for the entered zip 5 and radius based upon
registered, best or relatives address.

Duplicates are not shown, sex offender AKA's are.

*/
/*--RESULT-- xslt.html */
import doxie;

export SexOffender_Enh_Search := MACRO

string5   zip_value       := '' : stored('Zip');
unsigned4 ZipRadius_Value := 0  : stored('ZipRadius');
integer1  GLB := 0              : stored('GLBDataUse');


//Call this common code instead of duplicating code for Service and Batch_Service
Result := doxie.SexOffender_Enh_Common(zip_value, ZipRadius_Value, glb);

output(Result, named('Result'));


ENDMACRO;