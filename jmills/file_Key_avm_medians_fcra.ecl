import avm_v2;

/*EXPORT integer8 avm_v2__layouts__max_history := 10;

layout_median_history_slim := RECORD
   string8 history_date;
   integer8 median_valuation;
  END;

RECORD
  string12 fips_geo_12;
  string8 history_date;
  integer8 median_valuation;
  DATASET(layout_median_history_slim) history{maxcount(avm_v2__layouts__max_history)};
  unsigned8 __internal_fpos__;
 END;*/
 
 layout_key_out := RECORD
  string12 fips_geo_12;
  string8 history_date;
  integer8 median_valuation;
	//DATASET(layout_median_history_slim) history{maxcount(avm_v2__layouts__max_history)};
	string8 history_history_date;
  string50 history_median_valuation;
  //unsigned8 __internal_fpos__;
	END;

 key_in := avm_v2.key_avm_medians_fcra;

 //transform statement
layout_key_out makerecord (key_in L) := transform
self.fips_geo_12 := L.fips_geo_12;
self.history_date := L.history_date;
self.median_valuation := L.median_valuation;
//DATASET(layout_median_history_slim) history{maxcount(avm_v2__layouts__max_history)};
self.history_history_date := 'HISTORY DATE';
self.history_median_valuation := 'MEDIAN VALUATION';
//unsigned8 __internal_fpos__;
END;




EXPORT file_Key_avm_medians_fcra := project(key_in,makerecord(left));