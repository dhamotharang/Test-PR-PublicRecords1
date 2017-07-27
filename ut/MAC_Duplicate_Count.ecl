export Mac_Duplicate_Count(infile,infield,outp) := macro
#uniquename(proj)
%proj% := record
  infile.infield;
  end;
#uniquename(ttable)
%ttable% := distribute(table(infile,%proj%),hash(infield));
#uniquename(count_record)
%count_record% := record
  integer2 cnt := count(group);
  end;

#uniquename(counts)
%counts% := table(%ttable%,%count_record%,%ttable%.infield,local);

#uniquename(count_totals)
%count_totals% := record
  integer2 number_dups := %counts%.cnt;
  integer4 occurrences := count(group);
  end;
#uniquename(ccounts)
%ccounts% := table(%counts%,%count_totals%,%counts%.cnt,few);

outp := output(choosen(%ccounts%,1000), NAMED('Duplicate_Count'))

  endmacro;