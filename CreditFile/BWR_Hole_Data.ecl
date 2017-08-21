p := creditfile.file_person_enhanced;

hole_person := sort ( distribute( p, hash(per_id) ), per_id, local ) : persist('temp::creditfile_person_sorted');

output(hole_person,,'HoleLoad::CreditFile_Person',overwrite);

t := creditfile.File_Trade_Plus;

creditfile.layout_hole_trade take_left(t le) := transform
  self.trd_per_id := le.per_id;
  self.duplicate := transfer(le.presflag[4], unsigned1) & 0x30 <> 0;
  self := le;
  end;

dsort_t := sort ( distribute( t, hash(per_id) ), per_id, local ) : persist('temp::creditfile_trade_sorted');

//hole_trade := project(dsort_t,into_trade(left));

hole_trade := join(dsort_t,hole_person,left.per_id=right.per_id,take_left(left),local);


output(hole_trade,,'HoleLoad::CreditFile_Trade',overwrite);