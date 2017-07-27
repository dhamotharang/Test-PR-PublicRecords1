//Replicates logic in person_models.FN_Relative_Details for the data layer
import doxie, ut, person_models, NID, header,doxie_raw, watchdog;
EXPORT fn_relative_title(rel,head):= functionmacro

con := header.relative_titles;

set_gender_unks  := ut.GenderTools .set_gender_unks;
set_gender_known := ut.GenderTools .set_gender_known;

//****** ADD AGE AND GENDER
gender_diff(string1 l,string1 r) := ut.GenderTools .diff(l,r);																					
gend(string fname, string mname) := ut.GenderTools .gender(fname,mname);

cln := header.fn_clean_rel_names(head);

re := record
	unsigned6 person1;
  unsigned8 person2;
	boolean subject;
	unsigned p2_sort;
	unsigned2 number_cohabits;
	integer3 recent_cohabit;
	unsigned4 dob;
	unsigned1 age;
	string1 gender;
	string20 fname;
	string20 lname;
	unsigned4 r_first_seen := 0;
	unsigned4 r_last_seen := 0;
	boolean early_lname := false;
	unsigned1 parent_lnames_count := 0;
	boolean subject_early_lname := false;
  end;
  
re xf_re(head l) := transform
  self.person2 := l.did;
	self.person1 := l.did;
	self.subject := true;
	self.age := if(l.dob=0,0,ut.GetAgeI(l.dob));
	self.gender := gend(l.fname, l.mname);
	self := l;
	self := [];
end;
  
tore := project(cln, xf_re(left));

//****** ROLLUP THE AGE
re rollage(re l, re r) := transform
	self.age := if(l.age = 0, r.age, l.age);
  self := l;
end;

tore_sort := sort(distribute(tore, hash(person1)), person1, lname, gender, age, r_first_seen, local);
wage := rollup(tore_sort, left.person1 = right.person1 and left.lname = right.lname and left.gender = right.gender, rollage(left, right), local);
it1 := sort(wage,person1,age,lname,gender, local);

names := header.FN_Person_Names(project(cln, header.Layout_Header));

re xf_en(re le, names ri) := transform
	isMale := le.gender='M';
	isNotFemale := le.gender<>'F';
	hasMulipleLNames := ri.cnt>1;		
	thisYear := (unsigned)ut.GetDate div 10000;
	yearFirstSeen := ut.max2(ri.first_seen div 100,1980);
	
	AgeOfData := ThisYear - yearFirstSeen;
	yrsOlderThanData := le.age - AgeOfData;
	wasYoungWhenFirstData := yrsOlderThanData < 25;

	self.early_lname := isMale or (ri.early_lname and (isNotFemale or wasYoungWhenFirstData or hasMulipleLNames));
	self.r_first_seen := if(ri.first_seen > 0, ri.first_seen, le.r_first_seen);
	self.r_last_seen := if(ri.last_seen > 0, ri.last_seen, le.r_last_seen);
	self := le;
end;

wel_ := join(distribute(it1, hash(person1)), 
            distribute(names, hash(did)),
					  left.person1 = right.did and left.lname = right.lname,
			       xf_en(left, right),
						 local);		

wel_1 := join(distribute(wel_, hash(person1)), 
						distribute(rel, hash(person1)),
						left.person1 = right.person1,
						transform(re,
											self.person2 := right.person2,
											self.subject := false,
											self.number_cohabits := right.number_cohabits,
											self.recent_cohabit := right.recent_cohabit,
											self := left),
						left outer,
						local);
wel := 		sort(distribute(wel_1 + wel_, hash(person1)), person1, -r_last_seen, local);	
	
//***** PUT EACH person1 INTO ONE ROW

rex := record
	boolean inlaw;
	boolean possible_husband;
	boolean possible_wife;
	boolean possible_parent;
	boolean possible_sibling;
	boolean possible_child;
	boolean ex;
	
	boolean gd;
	string1 gender;
	string25 fname;
	string25 lname;
	unsigned2 age;
	string20 debug := '';
	//re2;
end;

re2_ := record
	re.person1;
  re.person2;
	re.subject;
	unsigned4 number_cohabits;
	rel.recent_cohabit;
	unsigned1 title := 0;
	string2 generation := '';
	boolean  clear := false;
	rex reldata;
	dataset(re) person1_recs{maxlength(800000)};
end; 

re2_ xf_re2(re l) := transform
	self.reldata := [];
	self.person1_recs :=  l;
	self := l;
end;

wel2 := project(wel, xf_re2(lefT));

re2_ xf_roll2(re2_ l, re2_ r) := transform
	self.person1_recs := l.person1_recs + if(r.person1 > 0, r.person1_recs);
	self := l;
end;

welroll := rollup(sort(distribute(wel2, hash(person2)), person2, person1, local), left.person2 = right.person2 and left.person1 = right.person1, xf_roll2(left, right)) /* : persist('~persist::relative_welroll::aherzberg')*/;

re2 := record
re2_;
dataset(re) person2_recs{maxlength(800000)};
end;

//****** NOW TRY TO IDENTIFY POTENTIAL RELATIVE CANperson1ATES
GetRelationship(re2_ subject, re2_ other) := module

	shared numco := max(other.person1_recs, number_cohabits);

	shared sub_age := max(subject.person1_recs, age);
	shared other_age := max(other.person1_recs, age);
	
	shared gener := MAP( other_age = 0 or sub_age = 0 => ' ',
											 other_age > sub_age+40       => 'OO',
	                     other_age > sub_age+15       => 'O',
	                     other_age < sub_age-40 		=> 'YY',
	                     other_age < sub_age-15 		=> 'Y',
													   'S' );


	shared get_early_phonetic_lname(re2_ d) := //sort(d.person1_recs(early_lname),r_first_seen,r_last_seen)[1].lname;
   metaphonelib.DMetaPhone1(d.person1_recs(early_lname)[1].lname)[1..6];
	shared get_early_phonetic_lnames(re2_ d) := //sort(d.person1_recs(early_lname),r_first_seen,r_last_seen)[1].lname;
  set(d.person1_recs(early_lname), metaphonelib.DMetaPhone1(lname)[1..6]);
		
	shared get_current_rec(re2_ d) := sort(d.person1_recs,if(early_lname,1,0),-r_last_seen,-r_first_seen)[1];
			 
	shared get_current_lname(re2_ d) := get_current_rec(d).lname;

	shared get_current_phonetic_lname(re2_ d) := metaphonelib.DMetaPhone1(
	                                                       get_current_rec(d).lname)[1..6];

	shared isMale(re2_ d) := exists(d.person1_recs(gender = 'M'));
	shared isFemale(re2_ d) := exists(d.person1_recs(gender = 'F'));

	//needs to be reflexive
	shared hubs(re2_ her, re2_ his) := 
		gener = 'S' and 												//same generation
		(~isFemale(his) or isMale(his)) and  						//he could be male
		(isFemale(her) or ~isMale(her)) and  						//she could be female	
		// count(his.person1_recs) = 1  and			   							//he has one lname
		((exists(his.person1_recs(metaphonelib.DMetaPhone1(lname)[1..6] = get_current_phonetic_lname(her))) and	//they have the same lname now
		  get_current_phonetic_lname(his) <> get_early_phonetic_lname(her))			//but they person1nt used to
		 or ((her.number_cohabits > 50 and ut.GetAge(her.recent_cohabit + '00') < 2) or
		     (his.number_cohabits > 50 and ut.GetAge(his.recent_cohabit + '00') < 2)));
	
	shared pare(re2_ kid, re2_ adult) := 
		exists(adult.person1_recs(metaphonelib.DMetaPhone1(lname)[1..6] = get_early_Phonetic_lname(kid))) or
		(exists(adult.person1_recs(metaphonelib.DMetaPhone1(lname)[1..6] in get_early_phonetic_lnames(kid))) and ismale(kid));  //this gives better chance of finding the parent with a guy, in case he has multiple lnames

	//shared diff_early_lname := get_early_lname(subject) <> get_early_lname(other);
	shared same_early_lname := get_early_phonetic_lname(subject) = get_early_phonetic_lname(other);
	
	//shared diff_current_lname := get_current_lname(subject) <> get_current_lname(other);

	shared boolean L_inlaw := false; //this needs work because it should be sexist
		//diff_early_lname and gener[1] <> 'Y';
	shared boolean L_possible_husband := hubs(subject, other);
	shared boolean L_possible_wife := hubs(other, subject);
	shared boolean L_possible_parent := //same_early_lname and gener='O';
		pare(subject, other) and gener='O';
	shared boolean L_possible_grandparent := //same_early_lname and gener='O';
		pare(subject, other) and gener='OO';
		
	shared boolean L_possible_sibling :=   same_early_lname and gener='S';
	shared boolean L_possible_child := //same_early_lname and gener = 'Y';
		pare(other, subject) and gener='Y';
	shared boolean L_possible_grandchild := //same_early_lname and gener = 'Y';
		pare(other, subject) and gener='YY';
		
	shared boolean L_ex := false;//diff_early_lname and diff_current_lname;// and p_lname<>'';
	
	shared boolean L_gd := false;
	shared string25 L_FName := get_current_rec(other).fname;
	shared string25 L_LName := get_current_lname(other);
	shared unsigned2 L_age := other_age;
	
	shared string1 L_gender := 
		map(isMale(other) and isFemale(other)																									=> 'N',
			  get_current_rec(other).gender in set_gender_known								  								=> get_current_rec(other).gender,
			  exists(other.person1_recs(gender = 'F')) or (L_possible_wife and not L_possible_husband) => 'F',
			  exists(other.person1_recs(gender = 'M')) or (L_possible_wife and not L_possible_husband) => 'M',
																								 'N');

	export title := 
		MAP(L_possible_husband 					=> if( L_gender='M',con.num_Husband,con.num_Spouse),
			L_possible_wife 							=> if( L_gender='F',con.num_Wife,   con.num_Spouse),
			
			L_possible_parent and L_gender='M' 	=> con.num_Father,
			L_possible_parent and L_gender='F' 	=> con.num_Mother,
			L_possible_parent 					=> con.num_Parent,
			
			L_possible_grandparent and L_gender='M' 	=> con.num_Grandfather,
			L_possible_grandparent and L_gender='F' 	=> con.num_Grandmother,
			L_possible_grandparent 					=> con.num_Grandparent,
			
			L_possible_sibling and L_gender='M' => con.num_Brother,
			L_possible_sibling and L_gender='F' => con.num_Sister,
			L_possible_sibling 					=> con.num_Sibling,
			
			L_possible_child and L_gender='M' 	=> con.num_Son,
			L_possible_child and L_gender='F' 	=> con.num_Daughter,
			L_possible_child 					=> con.num_Child,

			L_possible_grandchild and L_gender='M' 	=> con.num_Grandson,
			L_possible_grandchild and L_gender='F' 	=> con.num_Granddaughter,
			L_possible_grandchild 					=> con.num_Gradchild,
			
			L_inlaw 							=> con.num_Inlaw,
													0);
	export number_cohabits := numco;												
	export generation := gener;
	export rd := row({L_inlaw,L_possible_husband,L_possible_wife,L_possible_parent,L_possible_sibling,
					  L_possible_child,L_ex,L_gd,L_gender,L_FName,L_LName,L_age,get_current_lname(subject)}, rex);

end;

//***** GENERATE RELATIONSHIP title
re2 xf_gr(re2_ sub, re2_ oth) := transform
	GR := GetRelationship(sub, oth);
	self.number_cohabits := GR.number_cohabits;
	self.title := GR.title;
	self.reldata := GR.rd;
	self.generation := GR.generation;
	self.person2_recs := sub.person1_recs;
	self := oth;
end;

j := join(distribute(welroll(subject), hash(person2)), 
					distribute(welroll(not subject), hash(person2)),
					left.person2=right.person2, 
					xf_gr(left, right),
					local) /*: persist('~persist::relative_label::aherzberg')*/;
					
//***** GET SOME SUBJECT RECORDS READY TO DEFRAGMENT THE REST
re2 normit(welroll l, integer c) := transform
  self.person2 := l.person2;
	self.person1 := 0;
	self.reldata.fname := l.person1_recs[c].fname;
	self.reldata.lname := l.person1_recs[c].lname;
	self.reldata.age := max(l.person1_recs, age);
	self.subject := true;
	self := [];
end;
welroll_sub := dedup(normalize(welroll(subject), count(left.person1_recs), normit(left, counter)), all);

//***** GET RID OF SOME FRAGMENTS
j2 := join(j, j + welroll_sub,  //subject part doesnt work bc lname and fname are blank
      left.person2 = right.person2 and 
			left.person1 <> right.person1 and
			left.reldata.lname = right.reldata.lname and
			(((left.title = 0 or (left.person1 > right.person1 and (left.title = right.title or left.number_cohabits < right.number_cohabits)))
			   ) or right.subject) and
			(left.reldata.age = 0 or right.reldata.age = 0 or right.reldata.age - left.reldata.age between 0 and 10) and
			(NID.mod_PFirstTools.PFLeqPFR(left.reldata.fname, right.reldata.fname) or
			 ut.stringsimilar(left.reldata.fname,right.reldata.fname) <= 2 or
			 left.reldata.fname = right.reldata.fname[1..length(trim(left.reldata.fname))]),
			left only,
			local)/*: persist('~persist::relative_j2::aherzberg')*/;
					
//***** GET SOME SUBJECT RECORDS READY TO DEFRAGMENT THE REST


//***** FIND MOST CURRENT SPOUSE (if two wives, drop one..thats my policy)
j2_srt := sort(j2, person2, title, -max(person1_recs,recent_cohabit),-max(person1_recs, number_cohabits), local);//here i prefer recency

re2 xf_spouse(re2 l, re2 r) := transform
	rt := r.title;
	self.clear := (rt in con.set_Spouse) and l.title = r.title;
	self := r;
end;

j2_itr := ungroup(iterate(group(j2_srt, person2, title), xf_spouse(left, right)));
j2_clr := project(j2_itr, transform(re2, self.title := if(left.clear, 0, left.title), self := left));//blanking out for now bc this seems too easy to trigger

j2_srt_ := sort(distribute(j2_clr, hash(person1)), person1, title, -max(person1_recs,recent_cohabit),-max(person1_recs, number_cohabits), local);//here i prefer recency
j2_itr_ := ungroup(iterate(group(j2_srt_, person1, title), xf_spouse(left, right)));
j2_clr_ := project(j2_itr_, transform(re2, self.title := if(left.clear, 0, left.title), self := left));//blanking out for now bc this seems too easy to trigger



//***** FIND MOST LIKELY PARENT(if two dads or two moms, drop one)
j2_srt2 := sort(distribute(j2_clr_, hash(person2)), person2, title,-max(person1_recs, number_cohabits), -max(person1_recs,recent_cohabit), local);//but here i prefere the more established relationship

re2 xf_spouse2(re2 l, re2 r) := transform
	rt := r.title;
	self.clear := (rt in con.set_SpecificParent) and l.title = r.title;
	self := r;
end;

j2_itr2 := ungroup(iterate(group(j2_srt2,person2, title), xf_spouse2(left, right)));
j2_clr2 := project(j2_itr2, transform(re2, self.title := if(left.clear, 0, left.title), self := left));//blanking out for now bc this seems too easy to trigger


//out_srt := sort(j2_clr2_, person2, person_models.title_rank(title), max(person1_recs, p2_sort), -reldata.age, person1, record, local);
//***** CHANGE FATHER (OR MOTHER) AND PARENT TO FATHER AND MOTHER 
cp := if(count(j2_clr2(title = con.num_Parent)) = 1, //if we have one unknown
				 map(count(j2_clr2(title = con.num_Father)) = 1 //and if we have one father, then sub mother for 'parent'
						=> project(j2_clr2, transform(re2, self.title := if(left.title = con.num_Parent, con.num_Mother, left.title), self := left)),
				     count(j2_clr2(title = con.num_Mother)) = 1 //and if we have one mother, then sub father for 'parent'
						=> project(j2_clr2, transform(re2, self.title := if(left.title = con.num_Parent, con.num_Father, left.title), self := left)),
						j2_clr2),  //else just return as is
				 j2_clr2);



final_rel := cp ;
return final_rel;
endmacro;

