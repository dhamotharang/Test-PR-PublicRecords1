IMPORT tools, wk_ut;

EXPORT _Hacks(
	STRING sModule,
	string pESP = wk_ut._Constants.LocalEsp + ':8145'
	)
:=MODULE

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//stockton-sa		
EXPORT dHACK01 := DATASET([
								{sModule,'Debug','SELF[.]Rule [:][=] c;','/*HACK01a*/',
								'		 /*BEGIN HACK01a*/\n'
+'	  nbrsOnly (string str) := REGEXREPLACE(\'[^0-9]\',str,\'\');\n'
+'    notNull  (string str) := nbrsOnly(str) <> \'\';\n'
+'		isNullx  (string str) := nbrsOnly(str) =  \'\';\n'
+'		hasMatch (string str1, string str2) := IF(ut.nowords(str2) = 1 AND length(nbrsOnly(str2)) > 1,datalib.stringfind(str1,nbrsOnly(str2),1) > 0,FALSE);\n'		
+'		isRangeNameMatch := (isNullx(le.prim_range) and notNull(ri.prim_range) and hasMatch(le.prim_name,ri.prim_range)) OR \n'
+'		                    (isNullx(ri.prim_range) and notNull(le.prim_range) and hasMatch(ri.prim_name,le.prim_range));\n'
+'		isRangeSecMatch  := (isNullx(le.prim_range) and notNull(ri.prim_range) and hasMatch(le.sec_range_num,ri.prim_range)) OR \n'
+'		                    (isNullx(ri.prim_range) and notNull(le.prim_range) and hasMatch(ri.sec_range_num,le.prim_range));\n'
+'		isSecNameMatch   := (isNullx(le.sec_range_num)  and notNull(ri.sec_range_num)  and hasMatch(le.prim_name,ri.sec_range_num))  OR \n'
+'		                    (isNullx(ri.sec_range_num)  and notNull(le.sec_range_num)  and hasMatch(ri.prim_name,le.sec_range_num));\n'
+'		isRangeNameMisMatch := (isNullx(le.prim_range)  and notNull(ri.prim_range) and isNullx(le.sec_range) and isNullx(ri.sec_range) and \n'
+'		                            notNull(le.prim_name) and datalib.stringfind(le.prim_name,nbrsOnly(ri.prim_range),1) = 0) OR\n'
+'		                       (isNullx(ri.prim_range)    and notNull(le.prim_range) and isNullx(le.sec_range) and isNullx(ri.sec_range) and \n'
+'													      notNull(ri.prim_name) and datalib.stringfind(ri.prim_name,nbrsOnly(le.prim_range),1) = 0);\n'
+'		isRangeSecMisMatch  := (isNullx(le.prim_range)        and notNull(ri.prim_range) and isNullx(nbrsOnly(le.prim_name)) and isNullx(nbrsOnly(ri.prim_name)) and\n'
+'		                            notNull(le.sec_range_num) and datalib.stringfind(le.sec_range_num,nbrsOnly(ri.prim_range),1) = 0) OR\n'
+'		                       (isNullx(ri.prim_range)        and notNull(le.prim_range) and \n'
+'													      notNull(ri.sec_range_num) and datalib.stringfind(ri.sec_range_num,nbrsOnly(le.prim_range),1) = 0);\n'
+'		isSecNameMisMatch   := (isNullx(le.sec_range_num)  and notNull(ri.sec_range_num)  and isNullx(le.prim_range) and isNullx(ri.prim_range) and\n'
+'		                            notNull(le.prim_name)  and datalib.stringfind(le.prim_name,nbrsOnly(ri.sec_range_num),1) = 0) OR\n'
+'		                       (isNullx(ri.sec_range_num)  and notNull(le.sec_range_num)  and isNullx(le.prim_range) and isNullx(ri.prim_range) and\n'
+'													      notNull(ri.prim_name)  and datalib.stringfind(ri.prim_name,nbrsOnly(le.sec_range_num),1) = 0);\n'
+'		bonus := MAP(isRangeNameMatch    or isRangeSecMatch or isSecNameMatch       =>  3,\n'
+'                 isRangeNameMisMatch or isRangeSecMisMatch or isSecNameMisMatch => -9999,\n'
+'								 0);\n'
+'    /*END HACK01a*/\n'
+'		SELF.Rule := c;','stockton'},

								{sModule,'Matches','SELF[.]Rule [:][=] c;','/*HACK01a*/',
								'		 /*BEGIN HACK01a*/\n'
+'	  nbrsOnly (string str) := REGEXREPLACE(\'[^0-9]\',str,\'\');\n'
+'    notNull  (string str) := nbrsOnly(str) <> \'\';\n'
+'		isNullx   (string str) := nbrsOnly(str) =  \'\';\n'
+'		hasMatch (string str1, string str2) := IF(ut.nowords(str2) = 1 AND length(nbrsOnly(str2)) > 1,datalib.stringfind(str1,nbrsOnly(str2),1) > 0,FALSE);\n'		
+'		isRangeNameMatch := (isNullx(le.prim_range) and notNull(ri.prim_range) and hasMatch(le.prim_name,ri.prim_range)) OR \n'
+'		                    (isNullx(ri.prim_range) and notNull(le.prim_range) and hasMatch(ri.prim_name,le.prim_range));\n'
+'		isRangeSecMatch  := (isNullx(le.prim_range) and notNull(ri.prim_range) and hasMatch(le.sec_range_num,ri.prim_range)) OR \n'
+'		                    (isNullx(ri.prim_range) and notNull(le.prim_range) and hasMatch(ri.sec_range_num,le.prim_range));\n'
+'		isSecNameMatch   := (isNullx(le.sec_range_num)  and notNull(ri.sec_range_num)  and hasMatch(le.prim_name,ri.sec_range_num))  OR \n'
+'		                    (isNullx(ri.sec_range_num)  and notNull(le.sec_range_num)  and hasMatch(ri.prim_name,le.sec_range_num));\n'
+'		isRangeNameMisMatch := (isNullx(le.prim_range) and notNull(ri.prim_range) and isNullx(le.sec_range) and isNullx(ri.sec_range) and \n'
+'		                            notNull(le.prim_name) and not datalib.stringfind(le.prim_name,nbrsOnly(ri.prim_range),1) > 0) OR\n'
+'		                       (isNullx(ri.prim_range) and notNull(le.prim_range) and isNullx(le.sec_range_num) and isNullx(ri.sec_range_num) and \n'
+'													      notNull(ri.prim_name) and not datalib.stringfind(ri.prim_name,nbrsOnly(le.prim_range),1) > 0);\n'
+'		isRangeSecMisMatch  := (isNullx(le.prim_range)        and notNull(ri.prim_range) and isNullx(nbrsOnly(le.prim_name)) and isNullx(nbrsOnly(ri.prim_name)) and\n'
+'		                            notNull(le.sec_range_num) and datalib.stringfind(le.sec_range_num,nbrsOnly(ri.prim_range),1) = 0) OR\n'
+'		                       (isNullx(ri.prim_range)        and notNull(le.prim_range) and \n'
+'													      notNull(ri.sec_range_num) and datalib.stringfind(ri.sec_range_num,nbrsOnly(le.prim_range),1) = 0);\n'
+'		isSecNameMisMatch   := (isNullx(le.sec_range_num)  and notNull(ri.sec_range_num)  and isNullx(le.prim_range) and isNullx(ri.prim_range) and\n'
+'		                            notNull(le.prim_name)  and datalib.stringfind(le.prim_name,nbrsOnly(ri.sec_range_num),1) = 0) OR\n'
+'		                       (isNullx(ri.sec_range_num)  and notNull(le.sec_range_num)  and isNullx(le.prim_range) and isNullx(ri.prim_range) and\n'
+'													      notNull(ri.prim_name)  and datalib.stringfind(ri.prim_name,nbrsOnly(le.sec_range_num),1) = 0);\n'
+'		bonus := MAP(isRangeNameMatch    or isRangeSecMatch or isSecNameMatch       =>  3,\n'
+'                 isRangeNameMisMatch or isRangeSecMisMatch or isSecNameMisMatch => -9999,\n'
+'		             le.prim_name_alpha <> \'\' and ri.prim_name_alpha = \'\' and le.prim_name_num = \'\' and ri.prim_name_num <> \'\' => -3,\n'
+'								 ri.prim_name_alpha <> \'\' and le.prim_name_alpha = \'\' and ri.prim_name_num = \'\' and le.prim_name_num <> \'\' => -3,\n'
+'								 0);'
+'    /*END HACK01a*/\n'
+'		SELF.Rule := c;','stockton'}
								],tools.layout_attribute_hacks2);

EXPORT dHACK02 := DATASET([
								{sModule,'Debug','(SELF[.]Conf [:][=])(.*?)(outside);','/*HACK01b*/',
								'$1$2$3 + bonus/*HACK01b*/;','stockton'},
								{sModule,'Matches','(iComp [:][=])(.*?)(outside);','/*HACK01b*/',
								'$1$2$3 + bonus/*HACK01b*/;','stockton'}
								],tools.layout_attribute_hacks2);


EXPORT dHACK03 := DATASET([
								{sModule,'Debug','(IMPORT SALT311,std)(;)','/*HACK01c*/',
								'$1,ut/*HACK01c*/$2','adding import ut'},
								{sModule,'Matches','(IMPORT SALT311,std)(;)','/*HACK01c*/',
								'$1,ut/*HACK01c*/$2','adding import ut'}
								],tools.layout_attribute_hacks2);
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/*-------------------------------Hack Action-------------------------------------------*/
EXPORT aHack(DATASET(Tools.Layout_attribute_hacks2) d,bSaveIt=TRUE):=Tools.HackAttribute2(d,bSaveIt,pESP).saveit;

EXPORT dAll := 
dHACK01+
dHACK02+
dHACK03;

EXPORT aHackIt := aHack(dAll);

END;