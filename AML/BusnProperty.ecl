IMPORT LN_PropertyV2, RiskWise, Business_Risk, Risk_Indicators;


EXPORT BusnProperty(DATASET(Layouts.BusnLayoutV2) BusnIds) := FUNCTION

//version 2
//PROPERTY

kfs_nonFCRA	:= LN_PropertyV2.key_search_fid();
kafid_nonFCRA	:= LN_PropertyV2.key_assessor_fid();

gScore(UNSIGNED1 i) := i BETWEEN Risk_Indicators.iid_constants.min_score AND 100;

proprec := Record
  unsigned6 bdid;
	unsigned4 seq;
	unsigned4 historydate;
	string120 company_name ;
	string12 ln_fares_id;
	string10 errorStatus;
	string10 errorStatusSearchFID;
	BOOLEAN applicant_owned;
	BOOLEAN applicant_sold;
	string2 source_code_1;
	string2 source_code_2;
	string120 cname;
	unsigned3 cmpymatch_score;
	unsigned3 CountSoldProp;
	unsigned3 CountOwnProp;
	string PurchaseDate;
	unsigned6 TaxAssdValue;
	 string10  prim_range;
	 string2   predir;
	 string28  prim_name;
	 string4   suffix;
	 string2   postdir;
	 string10  unit_desig;
	 string8   sec_range;
	 string25  p_city_name;
	 string25  v_city_name;
	 string2   st;
	 string5   zip;
   string4		assessed_value_year;
	
END;


								

proprec  getLNFares(BusnIds  le, LN_PropertyV2.key_search_bdid ri)   := TRANSFORM

	self.bdid := le.OrigBdid;
	self.seq := le.seq;
	self.historydate := le.historydate;
	self.company_name := le.company_name;
	self.ln_fares_id := ri.ln_fares_id;
	self.errorStatus := ri.err_stat;
	self.prim_range  := ri.prim_range;
	self.predir  := ri.predir;
	self.prim_name := ri.prim_name;
	self.suffix  := ri.suffix;
	self.postdir  := ri.postdir;
	self.unit_desig := ri.unit_desig;
	self.sec_range  := ri.sec_range;
	self.p_city_name := ri.p_city_name;
	self.v_city_name := ri.v_city_name;
	self.st  := ri.st;
	self.zip := ri.zip;
	self := ri;
	self := [];								
END;

BusnProp := join(BusnIds , LN_PropertyV2.key_search_bdid ,
								Keyed(left.OrigBdid=right.s_bid)
								and trim(right.ln_fares_id) <> '' and
								right.dt_first_seen <= left.historydate,
								getLNFares(left,right),
								left outer, atmost(5000), keep(1000));
								
proprec  getSearch_nonFCRA(BusnProp le, kfs_nonFCRA ri)   := TRANSFORM  
  cmpymatch_score 	:= Business_Risk.CnameScore(le.company_name, ri.cname);
	cmpymatch 		:= gScore(cmpymatch_score);
	self.bdid := le.bdid;
	self.seq := le.seq;
	self.cmpymatch_score := cmpymatch_score;
	self.company_name := le.company_name;
	self.ln_fares_id := le.ln_fares_id;
	self.source_code_1 := ri.source_code_1;
	self.source_code_2 := ri.source_code_2;
	self.cname := ri.cname;
	SELF.applicant_owned :=  cmpymatch and ri.source_code_2='P' and ri.source_code_1 = 'O';
	self.historydate := le.historydate;
	SELF.applicant_sold :=  ri.source_code_1='S' AND cmpymatch and ri.source_code_2= 'P' ;	
	self.errorStatus :=  le.errorStatus;
	self.errorStatusSearchFID :=  ri.err_stat;
	self.prim_range  := ri.prim_range;
	self.predir  := ri.predir;
	self.prim_name := ri.prim_name;
	self.suffix  := ri.suffix;
	self.postdir  := ri.postdir;
	self.unit_desig := ri.unit_desig;
	self.sec_range  := ri.sec_range;
	self.p_city_name := ri.p_city_name;
	self.v_city_name := ri.v_city_name;
	self.st  := ri.st;
	self.zip := ri.zip;
	self := le;
	self := ri;
	self := [];								
END;
							

property_searched :=  JOIN(BusnProp, kfs_nonFCRA, //search_fid
								keyed(LEFT.ln_fares_id=RIGHT.ln_fares_id) AND
								wild(right.which_orig) 	and
								keyed(RIGHT.source_code_2 ='P'),
							  getSearch_nonFCRA(LEFT,RIGHT),  
								ATMOST(keyed(LEFT.ln_fares_id=RIGHT.ln_fares_id) AND
								  wild(right.which_orig) and
									keyed(RIGHT.source_code_2 ='P')	, 5000 ), keep(1000));


OwnProp := property_searched(applicant_owned and errorStatusSearchFID[1] <> 'E');
SoldProp := property_searched(applicant_sold and errorStatusSearchFID[1] <> 'E');

ownPropDD := dedup(sort(OwnProp, seq, bdid, prim_range, prim_name, predir,suffix,postdir, zip),
                         seq, bdid, prim_range, prim_name, predir,suffix,postdir, zip);
												 
SoldPropDD := dedup(sort(SoldProp, seq, bdid, prim_range, prim_name, predir,suffix,postdir, zip),
                         seq, bdid, prim_range, prim_name, predir,suffix,postdir, zip);
												 
owned_prop := join(ownPropDD, SoldPropDD, 
										left.prim_range = right.prim_range and
										left.prim_name = right.prim_name and
										left.suffix = right.suffix and
										left.postdir = right.postdir and
										left.st = right.st and
										left.p_city_name = right.p_city_name and
										left.zip = right.zip,
										transform(recordof(left), self := left),
										left only);

CurrOwnProp := table(owned_prop, {seq, Bdid, CurrPropCnt := count(group)}, seq, Bdid) ;
CountOwnProp := table(ownPropDD, {seq, Bdid, OwnPropCnt := count(group)}, seq, Bdid) ;
CountSoldProp := table(SoldPropDD, {seq, Bdid, SoldPropCnt := count(group)}, seq, Bdid) ;

                 
PropTaxValue :=   join(owned_prop, kafid_nonFCRA, // assessor fid
									Keyed(left.ln_fares_id = right.ln_fares_id )and
									(unsigned4)right.tax_year <= (unsigned4)(((string)left.historydate)[1..4])
								  AND (unsigned4)right.assessed_value_year <= (unsigned4)(((string)left.historydate)[1..4])
								  AND (unsigned4)right.market_value_year <= (unsigned4)(((string)left.historydate)[1..4]) 
								  AND (unsigned3)right.sale_date[1..6] <= (unsigned3)left.historydate
								  AND (unsigned4)right.recording_date[1..6] <= (unsigned4)left.historydate,
                  transform(proprec, 
														SELF.PurchaseDate := if((integer)right.sale_date=0, right.recording_date, right.sale_date)	,								
														self.bdid:=left.bdid,
														self.seq :=left.seq,
														self.taxAssdValue := max( (unsigned)right.market_total_value, (unsigned)right.assessed_total_value),
                            self.LN_fares_id := left.LN_fares_id,	
														self.assessed_value_year := right.assessed_value_year,
														self := left,
														// self := right
														// self := []
														),
									left outer, 
									ATMOST(keyed(LEFT.LN_fares_id=RIGHT.ln_fares_id), 100));
									
														
									
RemoveZeroValues := PropTaxValue(taxAssdValue <> 0);

						
PropTaxValueDD :=  dedup(sort(RemoveZeroValues, seq, bdid, prim_range, prim_name, predir,suffix,postdir, zip, -assessed_value_year, -PurchaseDate, taxAssdValue),
                         seq, bdid, prim_range, prim_name, predir,suffix,postdir, zip);
                               									

											
proprec  RollPropTaxValue(PropTaxValueDD le,PropTaxValueDD ri) := Transform
   self.seq  := le.seq;
	 self.bdid := le.bdid;
	 self.TaxAssdValue  := le.TaxAssdValue + ri.TaxAssdValue;
	 self := le;
END;


BusnPropTaxRolled := rollup(PropTaxValueDD,
											left.bdid=right.bdid and left.seq=right.seq,
											RollPropTaxValue(LEFT,RIGHT));
											
AddBusnPropValue := join(BusnIds, BusnPropTaxRolled,
                     left.seq=right.seq and
										 left.OrigBdid=right.bdid,
										 transform(Layouts.BusnLayoutV2,
													   self.PropTaxValue := right.TaxAssdValue,
														 self  := left),
										 left outer);

AddPropSoldCount  := join(AddBusnPropValue, CountSoldProp,
                      left.seq=right.seq and left.OrigBdid=right.bdid,
											transform(Layouts.BusnLayoutV2, 
																self.CountSoldProp := right.SoldPropCnt,
																self := left),
											left outer);
											
AddPropOwnCount  := join(AddPropSoldCount, CountOwnProp,
                      left.seq=right.seq and left.OrigBdid=right.bdid,
											transform(Layouts.BusnLayoutV2, 
																self.CountOwnProp := right.OwnPropCnt,
																self := left),
											left outer);


AddCurrOwnCount  := join(AddPropOwnCount, CurrOwnProp,
                      left.seq=right.seq and left.OrigBdid=right.bdid,
											transform(Layouts.BusnLayoutV2, 
																self.CurrPropOwnedCount := right.CurrPropCnt,
																self := left),
											left outer);
											
											

// output(BusnIds, named('BusnIds'));
// output(BusnProp, named('BusnProp'));
// output(property_searched, named('property_searched'));
// output(owned_prop, named('owned_prop'));
// output(ownPropDD, named('ownPropDD'));
// output(SoldPropDD, named('SoldPropDD'));
// output(CurrOwnProp, named('CurrOwnProp'));
// output(CountOwnProp, named('CountOwnProp'));
// output(CountSoldProp, named('CountSoldProp'));
// output(PropTaxValue, named('PropTaxValue'));
// output(PropTaxValueDD, named('PropTaxValueDD'));
// output(BusnPropTaxRolled, named('BusnPropTaxRolled'));
// output(AddPropOwnCount, named('AddPropOwnCount'));

RETURN AddCurrOwnCount;

END;