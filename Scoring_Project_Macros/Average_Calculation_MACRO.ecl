EXPORT Average_Calculation_MACRO(dtset) := functionmacro

layout := record
STRING Score_name := dtset.field_name;
decimal9_2 Average := AVE(group, (real)dtset.field_value);
end;

result_table := table(dtset, layout, dtset.field_name);

return result_table;

endmacro;