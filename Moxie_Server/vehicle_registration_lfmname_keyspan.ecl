/*--SOAP--
<message name="vehicle_registration_lfmname_keyspan">
  <part name="lfmname" type="xsd:string"/>
  <part name="max_count" type="xsd:integer"/>
  <part name="return_count" type="xsd:integer"/>
  <part name="partial" type="xsd:boolean"/>
</message>
*/

// Generated by def2ecl.pl on Tue Feb 15 14:50:36 GMT 2005

export vehicle_registration_lfmname_keyspan := MACRO

// beginning of fill in values
keyfilename := '~thor_data400::key::moxie.mv.lfmname.key';
payloadkey_filename := '~thor_data400::key::moxie.vehicles.fpos.data.key';
datasetlayout := RECORD
  VehLic.Layout_Vehreg_ToMike;
  unsigned integer8 fpos{virtual(fileposition)};
END;
// end of fill in values

STRING60 lfmname_val := '' : STORED('lfmname');
INTEGER max_count_value := 10000 : STORED('max_count');
INTEGER return_count_value := 1000 : STORED('return_count');
BOOLEAN partial := false : STORED('partial');

key := INDEX(dataset([],datasetlayout),{STRING60 lfmname := own_1_lname,fpos},keyfilename);
#uniquename(f)
payloadkey := INDEX(dataset([],datasetlayout),{unsigned8 %f% := fpos},{datasetlayout},payloadkey_filename);

res := key(
            keyed((partial AND lfmname[1..LENGTH(TRIM(lfmname_val))]=lfmname_val) OR lfmname=lfmname_val)
);

lim_res := LIMIT(res,max_count_value,FAIL(11, doxie.ErrorCodes(11)),keyed);

count(lim_res)

ENDMACRO;
