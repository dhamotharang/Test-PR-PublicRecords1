export fn_csz_format(string city_in, string st_in, string zip_in) := function

 string v_city := city_in;
 string v_st   := st_in;
 string v_zip  := zip_in;
 
 boolean has_city_and_st := v_city<>'' and v_st<>'';
 
 string v_opt_comma := if(has_city_and_st=true,', ',' ');
 
 string v_formatted := stringlib.stringcleanspaces(v_city+v_opt_comma+v_st+' '+v_zip);
 
 return v_formatted;
 
end;