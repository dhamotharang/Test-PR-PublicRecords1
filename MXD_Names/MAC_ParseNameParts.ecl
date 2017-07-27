export MAC_ParseNameParts(ds,field,uid_field,includeSynonyms,normalizeMetaphones,joinYLastNames,parse_orgs,dsResult):= MACRO


#uniquename(alphans)
#uniquename(connector)
#uniquename(name)
#uniquename(possibleNames)
#uniquename(connectorregex)

 UNICODE %connectorRegex% :=  u'(ET |SAN |SANTA |LOS |DE DI |VON DER |DON |DOS |ZUM |DALLA |DE DE LOS |DE DE LA |DE LA |DE DE |DE DEL |D LA |VON |DE LE |DE S C |DE DE LA |DE A LA |A LA |DE LA DE LA |DA LA |DE SC |DEL LA |DE LAS |DE LOS |DEL LOS |DE SAN |DEL SAN |DE S |DEL PERPETUO |DE LOS TRES |DE J Y |DEL SAGRADO CORAZON DE |DEL SAGRADO |DEL NUESTRA |DE NUESTRA |DEL NIÃ‘O |DE |BAS |BEN |DEL |LES |LEZ |LA |EL |DA |DI |WIDOW OF |VIUDA )';
PATTERN %connector% :=PATTERN(u'(ET |SAN |SANTA |LOS |DE DI |VON DER |DON |DOS |ZUM |DALLA |DE DE LOS |DE DE LA |DE LA |DE DE |DE DEL |D LA |VON |DE LE |DE S C |DE DE LA |DE A LA |A LA |DE LA DE LA |DA LA |DE SC |DEL LA |DE LAS |DE LOS |DEL LOS |DE SAN |DEL SAN |DE S |DEL PERPETUO |DE LOS TRES |DE J Y |DEL SAGRADO CORAZON DE |DEL SAGRADO |DEL NUESTRA |DE NUESTRA |DEL NIÃ‘O |DE |BAS |BEN |DEL |LES |LEZ |LA |EL |DA |DI |WIDOW OF |VIUDA )');


//parse name string into words  Ã‡            Â´Ã„                                                                                                                                                                                                   
                                                         
#uniquename(alphaend)
#uniquename(alphamiddle)                                                                                                                                   
PATTERN %alphaend% :=PATTERN('[A-ZÃ‘ÃœÃƒÃšÃÃ‰Ã“ÃÃ„Ã‡]+');
PATTERN %alphamiddle% :=PATTERN('[A-ZÃ‘ÃœÃƒÃšÃÃ‰Ã“ÃÃ„Ã‡\\-\']+');

PATTERN %alphans% := %alphaend% OPT( %alphamiddle% %alphaend%) ;
//PATTERN %connector% := ['SAN ','SANTA ','LOS ','DON ','DE LA ','D LA ','DE LE ','DE S C ','DE DE LA ','DE A LA ','A LA ','DE LA DE LA ','DA LA ','DE SC ','DEL LA ','DE LAS ','DE LOS ','DEL LOS ','DE SAN ',
//'DEL SAN ','DE S ','DEL PERPETUO ','DE JESUS Y ','DE LOS TRES ','DE J Y ', 'DEL SAGRADO CORAZON DE ','DEL SAGRADO ','DEL NUESTRA ','DE NUESTRA ','DEL NIÃ‘O ','DE ','BAS ','BEN ','DEL ','LA ','EL '];

PATTERN %name% :=OPT(%connector%) %alphans%;
rule %possibleNames% := %name%;

#uniquename(ds2)
#uniquename(npt)
#uniquename(cleannpt)
#uniquename(rgx)
%ds2% := parse(ds,field, %possibleNames%, TRANSFORM(mxd_Names.Layouts.L_MXPersonNamePart,

							%npt% :=TRIM(MATCHUNICODE(%possibleNames%[1]),LEFT,RIGHT);
							%cleannpt% :=if (TRANSFER(%npt%[1],unsigned1) > 32, %npt%, u'');
							%rgx% :=TRIM(REGEXREPLACE(%connectorRegex%,%cleannpt%,u''));
									SELF.name_part_text := %cleannpt%;
									SELF.stripped_name := %rgx%;
									SELF.name_part_hash := HASH64((STRING)%cleannpt%);
									SELF.item_id := LEFT.uid_field;																		
									SELF.name_part_position:=1;
									SELF.total_parts:=1;
									SELF.name_part_type:=0;
									SELF.metaphone := MetaphoneLib.DMetaphone1((STRING)%rgx%),
									SELF.metaphone2 := MetaphoneLib.DMetaphone2((STRING)%rgx%),
									SELF.isSynonym :=0;
									SELF.name_id:=1;									
								//	SELF.totalparts := COUNTER;
									), SCAN);
#uniquename(dsWithOrgs)

%dsWithOrgs% :=JOIN(%ds2%,mxd_Common.Datasets.dsMXWords,LEFT.name_part_text =TRIM(RIGHT.word),
TRANSFORM(RECORDOF(%ds2%),
SELF.is_org:=TRUE;
SELF := LEFT;));


#uniquename(dsWithOrgs2)
%dsWithOrgs2% :=JOIN(%ds2%,%dsWithOrgs%,LEFT.item_id=RIGHT.item_id,
TRANSFORM(RECORDOF(%ds2%),
SELF.is_org := IF (RIGHT.name_part_text != u'',TRUE,FALSE);
SELF := LEFT;),LEFT OUTER, KEEP(1));


//replace abbreviations
#uniquename(dsNamesSub)
%dsNamesSub% :=PROJECT(%dsWithOrgs2%,TRANSFORM(RECORDOF(%ds2%),
token_str :=(STRING) TRIM(LEFT.name_part_text);
SELF.name_part_text := MAP(
token_str = 'MA' =>u'MARIA',
token_str = 'GUAD' =>u'GUADALUPE',
token_str = 'NTRA' =>u'NUESTRA',
token_str = 'SRA' =>u'SENORA',
token_str = 'GPE' =>u'GUADALUPE',
token_str = 'MTZ' =>u'MARTINEZ',
token_str = 'HDEZ' =>u'HERNANDEZ',
token_str = 'HERN-NDEZ' =>u'HERNANDEZ',
token_str = 'HDZ' =>u'HERNANDEZ',
token_str = 'HEZ' =>u'HERNANDEZ',
token_str = 'PEEZ' =>u'PEREZ',
token_str = 'JE' =>u'JESUS',
token_str = 'HER' =>u'HERNANDEZ',
token_str = 'MANIA' =>u'MARIA',
token_str = 'GEMELAS' =>u'',
token_str = 'GEMELOS' =>u'',
token_str = 'STA' =>u'SANTA',
token_str = 'GLEZ' =>u'GONZALEZ',
token_str = 'GLZ' =>u'GONZALEZ',
token_str = 'RDZ' =>u'RODRIGUEZ',
token_str = 'FCO' =>u'FRANCISCO',
token_str = 'GDA' =>u'GUADALUPE',
token_str = 'FRNCISCO' =>u'FRANCISCO',
token_str = 'GEMELAS' =>u'',
token_str = '-' =>u'',
token_str = ',' =>u'',
token_str = 'JR' =>u'',
token_str = 'II' =>u'',
token_str = 'III' =>u'',
token_str = 'IV' =>u'',
token_str = 'MR' =>u'',
token_str = 'LIC' =>u'',
token_str = 'LICS' =>u'',
token_str = '\'' =>u'',
LEFT.name_part_text);
SELF := LEFT;));



#uniquename(dsNameWithHash)
%dsNameWithHash% :=PROJECT(%dsNamesSub%(name_part_text!= u''),TRANSFORM(
RECORDOF(%dsNamesSub%),
SELF.name_part_hash:= HASH64((STRING)TRIM(LEFT.name_part_text));
SELF :=LEFT;));

//determine probable name and gender
#uniquename(dsNamePartTypes)
%dsNamePartTypes% :=JOIN(%dsNameWithHash% , mxd_Names.Indexes.MXNameStatsHashIDX,

LEFT.name_part_hash=RIGHT.name_part_hash,
 TRANSFORM(
RECORDOF(%dsNameWithHash% ),
SELF.probable_name_part :=MAP 
			(LEFT.name_part_text in [ u'JR',u'II',u'III',u'IV']=>mxd_Names.Layouts.NamePartType.Suffix,
			LEFT.name_part_text in [ u'MR']=>mxd_Names.Layouts.NamePartType.Title,
			RIGHT.probable_name_part);
SELF.probable_gender :=if (
			LEFT.probable_gender not in ['M','F'],RIGHT.probable_gender, LEFT.probable_gender);
SELF.term_count :=RIGHT.cnt;
SELF :=LEFT;
),LEFT OUTER);

#uniquename(ds3)
#uniquename(dsgroup)
#uniquename(dsnpgoods)
%dsnpgoods% :=SORT(%dsNamePartTypes%,probable_name_part);

#uniquename(dsnpgood)
%dsnpgood% :=%dsnpgoods%(probable_name_part not in [mxd_Names.Layouts.NamePartType.Suffix,
																									mxd_Names.Layouts.NamePartType.Title]);
#uniquename(dsnptsorted)
%dsnptsorted% :=SORT(%dsNamePartTypes%,item_id);
#uniquename(rightpnpval)

%dsgroup% := GROUP(%dsnptsorted%,item_id);
//get total name part count per name
//double-iterate is faster than creating summery table & joining back in
%ds3% := ITERATE(%dsgroup%,
						TRANSFORM(
							RECORDOF(%dsNamePartTypes%),
							npt :=RIGHT.name_part_text;
							nptnorm :=if (TRANSFER(npt[1],UNSIGNED2) < 32,u'',npt);
							SELF.name_part_position:= IF(LEFT.item_id=RIGHT.item_id, LEFT.name_part_position + 1,RIGHT.name_part_position);
							SELF.total_parts:= IF(LEFT.item_id=RIGHT.item_id, LEFT.total_parts + 1,RIGHT.total_parts);
							SELF.norm_name:= IF(LEFT.item_id=RIGHT.item_id, TRIM(LEFT.norm_name) + u' ' + nptnorm,nptnorm);
							SELF :=RIGHT;));

#uniquename(ds3b)
%ds3b% :=ITERATE(SORT(%ds3%,item_id,-total_parts),TRANSFORM(
RECORDOF(%dsNamePartTypes%),
SELF.total_parts:= IF(LEFT.item_id=RIGHT.item_id, LEFT.total_parts,RIGHT.total_parts);
SELF.norm_name:= IF(LEFT.item_id=RIGHT.item_id, LEFT.norm_name,RIGHT.norm_name);
SELF :=RIGHT;));

//determine name format, identify connectors and whether an item is a potential husband's last name
#uniquename(ds4a)
%ds4a% :=PROJECT(%ds3b%(parse_orgs=true or is_org=false),TRANSFORM(
RECORDOF(%dsNamePartTypes%),
SELF.possible_hln:= IF(LEFT.name_part_position=LEFT.total_parts and LEFT.name_part_text[1..3]=u'DE ',true,false);
SELF :=LEFT;));

#uniquename(ds4b)
%ds4b% :=ITERATE(SORT(%ds4a%,item_id,-name_part_position),TRANSFORM(
RECORDOF(%dsNamePartTypes%),
%rightpnpval% :=MAP(RIGHT.probable_name_part in [mxd_Names.Layouts.NamePartType.Suffix,
																									mxd_Names.Layouts.NamePartType.Title]=>'',
									 RIGHT.name_part_text = u''=>'',
									 RIGHT.name_part_text[1..6] in [u'WIDOW ',u'VIUDA '] => 'H',
									 RIGHT.name_part_position in [1, RIGHT.total_parts] AND RIGHT.name_part_text in [u'Y',u'E']=>'X',									 
									 RIGHT.name_part_position not in [1, RIGHT.total_parts] 
																	AND RIGHT.name_part_text in [u'Y',u'AND']=>'Y',
									 RIGHT.name_part_position not in [1, RIGHT.total_parts] 
																	AND RIGHT.name_part_text=u'ET AL'=>'E',
									 RIGHT.name_part_position between 2 AND RIGHT.total_parts-1 
																	AND RIGHT.name_part_text=u'E' 
																	AND (LEFT.name_part_text[1] IN [u'Y',u'I',u'E']
																			OR (LEFT.name_part_text[1..2] in [u'HI',u'HE'] AND LEFT.name_part_text[1..3] != u'HIE'))	=>'Y',																										
									RIGHT.probable_name_part=9 =>'F',
									RIGHT.probable_name_part=8 =>'L',
									'X');
									
SELF.name_format:= %rightpnpval%;									
SELF.name_part_text :=UnicodeLib.UnicodeFindReplace(RIGHT.name_part_text,u'(WIDOW OF |VIUDA )' ,u'');
SELF.is_connector:= IF(LEFT.item_id=RIGHT.item_id AND %rightpnpval% in ['Y','E','AND'],true,false);
SELF :=RIGHT;));


#uniquename(ds4c)
%ds4c% :=ITERATE(SORT(%ds4b%,item_id,name_part_position),TRANSFORM(
RECORDOF(%dsNamePartTypes%),
SELF.name_format:= IF(LEFT.item_id=RIGHT.item_id, TRIM(LEFT.name_format) + TRIM(RIGHT.name_format),TRIM(RIGHT.name_format));
SELF :=RIGHT;));

#uniquename(ds4d)
%ds4d% :=ITERATE(SORT(%ds4c%,item_id,-name_part_position),TRANSFORM(
RECORDOF(%dsNamePartTypes%),
SELF.name_format:= IF(LEFT.item_id=RIGHT.item_id, LEFT.name_format,RIGHT.name_format);
SELF :=RIGHT;));

#uniquename(ds4)
%ds4% :=%ds4d%;

#uniquename(dbg)

%dbg% :=RECORD
%ds4%.name_format;
grp :=COUNT(GROUP);
END;

//retrieve additional synonyms from docket synonym list
#uniquename(dsSynonyms)
%dsSynonyms% :=
	JOIN(%ds4%, mxd_Common.Datasets.DS_MXSynonymM,
			 LEFT.metaphone=RIGHT.term1M1 AND LEFT.metaphone2=RIGHT.term1M2,
			 TRANSFORM(RECORDOF(%ds4%),
								 SELF.metaphone := RIGHT.term2M1;
								 SELF.metaphone2 := RIGHT.term2M2;
								 SELF.isSynonym := 1;
								 SELF.name_part_text :=TRIM(RIGHT.term1,RIGHT) + u'/' + RIGHT.term2;
								 SELF := LEFT;),
				LOOKUP);


#uniquename(dsNotNormalizedNames)
%dsNotNormalizedNames% := if (includeSynonyms, %ds4%+%dsSynonyms%, %ds4%);

#uniquename(dsNamesNormalized)
%dsNamesNormalized% :=
	NORMALIZE(%dsNotNormalizedNames%(metaphone!=''), 2,
						TRANSFORM(RECORDOF(%dsNotNormalizedNames%),
											SELF.metaphone := IF(COUNTER=1,LEFT.metaphone,LEFT.metaphone2);											
											SELF.metaphone2 :='';
											SELF.metaphone_id := COUNTER;
											SELF := LEFT;));
											
#uniquename(dsNamesToUse)
%dsNamesToUse% := IF(normalizeMetaphones,%dsNamesNormalized%,%dsNotNormalizedNames%);

#uniquename(dsNamesToUseSorted)
%dsNamesToUseSorted% := SORT(%dsNamesToUse%,item_id,name_id,name_part_position);


//join together any 'Y' last names
#uniquename(ylast)
%ylast% :=%dsNamesToUseSorted%(name_format[LENGTH(name_format)-1]='Y'
							AND name_part_position between total_parts-2 AND total_parts
							AND Total_parts > 3);

#uniquename(ylastname)
%ylastname% :=ROLLUP(%ylast%,LEFT.item_id=RIGHT.item_id, TRANSFORM(recordof(%ylast%),
			SELF.name_part_text:=TRIM(LEFT.name_part_text) + u' ' + TRIM(RIGHT.name_part_text);
SELF := LEFT));

#uniquename(dsYFixed)
%dsYFixed% :=JOIN(%dsNamesToUse%,%ylastname%, LEFT.item_id=RIGHT.item_id, TRANSFORM(RECORDOF(%dsNamesToUse%),
			SELF.total_parts :=IF (RIGHT.item_id != 0, RIGHT.name_part_position,LEFT.total_parts);
			SELF.name_part_text:=IF (RIGHT.item_id = 0, LEFT.name_part_text,
															MAP (LEFT.name_part_position < RIGHT.name_part_position=>LEFT.name_part_text,
															LEFT.name_part_position = RIGHT.name_part_position => RIGHT.name_part_text,
															LEFT.name_part_position > RIGHT.name_part_position =>u'',
															LEFT.name_part_text));
			SELF.name_format := IF (RIGHT.item_id != 0, LEFT.name_format[1..LENGTH(LEFT.name_format)-3] + 'L', LEFT.name_format);												
			SELF := LEFT),
LEFT OUTER,LOOKUP);

#uniquename(dsYNamesToUseSorted)
%dsYNamesToUseSorted% := SORT(%dsYFixed%,item_id,name_id,name_part_position);


//join together any 'Y' last names created after the firstfix
#uniquename(ylast2)
%ylast2% :=%dsYNamesToUseSorted%(name_format[LENGTH(name_format)-1]='Y'
							AND name_part_position between total_parts-2 AND total_parts
							AND Total_parts > 3);

#uniquename(ylastname2)
%ylastname2% :=ROLLUP(%ylast%,LEFT.item_id=RIGHT.item_id, TRANSFORM(recordof(%ylast%),
			SELF.name_part_text:=TRIM(LEFT.name_part_text) + u' ' + TRIM(RIGHT.name_part_text);
SELF := LEFT));

#uniquename(dsYFixed2)
%dsYFixed2% :=JOIN(%dsYFixed%,%ylastname2%, LEFT.item_id=RIGHT.item_id, TRANSFORM(RECORDOF(%dsNamesToUse%),
			SELF.total_parts :=IF (RIGHT.item_id != 0, RIGHT.name_part_position,LEFT.total_parts);
			SELF.name_part_text:=IF (RIGHT.item_id = 0, LEFT.name_part_text,
															MAP (LEFT.name_part_position < RIGHT.name_part_position=>LEFT.name_part_text,
															LEFT.name_part_position = RIGHT.name_part_position => RIGHT.name_part_text,
															LEFT.name_part_position > RIGHT.name_part_position =>u'',
															LEFT.name_part_text));
			SELF.name_format := IF (RIGHT.item_id != 0, LEFT.name_format[1..LENGTH(LEFT.name_format)-3] + 'L', LEFT.name_format);												
			SELF := LEFT),
LEFT OUTER,LOOKUP);
#uniquename(dsremaining)
%dsRemaining% :=%dsyfixed2%(name_part_text != u'');

#uniquename(dsYNamesToUse)
//%dsYNamesToUse% := IF(joinYLastNames,%dsNextYFixed%,%dsNamesToUse%);
%dsYNamesToUse% := IF(joinYLastNames,%dsRemaining%,%dsNamesToUse%);

#uniquename(dsNamesSorted)
%dsNamesSorted% :=SORT(%dsYNamesToUse%,name_part_text,metaphone,metaphone_id,item_id,name_part_position);

#uniquename(dsNamesDeduped)
%dsNamesDeduped% := DEDUP(%dsNamesSorted%,name_part_text,metaphone,metaphone_id,item_id,name_part_position);// : PERSIST('~mxd::temp::mxBRNames');

#uniquename(dsNamesDedupedWithUnparsedOrgs)
%dsNamesDedupedWithUnparsedOrgs% := %dsNamesDeduped% + %ds3b%(is_org=true);

#uniquename(dsFinalNamesToUse)
%dsFinalNamesToUse% := IF(parse_orgs=true, %dsNamesDeduped%,%dsNamesDedupedWithUnparsedOrgs%);

dsResult :=UNGROUP(SORT(%dsFinalNamesToUse%,item_id,name_part_position));

ENDMACRO;
