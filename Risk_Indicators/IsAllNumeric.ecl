export IsAllNumeric(STRING var) := IF(Stringlib.StringFilterOut(var,'0123456789')='',true,false);