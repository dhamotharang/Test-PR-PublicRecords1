my_bc_init := dataset('~thor_data400::TEMP::BC_Init', Business_Header.Layout_Business_Contacts_Temp, flat);

bc_init_ssn := my_bc_init(ssn != 0);

layout_bc_table :=
record
	bc_init_ssn.source;
	integer4 cnt := count(group);
end;

bc_init_ssn_table := table(bc_init_ssn, layout_bc_table, source);

output(bc_init_ssn_table, all);