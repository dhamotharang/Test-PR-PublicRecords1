export File_Corporate_Affiliations_Plus := dataset('~thor_data400::BASE::Corporate_Affiliations_' + Corp4_Build_Date,
                                            {Layout_Corporate_Affiliation, unsigned8 __filepos { virtual(fileposition) }},
                                            flat);