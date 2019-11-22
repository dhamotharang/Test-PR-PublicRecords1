import hygenics_crim, hygenics_search;

EXPORT sCourt_Vendors_To_Omit := FUNCTION

l_vendor_omits := record
string5 vendor_code;
string100 vendor_source;
string1 lf;
end;

df_omit := dataset('~thor_data400::out::vendor_omits', l_vendor_omits, flat);

omit_set := set(df_omit, vendor_code);

//output(omit_set);

RETURN omit_set;

END;