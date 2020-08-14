IMPORT ut,doxie,doxie_cbrs_raw;
doxie_cbrs.mac_Selection_Declare()

EXPORT Associated_Business_byContact_bdids(DATASET(doxie_cbrs.layout_references) bdids) := FUNCTION

bdidsrev := doxie_cbrs_raw.Associated_Business_byContact(bdids,Include_AssociatedBusinesses_val,max_AssociatedBusinesses_val).records;

//switch the bdids of those we found into bdid field
ids := SORT(table(bdidsrev, {UNSIGNED6 bdid := bdidsrev.bdid2, did, score}), RECORD);
        
//remove bdids represented in other sections
RETURN CHOOSEN(ids(bdid NOT IN SET(doxie_Cbrs.ds_SupergroupLevels(bdids), bdid)), max_AssociatedBusinesses_val);
END;
