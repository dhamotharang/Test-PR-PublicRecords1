IMPORT $, Civ_Court, ut;

EXPORT File_In_CA_LosAngeles := FUNCTION

 Old :=  dataset('~thor_data400::in::civil::ca_los_angeles', Civ_Court.Layout_In_CA_LosAngeles.old, flat);

 New := dataset('~thor_data400::in::civil::ca_los_angeles_new', Civ_Court.Layout_In_CA_LosAngeles.new, flat);

//Project new into old layout so all can be processed in a common layout
pNew2Old := PROJECT(New, TRANSFORM($.Layout_In_CA_LosAngeles.old, SELF := []; SELF := LEFT));

//Combine common
CombineAll := old + pNew2Old;

RETURN CombineAll;

END;
