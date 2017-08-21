IMPORT Civ_Court, ut;

EXPORT File_In_GA_Hall := dataset('~thor_data400::in::civil::ga_hall', Civ_Court.Layout_In_GA_Hall,csv(separator([',']),quote('"')));