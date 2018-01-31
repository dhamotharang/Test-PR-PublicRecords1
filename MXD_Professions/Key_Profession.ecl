import doxie,Data_Services;

MXProfession := record
	unsigned8 	rec_id;
	unsigned8 	entity_id;
	unicode50 	firstName;
	unicode50 	middleName1;
	unicode20 	middleName2;
	unicode20 	middleName3;
	unicode20 	middleName4;
	unicode20 	middleName5;
	unicode50 	lastName;
	unicode50 	matronymic;
	unicode50 	husbandslastname;
	unicode50 	patronymic;	
	string1 		gender;	
	unicode200	full_name;
	unsigned1		prof_cat;
	string10		profno;
	string100		profession;
	string100		education_level;	
end;	

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
										
base_recs_seeded 			:= MXD_Professions.FileKeyBuild;
										
dsProfRecs 						:= project(base_recs_seeded, transform(MXProfession, self.prof_cat := mapProfCategory(left.profession), self := left));
								
export Key_Profession := index(dsProfRecs,
																{entity_id, rec_id},		
																{	firstName, middleName1, middleName2, middleName3, middleName4, middleName5, lastName, 
																	matronymic, husbandslastname, patronymic, gender, full_name, prof_cat,
																	profno, profession, education_level
																},
																Data_Services.Data_location.Prefix()+'thor_data400::key::mxd_professions::'+doxie.Version_SuperKey+'::prof_idx'
															 );