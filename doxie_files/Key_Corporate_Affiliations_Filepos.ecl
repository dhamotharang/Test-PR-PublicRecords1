import doxie, Corp, data_services;

export Key_Corporate_Affiliations_Filepos := index(
   Corp.File_Corporate_Affiliations_Plus,
   {unsigned8 filepos := __filepos},
   {Corp.File_Corporate_Affiliations_Plus},
   data_services.data_location.prefix() + 'thor_data400::key::corporate_affiliations.filepos_' + doxie.Version_SuperKey);