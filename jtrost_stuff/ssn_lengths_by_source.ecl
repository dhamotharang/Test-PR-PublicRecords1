hdr := header.file_headers(ssn<>'');
//hdr := dataset('~thor_dell400_2::new_header_records',header.layout_new_records,flat)(ssn<>'');

r1 := record
 hdr;
 string30 src_desc;
 integer  ssn_length;
 boolean  in_ut_setbadssn;
 boolean  has_non_numerics;
end;

r1 t1(hdr le) := transform
 self.src_desc         := stringlib.stringtouppercase(mdr.sourcetools.translatesource(le.src));
 self.ssn_length       := length(trim(le.ssn,left,right));
 self.in_ut_setbadssn  := le.ssn in ut.Set_BadSSN and le.ssn[1..5]<>'00000';
 self.has_non_numerics := trim(le.ssn,left,right)<>stringlib.stringfilter(trim(le.ssn,left,right),'0123456789');			
 self                  := le;
end;

p1 := project(hdr,t1(left));

r2 := record
 p1.src_desc;
 p1.ssn_length;
 p1.in_ut_setbadssn;
 p1.has_non_numerics;
 count_ := count(group);
end;

ta1 := sort(table(p1,r2,src_desc,ssn_length,in_ut_setbadssn,has_non_numerics,few),src_desc,ssn_length,in_ut_setbadssn,has_non_numerics);

export ssn_lengths_by_source := output(ta1,all);