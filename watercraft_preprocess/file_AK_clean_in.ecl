import watercraft, watercraft_preprocess, ut, lib_StringLib;

fIn_raw := watercraft_preprocess.Files_raw.AK;

//Trim and uppercase all fields prior to mapping
Watercraft.layout_ak CleanTrimRaw(fIn_raw L) := TRANSFORM
self.STATEABREV	:= ut.CleanSpacesAndUpper(L.STATEABREV);
self.REG_NUM		:= ut.CleanSpacesAndUpper(L.REG_NUM);
self.PROP	:= ut.CleanSpacesAndUpper(L.PROP);
self.VEH_TYPE	:= ut.CleanSpacesAndUpper(L.VEH_TYPE);
self.FUEL	:= ut.CleanSpacesAndUpper(L.FUEL);
tempHullID			:= MAP(StringLib.Stringfind(L.HULL_ID,'_',1) > 0 => StringLib.StringFindReplace(L.HULL_ID,'_',''),
											StringLib.Stringfind(L.HULL_ID,'*',1) > 0 => StringLib.StringFindReplace(L.HULL_ID,'*',''),
											L.HULL_ID);
self.HULL_ID := ut.CleanSpacesAndUpper(tempHullID);											
self.HULL	:= ut.CleanSpacesAndUpper(L.HULL);
self.USE_1	:= ut.CleanSpacesAndUpper(L.USE_1);
tempMake	:= ut.CleanSpacesAndUpper(StringLib.StringFindReplace(L.MAKE, '(DBA)',''));
self.MAKE	:= stringlib.StringFindReplace(tempMake,'\'','');
self.TOTAL_INCH := StringLib.StringFindReplace(L.TOTAL_INCH, '*','');
self.FIRST_NAME	:= ut.CleanSpacesAndUpper(L.FIRST_NAME);
self.MID	:= ut.CleanSpacesAndUpper(L.MID);
self.LAST_NAME	:= ut.CleanSpacesAndUpper(L.LAST_NAME);
self.ADDRESS_1	:= ut.CleanSpacesAndUpper(L.ADDRESS_1);
self.CITY	:= ut.CleanSpacesAndUpper(L.CITY);
self.STATE	:= ut.CleanSpacesAndUpper(L.STATE);
self.COUNTY	:= ut.CleanSpacesAndUpper(L.COUNTY);
tempLicPrevState	:= StringLib.StringFindReplace(L.LicPrevState, '*','');
self.LicPrevState	:= tempLicPrevState;
self.Address2	:= ut.CleanSpacesAndUpper(L.Address2);
self.Country	:= ut.CleanSpacesAndUpper(L.Country);
self.AddressRes1	:= ut.CleanSpacesAndUpper(L.AddressRes1);
self.AddressRes2	:= ut.CleanSpacesAndUpper(L.AddressRes2);
self.CityRes	:= ut.CleanSpacesAndUpper(L.CityRes);
self.StateRes	:= ut.CleanSpacesAndUpper(L.StateRes);
self.CountryRes	:= ut.CleanSpacesAndUpper(L.CountryRes);
self.Zip4Res	:= Regexreplace('[^0-9]',L.Zip4res,'');
self.LicStatus	:= ut.CleanSpacesAndUpper(L.LicStatus);
self.LicCountry	:= ut.CleanSpacesAndUpper(L.LicCountry);
self.Suffix1	:= ut.CleanSpacesAndUpper(L.Suffix1);
self.Company1	:= ut.CleanSpacesAndUpper(L.Company1);
self.ConJuntnCode1 := ut.CleanSpacesAndUpper(L.ConJuntnCode1);
self.OwnerNameLast2	:= ut.CleanSpacesAndUpper(L.OwnerNameLast2);
self.OwnerNameFirst2	:= ut.CleanSpacesAndUpper(L.OwnerNameFirst2);
self.OwnerNameMiddle2	:= ut.CleanSpacesAndUpper(L.OwnerNameMiddle2);
self.OwnerNameSuffix2	:= ut.CleanSpacesAndUpper(L.OwnerNameSuffix2);
self.OwnerNameCompany2	:= ut.CleanSpacesAndUpper(L.OwnerNameCompany2);
self.OwnerNameLast3	:= ut.CleanSpacesAndUpper(L.OwnerNameLast3);
self.OwnerNameFirst3	:= ut.CleanSpacesAndUpper(L.OwnerNameFirst3);
self.OwnerNameMiddle3	:= ut.CleanSpacesAndUpper(L.OwnerNameMiddle3);
self.OwnerNameSuffix3	:= ut.CleanSpacesAndUpper(L.OwnerNameSuffix3);
self.OwnerNameLast4	:= ut.CleanSpacesAndUpper(L.OwnerNameLast4);
self.OwnerNameFirst4	:= ut.CleanSpacesAndUpper(L.OwnerNameFirst4);
self.OwnerNameMiddle4	:= ut.CleanSpacesAndUpper(L.OwnerNameMiddle4);
self.OwnerNameSuffix4	:= ut.CleanSpacesAndUpper(L.OwnerNameSuffix4);
self.OwnerNameCompany4	:= ut.CleanSpacesAndUpper(L.OwnerNameCompany4);
self.OwnerNameLast5	:= ut.CleanSpacesAndUpper(L.OwnerNameLast5);
self.OwnerNameFirst5	:= ut.CleanSpacesAndUpper(L.OwnerNameFirst5);
self.OwnerNameMiddle5	:= ut.CleanSpacesAndUpper(L.OwnerNameMiddle5);
self.OwnerNameSuffix5	:= ut.CleanSpacesAndUpper(L.OwnerNameSuffix5);
self.OwnerNameCompany5	:= ut.CleanSpacesAndUpper(L.OwnerNameCompany5);
self.LienAddress1	:= ut.CleanSpacesAndUpper(L.LienAddress1);
self.LienAddress2	:= ut.CleanSpacesAndUpper(L.LienAddress2);
self.LienCity	:= ut.CleanSpacesAndUpper(L.LienCity);
self.LienState	:= ut.CleanSpacesAndUpper(L.LienState);
self.LienCountry	:= ut.CleanSpacesAndUpper(L.LienCountry);
self.HullColor	:= ut.CleanSpacesAndUpper(L.HullColor);
self.TrimColor	:= ut.CleanSpacesAndUpper(L.TrimColor);
self.CabinColor	:= ut.CleanSpacesAndUpper(L.CabinColor);
self := L;
END;

EXPORT file_AK_clean_in := project(fIn_raw,CleanTrimRaw(left));