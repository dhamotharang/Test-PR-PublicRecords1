export string32 MapOutputCharterNumber(string2 state, string32 charter_number) := 
  map(state = 'NV' => Stringlib.StringFilterOut(charter_number, 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'),
      charter_number);