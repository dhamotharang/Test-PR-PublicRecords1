import doxie,doxie_files,doxie_build,codes,autokey,suppress, ut, _Control, Data_Services;
export DOC_People_Raw(
    dataset(Doxie.layout_references) dids,
		string14 did_value = '',
    string25 doc_number = '',
    string2  doc_state = '',
		string60 ofk_in = '',
		string14 uid_value= '',
	unsigned8 maxResults_val = 2000,
	unsigned4 dateVal = 0,
	unsigned1 dppa_purpose = 0,
	unsigned1 glb_purpose = 0,
	string6 ssn_mask_value = 'NONE',
	boolean isCRS = false,
	string32 appType
) := FUNCTION

Layout_ofk :=
RECORD
	STRING60 ofk;
	STRING10 doc_num;
	unsigned6 did;
END;

offenders_key := doxie_files.Key_Offenders();
Layout_ofk double_fetch(offenders_key R) :=
TRANSFORM
	SELF.ofk := R.offender_key;
	SELF.did := (unsigned6)R.did;
	SELF.doc_num := R.doc_num;
END;

//---------------[ Doc_number method ] -------------
offenders_docnum_key := doxie_files.Key_offenders_docnum();
Layout_ofk fetch_by_docnum(offenders_docnum_key L) := transform
	self.ofk := L.offender_key;
	SELF.did := (unsigned6)L.did;
	SELF.doc_num := L.doc_num;
end;

ds_doc_num := offenders_docnum_key(keyed(doc_number = docnum AND doc_number<>'') and
									  keyed(doc_state = '' or state = doc_state));
F2 := project(LIMIT (ds_doc_num, ut.limits. OFFENDERS_MAX, KEYED, SKIP), fetch_by_docnum(LEFT));

F2b := JOIN(F2,offenders_key,
            keyed((unsigned6)left.did = right.sdid) AND LEFT.doc_num <> RIGHT.doc_num,
            double_fetch(RIGHT),
            LEFT OUTER, ATMOST (ut.limits. OFFENDERS_PER_DID)) + F2;

//--------------[ Offender Key Method ]----------------

key_offenders_ofk := doxie_files.Key_Offenders_OffenderKey ();
Layout_ofk fetch_by_ofk(key_offenders_ofk L) := transform
	self.ofk := L.offender_key;
	SELF.did := (unsigned6)L.did;
	SELF.doc_num := L.doc_num;
end;

ds_offender_key := key_offenders_ofk(keyed(ofk = ofk_in) AND ofk_in<>'');
F3 := project(LIMIT (ds_offender_key, ut.limits.OFFENDERS_MAX, KEYED, SKIP), fetch_by_ofk(LEFT));

F3b := JOIN(F3,offenders_key,
            keyed((unsigned6)left.did = right.sdid) AND LEFT.ofk <> RIGHT.offender_key,
            double_fetch(RIGHT),
            LEFT OUTER, ATMOST (ut.limits. OFFENDERS_PER_DID)) + F3;

//--------------[ Get all sex offenders by did and fake did ]----------------


Layout_ofk just_ofk(STRING60 ofk) :=
TRANSFORM
	SELF.ofk := ofk;
	SELF.did := 0;
	SELF.doc_num := '';
END;

F1 := join(TOPN(dids,maxResults_val,did), offenders_key, 
           keyed(left.did = right.sdid),
           just_ofk(RIGHT.offender_key), ATMOST (ut.limits. OFFENDERS_PER_DID));

// if no DOC specific fields (or DIDs) were input, and we're only using autokeys to search,
// then set noFail to false to force an exception if the input criteria are too broad
ak_only_search := not exists(dids) and did_value = '' and doc_number = '' and doc_state = '' 
									and ofk_in = '' and uid_value = '';
fake_fetch := JOIN(TOPN(autokey.get_dids('~thor_data400::key::corrections_'+doxie_build.buildstate, nofail := not ak_only_search),MaxResults_val,did),
                   doxie_files.key_offenders_fdid,
                   keyed(left.did=right.sdid),
                   just_ofk(RIGHT.offender_key), KEEP (1));
// did_join := JOIN(F1+fake_fetch, doxie_files.Key_Offenders_OffenderKey, keyed(LEFT.ofk=RIGHT.ofk),fetch_by_ofk(RIGHT));

//------------------[ Local ]--------------------------

doxie.layout_DOCSearch_Person into_plus_local(key_offenders_ofk L) := transform
	self.sex := codes.CRIM_OFFENDER2.SEX(L.sex);
	self.ssn := if(l.ssn<>'', l.ssn, l.ssn_appended);
	self := L;
end;
 
chooser := MAP(isCRS => F1,
			(doc_number<>'' OR ofk_in<>'') AND (uid_value<>'' OR did_value<>'')	=> F1+F2b+F3b,
			(doc_number<>'' OR ofk_in<>'') 								=> F2b+F3b,
																	   F1+fake_fetch);
Flocal := DEDUP(chooser,ALL);

j := JOIN(flocal,key_offenders_ofk,
          keyed(LEFT.ofk=RIGHT.ofk),
          into_plus_local(RIGHT), ATMOST (ut.limits. OFFENDERS_MAX));


outj := j(orig_state in doxie.doc_stateSubset or doxie.doc_stateSubset = []);

out_f := sort(outj,record);

Suppress.MAC_Suppress(out_f,pull_1,appType,Suppress.Constants.LinkTypes.DID,did);
Suppress.MAC_Suppress(pull_1,pull_2,appType,Suppress.Constants.LinkTypes.SSN,ssn);
Suppress.MAC_Suppress(pull_2,pull_3,appType,,,Suppress.Constants.DocTypes.OffenderKey,offender_key);

doxie.MAC_PruneOldSSNs(pull_3, out_f_p1, ssn, did);
doxie.MAC_PruneOldSSNs(out_f_p1, out_f_p2, ssn_appended, did);

suppress.MAC_Mask(out_f_p2, out_intm, ssn, blank, true, false);
suppress.MAC_Mask(out_intm, out_mskd, ssn_appended, blank, true, false);

return out_mskd;

END;