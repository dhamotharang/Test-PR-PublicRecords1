rec := record
 string2 state_code;
 string2 state_fips;
 string3 county_fips;
 string18 county_name;
 string1 lf;
end;

export File_Fips2County := dataset('~thor_data400::in::fips_counties',rec,flat)(state_fips<>'',county_fips<>'');