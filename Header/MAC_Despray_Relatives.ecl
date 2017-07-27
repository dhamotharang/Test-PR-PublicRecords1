export MAC_Despray_Relatives(infile,seqname) := macro

#uniquename(PGRun)
%PGRun% := 0 : stored('PG_Rels');

#uniquename(oformat)
%oformat% :=   record
  string12 person1 := intformat(infile.person1,12,1);
  string12 person2 := intformat(infile.person2,12,1);
  string6  recent_cohabit := intformat(infile.recent_cohabit,6,1);
  string1  same_lname := if(infile.same_lname,'Y','N');
  string3  number_cohabits := if(infile.number_cohabits>999,'999',intformat(infile.number_cohabits,3,1));
  end;

#uniquename(r)
%r% := table(infile,%oformat%);

//outname := if(%pgrun% = 0, 'OUT::Relatives', 'OUT::PreGLB_Relatives');

seqname := output(%r%,,'OUT::Relatives'
// + header.version  this adding extra spaces right now
, overwrite);

endmacro;