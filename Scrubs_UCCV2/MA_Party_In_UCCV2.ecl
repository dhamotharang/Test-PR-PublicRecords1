IMPORT Scrubs_UCCV2, Data_Services;

EXPORT MA_Party_In_UCCV2 := DATASET(Data_Services.foreign_prod + 'thor_data400::base::UCC::Party::ma', 
                                     Scrubs_UCCV2.MA_Party_Layout_UCCV2, THOR);