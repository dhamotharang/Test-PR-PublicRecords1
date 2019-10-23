import avm_v2;


loadfile:=avm_v2.File_AVM_Medians_Base;

Scrubs_AVM.Medians_layout_AVM NewChildren(avm_v2.layouts.layout_medians_with_history L, avm_v2.layouts.layout_median_history_slim R):= transform
		SELF.history_history_date:=R.history_date;
		SELF.history_median_valuation:=R.median_valuation;
		SELF.history_date:=L.history_date;
		SELF.fips_geo_12:=L.fips_geo_12;
		SELF.median_valuation:=L.median_valuation;
		end;
		
NewSet:=NORMALIZE(loadfile,Left.history,NewChildren(Left,RIGHT));
EXPORT Medians_in_AVM := NewSet;