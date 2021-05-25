import risk_indicators, riskwise, header, relationship, std, dx_header, _Control;
onThor := _Control.Environment.OnThor;


export iid_getFraudVelocity(
	grouped 	dataset(risk_indicators.iid_constants.layout_outx) all_header,
	grouped 	dataset(risk_indicators.Layout_Output) rolled_header,
	String32 	ApplicationType = '',
	unsigned1 dppa=0, 
	boolean 	ln_branded=false,
	boolean 	isFCRA=false, 
	unsigned1 BSversion=1,
	string50 	DataRestriction=Risk_Indicators.iid_constants.default_DataRestriction,
	string10 	CustomDataFilter='',
	unsigned8 BSOptions=0,
	unsigned1 glb)  := function

// To use Relatives V3 filter for IDM's KBA applications 
isKBA := trim(stringlib.stringtouppercase(ApplicationType)) = 'KBA'; 
HighConfidenceRelatives_Value :=  isKBA;
HighConfidenceAssociates_Value := isKBA;
RelLookbackMonths_Value := if(isKBA,60,0); 


//get data from new Risk Correlation keys that were created for shell 5.3 
risk_indicators.layout_output add_ssn_name_summary(risk_indicators.layout_output le, Risk_Indicators.Correlation_Risk.key_ssn_name_summary rt) := transform
		rolledSummary := Risk_Indicators.rollCorrRiskSummary(rt.summary, le.historydate, dppa, ln_branded, isFCRA,
																												 BSversion, DataRestriction, CustomDataFilter, BSOptions, glb);
		self.header_summary.ssn_name_source_count := count(rolledSummary);
		setSources 			:= set(rolledSummary,src);
		stringSources 	:= STD.Str.CombineWords(setSources, ',');
		self.header_summary.corrssnname_sources := if(BSversion <= 51, '', trim(stringSources, left) + if(trim(stringSources, left, right) <> '', ',', ''));
		setFirstSeen  	:= set(rolledSummary,(string)dt_first_seen);
		stringFirstSeen := STD.Str.CombineWords(setFirstSeen, ',');
		self.header_summary.corrssnname_firstseen := if(BSversion <= 51, '', trim(stringFirstSeen, left, right) + if(trim(stringFirstSeen, left, right) <> '', ',', ''));
		setLastSeen  		:= set(rolledSummary,(string)dt_last_seen);
		stringLastSeen 	:= STD.Str.CombineWords(setLastSeen, ',');
		self.header_summary.corrssnname_lastseen := if(BSversion <= 51, '', trim(stringLastSeen, left, right) + if(trim(stringLastSeen, left, right) <> '', ',', ''));
		setSource_cnt		 := set(rolledSummary,(string)record_count);
		stringSource_cnt := STD.Str.CombineWords(setSource_cnt, ',');
		self.header_summary.corrssnname_source_cnt := if(BSversion <= 51, '', trim(stringSource_cnt, left, right) + if(trim(stringSource_cnt, left, right) <> '', ',', ''));
		self := le;
end;

with_ssn_name_summary_roxie := join(rolled_header, Risk_Indicators.Correlation_Risk.key_ssn_name_summary,
	left.ssn<>'' and left.fname<>'' and left.lname<>'' and
	keyed(left.ssn=right.ssn) and keyed(left.lname=right.lname) and keyed(left.fname=right.fname),
	add_ssn_name_summary(left, right),		
		left outer, atmost(riskwise.max_atmost), keep(1));

with_ssn_name_summary_thor := join(
	distribute(rolled_header(ssn<>'' and fname<>'' and lname<>''), hash64(ssn, lname, fname)),
	distribute(pull(Risk_Indicators.Correlation_Risk.key_ssn_name_summary), hash64(ssn, lname, fname)),
	(left.ssn=right.ssn) and (left.lname=right.lname) and (left.fname=right.fname),
	add_ssn_name_summary(left, right),		
		left outer, local) + 
	rolled_header(ssn='' or fname='' or lname=''); // add back the records that have any of these elements missing;

#IF(onThor)
	with_ssn_name_summary := with_ssn_name_summary_thor;
#ELSE
	with_ssn_name_summary := with_ssn_name_summary_roxie;
#END 
		
risk_indicators.layout_output add_ssn_addr_summary(risk_indicators.layout_output le, Risk_Indicators.Correlation_Risk.key_ssn_addr_summary rt) := transform
		rolledSummary := Risk_Indicators.rollCorrRiskSummary(rt.summary, le.historydate, dppa, ln_branded, isFCRA,
																												 BSversion, DataRestriction, CustomDataFilter, BSOptions, glb);
		self.header_summary.ssn_addr_source_count := count(rolledSummary);
		setSources 			 := set(rolledSummary,src);
		stringSources 	 := STD.Str.CombineWords(setSources, ',');
		self.header_summary.corrssnaddr_sources := if(BSversion <= 51, '', trim(stringSources, left) + if(trim(stringSources, left, right) <> '', ',', ''));
		setFirstSeen  	 := set(rolledSummary,(string)dt_first_seen);
		stringFirstSeen  := STD.Str.CombineWords(setFirstSeen, ',');
		self.header_summary.corrssnaddr_firstseen := if(BSversion <= 51, '', trim(stringFirstSeen, left, right) + if(trim(stringFirstSeen, left, right) <> '', ',', ''));
		setLastSeen  		 := set(rolledSummary,(string)dt_last_seen);
		stringLastSeen 	 := STD.Str.CombineWords(setLastSeen, ',');
		self.header_summary.corrssnaddr_lastseen := if(BSversion <= 51, '', trim(stringLastSeen, left, right) + if(trim(stringLastSeen, left, right) <> '', ',', ''));
		setSource_cnt		 := set(rolledSummary,(string)record_count);
		stringSource_cnt := STD.Str.CombineWords(setSource_cnt, ',');
		self.header_summary.corrssnaddr_source_cnt := if(BSversion <= 51, '', trim(stringSource_cnt, left, right) + if(trim(stringSource_cnt, left, right) <> '', ',', ''));
		self := le;
end; 
		
with_ssn_addr_summary_roxie := join(with_ssn_name_summary, Risk_Indicators.Correlation_Risk.key_ssn_addr_summary,
	left.ssn<>'' and left.prim_name<>'' and left.z5<>'' and
	keyed(left.ssn=right.ssn) and keyed(left.prim_name=right.prim_name) and keyed(left.prim_range=right.prim_range) and keyed(left.z5=right.zip),
add_ssn_addr_summary(left, right),		
		left outer, atmost(riskwise.max_atmost), keep(1));
		
with_ssn_addr_summary_thor := join(
distribute(with_ssn_name_summary(ssn<>'' and prim_name<>'' and z5<>''), hash64(ssn, prim_name, z5)), 
distribute(pull(Risk_Indicators.Correlation_Risk.key_ssn_addr_summary), hash64(ssn, prim_name, zip)),
	(left.ssn=right.ssn) and (left.prim_name=right.prim_name) and (left.prim_range=right.prim_range) and (left.z5=right.zip),
add_ssn_addr_summary(left, right),		
		left outer, local) + 
	with_ssn_name_summary(ssn='' or prim_name='' or z5=''); // add back the records that have any of these elements missing;
	
#IF(onThor)
	with_ssn_addr_summary := with_ssn_addr_summary_thor;
#ELSE
	with_ssn_addr_summary := with_ssn_addr_summary_roxie;
#END 

risk_indicators.layout_output add_addr_name_summary(risk_indicators.layout_output le, Risk_Indicators.Correlation_Risk.key_addr_name_summary rt) := transform
		rolledSummary := Risk_Indicators.rollCorrRiskSummary(rt.summary, le.historydate, dppa, ln_branded, isFCRA,
																												 BSversion, DataRestriction, CustomDataFilter, BSOptions, glb);
		self.header_summary.addr_name_source_count := count(rolledSummary);
		setSources 			:= set(rolledSummary,src);
		stringSources 	:= STD.Str.CombineWords(setSources, ',');
		self.header_summary.corraddrname_sources := if(BSversion <= 51, '', trim(stringSources, left) + if(trim(stringSources, left, right) <> '', ',', ''));
		setFirstSeen  	:= set(rolledSummary,(string)dt_first_seen);
		stringFirstSeen := STD.Str.CombineWords(setFirstSeen, ',');
		self.header_summary.corraddrname_firstseen := if(BSversion <= 51, '', trim(stringFirstSeen, left, right) + if(trim(stringFirstSeen, left, right) <> '', ',', ''));
		setLastSeen  		:= set(rolledSummary,(string)dt_last_seen);
		stringLastSeen 	:= STD.Str.CombineWords(setLastSeen, ',');
		self.header_summary.corraddrname_lastseen := if(BSversion <= 51, '', trim(stringLastSeen, left, right) + if(trim(stringLastSeen, left, right) <> '', ',', ''));
		setSource_cnt		 := set(rolledSummary,(string)record_count);
		stringSource_cnt := STD.Str.CombineWords(setSource_cnt, ',');
		self.header_summary.corraddrname_source_cnt := if(BSversion <= 51, '', trim(stringSource_cnt, left, right) + if(trim(stringSource_cnt, left, right) <> '', ',', ''));
		self := le;		
end;

with_addr_name_summary_roxie := join(with_ssn_addr_summary, Risk_Indicators.Correlation_Risk.key_addr_name_summary,
	left.prim_name<>'' and left.z5<>'' and left.fname<>'' and left.lname<>'' and
	keyed(left.prim_name=right.prim_name) and keyed(left.prim_range=right.prim_range) and keyed(left.z5=right.zip) and
	keyed(left.fname=right.fname) and keyed(left.lname=right.lname),
	add_addr_name_summary(left,right), 
	left outer, atmost(riskwise.max_atmost), keep(1));
	
with_addr_name_summary_thor := join(
distribute(with_ssn_addr_summary(prim_name<>'' and z5<>'' and fname<>'' and lname<>''), hash64(prim_name, prim_range, z5, fname, lname)), 
distribute(pull(Risk_Indicators.Correlation_Risk.key_addr_name_summary), hash64(prim_name, prim_range, zip, fname, lname)),
	(left.prim_name=right.prim_name) and (left.prim_range=right.prim_range) and (left.z5=right.zip) and
	(left.fname=right.fname) and (left.lname=right.lname),
	add_addr_name_summary(left,right), 
	left outer, atmost(riskwise.max_atmost), keep(1), local) +
	with_ssn_addr_summary(prim_name='' or z5='' or fname='' or lname=''); // add back the records that have any of these elements missing;

#IF(onThor)
	with_addr_name_summary := with_addr_name_summary_thor;
#ELSE
	with_addr_name_summary := with_addr_name_summary_roxie;
#END 

risk_indicators.Layout_Output add_phone_addr_summary(risk_indicators.layout_output le, Risk_Indicators.Correlation_Risk.key_phone_addr_summary rt) := transform
		rolledSummary := Risk_Indicators.rollCorrRiskSummary(rt.Summary, le.historydate, dppa, ln_branded, isFCRA,
																												 BSversion, DataRestriction, CustomDataFilter, BSOptions, glb);
		self.header_summary.phone_addr_source_count := count(rolledSummary);
		self := le;
end;

//this join to populate the existing field 'phone_addr_source_count' based off of phone/utility sources (WP, Infutor, Utilities, Gong)
with_phone_addr_summary_roxie := join(with_addr_name_summary, Risk_Indicators.Correlation_Risk.key_phone_addr_summary,
	left.phone10<>'' and left.prim_name<>'' and left.z5<>'' and
	keyed(left.phone10=right.phone10) and keyed(left.prim_name=right.prim_name) and keyed(left.prim_range=right.prim_range) and keyed(left.z5=right.zip),
	add_phone_addr_summary(left, right), left outer, atmost(riskwise.max_atmost), keep(1));

with_phone_addr_summary_thor := join(
distribute(with_addr_name_summary(phone10<>'' and prim_name<>'' and z5<>''), hash64(phone10, prim_name, prim_range, z5)), 
distribute(pull(Risk_Indicators.Correlation_Risk.key_phone_addr_summary),hash64(phone10, prim_name, prim_range, zip)), 
	(left.phone10=right.phone10) and (left.prim_name=right.prim_name) and (left.prim_range=right.prim_range) and (left.z5=right.zip),
	add_phone_addr_summary(left, right), left outer, atmost(riskwise.max_atmost), keep(1), local) +
	with_addr_name_summary(phone10='' or prim_name='' or z5=''); // add back the records that have any of these elements missing;

#IF(onThor)
	with_phone_addr_summary := with_phone_addr_summary_thor;
#ELSE
	with_phone_addr_summary := with_phone_addr_summary_roxie;
#END 

risk_indicators.layout_output add_phone_addr_header_summary(risk_indicators.layout_output le, Risk_Indicators.Correlation_Risk.key_phone_addr_header_summary rt) := transform
		rolledSummary := Risk_Indicators.rollCorrRiskSummary(rt.Summary, le.historydate, dppa, ln_branded, isFCRA,
																												 BSversion, DataRestriction, CustomDataFilter, BSOptions, glb);
		setSources 			:= set(rolledSummary,src);
		stringSources 	:= STD.Str.CombineWords(setSources, ',');
		self.header_summary.corraddrphone_sources := if(BSversion <= 51, '', trim(stringSources, left) + if(trim(stringSources, left, right) <> '', ',', ''));
		setFirstSeen  	:= set(rolledSummary,(string)dt_first_seen);
		stringFirstSeen := STD.Str.CombineWords(setFirstSeen, ',');
		self.header_summary.corraddrphone_firstseen := if(BSversion <= 51, '', trim(stringFirstSeen, left, right) + if(trim(stringFirstSeen, left, right) <> '', ',', ''));
		setLastSeen  		:= set(rolledSummary,(string)dt_last_seen);
		stringLastSeen 	:= STD.Str.CombineWords(setLastSeen, ',');
		self.header_summary.corraddrphone_lastseen := if(BSversion <= 51, '', trim(stringLastSeen, left, right) + if(trim(stringLastSeen, left, right) <> '', ',', ''));
		setSource_cnt		 := set(rolledSummary,(string)record_count);
		stringSource_cnt := STD.Str.CombineWords(setSource_cnt, ',');
		self.header_summary.corraddrphone_source_cnt := if(BSversion <= 51, '', trim(stringSource_cnt, left, right) + if(trim(stringSource_cnt, left, right) <> '', ',', ''));
		self := le;
end;
//this join for BS 5.2 and higher to populate the new phone/addr correlation fields based off of header sources
with_phone_addr_header_summary_roxie := join(with_phone_addr_summary, Risk_Indicators.Correlation_Risk.key_phone_addr_header_summary,
	left.phone10<>'' and left.prim_name<>'' and left.z5<>'' and
	keyed(left.phone10=right.phone10) and keyed(left.prim_name=right.prim_name) and keyed(left.prim_range=right.prim_range) and keyed(left.z5=right.zip),
	add_phone_addr_header_summary(left, right), 
	left outer, atmost(riskwise.max_atmost), keep(1));

with_phone_addr_header_summary_thor := join(
distribute(with_phone_addr_summary(phone10<>'' and prim_name<>'' and z5<>''), hash64(phone10, prim_name, z5)),
distribute(pull(Risk_Indicators.Correlation_Risk.key_phone_addr_header_summary), hash64(phone10, prim_name, zip)),
		(left.phone10=right.phone10) and (left.prim_name=right.prim_name) and (left.prim_range=right.prim_range) and (left.z5=right.zip),
	add_phone_addr_header_summary(left, right), 
	left outer, atmost(riskwise.max_atmost), keep(1), local) + 
	with_phone_addr_summary(phone10='' or prim_name='' or z5='');  // add back the records that have any of these elements missing;

#IF(onThor)
	with_phone_addr_header_summary := with_phone_addr_header_summary_thor;
#ELSE
	with_phone_addr_header_summary := with_phone_addr_header_summary_roxie;
#END 
	
risk_indicators.layout_output add_phone_lname_summary(risk_indicators.layout_output le, Risk_Indicators.Correlation_Risk.key_phone_lname_summary rt) := transform
		rolledSummary := Risk_Indicators.rollCorrRiskSummary(rt.summary, le.historydate, dppa, ln_branded, isFCRA,
																												 BSversion, DataRestriction, CustomDataFilter, BSOptions, glb);
		self.header_summary.phone_lname_source_count := count(rolledSummary);
		self := le;
end;

//this join to populate the existing field 'phone_lname_source_count' based off of phone/utility sources (WP, Infutor, Utilities, Gong)
with_phone_lname_summary_roxie := join(with_phone_addr_header_summary, Risk_Indicators.Correlation_Risk.key_phone_lname_summary,
	left.phone10<>'' and left.lname<>'' and
	keyed(left.phone10=right.phone10) and keyed(left.lname=right.lname),
	add_phone_lname_summary(left, right), 
	left outer, atmost(riskwise.max_atmost), keep(1));

with_phone_lname_summary_thor := join(
distribute(with_phone_addr_header_summary(phone10<>'' and lname<>''), hash64(phone10, lname)), 
distribute(pull(Risk_Indicators.Correlation_Risk.key_phone_lname_summary), hash64(phone10, lname)),
	(left.phone10=right.phone10) and (left.lname=right.lname),
	add_phone_lname_summary(left, right), 
	left outer, atmost(riskwise.max_atmost), keep(1), local) +
	with_phone_addr_header_summary(phone10='' or lname=''); // add back the records that have any of these elements missing;
	
#IF(onThor)
	with_phone_lname_summary := with_phone_lname_summary_thor;
#ELSE
	with_phone_lname_summary := with_phone_lname_summary_roxie;
#END 

	
risk_indicators.layout_output add_phone_lname_header_summary(risk_indicators.layout_output le, Risk_Indicators.Correlation_Risk.key_phone_lname_header_summary rt) := transform
		rolledSummary := Risk_Indicators.rollCorrRiskSummary(rt.summary, le.historydate, dppa, ln_branded, isFCRA,
																												 BSversion, DataRestriction, CustomDataFilter, BSOptions, glb);
		setSources 			:= set(rolledSummary,src);
		stringSources 	:= STD.Str.CombineWords(setSources, ',');
		self.header_summary.corrphonelastname_sources := if(BSversion <= 51, '', trim(stringSources, left) + if(trim(stringSources, left, right) <> '', ',', ''));
		setFirstSeen  	:= set(rolledSummary,(string)dt_first_seen);
		stringFirstSeen := STD.Str.CombineWords(setFirstSeen, ',');
		self.header_summary.corrphonelastname_firstseen := if(BSversion <= 51, '', trim(stringFirstSeen, left, right) + if(trim(stringFirstSeen, left, right) <> '', ',', ''));
		setLastSeen  		:= set(rolledSummary,(string)dt_last_seen);
		stringLastSeen 	:= STD.Str.CombineWords(setLastSeen, ',');
		self.header_summary.corrphonelastname_lastseen := if(BSversion <= 51, '', trim(stringLastSeen, left, right) + if(trim(stringLastSeen, left, right) <> '', ',', ''));
		setSource_cnt		 := set(rolledSummary,(string)record_count);
		stringSource_cnt := STD.Str.CombineWords(setSource_cnt, ',');
		self.header_summary.corrphonelastname_source_cnt := if(BSversion <= 51, '', trim(stringSource_cnt, left, right) + if(trim(stringSource_cnt, left, right) <> '', ',', ''));
		self := le;
end;

//this join for BS 5.3 and higher to populate the new phone/addr correlation fields based off of header sources
with_phone_lname_header_summary_roxie := join(with_phone_lname_summary, Risk_Indicators.Correlation_Risk.key_phone_lname_header_summary,
	left.phone10<>'' and left.lname<>'' and
	keyed(left.phone10=right.phone10) and keyed(left.lname=right.lname),
	add_phone_lname_header_summary(left, right), left outer, atmost(riskwise.max_atmost), keep(1));

with_phone_lname_header_summary_thor := join(
distribute(with_phone_lname_summary(phone10<>'' and lname<>''), hash64(phone10, lname)),
distribute(Risk_Indicators.Correlation_Risk.key_phone_lname_header_summary, hash64(phone10, lname)),
	(left.phone10=right.phone10) and (left.lname=right.lname),
	add_phone_lname_header_summary(left, right), left outer, atmost(riskwise.max_atmost), keep(1), local) +
	with_phone_lname_summary(phone10='' or lname='');  // add back the records that have any of these elements missing;

#IF(onThor)
	with_phone_lname_header_summary := with_phone_lname_header_summary_thor;
#ELSE
	with_phone_lname_header_summary := with_phone_lname_header_summary_roxie;
#END 	
	
risk_indicators.layout_output add_name_dob_summary(risk_indicators.layout_output le, Risk_Indicators.Correlation_Risk.key_name_dob_summary rt) := transform
		rolledSummary := Risk_Indicators.rollCorrRiskSummary(rt.summary, le.historydate, dppa, ln_branded, isFCRA,
																												 BSversion, DataRestriction, CustomDataFilter, BSOptions, glb);
		setSources 			:= set(rolledSummary,src);
		stringSources 	:= STD.Str.CombineWords(setSources, ',');
		self.header_summary.corrnamedob_sources := trim(stringSources, left) + if(trim(stringSources, left, right) <> '', ',', '');
		setFirstSeen  	:= set(rolledSummary,(string)dt_first_seen);
		stringFirstSeen := STD.Str.CombineWords(setFirstSeen, ',');
		self.header_summary.corrnamedob_firstseen := trim(stringFirstSeen, left, right) + if(trim(stringFirstSeen, left, right) <> '', ',', '');
		setLastSeen  		:= set(rolledSummary,(string)dt_last_seen);
		stringLastSeen 	:= STD.Str.CombineWords(setLastSeen, ',');
		self.header_summary.corrnamedob_lastseen := trim(stringLastSeen, left, right) + if(trim(stringLastSeen, left, right) <> '', ',', '');
		setSource_cnt		 := set(rolledSummary,(string)record_count);
		stringSource_cnt := STD.Str.CombineWords(setSource_cnt, ',');
		self.header_summary.corrnamedob_source_cnt := trim(stringSource_cnt, left, right) + if(trim(stringSource_cnt, left, right) <> '', ',', '');
		self := le;
end;		
with_name_dob_summary_roxie := join(with_phone_lname_header_summary, Risk_Indicators.Correlation_Risk.key_name_dob_summary,
	left.lname<>'' and left.fname<>'' and left.dob<>'' and 
	keyed(left.lname=right.lname) and keyed(left.fname=right.fname) and keyed(left.dob=(string)right.dob),
	add_name_dob_summary(left, right), left outer, atmost(riskwise.max_atmost), keep(1));		

with_name_dob_summary_thor := join(
distribute(with_phone_lname_header_summary(lname<>'' and fname<>'' and dob<>''), hash64(lname, fname, dob)), 
distribute(pull(Risk_Indicators.Correlation_Risk.key_name_dob_summary), hash64(lname, fname, dob)),
	(left.lname=right.lname) and (left.fname=right.fname) and (left.dob=(string)right.dob),
	add_name_dob_summary(left, right), left outer, atmost(riskwise.max_atmost), keep(1), local) +
	with_phone_lname_header_summary(lname='' or fname='' or dob='');  // add back the records that have any of these elements missing;		
	
#IF(onThor)
	with_name_dob_summary := with_name_dob_summary_thor;
#ELSE
	with_name_dob_summary := with_name_dob_summary_roxie;
#END
	
risk_indicators.layout_output add_addr_dob_summary(risk_indicators.layout_output le, Risk_Indicators.Correlation_Risk.key_addr_dob_summary rt) := transform
		rolledSummary := Risk_Indicators.rollCorrRiskSummary(rt.summary, le.historydate, dppa, ln_branded, isFCRA,
																												 BSversion, DataRestriction, CustomDataFilter, BSOptions, glb);
		setSources 			:= set(rolledSummary,src);
		stringSources 	:= STD.Str.CombineWords(setSources, ',');
		self.header_summary.corraddrdob_sources := trim(stringSources, left) + if(trim(stringSources, left, right) <> '', ',', '');
		setFirstSeen  	:= set(rolledSummary,(string)dt_first_seen);
		stringFirstSeen := STD.Str.CombineWords(setFirstSeen, ',');
		self.header_summary.corraddrdob_firstseen := trim(stringFirstSeen, left, right) + if(trim(stringFirstSeen, left, right) <> '', ',', '');
		setLastSeen  		:= set(rolledSummary,(string)dt_last_seen);
		stringLastSeen 	:= STD.Str.CombineWords(setLastSeen, ',');
		self.header_summary.corraddrdob_lastseen := trim(stringLastSeen, left, right) + if(trim(stringLastSeen, left, right) <> '', ',', '');
		setSource_cnt		 := set(rolledSummary,(string)record_count);
		stringSource_cnt := STD.Str.CombineWords(setSource_cnt, ',');
		self.header_summary.corraddrdob_source_cnt := trim(stringSource_cnt, left, right) + if(trim(stringSource_cnt, left, right) <> '', ',', '');
		self := le;
end;
with_addr_dob_summary_roxie := join(with_name_dob_summary, Risk_Indicators.Correlation_Risk.key_addr_dob_summary,
	left.prim_name<>'' and left.prim_range<>'' and left.z5<>'' and left.dob<>'' and 
	keyed(left.prim_name=right.prim_name) and keyed(left.prim_range=right.prim_range) and 
	keyed(left.z5=right.zip) and keyed(left.dob=(string)right.dob),
	add_addr_dob_summary(left, right), left outer, atmost(riskwise.max_atmost), keep(1));		

with_addr_dob_summary_thor := join(
distribute(with_name_dob_summary(prim_name<>'' and prim_range<>'' and z5<>'' and dob<>''), hash64(prim_name, prim_range, z5, dob)), 
distribute(pull(Risk_Indicators.Correlation_Risk.key_addr_dob_summary),hash64(prim_name, prim_range, zip, dob)),
	(left.prim_name=right.prim_name) and (left.prim_range=right.prim_range) and 
	(left.z5=right.zip) and (left.dob=(string)right.dob),
	add_addr_dob_summary(left, right), left outer, atmost(riskwise.max_atmost), keep(1), local) +
	with_name_dob_summary(prim_name='' or prim_range='' or z5='' or dob='');		// add back the records that have any of these elements missing;	

#IF(onThor)
	with_addr_dob_summary := with_addr_dob_summary_thor;
#ELSE
	with_addr_dob_summary := with_addr_dob_summary_roxie;
#END	
	
risk_indicators.layout_output add_ssn_dob_summary(risk_indicators.layout_output le, Risk_Indicators.Correlation_Risk.key_ssn_dob_summary rt) := transform
		rolledSummary := Risk_Indicators.rollCorrRiskSummary(rt.summary, le.historydate, dppa, ln_branded, isFCRA,
																												 BSversion, DataRestriction, CustomDataFilter, BSOptions, glb);
		setSources 			:= set(rolledSummary,src);
		stringSources 	:= STD.Str.CombineWords(setSources, ',');
		self.header_summary.corrssndob_sources := trim(stringSources, left) + if(trim(stringSources, left, right) <> '', ',', '');
		setFirstSeen  	:= set(rolledSummary,(string)dt_first_seen);
		stringFirstSeen := STD.Str.CombineWords(setFirstSeen, ',');
		self.header_summary.corrssndob_firstseen := trim(stringFirstSeen, left, right) + if(trim(stringFirstSeen, left, right) <> '', ',', '');
		setLastSeen  		:= set(rolledSummary,(string)dt_last_seen);
		stringLastSeen 	:= STD.Str.CombineWords(setLastSeen, ',');
		self.header_summary.corrssndob_lastseen := trim(stringLastSeen, left, right) + if(trim(stringLastSeen, left, right) <> '', ',', '');
		setSource_cnt		 := set(rolledSummary,(string)record_count);
		stringSource_cnt := STD.Str.CombineWords(setSource_cnt, ',');
		self.header_summary.corrssndob_source_cnt := trim(stringSource_cnt, left, right) + if(trim(stringSource_cnt, left, right) <> '', ',', '');
		self := le;
end;

with_ssn_dob_summary_roxie := join(with_addr_dob_summary, Risk_Indicators.Correlation_Risk.key_ssn_dob_summary,
	left.ssn<>'' and left.dob<>'' and 
	keyed(left.ssn=right.ssn) and keyed(left.dob=(string)right.dob),
	add_ssn_dob_summary(left, right), left outer, atmost(riskwise.max_atmost), keep(1));		

with_ssn_dob_summary_thor := join(
distribute(with_addr_dob_summary(ssn<>'' and dob<>''), hash64(ssn, dob)),
distribute(pull(Risk_Indicators.Correlation_Risk.key_ssn_dob_summary), hash64(ssn, dob)),
	(left.ssn=right.ssn) and (left.dob=(string)right.dob),
	add_ssn_dob_summary(left, right), left outer, atmost(riskwise.max_atmost), keep(1), local) +
	with_addr_dob_summary(ssn='' or dob='');	// add back the records that have any of these elements missing;	

#IF(onThor)
	with_ssn_dob_summary := with_ssn_dob_summary_thor;
#ELSE
	with_ssn_dob_summary := with_ssn_dob_summary_roxie;
#END		
	
risk_indicators.layout_output add_ssn_phone_summary(risk_indicators.layout_output le, Risk_Indicators.Correlation_Risk.key_ssn_phone_summary rt) := transform
		rolledSummary := Risk_Indicators.rollCorrRiskSummary(rt.summary, le.historydate, dppa, ln_branded, isFCRA,
																												 BSversion, DataRestriction, CustomDataFilter, BSOptions, glb);
		setSources 			:= set(rolledSummary,src);
		stringSources 	:= STD.Str.CombineWords(setSources, ',');
		self.header_summary.corrssnphone_sources := trim(stringSources, left) + if(trim(stringSources, left, right) <> '', ',', '');
		setFirstSeen  	:= set(rolledSummary,(string)dt_first_seen);
		stringFirstSeen := STD.Str.CombineWords(setFirstSeen, ',');
		self.header_summary.corrssnphone_firstseen := trim(stringFirstSeen, left, right) + if(trim(stringFirstSeen, left, right) <> '', ',', '');
		setLastSeen  		:= set(rolledSummary,(string)dt_last_seen);
		stringLastSeen 	:= STD.Str.CombineWords(setLastSeen, ',');
		self.header_summary.corrssnphone_lastseen := trim(stringLastSeen, left, right) + if(trim(stringLastSeen, left, right) <> '', ',', '');
		setSource_cnt		 := set(rolledSummary,(string)record_count);
		stringSource_cnt := STD.Str.CombineWords(setSource_cnt, ',');
		self.header_summary.corrssnphone_source_cnt := trim(stringSource_cnt, left, right) + if(trim(stringSource_cnt, left, right) <> '', ',', '');
		self := le;
end;

with_ssn_phone_summary_roxie := join(with_ssn_dob_summary, Risk_Indicators.Correlation_Risk.key_ssn_phone_summary,
	left.ssn<>'' and left.phone10<>'' and 
	keyed(left.ssn=right.ssn) and keyed(left.phone10=right.phone),
	add_ssn_phone_summary(left, right), left outer, atmost(riskwise.max_atmost), keep(1));

with_ssn_phone_summary_thor := join(
distribute(with_ssn_dob_summary(ssn<>'' and phone10<>''), hash64(ssn, phone10)),
distribute(pull(Risk_Indicators.Correlation_Risk.key_ssn_phone_summary), hash64(ssn, phone)),
	(left.ssn=right.ssn) and (left.phone10=right.phone),
	add_ssn_phone_summary(left, right), left outer, atmost(riskwise.max_atmost), keep(1), local) +
	with_ssn_dob_summary(ssn='' or phone10='');// add back the records that have any of these elements missing;
	
#IF(onThor)
	with_ssn_phone_summary := with_ssn_phone_summary_thor;
#ELSE
	with_ssn_phone_summary := with_ssn_phone_summary_roxie;
#END		
	
risk_indicators.layout_output add_phone_dob_summary(risk_indicators.layout_output le, Risk_Indicators.Correlation_Risk.key_phone_dob_summary rt) := transform
		rolledSummary := Risk_Indicators.rollCorrRiskSummary(rt.summary, le.historydate, dppa, ln_branded, isFCRA,
																												 BSversion, DataRestriction, CustomDataFilter, BSOptions, glb);
		setSources 			:= set(rolledSummary,src);
		stringSources 	:= STD.Str.CombineWords(setSources, ',');
		self.header_summary.corrdobphone_sources := trim(stringSources, left) + if(trim(stringSources, left, right) <> '', ',', '');
		setFirstSeen  	:= set(rolledSummary,(string)dt_first_seen);
		stringFirstSeen := STD.Str.CombineWords(setFirstSeen, ',');
		self.header_summary.corrdobphone_firstseen := trim(stringFirstSeen, left, right) + if(trim(stringFirstSeen, left, right) <> '', ',', '');
		setLastSeen  		:= set(rolledSummary,(string)dt_last_seen);
		stringLastSeen 	:= STD.Str.CombineWords(setLastSeen, ',');
		self.header_summary.corrdobphone_lastseen := trim(stringLastSeen, left, right) + if(trim(stringLastSeen, left, right) <> '', ',', '');
		setSource_cnt		 := set(rolledSummary,(string)record_count);
		stringSource_cnt := STD.Str.CombineWords(setSource_cnt, ',');
		self.header_summary.corrdobphone_source_cnt := trim(stringSource_cnt, left, right) + if(trim(stringSource_cnt, left, right) <> '', ',', '');
		self := le;
end;
with_correlation_summary52_roxie := join(with_ssn_phone_summary, Risk_Indicators.Correlation_Risk.key_phone_dob_summary,
	left.phone10<>'' and left.dob<>'' and  
	keyed(left.phone10=right.phone) and keyed(left.dob=(string)right.dob), 
	add_phone_dob_summary(left, right), left outer, atmost(riskwise.max_atmost), keep(1));		

with_correlation_summary52_thor := join(
distribute(with_ssn_phone_summary(phone10<>'' and dob<>''), hash64(phone10, dob)),
distribute(pull(Risk_Indicators.Correlation_Risk.key_phone_dob_summary), hash64(phone, dob)),
	(left.phone10=right.phone) and (left.dob=(string)right.dob), 
	add_phone_dob_summary(left, right), left outer, atmost(riskwise.max_atmost), keep(1), local) +
	with_ssn_phone_summary(phone10='' or dob='');	// add back the records that have any of these elements missing;
	
#IF(onThor)
	with_correlation_summary52 := with_correlation_summary52_thor;
#ELSE
	with_correlation_summary52 := with_correlation_summary52_roxie;
#END		

	
with_correlation_summary := if(bsversion <= 51, with_phone_lname_summary, with_correlation_summary52);  //don't do unnecessary joins if BS version <= 51

// hang on to datasets of PII information that was found on file at the time of application
		ssns_on_file := dedup(sort(table(all_header, {seq, historydate, h.ssn, dt_first := min(group, if(h.dt_first_seen=0, 999999, h.dt_first_seen))}, 
																									seq, historydate, h.ssn), seq, -if(dt_first=999999, 0, dt_first)), keep(5));							
		addrs_on_file := dedup(sort(table(all_header, {seq,historydate, h.prim_range, h.prim_name, dt_first := min(group, if(h.dt_first_seen=0, 999999, h.dt_first_seen))}, 
																									 seq,historydate,  h.prim_range, h.prim_name), seq, -if(dt_first=999999, 0, dt_first)), keep(30));							
		dobs_on_file := dedup(sort(table(all_header, {seq,historydate, h.dob, dt_first := min(group, if(h.dt_first_seen=0, 999999, h.dt_first_seen))}, 
																									seq,historydate, h.dob), seq, -if(dt_first=999999, 0, dt_first)), keep(5));	
		lnames_on_file := dedup(sort(table(all_header, {seq,historydate, h.lname, dt_first := min(group, if(h.dt_first_seen=0, 999999, h.dt_first_seen))}, 
																									seq,historydate, h.lname), seq, -if(dt_first=999999, 0, dt_first)), keep(30));																									
		temprec := record
			unsigned seq;
			Risk_Indicators.Layouts.layout_pii_on_file;
		end;

		pssn := project(ssns_on_file, 
			transform(temprec, 
				self.ssns_on_file := if(trim(left.ssn)='', '', left.ssn + ',');	
				self.ssns_on_file_created12months := 
					if(trim(left.ssn)<>'' and iid_constants.checkdays(iid_constants.myGetDate(left.historydate),
																		(string)left.dt_first + '31',
																		iid_constants.oneyear, 
																		left.historydate), 
						left.ssn + ',', 
						'');	
				self := left,
				self := []));
		// output(ps);
		rolled_ssns := rollup(pssn, left.seq=right.seq, 
			transform(temprec, 
				self.ssns_on_file := trim(left.ssns_on_file) + right.ssns_on_file + ',';
				self.ssns_on_file_created12months := trim(left.ssns_on_file_created12months) + if(trim(right.ssns_on_file_created12months)='', '',  right.ssns_on_file_created12months+ ',');
				self := left));

		paddr := project(addrs_on_file, 
			transform(temprec, 
				street := trim( trim(left.prim_range) + trim(left.prim_name) );
				self.streets_on_file := if(street='', '', street + ',');
				self.streets_on_file_created12months := 
					if(trim(street)<>'' and iid_constants.checkdays(iid_constants.myGetDate(left.historydate),
																		(string)left.dt_first + '31',
																		iid_constants.oneyear, 
																		left.historydate), 
						street + ',', 
						'');					
				
				self := left,
				self := []));
		// output(ps);
		rolled_streets := rollup(paddr, left.seq=right.seq, 
			transform(temprec, 
				self.streets_on_file := trim(left.streets_on_file) + right.streets_on_file + ',', 
				self.streets_on_file_created12months := trim(left.streets_on_file_created12months) + if(trim(right.streets_on_file_created12months)='', '',  right.streets_on_file_created12months+ ',');
				self := left));

		pdob := project(dobs_on_file, 
			transform(temprec, 
				self.dobs_on_file := if(left.dob=0, '', (string8)left.dob + ',');
				self.dobs_on_file_created12months := 
					if(left.dob<>0 and iid_constants.checkdays(iid_constants.myGetDate(left.historydate),
																		(string)left.dt_first + '31',
																		iid_constants.oneyear, 
																		left.historydate), 
						(string8)left.dob + ',', 
						'');	
				self := left,
				self := []));
		// output(ps);
		rolled_dobs_on_file := rollup(pdob, left.seq=right.seq, 
			transform(temprec, 
				self.dobs_on_file := trim(left.dobs_on_file) + right.dobs_on_file + ','; 
				self.dobs_on_file_created12months := trim(left.dobs_on_file_created12months) + if(trim(right.dobs_on_file_created12months)='', '',  right.dobs_on_file_created12months+ ',');

				self := left));

		plname := project(lnames_on_file, 
			transform(temprec, 
				self.lnames_on_file := if(left.lname='', '', (string8)left.lname + ',');
				self := left,
				self := []));
		// output(ps);
		rolled_lname_on_file := rollup(plname, left.seq=right.seq, 
			transform(temprec, 
				self.lnames_on_file := trim(left.lnames_on_file) + right.lnames_on_file + ','; 
				self := left));

		j1 := join(rolled_ssns, rolled_streets, left.seq=right.seq, 
			transform(temprec, 
				self.ssns_on_file := left.ssns_on_file;
				self.ssns_on_file_created12months := left.ssns_on_file_created12months;
				self.streets_on_file := right.streets_on_file;
				self.streets_on_file_created12months := right.streets_on_file_created12months;
				self.seq := if(left.seq=0, right.seq, left.seq);
				self := [];
				), full outer);

		j2 := join(j1, rolled_dobs_on_file, left.seq=right.seq,
			transform(temprec,
				self.dobs_on_file := right.dobs_on_file;
				self.dobs_on_file_created12months := right.dobs_on_file_created12months;
				self.seq := if(left.seq=0, right.seq, left.seq);
				self := left), full outer);
	
		j3 := join(j2, rolled_lname_on_file, left.seq=right.seq,
			transform(temprec,
				self.lnames_on_file := right.lnames_on_file;
				self.seq := if(left.seq=0, right.seq, left.seq);
				self := left), full outer);	
	
	with_pii_on_file := join(with_correlation_summary, j3, left.seq=right.seq,
			transform(risk_indicators.layout_output,
				self.header_summary.ssns_on_file := right.ssns_on_file;
				self.header_summary.streets_on_file := right.streets_on_file;
				self.header_summary.dobs_on_file := right.dobs_on_file;				
				self.header_summary.lnames_on_file := right.lnames_on_file;		
				
				self.header_summary.ssns_on_file_created12months := right.ssns_on_file_created12months;
				self.header_summary.streets_on_file_created12months := right.streets_on_file_created12months;
				self.header_summary.dobs_on_file_created12months := right.dobs_on_file_created12months;
				self := left), left outer);

// check the NLR (no longer reporting) file to see if DIDs or SSNs have been deleted from bureaus
temprec3 := record  
	risk_indicators.iid_constants.layout_outx;
	unsigned4 not_in_bureau; // for debugging
	
	boolean EQ_did_nlr;
	boolean EN_did_nlr;
	boolean TN_did_nlr;
	
	boolean EQ_ssn_nlr;
	boolean EN_ssn_nlr;
	boolean TN_ssn_nlr;
end;

temprec3 append_NLR(all_header le, header.key_nlr_payload rt) := transform
		Self.not_in_bureau := rt.not_in_bureau, 
		
		self.EQ_did_nlr := rt.not_in_bureau = header.constants.no_longer_reported.did_not_in_eq;
		self.EN_did_nlr := rt.not_in_bureau = header.constants.no_longer_reported.did_not_in_en;
		self.TN_did_nlr := rt.not_in_bureau = header.constants.no_longer_reported.did_not_in_tn;
		self.EQ_ssn_nlr := le.ssn=le.h.ssn and rt.not_in_bureau = header.constants.no_longer_reported.ssn_not_in_eq;
		self.EN_ssn_nlr := le.ssn=le.h.ssn and rt.not_in_bureau = header.constants.no_longer_reported.ssn_not_in_en;
		self.TN_ssn_nlr := le.ssn=le.h.ssn and rt.not_in_bureau = header.constants.no_longer_reported.ssn_not_in_tn;
		
		self := le;
end;

// for any records that have SSN on input we found it on 
with_NLR_roxie := JOIN (
	all_header(h.src in risk_indicators.iid_constants.bureau_sources),
	header.key_nlr_payload,
	keyed (Left.h.did = Right.did) and
	keyed (Left.h.rid = Right.rid),
	append_NLR(left, right),
		left outer,
	atmost(riskwise.max_atmost), keep(1));
  
with_NLR_thor := JOIN (
	DISTRIBUTE(all_header(h.src in risk_indicators.iid_constants.bureau_sources), HASH64(h.did, h.rid)),
	DISTRIBUTE(PULL(header.key_nlr_payload), HASH64(did, rid)),
	Left.h.did = Right.did and
	Left.h.rid = Right.rid,
	append_NLR(left, right),
		left outer,
	atmost(riskwise.max_atmost), keep(1), LOCAL);
  
#IF(onThor)
	with_NLR := with_NLR_thor;
#ELSE
	with_NLR := with_NLR_roxie;
#END
											
// output(with_NLR, named('with_NLR'));

temprec3 roll_nlr(temprec3 le, temprec3 rt) := transform
		self.EQ_did_nlr := le.EQ_did_nlr or rt.EQ_did_nlr ;
		self.EN_did_nlr := le.EN_did_nlr or rt.EN_did_nlr ;
		self.TN_did_nlr := le.TN_did_nlr or rt.TN_did_nlr ;
		self.EQ_ssn_nlr := le.EQ_ssn_nlr or rt.EQ_ssn_nlr ;
		self.EN_ssn_nlr := le.EN_ssn_nlr or rt.EN_ssn_nlr ;
		self.TN_ssn_nlr := le.TN_ssn_nlr or rt.TN_ssn_nlr ;
		self := rt;
end;

rolled_NLR := rollup(group(sort(with_NLR, did, h.rid), did), true, roll_nlr(left, right));
// output(rolled_NLR, named('rolled_NLR'));

with_NLR_flags_roxie := join(with_pii_on_file, rolled_NLR, left.did=right.did,
	transform(risk_indicators.layout_output,
		self.header_summary.EQ_did_nlr := right.EQ_did_nlr;
		self.header_summary.EN_did_nlr := right.EN_did_nlr;
		self.header_summary.TN_did_nlr := right.TN_did_nlr;
		self.header_summary.EQ_ssn_nlr := right.EQ_ssn_nlr;
		self.header_summary.EN_ssn_nlr := right.EN_ssn_nlr;
		self.header_summary.TN_ssn_nlr := right.TN_ssn_nlr;
		self := left), left outer, keep(1));
    
with_NLR_flags_thor := join(DISTRIBUTE(with_pii_on_file, HASH64(did)), 
                            DISTRIBUTE(rolled_NLR, HASH64(did)), 
                            left.did=right.did,
                            transform(risk_indicators.layout_output,
                              self.header_summary.EQ_did_nlr := right.EQ_did_nlr;
                              self.header_summary.EN_did_nlr := right.EN_did_nlr;
                              self.header_summary.TN_did_nlr := right.TN_did_nlr;
                              self.header_summary.EQ_ssn_nlr := right.EQ_ssn_nlr;
                              self.header_summary.EN_ssn_nlr := right.EN_ssn_nlr;
                              self.header_summary.TN_ssn_nlr := right.TN_ssn_nlr;
                              self := left), left outer, keep(1), LOCAL);
                              
#IF(onThor)
	with_NLR_flags := with_NLR_flags_thor;
#ELSE
	with_NLR_flags := with_NLR_flags_roxie;
#END                              
// output(with_NLR_flags, named('with_NLR_flags'));



// identify if the ssns on file belong to any of your relatives
		counts_per_ssn1 := table(all_header, {seq, historydate, did, ssn_from_did,
															_ssns_per_adl := count(group, ssns_per_adl>0),
															_ssns_per_adl_created_6months := count(group, ssns_per_adl_created_6months>0),
															_ssns_per_adl_seen_18months := count(group, ssns_per_adl_seen_18months>0),
															ssn_isRelative := false}, seq, historydate, did,  ssn_from_did);
															
		temprec2 := record
			counts_per_ssn1;
			unsigned6 wildcard_did;
			boolean isRelative;
		end;
					
		multiple_use_ssns_with_wildcard_did := join(counts_per_ssn1(_ssns_per_adl>1), dx_header.key_wild_SSN(),
			left.ssn_from_did<>'' and
			keyed(right.s1=left.ssn_from_did[1]) and
			keyed(right.s2=left.ssn_from_did[2]) and
			keyed(right.s3=left.ssn_from_did[3]) and
			keyed(right.s4=left.ssn_from_did[4]) and
			keyed(right.s5=left.ssn_from_did[5]) and
			keyed(right.s6=left.ssn_from_did[6]) and
			keyed(right.s7=left.ssn_from_did[7]) and
			keyed(right.s8=left.ssn_from_did[8]) and
			keyed(right.s9=left.ssn_from_did[9]) and
			left.did<>right.did,
				transform(temprec2, 
					self.wildcard_did := right.did, 
					self.isRelative := false,
					self := left),
						left outer,
						atmost(riskwise.max_atmost), keep(100));
		iids_dedp := dedup(sort(ungroup(multiple_use_ssns_with_wildcard_did)(did<>0),did), did);
		justDids := PROJECT(iids_dedp, 
			TRANSFORM(Relationship.Layout_GetRelationship.DIDs_layout, SELF.DID := LEFT.DID));
	  rellyids := Relationship.proc_GetRelationshipNeutral(justDids, TopnCount:=1,
	  RelativeFlag :=TRUE,AssociateFlag:=TRUE,doAtmost:=TRUE,MaxCount:=RiskWise.max_atmost,
		HighConfidenceRelatives := HighConfidenceRelatives_Value,
		HighConfidenceAssociates := HighConfidenceAssociates_Value,
		RelLookbackMonths := RelLookbackMonths_Value,
		doThor:=onThor).result;

		multiple_use_ssn_with_relative_flag := join(multiple_use_ssns_with_wildcard_did, rellyids, 
			left.did<>0 and
			left.did=right.did1 and right.did2=left.wildcard_did,
				transform(temprec2, 
					self.isRelative := left.wildcard_did<>0 and right.did2=left.wildcard_did, 
					self := left), 
						left outer);

		with_relative_flag := dedup(sort(multiple_use_ssn_with_relative_flag, seq, did, ssn_from_did, -isRelative), seq, did, ssn_from_did);

		counts_per_ssn := join(counts_per_ssn1, with_relative_flag, left.seq=right.seq and left.did=right.did and left.ssn_from_did=right.ssn_from_did,
			transform(recordof(counts_per_ssn1), self.ssn_isRelative := right.isRelative, self := left), left outer);
// end of relatives check														
ssn_counts_by_seq_did := table(counts_per_ssn, {seq, historydate, did, 
															ssns_per_adl := count(group, _ssns_per_adl>0),
															ssns_per_adl_multiple_use := count(group, _ssns_per_adl>1),
															ssns_per_adl_multiple_use_non_relative := count(group, _ssns_per_adl>1 and ssn_isRelative=false),
															ssns_per_adl_created_6months := count(group, _ssns_per_adl_created_6months>0),
															ssns_per_adl_seen_18months := count(group, _ssns_per_adl_seen_18months>0)}, seq, historydate, did);

sorted_dobs := group(sort(all_header, seq, did, -h.dob, -dobs_per_adl_created_6months, -dobs_per_adl, -dobcount2, hdr_dt_first_seen ), seq, did);

rolled_dobs := rollup(sorted_dobs, true, 
	transform(recordof(sorted_dobs),
    r_head_dob := (string)right.h.dob;
    l_head_dob := (string)left.h.dob;
		dob_match := left.h.dob=right.h.dob or 
								(r_head_dob[7..8]='00' and l_head_dob[1..6]=r_head_dob[1..6]) or
								(r_head_dob[5..8]='0000' and l_head_dob[1..4]=r_head_dob[1..4]);
		self.dobs_per_adl := iid_constants.capVelocity(left.dobs_per_adl + 
							IF(dob_match, 0, right.dobs_per_adl));
		self.dobs_per_adl_created_6months := iid_constants.capVelocity(left.dobs_per_adl_created_6months + 
											if(dob_match, 0, right.dobs_per_adl_created_6months));
		self := right));
		
		
rolled_ssns_dobs := join(ssn_counts_by_seq_did, rolled_dobs, 
	left.seq=right.seq and left.did=right.did,
	transform(iid_constants.layout_outx, 
		self.dobs_per_adl := right.dobs_per_adl;
		self.dobs_per_adl_created_6months := right.dobs_per_adl_created_6months;
		self := left, self := []));		

		
with_fraud_velocity := join(with_NLR_flags, rolled_ssns_dobs,
	left.seq=right.seq and left.did=right.did,
	transform(risk_indicators.layout_output,
		self.dobs_per_adl := right.dobs_per_adl;
		self.dobs_per_adl_created_6months := right.dobs_per_adl_created_6months;
		// just in case the adl_risk_table has lower numbers than counting the header records, cap these 2 fields at ssns_per_adl
		self.ssns_per_adl_multiple_use := if(left.ssns_per_adl < right.ssns_per_adl_multiple_use, left.ssns_per_adl, right.ssns_per_adl_multiple_use) ;
		self.ssns_per_adl_multiple_use_non_relative := if(left.ssns_per_adl < right.ssns_per_adl_multiple_use_non_relative, left.ssns_per_adl, right.ssns_per_adl_multiple_use_non_relative) ;													
		self := left), left outer);	


#if(_control.Environment.onThor_LeadIntegrity)
	return group(with_NLR_flags, seq);  // don't need the fraud velocity work if just running leadintegrity
#else
	return group(with_fraud_velocity, seq);
#end

end;
