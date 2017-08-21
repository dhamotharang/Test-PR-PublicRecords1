export fn_AddStat(real8 value, string name) := 
FUNCTION

return ut.fn_AddStatDS(dataset([{name, value}], ut.layout_stats_extend)/*, name*/);

END;