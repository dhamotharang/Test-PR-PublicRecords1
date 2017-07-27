Import Data_Services, doxie, ut, crimsrch;

	layout_date := RECORD
		unsigned4 	date;
		string60	offender_key;
		string35  	case_num; 
		string1		fcra_conviction_flag;
		string1		fcra_traffic_flag;
		string2		offense_score;
	END;

	slimrec := RECORD
		unsigned6	did;
		DATASET(layout_date) criminal_count {MAXCOUNT(100)};
	END;

	layout_rollup := record // need offender_key to accomplish final rollup
		slimrec;
		string35   	offender_key; 
	END;

	layout_rollup add_doc(crimsrch.Layout_Moxie_Offender le) := TRANSFORM
		SELF.criminal_count := DATASET([{(unsigned4)le.fcra_date, le.offender_key, le.case_number, le.fcra_conviction_flag, le.fcra_traffic_flag, le.offense_score}],layout_date);
		SELF.offender_key 	:= le.offender_key;
		self.did 			:= (unsigned6)le.did;
	END;

doc_added 	:= PROJECT(hygenics_search.File_Moxie_Offender_Dev((integer)did != 0 AND fcra_date<>'' AND offender_key <> ''), add_doc(LEFT));

	layout_rollup roll_doc (layout_rollup le, layout_rollup ri) := TRANSFORM
	  boolean sameOffender 	:= le.offender_key=ri.offender_key;
		SELF.criminal_count := CHOOSEN (le.criminal_count + IF(~sameOffender, ri.criminal_count),100);
		SELF := le;
	END;

doc_rolled 	:= ROLLUP(SORT(DISTRIBUTE(doc_added,HASH(did)),did,offender_key, local), LEFT.did=RIGHT.did, roll_doc(LEFT,RIGHT), local);
doc_final 	:= PROJECT (doc_rolled, transform (slimrec, SELF := Left));

export Key_BocaShell_Crim_FCRA := index(doc_final, {did}, {doc_final}, Data_Services.Data_location.Prefix('Provider')+'thor_data400::key::corrections_offenders::fcra::bocashell_did_' + doxie.Version_SuperKey);
