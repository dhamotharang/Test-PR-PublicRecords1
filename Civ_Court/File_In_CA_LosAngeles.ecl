IMPORT Civ_Court, ut;

EXPORT File_In_CA_LosAngeles := MODULE

EXPORT File_In_CA_LosAngeles_Old :=  dataset('~thor_data400::in::civil::ca_los_angeles', Civ_Court.Layout_In_CA_LosAngeles.Layout_In_CA_LosAngeles_old, flat);

EXPORT File_In_CA_LosAngeles_New := dataset('~thor_data400::in::civil::ca_los_angeles_new', Civ_Court.Layout_In_CA_LosAngeles.Layout_In_CA_LosAngeles_new, flat);

End;
