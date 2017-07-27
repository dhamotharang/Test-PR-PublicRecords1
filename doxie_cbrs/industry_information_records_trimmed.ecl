import doxie_cbrs, ut;

export industry_information_records_trimmed(dataset(doxie_cbrs.layout_references) bdids) := 
MODULE

doxie_cbrs.mac_Selection_Declare()

iirs := doxie_cbrs.industry_information_records(bdids)(Include_IndustryInfo_val);
e5600iirs := if(NOT doxie.DataRestriction.EBR,doxie_cbrs.industry_information_EBR_5600_records(bdids)(Include_IndustryInfo_val));
e0010iirs := if(NOT doxie.DataRestriction.EBR,doxie_cbrs.industry_information_EBR_0010_records(bdids)(Include_IndustryInfo_val));

// Uncomment below as needed for debugging
//output(Include_IndustryInfo_val,  named('iirt_include_ii_val'));
//output(doxie.DataRestriction.EBR, named('iirt_ddr_ebr'));

ii_rec := RECORD
	unsigned6 bdid;
	string4  sic_code;
	string97 sic_descriptions;
END;



ii_rec ii_transform(iirs L,unsigned1 cnt) := TRANSFORM
  SELF.bdid := L.bdid;
	SELF.sic_code := MAP(cnt = 1 => L.sic1,
						  cnt = 2 => L.sic2,
						  cnt = 3 => L.sic3,
						  cnt = 4 => L.sic4,
						  cnt = 5 => L.sic5,
						  cnt = 6 => L.sic6,
						  cnt = 7 => L.sic7,
						  cnt = 8 => L.sic8,
						  cnt = 9 => L.sic9,
						  cnt = 10 => L.sic10,
						  '');																											  
	SELF.sic_descriptions := MAP(cnt = 1 => L.text1,
								 cnt = 2 => L.text2,
								 cnt = 3 => L.text3,
								 cnt = 4 => L.text4,
								 cnt = 5 => L.text5,
								 cnt = 6 => L.text6,
								 cnt = 7 => L.text7,
								 cnt = 8 => L.text8,
								 cnt = 9 => L.text9,
								 cnt = 10 => L.text10,
								 '');
END;

ii_rec e5600ii_transform(e5600iirs L,unsigned1 cnt) := TRANSFORM
	SELF.bdid := L.bdid;
	SELF.sic_code := MAP(cnt = 1 => L.sic_1_code,
						  cnt = 2 => L.sic_2_code,
						  cnt = 3 => L.sic_3_code,
						  cnt = 4 => L.sic_4_code,
						  ''); 					
	SELF.sic_descriptions := MAP(cnt = 1 => L.sic_1_desc,
								 cnt = 2 => L.sic_2_desc,
								 cnt = 3 => L.sic_3_desc,
								 cnt = 4 => L.sic_4_desc,
								 '');
END;

ii_rec e0010ii_transform(e0010iirs L,unsigned1 cnt) := TRANSFORM
  SELF.bdid := L.bdid;	
	SELF.sic_code := MAP(cnt = 1 => L.sic_code,'');  						
	SELF.sic_descriptions := MAP(cnt = 1 => L.business_desc,'');
END;

// this transform/rollup will remove any duplicate sic code descriptions that have same sic code but are
// all uppercase in the description.
//											 
lowercaseAlphabet := stringlib.stringtolowercase(ut.alphabet);

ii_rec   xform_transform(ii_rec l, ii_rec r) := TRANSFORM
  stringOfLittleCharsLeft :=  stringlib.stringfilter(l.sic_descriptions,lowercaseAlphabet);
  boolean useLeft	 := length(trim(stringOfLittleCharsLeft, left, right)) > 0;
  self.bdid := if (useLeft, l.bdid,  r.bdid); 	                 
	self.sic_descriptions := if (useleft, l.sic_descriptions, r.sic_descriptions);
	self.sic_code := l.sic_code; // will always be same as right
end;
// important to sort on sic_code before the rollup

shared norm_results := rollup(sort(
                       normalize(iirs,10,ii_transform(left,counter)) +
                       normalize(e5600iirs,4,e5600ii_transform(left,counter)) +
								       normalize(e0010iirs,1,e0010ii_transform(left,counter)), sic_code),
											  left.sic_code = right.sic_code
												,xform_transform(left,right));
												
ii_rec2 := RECORD
	string4  sic_code;
	string97 sic_descriptions;
END;


// Do a project to get rid of the bdid, then dedup it.
shared norm_results_nobdid       := project(norm_results,transform(ii_rec2,self := left));
shared dedup_norm_results_nobdid := dedup(norm_results_nobdid(sic_code <> ''),sic_code,sic_descriptions,ALL);

// Dedup the temp ds that has bdids
shared dedup_norm_results := dedup(norm_results(bdid <> 0 and sic_code <>''),bdid,sic_code,sic_descriptions,ALL);

// Uncomment as needed for debugging
//output(iirs,                named('iirt_iirs'));
//output(e5600iirs,           named('iirt_e5600_iirs'));
//output(e5600iirs,           named('iirt_e5600_iirs'));
// output(iirs_5600, named('iirs_5600'));
//output(e0010iirs, named('e0010iirs'));
//output(norm, named('norm'));
// output(norm_results,        named('iirt_nr'));
//output(tmp_56, named('norm_results56'));
// output(norm_results_nobdid, named('iirt_nr_nb'));
// output(dedup_norm_results_nobdid, named('iirt_dd_nr_nb'));
//output(dedup_norm_results,        named('iirt_dd_nr'));

doxie_cbrs.mac_Selection_Declare()

shared unsigned3 saved_max_IndustryInfo_val := Max_IndustryInfo_Val;

export records := choosen(dedup_norm_results_nobdid,saved_Max_IndustryInfo_val);
export records_count := count(dedup_norm_results_nobdid);
export records_with_bdids := choosen(dedup_norm_results,saved_Max_IndustryInfo_val);

END;