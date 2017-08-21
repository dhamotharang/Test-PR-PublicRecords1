IMPORT Scrubs_UCCV2, Data_Services;

EXPORT IL_Party_In_UCCV2 := DATASET(Data_Services.foreign_prod + 'thor_data400::base::UCC::Party::il', 
                                     Scrubs_UCCV2.IL_Party_Layout_UCCV2, THOR);
                                     
                                     