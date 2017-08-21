import watercraft, watercraft_preprocess, ut, lib_StringLib;

fIn_raw := watercraft_preprocess.Files_raw.KY;

InvalidData := ['NO S/N','NOS/N','N/S/N','UNK','UNKNOWN','UNKN','*NONE*','NONE','NA ','0 ','UNKOWN','OP','NONE OP','NONE AFFADAVIT','N/A'];

//Trim and uppercase fields prior to mapping
Watercraft.layout_ky_infolink CleanTrimRaw(fIn_raw L) := TRANSFORM
self.STATEABREV	:= ut.CleanSpacesAndUpper(L.STATEABREV);
self.REG_NUM	:= ut.CleanSpacesAndUpper(L.REG_NUM);
ClnHullID	:= MAP(trim(L.HULL_ID,left,right)in InvalidData => '',
								StringLib.StringFind(L.HULL_ID,'S/N',1) = 1 => trim(L.HULL_ID,left,right)[4..],
								L.HULL_ID);
self.HULL_ID	:= ut.CleanSpacesAndUpper(ClnHullID);
self.PROP	:= ut.CleanSpacesAndUpper(L.PROP);
self.VEH_TYPE	:= ut.CleanSpacesAndUpper(L.VEH_TYPE);
self.FUEL	:= ut.CleanSpacesAndUpper(L.FUEL);											
self.HULL	:= ut.CleanSpacesAndUpper(L.HULL);
self.USE	:= ut.CleanSpacesAndUpper(L.USE);
tempMake	:= ut.CleanSpacesAndUpper(MAP(LENGTH(TRIM(L.MAKE,LEFT,RIGHT))=1 AND StringLib.StringFind(L.MAKE,'-',1) > 0 => StringLib.StringFindReplace(L.MAKE,'-',''),
																	StringLib.StringFind(L.MAKE, '(DBA)',1) > 0 => StringLib.StringFindReplace(L.MAKE, '(DBA)',''),
																	StringLib.StringFind(L.MAKE, '\'\'',1) > 0 => StringLib.StringFindReplace(L.MAKE, '\'\'','\''),
																	L.MAKE));
self.MAKE	:= StringLib.StringCleanSpaces(tempMake);

FilterDash	:= ut.CleanSpacesAndUpper(StringLib.StringFilterOut(L.FNAME,'-'));
FilterPeriod := StringLib.StringFilterOut(FilterDash,'.');
RmvOR	:= StringLib.StringCleanSpaces(MAP(REGEXFIND('(OR)',FilterPeriod)=> StringLib.StringFindReplace(FilterPeriod,'(OR)','OR'),
																				REGEXFIND('& OR$',TRIM(FilterPeriod,left,right))=> REGEXREPLACE(FilterPeriod,'& OR',' '),
																				REGEXFIND(' AND OR$',TRIM(FilterPeriod,left,right))=> REGEXREPLACE(FilterPeriod,' AND OR$',' '),
																				REGEXFIND(' OR$',TRIM(FilterPeriod,left,right))=> StringLib.StringFindReplace(FilterPeriod,' OR',' '),FilterPeriod));

ClnLname	:= StringLib.StringCleanSpaces(ut.CleanSpacesAndUpper(L.LNAME));
TempLname	:= IF(StringLib.StringFind(ClnLname,'-OR-',1)>0, StringLib.StringFindReplace(ClnLname,'-OR-',''),
									IF(REGEXFIND(', OR$',ClnLname), REGEXREPLACE(', OR$',ClnLname,''), ClnLname));
TempName		:= Watercraft_preprocess.fn_concat_name_KY(RmvOR,L.MNAME,TempLname); //Concat names in order to handle business names and multiple names
self.NAME		:= ut.CleanSpacesAndUpper(TempName);
self.FNAME	:= ut.CleanSpacesAndUpper(L.FNAME);
self.MNAME	:= ut.CleanSpacesAndUpper(L.MNAME);
self.LNAME	:= ut.CleanSpacesAndUpper(L.LNAME);
ClnPunctAddr		:= ut.CleanSpacesAndUpper(StringLib.StringFindReplace(L.ADDRESS,'`',''));
self.ADDRESS	:= MAP(REGEXFIND('P O |P.O. |P. O. ',ClnPunctAddr) => REGEXREPLACE('P O |P.O. |P. O. ',ClnPunctAddr,'PO '),
												REGEXFIND('^BOX ',ClnPunctAddr) => REGEXREPLACE('^BOX ',ClnPunctAddr,'PO BOX '),
												ClnPunctAddr);
self.CITY	:= ut.CleanSpacesAndUpper(IF(REGEXFIND('#203/|,|;',L.CITY),REGEXREPLACE('#203/|,|;',L.CITY,''),L.CITY));
self.STATE	:= ut.CleanSpacesAndUpper(REGEXREPLACE('[^A-Z0-9]',L.STATE,''));
self.SEX	:= ut.CleanSpacesAndUpper(L.SEX);
ClnModel	:= MAP(trim(L.MODEL,left,right) in InvalidData => '',
									REGEXFIND('^0+',L.MODEL) => StringLib.StringFindReplace(L.MODEL,'0',''),
									REGEXFIND('^-+',L.MODEL) => REGEXREPLACE('^-+',L.MODEL,''),
									StringLib.StringFind(L.MODEL,'.',1) > 0 => StringLib.StringFindReplace(L.MODEL,'.',''),
									StringLib.StringFind(L.MODEL,'/',1) > 0 => StringLib.StringFindReplace(L.MODEL,'/',''),
									StringLib.StringFind(L.MODEL,'YYY ',1) > 0 => StringLib.StringFindReplace(L.MODEL,'YYY ',''),
									L.MODEL);
self.MODEL	:= ut.CleanSpacesAndUpper(ClnModel);
self	:= L;
END;

EXPORT file_KY_clean_in := project(fIn_raw,CleanTrimRaw(left));