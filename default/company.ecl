company_raw := DATASET('company', RECORD
  string20 c_ups_assigned_shipper_number,
  string35 c_shipper_name_line_1,
  string35 c_shipper_name_line_2,
  string35 c_shipper_address_line_1,
  string35 c_shipper_address_line_2,
  string30 c_shipper_city,
  string2  c_shipper_state_or_province,
  string15 c_shipper_postal_code,  
  unsigned integer8 holepos,
  END, HOLE);
export company := table(company_raw(),{company_raw});