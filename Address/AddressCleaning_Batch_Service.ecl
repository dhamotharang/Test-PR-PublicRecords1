/*--SOAP--
<message name="AddressCleaning_Batch_Service">
  <part name="batch_in" type="tns:XmlDataSet" cols="70" rows="25"/>
</message>
*/
/*--INFO-- This service cleans addresses always hitting the Unixs cleaner.*/
export AddressCleaning_Batch_Service := MACRO

in_format  := address.Layout_Batch_In_Address;
out_format := address.Layout_Batch_Out_Address;

ds_in := dataset([],in_format) : stored('batch_in',few);

STRING120 ca(STRING s) := stringlib.StringToUpperCase(stringlib.StringCleanSpaces(trim(s, left)));

out_format clean_xform(ds_in L) := transform
 STRING temp_addr2 := if(l.addr2='',address.addr2FromComponents(l.city_name,l.st,l.zip),l.addr2);
 STRING183 cleaned_name := doxie.CleanAddress183(ca(l.addr1),ca(temp_addr2));
 self.clean       := cleaned_name;
 self.prim_range  := cleaned_name[1..10];
 self.predir      := cleaned_name[11..12];
 self.prim_name   := cleaned_name[13..40];
 self.addr_suffix := cleaned_name[41..44];
 self.postdir     := cleaned_name[45..46];
 self.unit_desig  := cleaned_name[47..56];
 self.sec_range   := cleaned_name[57..64];
 self.p_city_name := cleaned_name[65..89];
 self.v_city_name := cleaned_name[90..114];
 self.cleaned_st  := cleaned_name[115..116]; 
 self.cleaned_zip := cleaned_name[117..121]; 
 self.zip4        := cleaned_name[122..125]; 
 self.cart        := cleaned_name[126..129]; 
 self.cr_sort_sz  := cleaned_name[130..130]; 
 self.lot         := cleaned_name[131..134]; 
 self.lot_order   := cleaned_name[135..135]; 
 self.dbpc        := cleaned_name[136..137]; 
 self.chk_digit   := cleaned_name[138..138]; 
 self.rec_type    := cleaned_name[139..140]; 
 self.county      := cleaned_name[141..145]; 
 self.geo_lat     := cleaned_name[146..155]; 
 self.geo_long    := cleaned_name[156..166]; 
 self.msa         := cleaned_name[167..170]; 
 self.geo_blk     := cleaned_name[171..177]; 
 self.geo_match   := cleaned_name[178..178]; 
 self.err_stat    := cleaned_name[179..182]; 
 self := l;
end;

all_recs_cleaned := project(ds_in,clean_xform(left));

result := all_recs_cleaned;

output(result, named('Results'))

ENDMACRO;
