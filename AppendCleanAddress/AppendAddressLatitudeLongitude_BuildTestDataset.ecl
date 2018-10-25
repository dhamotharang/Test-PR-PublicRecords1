rAddress :=
record
	string10 addressprimaryrange;
	string2 addresspredirectional;
	string28 addressprimaryname;
	string4 addressaddresssuffix;
	string2 addresspostdirectional;
	string10 addressunitdesignation;
	string8 addresssecondaryrange;
	string25 addresspostalcity;
	string25 addressvanitycity;
	string2 addressstate;
	string5 addresszip;
	string4 addresszip4;
end;
	
dAddress :=
  dataset([
    {'6601      ', '  ', 'PARK OF COMMERCE            ', 'BLVD', '  ', '          ', '        ', 'BOCA RATON               ', 'BOCA RATON               ', 'FL', '33487', '8247'}, 
    {'1600      ', '  ', 'PENNSYLVANIA                ', 'AVE ', 'NW', '          ', '        ', 'WASHINGTON               ', 'WASHINGTON               ', 'DC', '20500', '0003'}, 
    {'4879      ', 'S ', 'CITATION                    ', 'DR  ', '  ', '          ', '        ', 'DELRAY BEACH             ', 'DELRAY BEACH             ', 'FL', '33445', '6513'},
    {'          ', '  ', '                            ', '    ', '  ', '          ', '        ', '                         ', '                         ', '  ', '     ', '    '}], rAddress);

OUTPUT(dAddress,,'~qa::appendcleanaddress::appendaddresslatitudelongitude::input',OVERWRITE);
