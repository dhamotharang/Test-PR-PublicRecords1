lastmaxbdid := 744369890;

bh_new := Business_Header.File_Business_Header(bdid > lastmaxbdid);
bh_old := Business_Header.File_Business_Header(bdid <= lastmaxbdid);

bc_new := Business_Header.File_Business_Contacts(bdid > lastmaxbdid);
bc_old := Business_Header.File_Business_Contacts(bdid <= lastmaxbdid);

paw_new := Business_Header.File_Employment_Out((integer)bdid > lastmaxbdid);
paw_old := Business_Header.File_Employment_Out((integer)bdid <= lastmaxbdid);

////////////////////////////////////////////////////////////////////////////////////////////
layout_bc_old_table :=
record
	bc_old.source;
	integer4 cnt := count(group);
end;

bc_old_source_table := table(bc_old, layout_bc_old_table, source);

layout_bc_old_table_bdid :=
record
	bc_old.bdid;
end;

bc_old_source_table_bdid := table(bc_old, layout_bc_old_table_bdid, bdid);

output(count(bc_old_source_table_bdid), named('TotalUniqueOldBusinessContactsBdids'));

output(bc_old_source_table, named('OldBusinessContactsBdidsBySource'), all);
//////////////////////////////////////////////////////////////////////////////////////
layout_bc_new_table :=
record
	bc_new.source;
	integer4 cnt := count(group);
end;

bc_new_source_table := table(bc_new, layout_bc_new_table, source);

layout_bc_new_table_bdid :=
record
	bc_new.bdid;
end;

bc_new_source_table_bdid := table(bc_new, layout_bc_new_table_bdid, bdid);

output(count(bc_new_source_table_bdid), named('TotalUniqueNewBusinessContactsBdids'));

output(bc_new_source_table, named('NewBusinessContactsBdidsBySource'), all);
////////////////////////////////////////////////////////////////////////////////////////////
layout_bh_old_table :=
record
	bh_old.source;
	integer4 cnt := count(group);
end;

bh_old_source_table := table(bh_old, layout_bh_old_table, source);

layout_bh_old_table_bdid :=
record
	bh_old.bdid;
end;

bh_old_source_table_bdid := table(bh_old, layout_bh_old_table_bdid, bdid);

//output(count(bh_old_source_table_bdid), named('TotalUniqueOldBusinessHeaderBdids'));

//output(bh_old_source_table, named('OldBusinessHeaderBdidsBySource'), all);

////////////////////////////////////////////////////////////////////////////////////////////
layout_bh_new_table :=
record
	bh_new.source;
	integer4 cnt := count(group);
end;

bh_new_source_table := table(bh_new, layout_bh_new_table, source);

layout_bh_new_table_bdid :=
record
	bh_new.bdid;
end;

bh_new_source_table_bdid := table(bh_new, layout_bh_new_table_bdid, bdid);

output(count(bh_new_source_table_bdid), named('TotalUniqueNewBusinessHeaderBdids'));

output(bh_new_source_table, named('NewBusinessHeaderBdidsBySource'), all);

////////////////////////////////////////////////////////////////////////////////////////////

layout_paw_old_table :=
record
	paw_old.source;
	paw_old.score;
	integer4 cnt := count(group);
end;

paw_old_source_table := table(paw_old, layout_paw_old_table, source, score, few);

layout_paw_old_table_bdid :=
record
	paw_old.bdid;
end;

paw_old_source_table_bdid := table(paw_old, layout_paw_old_table_bdid, bdid);

output(count(paw_old_source_table_bdid), named('TotalUniqueOldPawBdids'));

output(paw_old_source_table, named('OldPawBdidsBySource'), all);
////////////////////////////////////////////////////////////////////////////////////////////

layout_paw_new_table :=
record
	paw_new.source;
	paw_new.score;
	integer4 cnt := count(group);
end;

paw_new_source_table := table(paw_new, layout_paw_new_table, source, score, few);

layout_paw_new_table_bdid :=
record
	paw_new.bdid;
end;

paw_new_source_table_bdid := table(paw_new, layout_paw_new_table_bdid, bdid);

output(count(paw_new_source_table_bdid), named('TotalUniqueNewPawBdids'));

output(paw_new_source_table, named('NewPawBdidsBySource'), all);


///////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////

bh_father := Business_Header.File_Business_Header_father;
bc_father := Business_Header.File_Business_Contacts_father;

////////////////////////////////////////////////////////////////////////////////////////////
layout_bc_father_table :=
record
	bc_father.source;
	integer4 cnt := count(group);
end;

bc_father_source_table := table(bc_father, layout_bc_father_table, source);

layout_bc_father_table_bdid :=
record
	bc_father.bdid;
end;

bc_father_source_table_bdid := table(bc_father, layout_bc_father_table_bdid, bdid);

output(count(bc_father_source_table_bdid), named('TotalUniqueFatherBusinessContactsBdids'));

output(bc_father_source_table, named('FatherBusinessContactsBdidsBySource'), all);
//////////////////////////////////////////////////////////////////////////////////////

layout_bh_father_table :=
record
	bh_father.source;
	integer4 cnt := count(group);
end;

bh_father_source_table := table(bh_father, layout_bh_father_table, source);

layout_bh_father_table_bdid :=
record
	bh_father.bdid;
end;

bh_father_source_table_bdid := table(bh_father, layout_bh_father_table_bdid, bdid);

//output(count(bh_father_source_table_bdid), named('TotalUniqueFatherBusinessHeaderBdids'));

//output(bh_father_source_table, named('FatherBusinessHeaderBdidsBySource'), all);

