/*
Used in the BTST shell
Common Last Name Link - btst_last_names_in_common - Number of unique last names in the intersection of BT last names and ST last names -- Including the input names
*/

import doxie, Risk_Indicators, models;
							
EXPORT Boca_Shell_BtSt_Header (grouped dataset(Risk_Indicators.layout_ciid_btst_Output) inrec	) := function													

	Layout_Header_Data := record
		qstring1200 lname ;
		unsigned4 seq;
		integer btst_last_names_in_common := 0;
	end;	

	inrec_ungrpd := ungroup(inrec);
	bt_LNames := project(inrec_ungrpd, transform(Layout_Header_Data, 
														 self.seq := left.bill_to_output.seq, 
														 self.lname := if(left.bill_to_output.lname != '', trim(left.bill_to_output.lname) + ',' + left.bill_to_output.header_summary.lnames_on_file, left.bill_to_output.header_summary.lnames_on_file),
														 ));
	st_Lnames := project(inrec_ungrpd, transform(Layout_Header_Data, 
														 self.seq := left.ship_to_output.seq, 
														 self.lname := if(left.ship_to_output.lname != '', trim(left.ship_to_output.lname) + ',' + left.ship_to_output.header_summary.lnames_on_file, left.ship_to_output.header_summary.lnames_on_file),
														 ));
	btst_lnames_tmp := join(bt_LNames, st_Lnames,
		LEFT.seq = RIGHT.seq -1,
		transform(Layout_Header_Data,
				bt_lnames_split := models.common.zip2(left.lname, left.lname, ' ,');
				st_lnames_split := models.common.zip2(right.lname, right.lname, ' ,');
				bt_lnames_dedupe := dedup(sort(bt_lnames_split(str1 != ''), str1), str1);
				st_lnames_dedupe := dedup(sort(st_lnames_split(str1 != ''), str1), str1);			
				common_lnames := join(bt_lnames_dedupe, st_lnames_dedupe, 
					left.str1 = right.str1);
				CommonlnameCnt := count(common_lnames);
					self.btst_last_names_in_common := CommonlnameCnt;
					self.lname := '';
					self.seq := LEFT.seq),
					left outer);
	btst_lnames := group(btst_lnames_tmp, seq);

	//outputs for debugging
	// output(bt_LNames, named('bt_LNames'));
	// output(st_Lnames, named('st_Lnames'));
	// output(btst_lnames, named('btst_lnames'));

	return btst_lnames;

end;