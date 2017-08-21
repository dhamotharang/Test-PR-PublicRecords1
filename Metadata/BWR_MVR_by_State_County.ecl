//MVR by State County, edited from MVR.ecl by John J. Bulten 20070516

dDev :=	vehlic.File_Base_Vehicles_Dev;

rDev
 :=
  record
	dDev.orig_state;
	dDev.mh_county_code;
	dDev.own_1_residence_county;
	dDev.reg_1_residence_county;
	dDev.lh_1_residence_county;
	dDev.own_1_county;
	dDev.reg_1_county;
	unsigned8	Total	:=	count(group);
  end
 ;

sort1 := sort(table(dDev,{orig_state,mh_county_code,count(group)},orig_state,mh_county_code,few),orig_state,mh_county_code);
sort2 := sort(table(dDev,{orig_state,own_1_residence_county,count(group)},orig_state,own_1_residence_county,few),orig_state,own_1_residence_county);
sort3 := sort(table(dDev,{orig_state,reg_1_residence_county,count(group)},orig_state,reg_1_residence_county,few),orig_state,reg_1_residence_county);
sort4 := sort(table(dDev,{orig_state,lh_1_residence_county,count(group)},orig_state,lh_1_residence_county,few),orig_state,lh_1_residence_county);
sort5 := sort(table(dDev,{orig_state,own_1_county,count(group)},orig_state,own_1_county,few),orig_state,own_1_county);
sort6 := sort(table(dDev,{orig_state,reg_1_county,count(group)},orig_state,reg_1_county,few),orig_state,reg_1_county);

output(sort1,all);
output(sort2,all);
output(sort3,all);
output(sort4,all);
output(sort5,all);
output(sort6,all);