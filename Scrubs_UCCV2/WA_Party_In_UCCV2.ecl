IMPORT Scrubs_UCCV2, Data_Services;

EXPORT WA_Party_In_UCCV2 := DATASET(Data_Services.foreign_prod + 'thor_data400::base::UCC::Party::wa', 
                                     Scrubs_UCCV2.WA_Party_Layout_UCCV2, THOR);
