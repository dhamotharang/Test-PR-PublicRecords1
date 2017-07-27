
// check a name against the list of names we have
EXPORT MOD_NameStats := MODULE
export BOOLEAN IsName(UNICODE nametext) := FUNCTION
namehash := HASH64((STRING)TRIM(nametext,ALL));
num:=COUNT(Datasets.dsMXNameStats(name_part_hash=namehash));
result := num > 0;
return result;
END;

export BOOLEAN IsLastName(UNICODE nametext) := FUNCTION
namehash := HASH64((STRING)TRIM(nametext,ALL));
num:=COUNT(Datasets.dsMXNameStats(name_part_hash=namehash 
	and probable_name_part in [Layouts.NamePartType.LastName,
	Layouts.NamePartType.Matronymic,
	Layouts.NamePartType.Patronymic]	));
result := num > 0;
return result;
END;

export BOOLEAN IsFirstName(UNICODE nametext) := FUNCTION
namehash := HASH64((STRING)TRIM(nametext,ALL));
num:=COUNT(Datasets.dsMXNameStats(name_part_hash=namehash 
	and probable_name_part in [Layouts.NamePartType.GivenName,
	Layouts.NamePartType.FirstName,
	Layouts.NamePartType.MiddleName1,
	Layouts.NamePartType.MiddleName2,
	Layouts.NamePartType.MiddleName3,
	Layouts.NamePartType.MiddleName4]	));
result := num > 0;
return result;
END;


export BOOLEAN HasMultipleNames(UNICODE dataIn) := FUNCTION
	result :=REGEXFIND(u'( Y COMO REPRESENTANTE DEL MENOR | E | AND | Y | ET AL)',dataIn) ;
	return result;
END;

export STRING1 GetProbableGender(UNICODE nametext) := FUNCTION
namehash := HASH64((STRING)TRIM(nametext,ALL));
result := mxd_Names.Indexes.MXNameStatsTextIDX(name_part_text=TRIM(nametext))[1].probable_gender;
return IF(result='','U',result);
END;

export INTEGER GetProbableNamePart(UNICODE nametext) := FUNCTION
namehash := HASH64((STRING)TRIM(nametext,ALL));
result := Datasets.dsMXNameStats(name_part_hash=namehash)[1].probable_name_part;
return result;
END;



export DATASET(mxd_Names.Layouts.L_MXNameStats) GenerateStats(
		DATASET(mxd_Names.Layouts.L_MXPersonNamePart) ds) := FUNCTION

dsNames :=ds(name_part_text != u'' and metaphone_id in [0,1]);

isFemale :=dsNames.probable_gender='F';
isMale :=dsNames.probable_gender='M';
tisMiddleName :=dsNames.name_part_type in [2,3,4,5];
tisFirstName := dsNames.name_part_type=1;
tisLastName := dsNames.name_part_type in [6,7,8];
isgivenName :=tisFirstName OR tisMiddleName;

totalRecs :=COUNT(dsNames);
totalFemCnt :=COUNT(dsNames(isFemale));
totalFemFNCnt :=COUNT(dsNames(isFemale and tisFirstName));
totalMaleCnt :=COUNT(dsNames(isMale));
totalMaleFNCnt :=COUNT(dsNames(isMale and tisFirstName));
totalFNCnt :=COUNT(dsNames(tisFirstName));
totalMNCnt :=COUNT(dsNames(tisMiddleName));
totalFemMNCnt :=COUNT(dsNames(isFemale and tisMiddleName));
totalMaleMNCnt :=COUNT(dsNames(isMale and tisMiddleName));
totalLNCnt :=COUNT(dsNames(tisLastName));

L_NameCalc:=RECORD
unicode60 	  name_part_text :=dsNames.name_part_text;
//Layouts.NamePartType name_part_type :=dsNames.name_part_type;
cnt := count(GROUP);
pct := count(GROUP)/totalRecs;
firstname_cnt :=count(group,tisFirstName);
middlename_cnt :=count(group,tisMiddleName);
lastname_cnt :=count(group,tisLastName);
fem_cnt :=count(group,isGivenName AND isFemale);
male_cnt :=count(group,isGivenName AND isMale);
fem_firstname_cnt :=count(group,tisFirstName AND isFemale);
male_firstname_cnt :=count(group,tisFirstName AND isMale);
fem_middlename_cnt :=count(group,tisMiddleName AND isFemale);
male_middlename_cnt :=count(group,tisMiddleName AND isMale);
firstname_itf :=LOG(totalFNCnt/(count(group,tisFirstName)));
fem_firstname_itf :=LOG(totalFemFNCnt/(count(group,tisFirstName AND isFemale)));
male_firstname_itf :=LOG(totalMaleFNCnt/(count(group,tisFirstName AND isMale)));
lastname_itf :=LOG(totalLNCnt/(count(group,tisLastName)));
middlename_itf :=LOG(totalMNCnt/(count(group,tisMiddleName)));
fem_middlename_itf :=LOG(totalFemMNCnt/(count(group,tisMiddleName AND isFemale)));
male_middlename_itf :=LOG(totalMaleMNCnt/(count(group,tisMiddleName AND isMale)));
//itf := LOG(totalRecs/count(GROUP));
//p_itf := LOG((totalRecs - count(GROUP))/count(GROUP));
END;

dsCalc :=TABLE(DISTRIBUTE(SORT(dsNames,name_part_text),HASH32(name_part_text)),L_NameCalc,name_part_text,LOCAL);

ds1 :=PROJECT(DISTRIBUTE(SORT(dsCalc, name_part_text),HASH32(name_part_text)), TRANSFORM(
mxd_Names.Layouts.L_MXNameStats,
SELF.name_part_hash :=HASH64((STRING)TRIM(LEFT.name_part_text,LEFT,RIGHT));
SELF.probable_name_part :=MAP(
	LEFT.middlename_cnt = MAX(LEFT.middlename_cnt,LEFT.firstname_cnt,LEFT.lastname_cnt) => Layouts.NamePartType.GivenName,
	LEFT.firstname_cnt = MAX(LEFT.middlename_cnt,LEFT.firstname_cnt,LEFT.lastname_cnt) => Layouts.NamePartType.GivenName,
	LEFT.lastname_cnt = MAX(LEFT.middlename_cnt,LEFT.firstname_cnt,LEFT.lastname_cnt) => Layouts.NamePartType.LastName,
	Layouts.NamePartType.UNKNOWN);
SELF.total_recs:=totalRecs;
SELF.total_fn_recs :=totalFNCnt;
SELF.total_ln_recs :=totalLNCnt;
SELF.total_mn_recs :=totalMNCnt;
SELF.total_fem_recs :=totalFemCnt;
SELF.total_male_recs :=totalMaleCnt;
SELF.metaphone := MetaphoneLib.DMetaphone1((STRING)LEFT.name_part_text);
SELF.metaphone2 := MetaphoneLib.DMetaphone2((STRING)LEFT.name_part_text);
SELF := LEFT; ),LOCAL);

ds2 :=PROJECT(DISTRIBUTE(ds1,HASH32(name_part_text)), 
	TRANSFORM(
		mxd_Names.Layouts.L_MXNameStats,
		SELF.probable_gender :=MAP(
				LEFT.probable_name_part=Layouts.NamePartType.LastName =>'',
				LEFT.probable_name_part=Layouts.NamePartType.GivenName
					AND (LEFT.fem_cnt - LEFT.male_cnt)/LEFT.fem_cnt > .09 =>'F',
				LEFT.probable_name_part=Layouts.NamePartType.GivenName 
					AND (LEFT.male_cnt - LEFT.fem_cnt)/LEFT.male_cnt > .09 =>'M',
				'U');
		SELF := LEFT; ),LOCAL);

dsStats :=SORT(ds2,-cnt);

return dsStats;

END;

END;