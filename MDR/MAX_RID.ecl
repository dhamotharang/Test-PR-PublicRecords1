import header;
// This should probably be header.File_Headers
f := header.File_Headers;

rs := record
  f.rid;
  end;

t := table(f,rs);

export max_rid := MAX(t,rid);// :global;

//export max_rid := 4500000000;
//keep it commented out so that folks don't use it without knowing what it should be
//ensure that it is set to a number higher than the highest rid in the current header file