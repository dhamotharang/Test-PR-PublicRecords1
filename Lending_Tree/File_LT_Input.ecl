// lending_tree.Layout_LT_Input trim_LT_Raw(Lending_Tree.File_LT_Input_Raw le) := transform
	// self := le;
// end;

// export File_LT_Input := project(Lending_Tree.File_LT_Input_Raw,trim_LT_Raw(left));


export File_LT_Input := dataset('~thor_data400::in::lendingtree_201509',Lending_Tree.Layout_LT_Input_Raw,flat);