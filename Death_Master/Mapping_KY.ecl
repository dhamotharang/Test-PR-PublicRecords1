IMPORT HEADER, ADDRESS, UT, STD;

// We only want records with valid DOD
file_in := Death_Master.Files.Kentucky(ut.isNumeric(STD.Str.FindReplace(dod,'"','')));
						 
Header.layout_death_master_supplemental tDeathMaster_Kentucky_Data_Supplement(file_in pInput) := 
TRANSFORM

// Kentucky puts quotes around fields as well as the entire record.
// We need to remove the quotes and clean up the fields before using.
	fnCleanField(STRING	pField)	:=	FUNCTION
		RETURN(ut.CleanSpacesAndUpper(STD.Str.FindReplace(pField,'"','')));
	END;

	SELF.source_state  			:= 	'KY';
	SELF.dod 								:= 	fnCleanField(pInput.dod);
	SELF.fname							:= 	fnCleanField(pInput.fname);
	SELF.mname							:= 	fnCleanField(pInput.mname);
	SELF.lname							:= 	fnCleanField(pInput.lname);
	SELF.county_death				:= 	fnCleanField(pInput.county_of_death);
	SELF.place_of_death			:= 	SELF.county_death;
	SELF										:=	[];
	
END;

EXPORT Mapping_KY := PROJECT(file_in, tDeathMaster_Kentucky_Data_Supplement(LEFT));
