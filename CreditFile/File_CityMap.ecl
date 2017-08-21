r := record
ebcdic string2 state;
ebcdic string4 city_abbr;
 decimal5 zip;
ebcdic string1 _type;
ebcdic string20 city_full;
end;



d := dataset('~thor_data400::IN::CITYZIPS1.HEX1', r, flat);

/*r1 := record
string2 state;
string4 city_abbr;
 decimal5 zip;
string1 _type;
string20 city_full;
end;

r1 into(r le) := transform
  self := le;
  end;

p := project(d,into(left)); */

export File_CityMap := ascii(d);