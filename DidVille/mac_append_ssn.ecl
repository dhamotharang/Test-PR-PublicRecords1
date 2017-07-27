export mac_append_ssn(inf,outf) := macro

dk := watchdog.key_best_ssn;

didville.Layout_SSN_Out get_best(inf L, dk R) := transform	
	self.SSN_Appended := R.ssn;
	self.permissions := R.permiss;
	self := L;
end;

f1 := inf(did != 0);
f_alt := inf(did = 0);

f2 := join(f1(ssn_in = ''),dk,left.did = right.did,get_best(LEFT,RIGHT),hash,left outer);
f3 := f1(ssn_in != '');

midrec := record
	didville.Layout_SSN_Out;
	boolean 	ismatch;
	integer4	freq;
end;

midrec get_max_ssn1(f3 L, header_slimsort.key_did_ssn R) := transform
	self.ssn_appended := R.ssn;
	self.ismatch := if (((integer)L.ssn_in)%10000 = (integer)R.ssn4 and self.ssn_appended != '',true,false);
	self.freq := R.freq;
	self.permissions := 1;
	self := l;
end;

midrec get_max_ssn2(f3 L, header_slimsort.key_did_ssn_nonUtil R) := transform
	self.ssn_appended := R.ssn;
	self.ismatch := if (((integer)L.ssn_in)%10000 = (integer)R.ssn4 and self.ssn_appended != '',true,false);
	self.freq := R.freq;
	self.permissions := 2;
	self := l;
end;
  
midrec get_max_ssn3(f3 L, header_slimsort.key_did_ssn_nonglb R) := transform
	self.ssn_appended := R.ssn;
	self.ismatch := if (((integer)L.ssn_in)%10000 = (integer)R.ssn4 and self.ssn_appended != '',true,false);
	self.freq := R.freq;
	self.permissions := 4;
	self := l;
end;
  
midrec get_max_ssn4(f3 L, header_slimsort.key_did_ssn_nonglb_nonutil R) := transform
	self.ssn_appended := R.ssn;
	self.ismatch := if (((integer)L.ssn_in)%10000 = (integer)R.ssn4 and self.ssn_appended != '',true,false);
	self.freq := R.freq;
	self.permissions := 8;
	self := l;
end;

mid1 := join(f3,header_slimsort.key_did_Ssn,left.did = right.did,get_max_ssn1(LEFT,RIGHT),left outer,hash);
mid2 := join(f3,header_slimsort.key_did_Ssn_nonUtil,left.did = right.did,get_max_ssn2(LEFT,RIGHT),left outer,hash);
mid3 := join(f3,header_slimsort.key_did_Ssn_nonglb,left.did = right.did,get_max_ssn3(LEFT,RIGHT),left outer,hash);
mid4 := join(f3,header_slimsort.key_did_Ssn_nonglb_nonutil,left.did = right.did,get_max_ssn4(LEFT,RIGHT),left outer,hash);

  
mid1a := dedup(sort(mid1,seq,-ismatch,-freq),seq);
mid2a := dedup(sort(mid2,seq,-ismatch,-freq),seq);
mid3a := dedup(sort(mid3,seq,-ismatch,-freq),seq);
mid4a := dedup(sort(mid4,seq,-ismatch,-freq),seq);
  
  
mid5 := group(sort(group(mid1a + mid2a + mid3a + mid4a),seq,permissions),seq);
	
mid5 roll(mid5 L, mid5 R) := transform
  self.permissions := L.permissions | if (l.ssn_appended = r.ssn_appended,R.permissions,0);
  self := L;
end;
  
out1 := rollup(mid5,true,roll(LEFT,RIGHT));
  
didville.Layout_SSN_Out into_outSsn(out1 L) := transform
	self := L;
end;
  
o2 := project(out1,into_outSSN(LEFT));

no_ssn := o2(ssn_appended = '');
yes_ssn := o2(ssn_appended != '');

o2 fill_blanks(no_ssn L, f3 R) := transform
	self.ssn_appended := R.ssn_in;
	self.permissions := 15; // is this right?
	self := L;
end;
  
o3 := join(no_ssn,f3,left.seq = right.seq,fill_blanks(LEFT,RIGHT),left outer, hash)
		+ yes_ssn;
 
o3 proj(f_Alt L) := transform
	 self.ssn_appended := '';
	 self.permissions := 0;
	 self := L;
end;
 
outf := f2 + o3 + project(f_alt,proj(LEFT));

endmacro;