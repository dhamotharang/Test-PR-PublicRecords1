Import ut, ATF, Data_Services;

export file_firearms_explosives_in := dataset(data_services.data_location.prefix() + 'thor_data400::in::atf_firearms_explosives_IN',atf.layout_firearms_explosives_in,flat);