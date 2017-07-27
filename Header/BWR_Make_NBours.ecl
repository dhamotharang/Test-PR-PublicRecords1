
// MOVED TO PROC_MAKE_NBRS
/*
oformat :=   record
  string12 person1;
  string12 person2;
  string6  overlap;
  string6  prim_range;
  string6  distance;
  end;

oformat1 := record
  oformat;
  unsigned integer8 __filepos { virtual(fileposition)};
  end;

oformat into(header.nbours infile) := transform
  self.person1 := intformat(infile.did1,12,1);
  self.person2 := intformat(infile.did2,12,1);
  self.overlap := intformat(infile.overlap,6,1);
  self.prim_range := intformat(infile.prim_range,6,1);
  self.distance := intformat(infile.distance,6,1);
  end;


base_file := header.NBours;

r := project(base_file,into(left));

output(r,,'OUT::NBrs' + header.version, overwrite);

output(base_file,,'base::Nbrs' + thorlib.wuid(),overwrite);
*/

// MOVED TO PROC_MAKE_NBRS