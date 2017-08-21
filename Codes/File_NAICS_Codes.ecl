import Codes;

export File_NAICS_Codes := dataset('~thor_data400::base::NAICS::qa::codes_lookup'
                                  ,Codes.Layout_NAICS_Codes
								  ,flat);