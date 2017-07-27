export Key_Corporate_Affiliations_Filepos := index(
   File_Corporate_Affiliations_Plus,
   {unsigned8 filepos := __filepos},
   {File_Corporate_Affiliations_Plus},
   '~thor_data400::key::corporate_affiliations.filepos_' + Corp4_Build_Date);