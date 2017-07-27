export fn_patch_name_field(string in_field) := function
 
 typeof(in_field) v_name := in_field;
 
 string v_name_patched := if(v_name[1..2]=', ',v_name[3..100],v_name);
 
 return v_name_patched;

end;