IMPORT Civ_Court, ut;

EXPORT File_In_CA_Fresno := dataset('~thor_data400::in::civil::ca_fresno', Civ_Court.Layouts_In_CA_Fresno.Civil_in,csv(heading(1), separator([',']),quote('"')));