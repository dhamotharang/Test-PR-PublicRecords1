export mac_compare_topn_by_fldval(newdata, olddata, fieldname, outf) := macro

#uniquename(rec)
%rec% := recordof(newdata.fieldname);

#uniquename(get_fld)
%rec% %get_fld%(%rec% R) := transform
	self := R;
end;

#uniquename(newf)
#uniquename(pref)
%newf% := sort(normalize(newdata,left.fieldname,%get_fld%(RIGHT)),fld_val);
%pref% := sort(normalize(olddata,left.fieldname,%get_fld%(RIGHT)),fld_val);

#uniquename(comprec)
%comprec% := record
	unsigned4 newcnt;
	unsigned4 oldcnt;
	string 	newfld;
	string 	oldfld;
	real4	pcnt_diff;
end;

#uniquename(into_comp)
%comprec% %into_comp%(%newf% L, %pref% R) := transform
	self.newcnt := L.cnt;
	self.newfld := L.fld_val;
	self.oldcnt := R.cnt;
	self.oldfld := R.fld_val;
	self.pcnt_diff := (100.0 * abs(L.cnt - R.cnt))/L.cnt;
end;

outf := join(%newf%,%pref%, left.fld_val = right.fld_val, %into_comp%(LEFT,RIGHT), full outer);

endmacro;
