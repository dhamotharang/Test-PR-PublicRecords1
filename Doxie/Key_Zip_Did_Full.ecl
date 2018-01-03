import doxie_build, data_services;

export Key_Zip_Did_Full := INDEX(doxie_build.Key_Prep_Zip_Did_Full,
                                 data_services.data_location.prefix() + 'thor_data400::key::zip_did_full_' + version_superkey);