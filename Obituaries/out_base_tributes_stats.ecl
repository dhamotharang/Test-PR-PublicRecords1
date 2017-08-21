Import Obituaries, header, STRATA;

EXPORT out_base_tributes_stats(string filedate) := function;

	ds_tributes						:=	Obituaries.file_obituary_dmasterv3_base(src = 'TR');
	ds_tributes_clrblanks	:=	PROJECT(ds_tributes,
															TRANSFORM(RECORDOF(LEFT),
																SELF.did						:=	IF((UNSIGNED)LEFT.did>0,LEFT.did,'');
																SELF.dod8						:=	IF((UNSIGNED)LEFT.dod8>0,LEFT.dod8,'');
																SELF.dob8						:=	IF((UNSIGNED)LEFT.dob8>0,LEFT.dob8,'');
																SELF.state_death_id	:=	IF((UNSIGNED)LEFT.state_death_id>0,LEFT.state_death_id,'');
																SELF:=LEFT;
															)
														);
	tStats_tributes				:=	strata.macf_pops(
															ds_tributes_clrblanks,	// input dataset
															'state',								// Field that the table should be grouped on
															,												// If group by field not set, use this name for default group by field
															,												// default field type for default group by field
															,												// default value for default group by field
															,												// Should output the ecl as a string(for testing) or actually run the ecl
															TRUE,										// Should the fields in the following parameter(pSetFields) be removed from the stats, or should they be the only ones kept?
															['crlf','state_death_flag','death_rec_src','src','GLB_flag'],	// remove/keep these fields from population stats(based on whether pShouldRemoveFieldsInSet is true or not)
															,												// don't append countrue, countnonblank, etc to field names in table
															,												// Remove prefix of field(s).
															,												// Should the field masks in the following parameter(pMatchExpression) be NOT'd?
															,												// remove/keep these field masks from population stats(based on whether pShouldRemoveExpression is true or not)
																											// keep group by field in layout
														);
	zOrig_Stats_tributes	:=	output(choosen(tStats_tributes,all));
	
	strata.createXMLStats(tStats_tributes,'Header','Tributes_Death_v3', filedate,'Kevin.Garrity@lexisnexis.com',zPopulation_Stats_tributes,'View','Population');
	
	RETURN parallel(	zOrig_Stats_tributes 
										,zPopulation_Stats_tributes
									);
END;
