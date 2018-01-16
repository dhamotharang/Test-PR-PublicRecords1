import doxie,Data_Services;

PROF_CATEGORIES := ENUM(unsigned1, ADMINISTRATION, CPA, DENTAL, IT, LEGAL, MEDICAL, NURSING, ENGINEERING, EDUCATION, FINANCIAL, MARKETING, UNKNOWN);
PROF_PATTERN_ADMIN := '(ADMINISTRATION|MANAGEMENT|EXECUTIVE ASSISTANT|LEADERSHIP)';
PROF_PATTERN_CPA := '(CPA|TAX ACCOUNTING|ACCOUNTING|TAX)';
PROF_PATTERN_DENTAL := '(DENTAL|DENTISTRY|DENTIST|ORTHODONT|PROSTHEDON|PROSTHODON|PERIODONT|ENDODONT)';
PROF_PATTERN_IT := '(INFORMATION TECHNOLOGY|COMPUTER|COMPUTER SYSTEMS|COMPUTER SCIENCE)';
PROF_PATTERN_LEGAL := '(LAW)';
PROF_PATTERN_MEDICAL := '(MEDICINE|CLINICAL|SURGERY|ANESTHESIOLOGY|ANESTHES|PSYCHOLOGY)';
PROF_PATTERN_NURSING := '(NURSING|NURSE)';
PROF_PATTERN_ENGINEERING := '(ENGINEERING|ENGINEER)';
PROF_PATTERN_EDUCATION := '(EDUCATION|ELEMENTARY EDUCATION)';
PROF_PATTERN_FINANCIAL := '(FINANCE|ECONOMIC|TRADE|INTERNATIONAL BUSINESS)';
PROF_PATTERN_MARKETING := '(MARKETING)';
PROF_PATTERN_EXCLUSIONS := '(VETERINARY)';

ds_prof_categories := dataset([
																{PROF_CATEGORIES.ADMINISTRATION, 'ADMINISTRATION', PROF_PATTERN_ADMIN},
																{PROF_CATEGORIES.CPA, 'CPA', PROF_PATTERN_CPA},
																{PROF_CATEGORIES.DENTAL, 'DENTAL', PROF_PATTERN_DENTAL},
																{PROF_CATEGORIES.IT, 'IT', PROF_PATTERN_IT},
																{PROF_CATEGORIES.LEGAL, 'LEGAL', PROF_PATTERN_LEGAL},
																{PROF_CATEGORIES.MEDICAL, 'MEDICAL', PROF_PATTERN_MEDICAL},
																{PROF_CATEGORIES.NURSING, 'NURSING', PROF_PATTERN_NURSING},
																{PROF_CATEGORIES.ENGINEERING, 'ENGINEERING', PROF_PATTERN_ENGINEERING},
																{PROF_CATEGORIES.EDUCATION, 'EDUCATION', PROF_PATTERN_EDUCATION},
																{PROF_CATEGORIES.FINANCIAL, 'FINANCIAL', PROF_PATTERN_FINANCIAL},
																{PROF_CATEGORIES.MARKETING, 'MARKETING', PROF_PATTERN_MARKETING},
																{PROF_CATEGORIES.UNKNOWN, 'UNKNOWN', ''}
															], {unsigned1 prof_cat; string100 profession; string prof_pattern;});

mapProfCategory(string100 prof) := function
	return map(
		// excluding some key words to avoid wrong classification first
		regexfind(PROF_PATTERN_EXCLUSIONS, prof)=>PROF_CATEGORIES.UNKNOWN,
		regexfind(ds_prof_categories[PROF_CATEGORIES.IT].prof_pattern, prof)=>PROF_CATEGORIES.IT,
		regexfind(ds_prof_categories[PROF_CATEGORIES.ADMINISTRATION].prof_pattern, prof)=>PROF_CATEGORIES.ADMINISTRATION,
		regexfind(ds_prof_categories[PROF_CATEGORIES.CPA].prof_pattern, prof)=>PROF_CATEGORIES.CPA,
		regexfind(ds_prof_categories[PROF_CATEGORIES.DENTAL].prof_pattern, prof)=>PROF_CATEGORIES.DENTAL,		
		regexfind(ds_prof_categories[PROF_CATEGORIES.LEGAL].prof_pattern, prof)=>PROF_CATEGORIES.LEGAL,
		regexfind(ds_prof_categories[PROF_CATEGORIES.MEDICAL].prof_pattern, prof)=>PROF_CATEGORIES.MEDICAL,
		regexfind(ds_prof_categories[PROF_CATEGORIES.NURSING].prof_pattern, prof)=>PROF_CATEGORIES.NURSING,
		regexfind(ds_prof_categories[PROF_CATEGORIES.ENGINEERING].prof_pattern, prof)=>PROF_CATEGORIES.ENGINEERING,
		regexfind(ds_prof_categories[PROF_CATEGORIES.EDUCATION].prof_pattern, prof)=>PROF_CATEGORIES.EDUCATION,
		regexfind(ds_prof_categories[PROF_CATEGORIES.FINANCIAL].prof_pattern, prof)=>PROF_CATEGORIES.FINANCIAL,
		regexfind(ds_prof_categories[PROF_CATEGORIES.MARKETING].prof_pattern, prof)=>PROF_CATEGORIES.MARKETING,
		PROF_CATEGORIES.UNKNOWN);
end;

MXProfessionSearch := record	
	unsigned1 search_type;
	string50  n1; 
	string50  n2;
	string50  n3;
	string1   minit;
	unsigned1 prof_cat;
	string1   gender;  
	unsigned8 rec_id;	
	unsigned8 entity_id;	
END;	

MXProfessionSearchMPH := record
  unsigned1 search_type;
  string10  n1_m1;
  string10  n1_m2;
  string10  n2_m1;
  string10  n2_m2;
  string10  n3_m1;
  string10  n3_m2;
  string1   minit;
  unsigned1 prof_cat;	
	string1   gender;  
	unsigned8 rec_id;	
	unsigned8 entity_id;	
end;

base_recs_seeded 			:= MXD_Professions.FileKeyBuild;

SearchType := ENUM(unsigned1, FLM, LMX, FMX);
SearchTypeInUse := 3;

string strip_prefix(string name) := function
	prefix := '^(ET |SAN |SANTA |LOS |DE DI |VON DER |DON |DOS |DAS |ZUM |DALLA |DE DE LOS |DE DE LA |DE LA |DE DE |DE DEL |D LA |VON |DE LE |DE S C |DE DE LA |DE A LA |A LA |DE LA DE LA |DA LA |DE SC |DEL LA |DE LAS |DE LOS |DEL LOS |DE SAN |DEL SAN |DE S |DEL PERPETUO |DE LOS TRES |DE J Y |DEL SAGRADO CORAZON DE |DEL SAGRADO |DEL NUESTRA |DE NUESTRA |DE |BAS |BEN |DEL |LES |LEZ |LA |EL |DA |DI |WIDOW OF |VIUDA |Y )';
	return regexreplace(prefix, name, '');
end;

cleanUni2Str(unicode ustr) := function		
	// Replacing u'Ã‘' for N to avoid dealing with special characters
	// Julie: 
	// 	Some records have Ñ replaced by -, which is bad (e.g. rec_id: 18, QUIÑONEZ has been replaced by QUI-ONEZ)
	// 	Not sure why this was done and how to fix that here, but ideally, it would be better to have the record reading QUINONEZ instead of QUI-ONEZ.
	return transfer(fromunicode(UnicodeLib.UnicodeFindReplace(ustr,u'Ã‘',u'N'), 'UTF-8'), string);
end;

MXProfessionSearch norm2Search(base_recs_seeded l, integer c) := transform
	
	string50 fname 			:= cleanUni2Str(l.firstname);
	string50 lname 			:= strip_prefix(cleanUni2Str(l.lastName));
	string20 mname 			:= strip_prefix(cleanUni2Str(l.middlename1));
	string50 matronymic := strip_prefix(cleanUni2Str(l.matronymic));
	
	n1 := map(c=SearchType.FLM=>fname,
					  c=SearchType.LMX=>lname,
						c=SearchType.FMX=>fname,
						'');
	n2 := map(c=SearchType.FLM=>lname,
						c=SearchType.LMX=>matronymic,
						c=SearchType.FMX=>matronymic,
						'');
	n3 := map(c=SearchType.FLM=>matronymic,
						c=SearchType.LMX=>'',
						c=SearchType.FMX=>'',
						'');
	self.search_type 	:= c;						
	self.n1 					:= if(n1<>'', n1, skip);
	self.n2 					:= if(n2<>'', n2, skip);
	self.n3 					:= n3;
	self.minit				:= mname[1];
	self.prof_cat 		:= mapProfCategory(l.profession);
	self.gender 			:= l.gender;
	self.entity_id 		:= l.entity_id;
	self.rec_id 			:= l.rec_id;
end;

p_recs_norm := normalize(base_recs_seeded, SearchTypeInUse, norm2Search(left, counter));

p_recs_norm_mph := project(p_recs_norm, 
													transform(MXProfessionSearchMPH,
													self.n1_m1 := MetaphoneLib.DMetaphone1(left.n1),
													self.n1_m2 := MetaphoneLib.DMetaphone2(left.n1),
													self.n2_m1 := MetaphoneLib.DMetaphone1(left.n2),
													self.n2_m2 := MetaphoneLib.DMetaphone2(left.n2),
													self.n3_m1 := MetaphoneLib.DMetaphone1(left.n3),
													self.n3_m2 := MetaphoneLib.DMetaphone2(left.n3),
													self := left
													));

dsProfMPHSearchRecs := p_recs_norm_mph;
export Key_ProfMPHSearch := index(dsProfMPHSearchRecs,
																	{search_type, n1_m1, n1_m2, n2_m1, n2_m2, n3_m1, n3_m2, minit, prof_cat, gender},															 
																	{entity_id, rec_id},
																	Data_Services.Data_location.Prefix()+'thor_data400::key::mxd_professions::'+doxie.Version_SuperKey+'::prof_mph_search_idx');
