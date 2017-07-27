export MOD_get_AVM_from_History := MODULE

import ut;

export MAC_get_AVM(avm_key_result, in_historydateYYYYMMDD, avm_result) := macro
	#uniquename(avm_key_layout)
	%avm_key_layout% := record
		recordof(avm_key_result)
	end;

	layout_valuations_plus := RECORD
		avm_V2.layouts.layout_automated_valuations;
		unsigned automated_valuation2;
		unsigned automated_valuation3;
		unsigned automated_valuation4;
		unsigned automated_valuation5;
		unsigned automated_valuation6;
	end;

	#uniquename(select_history)
	layout_valuations_plus %select_history%(%avm_key_layout% le):= transform

		// modelers wanted to tweak this logic slightly so that any customer applications prior to the earliest build
		// use the AVM values from that earliest AVM build instead of returning no valuation like a normal history date filter would do
		historydateYYYYMMDD := if((unsigned)in_historydateYYYYMMDD < (unsigned)AVM_V2.filters('').earliest_history_build, AVM_V2.filters('').earliest_history_build, in_historydateYYYYMMDD);

		// if realtime transaction (history_date = 999999) or recent enough that it's after the latest archive build, use the current build if valuation <> 0
		use_current := le.automated_valuation<>0 and 
			(
					 historydateYYYYMMDD[1..6]=(string6)risk_indicators.iid_constants.default_history_date or
					// ((unsigned)le.history_date <= (unsigned)historydateYYYYMMDD and ut.DaysApart(le.history_date, historydateYYYYMMDD) <= 366)
					((unsigned)le.history_date <= (unsigned)historydateYYYYMMDD)
			);
		
		// less than the history date
		hist_rec := le.history((unsigned)history_date <= (unsigned)historydateYYYYMMDD);
		
		c := count(hist_rec);
		
		self.history_date := if(use_current, le.history_date, hist_rec[c].history_date);
		self.land_use := if(use_current, if(le.automated_valuation<>0, le.land_use, ''), hist_rec[c].land_use);
		self.recording_date := if(use_current, le.recording_date, hist_rec[c].recording_date);
		self.assessed_value_year := if(use_current, le.assessed_value_year, hist_rec[c].assessed_value_year);
		self.sales_price   := if(use_current, le.sales_price, hist_rec[c].sales_price  );
		self.assessed_total_value := if(use_current, le.assessed_total_value, hist_rec[c].assessed_total_value);
		self.market_total_value := if(use_current, le.market_total_value, hist_rec[c].market_total_value);
		self.tax_assessment_valuation := if(use_current, le.tax_assessment_valuation, hist_rec[c].tax_assessment_valuation);
		self.price_index_valuation := if(use_current, le.price_index_valuation, hist_rec[c].price_index_valuation);
		self.hedonic_valuation := if(use_current, le.hedonic_valuation, hist_rec[c].hedonic_valuation);
		self.automated_valuation := if(use_current, le.automated_valuation, hist_rec[c].automated_valuation);
		self.confidence_score := if(use_current, le.confidence_score, hist_rec[c].confidence_score);
		
		// we're not building comps and nearby keys in history mode, so we can blank those out
		self.comp1 := if(use_current, le.comp1, '');
		self.comp2 := if(use_current, le.comp2, '');
		self.comp3 := if(use_current, le.comp3, '');
		self.comp4 := if(use_current, le.comp4, '');
		self.comp5 := if(use_current, le.comp5, '');
		self.nearby1 := if(use_current, le.nearby1, '');
		self.nearby2 := if(use_current, le.nearby2, '');
		self.nearby3 := if(use_current, le.nearby3, '');
		self.nearby4 := if(use_current, le.nearby4, '');
		self.nearby5 := if(use_current, le.nearby5, '');
		
		// now that we've switched to quarterly snapshots of avm, still only want the automated_valuation 2-6 to be yearly.  
		// use the snapshot from september each year
		yearly_history := hist_rec(history_date[5..8]='0930');
		yearcount := count(yearly_history);
		
		self.automated_valuation2 := if(use_current, yearly_history[yearcount].automated_valuation, yearly_history[yearcount-1].automated_valuation);	// for historical, the newest one will output above
		self.automated_valuation3 := if(use_current, yearly_history[yearcount-1].automated_valuation, yearly_history[yearcount-2].automated_valuation);
		self.automated_valuation4 := if(use_current, yearly_history[yearcount-2].automated_valuation, yearly_history[yearcount-3].automated_valuation);
		self.automated_valuation5 := if(use_current, yearly_history[yearcount-3].automated_valuation, yearly_history[yearcount-4].automated_valuation);
		self.automated_valuation6 := if(use_current, yearly_history[yearcount-4].automated_valuation, yearly_history[yearcount-5].automated_valuation);
		
		self := le;
	end;

	avm_result := project(avm_key_result, %select_history%(left));
	

endmacro;

export MAC_get_Medians(median_key_result, in_historydateYYYYMMDD, median_result) := macro
	#uniquename(median_key_layout)
	%median_key_layout% := record
		recordof(median_key_result)
	end;
	
	#uniquename(select_median_history)
	AVM_V2.layouts.layout_median_valuations %select_median_history%(%median_key_layout% le):= transform		
		// modelers wanted to tweak this logic slightly so that any customer applications prior to the earliest build
		// use the AVM values from that earliest AVM build instead of returning no valuation like a normal history date filter would do
		historydateYYYYMMDD := if(in_historydateYYYYMMDD < AVM_V2.filters('').earliest_history_build, AVM_V2.filters('').earliest_history_build, in_historydateYYYYMMDD);

		// if realtime transaction (history_date = 999999) or recent enough that it's after the latest archive build, use the current build if valuation <> 0	
		use_current := le.median_valuation<>0 and 
			(
					 historydateYYYYMMDD[1..6]=(string6)risk_indicators.iid_constants.default_history_date or
					((unsigned)le.history_date <= (unsigned)historydateYYYYMMDD)
			);	
		
		// if in history mode, select the most recent archive that is less than the history date
		hist_rec := le.history(history_date <= historydateYYYYMMDD);
		c := count(hist_rec);
		self.history_date := if(use_current, le.history_date, hist_rec[c].history_date);
		self.median_valuation := if(use_current, le.median_valuation, hist_rec[c].median_valuation);
					
		self := le;
	end;

	median_result := project(median_key_result, %select_median_history%(left));

endmacro;



end;