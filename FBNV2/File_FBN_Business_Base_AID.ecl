IMPORT data_services;

export File_FBN_Business_Base_AID := DATASET(data_services.foreign_prod + 'thor_data400::Base::FBNv2::Business',Layout_Common.Business_AID , flat);
