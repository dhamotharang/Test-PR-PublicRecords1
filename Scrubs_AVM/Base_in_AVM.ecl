import avm_v2;
loadfile:=avm_v2.File_AVM_Base;

Scrubs_AVM.Base_layout_AVM NewChildren(avm_v2.layouts.layout_base_with_history L, avm_v2.layouts.layout_history_slim R) := transform

	self.history_history_date:=R.history_date;
	self.history_land_use:=R.land_use;
	self.history_recording_date:=R.recording_date;
	self.history_assessed_value_year:=R.assessed_value_year;
	self.history_sales_price:=R.sales_price;
	self.history_assessed_total_value:=R.assessed_total_value;
	self.history_market_total_value:=R.market_total_value;
	self.history_tax_assessment_valuation:=R.tax_assessment_valuation;
	self.history_price_index_valuation:=R.price_index_valuation;
	self.history_hedonic_valuation:=R.hedonic_valuation;
	self.history_automated_valuation:=R.automated_valuation;
	self.history_confidence_score:=R.confidence_score;
	Self:=L;
	end;
	
	NewSet:=NORMALIZE(loadfile,Left.history,NewChildren(Left,RIGHT));


EXPORT Base_in_AVM := NewSet;