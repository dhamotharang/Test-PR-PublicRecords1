import header;
// This should probably be header.File_Headers
f := header.File_Headers(not header.isDemoData());

export max_rid := mdr.fn_Max_RID(f);
// :global;
