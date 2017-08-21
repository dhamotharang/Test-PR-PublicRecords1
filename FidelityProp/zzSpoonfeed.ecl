 
//  Step 1 (of couse, i did this 10 times, with segment_str = 0-9

import LN_PropertyV2, doxie_ln, address, progressive_phone, ut, codes, Census_Data;
segment_str := '3';
segment := (integer)segment_str;
#workunit('name','RAIN'+segment_str)

version := 
// 'WithFares0309';
'WithFares' + ut.GetDate+'_'+segment_str;

debug := 
// true;
false;

multiplier := 
11000000;
// 50;

wbothseq := dataset(ut.foreign_dataland+'thor_data400::cemtemp::wbothseq_withfares20090319', FidelityProp.layouts.from_prop_fid, thor)
((unsigned)acctno >= (segment * multiplier) and 
 (unsigned)acctno < ((segment + 1) * multiplier)
)
;



//********************

// CALL PROGRESSIVE PHONES

//********************




layout_progressive_batch_in := progressive_phone.layout_progressive_batch_in;

layout_progressive_batch_in get_in(wbothseq l) := transform
  // clean_name := address.CleanPersonFML73(l.name__owner__1_1);
	// clean_addr := address.CleanAddress182(trim(l.address), trim(l.city) + ',' + trim(l.st) + ' ' + trim(l.zip));
	self.acctno := l.acctno;
	self.name_first := l.fname;
	self.name_middle := l.mname;
	self.name_last := l.lname;
	self.name_suffix := '';
	self.phoneno := '';//l.HomePhone;
	self.prim_range := l.prim_range;
	self.predir := l.predir;
	self.prim_name := l.prim_name;
	self.suffix := '';
	self.postdir := '';
	self.unit_desig := '';
	self.sec_range := l.sec_range;
	self.p_city_name := l.prop__city_1;
	self.st := l.prop__state_1;
	self.z5 := l.prop__zipcode_1[1..5];
	self.z4 := l.prop__zipcode_1[7..];
	self.ssn := '';//intformat((unsigned)l.ssn, 9, 1);
	self.dob := '';
	self := [];
end;

f_test_in := distribute(project(wbothseq, get_in(left))(z5 <> '' and prim_name <> ''), hash(acctno) % 200);


roxie_ip := '10.173.190.1-100:9876';  //dev 64
// roxie_ip := '10.173.219.1-102:9856';  //dev 32
// roxie_ip := 'roxiebatch.br.seisint.com:9856';
// roxie_ip := 'roxieqavip.br.seisint.com:9856';
//roxie_ip := 'roxiedevvip.sc.seisint.com:9876';
//roxie_ip := '10.173.195.5:9876';
//roxie_ip := '10.173.202.5:9876';
//roxie_ip := 'roxiedevvip.sc.seisint.com:9876';
	
layout_progressive_batch_out := progressive_phone.layout_progressive_batch_out;
	
insize := sizeof(layout_progressive_batch_in);	
outsize := sizeof(layout_progressive_batch_out);
		
//We want to use levels 1, 2, 3, and 6 (ES, SE, AP, PP)		
out_data := PIPE(f_test_in, 'roxiepipe -iw '+ insize +' -t 1 -ow '
				        + outsize +' -b 10 -mr 2 -q "'
				   	    + '<progressive_phone.progressive_phone_batch_service  format=\'raw\'>'
					      + '<DedupOutputPhones>true</DedupOutputPhones>' 
						    + '<MaxPhoneCount>1000</MaxPhoneCount>'
						    + '<CountType1_Es_EDASEARCH>1</CountType1_Es_EDASEARCH>' 
						    + '<CountType2_Se_SKIPTRACESEARCH>1</CountType2_Se_SKIPTRACESEARCH>' 
						    + '<CountType3_Ap_PROGRESSIVEADDRESSSEARCH>1</CountType3_Ap_PROGRESSIVEADDRESSSEARCH>' 
						    + '<CountType4_Sp_POSSIBLESPOUSE>0</CountType4_Sp_POSSIBLESPOUSE>' 
						    + '<CountType4_Md_POSSIBLEPARENTS>0</CountType4_Md_POSSIBLEPARENTS>' 
						    + '<CountType4_Cl_CLOSESTRELATIVE>0</CountType4_Cl_CLOSESTRELATIVE>' 
						    + '<CountType4_Cr_CORESIDENT>0</CountType4_Cr_CORESIDENT>' 
						    + '<CountType5_Sx_EXPANDEDSKIPTRACESEARCH>0</CountType5_Sx_EXPANDEDSKIPTRACESEARCH>' 
						    + '<CountType6_Pp_PHONESPLUSSEARCH>1</CountType6_Pp_PHONESPLUSSEARCH>' 
						    + '<CountType7_UNVERIFIEDPHONE>0</CountType7_UNVERIFIEDPHONE>' 
						    + '<CountType_Ne_CLOSESTNEIGHBOR>0</CountType_Ne_CLOSESTNEIGHBOR>' 
						    + '<CountType_Wk_PEOPLEATWORK>0</CountType_Wk_PEOPLEATWORK>' 
						    + '<CountType_Rl_POSSIBLERELOCATION>0</CountType_Rl_POSSIBLERELOCATION>' 
					      + '<batch_in id=\'id\' format=\'raw\'></batch_in>'
					      + '</progressive_phone.progressive_phone_batch_service>" -h ' 
					      + roxie_ip + ' -vip -r Results', layout_progressive_batch_out);


od_dist := distribute(out_data, hash(acctno));
od_srt := sort(od_dist, acctno, sort_order, record, local);
od_ddp := dedup(od_srt, acctno, local);
od_p := 
project(
	od_ddp,
	transform(
		FidelityProp.layouts.from_phone_plus,
		self.subj_first_1 := left.subj_first;
		self.subj_middle_1 := left.subj_middle;
		self.subj_last_1 := left.subj_last;
		self.subj_suffix_1 := left.subj_suffix;
		self.subj_phone10_1 := left.subj_phone10;
		self.subj_name__dual_1 := left.subj_name_dual;
		self.subj_phone_type_1 := left.subj_phone_type;
		self.subj_date_first_1 := left.subj_date_first;
		self.subj_date_last_1 := left.subj_date_last;
		self.acctno := left.acctno;
	)
);




//********************

// PUT TOGETHER THE PROPERTY AND PHONE INFO

//********************

j :=
join(
	wbothseq,
	od_p,
	left.acctno = right.acctno,
	transform(
		FidelityProp.layouts.out,
		self := right,
		self := left
	),
	left outer,
	hash
) : persist('cemtemp::persist::j3');

#if(debug)
output(cof, named('cof'));
output(cofD, named('cofD'));
output(cof1, named('cof1'));
output(wsearch0, named('wsearch0'));
output(wsearch, named('wsearch'));
output(wdeed, named('wdeed'));
output(wassess, named('wassess'));	
output(wboth, named('wboth'));	 
output(wtt, named('wtt'));	 
output(wtt_decode, named('wtt_decode'));	 
output(wcounty, named('wcounty'));	 
output(wbothseq, named('wbothseq'));	 
output(f_test_in, named('f_test_in'));
output(out_data, named('out_data'));
output(j, named('jj'));
#else

// a := output(wbothseq,,'~thor_data400::cemtemp::wbothseq_'+version, overwrite);
b := output(j,,'~thor_data400::cemtemp::j_'+version, overwrite);
c := 
output(
	j,,
	'~thor_data400::out::FidelityProp_'+version,
	csv(
		heading(
			'parcel-number_1,name-owner-1_1,name-owner-2_1,prop-address_1,prop-city_1,prop-state_1,prop-zipcode_1,total-value_1,sale-date_1,sale-price_1,name-seller_1,mortgage-amount_1,assessed-value_1,total-market-value_1,legal-description_1,parcel-number_2,name-owner-1_2,name-owner-2_2,prop-address_2,prop-city_2,prop-state_2,prop-zipcode_2,total-value_2,sale-date_2,sale-price_2,name-seller_2,mortgage-amount_2,assessed-value_2,total-market-value_2,legal-description_2,parcel-number_3,name-owner-1_3,name-owner-2_3,prop-address_3,prop-city_3,prop-state_3,prop-zipcode_3,total-value_3,sale-date_3,sale-price_3,name-seller_3,mortgage-amount_3,assessed-value_3,total-market-value_3,legal-description_3,parcel-number_4,name-owner-1_4,name-owner-2_4,prop-address_4,prop-city_4,prop-state_4,prop-zipcode_4,total-value_4,sale-date_4,sale-price_4,name-seller_4,mortgage-amount_4,assessed-value_4,total-market-value_4,legal-description_4,subj_first_1,subj_middle_1,subj_last_1,subj_suffix_1,subj_phone10_1,subj_name-dual_1,subj_phone_type_1,subj_date_first_1,subj_date_last_1'
			+'\n', 
			single
		),
		separator(','), 
		terminator('\n'), 
		quote('"')
	),
	overwrite
);

// sequential(a,b,c);
// sequential(b,c);
b;
// output(wbothseq);
// count(wbothseq);
// output(j)
#end








//  Step 2


md(s, ds) := macro
ds := dataset(ut.foreign_dataland + 'thor_data400::cemtemp::j_withfares20090325_' + s, FidelityProp.layouts.out, thor);
output(ds, named('segment' + s));
output(count(ds), named('count_segment' + s));
endmacro;

md26(s, ds) := macro
ds := dataset(ut.foreign_dataland + 'thor_data400::cemtemp::j_withfares20090326_' + s, FidelityProp.layouts.out, thor);
output(ds, named('segment' + s));
output(count(ds), named('count_segment' + s));
endmacro;

mp(s, ds) := macro
ds := dataset(ut.foreign_prod + 'thor_data400::cemtemp::j_withfares20090325_' + s, FidelityProp.layouts.out, thor);
output(ds, named('segment' + s));
output(count(ds), named('count_segment' + s));
endmacro;

mp26(s, ds) := macro
ds := dataset(ut.foreign_prod + 'thor_data400::cemtemp::j_withfares20090326_' + s, FidelityProp.layouts.out, thor);
output(ds, named('segment' + s));
output(count(ds), named('count_segment' + s));
endmacro;

md(0, ds0);
md(1, ds1);
md26(2, ds2);
md26(3, ds3);
md26(4, ds4);

md26(5, ds5);
mp26(6, ds6);
mp26(7, ds7);
mp(8, ds8);
mp(9, ds9);

allem := ds0 + ds1 + ds2 + 
ds3 + ds4 + 
ds5 +
ds6 + ds7 + ds8 + ds9;

output(count(allem), named('count_allem'));
output(count(dedup(allem, record, all)), named('count_dedup_allem'));

set_zip5 := ['80209','78722','80218'];

// set_addr := ['550 S WASHINGTON ST', '4204 BRADWOOD RD', '1090 S LAFAYETTE ST'];
set_addr := ['550 S WASH', '4204 BRADW', '1090 S LAF', '1090 S. LA'];

Set_parcel__number_1:=[
'05022-38-045                                 ','05022-38-021-021                             ',
'5022-38-022                                  ','05022-38-023                                 ','05022-38-024-024                             ',
'05022-38-025-025                             ','05022-38-026                                 ','05022-38-027                                 ',
'05022-38-028-028                             ','05022-38-029                                 ','05022-38-030-030                             ',
'05022-38-031-031                             ','05022-38-032-032                             ','05022-38-033-033                             ',
'05022-38-034                                 ','05022-38-035-035                             ','05022-38-036-036                             ',
'05022-38-037-037                             ','05022-38-038                                 ','05022-38-039-039                             ',
'05022-38-040-040                             ','05022-38-041-041                             ','05022-38-042                                 ',
'05022-38-043-043                             ','05022-38-044-044                             ',
'05022-38-046-046                             ','05022-38-047                                 ','05022-38-048-048                             ',
'05022-38-049-049                             ','05022-38-050-050                             ','05022-38-051-051                             ',
'02-1811-09-03-0000                           ','05112-01-044-000                             ','05151-17-010-000                             '];



output(choosen(allem(parcel__number_1 in Set_parcel__number_1), 1000), named('allem_sample'));

output(allem,,'thor_data400::cemtemp::j_withfares20090326_all',overwrite);
