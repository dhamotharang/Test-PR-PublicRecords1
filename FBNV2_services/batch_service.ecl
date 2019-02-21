/*--SOAP--
<message name="FBNBatch_Service">
	<part name="batch_in" type="tns:XmlDataSet" cols="70" rows="25"/>
	<part name="IsSearch"  		type="xsd:boolean"/>
	<part name="DPPAPurpose" type="xsd:byte"/>
	<part name="GLBPurpose" type="xsd:byte"/>
	<part name="MaxResults" type="xsd:unsignedInt"/>
	<part name="Run_Deep_Dive" type="xsd:boolean"/>
	<part name="PenaltThreshold" type="xsd:unsignedInt"/>
</message>
*/

IMPORT doxie, Autokey_batch, FBNV2_services, Address, FBNV2, BatchServices, AutokeyB2, AutoStandardI,AutoheaderV2;

EXPORT Batch_Service() := FUNCTION
 #CONSTANT('SearchLibraryVersion', AutoheaderV2.Constants.LibVersion.SALT);
	// Key
	keyIdDID := FBNV2.Key_DID;


	// Aliases
	Consts := FBNV2.Constant('');
	AutoKeyBatchInput := Autokey_batch.Layouts.rec_inBatchMaster;
	PLRec := FBNV2.File_SearchAutokey();
	SearchLayout := FBNV2_services.layout_search_IDs;
	ReportLayout := FBNV2_services.Layout_FBN_Report;
	PenaltyI := AutoStandardI.LIBIN.PenaltyI;


	// Constants
	STRING BLNK := '';
	STRING NOT_NUMBER := '\\D+';
	UNSIGNED MaxDIDs := 100;
	UNSIGNED MaxDLs := 1000;


	// Functions
	trimBoth(STRING input) := TRIM(input, LEFT, RIGHT);
	toUpper(STRING input) := StringLib.StringToUpperCase(trimBoth(input));


	// Records/Transforms
	AutoKeyBatchInput cleanInput(AutoKeyBatchInput input) := TRANSFORM
		state_in := toUpper(input.st);
		dlstate_in := toUpper(input.dlstate);

		SELF.name_first := toUpper(input.name_first);
		SELF.name_middle := toUpper(input.name_middle);
		SELF.name_last := toUpper(input.name_last);
		SELF.name_suffix := toUpper(input.name_suffix);
		SELF.p_city_name := toUpper(input.p_city_name);
		SELF.st := IF(LENGTH(state_in) > 2, Address.Map_State_Name_To_Abbrev(state_in), state_in);
		SELF.ssn := REGEXREPLACE(NOT_NUMBER, input.ssn, BLNK);
		SELF.dl := toUpper(input.dl);
		SELF.dlstate := IF(LENGTH(dlstate_in) > 2, Address.Map_State_Name_To_Abbrev(dlstate_in), dlstate_in);
		SELF := input;
	END;

	AcctRec := RECORD(SearchLayout)
		AutoKeyBatchInput.acctno;
		UNSIGNED6	did := 0;
	END;

	AcctRec fromKeyIdDID(AcctRec l, keyIdDID r) := TRANSFORM
		SELF := r;
		SELF := l;
	END;

	AcctRecWithInput := RECORD(AcctRec)
		AutoKeyBatchInput - [acctno, did];
	END;

	ReportLayout toFBNReport(AcctRecWithInput l, BOOLEAN isSearch) := TRANSFORM
		tmpParam := MODULE(PROJECT(AutoStandardI.GlobalModule(), PenaltyI.base, OPT))
			EXPORT city := l.p_city_name;
			EXPORT state := l.st;
			EXPORT z5 := l.z5;
			EXPORT predir := l.predir;
			EXPORT postdir := l.postdir;
			EXPORT suffix := l.addr_suffix;
			EXPORT prim_name := l.prim_name;
			EXPORT prim_range := l.prim_range;
			EXPORT sec_range := l.sec_range;
			EXPORT bdid := '';
			EXPORT company := l.comp_name;
			EXPORT county := '';
			EXPORT did := IF(l.DID > 0, (STRING) l.DID, BLNK);
			EXPORT fein := l.FEIN;
			EXPORT lname := l.name_last;
			EXPORT mname := l.name_middle;
			EXPORT fname := l.name_first;
			EXPORT phone := l.homephone;
			EXPORT ssn := l.ssn;
		END;

		fbns := FBNV2_services.get_FBN(DATASET(l), isSearch, tmpParam).search;

		SELF.penalt := IF(EXISTS(fbns), fbns[1].penalt, 0xFFFF);
		SELF := fbns[1];
		SELF := l;
	END;

	OutRec := RECORD(FBNV2_services.assorted_layouts.batch_out_layout)
		UNSIGNED2	penalt := 0;
	END;


	// Main
	BOOLEAN is_search := FALSE : STORED('IsSearch');
	data_in := DATASET([], AutoKeyBatchInput) : STORED('batch_in', FEW);

	cfgs := MODULE(BatchServices.Interfaces.i_AK_Config)
		EXPORT UseAllLookUps := TRUE;
		EXPORT skip_set := ['S', 'F'];
	END;

	// Search via AutoKey
	input_c := PROJECT(data_in, cleanInput(LEFT));
	fids := UNGROUP(Autokey_batch.get_fids(input_c, Consts.ak_QAname, cfgs));
	AutokeyB2.mac_get_payload(fids, Consts.ak_QAname, PLRec, with_pl, did, bdid, Consts.ak_typeStr);
	with_pl_x := PROJECT(with_pl(tmsid <> BLNK), AcctRec);
	fromAK := DEDUP(SORT(with_pl_x, acctno, tmsid, rmsid), acctno, tmsid, rmsid);

	// Search via DID lookup
	notFoundAccts := JOIN(input_c, fromAK, LEFT.acctno = RIGHT.acctno, TRANSFORM(LEFT), LEFT ONLY);
	dDidsAcctno 	:= BatchServices.Functions.fn_find_dids_and_append_to_acctno(notFoundAccts); 
	dWithDIDs			:= JOIN(notFoundAccts, dDidsAcctno,
		LEFT.acctno = RIGHT.acctno,
		TRANSFORM(AcctRec,
			SELF.did				:= RIGHT.did,
			SELF.isDeepDive	:= TRUE,
			SELF						:= LEFT,
			SELF.tmsid			:= '',
			SELF.rmsid			:= ''),
		LEFT OUTER);
	fromDIDLkup := JOIN(dWithDIDs, keyIdDID, KEYED(LEFT.did = RIGHT.did), fromKeyIdDID(LEFT, RIGHT));

	// Merge/Sort/Dedup
	m_s_d := DEDUP(SORT(fromAK + fromDIDLkup, acctno, tmsid, rmsid, isDeepDive), acctno, tmsid, rmsid);

	// Make a choice
	ids_acctno := IF(cfgs.RunDeepDive AND EXISTS(notFoundAccts), m_s_d, fromAK);

	// Penalty calculation
	acctNos_i := JOIN(ids_acctno, input_c,
										LEFT.acctno = RIGHT.acctno,
										TRANSFORM(AcctRecWithInput, SELF := RIGHT, SELF := LEFT));
	acctNos_pnlt := PROJECT(acctNos_i, toFBNReport(LEFT, is_search))(penalt <= cfgs.PenaltThreshold);
	rp_recs := DEDUP(SORT(acctNos_pnlt, tmsid, rmsid), tmsid, rmsid);

	// Get matches
	matches := FBNV2_services.FBN_raw.batch_view.batch_layout(rp_recs);
	// Add acctno
	matches_a := JOIN(acctNos_i, matches,
										LEFT.tmsid = RIGHT.tmsid AND
										(LEFT.rmsid = BLNK OR LEFT.rmsid = RIGHT.rmsid),
										TRANSFORM(OutRec, SELF := LEFT, SELF := RIGHT));
	// Add penalt
	matches_p := JOIN(rp_recs, matches_a,
										LEFT.tmsid = RIGHT.tmsid AND
										(LEFT.rmsid = BLNK OR LEFT.rmsid = RIGHT.rmsid),
										TRANSFORM(OutRec, SELF.penalt := LEFT.penalt, SELF := RIGHT));

	rslt := DEDUP(SORT(matches_p , acctno, penalt, -filing_date, tmsid, rmsid),
								acctno, penalt, filing_date, tmsid, rmsid);

	RETURN OUTPUT(rslt, NAMED('Results'), ALL);

END;