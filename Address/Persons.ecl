export Persons := MODULE

import lib_stringlib, _Control, ut, NID, LIB_Word, Data_Services; //IDL_Header, 

rec := RECORD
	string20	name;
END;                                                                                                       

shared dataland := '~thor40_241::';	//		'~thor40_241::;	//'~thor200_144::';
shared cluster :=  IF(Thorlib.Daliservers()='10.173.231.12:7070',data_services.data_location.prefix() + 'thor_data400::',IF(_Control.ThisEnvironment.name='Dataland', dataland,'~thor_data400::'));
//shared cluster :=  IF(_Control.ThisEnvironment.name='Dataland', '~thor400_88::', '~thor_data400::');

export filename_fnames		:= cluster + 'base::nid::firstnames';
//export filename_fnames_supp	:= cluster + 'base::nid::firstnames_supp';
export filename_lnames		:= cluster + 'base::nid::lastnames';

/*
file_fnames_supp := PROJECT(DATASET(filename_fnames_supp, {string20 name}, CSV),
								TRANSFORM(Address.FirstNames.layout_name_count,
									SELF.name := LEFT.name,
									SELF := []));
*/
/* export file_lnames := DISTRIBUTE(
   							DATASET(filename_lnames,FirstNames.layout_name_count, FLAT)
   												(LENGTH(TRIM(name)) > 1, pct_lname > 0.15, name <> 'AND'),
   							HASH32(name));
   
   							//+ IDL_Header.Common_Misspellings_DS
   export file_fnames := DEDUP(SORT(DISTRIBUTE(
   							DATASET(filename_fnames, FirstNames.layout_name_count, FLAT)(pct_fname > 0.15)
   							+ Address.FirstNames.xtranames
   							+ file_lnames(pct_fname > 0.25),
   							HASH32(name)),
   						name, LOCAL), name, LOCAL);
*/
//export file_fnames := DATASET(filename_fnames, FirstNames.layout_name_count, FLAT) 
//							+ Address.FirstNames.xtranames;
export file_lnames := DATASET(filename_lnames,FirstNames.layout_name_count, FLAT)
							(LENGTH(TRIM(name)) > 1, pct_lname > 0.15, name <> 'AND');
export file_fnames := DATASET(filename_fnames, FirstNames.layout_name_count, FLAT)(pct_fname > 0.15)
							+ FirstNames.xtranames
							+ file_lnames(pct_fname > 0.25);
					


fnames := SET(file_fnames, name);	
//export boolean IsFirstName(string name) := IF(name='', false, name in fnames);
SET OF STRING32 firstnames := TokenManagement.SortAndTerminateSet(fnames);	
export boolean IsFirstName(string name) := 
		Nicknames.IsNickName(name) OR
		TokenManagement.FindToken(firstnames, name)
		OR Nid.PreferredNameExists(name) OR IndianNames.IsIndianName(name)
		OR ArabicNames.IsArabicName(name) OR hebrewNames.IsHebrewName(name);
//export SET OF STRING32 businesswords := Address.TokenManagement.SortAndTerminateSet(
//			SET(PROJECT(Address.WordTokens(rule=2),bxform(LEFT)), phrase));// : GLOBAL;

girls := file_fnames(Length(TRIM(name)) > 1, (female_cnt*100)/(male_cnt+female_cnt) > 50);
boys := file_fnames(Length(TRIM(name)) > 1, (male_cnt*100)/(male_cnt+female_cnt) > 50);

SET OF STRING32 femaleNames := TokenManagement.SortAndTerminateSet(SET(girls,name));	
SET OF STRING32 maleNames := TokenManagement.SortAndTerminateSet(SET(boys,name));

SET of STRING1 genders := 
['U', // unknown
 'M', // male
 'F', // female
 'N'  // either
];
export string1 gender(string name) := FUNCTION
// 0: unknown  1: male  2: female  3: either
	n := MAP(
		LENGTH(name) = 1 => 3,
		TRIM(name) = '' => 0,
		IF(Nicknames.IsMaleName(name) OR
			TokenManagement.FindToken(maleNames, name) OR
			IndianNames.IsIndianBoysName(name) OR
			ArabicNames.IsArabicBoysName(name) OR
			HebrewNames.IsHebrewBoysName(name) 
			,1, 0) 
				+
		IF(Nicknames.IsFemaleName(name) OR
			TokenManagement.FindToken(femaleNames, name) OR
			IndianNames.IsIndianGirlsName(name) OR
			ArabicNames.IsArabicGirlsName(name) OR
			HebrewNames.IsHebrewGirlsName(name)
			, 2, 0)
		);

    RETURN CASE(n,
		1 => 'M',
		2 => 'F',
		IF(LENGTH(name) > 1, datalib.gender(name),
			genders[n+1])
	);
END;

export string1 genderEx(string fnamex, string mnamex) := FUNCTION
	fname := TRIM(fnamex);
	mname := TRIM(mnamex);
	g := gender(fname);
	return IF (g in ['M','F'],g, gender(mname));
END;

lonly := JOIN(file_lnames, CensusSurnames, LEFT.name=RIGHT.name, 
			TRANSFORM({string32	name}, SELF.name := LEFT.name),
			LEFT ONLY);


census := TABLE(CensusSurnames,{string32	name := CensusSurnames.name});

//lnames := SET(file_lnames, name);	// : GLOBAL;
lnames := SET(census + lonly, name) + ['VERSANT'];	// : GLOBAL;

SET OF STRING32 lastnames := TokenManagement.SortAndTerminateSet(lnames);	
export boolean IsLastName(string name) := TokenManagement.FindToken(lastnames, name);

set of STRING32 cnames := TokenManagement.SortAndTerminateSet(SET(CensusSurnames,name));
export boolean isCensusName(string name) := TokenManagement.FindToken(cnames, name);

export boolean HasLastName(string s) := EXISTS(
	WordSplit(s)(IsLastName(word)));	// AND NOT EXISTS(WordSplit(s)(word in fnames));
//	WordSplit(s)(word in lnames));	// AND NOT EXISTS(WordSplit(s)(word in fnames));


// determine if the string is layed out like a personal name.
/* boolean IsPersonalFormat(string s) := FUNCTION
   	rgx := '^[A-Z]+[, ]+[A-Z]+( [A-Z]+)?( (JR|SR|II|III))?$';
   	return REGEXFIND(rgx, s);
   END;
*/

//shared rgxBasic := '([A-Z]+|[A-Z][.]?)';
shared rgxBasic := '([A-Z]+)';
shared rgxBasicX := '([A-Z]+-?[A-Z]*)';
shared rgxFirst := '([A-Z-]+)';
shared rgxLast := '(DI |DA |DEL |DE LA |DE LOS |DES |DE |DELLA |DELLO |DOS |DU |LA |MC |VON |VAN DER |VAN |VANDER |ST |EL |LE |[ODANL]\')?([A-Z]+[A-Z\'-]+)';
//shared rgxLast := '(DI |DA |DEL |DE LA |DE LOS |DES |DE |DELLA |DELLO |DOS |VON |VAN DER |VAN |VANDER |ST |EL |[ODANL]\')?([A-Z][A-Z-]+)';
shared rgxLastStrong := '(DI |DA |DEL |DE LA |DELA |DE LOS |DES |DE |DELLA |DOS |DU |LA |MC |MAC |VON |VAN DER |VAN DEN |VAN |VANDER |ST |EL |LE |[ODANL]\'|A-|ABU-EL-|VAN-DEN-)([A-Z][A-Z-]+)';
shared rgxLastOrInitial := '(DI |DA |DEL |DES |DE LA |DE LOS |DE |DELLA |DELLO |DOS |DU |MC |VON |VAN DER |VAN |VANDER |ST |EL |LE |[ODANL]\'|A-|ABU-EL-|VAN-DEN-)?([A-Z][A-Z-]*)';
shared rgxGen := '(JR|SR|I|II|III|IV|V|VI|2ND|3RD|4TH|5TH|6TH)';
shared rgxSureGen := '(JR|SR|II|III|IV|2ND|3RD|4TH|5TH|6TH)';
shared rgxHonor := 
 '(MD|DMD|DDS|CPA|DR|PHD|ESQ|RN|LN|DO|DC|DPM|DPC|DD|LMT|DVM|PSYD|ASID|CLU|JD|OD|CFP|AA|NP|ARNP|MSW|LCSW|LSW|ACSW|LMHC|LMFT|CMT|LPCC|MA)';
shared rgxSuffix := '(' + rgxGen + '|' + rgxHonor + ')';
shared rgxSureSuffix := '(' + rgxSureGen + '|' + rgxHonor + ')';
shared rgxTitles := '(MR|MRS|MISS|MS|DR|REV|SHRF)';
shared rgxConnector := 	'( AND |&| OR | AND/OR |&/OR |\\+)';
shared rgxInitial := '[A-Z][.]?';
shared rgxHyphenated := '([A-Z]+(-[A-Z-]+)?)';

shared rgxFL := '^' + rgxBasic + ' +('  + rgxLastStrong + ')$';
shared rgxFLhL := '^' + rgxBasic + ' +(([A-Z]{2,})-([A-Z]{2,}))$';
shared rgxLF := '^(' + rgxLastStrong + ') +' + rgxBasic + '$';
shared rgxLFM := '^(' + rgxLastStrong + ') +' + rgxBasic + ' +([A-Z]+)$';
shared rgxFLoLF := '^' + rgxHyphenated + ' +' + rgxHyphenated + '$';
shared rgxFLcS := '^' + rgxBasic + ' +('  + rgxLast + ') *, *' + rgxSuffix + '$';
shared rgxFLS := '^' + rgxBasic + ' +('  + rgxLastStrong + ') +' + rgxSuffix + '$';
shared rgxFLSorLFS := '^' + rgxBasic + ' +'  + rgxBasic + ' +' + rgxSuffix + '$';
//shared rgxFiMiL := '^(' + rgxInitial + ')[ ]+(' + rgxInitial + ')?[ ]*(' + rgxLast + ')$';
shared rgxLFi := '^(' + rgxLast + ') +(' +  rgxInitial+ ')$';
shared rgxLFiS := '^(' + rgxLast + ') +([A-Z]) +' + rgxSureSuffix + '$';
shared rgxFiL := '^(' + rgxInitial + ') +(' + rgxLast + ')$';
shared rgxFiLS := '^(' + rgxInitial + ') +(' + rgxLast + ') +' + rgxSuffix + '$';
shared rgxFiML := '^(' + rgxInitial + ') +([A-Z]+) +(' + rgxLast + ')$';
shared rgxFiMLS := '^(' + rgxInitial + ') +([A-Z]+) +(' + rgxLast + ') +' + rgxSuffix + '$';

shared rgxFLL := '^' + rgxBasic + ' +('  + rgxLastStrong + ')' + ' +('  + rgxLast +  ')$';
shared rgxFMLL := '^' + rgxBasic + ' +([A-Z]+) +('  + rgxLast + ')' + ' +('  + rgxLast +  ')$';
shared rgxFMLLS := '^' + rgxBasic + ' +([A-Z]+) +('  + rgxLast + ')' + ' +('  + rgxLast + ') +' + rgxSuffix +  '$';
shared rgxFMML := '^' + rgxBasic + ' +([A-Z]+) +[A-Z]+ +('  + rgxLast +  ')$';
shared rgxFMiMiL := '^' + rgxBasic + ' +([A-Z]) +[A-Z] +('  + rgxLast +  ')$';
shared rgxLFMiM := '^' + rgxBasic + ' +([A-Z]+) +([A-Z]) +'  + rgxBasic +  '$';
shared rgxFMMLS := '^' + rgxBasic + ' +([A-Z]+) +[A-Z]+ +('  + rgxLast +  ') +' + rgxSuffix + '$';

shared rgxLFcMi := '^(' + rgxLast + ') +([A-Z]+) *, *([A-Z])$';

shared rgxFMLorLFM := '^(' + rgxLastOrInitial + ') +([A-Z-]+) +([A-Z]+|(' + rgxLast + '))$'; 
shared rgxFML := '^([A-Z\'-]+) +([A-Z-]+) +([A-Z]+|(' + rgxLast + '))$'; 

//shared rgxFMLS := '^(' + rgxBasic + ')[ ]+(' + rgxBasic + '[ ]+)?' + rgxLast + '[ ]+' + rgxSuffix + '$';
shared rgxFMLS := '^' + rgxBasic + ' +' + rgxBasic + ' +(' + rgxLast + ') +' + rgxSuffix + '$';
shared rgxFMLcS := '^' + rgxBasic + ' +' + rgxBasic + ' +(' + rgxLast + ') *, *' + rgxSuffix + '$';
shared rgxLFMicS := '^(' + rgxLast + ') +' + rgxBasic + ' +([A-Z]) *, *' + rgxSuffix + '$';

//shared rgxLFS := '^(' + rgxLast + ') +' + rgxBasic + ' +' + rgxSureGen + '$';
shared rgxLFMS := '^(' + rgxLast + ') +' + rgxBasic + ' +' + rgxBasic + ' +' + rgxSuffix + '$';

// dual F M & F M L
shared rgxFMaFML := '^([A-Z]+) +([A-Z]+) *' + rgxConnector + 
					' *([A-Z]+) +([A-Z]+ +)?(' + rgxLast + ')$';
// dual F M & F L S
shared rgxFMaFLS := '^([A-Z]+) +([A-Z]+) *' + rgxConnector + 
					' *([A-Z]+) +(' + rgxLast + ') +' + rgxSuffix + '$';
// dual L F & F M S
shared rgxLFaFMS := '^(' + rgxLast + ') +([A-Z]+) *' + rgxConnector + 
					' *([A-Z]+) +([A-Z]+) +' + rgxSuffix + '$';

// dual L F & F
shared rgxLFaF := '^(' + rgxLast + ') +' + rgxBasicX + ' *' + rgxConnector + ' *' + rgxHyphenated + '$';
shared rgxLFiaFiL := '^' + rgxBasic + ' +([A-Z]) *' + rgxConnector + ' *([A-Z]) +' + rgxBasic + '$';
shared rgxLFiaFi := '^(' + rgxLast + ') +([A-Z]) *' + rgxConnector + ' *' + '([A-Z])$';
shared rgxLFiMiaFiMi := '^(' + rgxLast + ') +([A-Z]) +([A-Z]) *' + rgxConnector + 
					' *' + '([A-Z]) +([A-Z])$';
// dual L F & F M
shared rgxLFaFM := '^(' + rgxLast + ') +' + rgxBasic + ' *' + rgxConnector + ' *' + rgxBasic + ' +' + rgxBasic + '$';
shared rgxFMiaFL := '^' + rgxBasic + ' +([A-Z]) *' + rgxConnector + ' *' + rgxBasic + ' +(' + rgxLast + ')$';


shared rgxLFMaFML := 
'^(' + rgxLast + ') +' + '([A-Z]+) +([A-Z]+ )?'+ rgxConnector + ' *([A-Z]+) +([A-Z]+ )?\\1$';
shared rgxFMLaFML := 
'^' + rgxBasic + ' +' + '([A-Z]+) +(' + rgxLast + ') *'+ rgxConnector + ' *([A-Z]+) +([A-Z]+) +\\3$';
shared rgxFMLcFML := 
'^' + rgxBasic + ' +' + '([A-Z]+) +(' + rgxLast + ') *, *([A-Z]+) +([A-Z]+) +([A-Z]+)$';
shared rgxLFMaLFM := 
'^(' + rgxLast + ') +' + '([A-Z]+) +([A-Z]+) *'+ rgxConnector + ' *\\1 +([A-Z]+) +([A-Z]+)$';
shared rgxLFMaLFM2 := 	// unique last names
'^(' + rgxLast + ') +' + '([A-Z]+) +([A-Z]+) *'+ rgxConnector + ' *([A-Z]+) +([A-Z]+) +([A-Z]+)$';
shared rgxFMLSaFML := 
'^' + rgxBasic + ' +' + '([A-Z]+) +(' + rgxLast + ') +' + rgxGen + ' *'+ rgxConnector +
	' *([A-Z]+) +([A-Z]+) +([A-Z]+)$';


shared rgxLcFMM :=
'^(' + rgxLast + ') *, *([A-Z]+) +(([A-Z]+) +([A-Z]+))$';

shared rgxLFMi := '^(' + rgxLast + ') +([A-Z]+) +([A-Z])$';

shared rgxLFMMi :=
'^(' + rgxLast + ') +([A-Z]+) +([A-Z]+) +([A-Z])$';

shared rgxLFMiS := 
'^(' + rgxLast + ') +' + rgxBasic + ' +([A-Z]),? +' + rgxSuffix + '$';


shared rgxLcFaF := '^(' + rgxLast + ') *, *([A-Z]+) *' + rgxConnector + ' *([A-Z][A-Z-]*)$';
shared rgxLcFaFM := '^(' + rgxLast + ') *, *([A-Z]+) *' + rgxConnector + ' *([A-Z][A-Z-]*) +([A-Z]+)( +[A-Z]+)?$';

shared rgxFMLaFM := 
		'^' + rgxBasic + ' +([A-Z]+) +(' + rgxLast + ') *'+ rgxConnector + 
	/* name 2*/	' *([A-Z]+)( +[A-Z]+)?$';
shared rgxFMLaFL := 
		'^' + rgxBasic + ' +([A-Z]+) +(' + rgxLast + ') *'+ rgxConnector + 
	/* name 2*/	' *([A-Z]+) +\\3?$';
shared rgxFMiSaFL := 
		'^' + rgxBasic + ' +([A-Z]) +' + rgxGen + ' *'+ rgxConnector + 
	/* name 2*/	' *([A-Z]+) +(' + rgxLast + ')$';
shared rgxLFiSaI := 
		'^(' + rgxLast + ') +([A-Z]) +' + rgxGen + ' *'+ rgxConnector + 
	/* name 2*/	' *([A-Z])$';
shared rgxLSFaFM := 
		'^(' + rgxLast + ') +' + rgxSureGen + ' +' + rgxBasic + ' *' + rgxConnector + 
	/* name 2*/	' *([A-Z]+)( +[A-Z]+)?$';
shared rgxLSFMaFM := 
		'^(' + rgxLast + ') +' + rgxSureGen + ' +' + rgxBasic + ' +' + rgxBasic + ' *' + rgxConnector + 
	/* name 2*/	' *([A-Z]+)( +[A-Z]+)?$';
shared rgxFLSaFM := 
		'^' + rgxBasic + ' +(' + rgxLast + ') +' + rgxSureGen + ' *' + rgxConnector + 
	/* name 2*/	' *([A-Z]+)( +[A-Z]+)?$';
shared rgxFaFML := 
		'^' + rgxBasic + ' *'+ rgxConnector + 
	/* name 2*/	' *([A-Z]+) +([A-Z]+) +(' + rgxLast + ')$';
shared rgxFiaFiL := 
		'^([A-Z]) *'+ rgxConnector + 
	/* name 2*/	' *([A-Z]) +(' + rgxLast + ')$';
shared rgxFaFL := 
		'^' + rgxBasic + ' *'+ rgxConnector + 
	/* name 2*/	' *([A-Z]+) +(' + rgxLast + ')$';
shared rgxLFMiaFM := 
		'^(' + rgxLast + ') +([A-Z]+) +([A-Z]) *'+ rgxConnector + 
	/* name 2*/	' *([A-Z]+)( +[A-Z]+)?$';
shared rgxLFMiaFMiL := 
		'^(' + rgxLast + ') +([A-Z]+) +([A-Z]) *'+ rgxConnector + 
	/* name 2*/	' *([A-Z]+) +([A-Z]) +(' + rgxLast + ')$';
shared rgxLcFMaFMM := 
		'^(' + rgxLast + ') *, *' + '([A-Z]+) +([A-Z]+) *'+ rgxConnector + 
	/* name 2*/	' *([A-Z]+) +([A-Z]+)( +[A-Z]+)?$';
shared rgxLcFMaF := 
		'^(' + rgxLast + ') *, *' + '([A-Z]+) +([A-Z]+) *'+ rgxConnector + 
	/* name 2*/	' *([A-Z]+)$';
shared rgxLcFMaFMS := 
		'^(' + rgxLast + ') *, *' + '([A-Z]+) +([A-Z]+) *'+ rgxConnector + 
	/* name 2*/	' *([A-Z]+) +([A-Z]+) +' + rgxSuffix + '$';

shared rgxLcFMSaFMM := 
'^(' + rgxLast + '), *([A-Z]+) +([A-Z]+) +' + rgxGen + ' *' + rgxConnector +
	/* 2nd name */			' *([A-Z]+)( +[A-Z]+)?( +[A-Z]+)?$';
shared rgxLFMSaFMM := 
'^(' + rgxLast + ') +([A-Z]+) +([A-Z]+) +' + rgxSuffix + ' *' + rgxConnector +
	/* 2nd name */			' *([A-Z]+)( +[A-Z]+)?( +[A-Z]+)?$';
shared rgxLcFMaLcFM := 
'^(' + rgxLast + '), *([A-Z]+) +([A-Z]+) *' + rgxConnector +
	/* 2nd name */			' *(' + rgxLast + '), *([A-Z]+) *([A-Z]+)$';
shared rgxLcFaLcF := 
'^(' + rgxLast + '), *([A-Z]+) *' + rgxConnector +
	/* 2nd name */			' *(' + rgxLast + '), *([A-Z]+)$';

shared rgxLcF := 
'^(' + rgxLast + ') *, *' + rgxBasic + '$';
shared rgxLcFS := 
'^(' + rgxLast + ') *, *' + rgxBasic + ' +' + rgxSureSuffix + '$';
shared rgxLcFMS	:=
'^(' + rgxLast + ') *, *' + rgxBasic + ' +' + rgxBasic + ' +' + rgxSuffix + '$';
shared rgxLcFM	:=
'^(' + rgxLast + ') *, *' + rgxFirst + ' +' + rgxBasic + '$';

shared rgxLcTF := 
'^(' + rgxLast + ') *, *' + rgxTitles + ' +' + rgxBasic +'$';


//shared rgxLLcFM := '^([A-Z]+) +([A-Z]{2,}) *, *([A-Z]+)( +[A-Z]+)?$';
shared rgxLLcFM := '^(' + rgxLast + ') +(' + rgxLast+ ') *, *([A-Z]+)( +[A-Z]+)?$';
shared rgxLLcFS := '^(' + rgxLast + ') +(' + rgxLast+ ') *, *([A-Z]+) +' + rgxSureSuffix + '?$';

shared rgxLcFhF := 		// hyphenated first name (Taiwanese or Hong Kong style)
'^([A-Z]+) *, *([A-Z]+-[A-Z]+)$';

shared rgxLScFM := '^(' + rgxLast + ') +' + rgxSuffix + ' *, *'  + rgxBasic + ' +' + rgxBasic + '$';
shared rgxLSFM := '^(' + rgxLast + ') +' + rgxSureGen + ' +'  + rgxBasic + ' +' + rgxBasic + '$';
shared rgxLScF := '^(' + rgxLast + ') +' + rgxGen + ' *, *'  + rgxBasic + '$';
shared rgxLScFMM := '^(' + rgxLast + ') +' + rgxSuffix + ' *, *'  + rgxBasic + ' +([A-Z]+ +[A-Z]+)$';

shared rgxFMiL := '^' + rgxBasic + ' +([A-Z]) +('  + rgxLast + ')$';
shared rgxFMiLI := '^' + rgxBasic + ' +([A-Z]) +('  + rgxLast + ') +[A-Z]$';
shared rgxFMiLS := '^' + rgxBasic + ' +([A-Z]) +('  + rgxLast + ') +' + rgxSuffix + '$';

// Fx L L	extended Spanish names: 'MARIA DE JESUS GARCIA LOPEZ';
//shared rgxFxLL := '^([A-Z]+ +DE +[A-Z]+) +[A-Z]+ +([A-Z]+)$';
shared rgxFxLL := '^([A-Z]+ +(DE LA|DE LOS|DE) +[A-Z]+) +[A-Z]{2,} +([A-Z]{2,})$';
shared rgxFxL := '^([A-Z]+ +(DE LA|DE LOS|DE) +[A-Z]+) +([A-Z]+)$';
shared rgxFxLS := '^([A-Z]+ +(DE LA|DE LOS|DE) +[A-Z]+) +([A-Z]+) +' + rgxSuffix + '$';
shared rgxLxFM := '^([A-Z]+ +(DE LA|DE LOS|DE) +[A-Z]+) +' + rgxBasic + ' +([A-Z]+)$';

shared rgxSpanishLName1 := '([A-Z]+ +(DE LA|DE LOS|DE) +[A-Z]+)';

// Fi I I L
shared rgxFiIIL := '^([A-Z]) +[A-Z] +[A-Z] +(' + rgxLast + ')$';

// S F L
shared rgxSFL := '^' + rgxSureGen + ' +' + rgxBasic + ' +(' + rgxLast + ')$';
// F S L
shared rgxFSL := '^' + rgxBasic + ' +' + rgxSureGen + ' +(' + rgxLast + ')$';

// Spanish style name (LOPEZ Y PEREZ)
shared rgxFMLyL := '^([A-Z]+) *([A-Z]+)? +(([A-Z]{3,}) +Y +([A-Z]{3,}))$';

// Special case: MR and MRS
shared rgxMrMrs := '\\b((MR|DR) (&|AND)? (MRS))\\b';

// comma separated names
shared rgxLcFMcS := 	// LcFMS
'^(' + rgxLast + ') *, *' + rgxBasic + ' +' + rgxBasic + ' *, *' + rgxSuffix + '$';
shared rgxLcFcS := 		// LcFcS
'^(' + rgxLast + ') *, *' + rgxBasic + ' *, *' + rgxSureGen + '$';
shared rgxLcFcM := 		// LcFcM
'^(' + rgxLast + ') *, *' + rgxBasic + ' *, *' + rgxBasic + '$';
shared rgxLcFcMS := 	// LcFcMS
'^(' + rgxLast + ') *, *' + rgxBasic + ' *, *' + rgxBasic + ' +' + rgxSuffix + '$';
shared rgxLcScF := 	// LcScF
'^(' + rgxLast + ') *, *' + rgxSuffix + ' *, *'  + rgxBasic + '$';
shared rgxLcScFM := 	// LScFM
'^(' + rgxLast + ') *, *' + rgxSuffix + ' *, *'  + rgxBasic + ' +' + rgxBasic + '$';

// special
shared rgxLLaL := '^(' + rgxLast + ') +(' + rgxLast + ') *' + rgxConnector + ' *(' + rgxLast + ')$';

		
export NameFormat := ENUM(integer2, NoName=0,
	// single name formats
		FL, LF, LFM, FLorLF, FLcS, FLS, FLSorLFS, LFMi, FML, FMLorLFM, FMLSorLFMS, FMLcS, LFMS, LcFMS, LScF,
		LScFM, LScFMM, LSFM, FMLLS, LcFMM, LFMMi,
		FiL, FiML, FiMLS, FiLS, FLL, FMLL, FMML, FMiMiL, LFMiM, FMMLS, LFcMi, LcF, LcFS, LcFM, LcTF, LFMiS, LFi, LFiS,
		LLcFM, LLcFS, LcFhF, FMiL, FMiLS, FMiLI, FiIIL, FxLL, FxL, FxLS, LxFM, SFL, FSL, FMLyL,
		LFMicS, LcFMcS, LcFcM, LcFcMS, LcFcS, LcScF, LcScFM,
	// dual name formats
		LFaF, LFiaFi, LFiaFiL, LFiMiaFiMi, LFaFM, FMiaFL, FMLaFM, FMLaFL, FMiSaFL, LFiSaI, LSFaFM, LSFMaFM, FLSaFM, LFMiaFM,
		LcFMaF, LcFMaFMM, LcFMaFMS, LFMaFML, FMLaFML, FMLcFML, LFMaLFM, LFMaLFM2, FMaFML, FMaFLS, LFaFMS, FaFL, FiaFiL,
		FaFML, LcFaF, LcFaFM, LcFMSaFMM, LFMSaFMM, LcFaLcF, LcFMaLcFM, FMLSaFML, LFMiaFMiL, MrMrs
		);

// search order is important
// based on most common formats first
// some are order dependent
shared SingleNameFormat(string s) := MAP(
		// S F L  
		REGEXFIND(rgxSFL, s) => NameFormat.SFL,
		// F S L  
		REGEXFIND(rgxFSL, s) => NameFormat.FSL,
		// L Fi S
		REGEXFIND(rgxLFiS, s) => NameFormat.LFiS,
		// F Mi L S		
		REGEXFIND(rgxFMiLS, s) => NameFormat.FMiLS,
		// F Mi L
		REGEXFIND(rgxFMiL, s) => NameFormat.FMiL,
		// F Mi L
		REGEXFIND(rgxFMiLI, s) => NameFormat.FMiLI,
		// Fi L
		REGEXFIND(rgxFiL, s) => NameFormat.FiL,
		// L Fi
		REGEXFIND(rgxLFi, s) => NameFormat.LFi,
		// F L or L F
		REGEXFIND(rgxFLoLF, s) => NameFormat.FLorLF,
		//REGEXFIND('^[A-Z][\']?[A-Z][A-Z/-]+ +[A-Z][\']?[A-Z/-]*$', s, NOCASE) => NameFormat.FLorLF,
		// F L
		REGEXFIND(rgxFL, s) => NameFormat.FL,
		// L F
		REGEXFIND(rgxLF, s) => NameFormat.LF,
		// L F M
		REGEXFIND(rgxLFM, s) => NameFormat.LFM,
		// Fi L S
		REGEXFIND(rgxFiLS, s) => NameFormat.FiLS,
		// Fi M L S
		REGEXFIND(rgxFiMLS, s) => NameFormat.FiMLS,
		// Fi M L
		REGEXFIND(rgxFiML, s) => NameFormat.FiML,
		
		// F L S
		REGEXFIND(rgxFLcS, s) => NameFormat.FLcS,
		// L F Mi
		REGEXFIND(rgxLFMi, s) => NameFormat.LFMi,
		// F L S or L F S
		REGEXFIND(rgxFLSorLFS, s) => NameFormat.FLSorLFS,
		// L F Mi S
		REGEXFIND(rgxLFMiS, s) => NameFormat.LFMiS,
		// F L S
		REGEXFIND(rgxFLS, s) => NameFormat.FLS,
		// F L L
		REGEXFIND(rgxFLL, s) => NameFormat.FLL,
		// F M L S or L F M S
		REGEXFIND(rgxFMLS, s) => NameFormat.FMLSorLFMS,
		// L F Mi, S 
		REGEXFIND(rgxLFMicS, s) => NameFormat.LFMicS,
		// F M L, S rgxLFMicS
		REGEXFIND(rgxFMLcS, s) => NameFormat.FMLcS,
		// F M L or L F M
		REGEXFIND(rgxFMLorLFM, s) => NameFormat.FMLorLFM,
		// F Mi Mi L
		REGEXFIND(rgxFMiMiL, s) => NameFormat.FMiMiL,
		// L F Mi M
		REGEXFIND(rgxLFMiM, s) => NameFormat.LFMiM,
		// F M L L
		REGEXFIND(rgxFMLL, s) => NameFormat.FMLL,
		// Fi I I L
		REGEXFIND(rgxFiIIL, s) => NameFormat.FiIIL,
		// F M L y L (Spanish style) 
		REGEXFIND(rgxFMLyL,s,NOCASE) => NameFormat.FMLyL,
		// F M M L
		REGEXFIND(rgxFMML, s) => NameFormat.FMML,
		// F M M L S
		REGEXFIND(rgxFMMLS, s) => NameFormat.FMMLS,


		// L F M S
		REGEXFIND(rgxLFMS, s) => NameFormat.LFMS,

		// L S F M
		REGEXFIND(rgxLSFM, s) => NameFormat.LSFM,
		// L S, F M
		REGEXFIND(rgxLScFM, s) => NameFormat.LScFM,
		// L S, F M M
		REGEXFIND(rgxLScFMM, s) => NameFormat.LScFMM,
		// L S, F
		REGEXFIND(rgxLScF, s) => NameFormat.LScF,

		// F M L L (S)
		REGEXFIND(rgxFMLLS, s) => NameFormat.FMLLS,
		// L F M Mi
		REGEXFIND(rgxLFMMi, s) => NameFormat.LFMMi,
		// L, F
		REGEXFIND(rgxLcF, s) => NameFormat.LcF,
		// L, F S
		REGEXFIND(rgxLcFS, s) => NameFormat.LcFS,
		// L, F M S
		REGEXFIND(rgxLcFMS, s, NOCASE) => NameFormat.LcFMS,
		// L, T F
		REGEXFIND(rgxLcTF, s, NOCASE) => NameFormat.LcTF,
		// L, F M
		REGEXFIND(rgxLcFM, s, NOCASE) => NameFormat.LcFM,
		// L, F M M	
		REGEXFIND(rgxLcFMM, s) => NameFormat.LcFMM,
		// L F, Mi
		REGEXFIND(rgxLFcMi, s) => NameFormat.LFcMi,
		// L L, F M
		REGEXFIND(rgxLLcFS, s) => NameFormat.LLcFS,
		// L L, F M
		REGEXFIND(rgxLLcFM, s) => NameFormat.LLcFM,
		// L, F-F
		REGEXFIND(rgxLcFhF, s) => NameFormat.LcFhF,
		// FxL  
		REGEXFIND(rgxFxL, s) => NameFormat.FxL,
		// Fx L S  
		REGEXFIND(rgxFxLS, s) => NameFormat.FxLS,
		// FxL L 
		REGEXFIND(rgxFxLL, s) => NameFormat.FxLL,
		// L, F M, S
		REGEXFIND(rgxLcFMcS, s) => NameFormat.LcFMcS,
		// L, S, F 
		REGEXFIND(rgxLcScF, s) => NameFormat.LcScF,
		// L, S, F M
		REGEXFIND(rgxLcScFM, s) => NameFormat.LcScFM,
		// L, F, S
		REGEXFIND(rgxLcFcS, s) => NameFormat.LcFcS,
		// L, F, M
		REGEXFIND(rgxLcFcM, s) => NameFormat.LcFcM,
		// L, F, M S
		REGEXFIND(rgxLcFcMS, s) => NameFormat.LcFcMS,
		// Lx F M  
		REGEXFIND(rgxLxFM, s) => NameFormat.LxFM,
		// F M L 
		REGEXFIND(rgxFML, s) => NameFormat.FML,
		
		NameFormat.NoName
	);


		// *** DUAL NAMES
shared DualNameFormat(string s) := MAP(
		// L Fi & Fi
		REGEXFIND(rgxLFiaFi, s) => NameFormat.LFiaFi,
		// L Fi & Fi L
		REGEXFIND(rgxLFiaFiL, s) => NameFormat.LFiaFiL,
		// L F & F
		REGEXFIND(rgxLFaF, s) => NameFormat.LFaF,
		// L Fi Mi & Fi Mi
		REGEXFIND(rgxLFiMiaFiMi, s) => NameFormat.LFiMiaFiMi,
		// F Mi & F L
		REGEXFIND(rgxFMiaFL, s) => NameFormat.FMiaFL,
		// L F & F M
		REGEXFIND(rgxLFaFM, s, NOCASE) => NameFormat.LFaFM,
		// L F (M) & F (M) L	(dual)
		REGEXFIND(rgxLFMaFML, s, NOCASE) => NameFormat.LFMaFML,
		// L F M & L F M	(dual)
		REGEXFIND(rgxLFMaLFM, s, NOCASE) => NameFormat.LFMaLFM,
		// F M L & F M L	(dual)
		REGEXFIND(rgxFMLaFML, s, NOCASE) => NameFormat.FMLaFML,
		// F M L S & F M L	(dual)
		REGEXFIND(rgxLFMaLFM2, s) => NameFormat.LFMaLFM2,
		// F M L & F M L	(dual)
		REGEXFIND(rgxFMLSaFML, s, NOCASE) => NameFormat.FMLSaFML,
		// F M L & F M L	(dual)
		REGEXFIND(rgxLFMaFML, s, NOCASE) => NameFormat.LFMaFML,
		// L F Mi & F (M)	(dual)
		REGEXFIND(rgxLFMiaFM, s, NOCASE) => NameFormat.LFMiaFM,
		// F L S & F (M)	(dual)
		REGEXFIND(rgxFLSaFM, s, NOCASE) => NameFormat.FLSaFM,
		// L S F & F (M)	(dual)
		REGEXFIND(rgxLSFaFM, s, NOCASE) => NameFormat.LSFaFM,
		// L S F & F (M)	(dual)
		REGEXFIND(rgxLSFMaFM, s, NOCASE) => NameFormat.LSFMaFM,
		// L Fi S & Fi		(dual)
		REGEXFIND(rgxLFiSaI, s) => NameFormat.LFiSaI,
		// F Mi S & F L	(dual)
		REGEXFIND(rgxFMiSaFL, s) => NameFormat.FMiSaFL,
		// F M L & F L	(dual)
		REGEXFIND(rgxFMLaFL, s) => NameFormat.FMLaFL,
		// F M L & F (M)	(dual)
		REGEXFIND(rgxFMLaFM, s, NOCASE) => NameFormat.FMLaFM,
		// L F (M) & F M S	(dual)
		REGEXFIND(rgxLcFMaFMS, s, NOCASE) => NameFormat.LcFMaFMS,
		// L F (M) & F 	(dual)
		REGEXFIND(rgxLcFMaF, s, NOCASE) => NameFormat.LcFMaF,
		// L F (M) & F (M) (M)	(dual)
		REGEXFIND(rgxLcFMaFMM, s, NOCASE) => NameFormat.LcFMaFMM,
		// F M & F L S	(dual)
		REGEXFIND(rgxFMaFLS, s) => NameFormat.FMaFLS,		          
		// F M & F M L	(dual)
		REGEXFIND(rgxLFaFMS, s) => NameFormat.LFaFMS,		          
		// F M & F M L	(dual)
		REGEXFIND(rgxFMaFML, s, NOCASE) => NameFormat.FMaFML,		          
		//REGEXFIND('^[A-Z]+([ ]+[A-Z]+[ ]*)?&[ ]*[A-Z]+[ ]+([A-Z]+[ ]+)?[A-Z][\']?[A-Z-]+$', s, NOCASE) => NameFormat.FMaFML,		          
		// F & F M L	(dual)
		//REGEXFIND('^[A-Z]+([ ]+AND[ ]+|[ ]*&[ ]*|[ ]+OR[ ]+)[A-Z]+[ ]+([A-Z]+[ ]+)?[A-Z][\']?[A-Z-]+$', s, NOCASE)
		// Fi & Fi L
		REGEXFIND(rgxFiaFiL, s) => NameFormat.FiaFiL,
		// F & F L
		REGEXFIND(rgxFaFL, s) => NameFormat.FaFL,
		// F & F M L
		REGEXFIND(rgxFaFML, s) => NameFormat.FaFML,		          
		// L, F M S & F M (M)
		REGEXFIND(rgxLcFMSaFMM, s, NOCASE) => NameFormat.LcFMSaFMM,
		//REGEXFIND(rgxLast + ',[ ]?[A-Z]+ [A-Z]+[ ]+' + rgxGen + '[ ]*&[ ]*[A-Z]+([ ]+[A-Z]+)?([ ]+[A-Z]+)?$', s, NOCASE) => NameFormat.LcFMSaFMM,
		// L F M S & F M
		REGEXFIND(rgxLFMSaFMM, s, NOCASE) => NameFormat.LFMSaFMM,
		// L, F & F
		REGEXFIND(rgxLcFaF, s, NOCASE) => NameFormat.LcFaF,
		// L, F & F M (M)
		REGEXFIND(rgxLcFaFM, s, NOCASE) => NameFormat.LcFaFM,
		// L F Mi & F (M)	(dual)
		REGEXFIND(rgxLFMiaFMiL, s, NOCASE) => NameFormat.LFMiaFMiL,
		// F M L, F M L	(dual)
		REGEXFIND(rgxFMLcFML, s) => NameFormat.FMLcFML,
		// L, F & L, F
		REGEXFIND(rgxLcFaLcF, s) => NameFormat.LcFaLcF,
		// L, F M & L, F M
		REGEXFIND(rgxLcFMaLcFM, s, NOCASE) => NameFormat.LcFMaLcFM,
		// MR & MRS
		//REGEXFIND(rgxMrMrs, s) AND
		//	SingleNameFormat(REGEXREPLACE(rgxMrMrs, s, '')) != NameFormat.NoName
		//		=> NameFormat.MrMrs,
		NameFormat.NoName
	);
	

	
// determine name format so we know location of first name
// supports hyphenated last name and period after middle name
export PersonalNameFormat(string s) := 
	//IF(REGEXFIND('([ ]+AND[ ]+|[ ]*&[ ]*)', s, NOCASE), DualNameFormat(s), SingleNameFormat(s));
	//IF(REGEXFIND(rgxConnector, s), DualNameFormat(s), SingleNameFormat(s));
	MAP(
		REGEXFIND(rgxConnector, s) => DualNameFormat(s),
		REGEXFIND(rgxFMLcFML, s) => NameFormat.FMLcFML,
		SingleNameFormat(s)
	);
	

export boolean IsDualNameFormat(string s) := PersonalNameFormat(s) >= NameFormat.LFaF;
export boolean IsNameFormatDual(integer2 n) := (n >= NameFormat.LFaF);
export boolean validPersonNameFormat(integer2 n) := (n != NameFormat.NoName) AND (NOT IsNameFormatDual(n));


export IsSuffix(string name) := REGEXFIND('^'+rgxSuffix+'$',name);
export HasSuffix(string name) := REGEXFIND(rgxFMLS,name) OR REGEXFIND(rgxFLSorLFS,name);

export IsGeneration(string name) := 
	name IN ['JR','SR','I','II','III','IV','V','VI'];
export IsSureGen(string name) := 
	name IN ['JR','SR','II','III','IV','VI'];

// determine if name may be multi-part last name
export boolean IsLastNameOnly(string name) := RegexFind('^' + rgxLastStrong + '$', name);
export boolean IsJustLastName(string name) := 
	IF(RegexFind('^' + rgxLastStrong + '$', name),
		NOT IsFirstName(RegexFind('^([A-Z]+) +', name, 1)),
		false);
		
shared boolean InvalidLastName(string name) := MAP(
	Length(name) < 2 => true,
	//REGEXFIND('^'+rgxSuffix+'$',name) => true,		// don't consider suffixes as last names
	IsSuffix(name) => true,
	REGEXFIND('^[A-Z]-[A-Z]$',name) => true,		// A-B
	name in ['NMN','NMI'] => true,
	false
	);

// likely last name
export boolean IsLastNameEx(string name) := MAP(
	Length(name) < 2 => false,
	IsSuffix(name) => false,
	//IsCensusName(name) => true,
	IsLastName(name) => true,
	IsLastNameOnly(name) => true,
	SpanishNames.IsSpanishSurname(name) => true,
	IndianNames.IsIndianSurname(name) => true,
	ArabicNames.IsArabicSurname(name) => true,
	REGEXFIND('[A-Z]+(WITZ|WICZ|WISCH|SKI|SKY|TZKY|VICH|VITCH|VICZ|VITZ|STEIN|STEAD|STAD|FELD|BACH|MAN|MANN|DOLPH|IAK|OV|ROFF|DORF|LIEB|HAUSEN|EVA|OVA|KAYA|ACK|TZKY|ZYK|RECHT|SCHLING|CHUK|ENKO|SHKIN|EK)$',name) => true,	// east european endings
	//StringLib.StringFind(name, '-', 1) > 0 => true,		// look for hyphen
	REGEXFIND('[A-Z](OPOULOS|ELLIS|IDIS|IADIS|OUDAS|OUKAS|AKIS|OUSIS|SIOS|KONIS|OTIS|ATOS|ITIS)$',name) => true,	// greek endings
	REGEXFIND('^(KARA|PAPA|KONDO|SCHN|STEIN)[A-Z]{2,}$',name) => true,		// greek & otherprefixes
	REGEXFIND('[A-Z](SON|SEN|FIELD|SHIRE|BERG|BERRY|BERY|BURG|BURY|CROFT|NESS|WELL|ELLS|LAND|WARD|FORD|BODY|DALE|OY|ER|TOM|TRY|ARTON|SHAW|DOTTIR|IAMS)$',name)
						AND NOT IsFirstName(name) => true,		// anglo endings
	REGEXFIND('[A-Z](SWAMY|NKA|OOD|UZ|MURTI|MADI|REVA|REZA|ERJEE|ARJUNA|YAMA|IAN|TULLA)$',name) => true,				// asian endings
	REGEXFIND('[B-DF-HJ-NP-TVWXZ](EZ|ES|IZ)$',name) => true,	// possible spanish name
	REGEXFIND('[B-DF-HJ-NP-TVWXZ](ITO|ELLI|ANO|ONA|TINI|ACCI|ETTO|COLA|ENZO|ENTO|ETTI|AGNI|ISTA|UCCI|UZZO|DELLA)$',name) AND NOT IsFirstName(name) => true,	// possible italian name
	REGEXFIND('[B-DF-HJ-NP-TVWXZ]{5,}',name) => true,	// 5 consecutive consonants
	name[1] = 'O' AND IsLastName(name[2..]) => true,
	IsLastName(REGEXFIND('^(O|DU|VAN|DE)([A-Z]{2,})$',name,2)) => true,
	//name[1..2] = 'MC' AND IsLastName(name[3..]) => true,
	REGEXFIND('^(MAC|MC)[A-Z]{2,}$',name) => true,		// scottish prefixes
	//REGEXFIND('[B-DF-HJ-NP-TVWXZ](A|E|I|O)$',name) AND NOT IsFirstName(name) => true,	// possible name ending
	REGEXFIND('^[A-Z]-[A-Z]$',name) => false,		// A-B
	REGEXFIND(rgxSpanishLName1, name) => true,
	false);

shared rgxHyphenatedname := '^([A-Z]\'?[A-Z]+)-([A-Z]\'?[A-Z]+)$';

shared boolean ProbableFirstName(string name) :=
	IsFirstName(name) AND NOT IsLastName(name);
	
	
export boolean ExclusiveLastName(string name) :=
	IsLastNameEx(name) AND NOT IsFirstName(name);
	
shared boolean IsLastNameHyphenated(string name) := REGEXFIND(rgxHyphenatedname, name);
shared boolean IsLastNameExOrHyphenated(string name) := 
	IsLastNameEx(name) OR IsLastNameHyphenated(name);
export boolean ProbableLastName(string name) :=
	IsLastNameExOrHyphenated(name) OR NOT IsFirstName(name);
	
export boolean IsLastNameConfirmed(string name) := MAP(
	Length(name) < 2 => false,
	REGEXFIND('^'+rgxSuffix+'$',name) => false,			// don't consider suffixes as last names
	IsLastNameEx(name) => true,
	IsLastNameOnly(name) => true,
	IsLastNameHyphenated(name) => true,
	//**StringLib.StringFind(name, '-', 1) > 0 => IsLastNameEx(REGEXFIND(rgxHyphenatedname, name, 1)) OR IsLastNameEx(REGEXFIND(rgxHyphenatedname, name, 2)),		
	//IsFirstname(name) => false,
	false);

shared boolean RepeatedLetters(string name) :=
	REGEXFIND('\\b([A-Z])\\1{2,}\\b', name);
	
shared rgxLastReversed := 	// VAN DELA DOS LE
	'^([A-Z]+) +(DI|DA|DEL|DES|DE|DU|LA|MC|VON|ST|EL)$';
export boolean InvalidNameFormat(string name) := MAP(
	REGEXFIND('^[A-Z]+ +(JR|SR|NMN|NMI|II|III|IV)$', name)	=> true,	// NAME JR
	REGEXFIND('^[A-Z] +[A-Z] +(JR|SR|I|II|III|IV|V)$', name)	=> true,	// NAME JR
	REGEXFIND('^(JR|SR|MC|ST) +[A-Z]+$', name)	=> true,	// JR NAME
	REGEXFIND('\\b(JR|SR) +(JR|SR)$', name)	=> true,	// JR JR
	REGEXFIND('\\b[B-DF-HJ-NP-TVWXZ]+Q\\b', name) => true,
	REGEXFIND('\\b[B-DF-HJ-NP-TVWXZ]{4,}\\b', name) => NOT REGEXFIND('\\b' + rgxHonor + '\\b', name),
	REGEXFIND(rgxLastReversed, name) => true,
	REGEXFIND('^[A-Z]+ +[A-Z]* *[A-Z]+[0-9][A-Z]+$',name) => true,	// embedded numeral
	REGEXFIND('^[A-Z] +[A-Z]$', name) => true,	// A B
	REGEXFIND('^[A-Z] +[A-Z] +[A-Z]$', name) => true,	// A B C
	REGEXFIND('\\b([B-HJ-Z])\\1{2,}\\b', name) => true,	// XXX (except AAA and III)
	REGEXFIND('^([A-Z]+) \\1$', name) => true,	// DURAN DURAN
	REGEXFIND('\\b[A-Z]-[A-Z]\b', name) => true,	// A-B
	REGEXFIND('\\b[A-Z]+-[A-Z] ', name) => 
						NOT IsFirstName(REGEXFIND('\\b([A-Z]+-[A-Z]) ', name, 1)),		// GARCIA-R
	REGEXFIND('\\bAND\\b', name)	=> true,	// ends with "AND"
	REGEXFIND('^OR\\b', name)	=> true,	// begins with "OR"
	REGEXFIND('^COOKIE +[A-Z]* +MONSTER$', name)	=> true,	// 
	REGEXFIND('^I LIKE +[A-Z]*\\b', name)	=> true,	// 
	REGEXFIND('\\b(PT|LT|FT|TE|DL)\\b',name) => true,  // unprocessed abbreviations
	//REGEXFIND(rgxLFi, name) => IsFirstName(REGEXFIND(rgxLFi, name, 1)) 
	//			AND NOT IsLastNameExOrHyphenated(REGEXFIND(rgxLFi, name, 1)),
					// MARY X
	false);
		
shared string NameOrGen(string rgx, string s, integer2 pos, boolean getgen) := FUNCTION
		name := TRIM(REGEXFIND(rgx, s, pos, NOCASE),LEFT,RIGHT);
		RETURN IF (getgen, IF(IsSureGen(name),name,''),
							IF(IsSureGen(name),'',name));
END;


// accepts only Mr and Mrs F M L S
/*shared boolean IsSingleName(string s) := FUNCTION
	n := PersonalNameFormat(s);
	return CASE (n,
			1 => 	IsFirstName(REGEXFIND(rgx, s, 1, NOCASE)),
			2 =>	true,
			3 => 	IsFirstName(REGEXFIND(rgx, s, 1, NOCASE)),			
			4 => 	IsFirstName(REGEXFIND(rgx, s, 1, NOCASE)),
			7 => 	IsFirstName(REGEXFIND(rgx, s, 1, NOCASE)),
			false);
END;
*/

export Name_Rec := RECORD
		string80	fullname;
		string1		nameType;
		string10	nameFormat;
		string5		cln_title;
		string20	cln_fname;
		string20	cln_mname;
		string20	cln_lname;
		string5		cln_suffix;
		string5		cln_honor;
		integer2	rating;
		string5		cln_title2;
		string20	cln_fname2;
		string20	cln_mname2;
		string20	cln_lname2;
		string5		cln_suffix2;
		string5		cln_honor2;
		integer2	rating2;
		string10	modifier;
END;

DATASET(Name_Rec) ExtractNames(string rgx, string s, integer4 fpos, integer4 lpos, posA=0) := FUNCTION
	name1 := REGEXFIND(rgx, s, fpos);		// likely first name
	name2 := IF(posA > 0, REGEXFIND(rgx, s, posA), '');	// alternate first name
	name3 := IF(lpos = posA, name2, REGEXFIND(rgx, s, lpos));	// likely last name
	n := MAP(
				IsFirstName(name1) => 1,
				IsFirstName(name2) => 2,
				IsLastName(name3) => 4,
				0
			);
	fname := CASE(n,
				0 => name1,
				1 => name1,
				2 => name2,
				4 => name1,
				name1
			);
	lname := CASE(n,
				0 => name3,
				1 => name3,
				2 => name1,
				4 => name3,
				name3
			);
	
	r := DATASET([{s,'P','','',fname,'',lname,'','',n,'','','','','','',0,''}], Name_Rec );
	return r;
END;


export string16 WhichFormat(NameFormat n) := CASE(n,
			NameFormat.NoName =>	'',
			NameFormat.FL =>		'FL',
			NameFormat.LF =>		'LF',
			NameFormat.FLorLF => 	'FLorLF',
			NameFormat.FLcS =>		'FLcS',
			NameFormat.FLS =>		'FLS',
			NameFormat.FLSorLFS =>	'FLSorLFS',
			NameFormat.FLL =>		'FLL',
			NameFormat.FxL =>		'FxL',
			NameFormat.FxLS =>		'FxLS',
			NameFormat.LxFM	=>		'LxFM',
			NameFormat.FxLL =>		'FxLL',
			NameFormat.FMLL =>		'FMLL',
			NameFormat.FMiMiL =>	'FMiMiL',
			NameFormat.LFMiM =>		'LFMiM',
			NameFormat.FMML =>		'FMML',
			NameFormat.FMMLS =>		'FMMLS',
			NameFormat.LFMi =>		'LFMi',
			NameFormat.LFM =>		'LFM',
			NameFormat.FMLorLFM => 	'FMLorLFM',
			NameFormat.FML => 		'FML',
			NameFormat.FMLSorLFMS => 'FMLSorLFMS',
			NameFormat.LFMicS =>	'LFMicS',
			NameFormat.FMLcS => 	'FMLcS',
			NameFormat.LcFMS => 	'LcFMS',
			NameFormat.LFMiS =>	 	'LFMiS',
			NameFormat.LFMS =>	 	'LFMS',
			NameFormat.LScF => 		'LScF',
			NameFormat.LSFM =>	 	'LSFM',
			NameFormat.LScFM => 	'LScFM',
			NameFormat.LScFMM => 	'LScFMM',
			NameFormat.FMLLS => 	'FMLLS',
			NameFormat.LcFMM => 	'LcFMM',
			NameFormat.LFMMi => 	'LFMMi',
			//NameFormat.FiMiL =>		'FiMiL',
			NameFormat.LFi =>		'LFi',
			NameFormat.LFiS =>		'LFiS',
			NameFormat.FiL =>		'FiL',
			NameFormat.FiML =>		'FiML',
			NameFormat.FiLS =>		'FiLS',
			NameFormat.FiMLS =>		'FiMLS',
			NameFormat.FMiL =>		'FMiL',
			NameFormat.FMiLS =>		'FMiLS',
			NameFormat.FMiLI =>		'FMiLI',
			NameFormat.LFcMi =>		'LFcMi',
			NameFormat.LcF =>		'LcF',
			NameFormat.LcTF =>		'LcTF',
			NameFormat.LcFM =>		'LcFM',
			NameFormat.LcFS =>		'LcFS',
			NameFormat.LLcFM =>		'LLcFM',
			NameFormat.LLcFS =>		'LLcFS',
			NameFormat.LcFhF =>		'LcFhF',
			NameFormat.FiIIL =>		'FiIIL',
			NameFormat.SFL =>		'SFL',
			NameFormat.FSL =>		'FSL',
			NameFormat.FMLyL =>		'FMLyL',
			NameFormat.LcFMcS =>	'LcFMcS',
			NameFormat.LcFcM =>		'LcFcM',
			NameFormat.LcFcMS =>	'LcFcMS',
			NameFormat.LcFcS =>		'LcFcS',
			NameFormat.LcScF =>		'LcScF',
			NameFormat.LcScFM =>	'LcScFM',
			
			// Dual Names
			NameFormat.LFaF =>		'LFaF',
			NameFormat.LFiaFi =>	'LFiaFi',
			NameFormat.LFiaFiL =>	'LFiaFiL',
			NameFormat.LFiMiaFiMi =>'LFiMiaFiMi',
			NameFormat.FMiaFL => 	'FMiaFL',
			NameFormat.LFaFM =>		'LFaFM',
			NameFormat.LFMaFML =>	'LFMaFML',
			NameFormat.LFMiaFM =>	'LFMiaFM',
			NameFormat.LFMiaFMiL =>	'LFMiaFMiL',
			NameFormat.FLSaFM =>	'FLSaFM',
			NameFormat.LSFaFM =>	'LSFaFM',
			NameFormat.LSFMaFM =>	'LSFMaFM',
			NameFormat.FMLaFML =>	'FMLaFML',
			NameFormat.FMLcFML =>	'FMLcFML',
			NameFormat.FMLSaFML =>	'FMLSaFML',
			NameFormat.LFMaLFM =>	'LFMaLFM',
			NameFormat.LFMaLFM2 =>	'LFMaLFM2',
			NameFormat.LFiSaI =>	'LFiSaI',
			NameFormat.FMiSaFL =>	'FMiSaFL',
			NameFormat.FMLaFL =>	'FMLaFL',
			NameFormat.FMLaFM =>	'FMLaFM',
			NameFormat.LcFMaFMS =>	'LcFMaFMS',
			NameFormat.LcFMaF =>	'LcFMaF',
			NameFormat.LcFMaFMM =>	'LcFMaFMM',
			NameFormat.FMaFLS =>	'FMaFLS',
			NameFormat.FMaFML =>	'FMaFML',
			NameFormat.LFaFMS =>	'LFaFMS',
			NameFormat.FiaFiL =>	'FiaFiL',
			NameFormat.FaFL =>		'FaFL',
			NameFormat.FaFML =>		'FaFML',
			NameFormat.LcFMSaFMM =>	'LcFMSaFMM',
			NameFormat.LFMSaFMM =>	'LFMSaFMM',
			NameFormat.LcFaF =>		'LcFaF',
			NameFormat.LcFaFM =>	'LcFaFM',
			NameFormat.LcFMaLcFM =>	'LcFMaLcFM',
			NameFormat.LcFaLcF =>	'LcFaLcF',
			NameFormat.MrMrs =>	'MrMrs',
			'X' + (string)n
		);

shared string GetWord(string s, integer2 n) := FUNCTION
	ds := WordSplit(s);
	return TRIM(ds[n].word);
END;


shared rgxHyphenatedSimplename := '^([A-Z]+)-([A-Z]+)$';
shared boolean IsFirstNameOrHyphenated(string name) := 
	IsFirstName(name) OR
		(REGEXFIND(rgxHyphenatedSimplename, name) AND 
			IsFirstName(REGEXFIND(rgxHyphenatedSimplename, name, 1)) AND
			IsFirstName(REGEXFIND(rgxHyphenatedSimplename, name, 2))
			);
		
/*	IF(IsLastNameEx(name), true,
		IF(REGEXFIND(rgxHyphenatedname, name),
			IsLastNameEx(REGEXFIND(rgxHyphenatedname, name, 1)) OR
			IsLastNameEx(REGEXFIND(rgxHyphenatedname, name, 2)),
		false));*/
shared boolean IsLastNameOnlyOrHyphenated(string name) := 
	IsLastNameOnly(name) OR
		IsLastNameHyphenated(name);
		
//shared boolean IsNickName(string name) :=
//	IF(TRIM(Nid.PreferredFirstNew(name)) = name, false, true);
shared boolean IsNickName(string name) := NOT IsLastNameEx(name);
shared boolean IsNoFirstLastNameExOrHyphenated(string name) := 
	IsLastNameEx(name) OR
		((REGEXFIND(rgxHyphenatedname, name) OR LENGTH(name) > 10)AND NOT IsFirstName(name) );
	
export string4 ValidateNames(string rgx, string s, integer2 posf1, integer2 posf2, 
													integer2 posl1, integer2 posl2) := FUNCTION
	fname := REGEXFIND(rgx, s, posf1);		// likely first name
	afname := REGEXFIND(rgx, s, posf2);		// alternate first name
	lname := REGEXFIND(rgx, s, posl1);		// likely last name
	alname := REGEXFIND(rgx, s, posl2);		// alternate last name

	RETURN 
		IF(IsFirstNameOrHyphenated(fname),'F',' ') + IF(IsNoFirstLastNameExOrHyphenated(lname), 'L', ' ') +
		IF(IsFirstNameOrHyphenated(TRIM(afname,LEFT,RIGHT)), 'f', ' ') + IF(IsNoFirstLastNameExOrHyphenated(alname), 'l', ' ');
END;

shared string1 SelectOrder(string rgx, string s, string1 clue, integer2 posm1, integer2 posm2) := FUNCTION
	string2 m := IF(posm1 > 0, IF(IsFirstName(REGEXFIND(rgx, s, posm1)),'M','m'),'m') +
					IF(posm2 > 0, IF(IsFirstName(REGEXFIND(rgx, s, posm2)),'M','m'),'m');
	return MAP(
		m = 'Mm' => 'F',
		m = 'mM' => 'L',
		//m = 'mm' => IF(clue='U','F',StringLib.StringToUpperCase(clue)),
		//clue = 'U' => 'F',	
		StringLib.StringToUpperCase(clue));
		
END;

shared string1 GetNameOrder(string rgx, string s, integer2 posf1, integer2 posf2, 
													integer2 posl1, integer2 posl2, string1 clue='U',
													integer2 posm1 = 0, integer2 posm2 = 0) := FUNCTION

	// modify to make clue "hard" rather than a suggestion
	// use lower case for a suggestion
	RETURN MAP(
		clue = 'F' => 'F',
		clue = 'L' => 'L',
		Case(ValidateNames(rgx, s, posf1, posf2, posl1, posl2),
		'    ' => MAP(
					//LENGTH(REGEXFIND(rgx, s, posl1)) = 1 => 'L',
					//LENGTH(REGEXFIND(rgx, s, posl2)) = 1 => 'F',				
					clue in ['f','F'] => 'F',
					clue in ['l','L'] => 'L',
					SelectOrder(rgx, s, StringLib.StringToUpperCase(clue), posm1, posm2)), 
		'F   ' => 'F',
		'FL  ' => 'F',
		'F f ' => MAP(
					clue in ['f','F'] => 'F',
					clue in ['l','L'] => 'L',
					SelectOrder(rgx, s, clue, posm1, posm2)
					),
//		'F  l' => SelectOrder(rgx, s, clue, posm1, posm2),
		'F  l' => IF(clue='U',SelectOrder(rgx, s, clue, posm1, posm2),
								StringLib.StringToUpperCase(clue)),
		' L  ' => IF(clue in ['f','F','U'],'F','L'),
		' Lf ' => IF(clue='U',SelectOrder(rgx, s, clue, posm1, posm2),
								StringLib.StringToUpperCase(clue)),
		' L l' => MAP(
					IsLastNameOnlyOrHyphenated(REGEXFIND(rgx, s, posl1)) => 'F',
					IsLastNameOnlyOrHyphenated(REGEXFIND(rgx, s, posl2)) => 'L',
					clue in ['f','F'] => 'F',
					clue in ['l','L'] => 'L',
					//LENGTH(REGEXFIND(rgx, s, posl1)) = 1 => 'L',
					//LENGTH(REGEXFIND(rgx, s, posl2)) = 1 => 'F',				
					SelectOrder(rgx, s, clue, posm1, posm2)),
		'  f ' => 'L',
		'  fl' => 'L',
		'   l' => MAP(
					clue in ['f','F'] => 'F',
					clue in ['l','L'] => 'L',
					'L'),
		'FLf ' => IF(clue in ['f','F','U'],'F','L'),
		'FL l' => IF(clue in ['f','F','U'],'F','L'),
		'F fl' => MAP(
					clue in ['f','F'] => 'F',
					clue in ['l','L'] => 'L',
					SelectOrder(rgx, s, 'L', posm1, posm2)),
		' Lfl' => 'L',
		'FLfl' => MAP(
					IsLastNameOnlyOrHyphenated(REGEXFIND(rgx, s, posl1)) => 'F',
					IsLastNameOnlyOrHyphenated(REGEXFIND(rgx, s, posl2)) => 'L',
					clue in ['f','F'] => 'F',
					clue in ['l','L'] => 'L',
					//LENGTH(REGEXFIND(rgx, s, posf1)) < LENGTH(REGEXFIND(rgx, s, posl1)) => 'F',
					//LENGTH(REGEXFIND(rgx, s, posf1)) > LENGTH(REGEXFIND(rgx, s, posl1)) => 'L',
					IsNickName(REGEXFIND(rgx, s, posf1)) => 'F',
					IsNickName(REGEXFIND(rgx, s, posf2)) => 'L',
					SelectOrder(rgx, s, clue, posm1, posm2)),
		StringLib.StringToUpperCase(clue)
		));
END;




/*
shared string1 GetWordOrder(string rgx, string s, integer2 posf1, integer2 posf2, 
													integer2 posl1, integer2 posl2, string1 clue='U') := FUNCTION
	fname := REGEXFIND(rgx, s, posf1, NOCASE);		// likely first name
	afname := REGEXFIND(rgx, s, posf2, NOCASE);		// alternate first name
	lname := REGEXFIND(rgx, s, posl1, NOCASE);		// likely last name
	alname := REGEXFIND(rgx, s, posl2, NOCASE);		// alternate last name

	RETURN MAP(
		IsFirstName(fname) AND IsLastName(lname) => 'F',
		IsFirstName(afname) AND IsLastName(alname) => 'L',
		IsFirstName(fname) AND IsFirstName(afname) => 'F',
		IsFirstName(fname) => 'F',
		IsFirstName(afname) => 'L',
		IsLastName(lname) => 'F',
		IsLastName(alname) => 'L',
		clue
	);
END;
*/

// check for a first name in the expected place
// clues '' (none) 'F' first/last 'L' last/first
export string FirstName(string s, NameFormat n, string1 clue='U') := 
	CASE (n,
			NameFormat.NoName =>	'',
			NameFormat.FL =>		REGEXFIND(rgxFL, s, 1),
			NameFormat.LF =>		REGEXFIND(rgxLF, s, 4),
			NameFormat.LFM =>		REGEXFIND(rgxLFM, s, 4),
			NameFormat.FLorLF => 	CASE(GetNameOrder(rgxFLoLF, s, 1, 3, 3, 1, clue),
										'F' => REGEXFIND(rgxFLoLF, s, 1),
										'L' => REGEXFIND(rgxFLoLF, s, 3),
										REGEXFIND(rgxFLoLF, s, 1)
									),
			/*NameFormat.FLorLF => 	CASE(GetWordOrder(rgxFLoLF, s, 1, 3, clue),
										'F' => REGEXFIND(rgxFLoLF, s, 1),
										'L' => REGEXFIND(rgxFLoLF, s, 3),
										REGEXFIND(rgxFLoLF, s, 1, NOCASE)
									),*/
			/*NameFormat.FLorLF => 	MAP(
										IsFirstName(REGEXFIND(rgxFLoLF, s, 1)) => REGEXFIND(rgxFLoLF, s, 1, NOCASE),
										IsFirstName(REGEXFIND(rgxFLoLF, s, 3)) => REGEXFIND(rgxFLoLF, s, 3, NOCASE),
										IsLastName(REGEXFIND(rgxFLoLF, s, 1)) => REGEXFIND(rgxFLoLF, s, 3, NOCASE),
										clue = 'L' => REGEXFIND(rgxFLoLF, s, 3, NOCASE),
										REGEXFIND(rgxFLoLF, s, 1, NOCASE)
									),*/
			
			NameFormat.FLcS =>		REGEXFIND(rgxFLcS, s, 1),
			NameFormat.FLS =>		REGEXFIND(rgxFLS, s, 1),
			NameFormat.FLSorLFS =>	CASE(GetNameOrder(rgxFLSorLFS, s, 1, 2, 2, 1, clue),
										'F' => REGEXFIND(rgxFLSorLFS, s, 1),
										'L' => REGEXFIND(rgxFLSorLFS, s, 2),
										REGEXFIND(rgxFLSorLFS, s, 1)
									),
			/*NameFormat.FLSoLFS =>	CASE(GetWordOrderV1(rgxFLSoLFS, s, 1, 2, clue),
										'F' => REGEXFIND(rgxFLSoLFS, s, 1),
										'L' => REGEXFIND(rgxFLSoLFS, s, 2),
										REGEXFIND(rgxFLSoLFS, s, 1)
									),
			/*NameFormat.FLSoLFS =>	MAP(
										IsFirstName(REGEXFIND(rgxFLSoLFS, s, 1)) => REGEXFIND(rgxFLSoLFS, s, 1),
										IsFirstName(REGEXFIND(rgxFLSoLFS, s, 2)) => REGEXFIND(rgxFLSoLFS, s, 2),
										IsLastName(REGEXFIND(rgxFLSoLFS, s, 1)) => REGEXFIND(rgxFLSoLFS, s, 2),
										clue = 'L' => REGEXFIND(rgxFLSoLFS, s, 2, NOCASE),
										REGEXFIND(rgxFLSoLFS, s, 1)
									),*/
			
			//NameFormat.FLL =>		REGEXFIND(rgxFLL, s, 1),
			NameFormat.FLL =>		CASE(GetNameOrder(rgxFLL, s, 1, 5, 5, 2, clue),
					/* FML or MLF */	'F' => REGEXFIND(rgxFLL, s, 1),
										'L' => REGEXFIND(rgxFLL, s, 5),
										REGEXFIND(rgxFLL, s, 1)
									),
			NameFormat.FxL =>		REGEXFIND(rgxFxL, s, 1),
			NameFormat.FxLS =>		REGEXFIND(rgxFxLS, s, 1),
			NameFormat.LxFM =>		REGEXFIND(rgxLxFM, s, 3),
			NameFormat.FxLL =>		REGEXFIND(rgxFxLL, s, 1),
			NameFormat.FMLL =>		REGEXFIND(rgxFMLL, s, 1),
			NameFormat.FMiMiL =>	REGEXFIND(rgxFMiMiL, s, 1),
			NameFormat.LFMiM =>		IF(clue='f',REGEXFIND(rgxLFMiM,s,1),
									CASE(GetNameOrder(rgxLFMiM, s, 1, 2, 4, 1, clue, 2, 4),
										'F' => REGEXFIND(rgxLFMiM, s, 1),
										'L' => REGEXFIND(rgxLFMiM, s, 2),
										REGEXFIND(rgxLFMiM,s,2)
									)),
										//REGEXFIND(rgxLFMiM, s, 2),
			NameFormat.FMML =>		REGEXFIND(rgxFMML, s, 1),
			NameFormat.FMMLS =>		REGEXFIND(rgxFMMLS, s, 1),
			NameFormat.LFMi =>		REGEXFIND(rgxLFMi, s, 4),

			NameFormat.FML =>		REGEXFIND(rgxFML, s, 1),
			NameFormat.FMLorLFM => 	CASE(GetNameOrder(rgxFMLorLFM, s, 1, 4, 5, 1, clue, 4, 5),
										'F' => REGEXFIND(rgxFMLorLFM, s, 1),
										'L' => REGEXFIND(rgxFMLorLFM, s, 4),
										REGEXFIND(rgxFMLorLFM, s, 1)
									),
			/*NameFormat.FMLorLFM => 	CASE(GetWordOrder(rgxFMLorLFM, s, 1, 5, clue),
										'F' => REGEXFIND(rgxFMLorLFM, s, 1),
										'L' => REGEXFIND(rgxFMLorLFM, s, 5),
										REGEXFIND(rgxFMLorLFM, s, 1)
									),*/
			/*NameFormat.FMLorLFM => 	MAP(
										IsFirstName(REGEXFIND(rgxFMLorLFM, s, 1)) => REGEXFIND(rgxFMLorLFM, s, 1),
										IsFirstName(REGEXFIND(rgxFMLorLFM, s, 4)) => REGEXFIND(rgxFMLorLFM, s, 4),
										IsLastName(REGEXFIND(rgxFMLorLFM, s, 1)) => REGEXFIND(rgxFMLorLFM, s, 4),
										clue = 'L' => REGEXFIND(rgxFMLorLFM, s, 4, NOCASE),
										REGEXFIND(rgxFMLorLFM, s, 1)
									),*/
			NameFormat.FMLSorLFMS => CASE(GetNameOrder(rgxFMLS, s, 1, 2, 3, 1, clue, 2, 3),
										'F' => REGEXFIND(rgxFMLS, s, 1, NOCASE),
										'L' => REGEXFIND(rgxFMLS, s, 2, NOCASE),
										REGEXFIND(rgxFMLS, s, 1, NOCASE)
									),
										//REGEXFIND(rgxFMLS, s, 1),
			NameFormat.LFMicS => 	REGEXFIND(rgxLFMicS, s, 4),
			NameFormat.FMLcS => 	REGEXFIND(rgxFMLcS, s, 1),
			NameFormat.LcFMS => 	REGEXFIND(rgxLcFMS, s, 4, NOCASE),
			NameFormat.LcFMcS => 	REGEXFIND(rgxLcFMcS, s, 4),
			NameFormat.LScF => 		REGEXFIND(rgxLScF, s, 5),
			NameFormat.LSFM => 		REGEXFIND(rgxLSFM, s, 5),
			NameFormat.LScFM => 	REGEXFIND(rgxLScFM, s, 7),
			NameFormat.LScFMM => 	REGEXFIND(rgxLScFMM, s, 7),
			NameFormat.LcScF => 	REGEXFIND(rgxLcScF, s, 7),
			NameFormat.LcScFM => 	REGEXFIND(rgxLcScFM, s, 7),
			NameFormat.LFMiS =>		REGEXFIND(rgxLFMiS, s, 4),
			NameFormat.LFMS => 		REGEXFIND(rgxLFMS, s, 4),
			NameFormat.FMLLS => 	REGEXFIND(rgxFMLLS, s, 1),
			NameFormat.LcFMM => 	REGEXFIND(rgxLcFMM, s, 4),
			//NameFormat.LFMMi => 	REGEXFIND(rgxLFMMi, s, 4),
			NameFormat.LFMMi =>		CASE(GetNameOrder(rgxLFMMi, s, 4, 5, 1, 4, clue),
										'F' => REGEXFIND(rgxLFMMi, s, 4),
										'L' => REGEXFIND(rgxLFMMi, s, 5),
										REGEXFIND(rgxLFMMi, s, 4)
									),
			//NameFormat.FiMiL =>		s[1],
			NameFormat.LFi =>		REGEXFIND(rgxLFi, s, 4, NOCASE),
			NameFormat.LFiS =>		REGEXFIND(rgxLFiS, s, 4, NOCASE),
			NameFormat.FiL =>		s[1],
			//NameFormat.FiML =>		s[1],
			NameFormat.FiML =>		IF(clue='f',s[1],
									CASE(GetNameOrder(rgxFiML, s, 2, 3, 3, 2, clue, 2, 0),
										'F' => s[1],
										'L' => REGEXFIND(rgxFiML, s, 3),
										s[1]
									)),
			NameFormat.FiLS =>		s[1],
			NameFormat.FiMLS =>		s[1],
			NameFormat.FMiL =>		IF(clue='f',REGEXFIND(rgxFMiL, s, 1),
									CASE(GetNameOrder(rgxFMiL, s, 1, 3, 3, 1, clue, 0, 3),
										'F' => REGEXFIND(rgxFMiL, s, 1),
										'L' => REGEXFIND(rgxFMiL, s, 2),
										REGEXFIND(rgxFMiL, s, 1)
									)),
			NameFormat.FMiLS =>		REGEXFIND(rgxFMiLS, s, 1),
			NameFormat.FMiLI =>		REGEXFIND(rgxFMiLI, s, 1),
			NameFormat.LFcMi =>		REGEXFIND(rgxLFcMi, s, 4),
			NameFormat.LcF =>		REGEXFIND(rgxLcF, s, 4),
			NameFormat.LcTF =>		REGEXFIND(rgxLcTF, s, 5),
			NameFormat.LcFM =>		REGEXFIND(rgxLcFM, s, 4),
			NameFormat.LcFcS =>		REGEXFIND(rgxLcFcS, s, 4),
			NameFormat.LcFcM =>		REGEXFIND(rgxLcFcM, s, 4),
			NameFormat.LcFcMS =>	REGEXFIND(rgxLcFcMS, s, 4),
			NameFormat.LcFS =>		REGEXFIND(rgxLcFS, s, 4),
			NameFormat.LLcFM =>		REGEXFIND(rgxLLcFM, s, 7),
			NameFormat.LLcFS =>		REGEXFIND(rgxLLcFS, s, 7),
			NameFormat.LcFhF =>		REGEXFIND(rgxLcFhF, s, 2),
			NameFormat.FiIIL =>		s[1],
			NameFormat.SFL =>		REGEXFIND(rgxSFL, s, 2),
			//NameFormat.FSL =>		REGEXFIND(rgxFSL, s, 1),
			NameFormat.FSL =>		CASE(GetNameOrder(rgxFSL, s, 1, 3, 3, 1, clue),
										'F' => REGEXFIND(rgxFSL, s, 1),
										'L' => REGEXFIND(rgxFSL, s, 3),
										REGEXFIND(rgxFSL, s, 1)
									),
			NameFormat.FMLyL =>		REGEXFIND(rgxFMLyL,s,1,NOCASE),

			// Dual Names
			NameFormat.LFiaFi =>	REGEXFIND(rgxLFiaFi, s, 4),
			NameFormat.LFiaFiL =>	REGEXFIND(rgxLFiaFiL, s, 2),
			NameFormat.LFiMiaFiMi =>REGEXFIND(rgxLFiMiaFiMi, s, 4),
			//NameFormat.LFaF =>		REGEXFIND(rgxLFaF, s, 4),
			NameFormat.LFaF =>		CASE(GetNameOrder(rgxLFaF, s, 1, 4, 4, 1),
										'F' => REGEXFIND(rgxLFaF, s, 1),
										'L' => REGEXFIND(rgxLFaF, s, 4),
										REGEXFIND(rgxLFaF, s, 4)
									),
			NameFormat.FMiaFL =>	REGEXFIND(rgxFMiaFL, s, 1),
			NameFormat.LFaFM =>		REGEXFIND(rgxLFaFM, s, 4),
			NameFormat.FMLaFML  =>	REGEXFIND(rgxFMLaFML, s, 1),
			NameFormat.FMLcFML  =>	REGEXFIND(rgxFMLcFML, s, 1),
			NameFormat.FMLSaFML  =>	REGEXFIND(rgxFMLSaFML, s, 1),
			NameFormat.LFMaLFM  =>	REGEXFIND(rgxLFMaLFM, s, 4),
			NameFormat.LFMaLFM2  =>	REGEXFIND(rgxLFMaLFM2, s, 4),
			NameFormat.LFMaFML =>	REGEXFIND(rgxLFMaFML, s, 4),
			NameFormat.FLSaFM =>	CASE(GetNameOrder(rgxFLSaFM, s, 1, 2, 2, 1, clue),
										'F' => REGEXFIND(rgxFLSaFM, s, 1, NOCASE),
										'L' => REGEXFIND(rgxFLSaFM, s, 2),
										REGEXFIND(rgxFLSaFM, s, 1)
									),
			NameFormat.LSFaFM =>	REGEXFIND(rgxLSFaFM, s, 5, NOCASE),
			NameFormat.LSFMaFM =>	REGEXFIND(rgxLSFMaFM, s, 5, NOCASE),
			NameFormat.LFiSaI  =>	REGEXFIND(rgxLFiSaI, s, 4),
			NameFormat.FMiSaFL  =>	REGEXFIND(rgxFMiSaFL, s, 1),
			NameFormat.FMLaFL =>	REGEXFIND(rgxFMLaFL, s, 1),
			NameFormat.FMLaFM =>	CASE(GetNameOrder(rgxFMLaFM, s, 1, 3, 3, 1, clue, 2, 3),
										'F' => REGEXFIND(rgxFMLaFM, s, 1),
										'L' => REGEXFIND(rgxFMLaFM, s, 2),
										REGEXFIND(rgxFMLaFM, s, 1)
									),
									//IF(IsFirstName(REGEXFIND(rgxFMLaFM, s, 1)),
									//		REGEXFIND(rgxFMLaFM, s, 1),
									//		REGEXFIND(rgxFMLaFM, s, 2)),
			NameFormat.LFMiaFM  =>	REGEXFIND(rgxLFMiaFM, s, 4),
			NameFormat.LFMiaFMiL => REGEXFIND(rgxLFMiaFMiL, s, 4),
			NameFormat.LcFMaFMS =>	REGEXFIND(rgxLcFMaFMS, s, 4),
			NameFormat.LcFMaF =>	REGEXFIND(rgxLcFMaF, s, 4, NOCASE),
			NameFormat.LcFMaFMM =>	REGEXFIND(rgxLcFMaFMM, s, 4),
			NameFormat.FMaFLS =>	REGEXFIND(rgxFMaFLS, s, 1),
			NameFormat.LFaFMS =>	REGEXFIND(rgxLFaFMS, s, 4),
			NameFormat.FMaFML =>	REGEXFIND(rgxFMaFML, s, 1),
			NameFormat.FiaFiL =>	REGEXFIND(rgxFiaFiL, s, 1),
			NameFormat.FaFL =>		REGEXFIND(rgxFaFL, s, 1),
			NameFormat.FaFML =>		REGEXFIND(rgxFaFML, s, 1),
			NameFormat.LcFMSaFMM =>	REGEXFIND(rgxLcFMSaFMM, s, 4),
			NameFormat.LFMSaFMM =>	CASE(GetNameOrder(rgxLFMSaFMM, s, 1, 5, 4, 1, clue, 4, 5),
										'F' => REGEXFIND(rgxLFMSaFMM, s, 1),
										'L' => REGEXFIND(rgxLFMSaFMM, s, 4),
										REGEXFIND(rgxLFMSaFMM, s, 1)
									),
			NameFormat.LcFaF 	=>	REGEXFIND(rgxLcFaF, s, 4),
			NameFormat.LcFaFM 	=>	REGEXFIND(rgxLcFaFM, s, 4),
			NameFormat.LcFMaLcFM =>	REGEXFIND(rgxLcFMaLcFM, s, 4),
			NameFormat.LcFaLcF =>	REGEXFIND(rgxLcFaLcF, s, 4),
			'*');


export string FirstName2(string s, NameFormat n) := 
	TRIM(CASE (n,
			// Dual Names
			NameFormat.LFiaFi =>	REGEXFIND(rgxLFiaFi, s, 6),
			NameFormat.LFiaFiL =>	REGEXFIND(rgxLFiaFiL, s, 4),
			NameFormat.LFiMiaFiMi =>REGEXFIND(rgxLFiMiaFiMi, s, 7),
			NameFormat.LFaF =>		REGEXFIND(rgxLFaF, s, 6),	
			NameFormat.FMiaFL =>	REGEXFIND(rgxFMiaFL, s, 4),
			NameFormat.LFaFM =>		REGEXFIND(rgxLFaFM, s, 6, NOCASE),	
			NameFormat.FLSaFM =>	REGEXFIND(rgxFLSaFM, s, 7, NOCASE),
			NameFormat.LSFaFM =>	REGEXFIND(rgxLSFaFM, s, 7, NOCASE),
			NameFormat.LSFMaFM =>	REGEXFIND(rgxLSFMaFM, s, 8, NOCASE),
			NameFormat.FMLaFML  =>	REGEXFIND(rgxFMLaFML, s, 7, NOCASE),
			NameFormat.FMLcFML  =>	REGEXFIND(rgxFMLcFML, s, 6),
			NameFormat.FMLSaFML  =>	REGEXFIND(rgxFMLSaFML, s, 8, NOCASE),
			NameFormat.LFMaLFM  =>	REGEXFIND(rgxLFMaLFM, s, 7, NOCASE),
			NameFormat.LFMaLFM2  =>	REGEXFIND(rgxLFMaLFM2, s, 8),
			NameFormat.LFMaFML =>	REGEXFIND(rgxLFMaFML, s, 7, NOCASE),
			NameFormat.LFMiaFM  =>	REGEXFIND(rgxLFMiaFM, s, 7, NOCASE),
			NameFormat.LFMiaFMiL => REGEXFIND(rgxLFMiaFMiL, s, 7),
			NameFormat.LFiSaI  =>	REGEXFIND(rgxLFiSaI, s, 7),
			NameFormat.FMiSaFL  =>	REGEXFIND(rgxFMiSaFL, s, 5),
			NameFormat.FMLaFL =>	REGEXFIND(rgxFMLaFL, s, 7),
			NameFormat.FMLaFM =>	REGEXFIND(rgxFMLaFM, s, 7),
			NameFormat.LcFMaFMS =>	REGEXFIND(rgxLcFMaFMS, s, 7, NOCASE),
			NameFormat.LcFMaF =>	REGEXFIND(rgxLcFMaF, s, 7, NOCASE),
			NameFormat.LcFMaFMM =>	REGEXFIND(rgxLcFMaFMM, s, 7, NOCASE),
			NameFormat.FMaFLS =>	REGEXFIND(rgxFMaFLS, s, 4),
			NameFormat.LFaFMS =>	REGEXFIND(rgxLFaFMS, s, 6),
			NameFormat.FMaFML =>	REGEXFIND(rgxFMaFML, s, 4, NOCASE),
			NameFormat.FiaFiL =>	REGEXFIND(rgxFiaFiL, s, 3),
			NameFormat.FaFL =>		REGEXFIND(rgxFaFL, s, 3, NOCASE),
			NameFormat.FaFML =>		REGEXFIND(rgxFaFML, s, 3, NOCASE),
			NameFormat.LcFMSaFMM =>	REGEXFIND(rgxLcFMSaFMM, s, 8, NOCASE),
			NameFormat.LFMSaFMM =>	REGEXFIND(rgxLFMSaFMM, s, 10),
			NameFormat.LcFaF 	=>	REGEXFIND(rgxLcFaF, s, 6, NOCASE),
			NameFormat.LcFaFM 	=>	REGEXFIND(rgxLcFaFM, s, 6, NOCASE),
			NameFormat.LcFMaLcFM =>	REGEXFIND(rgxLcFMaLcFM, s, 10, NOCASE),
			NameFormat.LcFaLcF =>	REGEXFIND(rgxLcFaLcF, s, 9),
			''));

//export boolean SegInInsHdr(string s) :=
//	EXISTS(IDL_Header.Name_Count_DS(name=s));
	


		
// clues '' (none) 'F' first/last 'L' last/first
export string LastName(string s, NameFormat n, string1 clue='U') := 
		Stringlib.StringFilterOut(CASE (n,
			NameFormat.NoName =>	'',
			NameFormat.FL =>		REGEXFIND(rgxFL, s, 2, NOCASE),
			NameFormat.LF =>		REGEXFIND(rgxLF, s, 1, NOCASE),
			NameFormat.LFM =>		REGEXFIND(rgxLFM, s, 1),
			NameFormat.FLorLF => 	CASE(GetNameOrder(rgxFLoLF, s, 1, 3, 3, 1, clue),
										'F' => REGEXFIND(rgxFLoLF, s, 3),
										'L' => REGEXFIND(rgxFLoLF, s, 1),
										REGEXFIND(rgxFLoLF, s, 3, NOCASE)
									),
			/*NameFormat.FLorLF => 	MAP(
										IsFirstName(REGEXFIND(rgxFLoLF, s, 1, NOCASE)) => REGEXFIND(rgxFLoLF, s, 3, NOCASE),
										IsFirstName(REGEXFIND(rgxFLoLF, s, 3, NOCASE)) => REGEXFIND(rgxFLoLF, s, 1, NOCASE),
										IsLastName(REGEXFIND(rgxFLoLF, s, 1, NOCASE)) => REGEXFIND(rgxFLoLF, s, 1, NOCASE),
										clue = 'L' => REGEXFIND(rgxFLoLF, s, 1, NOCASE),
										REGEXFIND(rgxFLoLF, s, 3, NOCASE)
									),*/
			NameFormat.FLcS =>		REGEXFIND(rgxFLcS, s, 2, NOCASE),
			NameFormat.FLS =>		REGEXFIND(rgxFLS, s, 2, NOCASE),
			NameFormat.FLSorLFS =>	CASE(GetNameOrder(rgxFLSorLFS, s, 1, 2, 2, 1, clue),
										'F' => REGEXFIND(rgxFLSorLFS, s, 2),
										'L' => REGEXFIND(rgxFLSorLFS, s, 1),
										REGEXFIND(rgxFLSorLFS, s, 2)
									),
			/*NameFormat.FLSoLFS =>	CASE(GetWordOrderV1(rgxFLSoLFS, s, 1, 2, clue),
										'F' => REGEXFIND(rgxFLSoLFS, s, 2),
										'L' => REGEXFIND(rgxFLSoLFS, s, 1),
										REGEXFIND(rgxFLSoLFS, s, 2)
									),
			/*NameFormat.FLSoLFS =>	MAP(
										IsFirstName(REGEXFIND(rgxFLSoLFS, s, 1, NOCASE)) => REGEXFIND(rgxFLSoLFS, s, 2, NOCASE),
										IsFirstName(REGEXFIND(rgxFLSoLFS, s, 2, NOCASE)) => REGEXFIND(rgxFLSoLFS, s, 1, NOCASE),
										IsLastName(REGEXFIND(rgxFLSoLFS, s, 1, NOCASE)) => REGEXFIND(rgxFLSoLFS, s, 1, NOCASE),
										clue = 'L' => REGEXFIND(rgxFLSoLFS, s, 1, NOCASE),
										REGEXFIND(rgxFLSoLFS, s, 2, NOCASE)
									),*/
			NameFormat.LFMi =>		REGEXFIND(rgxLFMi, s, 1),
			
			//NameFormat.FLL =>		REGEXFIND(rgxFLL, s, 5),
			NameFormat.FLL =>		CASE(GetNameOrder(rgxFLL, s, 1, 5, 5, 2, clue),
					/* FML or MLF */	'F' => REGEXFIND(rgxFLL, s, 5),
										'L' => REGEXFIND(rgxFLL, s, 2),
										REGEXFIND(rgxFLL, s, 1)
									),
			NameFormat.FxL =>		REGEXFIND(rgxFxL, s, 3),
			NameFormat.FxLS =>		REGEXFIND(rgxFxLS, s, 3),
			NameFormat.LxFM =>		REGEXFIND(rgxLxFM, s, 1),
			NameFormat.FxLL =>		REGEXFIND(rgxFxLL, s, 3),
			NameFormat.FMLL =>		REGEXFIND(rgxFMLL, s, 3) + ' ' + REGEXFIND(rgxFMLL, s, 6),
			NameFormat.FMiMiL =>	REGEXFIND(rgxFMiMiL, s, 3),
			NameFormat.LFMiM =>		IF(clue='f',REGEXFIND(rgxLFMiM,s,4),
									CASE(GetNameOrder(rgxLFMiM, s, 1, 2, 4, 1, clue, 2, 4),
										'F' => REGEXFIND(rgxLFMiM, s, 4),
										'L' => REGEXFIND(rgxLFMiM, s, 1),
										REGEXFIND(rgxLFMiM, s, 1)
									)),
			//NameFormat.LFMiM =>		REGEXFIND(rgxLFMiM, s, 1),
			NameFormat.FMML =>		REGEXFIND(rgxFMML, s, 3),
			NameFormat.FMMLS =>		REGEXFIND(rgxFMMLS, s, 3),
			NameFormat.FML =>		REGEXFIND(rgxFML, s, 3),
			NameFormat.FMLorLFM => 	CASE(GetNameOrder(rgxFMLorLFM, s, 1, 4, 5, 1, clue, 4, 5),
										'F' => REGEXFIND(rgxFMLorLFM, s, 5),
										'L' => REGEXFIND(rgxFMLorLFM, s, 1),
										REGEXFIND(rgxFMLorLFM, s, 5)
									),
			/*NameFormat.FMLorLFM => 	MAP(
										IsFirstName(REGEXFIND(rgxFMLorLFM, s, 1, NOCASE)) => REGEXFIND(rgxFMLorLFM, s, 5, NOCASE),
										IsFirstName(REGEXFIND(rgxFMLorLFM, s, 4, NOCASE)) => REGEXFIND(rgxFMLorLFM, s, 1, NOCASE),
										IsLastName(REGEXFIND(rgxFMLorLFM, s, 1, NOCASE)) => REGEXFIND(rgxFMLorLFM, s, 1, NOCASE),
										clue = 'L' => REGEXFIND(rgxFMLorLFM, s, 1, NOCASE),
										REGEXFIND(rgxFMLorLFM, s, 5, NOCASE)
									),*/
			NameFormat.FMLSorLFMS => CASE(GetNameOrder(rgxFMLS, s, 1, 2, 3, 1, clue, 2, 3),
										'F' => REGEXFIND(rgxFMLS, s, 3, NOCASE),
										'L' => REGEXFIND(rgxFMLS, s, 1, NOCASE),
										REGEXFIND(rgxFMLS, s, 3, NOCASE)
									),
									//	REGEXFIND(rgxFMLS, s, 3, NOCASE),
			NameFormat.LFMicS => 	REGEXFIND(rgxLFMicS, s, 1),
			NameFormat.FMLcS => 	REGEXFIND(rgxFMLcS, s, 3),
			NameFormat.LcFMS => 	REGEXFIND(rgxLcFMS, s, 1, NOCASE),
			NameFormat.LcFMcS => 	REGEXFIND(rgxLcFMcS, s, 1),
			NameFormat.LScF => 		REGEXFIND(rgxLScF, s, 1, NOCASE),
			NameFormat.LSFM => 		REGEXFIND(rgxLSFM, s, 1, NOCASE),
			NameFormat.LScFM => 	REGEXFIND(rgxLScFM, s, 1, NOCASE),
			NameFormat.LScFMM => 	REGEXFIND(rgxLScFMM, s, 1),
			NameFormat.LcScF => 	REGEXFIND(rgxLcScF, s, 1),
			NameFormat.LcScFM => 	REGEXFIND(rgxLcScFM, s, 1),
			NameFormat.LFMiS => 	REGEXFIND(rgxLFMiS, s, 1, NOCASE),
			NameFormat.LFMS => 		REGEXFIND(rgxLFMS, s, 1, NOCASE),
			NameFormat.FMLLS => 	REGEXFIND(rgxFMLLS, s, 6, NOCASE),
			NameFormat.LcFMM => 	REGEXFIND(rgxLcFMM, s, 1, NOCASE),
			//NameFormat.LFMMi => 	REGEXFIND(rgxLFMMi, s, 1, NOCASE),
			NameFormat.LFMMi =>		CASE(GetNameOrder(rgxLFMMi, s, 4, 5, 1, 4, clue),
										'F' => REGEXFIND(rgxLFMMi, s, 1),
										'L' => REGEXFIND(rgxLFMMi, s, 1) +' '+
												REGEXFIND(rgxLFMMi, s, 4),
										REGEXFIND(rgxLFMMi, s, 1)
									),
			//NameFormat.FiMiL =>		REGEXFIND(rgxFiMiL, s, 2, NOCASE),
			NameFormat.LFi =>		REGEXFIND(rgxLFi, s, 1, NOCASE),
			NameFormat.LFiS =>		REGEXFIND(rgxLFiS, s, 1, NOCASE),
			NameFormat.FiL =>		REGEXFIND(rgxFiL, s, 2, NOCASE),
			//NameFormat.FiML =>		REGEXFIND(rgxFiML, s, 3, NOCASE),
			NameFormat.FiML =>		IF(clue='f',REGEXFIND(rgxFiML, s, 3),
									CASE(GetNameOrder(rgxFiML, s, 2, 3, 3, 2, clue, 2, 0),
										'F' => REGEXFIND(rgxFiML, s, 3),
										'L' => REGEXFIND(rgxFiML, s, 2),
										REGEXFIND(rgxFiML, s, 3)
									)),
			NameFormat.FiLS =>		REGEXFIND(rgxFiLS, s, 2, NOCASE),
			NameFormat.FiMLS =>		REGEXFIND(rgxFiMLS, s, 3, NOCASE),
			NameFormat.FMiL =>		IF(clue='f',REGEXFIND(rgxFMiL, s, 3),
									CASE(GetNameOrder(rgxFMiL, s, 1, 3, 3, 1, clue, 0, 3),
										'F' => REGEXFIND(rgxFMiL, s, 3),
										'L' => REGEXFIND(rgxFMiL, s, 1),
										REGEXFIND(rgxFMiL, s, 3)
									)),
			NameFormat.FMiLS =>		REGEXFIND(rgxFMiLS, s, 3, NOCASE),
			NameFormat.FMiLI =>		REGEXFIND(rgxFMiLI, s, 3),
			NameFormat.LFcMi =>		REGEXFIND(rgxLFcMi, s, 1, NOCASE),
			NameFormat.LcF =>		REGEXFIND(rgxLcF, s, 1, NOCASE),
			NameFormat.LcTF =>		REGEXFIND(rgxLcTF, s, 1, NOCASE),
			NameFormat.LcFM =>		REGEXFIND(rgxLcFM, s, 1, NOCASE),
			NameFormat.LcFcS =>		REGEXFIND(rgxLcFcS, s, 1),
			NameFormat.LcFcM =>		REGEXFIND(rgxLcFcM, s, 1),
			NameFormat.LcFcMS =>	REGEXFIND(rgxLcFcMS, s, 1),
			NameFormat.LcFS =>		REGEXFIND(rgxLcFS, s, 1),
			NameFormat.LLcFM =>		REGEXFIND(rgxLLcFM, s, 1) + ' ' + REGEXFIND(rgxLLcFM, s, 4),
			NameFormat.LLcFS =>		REGEXFIND(rgxLLcFS, s, 1) + ' ' + REGEXFIND(rgxLLcFS, s, 4),
			NameFormat.LcFhF =>		REGEXFIND(rgxLcFhF, s, 1),
			NameFormat.FiIIL =>		REGEXFIND(rgxFiIIL, s, 2),
			NameFormat.SFL =>		REGEXFIND(rgxSFL, s, 3),
			//NameFormat.FSL =>		REGEXFIND(rgxFSL, s, 3),
			NameFormat.FSL =>		CASE(GetNameOrder(rgxFSL, s, 1, 3, 3, 1, clue),
										'F' => REGEXFIND(rgxFSL, s, 3),
										'L' => REGEXFIND(rgxFSL, s, 1),
										REGEXFIND(rgxFSL, s, 3)
									),
			NameFormat.FMLyL =>		REGEXFIND(rgxFMLyL,s,3,NOCASE),
			
			// Dual Names
			NameFormat.LFiaFi =>	REGEXFIND(rgxLFiaFi, s, 1),
			NameFormat.LFiaFiL =>	REGEXFIND(rgxLFiaFiL, s, 1),
			NameFormat.LFiMiaFiMi =>REGEXFIND(rgxLFiMiaFiMi, s, 1),
			//NameFormat.LFaF =>		REGEXFIND(rgxLFaF, s, 1),
			NameFormat.LFaF =>		CASE(GetNameOrder(rgxLFaF, s, 1, 4, 4, 1),
										'F' => REGEXFIND(rgxLFaF, s, 4),
										'L' => REGEXFIND(rgxLFaF, s, 1),
										REGEXFIND(rgxLFaF, s, 1)
									),
			NameFormat.FMiaFL =>	REGEXFIND(rgxFMiaFL, s, 5),
			NameFormat.LFaFM =>		REGEXFIND(rgxLFaFM, s, 1, NOCASE),
			NameFormat.FMLaFML  =>	REGEXFIND(rgxFMLaFML, s, 3, NOCASE),
			NameFormat.FMLcFML  =>	REGEXFIND(rgxFMLcFML, s, 3),
			NameFormat.FMLSaFML  =>	REGEXFIND(rgxFMLSaFML, s, 3, NOCASE),
			NameFormat.LFMaLFM  =>	REGEXFIND(rgxLFMaLFM, s, 1, NOCASE),
			NameFormat.LFMaLFM2  =>	REGEXFIND(rgxLFMaLFM2, s, 1),
			NameFormat.LFMaFML =>	REGEXFIND(rgxLFMaFML, s, 1, NOCASE),
			NameFormat.FLSaFM =>	CASE(GetNameOrder(rgxFLSaFM, s, 1, 2, 2, 1, clue),
										'F' => REGEXFIND(rgxFLSaFM, s, 2, NOCASE),
										'L' => REGEXFIND(rgxFLSaFM, s, 1),
										REGEXFIND(rgxFLSaFM, s, 2)
									),
			NameFormat.LSFaFM =>	REGEXFIND(rgxLSFaFM, s, 1, NOCASE),
			NameFormat.LSFMaFM =>	REGEXFIND(rgxLSFMaFM, s, 1, NOCASE),
			NameFormat.LFiSaI  =>	REGEXFIND(rgxLFiSaI, s, 1),
			NameFormat.FMiSaFL  =>	REGEXFIND(rgxFMiSaFL, s, 6),
			NameFormat.FMLaFL =>	REGEXFIND(rgxFMLaFL, s, 3),
			NameFormat.FMLaFM =>	CASE(GetNameOrder(rgxFMLaFM, s, 1, 3, 3, 1, clue, 2, 3),
										'F' => REGEXFIND(rgxFMLaFM, s, 3),
										'L' => REGEXFIND(rgxFMLaFM, s, 1),
										REGEXFIND(rgxFMLaFM, s, 3)
									),
									//IF(IsFirstName(REGEXFIND(rgxFMLaFM, s, 1, NOCASE)),
									//		REGEXFIND(rgxFMLaFM, s, 3, NOCASE),
									//		REGEXFIND(rgxFMLaFM, s, 1, NOCASE)),
			NameFormat.LFMiaFM  =>	REGEXFIND(rgxLFMiaFM, s, 1, NOCASE),
			NameFormat.LFMiaFMiL => REGEXFIND(rgxLFMiaFMiL, s, 1),
			NameFormat.LcFMaFMS =>	REGEXFIND(rgxLcFMaFMS, s, 1, NOCASE),
			NameFormat.LcFMaF =>	REGEXFIND(rgxLcFMaF, s, 1, NOCASE),
			NameFormat.LcFMaFMM =>	REGEXFIND(rgxLcFMaFMM, s, 1, NOCASE),
			NameFormat.FMaFLS =>	REGEXFIND(rgxFMaFLS, s, 5),
			NameFormat.LFaFMS =>	REGEXFIND(rgxLFaFMS, s, 1),
			NameFormat.FMaFML =>	REGEXFIND(rgxFMaFML, s, 6, NOCASE),
			NameFormat.FiaFiL =>	REGEXFIND(rgxFiaFiL, s, 4),
			NameFormat.FaFL =>		REGEXFIND(rgxFaFL, s, 4),
			NameFormat.FaFML =>		REGEXFIND(rgxFaFML, s, 5, NOCASE),
			NameFormat.LcFMSaFMM =>	REGEXFIND(rgxLcFMSaFMM, s, 1, NOCASE),
			NameFormat.LFMSaFMM =>	CASE(GetNameOrder(rgxLFMSaFMM, s, 1, 5, 4, 1, clue, 4, 5),
										'F' => REGEXFIND(rgxLFMSaFMM, s, 5),
										'L' => REGEXFIND(rgxLFMSaFMM, s, 1),
										REGEXFIND(rgxLFMSaFMM, s, 5, NOCASE)
									),
			NameFormat.LcFaF 	=>	REGEXFIND(rgxLcFaF, s, 1, NOCASE),
			NameFormat.LcFaFM 	=>	REGEXFIND(rgxLcFaFM, s, 1, NOCASE),
			NameFormat.LcFMaLcFM =>	REGEXFIND(rgxLcFMaLcFM, s, 1, NOCASE),
			NameFormat.LcFaLcF =>	REGEXFIND(rgxLcFaLcF, s, 1),
			''),'\'');
			
export string LastName2(string s, NameFormat n) := 
	Stringlib.StringFilterOut(CASE (n,
			// Dual Names
			NameFormat.LFiaFi =>	REGEXFIND(rgxLFiaFi, s, 1),
			NameFormat.LFiaFiL =>	REGEXFIND(rgxLFiaFiL, s, 5),
			NameFormat.LFiMiaFiMi =>REGEXFIND(rgxLFiMiaFiMi, s, 1),
			//NameFormat.LFaF =>		REGEXFIND(rgxLFaF, s, 1),
			NameFormat.LFaF =>		CASE(GetNameOrder(rgxLFaF, s, 1, 4, 4, 1),
										'F' => REGEXFIND(rgxLFaF, s, 4),
										'L' => REGEXFIND(rgxLFaF, s, 1),
										REGEXFIND(rgxLFaF, s, 1)
									),
			NameFormat.FMiaFL =>	REGEXFIND(rgxFMiaFL, s, 5),
			NameFormat.LFaFM =>		REGEXFIND(rgxLFaFM, s, 1, NOCASE),
			NameFormat.FMLaFML  =>	REGEXFIND(rgxFMLaFML, s, 3, NOCASE),
			NameFormat.FMLcFML  =>	REGEXFIND(rgxFMLcFML, s, 8),
			NameFormat.FMLSaFML  =>	REGEXFIND(rgxFMLSaFML, s, 10, NOCASE),
			NameFormat.LFMaLFM  =>	REGEXFIND(rgxLFMaLFM, s, 1, NOCASE),
			NameFormat.LFMaLFM2  =>	REGEXFIND(rgxLFMaLFM2, s, 7),
			NameFormat.LFMaFML =>	REGEXFIND(rgxLFMaFML, s, 1, NOCASE),
			NameFormat.FLSaFM =>	CASE(GetNameOrder(rgxFLSaFM, s, 1, 2, 2, 1),
										'F' => REGEXFIND(rgxFLSaFM, s, 2, NOCASE),
										'L' => REGEXFIND(rgxFLSaFM, s, 1),
										REGEXFIND(rgxFLSaFM, s, 2)
									),
			NameFormat.LSFaFM =>	REGEXFIND(rgxLSFaFM, s, 1, NOCASE),
			NameFormat.LSFMaFM =>	REGEXFIND(rgxLSFMaFM, s, 1, NOCASE),
			NameFormat.LFiSaI  =>	REGEXFIND(rgxLFiSaI, s, 1),
			NameFormat.FMiSaFL  =>	REGEXFIND(rgxFMiSaFL, s, 6),
			NameFormat.FMLaFL =>	REGEXFIND(rgxFMLaFL, s, 3),
			NameFormat.FMLaFM =>	CASE(GetNameOrder(rgxFMLaFM, s, 1, 3, 3, 1, 'U', 2, 3),
										'F' => REGEXFIND(rgxFMLaFM, s, 3),
										'L' => REGEXFIND(rgxFMLaFM, s, 1),
										REGEXFIND(rgxFMLaFM, s, 3)
									),
									//IF(IsFirstName(REGEXFIND(rgxFMLaFM, s, 1, NOCASE)),
									//		REGEXFIND(rgxFMLaFM, s, 3, NOCASE),
									//		REGEXFIND(rgxFMLaFM, s, 1, NOCASE)),
			NameFormat.LFMiaFM  =>	REGEXFIND(rgxLFMiaFM, s, 1, NOCASE),
			NameFormat.LFMiaFMiL => REGEXFIND(rgxLFMiaFMiL, s, 9),
			NameFormat.LcFMaFMS =>	REGEXFIND(rgxLcFMaFMS, s, 1, NOCASE),
			NameFormat.LcFMaF =>	REGEXFIND(rgxLcFMaF, s, 1, NOCASE),
			NameFormat.LcFMaFMM =>	REGEXFIND(rgxLcFMaFMM, s, 1, NOCASE),
			NameFormat.FMaFLS =>	REGEXFIND(rgxFMaFLS, s, 5),
			NameFormat.LFaFMS =>	REGEXFIND(rgxLFaFMS, s, 1),
			NameFormat.FMaFML =>	REGEXFIND(rgxFMaFML, s, 6, NOCASE),
			NameFormat.FiaFiL =>	REGEXFIND(rgxFiaFiL, s, 4),
			NameFormat.FaFL =>		REGEXFIND(rgxFaFL, s, 4),
			NameFormat.FaFML =>		REGEXFIND(rgxFaFML, s, 5, NOCASE),
			NameFormat.LcFMSaFMM =>	REGEXFIND(rgxLcFMSaFMM, s, 1, NOCASE),
			NameFormat.LFMSaFMM =>	CASE(GetNameOrder(rgxLFMSaFMM, s, 1, 5, 4, 1, 'U', 4, 5),
										'F' => REGEXFIND(rgxLFMSaFMM, s, 5),
										'L' => REGEXFIND(rgxLFMSaFMM, s, 1),
										REGEXFIND(rgxLFMSaFMM, s, 5)
									),
			NameFormat.LcFaF 	=>	REGEXFIND(rgxLcFaF, s, 1, NOCASE),
			NameFormat.LcFaFM 	=>	REGEXFIND(rgxLcFaFM, s, 1, NOCASE),
			NameFormat.LcFMaLcFM =>	REGEXFIND(rgxLcFMaLcFM, s, 7, NOCASE),
			NameFormat.LcFaLcF =>	REGEXFIND(rgxLcFaLcF, s, 6),
			''),'\'');
			
// form: 
cnRgx := '([A-Z]+) +([A-Z]+)';
string CompoundName(string s) := FUNCTION
	part := REGEXFIND(cnRgx, s, 1);
	RETURN IF(part in ['DA','DE','DEL','LA','ST','VAN','VON'],
			s, part);
END;

string FilterMName(string s) := IF(s in ['NMI','NMN'],'',s);
			
export string MiddleName(string s, NameFormat n, string1 clue='U') := 
	FilterMName(
		CASE (n,
			NameFormat.NoName =>	'',
			NameFormat.FL =>		'',
			NameFormat.LF =>		'',
			NameFormat.LFM =>		REGEXFIND(rgxLFM, s, 5),
			NameFormat.FLorLF => 	'',
			NameFormat.FLcS =>		'',
			NameFormat.FLS =>		'',
			NameFormat.FLSorLFS =>	'',
			
			//NameFormat.FLL =>		'',
			NameFormat.FLL =>		CASE(GetNameOrder(rgxFLL, s, 1, 5, 5, 2, clue),
					/* FML or MLF */	'F' => REGEXFIND(rgxFLL, s, 2),
										'L' => REGEXFIND(rgxFLL, s, 1),
										REGEXFIND(rgxFLL, s, 1)
									),
			NameFormat.FxL =>		'',
			NameFormat.FxLS =>		'',
			NameFormat.LxFM =>		REGEXFIND(rgxLxFM, s, 4),
			NameFormat.FxLL =>		'',
			NameFormat.FMLL =>		REGEXFIND(rgxFMLL, s, 2, NOCASE),
			NameFormat.FMiMiL =>	REGEXFIND(rgxFMiMiL, s, 2),
			NameFormat.LFMiM =>		IF(clue='f',REGEXFIND(rgxLFMiM,s,2),
									CASE(GetNameOrder(rgxLFMiM, s, 1, 2, 4, 1, clue, 2, 4),
										'F' => REGEXFIND(rgxLFMiM, s, 2),
										'L' => REGEXFIND(rgxLFMiM, s, 4),
										REGEXFIND(rgxLFMiM, s, 4)
									)),
			//NameFormat.LFMiM =>		REGEXFIND(rgxLFMiM, s, 3),
			NameFormat.FMML =>		REGEXFIND(rgxFMML, s, 2),
			NameFormat.FMMLS =>		REGEXFIND(rgxFMMLS, s, 2, NOCASE),
			NameFormat.LFMi =>		REGEXFIND(rgxLFMi, s, 5, NOCASE),

			NameFormat.FML =>		REGEXFIND(rgxFML, s, 2),
			NameFormat.FMLorLFM => 	CASE(GetNameOrder(rgxFMLorLFM, s, 1, 4, 5, 1, clue, 4, 5),
										'F' => REGEXFIND(rgxFMLorLFM, s, 4, NOCASE),
										'L' => REGEXFIND(rgxFMLorLFM, s, 5, NOCASE),
										REGEXFIND(rgxFMLorLFM, s, 4, NOCASE)
									),
			NameFormat.FMLSorLFMS => CASE(GetNameOrder(rgxFMLS, s, 1, 2, 3, 1, clue, 2, 3),
										'F' => REGEXFIND(rgxFMLS, s, 2, NOCASE),
										'L' => REGEXFIND(rgxFMLS, s, 3, NOCASE),
										REGEXFIND(rgxFMLS, s, 2, NOCASE)
									),
										//REGEXFIND(rgxFMLS, s, 2, NOCASE),
			NameFormat.LFMicS => 	REGEXFIND(rgxLFMicS, s, 5),
			NameFormat.FMLcS => 	REGEXFIND(rgxFMLcS, s, 2),
			NameFormat.LcTF =>		'',
			NameFormat.LcFMS => 	REGEXFIND(rgxLcFMS, s, 5, NOCASE),
			NameFormat.LcFMcS => 	REGEXFIND(rgxLcFMcS, s, 5),
			NameFormat.LScF => 		'',
			NameFormat.LSFM => 		REGEXFIND(rgxLSFM, s, 6, NOCASE),
			NameFormat.LScFM => 	REGEXFIND(rgxLScFM, s, 8, NOCASE),
			NameFormat.LScFMM => 	REGEXFIND(rgxLScFMM, s, 8),
			NameFormat.LcScF => 	'',
			NameFormat.LcScFM => 	REGEXFIND(rgxLcScFM, s, 8),
			NameFormat.LFMiS =>		REGEXFIND(rgxLFMiS, s, 5, NOCASE),
			NameFormat.LFMS => 		REGEXFIND(rgxLFMS, s, 5),
			NameFormat.FMLLS => 	REGEXFIND(rgxFMLLS, s, 2),
			NameFormat.LcFMM => 	CompoundName(REGEXFIND(rgxLcFMM, s, 5)),
			//NameFormat.LFMMi => 	REGEXFIND(rgxLFMMi, s, 5, NOCASE),
			NameFormat.LFMMi =>		CASE(GetNameOrder(rgxLFMMi, s, 4, 5, 1, 4, clue),
										'F' => REGEXFIND(rgxLFMMi, s, 5),
										'L' => REGEXFIND(rgxLFMMi, s, 6),
										REGEXFIND(rgxLFMMi, s, 5)
									),

			NameFormat.LFi =>		'',
			NameFormat.LFiS =>		'',
			NameFormat.FiL =>		'',
			//NameFormat.FiML =>		REGEXFIND(rgxFiML, s, 2),
			NameFormat.FiML =>		IF(clue='f',REGEXFIND(rgxFiML, s, 2),
									CASE(GetNameOrder(rgxFiML, s, 2, 3, 3, 2, clue, 2, 0),
										'F' => REGEXFIND(rgxFiML, s, 2),
										'L' => REGEXFIND(rgxFiML, s, 1),
										REGEXFIND(rgxFiML, s, 2)
									)),
			NameFormat.FiLS =>		'',
			NameFormat.FiMLS =>		REGEXFIND(rgxFiMLS, s, 2),
			NameFormat.FMiL =>		IF(clue='f',REGEXFIND(rgxFMiL, s, 2),
									CASE(GetNameOrder(rgxFMiL, s, 1, 3, 3, 1, clue, 0, 3),
										'F' => REGEXFIND(rgxFMiL, s, 2),
										'L' => REGEXFIND(rgxFMiL, s, 3),
										REGEXFIND(rgxFMiL, s, 2)
									)),
			NameFormat.FMiLS =>		REGEXFIND(rgxFMiLS, s, 2, NOCASE),
			NameFormat.FMiLI =>		REGEXFIND(rgxFMiLI, s, 2),
			NameFormat.LFcMi =>		REGEXFIND(rgxLFcMi, s, 5, NOCASE),
			NameFormat.LcF =>		'',
			NameFormat.LcFM =>		REGEXFIND(rgxLcFM, s, 5, NOCASE),
			NameFormat.LcFcS =>		'',
			NameFormat.LcFcM =>		REGEXFIND(rgxLcFcM, s, 5),
			NameFormat.LcFcMS =>	REGEXFIND(rgxLcFcMS, s, 5),
			NameFormat.LcFS =>		'',
			NameFormat.LLcFM =>		TRIM(REGEXFIND(rgxLLcFM, s, 8),LEFT,RIGHT),
			NameFormat.LLcFS =>		'',
			NameFormat.LcFhF =>		'',
			NameFormat.FiIIL =>		'',
			NameFormat.SFL =>		'',
			NameFormat.FSL =>		'',
			NameFormat.FMLyL =>		REGEXFIND(rgxFMLyL,s,2,NOCASE),
			
// ** Dual Names			
			NameFormat.LFiaFi =>	'',
			NameFormat.LFiaFiL =>	'',
			NameFormat.LFiMiaFiMi =>REGEXFIND(rgxLFiMiaFiMi, s, 5),
			NameFormat.LFaF =>		'',	
			NameFormat.FMiaFL =>	REGEXFIND(rgxFMiaFL, s, 2),
			NameFormat.LFaFM =>		'',	
			NameFormat.FMLaFML  =>	REGEXFIND(rgxFMLaFML, s, 2, NOCASE),
			NameFormat.FMLcFML  =>	REGEXFIND(rgxFMLcFML, s, 2),
			NameFormat.FMLSaFML  =>	REGEXFIND(rgxFMLSaFML, s, 2, NOCASE),
			NameFormat.LFMaLFM  =>	REGEXFIND(rgxLFMaLFM, s, 5, NOCASE),
			NameFormat.LFMaLFM2  =>	REGEXFIND(rgxLFMaLFM2, s, 5),
			NameFormat.LFMaFML =>	REGEXFIND(rgxLFMaFML, s, 5, NOCASE),
			NameFormat.LFMiaFM  =>	REGEXFIND(rgxLFMiaFM, s, 5, NOCASE),
			NameFormat.LFMiaFMiL => REGEXFIND(rgxLFMiaFMiL, s, 5),
			NameFormat.FLSaFM =>	'',
			NameFormat.LSFaFM =>	'',
			NameFormat.LSFMaFM =>	REGEXFIND(rgxLSFMaFM, s, 6, NOCASE),
			NameFormat.FMiSaFL  =>	REGEXFIND(rgxFMiSaFL, s, 2),
			NameFormat.FMLaFL =>	REGEXFIND(rgxFMLaFL, s, 2),
			NameFormat.FMLaFM =>	CASE(GetNameOrder(rgxFMLaFM, s, 1, 3, 3, 1, clue, 2, 3),
										'F' => REGEXFIND(rgxFMLaFM, s, 2),
										'L' => REGEXFIND(rgxFMLaFM, s, 3),
										REGEXFIND(rgxFMLaFM, s, 2)
									),
			NameFormat.LcFMaFMS =>	REGEXFIND(rgxLcFMaFMS, s, 5, NOCASE),
			NameFormat.LcFMaF =>	REGEXFIND(rgxLcFMaF, s, 5, NOCASE),	
			NameFormat.LcFMaFMM =>	NameOrGen(rgxLcFMaFMM, s, 5, false),
			NameFormat.FMaFLS =>	IF(REGEXFIND(rgxFMaFLS, s, 2)=REGEXFIND(rgxFMaFLS, s, 5),
										'',REGEXFIND(rgxFMaFLS, s, 2)),
			NameFormat.LFaFMS =>	'',
			NameFormat.FMaFML =>	IF(IsSureGen(REGEXFIND(rgxFMaFML, s, 2)),'',
													REGEXFIND(rgxFMaFML, s, 2)),
			NameFormat.FiaFiL =>	'',
			NameFormat.FaFL =>		'',
			NameFormat.FaFML =>		'',
			NameFormat.LcFMSaFMM =>	REGEXFIND(rgxLcFMSaFMM, s, 5, NOCASE),
			NameFormat.LFMSaFMM =>	CASE(GetNameOrder(rgxLFMSaFMM, s, 1, 5, 4, 1, clue, 4, 5),
										'F' => REGEXFIND(rgxLFMSaFMM, s, 4),
										'L' => REGEXFIND(rgxLFMSaFMM, s, 5),
										REGEXFIND(rgxLFMSaFMM, s, 4)
									),
			NameFormat.LcFaF 	=>	'',
			NameFormat.LcFaFM 	=>	'',
			NameFormat.LcFMaLcFM =>	REGEXFIND(rgxLcFMaLcFM, s, 5, NOCASE),
			NameFormat.LcFaLcF =>	'',
			''));



export string MiddleName2(string s, NameFormat n) := 
	TRIM(CASE (n,
			// Dual Names
			NameFormat.LFiaFi =>	'',
			NameFormat.LFiaFiL =>	'',
			NameFormat.LFiMiaFiMi =>REGEXFIND(rgxLFiMiaFiMi, s, 8),
			NameFormat.LFaF =>		'',	
			NameFormat.FMiaFL =>	'',
			NameFormat.LFaFM =>		REGEXFIND(rgxLFaFM, s, 7, NOCASE),	
			NameFormat.FMLaFML  =>	REGEXFIND(rgxFMLaFML, s, 8, NOCASE),
			NameFormat.FMLcFML  =>	REGEXFIND(rgxFMLcFML, s, 7),
			NameFormat.FMLSaFML  =>	REGEXFIND(rgxFMLSaFML, s, 9, NOCASE),
			NameFormat.LFMaLFM  =>	REGEXFIND(rgxLFMaLFM, s, 8, NOCASE),
			NameFormat.LFMaLFM2  =>	REGEXFIND(rgxLFMaLFM2, s, 9),
			NameFormat.LFMaFML =>	REGEXFIND(rgxLFMaFML, s, 8, NOCASE),
			NameFormat.LFMiaFM  =>	REGEXFIND(rgxLFMiaFM, s, 8, NOCASE),
			NameFormat.LFMiaFMiL => REGEXFIND(rgxLFMiaFMiL, s, 8),
			NameFormat.FLSaFM =>	REGEXFIND(rgxFLSaFM, s, 8, NOCASE),
			NameFormat.LSFaFM =>	REGEXFIND(rgxLSFaFM, s, 8, NOCASE),
			NameFormat.LSFMaFM =>	REGEXFIND(rgxLSFMaFM, s, 9, NOCASE),
			NameFormat.FMiSaFL  =>	'',
			NameFormat.FMLaFL =>	'',
			NameFormat.FMLaFM =>	REGEXFIND(rgxFMLaFM, s, 8),
			NameFormat.LcFMaFMS =>	REGEXFIND(rgxLcFMaFMS, s, 8, NOCASE),
			NameFormat.LcFMaF =>	'',
			NameFormat.LcFMaFMM =>	TRIM(REGEXFIND(rgxLcFMaFMM, s, 8),LEFT,RIGHT),
			NameFormat.FMaFLS =>	'',
			NameFormat.LFaFMS =>	REGEXFIND(rgxLFaFMS, s, 7),
			NameFormat.FMaFML =>	REGEXFIND(rgxFMaFML, s, 5, NOCASE),
			NameFormat.FiaFiL =>	'',
			NameFormat.FaFL =>		'',
			NameFormat.FaFML =>		REGEXFIND(rgxFaFML, s, 4, NOCASE),
			NameFormat.LcFMSaFMM =>	TRIM(REGEXFIND(rgxLcFMSaFMM, s, 9, NOCASE),LEFT,RIGHT),
			NameFormat.LFMSaFMM =>	TRIM(REGEXFIND(rgxLFMSaFMM, s, 11),LEFT,RIGHT),
			NameFormat.LcFaF 	=>	'',
			NameFormat.LcFaFM 	=>	REGEXFIND(rgxLcFaFM, s, 7, NOCASE),
			NameFormat.LcFMaLcFM =>	REGEXFIND(rgxLcFMaLcFM, s, 11, NOCASE),
			NameFormat.LcFaLcF =>	'',
			''),LEFT);

shared string GenToAlpha(string suffix) :=
		IF(IsGeneration(suffix), suffix,
		CASE(suffix,
			'' => '',
			'1' => 'SR',
			'2' => 'JR',
			'3' => 'III',
			'4' => 'IV',
			'5' => 'V',
			'6' => '',
			'7' => '',
			'8' => '',
			'9' => '',
			//'6' => 'VII',
			//'7' => 'VIII',
			'1ST' => 'I',
			'2N' => 'II',
			'2ND' => 'II',
			'ND' => 'II',
			'3RD' => 'III',
			'RD' => 'III',
			'4TH' => 'IV',
			'5TH' => 'V',
			'6TH' => 'VI',
			'000' => '',
			''));


export string NameSuffix(string s, NameFormat n) := 
	genToAlpha(CASE (n,
			NameFormat.NoName =>	'',
			NameFormat.FL =>		'',
			NameFormat.LF =>		'',
			NameFormat.LFM =>		'',
			NameFormat.FLorLF => 	'',
			NameFormat.FLcS =>		REGEXFIND(rgxFLcS, s, 6),
			NameFormat.FLS =>		REGEXFIND(rgxFLS, s, 5, NOCASE),
			NameFormat.FLSorLFS =>	REGEXFIND(rgxFLSorLFS, s, 3, NOCASE),
			
			NameFormat.FLL =>		'',
			NameFormat.FxL =>		'',
			NameFormat.FxLS =>		REGEXFIND(rgxFxLS, s, 5, NOCASE),
			NameFormat.LxFM =>		'',
			NameFormat.FxLL =>		'',
			NameFormat.FMLL =>		'',
			NameFormat.FMiMiL =>	'',
			NameFormat.LFMiM =>		'',
			NameFormat.FMML =>		'',
			NameFormat.FMMLS =>		REGEXFIND(rgxFMMLS, s, 6, NOCASE),
			NameFormat.LFMi =>		'',

			NameFormat.FML => 		'',
			NameFormat.FMLorLFM => 	'',
			NameFormat.FMLSorLFMS => REGEXFIND(rgxFMLS, s, 6, NOCASE),
			NameFormat.LFMicS => 	REGEXFIND(rgxLFMicS, s, 6),
			NameFormat.FMLcS => 	REGEXFIND(rgxFMLcS, s, 6),
			NameFormat.LcFMS => 	REGEXFIND(rgxLcFMS, s, 6, NOCASE),
			NameFormat.LcFMcS => 	REGEXFIND(rgxLcFMcS, s, 6),
			NameFormat.LScF => 		REGEXFIND(rgxLScF, s, 4, NOCASE),
			NameFormat.LSFM => 		REGEXFIND(rgxLSFM, s, 4, NOCASE),
			NameFormat.LScFM => 	REGEXFIND(rgxLScFM, s, 4),
			NameFormat.LScFMM => 	REGEXFIND(rgxLScFMM, s, 4),
			NameFormat.LcScF => 	REGEXFIND(rgxLcScF, s, 4),
			NameFormat.LcScFM => 	REGEXFIND(rgxLcScFM, s, 4),
			NameFormat.LFMiS =>		REGEXFIND(rgxLFMiS, s, 6, NOCASE),
			NameFormat.LFMS => 		REGEXFIND(rgxLFMS, s, 6, NOCASE),
			NameFormat.FMLLS => 	REGEXFIND(rgxFMLLS, s, 9, NOCASE),
			NameFormat.LcFMM => 	'',
			NameFormat.LFMMi => 	'',
			//NameFormat.FiMiL =>		s[1],
			NameFormat.LFi =>		'',
			NameFormat.LFiS =>		REGEXFIND(rgxLFiS, s, 5, NOCASE),
			NameFormat.FiL =>		'',
			NameFormat.FiML =>		'',
			NameFormat.FiLS =>		REGEXFIND(rgxFiLS, s, 5, NOCASE),
			NameFormat.FiMLS =>		REGEXFIND(rgxFiMLS, s, 6, NOCASE),
			NameFormat.FMiL =>		'',
			NameFormat.FMiLS =>		REGEXFIND(rgxFMiLS, s, 6, NOCASE),
			NameFormat.FMiLI =>		'',
			NameFormat.LFcMi =>		'',
			NameFormat.LcF =>		'',
			NameFormat.LcFM =>		'',
			NameFormat.LcFcS =>		REGEXFIND(rgxLcFcS, s, 5),
			NameFormat.LcFcM =>		'',
			NameFormat.LcFcMS =>	REGEXFIND(rgxLcFcMS, s, 6),
			NameFormat.LcFS =>		REGEXFIND(rgxLcFS, s, 5),
			NameFormat.LLcFS =>		REGEXFIND(rgxLLcFS, s, 8),
			NameFormat.LLcFM =>		'',
			NameFormat.LcFhF =>		'',
			NameFormat.FiIIL =>		'',
			NameFormat.SFL =>		REGEXFIND(rgxSFL, s, 1),
			NameFormat.FSL =>		REGEXFIND(rgxFSL, s, 2),
			
// Dual Names
			NameFormat.LFiaFi =>	'',
			NameFormat.LFiaFiL =>	'',
			NameFormat.LFiMiaFiMi =>'',
			NameFormat.LFaF =>		'',	
			NameFormat.FMiaFL =>	'',
			NameFormat.LFaFM =>		'',	
			NameFormat.FMLaFML  =>	'',
			NameFormat.FMLcFML  =>	'',
			NameFormat.FMLSaFML  =>	REGEXFIND(rgxFMLSaFML, s, 6, NOCASE),
			NameFormat.LFMaLFM  =>	'',
			NameFormat.LFMaLFM2  =>	'',
			NameFormat.LFMaFML =>	'',
			NameFormat.LFMiaFM  =>	'',
			NameFormat.LFMiaFMiL => '',
			NameFormat.FLSaFM =>	REGEXFIND(rgxFLSaFM, s, 5, NOCASE),
			NameFormat.LSFaFM =>	REGEXFIND(rgxLSFaFM, s, 4, NOCASE),
			NameFormat.LSFMaFM =>	REGEXFIND(rgxLSFMaFM, s, 4, NOCASE),
			NameFormat.LFiSaI  =>	REGEXFIND(rgxLFiSaI, s, 5),
			NameFormat.FMiSaFL  =>	REGEXFIND(rgxFMiSaFL, s, 3),
			NameFormat.FMLaFL =>	'',
			NameFormat.FMLaFM =>	'',
			NameFormat.LcFMaFMS =>	'',
			NameFormat.LcFMaF =>	'',
			NameFormat.LcFMaFMM =>	NameOrGen(rgxLcFMaFMM, s, 5, true),
			NameFormat.FMaFLS =>	'',
			NameFormat.LFaFMS =>	'',
			NameFormat.FMaFML =>	IF(IsSureGen(REGEXFIND(rgxFMaFML, s, 2)),
													REGEXFIND(rgxFMaFML, s, 2),''),
			NameFormat.FiaFiL =>	'',
			NameFormat.FaFL =>		'',
			NameFormat.FaFML =>		'',
			NameFormat.LcFMSaFMM =>	REGEXFIND(rgxLcFMSaFMM, s, 6, NOCASE),
			NameFormat.LFMSaFMM =>	REGEXFIND(rgxLFMSaFMM, s, 6),
			NameFormat.LcFaF 	=>	'',
			NameFormat.LcFaFM 	=>	'',
			NameFormat.LcFMaLcFM =>	'',
			NameFormat.LcFaLcF =>	'',
			''));

			
export string NameSuffix2(string s, NameFormat n) :=
	genToAlpha(CASE (n,
			// Dual Names
			NameFormat.LFiaFi =>	'',
			NameFormat.LFiaFiL =>	'',
			NameFormat.LFiMiaFiMi =>'',
			NameFormat.LFaF =>		'',	
			NameFormat.LFaFM =>		'',	
			NameFormat.FMLaFML  =>	'',
			NameFormat.FMLcFML  =>	'',
			NameFormat.FMLSaFML  =>	'',
			NameFormat.LFMaLFM  =>	'',
			NameFormat.LFMaLFM2  =>	'',
			NameFormat.LFMaFML =>	'',
			NameFormat.LFMiaFM  =>	'',
			NameFormat.LFMiaFMiL => '',
			NameFormat.FLSaFM =>	'',
			NameFormat.LSFaFM =>	'',
			NameFormat.LSFMaFM =>	'',
			NameFormat.FMiSaFL  =>	'',
			NameFormat.FMLaFL =>	'',
			NameFormat.FMLaFM =>	'',
			NameFormat.LcFMaFMS =>	REGEXFIND(rgxLcFMaFMS, s, 10),
			NameFormat.LcFMaF =>	'',
			NameFormat.LcFMaFMM =>	'',
			NameFormat.FMaFLS =>	REGEXFIND(rgxFMaFLS, s, 9),
			NameFormat.LFaFMS =>	REGEXFIND(rgxLFaFMS, s, 8),
			NameFormat.FMaFML =>	'',
			NameFormat.FiaFiL =>	'',
			NameFormat.FaFL =>		'',
			NameFormat.FaFML =>		'',
			NameFormat.LcFMSaFMM =>	'',
			NameFormat.LFMSaFMM =>	'',
			NameFormat.LcFaF 	=>	'',
			NameFormat.LcFaFM 	=>	'',
			NameFormat.LcFMaLcFM =>	'',
			NameFormat.LcFaLcF =>	'',
		''));
			
shared titles :=
 '\\b(MR|MRS|MS|MMS|MISS|DR|REV|RABBI|REVEREND|PROF|LT COL|COL|LCOL|LTCOL|LT GEN|LT CDR|MAJ|SFC|SRTA|APCO|CAPT|SGT|CPO|SHRF|SMSG|SMSGT)\\b';
export string Title (string s, NameFormat n, string1 clue='U', string fullname='') := 
	MAP(
		n = NameFormat.LcTF =>		REGEXFIND(rgxLcTF, s, 4),
		REGEXFIND(titles, fullname) => REGEXFIND(titles, fullname, 1),
		REGEXFIND(rgxMrMrs, fullname) => REGEXFIND(rgxMrMrs, fullname, 2),
		CASE(genderEx(FirstName(s, n, clue),MiddleName(s, n, clue)),
			'M' => 'MR',
			'F' => 'MS',
		'')
	);

export string Title2 (string s, NameFormat n, string fullname='') := 
		CASE(genderEx(FirstName2(s, n),MiddleName2(s, n)),
			'M' => 'MR',
			'F' => 'MS',
			'');
/*	MAP(
		REGEXFIND(rgxMrMrs, fullname) => REGEXFIND(rgxMrMrs, fullname, 4),
		CASE(gender(FirstName2(s, n)),
			1 => 'MR',
			2 => 'MS',
			'')
	);
*/	
boolean IsHyphenatedFirstName(string s) := MAP(
	REGEXFIND('([A-Z]+)-([A-Z]+)', s) => IsFirstName(s) OR
											IsFirstName(REGEXFIND('([A-Z]+)-([A-Z]+)', s, 1)),
	IsFirstname(s));
	
boolean IsFirstNameNotI(string s) :=
	IF (Length(s) < 2, false, IsFirstName(s));

//		LFaF, LFaFM, FMLaFM, LFMiaFM, LcFMaFMM, LcFMaFMS, LFMaFML, FMLaFML, LFMaLFM, FMaFML, FaFL, FaFML, LcFaF, LcFaFM, LcFMSaFMM, LFMSaFMM, LcFMaLcFM,
//		FMLSaFML
export boolean ValidDualName(string s, integer2 format) := 
	CASE (format,
			NameFormat.NoName =>	false,
			NameFormat.FMLaFML  =>	true,		// this is a validated format
			NameFormat.FMLcFML  =>	true,		// this is a validated format
			NameFormat.FMLSaFML  =>	true,		// this is a validated format
			NameFormat.LFMaLFM  =>	true,		// this is a validated format
			NameFormat.LFMaLFM2  =>	true,		// this is a validated format
			NameFormat.LFMaFML  =>	true,		// this is a validated format
			NameFormat.LFiaFiL =>	true,
			// likely dual name formats
			NameFormat.LcFaFM => true,
			NameFormat.LcFMaLcFM => true,
			NameFormat.LcFaLcF => true,
			NameFormat.LcFMaFMM => true,
			NameFormat.LcFMaFMS => true,
			NameFormat.LcFMaF => true,
			NameFormat.FLSaFM => true,
			NameFormat.LSFaFM => true,
			NameFormat.LFMiaFMiL => true,
			NameFormat.LFaFMS => true,
			NameFormat.LSFMaFM => true,
									//IsFirstName(REGEXFIND(rgxLFMaFML, s, 4, NOCASE)) AND
									//IsFirstName(REGEXFIND(rgxLFMaFML, s, 7, NOCASE)),
			NameFormat.FMLaFL =>	true,
			NameFormat.FMLaFM  =>	(IsFirstName(REGEXFIND(rgxFMLaFM, s, 1)) OR IsFirstName(REGEXFIND(rgxFMLaFM, s, 2)))
										AND
									(IsFirstName(REGEXFIND(rgxFMLaFM, s, 7)) OR LENGTH(REGEXFIND(rgxFMLaFM, s, 8)) = 1),
			NameFormat.LcFaF => IsFirstName(FirstName(s,format)) OR IsHyphenatedFirstName(FirstName2(s,format)),
			NameFormat.MrMrs => true,
			NameFormat.FiaFiL => ProbableLastName(LastName(s,format)),
			NameFormat.LFiaFi => ProbableLastName(LastName(s,format)),
			NameFormat.LFiMiaFiMi =>ProbableLastName(LastName(s,format)),
			NameFormat.LFaF => ProbableLastName(LastName(s,format)) OR 
								(IsFirstName(FirstName(s,format)) AND
								IsFirstName(FirstName2(s,format))),
			IsFirstNameNotI(FirstName(s,format)) OR IsFirstNameNotI(FirstName2(s,format)) 
			//	OR IsLastNameConfirmed(LastName(s,format))
			//	OR	((NOT IsLastNameConfirmed(FirstName(s,format))) AND (NOT IsLastNameConfirmed(FirstName2(s,format))))
			);

shared boolean IsDualFmtValid(string s) := MAP(
	REGEXFIND('\\b[B-DF-HJ-NP-TVWXZ]+Q\\b', s) => false,
	REGEXFIND('\\b[B-DF-HJ-NP-TVWXZ]{4,}\\b', s) => false,
	REGEXFIND('\\b[A-Z] +OR +(JR|SR)$', s) => false,
	REGEXFIND('^[A-Z]+ +(JR|SR) *' + rgxConnector + ' *[A-Z]+$', s) => false,
	REGEXFIND('\\b(AND|OR)$', s) => false,
	REGEXFIND('^[A-Z]+ +[A-Z] +OR +[A-Z]+$', s) => false,	// LEE O OR DEES
	REGEXFIND('\\b(PT|LT|FT|TE|DL)\\b',s) => false,  // unprocessed abbreviations
	true
);

export boolean IsDualName(string s) := FUNCTION
	fmt := DualNameFormat(s);
	return MAP(
		NOT REGEXFIND(rgxConnector, s) AND NOT REGEXFIND(rgxFMLcFML,s) => false,
		REGEXFIND('\\b[B-DF-HJ-NP-TVWXZ]+Q\\b', s) => false,
		REGEXFIND('\\b[B-DF-HJ-NP-TVWXZ]{4,}\\b', s) => false,
		//REGEXFIND('\\b[A-Z] +OR +(JR|SR)$', s) => false,
		REGEXFIND('\\b[A-Z]+ *( AND | OR |&) *(JR|SR|II|III|IV)$', s) => false,
		//REGEXFIND('\\b[A-Z]+ *( AND |&) *[A-Z]$', s) => false,
		REGEXFIND('^[A-Z]+ +(JR|SR) *' + rgxConnector + ' *[A-Z]+$', s) => false,
		REGEXFIND('^[A-Z]+ +[A-Z] +OR +[A-Z]+$', s) => false,	// LEE O OR DEES
		REGEXFIND('\\b(PT|LT|FT|TE|DL)\\b',s) => false,  // unprocessed abbreviations
		InvalidLastName(LastName(s,fmt)) => false,
		ValidDualName(s, fmt)
	);
END;

// check for a last name in the expected place
rgx_any := '([A-Z\'-]+)([^A-Z]+)?([A-Z\'-]+)?([^A-Z]+)?([A-Z\'-]+)?([^A-Z]+)?([A-Z\'-]+)?([^A-Z]+)?([A-Z\'-]+)?([^A-Z]+)?([A-Z]+)?([^A-Z]+)?([A-Z]+)?([^A-Z]+)?([A-Z]+)?';


// check for a first name in the expected place
//shared	titles := '^MMS\\b(.+)';

shared set of NameFormat LikelyNameFormats := [
	NameFormat.FL, NameFormat.LF, NameFormat.LFM, NameFormat.FLcS, NameFormat.FLS, NameFormat.FLSorLFS, NameFormat.FMLLS,
	NameFormat.FiL,NameFormat.FiMLS,NameFormat.FiLS, //NameFormat.FiMiL,
	NameFormat.FMiL, NameFormat.FMiLS, NameFormat.LSFM, NameFormat.FMLSorLFMS,
	/*NameFormat.LFi,*/ NameFormat.LFiS, NameFormat.LFMS, NameFormat.LFMiS,
	NameFormat.LcFMS, NameFormat.LcFMcS,NameFormat.LcFcMS,
	NameFormat.LScFM, NameFormat.LScFMM, NameFormat.LcScFM, NameFormat.LcScF, NameFormat.LScF,
	NameFormat.LcF, NameFormat.LFMi, NameFormat.LcFhF, NameFormat.FiIIL, NameFormat.SFL, NameFormat.FSL,
	NameFormat.FMMLS, NameFormat.LcFM, NameFormat.LcFS, NameFormat.LcFcS, NameFormat.LcTF,
	NameFormat.LFMicS
	];
	
shared set of NameFormat PossibleNameFormats := [
	NameFormat.FMiMiL
	];
	
export boolean IsLikelyPersonalNameFormat(NameFormat fmt) := 
	MAP(
		NOT validPersonNameFormat(fmt) => FALSE,
		fmt in LikelyNameFormats => TRUE,
		FALSE);

export boolean IsSomewhatLikelyPersonalNameFormat(NameFormat fmt) := 
		fmt in [NameFormat.FLorLF,NameFormat.FMLorLFM,NameFormat.FMLL];


// use for compound names
//rgxHyphenatedname := '^([A-Z\']+)-([A-Z][A-Z\']+)$';
export boolean IsLastNameEither(string name, integer fmt, string1 hint='U') := FUNCTION
	lname := LastName(name, fmt, hint);
	return MAP(
	fmt = NameFormat.FMLL => IsLastNameEx(REGEXFIND(rgxFMLL, name, 3)) OR IsLastNameEx(REGEXFIND(rgxFMLL, name, 6)),
	fmt = NameFormat.LLcFM =>	IsLastNameEx(REGEXFIND(rgxLLcFM, name, 1)) OR IsLastNameEx(REGEXFIND(rgxLLcFM, name, 4)),
	fmt = NameFormat.LLcFS =>	IsLastNameEx(REGEXFIND(rgxLLcFS, name, 1)) OR IsLastNameEx(REGEXFIND(rgxLLcFS, name, 4)),
	fmt = NameFormat.FMLyL => IsLastNameEx(REGEXFIND(rgxFMLyL,name,4,NOCASE)) OR IsLastNameEx(REGEXFIND(rgxFMLyL,name,5,NOCASE)),
	
	StringLib.StringFind(name, '-', 1) > 0 => IsLastNameEx(REGEXFIND(rgxHyphenatedname, lname, 1, NOCASE)) OR IsLastNameEx(REGEXFIND(rgxHyphenatedname, lname, 2, NOCASE)),		
	IsLastNameEx(lname) => true,
	false
	);
END;

shared boolean IsActualFirstName(string s) :=
	IF(LENGTH(s) > 1, IsFirstNameOrHyphenated(s), false);

// this is a loose version allowing extra name formats
// it assumes no business words are in name
export boolean IsProbableName(string name) := FUNCTION
	n := SingleNameFormat(name);
	//RETURN IF(validPersonNameFormat(n), IsFirstName(fname), false);
	RETURN MAP(
		name = '' => false,
		NOT validPersonNameFormat(n) => false,
		InvalidNameFormat(name) => false,
		n in LikelyNameFormats => true,
		n = NameFormat.LFi => NOT ProbableFirstName(REGEXFIND(rgxLFi, name, 1)),
		IsFirstName(FirstName(name, n)) => true,
		IsLastNameEither(name, n) => true,
		n in [NameFormat.FLorLF,NameFormat.FMLorLFM,NameFormat.FMLL] => true, // riskiest assumption
		false
	);
END;


shared set of NameFormat FirstNameFirst := [
	NameFormat.FL, NameFormat.FLcS, NameFormat.FLS, NameFormat.FMLLS, 
	NameFormat.FiML, NameFormat.FiL,NameFormat.FiMLS,NameFormat.FiLS,	//NameFormat.FiMiL,
	NameFormat.FMLcS, NameFormat.FMiLS, NameFormat.FLL, NameFormat.FMiLI,
	NameFormat.FxL, NameFormat.FxLS, NameFormat.FxLL,	NameFormat.FSL, NameFormat.FML,
	NameFormat.FMLL, NameFormat.FMiMiL, NameFormat.FMML, NameFormat.FMMLS, NameFormat.FiIIL, NameFormat.FMLyL
	];

shared set of NameFormat LastNameFirst := [
	NameFormat.LF, NameFormat.LFM, NameFormat.LFi, NameFormat.LFiS, NameFormat.LFMS, NameFormat.LFMiS, 
	NameFormat.LcFMS, NameFormat.LcFMcS, NameFormat.LScF, NameFormat.LScFM, NameFormat.LScFMM,
	NameFormat.LcScFM,NameFormat.LcScF,	NameFormat.LxFM,
	NameFormat.LcFMM, NameFormat.LFMi, /*NameFormat.LFMMi,*/ NameFormat.LFcMi, NameFormat.LSFM,
	NameFormat.LcF, NameFormat.LcFM, NameFormat.LcFcM, NameFormat.LcFcMS,
	NameFormat.LcFcS, NameFormat.LcFS, NameFormat.LLcFM, NameFormat.LLcFS, NameFormat.LcFhF,
	NameFormat.LFMiM, NameFormat.LFMicS
	];
shared set of NameFormat NameFML := [
	NameFormat.FL, NameFormat.FLcS, NameFormat.FLS, NameFormat.FMLLS, 
	NameFormat.FiML, NameFormat.FiL,NameFormat.FiMLS,NameFormat.FiLS,	//NameFormat.FiMiL,
	NameFormat.FMLcS, NameFormat.FMiLS, NameFormat.FLL, NameFormat.FMiLI,
	NameFormat.FxL, NameFormat.FxLS, NameFormat.FxLL, NameFormat.FML,
	NameFormat.FMLL, NameFormat.FMiMiL, NameFormat.FMML, NameFormat.FMMLS,	NameFormat.FiIIL, NameFormat.FMLyL
	];

shared set of NameFormat NameLFM := [
	NameFormat.LF, NameFormat.LFM, NameFormat.LFi, NameFormat.LFMS, NameFormat.LFMiS, 
	NameFormat.LcFMS, NameFormat.LcFMcS, NameFormat.LScFM, NameFormat.LScFMM,
	NameFormat.LcFMM, NameFormat.LFMi, /*NameFormat.LFMMi,*/ NameFormat.LFcMi, 
	NameFormat.LcF, NameFormat.LcFM, NameFormat.LcFcM, NameFormat.LcFcMS,
	NameFormat.LcFcS, NameFormat.LLcFM, NameFormat.LLcFS, NameFormat.LxFM, NameFormat.LcFhF,
	NameFormat.LFMiM, NameFormat.LFMicS
	];	
// to replace IsProbableName
		//Persons.InvalidNameFormat(name) => MatchType.Inv,
		//Persons.IsJustLastName(name) => MatchType.Unclass,
export NameStatus := enum(UNSIGNED2, NotAName = 0, InvalidNameFormat = 1,
				StandaloneName = 2, 
				ProbableName = 3, PossibleName = 4, ImprobableName = 5,
				PossibleDualName = 6);
types := ['X','F','L','B'];
string1 GetNameClass(string nm) :=
	types[IF (IsFirstNameOrHyphenated(nm),1,0) +
	IF (IsLastNameConfirmed(nm),2,0) + 1];
	//IF (IsLastNameExOrHyphenated(nm),2,0) + 1];
	
NameStatus VerifyNameNotUsed(string name1, string name2) := FUNCTION
	s := GetNameClass(name1) + GetNameClass(name2);
	return MAP(
		s = 'XX' => NameStatus.ImprobableName,
		s[1] = 'X' OR s[2] = 'X' => NameStatus.PossibleName,
		s in ['FF','LL'] => NameStatus.PossibleName,
		NameStatus.ProbableName);
END;

NameStatus VerifyNameOrder(string2 s, string1 hint='U') := FUNCTION
	return MAP(
		s = 'XX' => NameStatus.ImprobableName,
		s in ['FF','LL','BX','XB'] => NameStatus.PossibleName,
		s = 'BB' => NameStatus.ProbableName,
		hint = 'F' => MAP(
					s in ['FL','FB','BL'] => NameStatus.ProbableName,
					s in ['LF','XF','LX'] => NameStatus.ImprobableName,
					NameStatus.PossibleName),
		hint = 'L' => MAP(
					s in ['LF','LB','BF'] => NameStatus.ProbableName,
					s in ['FL','FX','XL'] => NameStatus.ImprobableName,
					NameStatus.PossibleName),
		s[1] = 'X' OR s[2] = 'X' => NameStatus.PossibleName,
		NameStatus.ProbableName);
END;

NameStatus VerifyName(string name1, string name2, string1 hint='U') := FUNCTION
	s := GetNameClass(name1) + GetNameClass(name2);
	return VerifyNameOrder(s, hint);
END;

NameStatus VerifyName2(string name1, string name2, string name3, string1 hint='U') := FUNCTION
	s := If(length(name1) > 1, GetNameClass(name1), GetNameClass(name3)) 
			+ GetNameClass(name2);

	return VerifyNameOrder(s, hint);
END;

NameStatus VerifyHyphenatedName(string fname, string lname) := FUNCTION
	s := IF(IsFirstname(fname), 'F', 'X') +
		IF(IsLastNameEx(REGEXFIND(rgxHyphenatedname, lname, 1)) OR
		IsLastNameEx(REGEXFIND(rgxHyphenatedname, lname, 2)),'B','L');
	return VerifyNameOrder(s, 'F');
END;

NameStatus VerifyPossibleName(string fname, string lname) := 
	IF(IsFirstname(fname) and IsLastNameEx(lname),NameStatus.ProbableName,NameStatus.PossibleName);


/*
NameStatus VerifyName2(string name1, string name2, string name3) := FUNCTION
	s := If(length(name1) > 1, GetNameClass(name1), GetNameClass(name3)) 
			+ GetNameClass(name2);
	return MAP(
		s = 'XX' => NameStatus.ImprobableName,
		s[1] = 'X' OR s[2] = 'X' => NameStatus.PossibleName,
		NameStatus.ProbableName);
END;*/

export NameStatus ValidateName(string name,string1 hint='U') := FUNCTION
	n := PersonalNameFormat(name);
	//RETURN IF(validPersonNameFormat(n), IsFirstName(fname), false);
	RETURN MAP(
		TRIM(name) = '' => NameStatus.NotAName,
		IsNameFormatDual(n) => IF(IsDualFmtValid(name),	NameStatus.PossibleDualName,
									NameStatus.InvalidNameFormat),
		NOT validPersonNameFormat(n) => NameStatus.NotAName,
		InvalidNameFormat(name) => NameStatus.InvalidNameFormat,
		IsJustLastName(name) => NameStatus.StandaloneName,
		n in LikelyNameFormats => NameStatus.ProbableName,
		n = NameFormat.LFi => IF(IsLastNameExOrHyphenated(REGEXFIND(rgxLFi, name, 1)),
									NameStatus.ProbableName,NameStatus.PossibleName),
		REGEXFIND(rgxFLhL, name) => VerifyHyphenatedName(REGEXFIND(rgxFLhL, name, 1),REGEXFIND(rgxFLhL, name,2)),
		n = NameFormat.FLorLF => VerifyName(FirstName(name, n, hint),LastName(name, n, hint)),
				//IF(IsFirstNameOrHyphenated(FirstName(name, n)) OR IsLastNameEither(name, n),
				//NameStatus.ProbableName,
				//NameStatus.PossibleName),
		n = NameFormat.FMLorLFM => 
					VerifyName2(FirstName(name, n, hint),LastName(name, n, hint),
								MiddleName(name, n, hint)),
		n = NameFormat.FMLL => 
					VerifyName2(FirstName(name, n, 'F'),REGEXFIND(rgxFMLL, name, 6),
								MiddleName(name, n, 'F')),
		n = NameFormat.FiML => IF(hint='f',if(IsLastname(REGEXFIND(rgxFiML,name,3)),
								NameStatus.ProbableName,NameStatus.PossibleName),
							VerifyName(MiddleName(name, n),LastName(name, n),'U')),
			//IF(IsActualFirstName(FirstName(name, n)) AND IsLastNameEither(name, n),
			//	NameStatus.ProbableName,
			//	NameStatus.PossibleName),	// riskiest assumption
		//IsFirstName(FirstName(name, n, hint)) => NameStatus.ProbableName,
		//IsLastNameEither(name, n, hint) => NameStatus.ProbableName,
		//%IsActualFirstName(FirstName(name, n, hint)) AND IsLastNameEither(name, n, hint) => NameStatus.ProbableName,
		//%IsActualFirstName(FirstName(name, n, hint)) OR IsLastNameEither(name, n, hint) => NameStatus.PossibleName,
		//%NameStatus.ImprobableName
		n IN PossibleNameFormats => VerifyPossibleName(FirstName(name, n),LastName(name, n)),
		n IN FirstNameFirst	=> VerifyName(FirstName(name, n),LastName(name, n),'F'),
		//n IN LastNameFirst	=> VerifyName(FirstName(name, n),LastName(name, n),'L'),
		n IN LastNameFirst	=> VerifyName(LastName(name, n),FirstName(name, n),'L'),
		VerifyName(FirstName(name, n, hint),LastName(name, n, hint),hint)
	);
END;

export boolean IsPersonalName(string name) := FUNCTION
	n := SingleNameFormat(name);
	//RETURN IF(validPersonNameFormat(n), IsFirstName(FirstName(name, n)), false);
	RETURN MAP(
		NOT validPersonNameFormat(n) => FALSE,
		InvalidNameFormat(name) => FALSE,
		n in LikelyNameFormats => TRUE,
		n = NameFormat.LFi => NOT ProbableFirstName(REGEXFIND(rgxLFi, name, 1)),
		IsJustLastName(name) => FALSE,
		IsFirstName(FirstName(name, n)) => TRUE,
		IsLastNameEither(name, n) => TRUE,
		FALSE);
END;

export boolean IsLikelyPersonalName(string name) := FUNCTION
	n := SingleNameFormat(name);
	RETURN MAP(
		NOT validPersonNameFormat(n) => FALSE,
		n in LikelyNameFormats => TRUE,
		n = NameFormat.LFi => NOT ProbableFirstName(REGEXFIND(rgxLFi, name, 1)),
		IsJustLastName(name) => FALSE,
		IsFirstName(FirstName(name, n)) => TRUE,
		FALSE);
END;

export boolean IsConfirmedName(string name) := FUNCTION
	n := SingleNameFormat(name);
	//RETURN IF(validPersonNameFormat(n), IsFirstName(FirstName(name, n)), false);
	RETURN IF(
		validPersonNameFormat(n), 
			IsFirstName(FirstName(name, n)) AND
			IsLastNameEither(name, n),
		FALSE);
END;



// valid first or last name
export boolean IsLikelyName(string s) := FUNCTION
	fmt := SingleNameFormat(s);
	RETURN MAP(
		fmt = NameFormat.NoName =>	false,
		fmt in LikelyNameFormats => TRUE,
		fmt = NameFormat.LFi => NOT ProbableFirstName(REGEXFIND(rgxLFi, s, 1)),
		IsFirstName(FirstName(s,fmt)) => TRUE,
		IsLastNameEither(s,fmt)
	);
END;

// matches a supported name format
export boolean IsPossibleName(string name) := FUNCTION
	fmt := SingleNameFormat(name);
	RETURN MAP(
		fmt = NameFormat.NoName =>	false,
		InvalidNameFormat(name) => false,
		false
	);
END;

shared set of NameFormat StandAloneNameFormats := [
	NameFormat.FL, NameFormat.FLS, NameFormat.FLSorLFS, NameFormat.FMLLS,
	NameFormat.FiML,NameFormat.FiL,NameFormat.FiMLS,NameFormat.FiLS, //NameFormat.FiMiL,
	NameFormat.FMiL, NameFormat.FMiLS, NameFormat.FMLSorLFMS,
	/*NameFormat.LFMi,*/ NameFormat.FiIIL, /*NameFormat.FSL,*/
	NameFormat.FMMLS, NameFormat.FLorLF,NameFormat.FMLorLFM,NameFormat.FMLL
	];
IsStandAloneNameFormat(integer fmt) := fmt in StandAloneNameFormats;
// validate that part of a name is itself a name
boolean IsStandAloneName(string s) := FUNCTION
	fmt := SingleNameFormat(s);
	RETURN MAP(
		fmt = NameFormat.NoName =>	false,
		NOT IsStandAloneNameFormat(fmt) => false,
		//fmt = NameFormat.LFi => NOT ProbableFirstName(REGEXFIND(rgxLFi, name, 1)),
		IsFirstName(FirstName(s,fmt)) => TRUE,
		IsLastNameEither(s,fmt) => TRUE,
		FALSE
	);
END;

// fix up the personal name for easier recognition
InitialFixup(string s) := MAP (
	s[1] in ['"','+','('] => s[2..],
	s[1] = '0' => 'O' + S[2..],
	s[1..2] = 'A-' => s[3..],
	s
);

string SlamPeriodsDNU(string s) := MAP(
	REGEXFIND('^[A-Z]\\.[A-Z]\\. ', s) => s[1] + ' ' + s[3..],
	REGEXFIND('[ ,][A-Z]\\.[A-Z]\\.', s) => REGEXREPLACE('([ ,])([A-Z])\\.([A-Z])\\.', s, '$1$2$3'),
	REGEXFIND('[ ,][A-Z]{1,2}\\.[A-Z]\\.?$', s) => REGEXREPLACE('([ ,])([A-Z])\\.([A-Z])\\.?$', s, '$1$2$3'),
	s
);
string SlamPeriods(string s) := FUNCTION
	t := MAP(
		REGEXFIND('[ ,][A-Z]\\.[A-Z]\\.[A-Z]\\.?$', s) =>
			REGEXREPLACE('([ ,])([A-Z])\\.([A-Z])\\.([A-Z])\\.?$',s,'$1$2$3$4'),
		REGEXFIND('[ ,][A-Z]{1,2}\\.[A-Z]\\.?$', s) =>
			REGEXREPLACE('([ ,])([A-Z]{1,2})\\.([A-Z])\\.?$',s,'$1$2$3'),
		REGEXFIND('[ ,][A-Z]\\.[A-Z]\\.[A-Z]\\.? +', s) =>
			REGEXREPLACE('([ ,])([A-Z])\\.([A-Z])\\.([A-Z])\\.?', s, '$1$2$3$4 '),
		s
		);
	return IF(REGEXFIND('^[A-Z]\\.[A-Z]\\. ', t), t[1] + ' ' + t[3..], t);
END;
string RemoveNickname(string s) :=
	REGEXREPLACE('([("][A-Z]+[)"])$',s,'');
//	REGEXREPLACE('(\\([A-Z]+\\))$',s,'');
	
string RemoveMrMrs(string s) :=
	IF(REGEXFIND(rgxMrMrs, s),
		REGEXREPLACE(rgxMrMrs, s, ''), s);

rgxIsHonor := ' +' + rgxHonor + '\\b';
//rgxExtractHonor := '^(.+) +' + rgxHonor + ' *(.*)$';

string FixAndOr(string s) :=
	IF(REGEXFIND('\\bAND OR\\b',s),
		REGEXREPLACE('\\bAND OR\\b',s, ' AND/OR '), s);

string RemoveHonors(string s) := 
	FixAndOr(	// do it here for now
		MAP(
			REGEXFIND('^[A-Z-]+ +MA$', TRIM(s)) => s,
			REGEXFIND(rgxIsHonor, s) =>	REGEXREPLACE(rgxIsHonor, s, ''),
			s
		)
	);

string RemoveDblComma(string s) :=
	IF(REGEXFIND(', *,', s),
		REGEXREPLACE('^(.+), *,(.+)$', s, '$1,$2'),
		s);
	
string RemoveComma(string s) :=
	RemoveDblComma(
		IF(REGEXFIND(' [A-Z], ', s),
			REGEXREPLACE(' ([A-Z]), ', s, ' $1 '),
		s));
		
		
string RemoveSemicolon(string s) :=
	IF(StringLib.StringFind(s, ';', 1)=0, s,
		MAP(
			REGEXFIND('\\bAMP;',s) => StringLib.StringFindReplace(s, 'AMP;', '&'),
			REGEXFIND(';UNIT\\b',s) => StringLib.StringFindReplace(s, ';UNIT', 'UNIT'),
			REGEXFIND('^ATTN; ',s) => StringLib.StringFindReplace(s, 'ATTN; ', ''),
			REGEXFIND(' [A-Z];[A-Z]+',s) => StringLib.StringFindReplace(s, ';', '&'),
			REGEXFIND('L;[A-Z]',s) => StringLib.StringFilterOut(s, ';'),
			REGEXFIND('[A-Z];L',s) => StringLib.StringFilterOut(s, ';'),
			REGEXFIND('^[A-Z]+; +[A-Z]+ +[A-Z]+$',s) => StringLib.StringFindReplace(s, ';', ','),
			REGEXFIND('\\bO;[A-Z]',s) => StringLib.StringFindReplace(s, ';','\''),
			REGEXFIND('^[A-Z]+;?[A-Z]+ +[A-Z]+;?[A-Z]+$',s) => StringLib.StringFindReplace(s, ';', 'L'),
			REGEXFIND('^[A-Z]+ *; *[A-Z]+$',s) => StringLib.StringFindReplace(s, ';',','),
			REGEXFIND(';[^A-Z]+$', s) => s,
			StringLib.StringFindReplace(s, ';', '&')
		)
	);


string TrimRightPunct(string s) := REGEXREPLACE('[ .,+;?*&:#\'/\\\\-]+$',s,'');
string TrimRightHyphenChar(string s) := REGEXREPLACE('([A-Z])-[A-Z]$',s,'$1');
string TrimRightDblGen(string s) := REGEXREPLACE('\\b(JR|SR) (JR|SR)$',s,'$1');

string TrimRight(string s) := 
	TrimRightDblGen(TrimRightHyphenChar(TrimRightPunct(s)));
	
string FixupPlusSign(string s) :=
	MAP(
		REGEXFIND('^[A-Z]+ *\\+ *[A-Z]+',s) => stringlib.StringFindReplace(s,'+',' '),
		REGEXFIND('^[A-Z]+ +[A-Z] *\\+ *[A-Z]+$',s) => stringlib.StringFindReplace(s,'+',' '),
		s
	);

rgxAddApostrophe := '\\b([A-Z]+-O) ([A-Z]+)$';
string OtherFixup(string s) := 
	FixupPlusSign(
		IF(REGEXFIND(rgxAddApostrophe, s),
			REGEXREPLACE(rgxAddApostrophe, s, '$1\'$2'), s));
		
	
// miscellaneous words in a name
designations := 
'\\b(FACS|FAAP|FACP|RET|LSW|PHY|PHYS|ESQUIRE|MINISTER|PASTOR|SISTER|ENGNR|MFCC|MFT|DNTST|FACC|ATTY|CLU|CMT|CHFC|LWYR|AGNT|VET|PRES|OWNER|CNSLR)\\b';

export string FixupName(string s) := TRIM(StringLib.StringCleanSpaces(
										//LIB_Word.StripTail(LIB_Word.StripTail(
										TrimRight(
										RemoveComma(RemoveSemicolon(OtherFixup(
										RemoveHonors(
										REGEXREPLACE(titles,
										REGEXREPLACE(designations,
										RemoveMrMrs(
										StringLib.StringSubstituteOut(
											// look for two initials: A.C. GREENWOOD
											RemoveNickname(SlamPeriods(s)),
											'.()"{}', ' ')),
											''),
										''))))))),
									  LEFT,RIGHT);

/*
export string FixupName(string s) := TRIM(			//InitialFixup(
										REGEXREPLACE(titles,
										StringLib.StringFilterOut(
											// look for two initials: A.C. GREENWOOD
											IF(REGEXFIND('^[A-Z]\\.[A-Z]\\. ', s), s[1] + ' ' + s[3..], s),
											'.()"+'),	//),
										''),	LEFT,RIGHT);
*/
shared rgxSlashAtEnd := '/$';		// slash at end
rgxNandNslashN := '^[A-Z]+ +(AND|OR) +[A-Z]+/[A-Z]+';	// JOHN AND MARY/SMITH
rgxLslashF := '^[A-Z]{2,}/[A-Z]+';		// SMITH/MARY 
rgxFLslashL := '[A-Z+] +[A-Z]{2,}/[A-Z]+$';	// MARIA DIAZ/RUIZ
rgxFLslashLsp := '[A-Z+] +[A-Z]{2,} / [A-Z]+$';	// MARIA DIAZ/RUIZ
rgxSlashS := ' /[A-Z]+$';		// stray slash
rgxSlashedInitials := '\\b[A-Z]/[A-Z]\\b';		// slash at end
rgxEquifaxFix := '\\b([A-Z]+-[A-Z]+)/[A-Z]+$';

export string FixupSlash(string s) := FUNCTION
	name := FixupName(s);
	return MAP(
		StringLib.StringFindCount(s, '/') > 1 => s,
		StringLib.StringFind(name, '&/OR', 1) > 0 => name,
		StringLib.StringFind(name, 'AND/OR', 1) > 0 => name,
		REGEXFIND(rgxSlashedInitials, name) => s,
		REGEXFIND(rgxNandNslashN, name) => StringLib.StringFindReplace(name, '/', ' '),
		REGEXFIND(rgxLslashF, name) => StringLib.StringFindReplace(name, '/', ' '),
		REGEXFIND(rgxFLslashL, name) => StringLib.StringFindReplace(name, '/', '-'),
		REGEXFIND(rgxFLslashLsp, name) => StringLib.StringFindReplace(name, ' / ', '-'),
		REGEXFIND(rgxEquifaxFix, name) => REGEXREPLACE(rgxEquifaxFix, name, '$1'),
		REGEXFIND(rgxSlashS, name) => StringLib.StringFilterOut(name, '/'),
		REGEXFIND('^([A-Z \'-]+)/H W$', name) => REGEXREPLACE('^([A-Z \'-]+)/H W$', name, '$1'),
		REGEXFIND('^([A-Z \'-]+)/WIFE$', name) => REGEXREPLACE('^([A-Z \'-]+)/WIFE$', name, '$1'),
		REGEXFIND(rgxSlashAtEnd, name) => TRIM(StringLib.StringFilterOut(name, '/')),
		REGEXFIND('\\b([A-Z]+-[A-Z]+)/[A-Z]+$',name) => REGEXREPLACE('\\b([A-Z]+-[A-Z]+)/[A-Z]+$', name, '$1'),
		StringLib.StringFind(name, '&', 1) > 0 => name,	// not two ampersands
		StringLib.StringFind(name, '/', 1) > 4 => StringLib.StringFindReplace(name, '/', '&'),	// possible dual name
		name
	);
END;

string FixGen(string suffix) :=
		CASE(suffix,
			'1' => 'SR',
			'2' => 'JR',
			'3' => 'III',
			'4' => 'IV',
			'5' => 'V',
			'6' => '',
			'7' => '',
			'8' => '',
			'9' => '',
			//'6' => 'VII',
			//'7' => 'VIII',
			'JR' => 'JR',
			'JR,' => 'JR',
			'SR' => 'SR',
			'I' => 'I',
			'II' => 'II',
			'II,' => 'II',
			'III' => 'III',
			'IV' => 'IV',
			'IIII' => 'IV',
			'V' => 'V',
			'1ST' => 'I',
			'2N' => 'II',
			'2ND' => 'II',
			'ND' => 'II',
			'3RD' => 'III',
			'RD' => 'III',
			'3 I' => 'III',
			'4TH' => 'IV',
			'5TH' => 'V',
			'000' => '',
			suffix);

/***
	assumes that last word is a suffix and convert to alphs
***/
export string SuffixToAlpha(string name) := FUNCTION
	suffix := REGEXFIND('^.+[ ,]([A-Z0-9]+)$', name, 1);
	return IF (suffix = '', name,
			TRIM(REGEXREPLACE('^(.+)([ ,])([A-Z0-9]+)$', name,
			'$1$2') + FixGen(suffix)));	
END;

string ReconstructLName(string name) := MAP(
		name[1..2] = 'O ' => 'O\'' + name[3..],
		REGEXFIND('^[A-Z]{2,}/(JR|SR)$',name) => REGEXREPLACE('^([A-Z]{2,})/(JR|SR)$',name, '$1'),
		REGEXFIND('^[A-Z]{2,}/[A-Z ]{2,}$',name) => StringLib.StringFindReplace(name, '/', '-'),
		REGEXFIND('^[A-Z]{2,}-[A-Z]{2,}/[A-Z]$',name) => StringLib.StringFindReplace(name, '/', ' '),
		REGEXFIND('^[A-Z]/[A-Z]+$',name) => REGEXREPLACE('^[A-Z]/([A-Z]+)$',name, '$1'),
		REGEXFIND('^[A-Z]+/[A-Z]$',name) => REGEXREPLACE('^([A-Z]+)/[A-Z]$',name, '$1'),
		REGEXFIND(rgxSlashAtEnd, name) => TRIM(StringLib.StringFilterOut(name, '/')),
		REGEXFIND('^([A-Z]+-)([A-Z]+)/\\2$',name) => REGEXREPLACE('^([A-Z]+-)([A-Z]+)/\\2$',name, '$1$2'),
		name[1..3] = 'MC ' => 'MC' + name[4..],
		name
	);


export string ReconstructName(string fname, string mname, string lname, string suffix) := FUNCTION
		//name := TRIM(lname);
		lnam := TRIM(ReconstructLName(TRIM(lname,LEFT,RIGHT)),LEFT,RIGHT);
		mnam := IF(StringLib.StringFindCount(mname, '/') > 0,
					StringLib.StringFindReplace(mname, '/', ' '), mname);
		gen := CASE(TRIM(suffix),
			'1' => 'SR',
			'2' => 'JR',
			'3' => 'III',
			'4' => 'IV',
			'5' => 'V',
			//'6' => '',
			//'7' => '',
			//'8' => '',
			//'9' => '',
			'JR' => 'JR',
			'JR,' => 'JR',
			'SR' => 'SR',
			'I' => 'I',
			'II' => 'II',
			'II,' => 'II',
			'III' => 'III',
			'IV' => 'IV',
			'IIII' => 'IV',
			'V' => 'V',
			'1ST' => 'I',
			'2N' => 'II',
			'2ND' => 'II',
			'ND' => 'II',
			'3RD' => 'III',
			'RD' => 'III',
			'3 I' => 'III',
			'4TH' => 'IV',
			'000' => '',
			TRIM(StringLib.StringFilterOut(suffix,',()')));
			
		RETURN TRIM( 
				TRIM(fname) +
					IF(mnam='','',' ' + TRIM(mnam)) +
					' ' + lnam + 
					IF(gen='','',' ' + TRIM(gen))
				, LEFT, RIGHT);

END;

//  string73 CleanPerson73(const string name, const string server = lib_system.cleaningServer, unsigned2 port = lib_system.cleaningPort) : c, pure, context, entrypoint='aclCleanPerson73Ctx'; 
//  string73 CleanPersonFML73(const string name, const string server = lib_system.cleaningServer, unsigned2 port = lib_system.cleaningPort) : c, pure, context, entrypoint='aclCleanPersonFML73Ctx'; 
//  string73 CleanPersonLFM73(const string name, const string server = lib_system.cleaningServer, unsigned2 port = lib_system.cleaningPort) : c, pure, context, entrypoint='aclCleanPersonLFM73Ctx'; 



// for test only		
types := ['X','F','L','B'];
string1 GetNameType(string nm) :=
	types[IF (IsFirstName(nm),1,0) +
	IF (IsLastNameEx(nm),2,0) + 1];
export string8 NameOrder(string name, integer2 fmtx=0, string1 hint='U') := FUNCTION
	//s := FixupSlash(name), '/', ',');
	//NameFormat fmt := SingleNameFormat(name);
	NameFormat fmt := IF(fmtx = 0, PersonalNameFormat(name), fmtx);
	clue := MAP(
		//fmt IN FirstNameFirst	=> 'Frst',
		//fmt IN LastNameFirst	=> 'Last',
		fmt = NameFormat.FMiL =>	ValidateNames(rgxFMiL, name, 1, 3, 3, 1),
		fmt = NameFormat.FiML =>	ValidateNames(rgxFiML, name, 1, 3, 3, 1),
		fmt = NameFormat.FLorLF => 	ValidateNames(rgxFLoLF, name, 1, 3, 3, 1),
		fmt = NameFormat.FLSorLFS =>	ValidateNames(rgxFLSorLFS, name, 1, 2, 2, 1),
		fmt = NameFormat.FMLorLFM => ValidateNames(rgxFMLorLFM, name, 1, 4, 5, 1),
		fmt = NameFormat.LFMSaFMM => ValidateNames(rgxLFMSaFMM, name, 1, 5, 4, 1),
		fmt = NameFormat.FLSaFM => ValidateNames(rgxFLSaFM, name, 1, 2, 2, 1),
		fmt = NameFormat.FMLSorLFMS => ValidateNames(rgxFMLS, name, 1, 2, 3, 1),	
		fmt = NameFormat.FLL =>	ValidateNames(rgxFLL, name, 1, 5, 5, 2),
		fmt = NameFormat.FSL =>	ValidateNames(rgxFSL, name, 1, 3, 3, 1),
		fmt = NameFormat.LFMMi => ValidateNames(rgxLFMMi, name, 4, 5, 1, 4),
		//fmt = NameFormat.LFaF => GetNameType(REGEXFIND(rgxLFaF,name,1)) + 
		//			GetNameType(REGEXFIND(rgxLFaF,name,4)) + GetNameType(REGEXFIND(rgxLFaF,name,6)) + ' ',
		fmt = NameFormat.LFaF => ValidateNames(rgxLFaF, name, 1, 4, 4, 1),
		/*fmt = NameFormat.FLorLF	=> IF(IsFirstName(REGEXFIND(rgx, name, 1)), 'F',
									IF(IsLastName(REGEXFIND(rgx, name, 1)),'L', 'U')),
		fmt = NameFormat.FMLorLFM	=> IF(IsFirstName(REGEXFIND(rgxFMLorLFM, name, 1)), 'F',
										IF(IsLastName(REGEXFIND(rgxFMLorLFM, name, 1)), 'L', 'U')),
		fmt = NameFormat.FLSoLFS =>	IF(IsFirstName(REGEXFIND(rgxFLSoLFS, name, 1)), 'F',
									IF(IsLastName(REGEXFIND(rgxFLSoLFS, name, 1)), 'L',
										'U')),*/
		fmt = NameFormat.FMLaFM =>	ValidateNames(rgxFMLaFM, name, 1, 3, 3, 1),
		IF(IsFirstName(FirstName(name, fmt)), 'F',' ') +
			IF(IsNoFirstLastNameExOrHyphenated(LastName(name,fmt)),'L',' ')
	);
	clue2 := MAP(
		fmt = NameFormat.FMLorLFM => GetNameOrder(rgxFMLorLFM, name, 1, 4, 5, 1, hint, 4, 5),
		fmt = NameFormat.FMiL =>	GetNameOrder(rgxFMiL, name, 1, 3, 3, 1, hint, 0, 3),
		fmt = NameFormat.FiML =>	GetNameOrder(rgxFiML, name, 2, 3, 3, 2, hint, 2, 0),
		fmt = NameFormat.FLorLF =>	GetNameOrder(rgxFLoLF, name, 1, 3, 3, 1, hint),
		fmt = NameFormat.LFaF =>	GetNameOrder(rgxLFaF, name, 1, 4, 4, 1, hint),
		fmt in FirstNameFirst => 'f',
		fmt in LastNameFirst => 'l',
		StringLib.StringToUpperCase(hint)
	);
	clue3 := MAP(
		fmt = NameFormat.FMLorLFM =>  
					IF(IsFirstName(REGEXFIND(rgxFMLorLFM, name, 4)),'M','m') +
					IF(IsFirstName(REGEXFIND(rgxFMLorLFM, name, 5)),'M','m'),
		fmt = NameFormat.FMiL =>  
					' ' +
					IF(IsFirstName(REGEXFIND(rgxFMiL, name, 3)),'M','m'),
		If(IsFirstName(MiddleName(name,fmt,hint)),'M',
					IF(MiddleName(name,fmt,hint)='',' ','m'))
	);

	return clue + '-' + clue2 + clue3;
END;

shared string1 Disambiguate(string rgx, string s, integer2 posf1, integer2 posf2, 
													integer2 posl1, integer2 posl2, string1 clue='U',
													integer2 posm1 = 0, integer2 posm2 = 0) := 
		Case(ValidateNames(rgx, s, posf1, posf2, posl1, posl2),
		'    ' => 'U', 
		'F   ' => 'F',
		'FL  ' => 'F',
		'F f ' => 'U',
		'F  l' => 'F',
		' L  ' => 'F',
		' Lf ' => 'U',
		' L l' => MAP(
					IsLastNameOnlyOrHyphenated(REGEXFIND(rgx, s, posl1)) => 'F',
					IsLastNameOnlyOrHyphenated(REGEXFIND(rgx, s, posl2)) => 'L',
					'U'),
		'  f ' => 'L',
		'  fl' => 'L',
		'   l' => 'L',
		'FLf ' => 'F',
		'FL l' => 'F',
		'F fl' => 'L',
		' Lfl' => 'L',
		'FLfl' => MAP(
					IsLastNameOnlyOrHyphenated(REGEXFIND(rgx, s, posl1)) => 'F',
					IsLastNameOnlyOrHyphenated(REGEXFIND(rgx, s, posl2)) => 'L',
					//IsNickName(REGEXFIND(rgx, s, posf1)) => 'F',
					//IsNickName(REGEXFIND(rgx, s, posf2)) => 'L',
					'U'),
		'U'
		);



export string140 CleanName(string name, string1 hint='U') := FUNCTION
	s := TRIM(
			FixupSlash(StringLib.StringToUpperCase(
				StringLib.StringCleanSpaces(
					StringLib.StringFindReplace(name,' ,',',')
				)
			))
		,LEFT,RIGHT);
	//s := Address.Persons.(stringlib.StringFindReplace(name, ';', '&'));
	
	NameFormat fmt := IF(hint = 'U',SingleNameFormat(s),NameFormat.NoName);
	clue := MAP(
		fmt = NameFormat.NoName => StringLib.StringToUpperCase(hint),
		fmt IN NameFML	=> 'F',
		fmt IN NameLFM	=> 'L',
		/*fmt = NameFormat.FLorLF	=> IF(IsFirstName(REGEXFIND(rgx, s, 1)), 'F',
									IF(IsLastName(REGEXFIND(rgx, s, 1)),'L', 'U')),
		fmt = NameFormat.FMLorLFM	=> IF(IsFirstName(REGEXFIND(rgxFMLorLFM, s, 1)), 'F',
										IF(IsLastName(REGEXFIND(rgxFMLorLFM, s, 1)), 'L', 'U')),
		fmt = NameFormat.FLSoLFS =>	IF(IsFirstName(REGEXFIND(rgxFLSoLFS, s, 1)), 'F',
									IF(IsLastName(REGEXFIND(rgxFLSoLFS, s, 1)), 'L',
										'U')),*/
		'U'
	);
 
	RETURN CASE(clue,
		'F'	=> CleanPersonFML73(s)[1..70],
		'L'	=> CleanPersonLFM73(s)[1..70],
		'D' => CleanDualName140(s),
		CleanPerson73(s)[1..70]
	);

END;

export boolean IsCouple(string s) := 
	IF(REGEXFIND(rgxMrMrs, s),
		IsProbableName(REGEXREPLACE(rgxMrMrs, s, '')), false);
	

integer4 NameTokenCount(string s) := BEGINC++
//void tokenize(size32_t & __lenResult, char * & __result,
//				size32_t lenS, char *s); 
#option pure
#body

	int i = 0;
	int n = 0;
	bool endtoken = true;
	
	while (i < lenS)
	{
		if (isalpha(s[i]) || (s[i] == '-') || (s[i] == '\''))
		{
			endtoken = false;
		}
		else if (!endtoken)
		{
			endtoken = true;
			++n;
		}
		
		++i;
	}
	if (!endtoken)
		++n;
	
	return n;

ENDC++;

set of string32 NameTokens(string s, integer4 n) := BEGINC++
//void tokenset(bool __isAllResult, size32_t & __lenResult, void * & __result
//				size32_t lenS, char *s, int n); 
#option pure
#body

	char *temp = (char *)0;
	if (n > 0)
		temp = (char *)rtlMalloc(32 * n);
	if ((n == 0) || (temp == (char *)0))
	{
		__isAllResult = true;
		__lenResult = 0;
		__result = (char *)0;
		return;
	}
	
	int i = 0;
	int j = 0;
	int k = 0;
	int len = 0;

	bool endtoken = true;
	
	while (i < lenS)
	{
		if (isalpha(s[i]) || (s[i] == '-') || (s[i] == '\''))
		{
			if (len < 32)
				temp[j++] = s[i];
			++len;		// word length
			if (len > 32)	// token too long
			{
				__isAllResult = true;
				__lenResult = 0;
				__result = (char *)0;
				return;
			}

			endtoken = false;
		}
		else if (!endtoken)
		{
			endtoken = true;
			if (len <= 32)
				for (k = len; k < 32; ++k)
					temp[j++] = ' ';
			len = 0;
		}
		++i;
	}
	if (!endtoken)
	{
		for (k = len; k < 32; ++k)
			temp[j++] = ' ';
	}
	
	__isAllResult = false;
	__lenResult = 32 * n;
	__result = temp;

ENDC++;

export DATASET NameSplit(string s) := 
	 DATASET(NameTokens(s,NameTokenCount(s)), {string32 word});

END;