dstest_Record :=
  record
    string address1;
    string city;
    string state;
    string zip;
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
    string2 addressdbpc;
    string1 addresscheckdigit;
    string2 addressrecordtype;
    string5 addresscounty;
    string10 addresslatitude;
    string11 addresslongitude;
    string4 addressmsa;
    string7 addressgeoblock;
    string1 addressgeomatchcode;
    string4 addresserrorstatus;
    boolean addresscachehit;
    boolean addresscleanerhit;
  end;
  
dstest :=
  dataset([
    {'6601 Park of Commerce Blvd', 'Boca Raton', 'FL', '33487', '6601      ', '  ', 'PARK OF COMMERCE            ', 'BLVD', '  ', '          ', '        ', 'BOCA RATON               ', 'BOCA RATON               ', 'FL', '33487', '8247', '01', '3', 'S ', '12099', '26.406964 ', '-80.096916 ', '    ', '0070029', '0', 'S800', true, false}, 
    {'1600 Pennsylvania Ave NW', 'Washington', 'DC', '20006', '1600      ', '  ', 'PENNSYLVANIA                ', 'AVE ', 'NW', '          ', '        ', 'WASHINGTON               ', 'WASHINGTON               ', 'DC', '20500', '0003', '99', '2', 'HD', '11001', '38.898851 ', '-77.033332 ', '8840', '0058001', '5', 'S900', true, false}, 
    {'4879 S Citation Drive', 'Delray Beach', 'FL', '33445', '4879      ', 'S ', 'CITATION                    ', 'DR  ', '  ', '          ', '        ', 'DELRAY BEACH             ', 'DELRAY BEACH             ', 'FL', '33445', '6513', '79', '0', 'S ', '12099', '26.433303 ', '-80.120497 ', '0000', '0069122', '0', 'S800', false, false}, 
    {'742 Evergreen Terrace', 'Springfield', 'USA', '', '          ', '  ', '                            ', '    ', '  ', '          ', '        ', '                         ', '                         ', '  ', '     ', '    ', '  ', ' ', '  ', '     ', '          ', '           ', '    ', '       ', '5', 'E101', false, false}], dstest_Record);

OUTPUT(dstest,,'~qa::advo::appendadvo::input',OVERWRITE);