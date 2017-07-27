import ut,lib_stringlib;
us_list := ['US', 'U S', 'UNITED STATES'];

export CS100S := MODULE

// made this a non-inline function and applied the 'define' keyword
// reduces size of generated code significantly per Gavin
  export CURRENT(string40 indic_l, string40 sec_l, string40 indic_r, string40 sec_r) := define function
    res := MAP(indic_l='' and indic_r='' and sec_l='' and sec_r='' => 1000,
      indic_l = indic_r and (indic_l in us_list or indic_l in ut.Set_State_Names) =>
        (ut.stringsimilar100(indic_l,indic_r) + ut.stringsimilar100(sec_l,sec_r)) * 2,      
      indic_l='' and indic_r='' => ut.stringsimilar100(sec_l,sec_r) * 4,
      sec_l='' and sec_r='' => ut.stringsimilar100(indic_l,indic_r) * 4,
     (ut.stringsimilar100(indic_l,indic_r) * 3 + ut.stringsimilar100(sec_l,sec_r))) div 4;
	  return res;
  END;

	// ----- 'NEW' function below -----
	
	SHARED no_the(STRING40 ll) := IF(ll[1..4]='THE ', ll[5..40], ll);
	
	SHARED statename2abbr(STRING s) :=
		FUNCTION
			 s1 := StringLib.StringFindReplace(  s, 'ALABAMA', 'AL');
			 s2 := StringLib.StringFindReplace( s1, 'ALASKA', 'AK');
			 s3 := StringLib.StringFindReplace( s2, 'ARKANSAS', 'AR');
			 s4 := StringLib.StringFindReplace( s3, 'AMERICAN SAMOA', 'AS');
			 s5 := StringLib.StringFindReplace( s4, 'ARIZONA', 'AZ');
			 s6 := StringLib.StringFindReplace( s5, 'CALIFORNIA', 'CA');
			 s7 := StringLib.StringFindReplace( s6, 'COLORADO', 'CO');
			 s8 := StringLib.StringFindReplace( s7, 'CONNECTICUT', 'CT');
			 s9 := StringLib.StringFindReplace( s8, 'DISTRICT OF COLUMBIA', 'DC');
			s10 := StringLib.StringFindReplace( s9, 'DELAWARE', 'DE');
			s11 := StringLib.StringFindReplace(s10, 'FLORIDA', 'FL');
			s12 := StringLib.StringFindReplace(s11, 'GEORGIA', 'GA');
			s13 := StringLib.StringFindReplace(s12, 'GUAM', 'GU');
			s14 := StringLib.StringFindReplace(s13, 'HAWAII', 'HI');
			s15 := StringLib.StringFindReplace(s14, 'IOWA', 'IA');
			s16 := StringLib.StringFindReplace(s15, 'IDAHO', 'ID');
			s17 := StringLib.StringFindReplace(s16, 'ILLINOIS', 'IL');
			s18 := StringLib.StringFindReplace(s17, 'INDIANA', 'IN');
			s19 := StringLib.StringFindReplace(s18, 'KANSAS', 'KS');
			s20 := StringLib.StringFindReplace(s19, 'KENTUCKY', 'KY');
			s21 := StringLib.StringFindReplace(s20, 'LOUISIANA', 'LA');
			s22 := StringLib.StringFindReplace(s21, 'MASSACHUSETTS', 'MA');
			s23 := StringLib.StringFindReplace(s22, 'MARYLAND', 'MD');
			s24 := StringLib.StringFindReplace(s23, 'MAINE', 'ME');
			s25 := StringLib.StringFindReplace(s24, 'MICHIGAN', 'MI');
			s26 := StringLib.StringFindReplace(s25, 'MINNESOTA', 'MN');
			s27 := StringLib.StringFindReplace(s26, 'MISSOURI', 'MO');
			s28 := StringLib.StringFindReplace(s27, 'MISSISSIPPI', 'MS');
			s29 := StringLib.StringFindReplace(s28, 'MONTANA', 'MT');
			s30 := StringLib.StringFindReplace(s29, 'NORTH CAROLINA', 'NC');
			s31 := StringLib.StringFindReplace(s30, 'NORTH DAKOTA', 'ND');
			s32 := StringLib.StringFindReplace(s31, 'NEBRASKA', 'NE');
			s33 := StringLib.StringFindReplace(s32, 'NEW HAMPSHIRE', 'NH');
			s34 := StringLib.StringFindReplace(s33, 'NEW JERSEY', 'NJ');
			s35 := StringLib.StringFindReplace(s34, 'NEW MEXICO', 'NM');
			s36 := StringLib.StringFindReplace(s35, 'NEVADA', 'NV');
			s37 := StringLib.StringFindReplace(s36, 'NEW YORK', 'NY');
			s38 := StringLib.StringFindReplace(s37, 'OHIO', 'OH');
			s39 := StringLib.StringFindReplace(s38, 'OKLAHOMA', 'OK');
			s40 := StringLib.StringFindReplace(s39, 'OREGON', 'OR');
			s41 := StringLib.StringFindReplace(s40, 'PENNSYLVANIA', 'PA');
			s42 := StringLib.StringFindReplace(s41, 'PUERTO RICO', 'PR');
			s43 := StringLib.StringFindReplace(s42, 'RHODE ISLAND', 'RI');
			s44 := StringLib.StringFindReplace(s43, 'SOUTH CAROLINA', 'SC');
			s45 := StringLib.StringFindReplace(s44, 'SOUTH DAKOTA', 'SD');
			s46 := StringLib.StringFindReplace(s45, 'TENNESSEE', 'TN');
			s47 := StringLib.StringFindReplace(s46, 'TEXAS', 'TX');
			s48 := StringLib.StringFindReplace(s47, 'UNITED STATES', 'US');
			s49 := StringLib.StringFindReplace(s48, 'UTAH', 'UT');
			s50 := StringLib.StringFindReplace(s49, 'VIRGINIA', 'VA');
			s51 := StringLib.StringFindReplace(s50, 'VIRGIN ISLANDS', 'VI');
			s52 := StringLib.StringFindReplace(s51, 'VERMONT', 'VT');
			s53 := StringLib.StringFindReplace(s52, 'WASHINGTON', 'WA');
			s54 := StringLib.StringFindReplace(s53, 'WISCONSIN', 'WI');
			s55 := StringLib.StringFindReplace(s54, 'WEST VIRGINIA', 'WV');
			s56 := StringLib.StringFindReplace(s55, 'WYOMING', 'WY');
			
			RETURN s56;
		END;
		
	SHARED 	get_score_multiplier(STRING40 searchExp_untrimmed, STRING40 candidateExp_untrimmed) :=
		FUNCTION
			STRING searchExp    := TRIM(searchExp_untrimmed,LEFT,RIGHT);
			STRING candidateExp := TRIM(candidateExp_untrimmed,LEFT,RIGHT);
			
			RETURN 
				MAP(
					searchExp = candidateExp                             => 0,
					StringLib.StringFind(candidateExp, searchExp, 1) = 1 => 1,
					StringLib.StringFind(candidateExp, searchExp, 1) > 1 => 2,
					/* Default--strings are dissimilar.................: */ 4
				);					
		END;
		
	// Evaluate each part of company name, cleaned. Then add scores and return. NOTE that sec words
	// are being weighted the same as indic words. The straight_compare accounts for the odd cleaning 
	// behavior where input 'ENTERPRISE ASSOCIATES' = indic, but corp_legal_name 'INTEGRITY ENTERPRISE 
	// ASSOCIATES' is split into 'INTEGRITY' = indic and 'ENTERPRISE ASSOCIATES' = furn.
			
  EXPORT NEW(STRING40 pre_indic_l = '', STRING40 sec_l = '',  
	           STRING40 pre_indic_r = '', STRING40 sec_r = '', 
						 STRING120 pre_l = '', STRING120 pre_r = ''
					) := 
		DEFINE FUNCTION

			// Remove the leading article "THE"; should be irrelevant in matching.			
			indic_l_clean_1 := no_the(pre_indic_l);
			indic_r_clean_1 := no_the(pre_indic_r);
			l_clean_1       := no_the(pre_l);
			r_clean_1       := no_the(pre_r);

			// Convert state names to abbreviations.
			indic_l_clean_2 := statename2abbr(indic_l_clean_1);
			indic_r_clean_2 := statename2abbr(indic_r_clean_1);
			l_clean_2       := statename2abbr(l_clean_1);
			r_clean_2       := statename2abbr(r_clean_1);
			
			// Standardize ampersands
			indic_l_clean_3 := StringLib.StringFindReplace(indic_l_clean_2, '&', ' ');
			indic_r_clean_3 := StringLib.StringFindReplace(indic_r_clean_2, '&', ' ');
			l_clean_3       := StringLib.StringFindReplace(l_clean_2, '&', 'AND');
			r_clean_3       := StringLib.StringFindReplace(r_clean_2, '&', 'AND');
			
			indic_l := indic_l_clean_3;
			indic_r := indic_r_clean_3;
			l       := l_clean_3;
			r       := r_clean_3;
			
			indic_score_mult := get_score_multiplier(indic_l,indic_r);
			sec_score_mult   := get_score_multiplier(sec_l,sec_r);
			
			// Use some conditionals to avoid needless calls to stringsimilar().
			indic_score := IF( indic_score_mult = 0, 0, indic_score_mult * ut.stringsimilar100(indic_l,indic_r) );
			sec_score   := IF( sec_score_mult = 0, 0, sec_score_mult * ut.stringsimilar100(sec_l,sec_r) );
			added_score := indic_score + sec_score; 
			
			score := IF(	((indic_l='' and sec_l='') OR (indic_r='' and sec_r='')), 1000, added_score );
			
			straight_compare := ut.stringsimilar100(l,r) * 4;
			
			RETURN MIN(score,straight_compare) DIV 2; // 'DIV 2' ==> tuning
			
		END;

END;

