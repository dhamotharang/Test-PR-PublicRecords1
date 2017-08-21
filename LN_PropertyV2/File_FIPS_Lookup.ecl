fips_rec := record
 string2  state_alpha;
 string2  state_code;
 string3  county_code;
 string40 county_alpha;
 string2  class;
 string1  crlf;
end;

export File_FIPS_Lookup := dataset('~thor_data400::in::fips_code_lookup',fips_rec,flat);