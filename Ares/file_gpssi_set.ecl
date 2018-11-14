import std;

	ssi_set := files.ds_ssiset;
	
	// flatten  ssi-id set from each ssi set 
	
	layout_ssi_set_extended := record(layout_ssiset)
			integer8 primary_key;
			integer8 ssi_link_rows;
	end;

  layout_ssi_set_extended add_sequence(ssi_set l, integer seq_cnt) := Transform
		self.primary_key	:= seq_cnt;
		self.ssi_link_rows := count(l.ssi_reference);
		self := l;
	end;	
	
	ssi_set_extended_ds := project(ssi_set, add_sequence(left, counter));
	
	output(	sort(ssi_set_extended_ds, id), named('ssiset_extended_ds'));
	output(	count(ssi_set_extended_ds), named('ssiset_extended_ds_count'));

	// flatten each ssi of ssiset
	layout_ssi_set_simple := record
			integer8 primary_key;
			layouts.layout_link ssi_link;
			string ssi_id := '';
			integer8 ssi_primary_key;
			string ssi_sub_category := '';
			string ssi_sub_category_short := '';
	end;
	
	layout_ssi_set_simple ssi_rows(ssi_set_extended_ds l, INTEGER c) := TRANSFORM
		self.primary_key := l.primary_key;
		self.ssi_link := l.ssi_reference[c];
		self.ssi_id := if(l.ssi_reference[c].href != '', std.str.splitwords(l.ssi_reference[c].href,'/')[3], '');
		self.ssi_primary_key := 0;
	END;
	
	ssiset_child_rows_ds := NORMALIZE(ssi_set_extended_ds, left.ssi_link_rows, ssi_rows(left, counter));
	
	output(	sort(ssiset_child_rows_ds, primary_key), named('ssiset_child_rows_ds'));
	output(	count(ssiset_child_rows_ds), named('ssiset_child_rows_ds_count'));
	
	ssi := Ares.file_ssi_flat(id != '');
	
	ssi;
	// join ssiset child rows - ssi with ssi_id
	ssiset_ssi_join_ds := join(ssiset_child_rows_ds, ssi, left.ssi_id = right.id, 
																			transform(layout_ssi_set_simple, 
																								self.ssi_sub_category := if (count(right.usage.use_type) > 0, right.usage.use_type[1].use_value, '') ; 
																								self.ssi_primary_key := right.primary_key;
																								self := left;), left outer);
	
	sort(ssiset_ssi_join_ds, primary_key);
	
	// join lookup to get ssi_category type
	ssi_type_lookup_ds := 	Ares.Files.ds_lookup(lookupname = 'SSI Type').lookupbody;
	
	ssiset_ssi_final_ds := join(ssiset_ssi_join_ds, ssi_type_lookup_ds, left.ssi_sub_category = right.id, 
																			transform(layout_ssi_set_simple, 
																								self.ssi_sub_category_short := right.tfpid; 
																								self := left;), left outer);	
	
	layout_gpssi_set final_xform(ssiset_ssi_final_ds l) := Transform
		self.Update_Flag 					:= 'A'; 
		self.Primary_Key					:= l.primary_key; 
		self.SSI_Primary_Key			:= l.ssi_primary_key;
		self.Sub_Category_Type		:= l.ssi_sub_category_short;
		self.filler 							:= '';
	End;

	final := Project(ssiset_ssi_final_ds, final_xform(left));
	
EXPORT file_gpssi_set := final;