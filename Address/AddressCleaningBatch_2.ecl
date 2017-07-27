/*--SOAP--
<message name="Did_Batch_Service">
  <part name="addr_batch_in" type="tns:XmlDataSet" cols="70" rows="25"/>
</message>
*/
/*--INFO-- This service cleans addresses always hitting the Unixs cleaner.*/
export AddressCleaningBatch_2 := MACRO

in_format := address.Layout_Batch_In;
out_format := address.Layout_Batch_Out_2;

f := dataset([],in_format) : stored('addr_batch_in',few);

in_format AddAddr2(f L) := transform
 self.addr2 := if(l.addr2='',address.addr2FromComponents(l.city_name,l.st,l.zip),l.addr2);
 self := l;
end;

WithAddr2 := project(choosen(f,1000),AddAddr2(left));

STRING120 ca(STRING s) := stringlib.StringToUpperCase(stringlib.StringCleanSpaces(trim(s, left)));

out_format addUnix(in_format L) := transform
 self.clean := doxie.CleanAddress183(ca(l.addr1),ca(l.addr2));
 self := l;
end;

all_recs_unix := project(WithAddr2,addUnix(left));

result := all_recs_unix;

output(result, named('Results'))

ENDMACRO;