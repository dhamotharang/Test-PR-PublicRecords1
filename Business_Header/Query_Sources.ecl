lastmaxbdid := 811027219;

bh := Business_Header.File_Business_Header(bdid > lastmaxbdid);

bc := Business_Header.File_Business_Contacts(bdid > lastmaxbdid);

paw := Business_Header.File_Employment_Out(bdid > (string)lastmaxbdid);

////////////////////////////////////////////////////////////////////////////////////////////
layout_bc_table :=
record
	bc.source;
	integer4 cnt := count(group);
end;

bc_source_table := table(bc, layout_bc_table, source);

layout_bc_table_bdid :=
record
	bc.bdid;
end;

bc_source_table_bdid := table(bc, layout_bc_table_bdid, bdid);

output(count(bc_source_table_bdid), named('TotalUniqueNewBusinessContactsBdids'));

output(bc_source_table, named('NewBcBdidsBySource'), all);

////////////////////////////////////////////////////////////////////////////////////////////
layout_bh_table :=
record
	bh.source;
	integer4 cnt := count(group);
end;

bh_source_table := table(bh, layout_bh_table, source);

layout_bh_table_bdid :=
record
	bh.bdid;
end;

bh_source_table_bdid := table(bh, layout_bh_table_bdid, bdid);

output(count(bh_source_table_bdid), named('TotalUniqueNewBusinessHeaderBdids'));

output(bh_source_table, named('NewBhBdidsBySource'), all);

////////////////////////////////////////////////////////////////////////////////////////////

layout_paw_table :=
record
	paw.source;
	paw.score;
	integer4 cnt := count(group);
end;

paw_source_table := table(paw, layout_paw_table, source, score, few);

layout_paw_table_bdid :=
record
	paw.bdid;
end;

paw_source_table_bdid := table(paw, layout_paw_table_bdid, bdid);

output(count(paw_source_table_bdid), named('TotalUniqueBdidNewPawBdids'));

output(paw_source_table, named('NewPawBdidsBySource'), all);
////////////////////////////////////////////////////////////////////////////////////////////
