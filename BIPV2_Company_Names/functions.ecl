/*2015-07-17T19:07:13Z (Harrison Sun)
RR Bug: 182234 - LINKING: BIP Sprint 29 Build
*/
import ut,SALT28,STD;
export functions := MODULE
export classify(dataset(BIPV2_Company_Names.layouts.layout_names) names) :=
FUNCTION
	n :=
	project(  //this probably needs to be a join or something
		names,
		transform(
			BIPV2_Company_Names.layouts.layout_names,
			self.cnp_classid := if(stringlib.stringfind(left.cnp_name, 'HOSPITAL', 1) > 0 and stringlib.stringfind(left.cnp_name, 'HOSPITALITY', 1) = 0, 1, left.cnp_classid), //NOT RIGHT
			self := left
		)
	);
	return n;
END;
export seq(dataset(BIPV2_Company_Names.layouts.layout_names) names) :=
FUNCTION
	p :=
	project(
		names,
		transform(
			BIPV2_Company_Names.layouts.layout_names,
			self.cnp_nameid := counter,
			self := left
		)
	);
	return p;
END;
export norm(dataset(BIPV2_Company_Names.layouts.layout_names) names) :=
FUNCTION
  numpos (string w)    := stringlib.stringfind(w,regexfind('[0-9]',w,0),1);
	alphapos (string w)  := stringlib.stringfind(w,regexfind('[A-Z]',w,0),1);
	cleanword (string w) := MAP(ut.isNumeric(w[numpos(w)..]) and numpos(w) > 1 and w[alphapos(w)-1] <> ' ' and length(w) > 2 => w[1..numpos(w)-1] + ' ' + w[numpos(w)..],
	                            ut.isNumeric(w[1..alphapos(w)-1]) and w[alphapos(w)-1] <> ' ' and alphapos(w) > 2 => w[1..alphapos(w)-1] + ' ' + w[alphapos(w)..],
															w);
  stringpos (string str, string1 c, integer nbr)            := stringlib.StringFind(str,c,nbr);
	cleanword1 (string str, integer i) := 	MAP(i=0 => cleanword(str),
                                             str = 'A-1' => 'A1',
																						 str = '1-800' => '1800',
																						 cleanword(str[1..4]) = '1-A-' => '1A ' + cleanword(str[5..]) ,
																						 //cleanword(str[1..i-1]) IN ['L.L.C','L.L.C.','LLC'] => 'LLC' + ' ' + cleanword(str[i+1..]),
																						 //cleanword(str[1..i-1]) IN ['L.L.P','L.L.P.','LLP'] => 'LLP' + ' ' + cleanword(str[i+1..]),
                                             //cleanword(str[i+1..]) IN ut.Set_State_Names  => cleanword(str[1..i-1]) + ' ' + cleanword(str[i+1..]),
																						 cleanword(str[i+1..]) IN ut.Set_State_Abbrev => cleanword(str[1..i-1]) + ' ' + cleanword(str[i+1..]),
																						 ut.isNumeric(str[i-1]) => cleanword(str[1..i-1]) + ' ' + cleanword(str[i+1..]),
																						 ut.isNumeric(str[i+1]) => cleanword(str[1..i-1]) + ' ' + cleanword(str[i+1..]),
												                     cleanword(str[1..i-1]) + cleanword(str[i+1..]));
	n :=
	normalize(
		names,
		STD.Str.CountWords(left.cnp_name, ' '),
		transform(
			BIPV2_Company_Names.layouts.layout_words,
			self.seq := counter,
			word     := ut.Word(left.cnp_name, counter, ' ');
			hcount   := stringlib.StringFindCount(word,'-');
			hpos (string w) := stringpos(w,'-',1);
			lpos  := stringpos(word,'(',1);
			rpos := stringpos(word,')',1);
			len := length(word);
			clean1 := cleanword1(word,hpos(word));
			clean2 := cleanword1(clean1,hpos(clean1));
			clean3 := cleanword1(clean2,hpos(clean2));
			clean4 := cleanword1(clean3,hpos(clean3));
			cleaned      := MAP(word = '-'       => '',
			                    hpos(word) = 1   => cleanword(word[2..]),
			                    hcount = 4       => clean4,
													hcount = 3       => clean3,
													hcount = 2       => clean2,
													hcount = 1       => clean1,
													ut.isNumeric(word[lpos+1..rpos-1]) => IF(len > rpos,
													                                         word[lpos+1..rpos-1] + ' ' + word[rpos+1..],
																																	 word[lpos+1..rpos-1]),
												  cleanword(word));
			self.word := cleaned,
			self := left
		)
	);
	return n;
END;
export simple_norm(dataset(BIPV2_Company_Names.layouts.layout_names) names) :=
FUNCTION
	n :=
	normalize(
		names,
		//ut.NoWords(left.cnp_name, ' '),
		STD.Str.CountWords(left.cnp_name, ' '),
		transform(
			BIPV2_Company_Names.layouts.layout_words,
			self.seq := counter,
			self.word := ut.Word(left.cnp_name, counter, ' '),
			self := left
		)
	);
	return n;
END;
export denorm(dataset(BIPV2_Company_Names.layouts.layout_words) words, boolean useAlphabeticalOrder = false) :=
FUNCTION
  //this little function just handles spacing when words get added together in the rollup
	f(string ls, string rs) := trim(ls) + if(ls <> '', ' ','') + trim(rs);
  //Store Number - Project into names2 layout
	p1 :=
	project(
		sort(words, cnp_nameid, seq, local),
		transform(
			BIPV2_Company_Names.layouts.layout_names2,
			//if a word was marked as extracted, take it out of the name and into the extraction field
			self.cnp_number := if(left.extracted_number, ut.rmv_ld_zeros(stringlib.stringfilter(left.word,'0123456789')), ''),
			self.cnp_store_number := if(left.extracted_store_number, ut.rmv_ld_zeros(stringlib.stringfilter(left.word,'0123456789')), ''),
			self.cnp_btype := if(left.extracted_btype, left.word, ''),
			self.cnp_lowv := if(left.extracted_lowv or left.extracted_store_prefix, left.word, ''),
			self.cnp_name := if(~(left.extracted_btype or left.extracted_lowv or left.extracted_store_number or left.extracted_store_prefix),
			                    left.word,''),
			self.cnp_name_trunc := if(~(left.extracted_btype or left.extracted_lowv or left.extracted_store_number or left.extracted_store_prefix or
			                      left.extracted_of_clause),
			                    left.word,''),
			self := left
		)
	);
  //Store Number - Sort into correct order based on passed alphabetical flag
	s1 := if(useAlphabeticalOrder,sort(p1,cnp_nameid,cnp_name,local),p1);
	//Store Number - Rollup words into cnp_name for store numbers in requested order;
	r1 := rollup(
		s1,
		left.cnp_nameid = right.cnp_nameid,
		transform(
			BIPV2_Company_Names.layouts.layout_names2,
			self.cnp_name := f(left.cnp_name, right.cnp_name);
			self := left
		),
		local
	);
  //Store Number - Rollup p1 file into names2 structure
	r2 :=
	rollup(
		sort(p1, cnp_nameid, cnp_name, local), //sorted into alphabetical order for Store Number matching
		left.cnp_nameid = right.cnp_nameid,
		transform(
			BIPV2_Company_Names.layouts.layout_names2,
			self.cnp_number := f(left.cnp_number, right.cnp_number),
			self.cnp_store_number := f(left.cnp_store_number, right.cnp_store_number),
			self.cnp_btype := f(left.cnp_btype, right.cnp_btype),
			self.cnp_lowv := f(left.cnp_lowv, right.cnp_lowv),
			self.cnp_name := f(left.cnp_name, right.cnp_name),
			self.cnp_name_trunc := f(left.cnp_name_trunc, right.cnp_name_trunc),
			self.cnp_translated := left.cnp_translated or right.cnp_translated,
			self := left
		),
		local
	);
	//Store Number  - Match to store number table
  j1 :=
	join(
		r2,
		// BIPV2_Company_Names.files.StrNbr_SF_DS,
    BIPV2_Company_Names.files.Company_StoreNbr_Names,
		left.cnp_name_trunc = right.cnp_name,
		transform(
			BIPV2_Company_Names.layouts.layout_names2,
      self := left
		),
		lookup
	);
	//Store Number = Join in cnp_name in correct order from above
	j2 :=
	join(
	 j1,r1,
	 left.cnp_nameid = right.cnp_nameid,
	 transform(
	   BIPV2_Company_Names.layouts.layout_names2,
		 self.cnp_name := right.cnp_name,
		 self := left),
		 local);
  //Project into names layout
	p2 :=
	project(
		if(
			useAlphabeticalOrder,
			sort(words, cnp_nameid, word, local),//this for rollup into alphabetical order
			sort(words, cnp_nameid, seq, local)  //this for rollup into original order
		),
		transform(
			BIPV2_Company_Names.layouts.layout_names,
			//if a word was marked as extracted, take it out of the name and into the extraction field
			self.cnp_number := if(left.extracted_number or left.extracted_store_number, ut.rmv_ld_zeros(stringlib.stringfilter(left.word,'0123456789')), ''),
			self.cnp_btype := if(left.extracted_btype, left.word, ''),
			self.cnp_lowv := if(left.extracted_lowv, left.word, ''),
			self.cnp_name := if(~(left.extracted_btype or left.extracted_lowv), left.word, ''),
			self := left
		)
	);
  //Rollup p2 into names layout
	r3 :=
	rollup(
		p2,//sorted above
		left.cnp_nameid = right.cnp_nameid,
		transform(
			BIPV2_Company_Names.layouts.layout_names,
			self.cnp_number := f(left.cnp_number, right.cnp_number);
			lenl := length(trim(left.cnp_btype));
			lenr := length(trim(right.cnp_btype));
			start_pos_last_lword := (lenl-lenr)+1;
			self.cnp_btype := if(left.cnp_btype[start_pos_last_lword..] = right.cnp_btype and left.cnp_btype[start_pos_last_lword-1]=' ', left.cnp_btype, f(left.cnp_btype, right.cnp_btype));
			self.cnp_lowv := f(left.cnp_lowv, right.cnp_lowv);
			self.cnp_name := f(left.cnp_name, right.cnp_name);
			self.cnp_translated := left.cnp_translated or right.cnp_translated;
			self := left
		),
		local
	);
  //Merge in store number fields if found on store number table
  j3 :=
	join(
		r3,
		j2,
		left.cnp_nameid = right.cnp_nameid,
		transform(
			BIPV2_Company_Names.layouts.layout_names,
      self.cnp_store_number := IF(right.cnp_name = '','',right.cnp_store_number),
			self.cnp_number       := IF(right.cnp_name = '',left.cnp_number,right.cnp_number),
			self.cnp_lowv         := IF(right.cnp_name = '',left.cnp_lowv,right.cnp_lowv),
			self.cnp_name         := IF(right.cnp_name = '',left.cnp_name,right.cnp_name),
			self := left
		),left outer,local
	);
	return j3;
END;
//currently limited to single word translations (see pretranslate for multi)
export translate(dataset(BIPV2_Company_Names.layouts.layout_words) words) :=
FUNCTION
	j :=
	join(
		words,
		BIPV2_Company_Names.files.translationskey,
		keyed(left.word = right.from) and
		(0 in right.set_classes or left.cnp_classid in right.set_classes),
		transform(
			BIPV2_Company_Names.layouts.layout_words,
			self.word := if(right.from <> '', right.to, left.word),
			self.cnp_translated := left.cnp_translated or right.from <> '',
			self := left
		),
		left outer,
		keep(1),local
	);
/*   // Need to abbreviate two word states
   	i1 := iterate(j,
   	              transform(recordof(left),
                             LongState   := IF(left.cnp_nameid = right.cnp_nameid,trim(left.word) + ' ' + trim(right.word),'');
   													isLongState := LongState IN ut.Set_State_Names;
   													self.word := IF(isLongState,ut.St2Abbrev(LongState),right.word),
   													self := right),local);
     // Need to go back and suppress out first word of two word states
   	i2 := iterate(sort(i1,cnp_nameid,-seq,local),
   	              transform(recordof(left),
                             isStAbbr := left.word IN ['AS','DC','NC','ND','NH','NJ','NM','NY','PR','RI','SC','SD','VI','WV']; //ut.Set_State_Abbrev;
   													self.word := IF(isStAbbr AND right.word IN files.State_prefixes,'',right.word),
   													self := right),local);
     // Now go back and abbreviate states so cases like West Virginia done correctly.
   	p :=
   	project(sort(i2,cnp_nameid,seq,local),
   		transform(
   			BIPV2_Company_Names.layouts.layout_words,
         isLongState := left.word IN ut.Set_State_Names;
   			self.word := if(isLongState,ut.St2Abbrev(left.word),left.word),
   			self.cnp_translated := isLongState,
   			self := left
   		)
   	);
   	return p;
*/
return j;
END;
EXPORT translate_shortlist(DATASET(BIPV2_Company_Names.layouts.layout_words) words) :=FUNCTION
	j :=
	join(
		words,
		BIPV2_Company_Names.files.Translations_shortlist,
		left.word = right.from and
		(0 in right.set_classes or left.cnp_classid in right.set_classes),
		transform(
			BIPV2_Company_Names.layouts.layout_words,
			self.word := if(right.from <> '', right.to+'blah', left.word),
			self.cnp_translated := left.cnp_translated or right.from <> '',
			self := left
		),
		left outer,
		lookup//looking without MANY effectively has a built in KEEP(1)
	);
/*
    // Need to abbreviate two word states
   	i1 := iterate(j,
   	              transform(recordof(left),
                             LongState   := IF(left.cnp_nameid = right.cnp_nameid,trim(left.word) + ' ' + trim(right.word),'');
   													isLongState := LongState IN ut.Set_State_Names;
   													self.word := IF(isLongState,ut.St2Abbrev(LongState),right.word),
   													self := right),local);
     // Need to go back and suppress out first word of two word states
   	i2 := iterate(sort(i1,cnp_nameid,-seq,local),
   	              transform(recordof(left),
                             isStAbbr := left.word IN ['AS','DC','NC','ND','NH','NJ','NM','NY','PR','RI','SC','SD','VI','WV']; //ut.Set_State_Abbrev ;
   													self.word := IF(isStAbbr AND right.word IN files.State_prefixes,'',right.word),
   													self := right),local);
     // Now go back and abbreviate states so cases like West Virginia done correctly.
     p :=
   	project(sort(i2,cnp_nameid,seq,local),
   		transform(
   			BIPV2_Company_Names.layouts.layout_words,
   			isLongState := left.word IN ut.Set_State_Names;
         self.word := if(isLongState,ut.St2Abbrev(left.word),left.word),
   			self.cnp_translated := isLongState,
   			self := left
   		)
   	);
   	return p;
*/
return j;
END;
//-----TEST------Each apply of translate will remove a special word before NY, NJ, NH, SC, NM, etc. translate2 skip the removal.
export translate2(dataset(BIPV2_Company_Names.layouts.layout_words) words) :=
FUNCTION
	j :=
	join(
		words,
		BIPV2_Company_Names.files.translationskey,
		keyed(left.word = right.from) and
		(0 in right.set_classes or left.cnp_classid in right.set_classes),
		transform(
			BIPV2_Company_Names.layouts.layout_words,
			self.word := if(right.from <> '', right.to, left.word),
			self.cnp_translated := left.cnp_translated or right.from <> '',
			self := left
		),
		left outer,
		keep(1),local
	);
/*
     // Need to abbreviate two word states
   	i1 := iterate(j,
   	              transform(recordof(left),
                             LongState   := IF(left.cnp_nameid = right.cnp_nameid,trim(left.word) + ' ' + trim(right.word),'');
   													isLongState := LongState IN ut.Set_State_Names;
   													self.word := IF(isLongState,ut.St2Abbrev(LongState),right.word),
   													self := right),local);
     // Need to go back and suppress out first word of two word states
   	i2 := iterate(sort(i1,cnp_nameid,-seq,local),
   	              transform(recordof(left),
                             self.word := right.word,
   													self := right),local);
     // Now go back and abbreviate states so cases like West Virginia done correctly.
   	p :=
   	project(sort(i2,cnp_nameid,seq,local),
   		transform(
   			BIPV2_Company_Names.layouts.layout_words,
         isLongState := left.word IN ut.Set_State_Names;
   			self.word := if(isLongState,ut.St2Abbrev(left.word),left.word),
   			self.cnp_translated := isLongState,
   			self := left
   		)
   	);
   	return p;
*/
return j;
END;
EXPORT translate_shortlist2(DATASET(BIPV2_Company_Names.layouts.layout_words) words) :=FUNCTION
	j :=
	join(
		words,
		BIPV2_Company_Names.files.Translations_shortlist,
		left.word = right.from and
		(0 in right.set_classes or left.cnp_classid in right.set_classes),
		transform(
			BIPV2_Company_Names.layouts.layout_words,
			self.word := if(right.from <> '', right.to+'blah', left.word),
			self.cnp_translated := left.cnp_translated or right.from <> '',
			self := left
		),
		left outer,
		lookup//looking without MANY effectively has a built in KEEP(1)
	);
/*  // Need to abbreviate two word states
   	i1 := iterate(j,
   	              transform(recordof(left),
                             LongState   := IF(left.cnp_nameid = right.cnp_nameid,trim(left.word) + ' ' + trim(right.word),'');
   													isLongState := LongState IN ut.Set_State_Names;
   													self.word := IF(isLongState,ut.St2Abbrev(LongState),right.word),
   													self := right),local);
     // Need to go back and suppress out first word of two word states
   	i2 := iterate(sort(i1,cnp_nameid,-seq,local),
   	              transform(recordof(left),
   													self.word := right.word,
   													self := right),local);
     // Now go back and abbreviate states so cases like West Virginia done correctly.
     p :=
   	project(sort(i2,cnp_nameid,seq,local),
   		transform(
   			BIPV2_Company_Names.layouts.layout_words,
   			isLongState := left.word IN ut.Set_State_Names;
         self.word := if(isLongState,ut.St2Abbrev(left.word),left.word),
   			self.cnp_translated := isLongState,
   			self := left
   		)
   	);
	return p;
*/
return j;
END;
//--------------------------------------------END TEST------------------
export isnumeric(string s) := s <> '' and stringlib.stringfilter(s,'0123456789#') = trim(s);
export extract(dataset(BIPV2_Company_Names.layouts.layout_words) words) :=
FUNCTION
	j1 :=
	project(
		words,
		transform(
			BIPV2_Company_Names.layouts.layout_words,
			self.extracted_number    := isnumeric(left.word) and left.word not in BIPV2_Company_Names.files.cnp_number_exclusions,
	      self := left
		)
	);
	d1 := // Mark last number as store number
	dedup(sort(j1(extracted_number),cnp_nameid,-seq,local),cnp_nameid,local);
	j1a := // join back to main file
	join(
	  j1,d1,
		left.cnp_nameid = right.cnp_nameid and
	  left.seq = right.seq,
		transform(
		  BIPV2_Company_Names.layouts.layout_words,
			self.extracted_store_number := IF(right.cnp_nameid>0,TRUE,left.extracted_store_number);
			self.extracted_number       := IF(right.cnp_nameid>0,FALSE,left.extracted_number),
			self := left),
			left outer,local
	);
	// output(j1a,named('j1a'),extend);
	i1 := // check for preceding word for suppression
	iterate(sort(j1a,cnp_nameid,-seq,local),
		transform(
		  BIPV2_Company_Names.layouts.layout_words,
			self.extracted_store_prefix := right.word IN BIPV2_Company_Names.files.StoreNbr_prefixes and left.extracted_store_number,
			self := right),local
	);
	// output(i1,named('i1'),extend);
	j2 :=
	join(
		sort(i1,cnp_nameid,seq,local),
		BIPV2_Company_Names.files.Extractions_btype,
		left.word = right.from,
		transform(
			BIPV2_Company_Names.layouts.layout_words,
      self.extracted_btype := right.from <> '' and left.seq > 1,
			self.word := IF(self.extracted_btype,right.to,left.word),
			self := left
		),
		left outer,
		lookup
	);
	j3 :=
	join(
		j2,
		BIPV2_Company_Names.files.Extractions_lowv,
		left.word = right.extraction,
		transform(
			BIPV2_Company_Names.layouts.layout_words,
			self.extracted_lowv := right.extraction <> '',
			self := left
		),
		left outer,
		lookup
	);
  i2 := iterate (j3,  // Mark words following of for truncation for store name match
	               transform(recordof(left),
								           self.extracted_of_clause := IF(left.cnp_nameid = right.cnp_nameid,
													                                IF(right.word = 'OF' AND
													                                   left.word NOT IN files.Of_exclusions,
																														 TRUE,
																														 left.extracted_of_clause),
																													FALSE),
													 self := right),local);
	return i2;
END;
EXPORT prep(DATASET(BIPV2_Company_Names.layouts.layout_names) names):=FUNCTION
  BIPV2_Company_Names.layouts.layout_names tPrep(RECORDOF(names) L):=TRANSFORM
    strip_punct0:=stringlib.StringFilterOut(L.cnp_name, '\'"');
    strip_punct:=stringlib.StringSubstituteOut(strip_punct0, '.,/\\#:()*', ' ');
    separate_ampersand:=REGEXREPLACE('([&])([^ ])',REGEXREPLACE('([^ ])([&])',strip_punct,'$1 $2'),'$1 $2');
    compress_spaces:=REGEXREPLACE('[ ]+',separate_ampersand,' ');
    strip_nonprintable:=REGEXREPLACE('[^[:print:]]',compress_spaces,'');
    SELF.cnp_name:=trim(strip_nonprintable, left, right);
    SELF:=L;
  END;
  RETURN PROJECT(names,tPrep(LEFT));
END;
// The following will be used for the ROMA NUMBER "I" handling: (not used, find another way - a little bit better the replacePattern)
SHARED find_real_1:='(?!.*\\bI GO\\b)(?!.*\\bI DO\\b)(?!.*\\bI AM\\b)(?!.*\\bI CAN\\b)(?!.*\\bI SEE\\b)(?!.*\\bI SAW\\b)(?!.*\\bI WAS\\b)(?!.*\\bI GOT\\b)' +
			   '(?!.*\\bI DID\\b)(?!.*\\bI FIX\\b)(?!.*\\bI LIKE\\b)(?!.*\\bI WILL\\b)(?!.*\\bI LOVE\\b)(?!.*\\bI MADE\\b)(?!.*\\bI MAKE\\b)' +
				 '(?!.*\\bI WANT\\b)(?!.*\\bI HAVE\\b)(?!.*\\bI LIVE\\b)(?!.*\\bI VIEW\\b)(?!.*\\bI FEEL\\b)(?!.*\\bI KNOW\\b)(?!.*\\bI DROP\\b)(?!.*\\bI DRED\\b)' +
				 '(?!.*\\bI FOUND\\b)(?!.*\\bI THINK\\b)(?!.*\\bI TOUCH\\b)(?!.*\\bI PRESUME\\b)(?!.*\\bI REMEMBER\\b)(?!.*\\bI STOOD\\b)' +
				 '(?!.*\\bI DOING\\b)(?!.*\\bI WONT\\b)(?!.*\\bI DONT\\b)(?=.*\\w\\w\\bI(, | ,| & | \\w\\w)).*$|\\w\\w\\sI$';
SHARED replacePattern1:='(\\w\\w\\s)I(?! AM\\b)(?! HAVE\\b)(?! VIEW)(?! GO\\b)(?! DO\\b)(?! CAN\\b)(?! SEE\\b)' +
												'(?! SAW\\b)(?! WAS\\b)(?! GOT\\b)(?! DID\\b)(?! FIX\\b)(?! LIKE\\b)(?! WILL\\b)(?! LIVE\\b)' +
												'(?! LOVE\\b)(?! FEEL\\b)(?! MADE\\b)(?! MAKE\\b)(?! WANT\\b)(?! KNOW\\b)(?! DROP\\b)(?! DRED\\b)' +
												'(?! FOUND\\b)(?! DOING\\b)(?! THINK\\b)(?! TOUCH\\b)(?! WONT\\b)(?! STOOD\\b)(?! DONT\\b)' +
												'(?! PRESUME\\b)(?! REMEMBER\\b)';
SHARED replacePattern :=	replacePattern1 + '(\\s\\w\\w|\\s& | ,|, )';
SHARED FR(string src, string find, string tobeReplaced, string replacewith) := function
			   return map(REGEXFIND(find, src)=true => regexreplace(tobeReplaced, src, replacewith), src);
			 end;
//       s1 :=FR(s0,find_real_1, '\\bI\\b', '1');
// one may also need a replace of find '(\\w\\w\\s)I$' to '$1 1' // no need !
import std;
export string RemoveDiacritics(string s) := (STRING) STD.Uni.Cleanaccents(s); 

SHARED SFR(string src, string find, string replacewith) := regexreplace('\\b'+find+'\\b', src, replacewith);
SHARED SFR0(string src, string find, string replacewith) := regexreplace(find, src, replacewith);
Shared sReplacements:=''+
  '\\b(C)(A)LIFORNIA\\b|'+
  '\\b(T)E(X)AS\\b|'+
  '\\b(F)(L)ORIDA\\b|'+
  '\\b(N)EW (Y)ORK\\b|'+
  '\\b(I)(L)LINOIS\\b|'+
  '\\b(P)ENNSYLVANI(A)\\b|'+
  '\\b(O)(H)IO\\b|'+
  '\\b(G)EORGI(A)\\b|'+
  '\\b(N)ORTH (C)AROLINA\\b|'+
  '\\b(M)(I)CHIGAN\\b|'+
  '\\b(N)EW (J)ERSEY\\b|'+
  '\\b(W)EST (V)IRGINIA\\b|'+
  '\\b(V)IRGINI(A)\\b|'+
  '\\b(W)(A)SHINGTON\\b|'+
  '\\b(M)(A)SSACHUSETTS\\b|'+
  '\\b(A)RI(Z)ONA\\b|'+
  '\\b(I)(N)DIANA\\b|'+
  '\\b(T)E(N)NESSEE\\b|'+
  '\\b(M)ISS(O)URI\\b|'+
  '\\b(M)ARYLAN(D)\\b|'+
  '\\b(W)(I)SCONSIN\\b|'+
  '\\b(M)I(N)NESOTA\\b|'+
  '\\b(C)(O)LORADO\\b|'+
  '\\b(A)(L)ABAMA\\b|'+
  '\\b(S)OUTH (C)AROLINA\\b|'+
  '\\b(L)OUISIAN(A)\\b|'+
  '\\b(K)ENTUCK(Y)\\b|'+
  '\\b(O)(R)EGON\\b|'+
  '\\b(O)(K)LAHOMA\\b|'+
  '\\b(C)ONNECTICU(T)\\b|'+
  '\\b(I)OW(A)\\b|'+
  '\\b(M)I(S)SISSIPPI\\b|'+
  '\\b(A)(R)KANSAS\\b|'+
  '\\b(U)(T)AH\\b|'+
  '\\b(K)ANSA(S)\\b|'+
  '\\b(N)E(V)ADA\\b|'+
  '\\b(N)EW (M)EXICO\\b|'+
  '\\b(N)(E)BRASKA\\b|'+
  '\\b(I)(D)AHO\\b|'+
  '\\b(H)AWAI(I)\\b|'+
  '\\b(M)AIN(E)\\b|'+
  '\\b(N)EW (H)AMPSHIRE\\b|'+
  '\\b(P)UERTO (R)ICO\\b|'+
  '\\b(R)HODE (I)SLAND\\b|'+
  '\\b(M)ON(T)ANA\\b|'+
  '\\b(D)(E)LAWARE\\b|'+
  '\\b(S)OUTH (D)AKOTA\\b|'+
  '\\b(N)ORTH (D)AKOTA\\b|'+
  '\\b(A)LAS(K)A\\b|'+
  '\\b(D)ISTRICT OF (C)OLUMBIA\\b|'+
  '\\b(V)ERMON(T)\\b|'+
  '\\b(W)(Y)OMING\\b|'+
  '\\b(G)(U)AM\\b|'+
  '\\b(V)(I)RGIN ISLANDS\\b|'+
  '\\b(A)MERICAN (S)AMOA\\b|'+
  '\\b(U)NITED (S)TATES\\b';
SHARED ST_REPLACE_TO:=
	'$1$2$3$4$5$6$7$8$9$10$11$12$13$14$15$16$17$18$19$20$21$22$23$24$25$26$27$28$29$30$31$32$33$34$35$36$37$38$39$40' +
	'$41$42$43$44$45$46$47$48$49$50$51$52$53$54$55$56$57$58$59$60$61$62$63$64$65$66$67$68$69$70$71$72$73$74$75$76$77' +
	'$78$79$80$81$82$83$84$85$86$87$88$89$90$91$92$93$94$95$96$97$98$99$100$101$102$103$104$105$106$107$108$109$110$111$112';
SHARED SSSS(string qqq) :=function
LOADXML('<xml/>');
#DECLARE(i) #SET(i,LENGTH(REGEXREPLACE('[^(]',sReplacements,'')))
#DECLARE(r) #SET(r,'')
#LOOP
  #IF(%i%>0)
    #SET(r,'$'+%'i'%+%'r'%)
    #SET(i,%i%-1)
  #ELSE
    #BREAK
  #END
#END
			#SET(r, 'ttt :=' + '\'' + %'r'% + '\'' + ';\n return ttt;\n')
			%r%
end;
SHARED State_To_Abbrv(string qqq)  :=function
            import ut;
							sa0:=qqq;
      				LOADXML('<xml/>');
         			#DECLARE (SetString)
         			#DECLARE (Ndx)
         			#DECLARE (Ndx1)
         			#SET (SetString, '');    //initialize SetString to [
         			#SET (Ndx, 1);            //initialize Ndx to 1
         			#SET (Ndx1, 1);
         			cntSt :=count(ut.Set_State_Names);
         			#LOOP
         				#IF (%Ndx% > cntSt)
         					#SET (Ndx1, %Ndx% - 1)
         					#APPEND (SetString,'ttt :=sa' + %Ndx1% + ';\n return ttt;\n');  //final output var is ttt
         					#BREAK         // break out of the loop
         				#ELSE             //otherwise
         					#SET (Ndx1, %Ndx% - 1) //first input is always s0
         					//#APPEND (SetString, 'sa' + %'Ndx'% + ' :=SFR0(sa' + %'Ndx1'% + ',' + 'ut.Set_State_Names[' + %'Ndx'% + ']' + ', ' + 'ut.St2Abbrev(' + 'ut.Set_State_Names[' + %'Ndx'% + ']));\n');
									#APPEND (SetString, 'sa' + %'Ndx'% + ' :=SFR0(sa' + %'Ndx1'% + ',' + 'ut.Set_State_Names[' + %'Ndx'% + ']' + ', ' + 'ut.Set_State_Abbrev[' +  %'Ndx'% + ']);\n');
									#SET (Ndx, %Ndx% + 1)   //and increment the value of Ndx
         				#END
         			#END
      			%SetString%
      end;
//this is where we can find multi word patterns
EXPORT pretranslate(DATASET(BIPV2_Company_Names.layouts.layout_names) names):=FUNCTION
	Run1:=PROJECT(
		names,
		transform(
							BIPV2_Company_Names.layouts.layout_names,
							// PA CO treatment:
							  start0:= RemoveDiacritics(trim(left.cnp_name,LEFT,RIGHT));
							  start:=stringlib.stringtouppercase(start0); //The uppercase call can be removed from the module.
								w0:=REGEXFIND('\\bOF\\b|\\bFROM\\b|\\IN\\b|\\bAT\\b|\\bTO\\b|\\bFOR\\b', start);  //true or false
								w1:=SFR(start, 'OF (PA|CO)'		, 'OFOF$1$1'); 			//to be OFOFPAPA or OFOFCOCO
								w2:=SFR(w1,		 'FROM (PA|CO)'	, 'FROMFROM$1$1');
								w3:=SFR(w2,		 'IN (PA|CO)'		, 'ININ$1$1');
								w4:=SFR(w3,		 'AT (PA|CO)'		, 'ATAT$1$1');
								w5:=SFR(w4,		 'TO (PA|CO)'		, 'TOTO$1$1');
								w6:=SFR(w5,		 'FOR (PA|CO)'	, 'FORFOR$1$1');
								start3 :=if(w0, (
																 if(w1   !=start, w1,
																 if(w2   !=start, w2,
																 if(w3   !=start, w3,
																 if(w4   !=start, w4,
																 if(w5   !=start, w5,
																 if(w6   !=start, w6,
																		start	))))))
																),
																start
														);
								start4 :=SFR0(start3	,'\\bCO (OWNER\\b|OWNERS\\b)', 'CO$1');
								w13:=SFR0(start4, '\\b(STEAK|ROAD|ALE|ICE|CLUB|GREEN|TOWN) HOUSE\\b', '$1HOUSE');
								start5:= if(w13  !=start4, w13, start4);
								start6:= SFR(start5, '^THE BANK OF NEW YORK','BNY MELLON'); //No good way to handle it in the files attribute.
								start7 := SFR0(SFR0(start6, '-CO |-CO\\.,|-CO,|-CO$|-CO\\. ', 'CO '),'\\bCO-', 'CO');
// ----------------------Add middle runs here ---------------------------------------
								s1:=SFR0(start7, '\\bP L L C\\b|PROFESSIONAL LTD LIABILITY CO\\b|PROFESSIONAL LIMITED LIABILITY COMPANY', 'PLLC');
								s2:=SFR0(s1, '\\bL\\.L\\.L\\.P\\.\\b|\\bL L L P\\b|LIMITED LIABILITY LIMITED PARTNERSHIP\\b', 'LLLP');
								s3:=SFR0(s2, '\\bP L L P\\b|PROFESSIONAL LTD LIABILITY PARTNERSHIP', 'PLLP');
								s4:=SFR0(s3, '\\bL L C\\b|\\bL\\.L\\.C\\.\\b|\\bL\\.L\\.C\\b|\\bLIMITED LIABILITY COMPANY\\b|\\bLIMITED LIABILITY COMP\\*', 'LLC'); // LLC case 38,346,675
								s5:=SFR0(s4,
   								'\\bLIMITED LIABILITY CO\\b|\\bLTD LIABILITY CO\\b|' +
									'\\bL T D LIABILITY CO\\b|\\bLIMITED LIABILITY COM\\b|' +
									'\\bLIMITED LIABILITY COMP\\b', 'LLC'); //LLC case 3,785,297
								s6:=SFR0(s5 ,'\\bL L P\\b|\\bL\\.L\\.P\\.\\b|\\bL\\.L\\.P\\b|LTD\\.L\\.P\\.',  'LLP');
								s7:=SFR0(s6, ' LC CO$| L C CO$| LC \\(CO\\)$| LC, CO$| L C, CO$| L\\.C\\. CO$', ' CO__LC');	// CO LC case	176,082?????
								s8:=SFR0(s7, ' PA CO$| P A CO$| PA \\(CO\\)$| PA, CO$| P A, CO$| P\\.A\\. CO$', ' CO__PA');	// CO PA case. 249,484 Maybe just PA CO part???
								s9:=SFR0(s8, ' PC CO$| P C CO$| PC \\(CO\\)$| PC, CO$| P C, CO$| P\\.C\\. CO$', ' CO__PC');	//CO PC case. 255,154???? Maybe just PC CO part???
								s10:=SFR0(s9,' L T D CO\\b| LTD CO\\b| LIMITED CO\\b', ' L__C');	//LC case. 456,238????
								s11:=SFR0(SFR0(SFR0(SFR0(SFR0(SFR0(SFR0(s10
   								,'\\bPROFESSIONAL CORP\\b', 'P__C')
   								,'\\bGENERAL PARTNERSHIP\\b', 'GGGPPP')
   								,'\\bPROFESSIONAL ASSOCIATION$', 'PPPAAA')
   								,'\\bLIMITED LIABILITY PARTNERSHIP\\b', 'LLP')
   								,'\\bLTD LIABILITY PARTNERSHIP\\b', 'LLP')
   								,'\\bFAMILY LIMITED PARTNERSHIP\\b|\\bFAMILY LTD PARTNERSHIP\\b|\\FAMILY L P$', 'FAMILY_LP') //PLLP LLLP, PLLC FAMILY_LP
									,' LIMITED PARTNERSHIP\\b| LTD PARTNERSHIP\\b|\\(LIMITED PARTNERSHIP\\b', ' LP');
									s12:=SFR0(s11,' GP$| G\\.P\\.$', ' GGGPPP');
									s13:=SFR0(s12,' PA$| P\\.A\\.$', ' PPPAAA');
									s14:=SFR0(s13,' LC$| L\\.C\\.$', ' L__C');
									s15:=SFR0(s14,' PC$| P\\.C\\.$', ' P__C');
									s16:=SFR0(s15,'(\\w\\w\\s)(G P$)', '$1GGGPPP');
									s17:=SFR0(s16,'(\\w\\w\\s)(P A$)', '$1PPPAAA');
									s18:=SFR0(s17,'(\\w\\w\\s)(L C$)', '$1L__C');
									s19:=SFR0(s18,'(\\w\\w\\s)(P C$|P\\.C\\.$)', '$1P__C');
									start8			:= if(s1  !=start7, s1,      // if(s1  !=left.cnp_name, s1,
																 if(s2  !=start7, s2,
																 if(s3  !=start7, s3,
																 if(s4  !=start7, s4,
																 if(s5  !=start7, s5,
																 if(s6  !=start7, s6,
																 if(s7  !=start7, s7,
																 if(s8  !=start7, s8,
																 if(s9  !=start7, s9,
																 if(s10 !=start7, s10,
																 if(s11 !=start7, s11,
																 if(s12 !=start7, s12,
																 if(s13 !=start7, s13,
																 if(s14 !=start7, s14,
																 if(s15 !=start7, s15,
																 if(s16 !=start7, s16,
																 if(s17 !=start7, s17,
																 if(s18 !=start7, s18,
																 if(s19 !=start7, s19,
																 start7
																 )))))))))))))))))));
							// PA CO treatment:   recover it back!!!!!
								s20:=	 SFR0(start8,' L\\.P\\. ', ' LP ');
								s21 :=SFR0(s20, '(\\w\\w\\s)(L P$|L P,)', '$1LP ');
								s22 :=SFR0(s21, '(\\w\\w\\s)(L P )(\\s\\w\\w)', '$1LP$3');
   							s23:=SFR0(s22, ' \\(L\\.P\\.\\)| L\\.P\\.,| L\\.P$| L\\.P\\.$|, L P\\b|\\) L P$|\\) L P |\\) L P,',' LP ');
   							s24:=SFR0(s23, ' CO | CO"| CO;| CO,| CO!|,CO\\b| CO$| CO\\(| CO\\)| CO\\.| CO\\.\\(|&CO\\b', ' CCCOOO ');		//,' CO$', ' CCCOOO');
// ---------------- The last run below--------------------------------------------
								end1 :=s24;
								q16:=SFR(end1,	'OFOFPAPA', 		'OF PA');
								q17:=SFR(q16,		'FROMFROMPAPA', 'FROM PA');
								q18:=SFR(q17,		'ININPAPA', 		'IN PA');
								q19:=SFR(q18,		'ATATPAPA', 		'AT PA');
								q20:=SFR(q19,		'TOTOPAPA', 		'TO PA');
								q21:=SFR(q20,		'FORFORPAPA', 	'FOR PA');
								q22 := SFR(q21,	'OFOFCOCO', 		'OF CO');
								q23 := SFR(q22,		'FROMFROMCOCO', 'FROM CO');
								q24 := SFR(q23,		'ININCOCO', 		'IN CO');
								q25 := SFR(q24,		'ATATCOCO', 		'AT CO');
								q26 := SFR(q25,		'TOTOCOCO', 		'TO CO');
								q27 := SFR(q26,		'FORFORCO', 		'FOR CO');
								end3 :=  if(w0,(
																 if(q16 !=end1, q16,
																 if(q17 !=end1, q17,
																 if(q18 !=end1, q18,
																 if(q19 !=end1, q19,
																 if(q20 !=end1, q20,
																 if(q21 !=end1, q21,
																 if(q22 !=end1, q22,
																 if(q23 !=end1, q23,
																 if(q24 !=end1, q24,
																 if(q25 !=end1, q25,
																 if(q26 !=end1, q26,
																 if(q27 !=end1, q27,
																		end1 ))))))))))))
															), end1
														);
//The following is to replace the state handling in translate_shortlist ...
//s17:=State_To_Abbrv(end3);
							  end8 := REGEXREPLACE(sReplacements,end3,ST_REPLACE_TO);
								xy0:=SFR0(end8,'&#39;','');
								//xy1 :=FR(xy0,find_real_1, '\\bI\\b', '1'); //handle Roman "I"
								xy1 :=SFR0(SFR0(xy0,replacePattern, '$1 1 $2'), '(\\w\\w) I$', '$1 1'); //handle Roman "I"
								xy2 :=SFR0(SFR0(xy1, '([A-Z][A-Z0-9]) X( ,|,| \\w\\w)', '$1 10 $2'),'(\\w\\w) X$', '$1 10');
								xy3 :=SFR0(SFR0(xy2, '([A-Z][A-Z0-9]) V( ,|,| \\w\\w)', '$1 5 $2'), '(\\w\\w) V$', '$1 5');
								self.cnp_name := xy3;
								self := left
			));
	RETURN Run1;
	END;
//----- added by HS 20150806 to handle school PTA/PTO:
EXPORT PtaPtoTo_cnpNumber(DATASET(BIPV2_Company_Names.layouts.layout_names) names):=FUNCTION
	RunIt:=PROJECT(
		names,
		transform(
					BIPV2_Company_Names.layouts.layout_names,
					searchpatternPTA1 :='PARENT TEACHER ASSOCIATION|PARENT AND TEACHER ASSOCIATION|PARENTS TEACHERS ASSOCIATION|PARENTS AND TEACHERS ASSOCIATION';
					searchpatternPTA2 :='\\w\\w P\\.T\\.A\\.$|\\w\\w PTA$|\\w\\w P T A$|\\w\\w PTA \\w\\w|\\w\\w PTA$|\\w\\w P T A \\w\\w|\\w\\w P\\.T\\.A\\. \\w\\w|\\w\\w P\\.T\\.A\\.$|^PTA \\w\\w|^P T A \\w\\w|^P\\.T\\.A\\. \\w\\w';
					searchpatternPTO1 :='PARENT TEACHER ORGANIZATION|PARENT TEACHER ORGANIZATIONS|PARENT TEACHERS ORGANIZATION|PARENT AND TEACHER ORGANIZATION|PARENT TEACHER ORGANISATION';
					searchpatternPTO2 :='\\w\\w P\\.T\\.O\\.$|\\w\\w PTO$|\\w\\w P T O$|\\w\\w PTO \\w\\w|\\w\\w PTO$|\\w\\w P T O \\w\\w|\\w\\w P\\.T\\.O\\. \\w\\w|\\w\\w P\\.T\\.O\\.$|^PTO \\w\\w|^P T O \\w\\w|^P\\.T\\.O\\. \\w\\w';
possibleschool :='SCHOOL|DISTRICT|LEARNING CENTER|SCHOLARSHIP| DIST | CNGRSS | CNGRSS$|CONGRES|CNGRESS|MIDDLE|HIGH|CHILDHOOD|PRESCHOOL|KIDS| HS | ES | SCH | SCHL |ELEMENTARY| ELEM |LEARNING| PRMRY |PRIMARY|CHARTER|JUNIOR|COLLEGE|ACADEMY|GRADE| MS | GRD | JR ';
					  start0:= trim(left.cnp_name,LEFT,RIGHT);
					  HasPtaPto:= if((length(regexfind(searchpatternPTA1, start0,0))>0 and length(regexfind(possibleschool, start0,0))>0) or
													 (length(regexfind(searchpatternPTA2, start0,0))>0 and length(regexfind(possibleschool, start0,0))>0), 1,
														if((length(regexfind(searchpatternPTO1, start0,0))>0 and length(regexfind(possibleschool, start0,0))>0) or
															 (length(regexfind(searchpatternPTO2, start0,0))>0 and length(regexfind(possibleschool, start0,0))>0),2,0));
						self.cnp_number :=map(HasPtaPto=1 => 'PTA ' + Left.cnp_number,
											  HasPtaPto=2 => 'PTO ' + Left.cnp_number,
											  Left.cnp_number);
						self := left
			));
	RETURN RunIt;
	END;
	//-----------------
EXPORT uppercase(DATASET(BIPV2_Company_Names.layouts.layout_names) names):=FUNCTION
  RETURN
	PROJECT(
		names,
		transform(
			BIPV2_Company_Names.layouts.layout_names,
			self.cnp_name := stringlib.stringtouppercase(left.cnp_name);
			self := left
		)
	);
END;
// only works on leading part of company name
EXPORT AbbrvAndStandardize(DATASET(BIPV2_Company_Names.layouts.layout_names) names):=FUNCTION
	mylength(string s) := length(trim(s));
	isleadingoneway(string a, string b) := a = b[1..mylength(a)];
  RETURN
	join(
		names,
		BIPV2_Company_Names.files.CoNameStdPlusAbbrv,
		left.cnp_name[1..5] = right.from[1..5] and //this is just something to make the next line work in a non-all join
		isleadingoneway(right.from,left.cnp_name),
		transform(
			BIPV2_Company_Names.layouts.layout_names,
			self.cnp_name := if(right.from <> '', trim(right.to) + left.cnp_name[(mylength(right.from)+1)..], left.cnp_name),
			self.cnp_translated := right.from <> '',
			self := left
		),
		left outer,
		lookup
		// keep(1)
	);
END;
// only works on leading part of company name
EXPORT abbrv(DATASET(BIPV2_Company_Names.layouts.layout_names) names):=FUNCTION
	mylength(string s) := length(trim(s));
	isleadingoneway(string a, string b) := a = b[1..mylength(a)];
  RETURN
	join(
		names,
		BIPV2_Company_Names.files.CoNameAbbrv,
		left.cnp_name[1..5] = right.from[1..5] and //this is just something to make the next line work in a non-all join
		isleadingoneway(right.from,left.cnp_name),
		transform(
			BIPV2_Company_Names.layouts.layout_names,
			self.cnp_name := if(right.from <> '', trim(right.to) + left.cnp_name[(mylength(right.from)+1)..], left.cnp_name),
			self.cnp_translated := right.from <> '',
			self := left
		),
		left outer,
		lookup
		// keep(1)
	);
END;
EXPORT standardize(DATASET(BIPV2_Company_Names.layouts.layout_names) names):=FUNCTION
	mylength(string s) := length(trim(s));
	isleadingoneway(string a, string b) := a = b[1..mylength(a)];
  RETURN
	join(
		names,
		BIPV2_Company_Names.files.CoNameStd,
		left.cnp_name[1..5] = right.from[1..5] and //this is just something to make the next line work in a non-all join
		isleadingoneway(right.from,left.cnp_name),
		transform(
			BIPV2_Company_Names.layouts.layout_names,
			self.cnp_name := if(right.from <> '', trim(right.to) + left.cnp_name[(mylength(right.from)+1)..], left.cnp_name),
			self.cnp_translated := right.from <> '',
			self := left
		),
		left outer,
		lookup
		// keep(1)
	);
END;
EXPORT storename(DATASET(BIPV2_Company_Names.layouts.layout_names) names):=FUNCTION
  RETURN
	project(
		names,
		transform(
			BIPV2_Company_Names.layouts.layout_names2,
			self.cnp_pre_extraction_name := left.cnp_name,
			self := left
		)
	);
END;
EXPORT getbackname(DATASET(BIPV2_Company_Names.layouts.layout_names) names, DATASET(BIPV2_Company_Names.layouts.layout_names2) names2):=FUNCTION
  RETURN
	join(
		names,
		names2,
		left.cnp_name = '' and
		left.cnp_nameid = right.cnp_nameid,
		transform(
			BIPV2_Company_Names.layouts.layout_names,
			self.cnp_name := if(left.cnp_name = '', right.cnp_pre_extraction_name, left.cnp_name),
			self := left
		),
		left outer,
		keep(1),local
	);
END;
EXPORT rmDups(DATASET(BIPV2_Company_Names.layouts.layout_names) names = DATASET([],BIPV2_Company_Names.layouts.layout_names)):=
MODULE
/*
this code is at least partial theft from SALT29.MAC_Dups_Note
reasons not to use SALT29.MAC_Dups_Note directly
1) it is designed for multiple fields and i only need to handle one
2) it requires a unique id named in a specific way (requires two extra transforms to workaround) - NO LONGER TRUE
3) it returns outfile and outdups in a way that doesnt let me export them both (would require SALT change to accomodate)
* all 3 could be overcome but i am not sure its worth changing SALT for such a small peice of code
*/
  export layoutWide := RECORD
	  names;
		SALT28.UIDType __shadow_ref := names.cnp_nameid;
	END;
  wider := SORT( TABLE(names,layoutWide,local),EXCEPT cnp_nameid,__shadow_ref, SKEW(1), local);
  layoutWide tra(wider le,wider ri) := 	TRANSFORM
	  SELF.__shadow_ref := IF ( le.cnp_name=ri.cnp_name	and le.__shadow_ref > 0,le.__shadow_ref,ri.cnp_nameid ); //careful, if the first record is empty it gets marked as a dup of air (thus "and le.__shadow_ref > 0")
	  SELF := ri;
	END;
  shared noted := ITERATE(wider,tra(LEFT,RIGHT),LOCAL);
	export outfile := PROJECT(noted(cnp_nameid=__shadow_ref),TRANSFORM(BIPV2_Company_Names.layouts.layout_names,SELF := LEFT));
	export layoutdups := {noted.cnp_nameid,noted.__shadow_ref};
  export outdups := TABLE(noted(cnp_nameid<>__shadow_ref),layoutdups, local);
/*
end of SALT29.MAC_Dups_Note replacement
*/
END;
EXPORT restoreDups(DATASET(BIPV2_Company_Names.layouts.layout_names) names, dataset(rmDups().layoutDups) dups):=
FUNCTION
/*
using my own code rather than SALT29.MAC_Dups_Restore since it uses Reference and UniqueID and I use neither.
 also, i can use a local join here and it doesnt know that (this part NO LONGER TRUE)
*/
  TYPEOF(names) takeid(names le,dups ri) := TRANSFORM
	  SELF.cnp_nameid := ri.cnp_nameid;
	  SELF := le;
	END;
	j2 := names
	+ JOIN(names,dups,LEFT.cnp_nameid=RIGHT.__shadow_ref,takeid(LEFT,RIGHT),LOCAL);
	return j2;
END;
EXPORT component(DATASET(BIPV2_Company_Names.layouts.layout_names) names):=FUNCTION
	c := BIPV2_Company_Names.files.Constants.Components._401KPlan;
	p :=
	project(
		names,
		transform(
			BIPV2_Company_Names.layouts.layout_names,
			s401 := regexfind(c.Regex, left.cnp_name, 2);
			has401 := s401 <> '';
			self.cnp_component_code := if(has401, c.code, left.cnp_component_code);
			self.cnp_name 					:= if(has401, stringlib.stringfindreplace(left.cnp_name, s401, ''), left.cnp_name);
			self := left;
		)
	);
	return p;
END;
//a function that transforms one company name thru the standard sequence (norm, translate, denorm, classify, norm, translate, extract, denorm)
export go(dataset(BIPV2_Company_Names.layouts.layout_names) names,BOOLEAN alphabetize,BOOLEAN include_translations) :=
FUNCTION
	r1 := rmDups(names).outfile;
	r2 := rmDups(names).outdups;
	u1 := r1; //uppercase(r1);  //uppercase logic put into pretranslate;
	t0 := pretranslate(u1);	//this does some standardization like L.L.C. to LLC
	z1 := component(t0);		//for now, just "401K plan" variants.
	p1 := prep(z1);					//this removes some extra punctuation and characters
	x1 := AbbrvAndStandardize(p1); //merged abbrv and standardize (because their code are identical, only use different data)
	//a1 := abbrv(p1);
	//x1 := standardize(a1);
	n1 := norm(x1);
	t1 := IF(include_translations,translate(n1),translate_shortlist(n1));
	d1 := denorm(t1, useAlphabeticalOrder := FALSE); //might need the words in order to classify.  we'll see.
	c1 := classify(d1);
	n2 := simple_norm(c1);
	t2 :=IF(include_translations,translate2(n2),translate_shortlist2(n2)); //IF(include_translations,translate(n2),translate_shortlist(n2));
	e1 := extract(t2);
	d2 := denorm(e1, useAlphabeticalOrder := alphabetize);
	//handling for records where cnp_name ends up blank
	s1 := storename(d1); //d1 is good because it already has some standardization
	s2 := storename(u1); //but sometimes we have already lost the name, see '----' in bug 123991
	g1 := getbackname(d2,s1);
	g2 := getbackname(g1,s2);
	//restore dups
	r3 := restoreDups(g2, r2);
	//return r3;
	r4:=PtaPtoTo_cnpNumber(r3); //added by HS
	return r4;   //r3;
END;
export fmac_go(infile, rid, namefield, alphabetize, include_translations) :=
FUNCTIONMACRO
	infile_try  := infile(namefield <> '');
	infile_skip := infile(namefield = '');
	infile_dist := distribute(infile_try,hash(namefield));//distribute once here and then do everything locally
	p :=
	project(	//this project keeps rid and cnp_name and drops everythin else
		infile_dist,
		transform(
			BIPV2_Company_Names.layouts.layout_names,
			self.cnp_nameid := left.rid,
			self.cnp_name := left.namefield
		)
	);
	//do the work
	g := BIPV2_Company_Names.functions.go(p,alphabetize,include_translations);
	//add the answers back
	outrec :=
	record
		RECORDOF(infile) OR RECORDOF(p);
	end;
	return
	join(	 //this join adds everything back and retains the cnp fields
		infile_dist + infile_skip,
		g,
		left.rid = right.cnp_nameid,
		transform(
			outrec,
			self := right,
			self := left
		),
		local,
		left outer //since infile_skip wont find any matches
	);
ENDMACRO;
export mac_go(infile, outfile, rid, namefield, alphabetize=TRUE, include_translations=FALSE) :=
MACRO
	outfile := BIPV2_Company_Names.functions.fmac_go(infile, rid, namefield, alphabetize, include_translations);
ENDMACRO;
export SanityChecks() :=
FUNCTION
return
parallel(
	output(if(count(BIPV2_Company_Names.files.translations) = count(dedup(BIPV2_Company_Names.files.translations, from, all)), 'translations unique - good', 'TRANSLATIONS NOT UNIQUE - BAD'))
	,output(if(count(BIPV2_Company_Names.files.Extractions_btype) = count(dedup(BIPV2_Company_Names.files.Extractions_btype, from, all)), 'Extractions_btype unique - good', 'EXTRACTIONS_BTYPE NOT UNIQUE - BAD'))
	,output(if(count(BIPV2_Company_Names.files.Extractions_lowv) = count(dedup(BIPV2_Company_Names.files.Extractions_lowv, extraction, all)), 'Extractions_lowv unique - good', 'EXTRACTIONS_LOWV NOT UNIQUE - BAD'))
);
END;
export SanityChecksTranslationDebug() :=
FUNCTION
ds := BIPV2_Company_Names.files.translations;
r := record
	ds.from;
	cnt := count(Group);
end;
t := table(ds, r, from);
return output(sort(t(cnt > 1), -cnt), named('SanityChecksTranslationDebug'));
END;
export LookupString(string s) :=
parallel(
	output(BIPV2_Company_Names.files.Translations(from = s), named('Translations_from'))
	,output(BIPV2_Company_Names.files.Translations(to = s), named('Translations_to'))
	,output(BIPV2_Company_Names.files.Extractions_btype(From = s), named('Extractions_btype'))
	,output(BIPV2_Company_Names.files.Extractions_lowv(Extraction = s), named('Extractions_lowv'))
);
END;
