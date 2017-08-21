import doxie,ut;

f := DCA.File_DCA_Base_bid;

layout_dca_hierarchy := record
f.bdid;
f.level;
f.root;
f.sub;
string6 parent_root := f.parent_number[1..6];
string3 parent_sub := f.parent_number[8..10];
end;

dca_hierarchy := table(f, layout_dca_hierarchy);

export Key_DCA_Hierarchy_Root_Sub_bid := index(dca_hierarchy,{root, sub},{dca_hierarchy},'~thor_data400::key::dca_hierarchy_root_sub_bid_'+doxie.Version_SuperKey);
