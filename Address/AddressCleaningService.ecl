/*--SOAP--
<message name="AddressCleaningService" fast_display="true">
  <part name="AddressLine1" type="xsd:string"/>
  <part name="AddressLine2" type="xsd:string"/>
  <part name="City" type="xsd:string"/>
  <part name="State" type="xsd:string"/>
  <part name="Zip" type="xsd:string"/>
 </message>
*/
/*--INFO--
This service will clean a given address.  You must enter address line 1.  Then you can 
enter either address line 2 or city, state, zip combination.
*/

Import WSInput;

export AddressCleaningService() := macro

//The following macro defines the field sequence on WsECL page of query.
  WSInput.MAC_Addr_AddressCleaningService();

string120 addr1_val := '' : stored('AddressLine1');
string120 addr2_val := '' : stored('AddressLine2');
string25 city_val := '' : stored('City');
string2 st_val := '' : stored('State');
string5 zip_val := '' : stored('Zip');

Address.Layout_Batch_In setupAddr() := transform
  self.uid := 0;
  self.addr1 := addr1_val;
  self.addr2 := addr2_val;
  self.city_name := city_val;
  self.st := st_val;
  self.zip := zip_val;
end;

addr_in := dataset([setupAddr()]);

cleaned := Address.fn_AddressCleanBatch(addr_in);

final_out := project(cleaned, address.Layout_AddressCleaning_Out);

output(final_out, named ('Results'));

ENDMACRO;