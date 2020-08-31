IMPORT doxie, business_header;
doxie_cbrs.MAC_Selection_Declare()

allem := doxie_cbrs.getRelatives(doxie_cbrs.subject_BDID)
    (Include_AssociatedBusinesses_val OR Include_NameVariations_val); //filter
    
//for supergroup stuff, limit these
allem limitor(allem l) := TRANSFORM
  SELF := l;
END;



lmtd := JOIN(allem, supergroup_ds, LEFT.bdid = RIGHT.bdid, limitor(LEFT));


EXPORT Associated_Business_bdids(BOOLEAN only_Supergroup = FALSE) :=
  IF(only_Supergroup, lmtd, allem);
