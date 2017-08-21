IMPORT Civ_Court, Data_Services;

EXPORT File_In_CA_SantaBarbara :=	dataset(Data_Services.foreign_prod + 'thor_data400::in::civil_court::ca_santa_barbara',Civ_Court.Layout_In_CA_SantaBarbara,csv(heading(0), separator([',']),quote('"')));
