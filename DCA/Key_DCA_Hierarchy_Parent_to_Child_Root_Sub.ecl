
Import Data_Services, DCA, doxie, ut;

f := DCA.File_DCA_Base;

layout_dca_hierarchy_parent_to_child := RECORD
	STRING9 parent_root := IF( f.parent_number != '', f.parent_number[1..9]		, f.root );
	STRING4 parent_sub  := IF( f.parent_number != '', f.parent_number[11..14]	, f.sub );
	STRING9 child_root  := f.root;
	STRING4 child_sub   := f.sub;
	STRING2 child_level := f.level;	
END;

dca_hierarchy_parent_to_child := TABLE(f, layout_dca_hierarchy_parent_to_child);

EXPORT Key_DCA_Hierarchy_Parent_to_Child_Root_Sub := 
            INDEX(dca_hierarchy_parent_to_child,
						      {parent_root, parent_sub, child_root, child_sub, child_level},
									{dca_hierarchy_parent_to_child},
									Data_Services.Data_location.Prefix('NONAMEGIVEN')+'thor_data400::key::dca_hierarchy_parent_to_child_root_sub_'+doxie.Version_SuperKey);
