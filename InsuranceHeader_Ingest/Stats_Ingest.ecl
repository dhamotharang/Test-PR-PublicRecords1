IMPORT InsuranceHeader,LinkingTools, STD,idl_header;

EXPORT Stats_Ingest(DATASET(Layout_Header_Plus) Ingestouput ,
										DATASET(Layout_Base) IngestInput,
										DATASET(idl_header.Layout_Header_Link) Base,
										DATASET(Layout_Stats.Inrec) IngestInputStats, 
										DATASET(Layout_Stats.XTAB) IngestUpdateStatsSrc,
										STRING versionIn) := FUNCTION

	IngestInput0 := IngestInput(not(fname = '' and lname = ''and prim_name = '' and city = ''));	
	dsBase       := PROJECT(Base,TRANSFORM(recordof(LEFT),SELF.src := IF(LEFT.src[..3] IN ['ICA','ICP','IVS'], LEFT.src[..3],LEFT.src);SELF:=LEFT));
	Ingestouput0 := PROJECT(Ingestouput(RecChangeType = Constants.RecordChangeType.Old),TRANSFORM(recordof(LEFT),SELF.src := IF(LEFT.src[..3] IN ['ICA','ICP','IVS'], LEFT.src[..3],LEFT.src);SELF:=LEFT)); 
	
	base1   := JOIN(IngestInput0, Ingestouput0 , LEFT.source_rid = RIGHT.source_rid and LEFT.src = RIGHT.src , TRANSFORM (LEFT),HASH); 
	father  := JOIN(dsBase, Ingestouput0 , LEFT.source_rid = RIGHT.source_rid and LEFT.src = RIGHT.src  , TRANSFORM (LEFT),HASH); 
	
	J      := JOIN (base1 , father , LEFT.source_rid = RIGHT.source_rid and 
                                   LEFT.src = RIGHT.src, 
																	 TRANSFORM ({RECORDOF(base1), 
																		BOOLEAN diff_fname , BOOLEAN diff_ssn ,
																		BOOLEAN diff_dob , BOOLEAN diff_dlnbr , BOOLEAN diff_dl_state }, 														 
																		SELF.diff_fname     := LEFT.fname <> RIGHT.fname , 
																		SELF.diff_ssn       := LEFT.ssn <> RIGHT.ssn , 
																		SELF.diff_dob       := LEFT.dob <> RIGHT.dob , 
																		SELF.diff_dlnbr     := LEFT.dl_nbr <>RIGHT.dl_nbr, 
																		SELF.diff_dl_state  := LEFT.dl_state <>RIGHT.dl_state , 
																		SELF:= LEFT)
											);
														 
	tab_modifield := TABLE(j,{j.src,j.diff_fname, j.diff_ssn, j.diff_dob, j.diff_dlnbr,
														j.diff_dl_state,  cnt:= COUNT(GROUP) },
											      src,diff_fname, diff_ssn, diff_dob, diff_dlnbr, diff_dl_state,  FEW);
											 
	OUTPUT(tab_modifield,NAMED('NewModified_by_field'),ALL);

	tab_overall := TABLE(j,{j.src,cnt:= COUNT(GROUP) },src,FEW);

	OUTPUT(tab_overall,NAMED('NewModified_by_src'),ALL);

  Join_modified := JOIN(IngestUpdateStatsSrc , tab_overall , LEFT.SRC = RIGHT.SRC , 
                           TRANSFORM(InsuranceHeader_Ingest.Layout_Stats.Out, 
													 SELF := LEFT ,
													 SELF.cnt_input := 0 , 
													 SELF.wuid := WORKUNIT;
	                         SELF.version := versionIn;
													 SELF.cnt_Modified := RIGHT.CNT , 
													 SELF.cnt_Tot := LEFT.cnt_Old + LEFT.cnt_Unchanged + LEFT.cnt_Updated + LEFT.cnt_New ;
													 ),LEFT OUTER); 
	
	new_stats := JOIN(Join_modified , IngestInputStats , LEFT.SRC = RIGHT.SRC , 
                           TRANSFORM(InsuranceHeader_Ingest.Layout_Stats.Out, 													 
													 SELF.cnt_input := RIGHT.CNT ,
													 SELF := LEFT ,
													 ),LEFT OUTER); 
	
	old_stats := Files.StatsIngest_Current_DS;

	combined_stats := old_stats & new_stats;

RETURN combined_stats;

END;