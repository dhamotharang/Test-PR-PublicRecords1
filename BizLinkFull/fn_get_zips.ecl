IMPORT RiskWise;
EXPORT fn_get_zips(STRING sCity,STRING sState,STRING sZip,UNSIGNED iRadius):=FUNCTION
  iZipRadius:=IF((sCity='' OR sState='') AND sZip='',0,iRadius);
  dWithinRadius:=TABLE(RiskWise.Key_ZipCitySt(keyed(city=StringLib.StringToUpperCase(sCity) AND state=StringLib.StringToUpperCase(sState))),{SET OF UNSIGNED zips:=ziplib.ZipsWithinRadius((STRING)zip5,iZipRadius)});
  dNormed:=NORMALIZE(dWithinRadius,COUNT(LEFT.zips),TRANSFORM({UNSIGNED zip;},SELF.zip:=(UNSIGNED)LEFT.zips[COUNTER];));
  siCityZip:=SET(TABLE(dNormed,{zip;},zip),zip);
  siListOfZips:=IF(iZipRadius>0,IF(sZip<>'',ziplib.ZipsWithinRadius(sZip,iRadius),siCityZip),IF(sZip='',[],[(UNSIGNED)sZip]));
  sNewCity:=IF(iZipRadius>0,'',sCity);
  sNewState:=IF(iZipRadius>0,'',sState);
  RETURN DATASET([{sNewCity,sNewState,siListOfZips}],{STRING city;STRING state;SET OF UNSIGNED zips;});
END;
