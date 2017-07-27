import doxie, ut;

d := canadianphones.file_CanadianWhitePagesBase;

payload := record
  string10 phonenumber;
  string15 firstname;
  string15 middlename;
  string20 lastname;
  string4 title;
  string4 professionalsuffix;
  string10 prim_range;
  string2 predir;
  string28 prim_name;
  string4 addr_suffix;
  string10 unit_desig;
  string8 sec_range;
  string25 p_city_name;
  string2 state;
  string6 zip;
  string6 errstat;
  string10 housenumber;
  string3 directional;
  string35 streetname;
  string7 streetsuffix;
  string9 suitenumber;
  string30 suburbancity;
  string30 postalcity;
  string2 province;
  string6 postalcode;
  string2 provincecode;
  string4 phonetypeflag;
  string4 nosolicitation;
  string4 cmacode;
end;


f := project(d(prim_name<>'' and zip <>''), transform(payload, self := left));


export Key_CWP_Addr := index(f,{zip, prim_name, prim_range, sec_range},
								{f},
                                  '~thor_data400::key::canadianwp_addr_'+doxie.Version_SuperKey);