import drivers, FCRA, header, mdr, Risk_Indicators;

export rollCorrRiskSummary(dataset(Risk_Indicators.Layouts.common_layout) summary = dataset([], Risk_Indicators.Layouts.common_layout),
													 unsigned  historydate,
													 unsigned1 dppa, 
													 boolean 	 ln_branded,
													 boolean 	 isFCRA=false, 
													 unsigned1 BSversion=1,
													 string50  DataRestriction=iid_constants.default_DataRestriction,
													 string10  CustomDataFilter='',
													 unsigned8 BSOptions,
													 unsigned1 glb) := function

		dppa_ok 		:= Risk_Indicators.iid_constants.dppa_ok(dppa, isFCRA);
		glb_ok 			:= Risk_Indicators.iid_constants.glb_ok(glb, isFCRA);
		FilterLiens := (BSOptions & risk_indicators.iid_constants.BSOptions.FilterLiens) > 0;

		//use same filters as iid_getHeader to drop sources not allowed
		filteredSummary := project(summary(
			(src in Risk_Indicators.iid_constants.setPhillipMorrisAllowedHeaderSources or customDataFilter<>Risk_Indicators.iid_constants.PhillipMorrisFilter) and 
			(src in Risk_Indicators.iid_constants.setExperianBatchAllowedHeaderSources or customDataFilter<>Risk_Indicators.iid_constants.ExperianFCRA_Batch) and
			(src not in Risk_Indicators.iid_constants.masked_header_sources(DataRestriction, isFCRA)) and
			(dt_first_seen < historydate and dt_first_seen <> 0) and
			((bsversion>=50 or ~mdr.Source_is_Utility(src)) and 
			 (~mdr.Source_is_DPPA(src) or (dppa_ok and drivers.state_dppa_ok(header.translateSource(src),dppa,src)) or isFCRA) and
			 (ln_branded OR bsversion>=50 or ~(dppa_ok AND (src in mdr.sourcetools.set_Experian_dl or src in mdr.sourcetools.set_Experian_vehicles)))) and
			 (header.IsPreGLB_LIB(dt_last_seen, 
														dt_first_seen, 
														src, 
														DataRestriction) OR glb_ok) AND
			(not isFCRA
			 OR (src='BA' and FCRA.bankrupt_is_ok(risk_indicators.iid_constants.myGetDate(historydate),(string)dt_first_seen))
			 OR (src='L2' and FCRA.lien_is_ok(risk_indicators.iid_constants.myGetDate(historydate),(string)dt_first_seen) and filterLiens=false)
			 OR src not in ['BA','L2'])),  
			transform(Risk_Indicators.Layouts.common_layout,
				utilityRecord := bsversion>=50 and mdr.Source_is_Utility(left.src);
				//convert raw source to converted source
				converted_src := map(
					 utilityRecord 																										=> 'U',  	// Set utilityRecord for BS >= 50
					 left.src in mdr.sourcetools.set_Experian_dl 											=> 'D',
					 left.src in mdr.sourcetools.set_Experian_vehicles 								=> 'V',
					 left.src[2] in ['D','V','W'] AND ~(left.src IN ['MW','UW'])			=> left.src[2],
					 left.src IN ['TU','LT']																					=> 'TU',
					 left.src in ['FC','FS','UC','US','GC','GS','PC','PS','MS','AS'] 	=> 'C',  	// Criminal
					 left.src IN ['MI','MA'] 																					=> 'XX', 	// won't count these
					 left.src IN ['FA', 'FP', 'FB', 'LP', 'LA'] 											=> 'P',		// property source
					 left.src IN ['EM','E1','E2','E3','E4'] 													=> 'EM', 
					 left.src IN ['QH','WH'] 																					=> 'EQ',	// set quickheader to EQ
					 left.src = 'AY' 																									=> 'SL',	// treat alloy as american student
					 left.src IN MDR.sourceTools.set_Death 														=> 'DE',	// set all new death sources to DE
					 left.src);
				self.src := if(BSversion >= 52, converted_src, left.src);	 //only use converted source for BS version 52 and higher	
				self.dt_last_seen := min(left.dt_last_seen, historydate);  //do not return last seen dates beyond the history date
				self 							:= left));

		//sort by source so we can rollup next
		sortedSummary := sort(filteredSummary, src);

		//rollup by source since multiple raw source records could convert to the same converted source
		rolledSummary := rollup(sortedSummary, left.src=right.src, transform(Risk_Indicators.Layouts.common_layout,
			self.src						:= left.src;
			self.dt_first_seen 	:= min(left.dt_first_seen, right.dt_first_seen);
			self.dt_last_seen		:= max(left.dt_last_seen, right.dt_last_seen);
			self.record_count		:= left.record_count + right.record_count;
			self := left));
			
		return rolledSummary;
		
end;