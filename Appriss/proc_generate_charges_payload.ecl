layout_payload_charges tRec(file_charges_base L):= TRANSFORM
//self.booking_sid_fixed:= TRIM(L.booking_sid); // make it fixed length
self.booking_sid := TRIM(L.booking_sid);
self.charge_seq :=(integer)L.charge_seq;
self:=L; 
END;
ds_payload:=PROJECT(file_charges_base(booking_sid <> '0'), tRec(LEFT));
export proc_generate_charges_payload := 
   OUTPUT(ds_payload,,'~thor_data400::temp::Appriss::charges_payloadformat',OVERWRITE);
