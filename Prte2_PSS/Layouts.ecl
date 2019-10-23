EXPORT Layouts := module

Export bdid_phone_layout:=RECORD
  unsigned6 bdid;
  string17 response_company_phone;
  unsigned1 phone_pos;
  string1 response_phone_status;
  string8 response_phone_notes_date;
  unsigned4 dt_vendor_last_reported;
  unsigned4 dt_vendor_first_reported;
 END;
 End;