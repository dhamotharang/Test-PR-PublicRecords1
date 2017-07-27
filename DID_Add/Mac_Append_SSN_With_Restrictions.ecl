export Mac_Append_SSN_With_Restrictions(inf,outf,did_field,ssn_field,restr_field) := macro                                                                      

/* In "restr_field" (restrictions byte) an "on" bit means you can see the ssn
	 xxx1 = glb permissitted people can see it (1)
	 xx1x = glb but not utility permitted people can see it (2)
	 x1xx = non-glb people can see it (4)
	 1xxx = non-glb, non-utility people can see it (8)
*/

#uniquename(seq_rec)
#uniquename(seq)
%seq_rec% := record
	unsigned4	%seq%;
	inf;
end;

#uniquename(into_seq)
%seq_rec% %into_seq%(inf L, integer C) := transform
	self.%seq% := c;
	self := L;
end;

#uniquename(infile)
#uniquename(infile_use)
%infile% := distribute(project(inf,%into_seq%(LEFT,COUNTER)),hash(did_field));
%infile_use% := %infile%(did_field != 0);

#uniquename(join_glb)
%seq_rec% %join_glb%(%infile_use% L, watchdog.File_Best R) := transform
	self.ssn_field := R.ssn;
	self.restr_field := 1;
	self := L;
end;

#uniquename(join_nonutility)
%seq_rec% %join_nonutility%(%infile_use% L, watchdog.File_Best_nonutility R) := transform
	self.ssn_field := R.ssn;
	self.restr_field := 2;
	self := L;
end;

#uniquename(join_nonglb)
%seq_rec% %join_nonglb%(%infile_use% L, watchdog.File_Best_nonglb R) := transform
	self.ssn_field := R.ssn;
	self.restr_field := 4;
	self := L;
end;

#uniquename(join_nonglb_nonutility)
%seq_rec% %join_nonglb_nonutility%(%infile_use% L, watchdog.File_Best_nonglb_nonutility R) := transform
	self.ssn_field := R.ssn;
	self.restr_field := 8;
	self := L;
end;

#uniquename(df1)
#uniquename(df2)
#uniquename(df3)
#uniquename(df4)
%df1% := join(%infile_use%,watchdog.File_Best,left.did_field = right.did,%join_glb%(LEFT,RIGHT),left outer,local);
%df2% := join(%infile_use%,watchdog.File_Best_nonutility,left.did_field = right.did,%join_nonutility%(LEFT,RIGHT),left outer, local);
%df3% := join(%infile_use%,watchdog.File_Best_nonglb,left.did_field = right.did,%join_nonglb%(LEFT,RIGHT),local,left outer);
%df4% := join(%infile_use%,watchdog.File_Best_nonglb_nonutility,left.did_field =right.did,%join_nonglb_Nonutility%(LEFT,RIGHT),left outer, local);

#uniquename(df5)
%df5% := group(sort(%df1% + %df2% + %df3% + %df4%,%seq%,did_field,restr_field),%seq%,did_field);

#uniquename(set_restr)
%df5% %set_restr%(%df5% L, %df5% R) := transform
	self.restr_field := L.restr_field | if (L.ssn_field = R.ssn_field,R.restr_field,0);
	self.ssn_field := L.ssn_field;
	self := l;
end;

#uniquename(o1)
%o1% := rollup(%df5%,left.%seq% = right.%seq%,%set_restr%(LEFT,RIGHT));

#uniquename(o2)
#uniquename(strip_seq)
inf %strip_seq%(%o1% L) := transform
	self := L;
end;

%o2% := project(%o1%,%strip_seq%(LEFT));

outf := %o2% + inf(did = 0);

endmacro;