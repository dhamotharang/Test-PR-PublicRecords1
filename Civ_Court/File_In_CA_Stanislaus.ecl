IMPORT Civ_Court, ut, Data_Services;

// EXPORT File_In_CA_Stanislaus := dataset(Data_Services.foreign_prod + 'thor_data400::in::civil::ca_stanislaus',Layout_CA_Stanislaus,csv(terminator('\n'), quote('"'), separator(',')));
EXPORT File_In_CA_Stanislaus := dataset(Data_Services.foreign_prod + 'thor_data400::in::civil::ca_stanislaus',Civ_Court.Layout_In_CA_Stanislaus,thor);