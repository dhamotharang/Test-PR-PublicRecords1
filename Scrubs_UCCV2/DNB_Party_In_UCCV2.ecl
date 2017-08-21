IMPORT Scrubs_UCCV2, Data_Services;

EXPORT DNB_Party_In_UCCV2 := DATASET(Data_Services.foreign_prod + 'thor_data400::base::UCC::Party::dnb', 
                                     Scrubs_UCCV2.DNB_Party_Layout_UCCV2, THOR);
