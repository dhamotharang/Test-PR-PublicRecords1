IMPORT $, Civ_Court, ut;

EXPORT File_In_CA_LosAngeles := MODULE

EXPORT Old :=  dataset('~thor_data400::in::civil::ca_los_angeles', Civ_Court.Layout_In_CA_LosAngeles.old, flat);

EXPORT New := dataset('~thor_data400::in::civil::ca_los_angeles_new', Civ_Court.Layout_In_CA_LosAngeles.new, flat);

END;
