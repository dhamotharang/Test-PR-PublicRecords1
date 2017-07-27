import dca, ut;

t := topn(LIMIT (DCA.Key_DCA_BDID(KEYED (bdid = doxie_cbrs.subject_BDID)), ut.limits.MAX_DCA_PER_BDID, SKIP),
          1,-parent_number);

boolean done(string3 s) := (integer)s = 0;
k := dca.Key_DCA_Root_Sub;

rec := recordof(k);

go_up(dataset(rec) ds_pn) := 
	if(exists(ds_pn((integer)root > 0)),
		 topn(join(ds_pn, k,
							 keyed (left.parent_number[1..9] = right.root) and 
							 keyed (left.parent_number[11..14] = right.sub),
							 transform (right),
							 keep (1), limit (0)),
					1,-parent_number));

ut.MAC_Slim_Back(t, rec, tr)
up1 := go_up(tr);

up2 := go_up(up1);

up3 := go_up(up2);

up4 := go_up(up3);

up5 := go_up(up4);


unf := sort((up1 + up2 + up3 + up4 + up5)(root <> ''), level);

doxie_cbrs.layout_hierarchy_prs form(unf l) := transform
	self.level := (unsigned1)l.level;
	self := l;
end;
	
export dca_hierarchy_prs := project(unf(name <> '' or bdid > 0), form(left));