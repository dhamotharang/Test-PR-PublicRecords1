/*--SOAP--
<message name="vehicle_registration_state_origin_vehicle_number_key_fetch">
  <part name="state_origin" type="xsd:string"/>
  <part name="vehicle_number" type="xsd:string"/>
  <part name="max_count" type="xsd:integer"/>
  <part name="return_count" type="xsd:integer"/>
  <part name="partial" type="xsd:boolean"/>
</message>
*/

// Generated by def2ecl.pl on Thu Jan 20 13:24:49 GMT 2005

export vehicle_registration_state_origin_vehicle_number_key_fetch := MACRO

// beginning of fill in values
keyfilename := '~thor_data400::key::moxie.mv.state_origin.vehicle_number.key';
payloadkey_filename := '~thor_data400::key::moxie.vehicles.fpos.data.key';
datasetlayout := RECORD
  VehLic.Layout_Vehreg_ToMike;
  unsigned integer8 fpos{virtual(fileposition)};
END;
// end of fill in values

STRING2 state_origin_val := '' : STORED('state_origin');
STRING20 vehicle_number_val := '' : STORED('vehicle_number');
INTEGER max_count_value := 10000 : STORED('max_count');
INTEGER return_count_value := 1000 : STORED('return_count');
BOOLEAN partial := false : STORED('partial');

key := INDEX(dataset([],datasetlayout),{orig_state,vehicle_numberxbg1,fpos},keyfilename);
#uniquename(f)
payloadkey := INDEX(dataset([],datasetlayout),{unsigned8 %f% := fpos},{datasetlayout},payloadkey_filename);

res := key(
            keyed(orig_state=state_origin_val),
            keyed((partial AND vehicle_numberxbg1[1..LENGTH(TRIM(vehicle_number_val))]=vehicle_number_val) OR vehicle_numberxbg1=vehicle_number_val)
);

lim_res := LIMIT(res,max_count_value,FAIL(11, doxie.ErrorCodes(11)),keyed);

output(TOPN(lim_res,return_count_value,RECORD))

ENDMACRO;
