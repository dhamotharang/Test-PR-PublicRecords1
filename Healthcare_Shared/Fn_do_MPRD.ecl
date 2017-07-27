import Healthcare_Shared;
EXPORT Fn_do_MPRD := MODULE
	//This module is for MPRD Specific functions
	Export decodeGender (unsigned2 code) := function
		return map(code=0 => '', //Unknown
							 code=1 => 'MALE', //Male Strong (high confidence that the person is male)
							 code=2 => 'MALE', //Male Weak (some confidence that the person is male)
							 code=3 => '', //Gender Ambiguous (not sure if gender is male or female)
							 code=4 => 'FEMALE', //Female Weak (name does not reliably indicate either gender)
							 code=5 => 'FEMALE', //Female Strong (some confidence that the person is female)
							'');
	end;
	//Build stat Detail decodes that can be implemented in Validations
	// Export getStatTable(integer inVal) := function
		// tmplayout := record
			// integer seq;
			// integer keyVal;
			// integer remain;
			// boolean match;
		// end;
		// myflagset := dataset([{1,2147483648,0,false},{2,1073741824,0,false},{3,536870912,0,false},{4,268435456,0,false},
											// {5,134217728,0,false},{6,67108864,0,false},{7,33554432,0,false},{8,16777216,0,false},
											// {9,8388608,0,false},{10,4194304,0,false},{11,2097152,0,false},{12,1048576,0,false},
											// {13,524288,0,false},{14,262144,0,false},{15,131072,0,false},{16,65536,0,false},{17,32768,0,false},
											// {18,16384,0,false},{19,8192,0,false},{20,4096,0,false},{21,2048,0,false},{22,1024,0,false},
											// {23,512,0,false},{24,256,0,false},{25,128,0,false},{26,64,0,false},{27,32,0,false},{28,16,0,false},
											// {29,8,0,false},{30,4,0,false},{31,2,0,false},{32,1,0,false}],tmplayout);	
		// tmplayout T(tmplayout L, tmplayout R) := TRANSFORM
			// checkVal := if(r.seq=1,inVal,l.remain);
			// setflag := r.keyVal <= checkVal;
			// SELF.remain := if(setflag,checkVal-r.keyval,checkval);
			// self.match := setflag;
			// SELF := r;
		// END;
		// myResultSet := iterate(myflagset,t(left,right));
		// return myResultSet(match=true);
	// end;
	// Export EvaluateStat(integer inVal, integer ExistsVal) := function
		// myResultSet := getStatTable(inVal);
		// myResult := exists(myResultSet(keyVal=ExistsVal));
		// return myResult;
	// end;
	/*Export getClassificationinfo(DATASET(Healthcare_Shared.Layouts.CombinedHeaderResults) allRows) := function
		//ApplyFilter may not be necessary, since Enclarity DataPrep has already performed validations
		//Changed Dataset set_IncludeTaxonomy_ENC = set_FC_NPI
		getTaxonomies:=NORMALIZE(allRows(subSrc NOT IN Healthcare_Shared.SourceTools.set_ExcludeTaxonomy_ENC),LEFT.Taxonomy(TaxonomyCode<>''),TRANSFORM(Healthcare_Shared.Layouts.layout_taxonomy,
		self.bestsource:=if(left.subSrc in Healthcare_Shared.SourceTools.set_FC_NPI,1,Healthcare_Shared.Constants.DEFAULT_BESTSCORE),SELF := RIGHT));
		ApplyFilter_Taxonomy := project(getTaxonomies, transform(Healthcare_Shared.Layouts.layout_taxonomy,
																						SkipRow := EvaluateStat(left.taxonomy_stat,Healthcare_Shared.Constants.notConfigured) or 
																												EvaluateStat(left.taxonomy_stat,Healthcare_Shared.Constants.configuredButBlank) or 
																												EvaluateStat(left.taxonomy_stat,Healthcare_Shared.Constants.valueInvalid) or 
																												EvaluateStat(left.taxonomy_stat,Healthcare_Shared.Constants.valueTooLong) or 
																												EvaluateStat(left.taxonomy_stat,Healthcare_Shared.Constants.notConfigured) or 
																												EvaluateStat(left.taxonomy_stat,Healthcare_Shared.Constants.valueTooLongSetToNull);
																						self.TaxonomyCode := if(skiprow,skip,left.TaxonomyCode);
																						self :=left;)); 
		
		finalSort_Taxonomy := sort(dedup(sort(ApplyFilter_Taxonomy,taxonomycode,bestsource,-PrimaryIndicator),taxonomycode),bestsource,-PrimaryIndicator);
		//output(allRows,named('allRows'));
		// output(getTaxonomies,named('getTaxonomies'));
		// output(ApplyFilter_Taxonomy,named('ApplyFilter_Taxonomy'));
		// output(finalSort_Taxonomy,named('finalSort_Taxonomy'));
		return finalSort_Taxonomy;
	end;*/
 end;	