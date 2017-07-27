IMPORT tools,Healthcare_Cleaners;

EXPORT Medschool_files(STRING pversion = '', boolean pUseProd = false) := MODULE
export medschool_file                  := dataset(Medschool_filenames(pversion,false).medschool_lBaseTemplate,Healthcare_Cleaners.layouts_medschool.layoutMedicalSchoolInfo1, flat);
export medschool_wordlist_file         := dataset(Medschool_filenames(pversion,false).medschool_wordlist_lBaseTemplate,Healthcare_Cleaners.layouts_medschool.layoutMedicalSchoolWord1, 
flat);
export non_medschool_file             := dataset(Medschool_filenames(pversion,false).non_medschool_lBaseTemplate,Healthcare_Cleaners.layouts_medschool.layoutMedicalSchoolInfo1, flat);
export non_medschool_wordlist_file    := dataset(Medschool_filenames(pversion,false).non_medschool_wordlist_lBaseTemplate,Healthcare_Cleaners.layouts_medschool.layoutMedicalSchoolWord1, 

flat);
end;   