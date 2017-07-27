IMPORT DCA;

EXPORT Layouts := MODULE
	EXPORT Layout_DCA_in := RECORD
			UNSIGNED6 bdid;
	END;
	
	EXPORT Layout_DCA_out := RECORD
			UNSIGNED6 passed_bdid;
			INTEGER1 tree_pos :=0;
			UNSIGNED2 sub_group_id1 := 0;
			UNSIGNED2 sub_group_id2 := 0;
			DCA.Layout_DCA_Base_slim;
	END;
	
	EXPORT layout_subs_level1 := RECORD
		Layout_DCA_out;
		UNSIGNED2 num_level2_subs;
		DATASET(Layout_DCA_out) subs_level2{MAXCOUNT(100)};
	END;

	EXPORT Layout_DCA_norm := RECORD
			Layout_DCA_out;
			DATASET(Layout_DCA_out) parent_up1{MAXCOUNT(1)};
			DATASET(Layout_DCA_out) parent_up2{MAXCOUNT(1)};
			DATASET(Layout_DCA_out) parent_up3{MAXCOUNT(1)};
			DATASET(Layout_DCA_out) parent_up4{MAXCOUNT(1)};
			DATASET(Layout_DCA_out) parent_up5{MAXCOUNT(1)};
			UNSIGNED2 num_level1_subs;
			DATASET(layout_subs_level1) subs_level1{MAXCOUNT(100)};
	END;
	
END;