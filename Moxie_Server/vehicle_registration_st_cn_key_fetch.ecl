/*--SOAP--
<message name="vehicle_registration_st_cn_key_fetch">
  <part name="st" type="xsd:string"/>
  <part name="cn" type="xsd:string"/>
  <part name="max_count" type="xsd:integer"/>
  <part name="return_count" type="xsd:integer"/>
  <part name="partial" type="xsd:boolean"/>
</message>
*/

// Generated by def2ecl.pl on Tue Feb 15 14:50:37 GMT 2005

export vehicle_registration_st_cn_key_fetch := MACRO

// beginning of fill in values
keyfilename := '~thor_data400::key::moxie.mv.st.cn.key';
payloadkey_filename := '~thor_data400::key::moxie.vehicles.fpos.data.key';
datasetlayout := RECORD
  VehLic.Layout_Vehreg_ToMike;
  unsigned integer8 fpos{virtual(fileposition)};
END;
// end of fill in values

STRING2 st_val := '' : STORED('st');
STRING10 cn_val := '' : STORED('cn');
INTEGER max_count_value := 10000 : STORED('max_count');
INTEGER return_count_value := 1000 : STORED('return_count');
BOOLEAN partial := false : STORED('partial');

key := INDEX(dataset([],datasetlayout),{own_1_state_2,STRING10 cn := '',fpos},keyfilename);
#uniquename(f)
payloadkey := INDEX(dataset([],datasetlayout),{unsigned8 %f% := fpos},{datasetlayout},payloadkey_filename);

res := key(
            keyed(own_1_state_2=st_val),
            keyed((partial AND cn[1..LENGTH(TRIM(cn_val))]=cn_val) OR cn=cn_val)
);

lim_res := LIMIT(res,max_count_value,FAIL(11, doxie.ErrorCodes(11)),keyed);

output(TOPN(lim_res,return_count_value,RECORD))

ENDMACRO;
