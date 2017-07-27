IMPORT Business_Credit_KEL;

EXPORT GLUE_Append(DATASET(RECORDOF(Business_Credit_KEL.File_SBFE_temp.linkids)) linkid_recs) := MODULE

	SHARED STRING1 BUSINESSINFO := 'B';
	SHARED STRING1 TRADELINES   := 'T';
	
	EXPORT layout_temp := RECORD
		UNSIGNED4 Seq := 0;
		UNSIGNED3 HistoryDate := 0;
		Business_Credit_KEL.GLUE_fdc.layout_combined;
	END;
	
	EXPORT fdc_layout := RECORD
		RECORDOF(Business_Credit_KEL.File_SBFE_temp);
	END;
	
	// 1. Read FDC records from the index
	EXPORT Bundles := 
		JOIN(
			linkid_recs, Business_Credit_KEL.GLUE_fdc.RoxieIndex, 
			KEYED( LEFT.sbfe_contributor_num = RIGHT.sbfe_contributor_num ) AND
			KEYED( LEFT.contractacc_num = RIGHT.contractacc_num ),
			TRANSFORM( layout_temp,
				SELF.seq         := LEFT.seq,
				SELF.historydate := LEFT.historydate,
				SELF             := RIGHT
			),
			LEFT OUTER
		);
	
	EXPORT tbl_businessinfo := 
		PROJECT( 
			Bundles(segment_type = BUSINESSINFO), 
			TRANSFORM( RECORDOF(fdc_layout.BusinessInformation), SELF := LEFT, SELF := [] )
		);
		
	EXPORT tbl_tradelines := 
		PROJECT( 
			Bundles(segment_type = TRADELINES), 
			TRANSFORM( RECORDOF(fdc_layout.tradelines), SELF := LEFT, SELF := [] )
		);
	
	// 2. Attach linkid_recs.
	EXPORT JustSeq := 
		PROJECT( 
			DEDUP(TABLE(linkid_recs, {Seq, historydate}), ALL, HASH), 
			TRANSFORM( fdc_layout, 
				SELF.seq := left.seq, 
				SELF.historydate := (INTEGER)((STRING)LEFT.historydate+'01'), 
				SELF := []
			)
		); // historydate isn't currently being populated (why?)
		
	EXPORT AddLinkids := 
		DENORMALIZE(
			JustSeq, linkid_recs, 
			LEFT.seq = RIGHT.seq, 
			GROUP, 
			TRANSFORM( fdc_layout, 
				SELF.seq := LEFT.seq, 
				SELF.linkids := ROWS(RIGHT), 
				SELF := []
			)
		);
	
	// 3. Attach Tradelines.
	EXPORT tradeline_recs := 
		DEDUP(
			JOIN(
				AddLinkIds, tbl_tradelines,
				RIGHT.contractacc_num IN SET(LEFT.linkids, contractacc_num) AND 
				RIGHT.sbfe_contributor_num IN SET(LEFT.linkids, sbfe_contributor_num) AND 
				RIGHT.cycleend_date < (STRING)(LEFT.linkids[1].historydate + '01'), 
				TRANSFORM( RECORDOF(fdc_layout.tradelines), 
					SELF.seq := LEFT.seq, 
					SELF.seq_num := HASH(COUNTER, RIGHT.sbfe_contributor_num, RIGHT.contractacc_num), 
					SELF.temp_load_date := RIGHT.cycleend_date; 
					SELF := RIGHT
				),
				INNER,
				ALL
			), 
			RECORD, EXCEPT seq_num, ALL, HASH
		); // TODO: which conditions do we dedup tradelines by? 

	EXPORT AddTradelines := 
		DENORMALIZE(
			AddLinkIds, tradeline_recs, 
			LEFT.seq = RIGHT.seq, 
			GROUP, 
			TRANSFORM( fdc_layout, 
				SELF.tradelines := ROWS(RIGHT), 
				SELF := LEFT, 
				SELF := []
			)
		);

	// 4. Attach Business Information.
	EXPORT BusinessInformation_recs := 
		JOIN( 
			AddTradelines, tbl_businessinfo,
			RIGHT.contractacc_num IN SET(LEFT.linkids, contractacc_num) AND 
			RIGHT.sbfe_contributor_num IN SET(LEFT.linkids, sbfe_contributor_num),
			TRANSFORM( RECORDOF(fdc_layout.BusinessInformation), 
				SELF.seq := LEFT.seq, 
				SELF.seq_num := HASH(COUNTER, RIGHT.sbfe_contributor_num, RIGHT.contractacc_num), 
				SELF.temp_load_date := '999999'; //what should this be?
				SELF := RIGHT
			),
			INNER,
			ALL
		);
																											
	EXPORT AddBusinessInformation := 
		DENORMALIZE(
			AddTradelines, BusinessInformation_recs, 
			LEFT.seq = RIGHT.seq, 
			GROUP, 
			TRANSFORM( fdc_layout, 
				SELF.BusinessInformation := ROWS(RIGHT), 
				SELF := LEFT, 
				SELF := []
			)
		);

  // 5. Setup query config module. Add day to history date.
	SHARED Cfg_Append := MODULE(Business_Credit_KEL.Cfg_graph)
		  EXPORT CurrentDate := (INTEGER)((STRING)linkid_recs[1].HistoryDate + '01'); 
	END;
	
	// 6. Append attributes.
	EXPORT SBFE_Raw := AddBusinessInformation;
	EXPORT SBFE_Result := Business_Credit_KEL.Q_S_B_F_E___Shell(AddBusinessInformation, CFG_append).Res0; 

END;
