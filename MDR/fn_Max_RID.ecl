import header;
export fn_Max_RID(Dataset(header.Layout_Header) f) := 
FUNCTION

rs := record
  f.rid;
  end;

t := table(f,rs);

return MAX(t,rid);

END;