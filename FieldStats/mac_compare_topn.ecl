export mac_compare_topn(newdata, olddata, fieldname, outf) := macro

#uniquename(rec)
%rec% := recordof(newdata.fieldname);

#uniquename(get_fld)
%rec% %get_fld%(%rec% R) := transform
	self := R;
end;

#uniquename(newf)
#uniquename(prevf)
%newf% := sort(normalize(newdata,left.fieldname,%get_fld%(RIGHT)),-cnt);
%prevf% := sort(normalize(olddata,left.fieldname,%get_fld%(RIGHT)),-cnt);

#uniquename(seqrec)
%seqrec% := record
	unsigned4	cnt;
	string	fld_val;
	unsigned1	seq;
end;

#uniquename(into_seq)
%seqrec% %into_seq%(%newf% L, integer C) := transform
	self.seq := C;
	self := L;
end;

#uniquename(newseq)
#uniquename(oldseq)
%newseq% := project(%newf%,%into_seq%(LEFT,COUNTER));
%oldseq% := project(%prevf%,%into_seq%(LEFT,COUNTER));

#uniquename(comprec)
%comprec% := record
	unsigned4 newcnt;
	unsigned4 oldcnt;
	string 	newfld;
	string 	oldfld;
	real4	pcnt_diff;
end;

#uniquename(into_comp)
%comprec% %into_comp%(%newseq% L, %oldseq% R) := transform
	self.newcnt := L.cnt;
	self.newfld := L.fld_val;
	self.oldcnt := R.cnt;
	self.oldfld := R.fld_val;
	self.pcnt_diff := (100.0 * abs(L.cnt - R.cnt))/L.cnt;
end;

outf := join(%newseq%,%oldseq%, left.seq = right.seq, %into_comp%(LEFT,RIGHT));

endmacro;
