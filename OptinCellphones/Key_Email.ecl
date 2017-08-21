import doxie, ut;
with_email := Files.file_base(did > 0 and length(trim(email,left, right)) > 4 and StringLib.StringFindCount(email,  '@') > 0);
export Key_Email := INDEX(with_email, 
							 {did},
							 {with_email},
							 '~thor_data400::key::OptinCellphones::' + doxie.Version_SuperKey + '::email_search');
							 
