export TestKeys := MACRO

output(choosen(index(doxie.File_pullSSN, 
                           {ssn}, 
													 {ssn},
													 '~thor_data400::key::pullSSN_father'),10));

ENDMACRO;