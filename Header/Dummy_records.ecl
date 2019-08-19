import std;

EXPORT Dummy_records := MODULE

SHARED today_in_ym := (unsigned3)(((STRING8)Std.Date.Today())[1..6]);

//IRS dummy data
EXPORT NonFCRAseed
	:= DATASET([
 {999999000001,999999000001,'','','','DU',199701,today_in_ym,today_in_ym,199901,200107,'','DU000001','','263124372',19600112,'MR','JOHN','','AARDVARK','','123','','MAIN','ST','','','','NEW YORK','NY','12345','1234','061','','','Y','G','','',''}
,{999999000001,999999000002,'','','','DU',198301,199612,	 199902,	 198511,199612,'','DU000001','','263124372',19600112,'MR','JOHN','','AARDVARK','','10','S','NORTH','ST','','APT','206','ANN ARBOR','MI','48103','','161','','','Y','G','','',''}
,{999999000001,999999000003,'','','','8F',199701,today_in_ym,today_in_ym,199901,200107,'','DU000001','','263124372',19600112,'MR','JOHN','','AARDVARK','','123','','MAIN','ST','','','','NEW YORK','NY','12345','1234','061','','','Y','G','','',''}
,{999999000001,999999000004,'','','','8F',198301,199612,	 199902,	 198511,199612,'','DU000001','','263124372',19600112,'MR','JOHN','','AARDVARK','','10','S','NORTH','ST','','APT','206','ANN ARBOR','MI','48103','','161','','','Y','G','','',''}

,{999999001001,999999001001,'','','','DU',199910,today_in_ym,today_in_ym,200101,200107,'','DU001001','','351762213',19750415,'',  'MARK','','MARSUPIAL','','401','N','LAZY LAKE','RD','','','','ANN ARBOR','MI','48104','','161','','','Y','G','','',''}
,{999999001001,999999001002,'','','','DU',199510,199910,     199911,     199510,199910,'','DU001001','','351762213',19750415,'',  'MARK','','MARSUPIAL','','20','N','SOUTH','ST','','APT','106','YPSILANTI','MI','48197','','161','','','Y','G','','',''}
,{999999001001,999999001003,'','','','8F',199910,today_in_ym,today_in_ym,200101,200107,'','DU001001','','351762213',19750415,'',  'MARK','','MARSUPIAL','','401','N','LAZY LAKE','RD','','','','ANN ARBOR','MI','48104','','161','','','Y','G','','',''}
,{999999001001,999999001004,'','','','8F',199510,199910,     199911,     199510,199910,'','DU001001','','351762213',19750415,'',  'MARK','','MARSUPIAL','','20','N','SOUTH','ST','','APT','106','YPSILANTI','MI','48197','','161','','','Y','G','','',''}
,{999999001001,999999001005,'','','','EQ',199510,199910,     199911,     199510,199910,'','DU001001','','351762213',19750415,'',  'MARK','','MARSUPIAL','','20','N','SOUTH','ST','','APT','106','YPSILANTI','MI','48197','','161','','','Y','G','','',''}

,{999999000012,999999000012,'','','','DU',199703,today_in_ym,today_in_ym,199901,200107,'','DU000002','','351762209',19630215,'',  'JOAN','','AARDVARK','','123','','MAIN','ST','','','','NEW YORK','NY','12345','1234','061','','','Y','G','','',''}
,{999999000012,999999000013,'','','','DU',198003,199612,	 199902,	 199001,199611,'','DU000002','','351762209',19630215,'',  'JOAN','','AARDVARK','','20','N','SOUTH','ST','','APT','108','YPSILANTI','MI','48197','','161','','','Y','G','','',''}
,{999999000012,999999000014,'','','','8F',199703,today_in_ym,today_in_ym,199901,200107,'','DU000002','','351762209',19630215,'',  'JOAN','','AARDVARK','','123','','MAIN','ST','','','','NEW YORK','NY','12345','1234','061','','','Y','G','','',''}
,{999999000012,999999000015,'','','','8F',198003,199612,	 199902,	 199001,199611,'','DU000002','','351762209',19630215,'',  'JOAN','','AARDVARK','','20','N','SOUTH','ST','','APT','108','YPSILANTI','MI','48197','','161','','','Y','G','','',''}

,{999999001012,999999001012,'','','','DU',199910,today_in_ym,today_in_ym,200101,200107,'','DU001002','','263124378',19750712,'',  'MARTIN','','MARSUPIAL','','401','N','LAZY LAKE','RD','','','','ANN ARBOR','MI','48104','','161','','','Y','G','','',''}
,{999999001012,999999001013,'','','','8F',199910,today_in_ym,today_in_ym,200101,200107,'','DU001002','','263124378',19750712,'',  'MARTIN','','MARSUPIAL','','401','N','LAZY LAKE','RD','','','','ANN ARBOR','MI','48104','','161','','','Y','G','','',''}
,{999999001013,999999001014,'','','','EN',199910,today_in_ym,today_in_ym,200101,200107,'','DU001003','','999999990',19510110,'',  'JONATHAN','','CONSUMER','','10655','N','BIRCH','ST','','','','BURBANK','CA','91502','','037','','','Y','G','','',''}
	],header.Layout_Header);

// EN/EQ test seed
EXPORT UpdateNonFCRASeedFile:=output(NonFCRAseed,,'~thor_data400::base::header::dummy',overwrite);
EXPORT FCRAseed
	:= DATASET([
 {999999000001,999999000001,'','','','EN',199701,today_in_ym,today_in_ym,199901,200107,'','DU000001','','263124372',19600112,'MR','JOHN','','AARDVARK','','123','','MAIN','ST','','','','NEW YORK','NY','12345','1234','061','','','Y','G','','',''}
,{999999000001,999999000002,'','','','EN',198301,199612,	 199902,	 198511,199612,'','DU000001','','263124372',19600112,'MR','JOHN','','AARDVARK','','10','S','NORTH','ST','','APT','206','ANN ARBOR','MI','48103','','161','','','Y','G','','',''}

,{999999000012,999999000012,'','','','EN',199703,today_in_ym,today_in_ym,199901,200107,'','DU000002','','351762209',19630215,'',  'JOAN','','AARDVARK','','123','','MAIN','ST','','','','NEW YORK','NY','12345','1234','061','','','Y','G','','',''}
,{999999000012,999999000013,'','','','EN',198003,199612,	 199902,	 199001,199611,'','DU000002','','351762209',19630215,'',  'JOAN','','AARDVARK','','20','N','SOUTH','ST','','APT','108','YPSILANTI','MI','48197','','161','','','Y','G','','',''}

,{999999001001,999999001001,'','','','EN',199910,today_in_ym,today_in_ym,200101,200107,'','DU001001','','351762213',19750415,'',  'MARK','','MARSUPIAL','','401','N','LAZY LAKE','RD','','','','ANN ARBOR','MI','48104','','161','','','Y','G','','',''}
,{999999001001,999999001002,'','','','EN',199510,199910,     199911,     199510,199910,'','DU001001','','351762213',19750415,'',  'MARK','','MARSUPIAL','','20','N','SOUTH','ST','','APT','106','YPSILANTI','MI','48197','','161','','','Y','G','','',''}
,{999999001001,999999001003,'','','','EQ',199510,199910,     199911,     199510,199910,'','DU001001','','351762213',19750415,'',  'MARK','','MARSUPIAL','','20','N','SOUTH','ST','','APT','106','YPSILANTI','MI','48197','','161','','','Y','G','','',''}

,{999999001012,999999001012,'','','','EN',199910,today_in_ym,today_in_ym,200101,200107,'','DU001002','','263124378',19750712,'',  'MARTIN','','MARSUPIAL','','401','N','LAZY LAKE','RD','','','','ANN ARBOR','MI','48104','','161','','','Y','G','','',''}
	],header.Layout_Header);

EXPORT UpdateFCRASeedFile:=output(NonFCRAseed,,'~thor_data400::base::fcra_header::dummy',overwrite);
EXPORT MAIN:=SEQUENTIAL(output(NonFCRAseed),output(FCRAseed)/*);//*/,UpdateNonFCRASeedFile,UpdateFCRASeedFile); // */
END;