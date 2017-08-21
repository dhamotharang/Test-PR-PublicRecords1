Import Data_Services, ATF;

export file_firearms_explosives_in := dataset(Data_Services.foreign_prod+'thor_data400::in::atf_firearms_explosives_IN',atf.layout_firearms_explosives_in,flat);