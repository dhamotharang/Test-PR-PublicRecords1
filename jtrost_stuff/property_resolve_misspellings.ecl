import ut;

EXPORT property_resolve_misspellings(dataset(recordof(jtrost_stuff.layout_property_field_names_normalized)) in_ds) := module

shared r2 := jtrost_stuff.layout_property_field_names_expanded;

r2 xform1(in_ds le) := transform
 
 integer space1  := stringlib.stringfind(le.name_standard,' ',1);
 integer space2  := stringlib.stringfind(le.name_standard,' ',2);
 integer space3  := stringlib.stringfind(le.name_standard,' ',3);
 integer space4  := stringlib.stringfind(le.name_standard,' ',4);
 integer space5  := stringlib.stringfind(le.name_standard,' ',5);
 integer space6  := stringlib.stringfind(le.name_standard,' ',6);
 integer space7  := stringlib.stringfind(le.name_standard,' ',7);
 integer space8  := stringlib.stringfind(le.name_standard,' ',8);
 integer space9  := stringlib.stringfind(le.name_standard,' ',9);
 integer space10 := stringlib.stringfind(le.name_standard,' ',10);
 
 //remove the trailing comma (e.g. "WORD,")
 self.word1  := stringlib.stringfilter(le.name_standard[1..space1-1],ut.alphabet+'1234567890#&');
 self.word2  := stringlib.stringfilter(le.name_standard[space1+1..space2-1],ut.alphabet+'1234567890#&');
 self.word3  := stringlib.stringfilter(le.name_standard[space2+1..space3-1],ut.alphabet+'1234567890#&');
 self.word4  := stringlib.stringfilter(le.name_standard[space3+1..space4-1],ut.alphabet+'1234567890#&');
 self.word5  := stringlib.stringfilter(le.name_standard[space4+1..space5-1],ut.alphabet+'1234567890#&');
 self.word6  := stringlib.stringfilter(le.name_standard[space5+1..space6-1],ut.alphabet+'1234567890#&');
 self.word7  := stringlib.stringfilter(le.name_standard[space6+1..space7-1],ut.alphabet+'1234567890#&');
 self.word8  := stringlib.stringfilter(le.name_standard[space7+1..space8-1],ut.alphabet+'1234567890#&');
 self.word9  := stringlib.stringfilter(le.name_standard[space8+1..space9-1],ut.alphabet+'1234567890#&');
 self.word10 := stringlib.stringfilter(le.name_standard[space9+1..space10-1],ut.alphabet+'1234567890#&');
 self.rest_of_string := le.name_standard[space10..];

 //self.word1  := stringlib.stringfilterout(le.name_standard[1..space1-1],',');
 //self.word2  := stringlib.stringfilterout(le.name_standard[space1+1..space2-1],',');
 //self.word3  := stringlib.stringfilterout(le.name_standard[space2+1..space3-1],',');
 //self.word4  := stringlib.stringfilterout(le.name_standard[space3+1..space4-1],',');
 //self.word5  := stringlib.stringfilterout(le.name_standard[space4+1..space5-1],',');
 //self.word6  := stringlib.stringfilterout(le.name_standard[space5+1..space6-1],',');
 //self.word7  := stringlib.stringfilterout(le.name_standard[space6+1..space7-1],',');
 //self.word8  := stringlib.stringfilterout(le.name_standard[space7+1..space8-1],',');
 //self.word9  := stringlib.stringfilterout(le.name_standard[space8+1..space9-1],',');
 //self.word10 := stringlib.stringfilterout(le.name_standard[space9+1..space10-1],',');

 //self.word1  := le.name_standard[1..space1-1];
 //self.word2  := le.name_standard[space1+1..space2-1];
 //self.word3  := le.name_standard[space2+1..space3-1];
 //self.word4  := le.name_standard[space3+1..space4-1];
 //self.word5  := le.name_standard[space4+1..space5-1];
 //self.word6  := le.name_standard[space5+1..space6-1];
 //self.word7  := le.name_standard[space6+1..space7-1];
 //self.word8  := le.name_standard[space7+1..space8-1];
 //self.word9  := le.name_standard[space8+1..space9-1];
 //self.word10 := le.name_standard[space9+1..space10-1];
 
 self        := le;
end;

shared p10 := project(in_ds,xform1(left));
p10_for_sequencing := p10(nametype='B');
ut.MAC_Sequence_Records(p10_for_sequencing,record_id,p10_sequenced);

shared p1 := p10_sequenced;
//output(p1,named('p1'));

r2 xform2(r2 le, integer c) := transform
 self.word_denormd := choose(c,le.word1,le.word2,le.word3,le.word4,le.word5,
                               le.word6,le.word7,le.word8,le.word9,le.word10
														);
 self := le;
end;

p2 := normalize(p1,10,xform2(left,counter));
f1 := p2(word_denormd<>'') : persist('persist::jet_epic_word_occurrences');
//f1 := dataset('~thor400_20::persist::jet_epic_word_occurrences',recordof(f10),flat);

r3 := record
 string30   word         := f1.word_denormd;
 integer    word_ct      := count(group);
 integer    edist        := 0;
 decimal6_2 edist_scaled := 0;
 string30   word_correct := '';
 boolean    word_correct_is_subset_of_word:=false;
 boolean    word_is_subset_of_word_correct:=false;
end;

ta1 := table(distribute(f1,hash(word_denormd)),r3,word_denormd,local) : persist('persist::jet::ta1');

r4 := record
 string30   word;
 integer    word_ct;
 integer    edist;
 decimal6_2 edist_scaled;
 string30   word_correct;
 boolean    word_correct_is_subset_of_word;
 boolean    word_is_subset_of_word_correct;
end;

fn_test(dataset(recordof(ta1)) in_ds, string word_to_compare) := function

//test_cases      := in_ds(length(trim(word))>6 and word[1]=word_to_compare[1] and word<>word_to_compare);
//try_later       := in_ds(~(length(trim(word))>6 and word[1]=word_to_compare[1] and word<>word_to_compare));
test_cases      := in_ds(edist<>1);
already_edisted := in_ds(edist=1);

//output(word_corp);

r4 xform3(test_cases le) := transform

 boolean is_plural := le.word+'S'=word_to_compare or word_to_compare+'S'=le.word;

 self.word_correct    := word_to_compare;
 self.word            := le.word;
 self.word_ct         := le.word_ct;
 self.edist           := if(is_plural,skip,stringlib.editDistance(le.word,word_to_compare));//exclude pluralization
 self.edist_scaled    := if(is_plural,skip,(self.edist * 100) / length(le.word));
 self.word_correct_is_subset_of_word := self.word_correct=self.word[2..] or self.word_correct=self.word[1..length(trim(self.word))-1];
 self.word_is_subset_of_word_correct := self.word=self.word_correct[1..length(trim(self.word_correct))-1];
 //self.edist_attempted := length(trim(word))>6 and word[1]=word_to_compare[1] and word<>word_to_compare;
end;

j1 := project(test_cases,xform3(left));

concat := already_edisted+j1;

return concat;
end;

word_mortgage       := fn_test(ta1,'MORTGAGE');
word_corporation    := fn_test(word_mortgage,'CORPORATION');
word_development    := fn_test(word_corporation,'DEVELOPMENT');
word_properties     := fn_test(word_development,'PROPERTIES');
word_association    := fn_test(word_properties,'ASSOCIATION');
word_investments    := fn_test(word_association,'INVESTMENT');
word_enterprises    := fn_test(word_investments,'ENTERPRISE');
word_communities    := fn_test(word_enterprises,'COMMUNITIES');
word_construction   := fn_test(word_communities,'CONSTRUCTION');
word_transportation := fn_test(word_construction,'TRANSPORTATION');
word_international  := fn_test(word_transportation,'INTERNATIONAL');

shared edist1_results := word_international(edist=1);

r8:= record
 edist1_results.word;
 edist1_results.word_ct;
 edist1_results.word_correct;
 edist1_results.word_correct_is_subset_of_word;
 edist1_results.word_is_subset_of_word_correct;
 //count_ := count(group);
end;
//ta7 := sort(table(edist1_results,r8,word,word_ct,word_correct,word_correct_is_subset_of_word,word_is_subset_of_word_correct,few),word_correct,word);
ta7 := project(edist1_results,r8);
export ta7_debugging := ta7;
//output(ta7,all,named('corrected_name_distribution'));

//output(count(edist1_results),named('edist1_results_ct'));
//output(edist1_results,named('edist1_results_sample'));

r2 xform4a(r2 le, recordof(edist1_results) ri) := transform self.word1_is_variant :=le.word1 =ri.word and le.word1<>'',  self.word1_corrected  := if(self.word1_is_variant, ri.word_correct,''),self := le, self := ri; end;
r2 xform4b(r2 le, recordof(edist1_results) ri) := transform self.word2_is_variant :=le.word2 =ri.word and le.word2<>'',  self.word2_corrected  := if(self.word2_is_variant, ri.word_correct,''),self := le, self := ri; end;
r2 xform4c(r2 le, recordof(edist1_results) ri) := transform self.word3_is_variant :=le.word3 =ri.word and le.word3<>'',  self.word3_corrected  := if(self.word3_is_variant, ri.word_correct,''),self := le, self := ri; end;
r2 xform4d(r2 le, recordof(edist1_results) ri) := transform self.word4_is_variant :=le.word4 =ri.word and le.word4<>'',  self.word4_corrected  := if(self.word4_is_variant, ri.word_correct,''),self := le, self := ri; end;
r2 xform4e(r2 le, recordof(edist1_results) ri) := transform self.word5_is_variant :=le.word5 =ri.word and le.word5<>'',  self.word5_corrected  := if(self.word5_is_variant, ri.word_correct,''),self := le, self := ri; end;
r2 xform4f(r2 le, recordof(edist1_results) ri) := transform self.word6_is_variant :=le.word6 =ri.word and le.word6<>'',  self.word6_corrected  := if(self.word6_is_variant, ri.word_correct,''),self := le, self := ri; end;
r2 xform4g(r2 le, recordof(edist1_results) ri) := transform self.word7_is_variant :=le.word7 =ri.word and le.word7<>'',  self.word7_corrected  := if(self.word7_is_variant, ri.word_correct,''),self := le, self := ri; end;
r2 xform4h(r2 le, recordof(edist1_results) ri) := transform self.word8_is_variant :=le.word8 =ri.word and le.word8<>'',  self.word8_corrected  := if(self.word8_is_variant, ri.word_correct,''),self := le, self := ri; end;
r2 xform4i(r2 le, recordof(edist1_results) ri) := transform self.word9_is_variant :=le.word9 =ri.word and le.word9<>'',  self.word9_corrected  := if(self.word9_is_variant, ri.word_correct,''),self := le, self := ri; end;
r2 xform4j(r2 le, recordof(edist1_results) ri) := transform self.word10_is_variant:=le.word10=ri.word and le.word10<>'', self.word10_corrected := if(self.word10_is_variant,ri.word_correct,''),self := le, self := ri; end;

j2a := join(p1, edist1_results,left.word1 =right.word,xform4a(left,right),left outer,lookup);
j2b := join(j2a,edist1_results,left.word2 =right.word,xform4b(left,right),left outer,lookup);
j2c := join(j2b,edist1_results,left.word3 =right.word,xform4c(left,right),left outer,lookup);
j2d := join(j2c,edist1_results,left.word4 =right.word,xform4d(left,right),left outer,lookup);
j2e := join(j2d,edist1_results,left.word5 =right.word,xform4e(left,right),left outer,lookup);
j2f := join(j2e,edist1_results,left.word6 =right.word,xform4f(left,right),left outer,lookup);
j2g := join(j2f,edist1_results,left.word7 =right.word,xform4g(left,right),left outer,lookup);
j2h := join(j2g,edist1_results,left.word8 =right.word,xform4h(left,right),left outer,lookup);
j2i := join(j2h,edist1_results,left.word9 =right.word,xform4i(left,right),left outer,lookup);
shared j2j := join(j2i,edist1_results,left.word10=right.word,xform4j(left,right),left outer,lookup);
//output(j2j);

shared f3 := j2j(word1_is_variant=true
       or word2_is_variant=true
			 or word3_is_variant=true
			 or word4_is_variant=true
			 or word5_is_variant=true
			 or word6_is_variant=true
			 or word7_is_variant=true
			 or word8_is_variant=true
			 or word9_is_variant=true
			 or word10_is_variant=true
			 );

shared f3_add_back := j2j(~(word1_is_variant=true
       or word2_is_variant=true
			 or word3_is_variant=true
			 or word4_is_variant=true
			 or word5_is_variant=true
			 or word6_is_variant=true
			 or word7_is_variant=true
			 or word8_is_variant=true
			 or word9_is_variant=true
			 or word10_is_variant=true
			 ));

export variant_samples_debugging := f3;
//output(count(f3),named('f3_ct'));
//output(f3,named('f3'));

f3b := f3(word_correct_is_subset_of_word=false and word_is_subset_of_word_correct=false);
export word_is_subset_debugging := f3b;
//output(count(f3b),named('f3b_ct'));
//output(f3b,named('f3b'));


r6 := record
 f3.name_standard;
 count_ := count(group);
end;

ta5 := sort(table(f3,r6,name_standard,few),-count_);
//output(choosen(ta5,1000),named('ta5'));

r7 := record
 f3.word_correct;
 count_ := count(group);
end;

ta6 := table(f3,r7,word_correct,few);
export ta6_debugging := ta6;
//output(ta6,named('ta6'));

r9 := record
 f3.word1_is_variant;
 f3.word2_is_variant;
 f3.word3_is_variant;
 f3.word4_is_variant;
 f3.word5_is_variant;
 f3.word6_is_variant;
 f3.word7_is_variant;
 f3.word8_is_variant;
 f3.word9_is_variant;
 f3.word10_is_variant;
 count_ := count(group);
end;

ta8 := table(f3,r9,word1_is_variant,word2_is_variant,word3_is_variant,word4_is_variant,word5_is_variant,
                   word6_is_variant,word7_is_variant,word8_is_variant,word9_is_variant,word10_is_variant,
									 few);
//output(sort(ta8,-count_),all,named('ta8'));
export ta8_debugging := ta8;

r2 xform_clean_standard(r2 le) := transform
 self.name_standard_clean := trim(stringlib.stringcleanspaces(if(le.word1_corrected <>'',le.word1_corrected ,le.word1)+' '
                            +if(le.word2_corrected <>'',le.word2_corrected ,le.word2)+' '
														+if(le.word3_corrected <>'',le.word3_corrected ,le.word3)+' '
														+if(le.word4_corrected <>'',le.word4_corrected ,le.word4)+' '
														+if(le.word5_corrected <>'',le.word5_corrected ,le.word5)+' '
														+if(le.word6_corrected <>'',le.word6_corrected ,le.word6)+' '
														+if(le.word7_corrected <>'',le.word7_corrected ,le.word7)+' '
														+if(le.word8_corrected <>'',le.word8_corrected ,le.word8)+' '
														+if(le.word9_corrected <>'',le.word9_corrected ,le.word9)+' '
														+if(le.word10_corrected<>'',le.word10_corrected,le.word10)
														+le.rest_of_string));
 self := le;
end;

export p_clean_standard := project(f3,xform_clean_standard(left))+p10(nametype<>'B')+f3_add_back;

//return p_clean_standard;

end;