IMPORT dca, ut;

t := topn(LIMIT (DCA.Key_DCA_BDID(KEYED (bdid = doxie_cbrs.subject_BDID)), ut.limits.MAX_DCA_PER_BDID, SKIP),
          1,-parent_number);

BOOLEAN done(STRING3 s) := (INTEGER)s = 0;
k := dca.Key_DCA_Root_Sub;

rec := RECORDOF(k);

go_up(DATASET(rec) ds_pn) :=
  IF(EXISTS(ds_pn((INTEGER)root > 0)),
     TOPN(JOIN(ds_pn, k,
               KEYED (LEFT.parent_number[1..9] = RIGHT.root) AND
               KEYED (LEFT.parent_number[11..14] = RIGHT.sub),
               TRANSFORM (RIGHT),
               KEEP (1), LIMIT (0)),
          1,-parent_number));

ut.MAC_Slim_Back(t, rec, tr)
up1 := go_up(tr);

up2 := go_up(up1);

up3 := go_up(up2);

up4 := go_up(up3);

up5 := go_up(up4);


unf := SORT((up1 + up2 + up3 + up4 + up5)(root <> ''), level);

doxie_cbrs.layout_hierarchy_prs form(unf l) := TRANSFORM
  SELF.level := (UNSIGNED1)l.level;
  SELF := l;
END;
  
EXPORT dca_hierarchy_prs := PROJECT(unf(name <> '' OR bdid > 0), form(LEFT));
