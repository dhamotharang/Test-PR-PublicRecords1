EXPORT Layout_Polk_Lifestyle_Random := RECORD
Layout_Polk_Lifestyle_Analytic;
STRING20 pk_fname;
STRING20 pk_lname;
STRING10 pk_prim_range;
STRING28 pk_prim_name;
STRING8  pk_sec_range;
STRING5  pk_zip5;
STRING4  pk_zip4;
STRING10 pk_geo_lat;
STRING11 pk_geo_long;
STRING5  ls_zip5;
STRING4  ls_zip4;
STRING10 ls_geo_lat;
STRING11 ls_geo_long;
STRING1 TNT_Flag := 'N';
END;