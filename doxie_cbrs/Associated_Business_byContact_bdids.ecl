import ut,doxie,doxie_cbrs_raw;
doxie_cbrs.mac_Selection_Declare()

export Associated_Business_byContact_bdids(dataset(doxie_cbrs.layout_references) bdids) := FUNCTION

bdidsrev := doxie_cbrs_raw.Associated_Business_byContact(bdids,Include_AssociatedBusinesses_val,max_AssociatedBusinesses_val).records;

//switch the bdids of those we found into bdid field
ids := sort(table(bdidsrev, {unsigned6 bdid := bdidsrev.bdid2, did, score}), record);			
				
//remove bdids represented in other sections				
return choosen(ids(bdid not in set(doxie_Cbrs.ds_SupergroupLevels(bdids), bdid)), max_AssociatedBusinesses_val);
END;