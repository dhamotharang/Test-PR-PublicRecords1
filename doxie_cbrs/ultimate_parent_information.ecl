IMPORT doxie_cbrs, Business_Header;

EXPORT ultimate_parent_information(DATASET(doxie_cbrs.layout_references) in_bdids) := FUNCTION

bdids := CHOOSEN(in_bdids,1);
rec := doxie_cbrs.layout_references;
rec joinrec(Business_Header.Key_BH_SuperGroup_BDID l) := TRANSFORM
  SELF.bdid := l.group_id;
END;

thebdid := JOIN(bdids,Business_Header.Key_BH_SuperGroup_BDID,LEFT.bdid=RIGHT.bdid,joinrec(RIGHT),LIMIT(2));

RETURN CHOOSEN(
  JOIN(thebdid,doxie_cbrs.fn_best_information(thebdid,TRUE),
    LEFT.bdid=(UNSIGNED6)RIGHT.bdid,
    TRANSFORM($.layouts.upcr_record, 
      SELF := LEFT; 
      SELF := RIGHT)
    ), 1);

END;
