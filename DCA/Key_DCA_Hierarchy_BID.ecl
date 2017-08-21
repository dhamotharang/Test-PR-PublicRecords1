import doxie,ut;

f := DCA.File_DCA_Base_bid(bdid <> 0);

layout_dca_hierarchy := record
f.bdid;
f.level;
f.root;
f.sub;
string6 parent_root := f.parent_number[1..6];
string3 parent_sub := f.parent_number[8..10];
end;

dca_hierarchy := table(f, layout_dca_hierarchy);

export Key_DCA_Hierarchy_BID := index(dca_hierarchy,{bdid},{dca_hierarchy},'~thor_data400::key::dca_hierarchy_bid_'+doxie.Version_SuperKey);
