import doxie, header;

f := header.File_Did_Death_Master;

export Key_Death_SSN:= INDEX(f,{ssn},{f},'~thor_data400::key::death_ssn_'+doxie.Version_SuperKey);