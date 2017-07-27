import lib_stringlib;
export CleanPrimRange(STRING10 s) :=

if (s != '' and stringlib.stringfilterout(s,'0123456789') = '',(string)((integer)s),s);
