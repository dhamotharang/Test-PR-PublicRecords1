import bankruptcyv3, banko;

export fn_rollup_dockets(
	dataset(recordof(bankruptcyv3.key_bankruptcyv3_main_full())) in_records, boolean isFCRA, 
			string8 lower_entered_date, string8 upper_entered_date) :=
		function
			
			// key containing docket info
			k_dock := Banko.Key_Banko_courtcode_casenumber(isFCRA);
			
			// filter range of entereddate values
			EnteredDateFilter() := macro
				(right.entereddate[1..8] >= lower_entered_date or lower_entered_date = '')
				and
				(right.entereddate[1..8] <= upper_entered_date or upper_entered_date = '')
			endmacro;
			
			clean_docket_text(string5000 doc_txt) := 
				regexreplace('&AMP;',
											// regexreplace('(  *)', 
																	trim(doc_txt, left, right), 
																	// ' '),
											'&');
		
      temp_docket_evts := 
				join(
					in_records,
					k_dock,
					left.tmsid[3..7] = right.court_code and left.tmsid[8..] = right.casekey
					and EnteredDateFilter(),
					transform(
						bankruptcyv3_services.layouts.layout_docket_ext,
						self.DocketText := clean_docket_text(right.DocketText);
						self := right,
						self := left));
						
		  /* Added AttachmentURL to the sort to prevent the dedup from selecting a docket item without 
         an attachment URL when one with an attachment exists.  Items without an attachment URL usually 
         have an entrynumber of -1, but not always. */

			temp_docket_dedup :=
				dedup(
					sort(
						temp_docket_evts(DocketText != ''),
						tmsid, FiledDate, entrynumber, -AttachmentURL, DocketText),
					tmsid, FiledDate, entrynumber, DocketText);
			temp_docket_keep :=
					sort(
						temp_docket_dedup,
						tmsid, FiledDate, pacer_entereddate, (unsigned) EntryNumber, DocketText);
			temp_docket_roll :=
				rollup(
					group(temp_docket_keep, tmsid),
					group,
					transform(
						bankruptcyv3_services.layouts.layout_docket_roll,
						self.dockets := choosen(project(rows(left),bankruptcyv3_services.layouts.layout_docket),
																		 bankruptcyv3_services.consts.DOCKETS_PER_ROLLUP),
						self := left));
			
			// output(temp_docket_evts, named('temp_docket_evts'));
			// output(temp_docket_dedup, named('temp_docket_dedup'));

			return
				temp_docket_roll;
		end;
		