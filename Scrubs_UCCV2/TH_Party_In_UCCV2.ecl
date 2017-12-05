IMPORT Scrubs_UCCV2, Data_Services;

EXPORT TH_Party_In_UCCV2 := DATASET(Data_Services.foreign_prod + 'thor_data400::base::UCC::Party::th', 
                                     Scrubs_UCCV2.TH_Party_Layout_UCCV2, THOR);
