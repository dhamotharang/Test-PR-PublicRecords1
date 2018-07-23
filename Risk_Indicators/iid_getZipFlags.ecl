import _Control, riskwise, risk_indicators;
onThor := _Control.Environment.OnThor;

export iid_getZipFlags(grouped DATASET(risk_indicators.Layout_output) inrec) := function

risk_indicators.layout_output addZipClass(risk_indicators.layout_output le, riskwise.Key_CityStZip rt) := transform	
	// addr_flags will be populated if there was a correction record.  use this result
	checkCMoverride := map(	risk_indicators.ga(le.chronoaddrscore) => le.chrono_addr_flags.corpMil,
													risk_indicators.ga(le.chronoaddrscore2) => le.chrono_addr_flags2.corpMil,
													risk_indicators.ga(le.chronoaddrscore3) => le.chrono_addr_flags3.corpMil,
													'');
	self.zipclass := if(trim(checkCMoverride)<>'', StringLib.StringToUpperCase(checkCMoverride), rt.zipclass);	
	self.zipcity := rt.prefctystname;

	self.ziptypeflag := MAP(length(Stringlib.StringFilter(le.in_zipCode,'0123456789')) < 5 and StringLib.StringFilterOut(le.in_zipCode,'0123456789') = '' => '6',
							trim(checkCMoverride)='U' => '2',
					    trim(checkCMoverride)='M' => '3',
							trim(rt.zipclass) = 'U' => '2',
					    trim(rt.zipclass) = 'M' => '3',
					    trim(rt.zipclass) = '' and rt.zip5 <> '' => '0',	// changed per apparent error
					    trim(rt.zipclass) = 'P' => '1',
					    trim(rt.zipclass) <> '' => '4',
					    '5');
	self.statezipflag := IF(trim(rt.state) <> '' and trim(le.in_state) <> '' and StringLib.StringToUpperCase(le.in_state) <> rt.state, '1', '0');
	self.cityzipflag := IF(trim(rt.city) <> '' and trim(le.in_city) <> '' and (risk_indicators.LnameScore(StringLib.StringToUpperCase(le.in_city), rt.city) < 80), '1', '0');
	
	self := le;
end;

wZipClass_roxie := join(inrec, riskwise.Key_CityStZip,
				keyed(right.zip5=left.in_zipCode) and trim(left.in_zipCode)!='',
				addZipClass(left, right), left outer, ATMOST(keyed(right.zip5=left.in_zipCode),RiskWise.max_atmost));

wZipClass_thor := join(distribute(inrec, hash64(in_zipCode)), 
				distribute(pull(riskwise.Key_CityStZip), hash64(zip5)),
				right.zip5=left.in_zipCode and trim(left.in_zipCode)!='',
				addZipClass(left, right), left outer, ATMOST(right.zip5=left.in_zipCode,RiskWise.max_atmost), LOCAL);
				
#IF(onThor)
	wZipClass := group(sort(wZipClass_thor, seq, local), seq, local);
#ELSE
	wZipClass := wZipClass_roxie;
#END

risk_indicators.layout_output zipRoll(risk_indicators.layout_output le, risk_indicators.layout_output ri) := transform
	self.ziptypeflag := IF(le.ziptypeflag  not in ['4','5'], le.ziptypeflag, ri.ziptypeflag);
	self.statezipflag := IF(le.statezipflag = '0', le.statezipflag, ri.statezipflag);
	self.cityzipflag := IF(le.cityzipflag = '0', le.cityzipflag, ri.cityzipflag);
	
	self := le;
end;
wZipClassRoll := ROLLUP(wZipClass,true,zipRoll(left,right));

return wZipClassRoll;

end;
