import Diversity_Certification, lib_stringlib;

EXPORT Input_In_Diversity_Certification := Diversity_Certification.Files().input.using(lib_stringlib.StringLib.StringFind(stringlib.StringToUpperCase(dartid), 'DARTID', 1) = 0 AND 
                                                                                       TRIM(stringlib.StringToUpperCase(Website), LEFT, RIGHT) <> 'WEBSITE');