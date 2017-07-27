// The purpose is to link a list of zip codes to a county

IMPORT doxie, ut;

// fips5 is complete fips: 2 digit state code + 3 char county code
layout_zips := RECORD
  string5 fips5;
  string5 zip5;
END;
ds_fips5_to_zip := DATASET ('~thor_data400::in::ZipbyCountyKeys', layout_zips, CSV);

base_file := Census_Data.file_Fips2County;


layout_out := RECORD
  string18 county_name;
  string2 state_code;
  string5 zip5;
end;

layout_out GetZipInfo (layout_zips L, base_file R) := TRANSFORM
  SELF.county_name := R.county_name;
  SELF.state_code := R.state_code;
  SELF.zip5 := L.zip5;
END;

ds_join := JOIN (ds_fips5_to_zip, base_file,
                 (Left.fips5 [1..2] = Right.state_fips) AND (Left.fips5 [3..5] = Right.county_fips),
                 GetZipInfo (Left, Right),
                 ATMOST (1)); // m:1 non-keyed relation

EXPORT Key_CountySt_Zip := INDEX (ds_join, {county_name, state_code}, {zip5},
                                 ut.foreign_prod+'thor_data400::key::countystate_zip_' + doxie.Version_SuperKey);


// 27 zip records are missing for ALASKA. ALASKA "counties" (boroughs) discrepancies:
// Comparing wikipedia vs. fips2county:
// Northwest Arctic Borough (missing)
// Prince of Wales-Outer Ketchikan Census Area (missing)
// Skagway-Hoonah-Angoon Census Area (maybe, this is = SKGWY-YKUTAT-ANGN in fips2county?)
