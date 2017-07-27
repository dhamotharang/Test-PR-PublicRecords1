
import census_data, ut;

ofheo_raw_layout := record
	string2 state;
	string4 year;
	string1 quarter;
	real hpi;
end;

ofheo_layout := record
	string2 state;
	string2 state_fips;
	string6 quarter;
	real hpi;
	real base_to_current_Ratio := 0;
	real Current_Ratio := 0;
end;

//make sure we get the most current copy loaded into production, possibly name it just in::avm_ofheo and overwrite it each quarter so this code doesn't have to change at all
f_raw := dataset('~thor_data400::in::avm_ofheo', ofheo_raw_layout, csv);									

w_fips1 := join(f_raw, census_data.File_Fips2County, 
							left.state=right.state_code,
							transform(ofheo_layout, 
									self.quarter := left.year + 'Q' + left.quarter, 
									self.state_fips := right.state_fips,
									self := left,
									self := []), lookup);
									
w_fips := w_fips1(quarter<=avm.filters.quarter_map(avm.filters.history_date));

Q3_2005_records := w_fips(quarter='2005Q3');
s := sort(w_fips, -quarter);
current_quarter := s[1].quarter;


Q_current_records := w_fips(quarter=current_quarter);


w_2005Q3_ratio := join(Q_current_records, Q3_2005_records, left.state=right.state,
						transform(ofheo_layout, 
								self.base_to_current_Ratio := left.hpi/right.hpi,
								self := left), lookup);


w_current_ratio := join(w_fips, w_2005Q3_ratio, left.state=right.state,
						transform(ofheo_layout, 
								self.Current_Ratio := right.hpi/left.hpi,
								self.base_to_current_ratio := right.base_to_current_ratio,
								self := left), lookup);

								


export File_OFHEO := w_current_ratio;
