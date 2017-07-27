ds := WorldCheck.File_Main;

temp_record := record
		integer4                      UID;
		string255                     First_Name;
		string255                     Last_Name;
		string1                       E_I_Ind;
end;

temp_record tNewlayout(ds L) := transform
   self := L;
end;

ds_new := project(ds, tNewLayout(left));

ds_new_dedup := dedup(ds_new);

output(ds_new_dedup
		,
		,'~thor_data400::temp::WorldCheck_Delimited'
		,overwrite
		,csv(SEPARATOR('|'), TERMINATOR('\n')));