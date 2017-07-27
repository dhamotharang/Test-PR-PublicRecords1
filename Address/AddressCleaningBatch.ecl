/*--SOAP--
<message name="Did_Batch_Service">
  <part name="addr_batch_in" type="tns:XmlDataSet" cols="70" rows="25"/>
</message>
*/
export AddressCleaningBatch := macro

in_format := address.Layout_Batch_In;
out_format := address.layout_batch_out;

addr_in := dataset([],in_format) : stored('addr_batch_in',few);

cleaned := Address.fn_AddressCleanBatch(addr_in);

output(cleaned, named('Result'))

ENDMACRO;