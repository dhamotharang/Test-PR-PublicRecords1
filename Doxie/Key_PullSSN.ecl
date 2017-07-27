import ut;

export Key_PullSSN := index(doxie.File_pullSSN, 
                           {ssn}, 
													 {ssn},
													 ut.foreign_prod+'thor_data400::key::pullSSN_' + doxie.Version_SuperKey);