import ut, Infutor_NARC, Scrubs_Infutor_NARC;

string	pversion := '';
boolean pUseProd := false;
 
EXPORT Raw_In_Infutor_NARC := Scrubs_infutor_NARC.Files(pversion,pUseProd).input;
// EXPORT Raw_In_Infutor_NARC := dataset(ut.foreign_prod+ 'thor_data400::in::infutor_narc::history', Scrubs_Infutor_NARC.Raw_Layout_Infutor_NARC, csv( separator('\t'),heading(1), terminator(['\n', '\r\n']), quote([''])));


