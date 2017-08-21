import watercraft, watercraft_preprocess, ut, lib_StringLib;
// translates mo_MJ.ksh* Ab intio graph into ECL

fIn_raw := watercraft_preprocess.Files_raw.MO;

// Filter for TOD

fTod := fIn_raw(regexfind(' TOD ',NAME) = true); 
fNTod := fIn_raw(regexfind(' TOD ',NAME) = false); 

fTodRef := project( fTod, transform({watercraft_preprocess.layout_temp.layout_mo_temp}, 

  string delimiters := if(regexfind(' TOD ',left.NAME),' TOD ',
                          if(regexfind(' & ',left.NAME),' & ',''));
						  
  integer4 len := if(regexfind(' TOD ',left.NAME),5,
                   if(regexfind(' & ',left.NAME),3,100));

  self.NAME1 := if(delimiters<>'', left.NAME[1.. StringLib.stringfind(left.NAME,delimiters,1)],'');
  self.NAME2 := if(len <99,/*left.NAME[1.. StringLib.stringfind(left.NAME,' ',1)]+ */left.NAME[StringLib.stringfind(left.NAME,delimiters,1)+len ..100],'');
  self.state_origin := 'MO'; 
  self.process_date := watercraft_preprocess.version; 
  self := left)); 

Watercraft.layout_mo   tnormalize(fTodRef L, integer cnt) := transform
	self.name:= choose(cnt,l.name1,l.name2); 
  self.first_name := ''; 
  self.mid := '' ; 
  self.last_name := ''; 
  self.lf := ''; 
  self := l ; 
end; 

fTodRef_norm := normalize(fTodRef, 2, tnormalize(left, counter));

//Trim and uppercase fields prior to mapping
Watercraft.Layout_MO CleanTrimRaw(fTodRef_norm L) := TRANSFORM
self.STATEABREV	:= ut.CleanSpacesAndUpper(L.STATEABREV);
self.REG_NUM	:= ut.CleanSpacesAndUpper(L.REG_NUM);
self.HULL_ID	:= ut.CleanSpacesAndUpper(L.HULL_ID);
self.PROP	:= ut.CleanSpacesAndUpper(L.PROP);
self.VEH_TYPE	:= ut.CleanSpacesAndUpper(L.VEH_TYPE);
self.FUEL	:= ut.CleanSpacesAndUpper(L.FUEL);											
self.HULL	:= ut.CleanSpacesAndUpper(L.HULL);
self.USE_1	:= ut.CleanSpacesAndUpper(L.USE_1);
tempMake	:= ut.CleanSpacesAndUpper(MAP(StringLib.StringFind(L.MAKE, '(DBA)',1) > 0 => StringLib.StringFindReplace(L.MAKE, '(DBA)',''),
																	StringLib.StringFind(L.MAKE, '\'\'',1) > 0 => StringLib.StringFindReplace(L.MAKE, '\'\'','\''),
																	L.MAKE));
self.MAKE	:= StringLib.StringCleanSpaces(tempMake);
self.TOTAL_INCH := ut.CleanSpacesAndUpper(L.TOTAL_INCH);
TempName := MAP(REGEXFIND('#|\\*$',L.NAME) => REGEXREPLACE('#|\\*$',L.NAME,''),
								REGEXFIND('(.*)/(.*)/(.*)$',L.NAME) => REGEXREPLACE('(.*)/(.*)/(.*)',L.NAME,' '),
								L.NAME);
self.NAME	:= ut.CleanSpacesAndUpper(TempName);
self.ADDRESS_1	:= ut.CleanSpacesAndUpper(IF(REGEXFIND('^[^A-Za-z0-9_]',L.ADDRESS_1), REGEXREPLACE('^[^A-Za-z0-9_]',L.ADDRESS_1,''),L.ADDRESS_1));
self.CITY				:= ut.CleanSpacesAndUpper(L.CITY);
self.STATE			:= ut.CleanSpacesAndUpper(L.STATE);
self.ZIP				:= ut.CleanSpacesAndUpper(L.ZIP);
self.MODEL_NUM	:= ut.CleanSpacesAndUpper(IF(REGEXFIND('^[^A-Za-z0-9_]',L.MODEL_NUM), REGEXREPLACE('^[^A-Za-z0-9_]',L.MODEL_NUM,''),L.MODEL_NUM));
self.TITLE			:= ut.CleanSpacesAndUpper(L.TITLE);
self.NEW_USED		:= ut.CleanSpacesAndUpper(L.NEW_USED);
self.COLOR			:= ut.CleanSpacesAndUpper(L.COLOR);
self.DEALER_NUM	:= ut.CleanSpacesAndUpper(L.DEALER_NUM);
self.LIEN_1			:= ut.CleanSpacesAndUpper(L.LIEN_1);
self.MAIL_CD_1	:= ut.CleanSpacesAndUpper(L.MAIL_CD_1);
self.STREET_1		:= ut.CleanSpacesAndUpper(IF(REGEXFIND('^[^A-Za-z0-9_]',L.STREET_1), REGEXREPLACE('^[^A-Za-z0-9_]',L.STREET_1,''),L.STREET_1));
self.CITY_1			:= ut.CleanSpacesAndUpper(L.CITY_1);
self.STATE_1		:= ut.CleanSpacesAndUpper(L.STATE_1);
self.LIEN_2			:= ut.CleanSpacesAndUpper(IF(REGEXFIND('^[^A-Za-z0-9_]',L.LIEN_2), REGEXREPLACE('^[^A-Za-z0-9_]',L.LIEN_2,''),L.LIEN_2));
self.MAIL_CD_2	:= ut.CleanSpacesAndUpper(L.MAIL_CD_2);
self.STREET_2		:= ut.CleanSpacesAndUpper(IF(REGEXFIND('^[^A-Za-z0-9_]',L.STREET_2), REGEXREPLACE('^[^A-Za-z0-9_]',L.STREET_2,''),L.STREET_2));
self.CITY_2			:= ut.CleanSpacesAndUpper(L.CITY_2);
self.STATE_2		:= ut.CleanSpacesAndUpper(L.STATE_2);
self.PRIVACY		:= ut.CleanSpacesAndUpper(L.PRIVACY);
self		:= L;
self		:= [];
END;

EXPORT file_MO_clean_in := project(fTodRef_norm,CleanTrimRaw(left));