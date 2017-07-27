
// median sales price is only calculated after 2005Q2.  base table or ofheo are used prior to that
pi_file1 := avm.File_AVM_PI_Records(recording_date[1..6] > '200506');  
pi_file := distribute(pi_file1, hash(quarter,fips_code,land_use));

layout_msp_calcs := record
	string5 fips_code;
	string1 land_use;
	string6 quarter;
	
	string11 sales_price;
	integer Q3_2005_base_msp;
	integer most_recent_quarter_msp;
	string6 most_recent_quarter;
	real Q3_2005_to_most_recent_quarter_ratio;
	real sale_quarter_to_most_recent_ratio;
	integer county_seq;
end;

// group all the properties by quarter, fips, land use and put that grouped result into layout_msp_calcs to iterate through
props := group(sort(project(pi_file, transform(layout_msp_calcs, self := left, self := [])), quarter,fips_code,land_use,sales_price, local), quarter, fips_code, land_use, local);

totals := table(props, {quarter,fips_code,land_use, total := count(group)});

layout_msp_calcs tf2(props le, props rt, integer C) := transform
	self.county_seq := c;
	self := rt;
end;

with_seq := iterate(props,tf2(left,right,counter));

// only create median sales price if there are more than 75 sales reported that quarter in that county
// and instead of taking the middle record as the median, Global Analytics suggested using the 49th percentile record
w_Median_Sales := join(with_seq, totals, left.quarter=right.quarter and left.fips_code=right.fips_code and left.land_use=right.land_use 
			and left.county_seq=round(right.total*0.49) and right.total > 75,     
	transform(layout_msp_calcs, self.land_use:=left.land_use, 
								self.quarter:=left.quarter,
								self.fips_code:=left.fips_code, 
								self.sales_price:=left.sales_price, 
								self.county_seq := left.county_seq,
								self := []), lookup);


Q3_2005_Baseline_recs := w_Median_Sales(quarter='2005Q3');

w_Q3_2005_sales := join(w_Median_Sales, Q3_2005_Baseline_recs, left.fips_code=right.fips_code and left.land_use=right.land_use,
				transform(layout_msp_calcs, 
								self.Q3_2005_base_msp:=(integer)right.sales_price, 
								self := left), left outer, lookup);

d_Q3_2005_sales := distribute(w_Q3_2005_sales, hash(fips_code,land_use));
								
sorted_quarters := sort(d_Q3_2005_sales, fips_code,land_use,-quarter, local);
most_recent_qtr_per_county := dedup(sorted_quarters, fips_code,land_use, local);


// if either sale price is missing, we can't calculate a ratio, set default to 9999
ratio(string a, string b) := if(trim(a)='' or trim(b)='', 9999, ((integer)a / (integer)b));

final := join(w_Q3_2005_sales, most_recent_qtr_per_county, left.fips_code=right.fips_code and left.land_use=right.land_use,
				transform(layout_msp_calcs, 
								self.most_recent_quarter:= right.quarter,
								self.most_recent_quarter_msp := (integer)right.sales_price,
								self.Q3_2005_to_most_recent_quarter_ratio := ratio(right.sales_price, (string)left.Q3_2005_base_msp) ;
								self.sale_quarter_to_most_recent_ratio := ratio(right.sales_price, left.sales_price);
								self := left), left outer, lookup);

output(final,,'~thor_data400::avm::median_sales_price_' + thorlib.WUID(), __compressed__);

export File_PI_Median_Sales := final;