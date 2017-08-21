h := header.File_EQ_OUT_plus;

unsigned8 moxietransform(unsigned8 filepos, unsigned8 rawsize, unsigned8 headersize) :=
  if (filepos<headersize, rawsize+filepos, filepos);

// Because the only layout that actually exists in an attribute is the "File_Out_Plus" used above.  However, that
// layout uses the extra unsigned8 of __filepos, which must be removed below before doing the match on record length.
rawsize := (sizeof(header.Layout_File_Out_plus)-8) * count(h) : global;
headersize := if ((sizeof(header.Layout_File_Out_plus)-8)>215, (sizeof(header.Layout_File_Out_plus)-8), error('too bad')) : global;

dfile := INDEX(h,{f:= moxietransform(__filepos, rawsize, headersize)},{h},'~thor_data400::key::moxie.eq_header.fpos.data.key');

export moxie_quick_header_keys_Part_10 := buildindex(dfile,moxie,overwrite);