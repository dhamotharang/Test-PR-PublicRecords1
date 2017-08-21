IMPORT Scrubs_UCCV2, Data_Services;

EXPORT CA_Party_In_UCCV2 := DATASET(Data_Services.foreign_prod + 'thor_data400::base::UCC::Party::ca', 
                                     Scrubs_UCCV2.CA_Party_Layout_UCCV2, THOR);