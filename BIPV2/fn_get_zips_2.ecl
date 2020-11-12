//---------------------------------------------------------------------------
// Function returns a dataset containing all of the zip codes that are within
// the radius sepcified of a specific zip code, along with the distance each
// is from it.
// If zip is passed, that will be the zip checked.  If it is not passed, but
// city and state are then zip will be derived from city/state
//---------------------------------------------------------------------------
IMPORT BIPV2_Build,Tools,ut;
EXPORT fn_get_zips_2(STRING sCity,STRING sState,STRING sZip,UNSIGNED iRadius):=FUNCTION
  // Check if the state is valid
  sStateChecked:=IF(StringLib.StringToUpperCase(sState) IN ut.Set_State_Abbrev,StringLib.StringToUpperCase(sState),'');
  
  // Derive the zip from city/state and add to the entered zip
  lZipList:={STRING zip;};
  useOtherEnv := tools._Constants.IsDataland or tools._Constants.IsAlpha_dev;
  dDerivedZips:=TABLE(BIPV2_Build.keys(, pUseOtherEnvironment:= useOtherEnv).ZipCitySt.qa(keyed(city=StringLib.StringToUpperCase(sCity) AND state=sStateChecked)),{STRING zip:=zip5;});
  dZipsFromCitySt:=IF(sCity='' OR sStateChecked='',DATASET([],lZipList),PROJECT(dDerivedZips,lZipList));
  dZipList:=DATASET([{sZip}],lZipList)+dZipsFromCitySt;
  
  // If a populated city and state did not derive a zip, then the city is invalid
  sCityChecked:=IF(sCity<>'' AND sStateChecked<>'' AND COUNT(dZipsFromCitySt)=0,'',StringLib.StringToUpperCase(sCity));
  
  // Get the list of zips within the radius
  dAllZips:=PROJECT(dZipList,TRANSFORM({STRING fromzip;SET OF UNSIGNED zips;},SELF.fromzip:=LEFT.zip;SELF.zips:=ziplib.ZipsWithinRadius(LEFT.zip,iRadius);));
  dNormed:=NORMALIZE(dAllZips,COUNT(LEFT.zips),TRANSFORM({STRING fromzip;STRING tozip;UNSIGNED dist;},SELF.tozip:=(STRING)LEFT.zips[COUNTER];SELF.dist:=ut.zip_Dist(LEFT.fromzip,SELF.tozip)+1;SELF:=LEFT;));
  lReturn:={STRING city:='';STRING state:='';STRING zip;UNSIGNED radius;};
  
  // We want to keep the row for the entered zip on top, so build a row just
  // for that, and then pull it out of dNormed and put it on top.
  dOrigZip:=IF(sZip='',DATASET([],lReturn),DATASET([{'','',sZip,0}],lReturn));
  dDeduped:=DEDUP(SORT(dNormed,tozip,dist),tozip)((UNSIGNED)tozip<>(UNSIGNED)sZip);
  dWithRadius:=dOrigZip&SORT(PROJECT(dDeduped,TRANSFORM(lReturn,SELF.zip:=('00000'+(STRING)LEFT.tozip)[LENGTH((STRING)LEFT.tozip)+1..];SELF.radius:=LEFT.dist;)),radius,zip);
  // The dataset to return if no radius is entered
  dDerived:=PROJECT(dZipList,TRANSFORM(lReturn,SELF.radius:=0;SELF.city:=sCityChecked;SELF.state:=sStateChecked;SELF:=LEFT;))(zip<>'');
  dDerivedNoRadius:=IF(COUNT(dDerived)=0 AND (sCityChecked<>'' OR sStateChecked<>''),DATASET([{sCityChecked,sStateChecked,sZip,0}],lReturn),dDerived);
  RETURN IF(iRadius>0 AND COUNT(dWithRadius)>0,dWithRadius,dDerivedNoRadius);
END;
/*
BIPV2.fn_get_zips_2('AUSTIN','TX','76710',0);   // Valid city/st with a valid zip code that is not in that city/st, without radius : should have all Austin zips as well as the one enterd
BIPV2.fn_get_zips_2('AUSTIN','TX','76710',15);  // Valid city/st with a valid zip code that is not in that city/st, with radius    : all zips within the radius of Austin as well as 76710
BIPV2.fn_get_zips_2('AUSTINI','TX','76710',0);  // Invalid city with a valid zip code, without radius                              : should have just the entered zip
BIPV2.fn_get_zips_2('AUSTINI','TX','76710',15); // Invalid city with a valid zip code, with radius                                 : all zips within the radius of 76710
BIPV2.fn_get_zips_2('AUSTIN','TX','',0);        // valid city/st without or radius                                                 : all zips in Austin
BIPV2.fn_get_zips_2('AUSTIN','TX','',15);       // valid city/st without zip, with radius                                          : all zips within the radius of Austin
BIPV2.fn_get_zips_2('AUSTIN','XX','',0);        // valid city but not state without zip or radius                                  : no results
BIPV2.fn_get_zips_2('AUSTIN','TX','78710',0);   // valid city/st with zip in Austin, without radius                                : all Austin zips (entered one on top)
BIPV2.fn_get_zips_2('AUSTIN','TX','78710',15);  // valid city/st with zip in Austin, with radius                                   : all zips within the radius of Austin (entered one on top)
BIPV2.fn_get_zips_2('','','76710',0);           // Valid valid zip only, without radius                                            : only the zip entered
BIPV2.fn_get_zips_2('','','76710',15);          // Valid valid zip only, with radius                                               : all zips within the radius of 76710
BIPV2.fn_get_zips_2('AUSTINI','TX','',0);       // Invalid city with a valid state, without radius                                 : should have just the entered state
BIPV2.fn_get_zips_2('AUSTINI','TX','',15);      // Invalid city with a valid state, with radius                                    : should have just the entered state
BIPV2.fn_get_zips_2('','TX','',0);              // valid state only, without radius                                                : should have just the entered state
BIPV2.fn_get_zips_2('','TX','',10);             // valid state only, with radius                                                   : should have just the entered state
*/

