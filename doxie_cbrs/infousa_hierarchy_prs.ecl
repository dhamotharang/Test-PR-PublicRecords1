IMPORT infousa,ut;
keepgoing(STRING abinum, STRING parentnum) := IF(abinum = parentnum, 1, 0);

k := infousa.Key_ABIUS_ABI_number;

// First get initial abi
abis := CHOOSEN(infousa.Key_ABIUS_Bdid(bdid=doxie_cbrs.subject_BDID),1);
t := JOIN(abis, k, KEYED(LEFT.abi_number=RIGHT.abi_number), KEEP(1));

BOOLEAN done(STRING3 s) := (INTEGER)s = 0;

// then traverse a few levels
rec := RECORD
  InfoUSA.Layout_ABIUS_Company_Base.abi_number;
  InfoUSA.Layout_ABIUS_Company_Base.bdid;
  InfoUSA.Layout_ABIUS_Company_Base.Subsidiary_Parent_num;
  InfoUSA.Layout_ABIUS_Company_Base.Ultimate_Parent_num;
  UNSIGNED1 level := 5;
END;

rec tra(k r, UNSIGNED1 rl) := TRANSFORM
  SELF.level := rl;
  SELF.SUBSIDIARY_PARENT_NUM :=
    IF(r.SUBSIDIARY_PARENT_NUM = r.abi_number,
       r.ultimate_PARENT_NUM,
       r.SUBSIDIARY_PARENT_NUM);
  SELF := r;
END;

go_up(DATASET(rec) ds_pn, UNSIGNED1 rl) :=
  IF(EXISTS(ds_pn((INTEGER)SUBSIDIARY_PARENT_NUM > 0)),
     topn(JOIN(ds_pn, k,
               LEFT.SUBSIDIARY_PARENT_NUM = RIGHT.abi_number, tra(RIGHT, rl)),
          1,keepgoing(abi_number, SUBSIDIARY_PARENT_NUM)));

ut.MAC_Slim_Back(t, rec, tr)
up1 := go_up(tr, 4);

up2 := go_up(up1, 3);

up3 := go_up(up2, 2);

up4 := go_up(up3, 1);

up5 := go_up(up4, 0);


unf := SORT((up1 + up2 + up3 + up4 + up5)(SUBSIDIARY_PARENT_NUM <> ''), level);
  
doxie_cbrs.layout_hierarchy_prs form(unf l) := TRANSFORM
  SELF.name := '';
  SELF := l;
END;
  
EXPORT infousa_hierarchy_prs := PROJECT(unf(bdid > 0), form(LEFT));
