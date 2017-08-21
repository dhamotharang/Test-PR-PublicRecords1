import	_control;

export Proc_Build_MXProfession_Keys(string pVersion) := function

prof_idx:= 
RECORD
  unsigned8 entity_id;
  unsigned8 rec_id;
  unicode50 firstname;
  unicode50 middlename1;
  unicode20 middlename2;
  unicode20 middlename3;
  unicode20 middlename4;
  unicode20 middlename5;
  unicode50 lastname;
  unicode50 matronymic;
  unicode50 husbandslastname;
  unicode50 patronymic;
  string1 gender;
  unicode200 full_name;
  unsigned1 prof_cat;
  string10 profno;
  string100 profession;
  string100 education_level;
  unsigned8 __internal_fpos__;
 END;
 
prof_idx_key := buildindex(index(dataset([],prof_idx),{entity_id, rec_id},		
																{	firstName, middleName1, middleName2, middleName3, middleName4, middleName5, lastName, 
																	matronymic, husbandslastname, patronymic, gender, full_name, prof_cat,
																	profno, profession, education_level
																},'keyname'),'~prte::key::mxd_professions::'+ pVersion +'::prof_idx',update);
																
prof_mph_search_idx:= 
RECORD
  unsigned1 search_type;
  string10 n1_m1;
  string10 n1_m2;
  string10 n2_m1;
  string10 n2_m2;
  string10 n3_m1;
  string10 n3_m2;
  string1 minit;
  unsigned1 prof_cat;
  string1 gender;
  unsigned8 entity_id;
  unsigned8 rec_id;
 END;
 
prof_mph_search_idx_key := buildindex(index(dataset([],prof_mph_search_idx),{search_type, n1_m1, n1_m2, n2_m1, n2_m2, n3_m1, n3_m2, minit, prof_cat, gender},															 
																	{entity_id, rec_id},'keyname'),'~prte::key::mxd_professions::'+ pVersion +'::prof_mph_search_idx',update);				

prof_search_idx:= 
RECORD
  unsigned1 search_type;
  string50 n1;
  string50 n2;
  string50 n3;
  string1 minit;
  unsigned1 prof_cat;
  string1 gender;
  unsigned8 entity_id;
  unsigned8 rec_id;
 END;

 
prof_search_idx_idx_key := buildindex(index(dataset([],prof_search_idx),{search_type, n1, n2, n3, minit, prof_cat, gender},															 
													{entity_id, rec_id},'keyname'),'~prte::key::mxd_professions::'+ pVersion +'::prof_search_idx',update);		
													
return sequential(
						parallel(
											prof_idx_key
											,prof_mph_search_idx_key
											,prof_search_idx_idx_key
											),
															 
															 
						PRTE.UpdateVersion(	'MXProfessionKeys',		//	Package name
																pVersion,							//	Package version
																'julianne.franzer@lexisnexis.com;anantha.venkatachalam@lexisnexis.com',	//	Who to email with specifics
																'B',									//	B = Boca, A = Alpharetta
																'N',									//	N = Non-FCRA, F = FCRA
																'N'										//	N = Do not also include boolean, Y = Include boolean, too
															)
						);	

end;