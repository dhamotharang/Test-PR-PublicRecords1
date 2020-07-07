export layout_best_supplemental_info := record
  integer1 age,
  integer1 age_at_death,
  string18 death_county,
  string2  death_state,
  boolean  is_valid_ssn,
  string32 ssn_issued_location,
  unsigned4 ssn_issued_startdate,
  unsigned4 ssn_issued_enddate
end;