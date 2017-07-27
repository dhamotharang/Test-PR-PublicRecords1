
// Only gets name info on did2 which is the relative.
layout := RECORD
  unsigned8 did;
  string15 type;
  string10 confidence;
  unsigned6 did2;
  string20 fname2;
  string20 lname2;
 END;


EXPORT Relatives := dataset([], layout);

