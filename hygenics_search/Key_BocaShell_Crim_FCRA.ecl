//
// hygenics_search.Key_BocaShell_Crim_FCRA
//

Import Data_Services, doxie, ut, crimsrch, hygenics_crim,doxie_build,corrections;

file_offenses_ds := dataset('~thor_data400::base::corrections_offenses_' + doxie_build.buildstate,hygenics_crim.Layout_Base_Offenses_with_OffenseCategory,flat)(length(trim(offender_key, left, right))>2);
file_offenses_keybuilding := hygenics_crim.Prep_Build.PB_File_Offenses(file_offenses_ds);

file_courtoffenses_ds := dataset('~thor_Data400::base::corrections_court_offenses_' + doxie_build.buildstate, hygenics_crim.Layout_Base_CourtOffenses_with_OffenseCategory,flat)(length(offender_key)>2);
file_courtoffenses_keybuilding  := hygenics_crim.Prep_Build.PB_File_CourtOffenses(file_courtoffenses_ds);

f := hygenics_search.file_fcra_offenders_keybuilding (Vendor not in hygenics_search.sCourt_Vendors_To_Omit);
o := file_courtoffenses_keybuilding (Vendor not in hygenics_search.sCourt_Vendors_To_Omit and (stringlib.stringfind(court_disp_desc_1, 'DISMISSED', 1) > 0 or stringlib.stringfind(court_disp_desc_2, 'DISMISSED', 1) > 0));
d := file_offenses_keybuilding (Vendor not in hygenics_search.sCourt_Vendors_To_Omit and (stringlib.stringfind(ct_disp_desc_1, 'DISMISSED', 1) > 0 or stringlib.stringfind(ct_disp_desc_2, 'DISMISSED', 1) > 0));
//o := hygenics_crim.file_courtoffenses_keybuilding (Vendor not in hygenics_search.sCourt_Vendors_To_Omit and (stringlib.stringfind(court_disp_desc_1, 'DISMISSED', 1) > 0 or stringlib.stringfind(court_disp_desc_2, 'DISMISSED', 1) > 0));
//d := hygenics_crim.file_offenses_keybuilding (Vendor not in hygenics_search.sCourt_Vendors_To_Omit and (stringlib.stringfind(ct_disp_desc_1, 'DISMISSED', 1) > 0 or stringlib.stringfind(ct_disp_desc_2, 'DISMISSED', 1) > 0));

layout_offense := record
	string60	offender_key;
	string35  case_number;
	string	  fcra_date;
	string1		fcra_conviction_flag;
	string1		fcra_traffic_flag;
	string2		offense_score;
end;

	layout_offense ctOff(o l):= transform
	  self.case_number := l.court_case_number;
		self := l;
	end;

	o_offense := project(o, ctOff(left));
	
	layout_offense docOff(d l):= transform
	  self.case_number := l.case_num;
		self := l;
	end;
	
	d_offense := project(d, docOff(left));
	
offenses := o_offense + d_offense;

layout_date := RECORD
	unsigned4 date;
	string60	offender_key;
	string35  case_num; 
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
	string35    offender_key; 
END;

layout_rollup add_doc(f le, offenses ri) := TRANSFORM
	SELF.criminal_count := DATASET([{(unsigned4)le.fcra_date, le.offender_key, le.case_num, le.fcra_conviction_flag, le.fcra_traffic_flag, le.offense_score}],layout_date);
	SELF.offender_key := le.offender_key;
	self.did := (unsigned6)le.did;
END;

// only need 1 of the offense records for that offender key to be "dismissed" to throw this record out
dismissed_offenses := offenses;//crimsrch.File_Moxie_Offenses_Dev( stringlib.stringfind(court_disp_desc, 'DISMISSED', 1) > 0 );

// left only join to dismissed_offenses to filter out any cases which have been dismissed															 
doc_added := join(
	distribute(f((integer)did != 0 AND fcra_date<>'' AND offender_key <> ''), hash64(offender_key)), 
	distribute(dismissed_offenses, hash64(offender_key)), 
	left.offender_key=right.offender_key, 
	add_doc(LEFT, RIGHT), left only, local);

layout_rollup roll_doc (layout_rollup le, layout_rollup ri) := TRANSFORM
  boolean sameOffender := le.offender_key=ri.offender_key;
	SELF.criminal_count := CHOOSEN (le.criminal_count + IF(~sameOffender, ri.criminal_count),100);
	SELF := le;
END;

doc_rolled 	:= ROLLUP(SORT(DISTRIBUTE(doc_added,HASH(did)),did,offender_key, local), LEFT.did=RIGHT.did, roll_doc(LEFT,RIGHT), local);
doc_final 	:= PROJECT (doc_rolled, transform (slimrec, SELF := Left));

export Key_BocaShell_Crim_FCRA := index(doc_final, {did}, {doc_final}, '~thor_data400::key::corrections_offenders::fcra::bocashell_did_' + doxie.Version_SuperKey);