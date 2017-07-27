IMPORT BIPV2_Build, Tools;
EXPORT fn_get_zips(STRING sCity,STRING sState,STRING sZip,UNSIGNED iRadius):=FUNCTION
  iZipRadius:=IF((sCity='' OR sState='') AND sZip='',0,iRadius);
  dZipsFromCitySt:=TABLE(BIPV2_Build.keys(, pUseOtherEnvironment:= tools._Constants.IsDataland).ZipCitySt.qa(keyed(city=StringLib.StringToUpperCase(sCity) AND state=StringLib.StringToUpperCase(sState))),{SET OF STRING zips:=ziplib.ZipsWithinRadius(zip5,iZipRadius)});
  dZipsFromZip:=DATASET([{ziplib.ZipsWithinRadius(sZip,iRadius)}],{SET OF STRING zips;});
  dZipsPrep:=IF(sZip='',dZipsFromCitySt,dZipsFromZip);
  dZipsNormed:=NORMALIZE(dZipsPrep,COUNT(LEFT.zips),TRANSFORM({STRING zip;},SELF.zip:=('0000'+LEFT.zips[COUNTER])[LENGTH('0000'+LEFT.zips[COUNTER])-4..];));
  ssZips:=IF(iZipRadius>0,SET(TABLE(dZipsNormed,{zip;},zip),zip),IF(sZip='',[],[sZip]));
  sNewCity:=IF(iZipRadius>0,'',sCity);
  sNewState:=IF(iZipRadius>0,'',sState);
  RETURN DATASET([{sNewCity,sNewState,ssZips}],{STRING city;STRING state;SET OF STRING zips;});
END;