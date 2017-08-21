import codes,std;

EXPORT fn_Valid_StateAbbrev(string st) := function

return if(st='' or Codes.valid_st(st),1,0);

end;