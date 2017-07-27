import doxie, Corp;

export Key_Corporate_Affiliations_Filepos := index(
   Corp.File_Corporate_Affiliations_Plus,
   {unsigned8 filepos := __filepos},
   {Corp.File_Corporate_Affiliations_Plus},
   '~thor_data400::key::corporate_affiliations.filepos_' + doxie.Version_SuperKey);