/*--SOAP--
<message name="vehicle_registration_state_origin_lic_plate_keyspan">
  <part name="state_origin" type="xsd:string"/>
  <part name="lic_plate" type="xsd:string"/>
  <part name="max_count" type="xsd:integer"/>
  <part name="return_count" type="xsd:integer"/>
  <part name="partial" type="xsd:boolean"/>
</message>
*/

// Generated by def2ecl.pl on Tue Feb 15 14:50:36 GMT 2005

export vehicle_registration_state_origin_lic_plate_keyspan := MACRO

// beginning of fill in values
keyfilename := '~thor_data400::key::moxie.mv.state_origin.lic_plate.key';
payloadkey_filename := '~thor_data400::key::moxie.mv.fpos.data.key';
datasetlayout := RECORD
  VehLic.Layout_Vehreg_ToMike;
  unsigned integer8 fpos{virtual(fileposition)};
END;
// end of fill in values

STRING2 state_origin_val := '' : STORED('state_origin');
STRING10 lic_plate_val := '' : STORED('lic_plate');
INTEGER max_count_value := 10000 : STORED('max_count');
INTEGER return_count_value := 1000 : STORED('return_count');
BOOLEAN partial := false : STORED('partial');

key := INDEX(dataset([],datasetlayout),{orig_state,license_plate_numberxbg4,fpos},keyfilename);
#uniquename(f)
payloadkey := INDEX(dataset([],datasetlayout),{unsigned8 %f% := fpos},{datasetlayout},payloadkey_filename);

res := key(
            keyed(orig_state=state_origin_val),
            keyed((partial AND license_plate_numberxbg4[1..LENGTH(TRIM(lic_plate_val))]=lic_plate_val) OR license_plate_numberxbg4=lic_plate_val)
);

lim_res := LIMIT(res,max_count_value,FAIL(11, doxie.ErrorCodes(11)),keyed);

count(lim_res)

ENDMACRO;
