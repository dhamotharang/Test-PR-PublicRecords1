IMPORT Address, STD;

EXPORT CleanAddressOneLine(string line1) :=
FUNCTION
  string vRemoveComma := STD.Str.FindReplace(line1, ',', ' ');
  string vCleanLine1  := STD.Str.CleanSpaces(line1);
  string vZip         := REGEXFIND('([0-9]{5,})(([-]?[0-9]{1,4})?)$', vCleanLine1, 0);
  string vState       := REGEXFIND('([ ])([A-Za-z]{2})([ ]?)([0-9]{5,})(([-]?[0-9]{1,4})?)$', vCleanLine1, 2, NOCASE);

  // Replace full zip (zip5 + zip4) with only zip5 to make it easier for parsing later on
  string vZip5      := vZip[1..5];
  string vLine1Zip5 := STD.Str.FindReplace(vCleanLine1, vZip, vZip5);

  // Clean address using only state and zip as line2
  vTmpClnAddr := Address.CleanAddressParsed(vLine1Zip5, vState + ' ' + vZip5).AddressRecord;

  string vCityName := IF(vTmpClnAddr.p_city_name = vTmpClnAddr.v_city_name,
                          TRIM(vTmpClnAddr.v_city_name),
                          TRIM(vTmpClnAddr.p_city_name) + IF(vTmpClnAddr.p_city_name != '' AND vTmpClnAddr.v_city_name != '', '|', '') + TRIM(vTmpClnAddr.v_city_name));

  string vCSZPattern := '(' + '(' + vCityName + ')' + '[ ]?' + vState + '[ ]?' + vZip5 + ')$';

  string vRemoveCSZLine1 := REGEXREPLACE(vCSZPattern, vLine1Zip5, '', NOCASE);

  modAddr := Address.GetCleanAddress(vRemoveCSZLine1, vTmpClnAddr.v_city_name + ' ' + vTmpClnAddr.st + ' ' + vTmpClnAddr.zip, Address.Components.Country.US).Results;

  RETURN modAddr;
END;
