Import Data_Services, doxie,ut;

f := DCA.File_DCA_Base_bdid;

layout_dca_hierarchy := record
f.bdid;
f.level;
f.root;
f.sub;
string9 parent_root := f.parent_number[1..9];
string4 parent_sub 	:= f.parent_number[11..14];
end;

dca_hierarchy := table(f, layout_dca_hierarchy);

export Key_DCA_Hierarchy_Root_Sub := index(dca_hierarchy,{root, sub},{dca_hierarchy},Data_Services.Data_location.Prefix('NONAMEGIVEN')+'thor_data400::key::dca_hierarchy_root_sub_'+doxie.Version_SuperKey);
