EXPORT STRING3 GetSpeciality (STRING10 Taxonomy) := FUNCTION
	IMPORT HealthCare;
	Taxonomy_DS := HealthCare.Files.Speciality_Taxonomy_DS;
	T := TABLE(Taxonomy_DS,{taxonomy_code,Speciality_Code}); // Slimmer 
	Taxonomy_Map := DICTIONARY(T,{ taxonomy_code => T });
	STRING3 SpecialityCode := IF ( Taxonomy IN Taxonomy_Map, Taxonomy_Map[Taxonomy].speciality_code, '');
	RETURN SpecialityCode;
END;

