import Data_Services;
EXPORT File_Fips := dataset(Data_Services.foreign_prod + 'thor_400::fips_code_lookup_table',{string5 fips_code, string2 state_code, string30 county_name}, thor);
