import data_services;

export File_FBN_Contact_Base_AID := DATASET(data_services.foreign_prod + 'thor_data400::Base::FBNv2::Contact',Layout_Common.Contact_AID , flat);
