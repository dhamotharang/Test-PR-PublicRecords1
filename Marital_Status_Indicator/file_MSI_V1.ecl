import doxie, dx_header, header, marital_status_indicator, models, risk_indicators, ut;

/*
Here are the current rules:

1.  Deceased are not given a marital status.
2.  Widows/Widowers are given a marital status of W.
3.  Divorced and remarried people are given a status of M.
4.  Divorced and unmarried people are given a status of D.
5.  Deceased partners are marked with an X.
 
To attain a status of M, a bi-directional link must be established.
To attain a status of D, a uni-directional link must be found.
To attain a status of W, a uni-directional link must be established with a Date Of Death or
                         a bi-directional link with a Date Of Death.

1.  Take relationship file and append:
			DOB
			First_Name
			Middle_Name
			Last_Name
			Date_of_Death
			Last 3 previous Last_Names
			Gender

2.  Drop relatives without the same last name
3.  Remove business associates
4.  Remove odd addresses
5.  Impute missing genders
6.  Remove relationships where gender1 = gender2
7.  Remove known minors
8.  Remove relatives where Age difference is greater than 18 years
9.  JOIN the file to itself WHERE Person1 links to Person2 AND Person2 links to Person1 (bi-directional)
			-If DOD_Person1 then Flag Deceased (X)
			-If DOD_Person2 then flag Widowed/Widower (W)
			-Else Married (M)

10. JOIN the file to itself WHERE Person1 links to Person2 AND Person2 does not link to Person1 (uni-directional)
			-If DOD_Person1 then Flag Deceased (X)
			-If DOD_Person2 then flag Widowed/Widower (W)
			-Else Divorced (D)

Caveats:
Our BEST Name is not the CURRENT name, but the name that is most frequently reported in the header data.
Last_Name chronology can be useful to look for name changes, however, this is culture specific.
*/

layout_recs := record
		UNSIGNED6		did;
end;
layout_lname := record
	QSTRING20 	lname;
	UNSIGNED3		date_name_first_seen;
end;
layout_slim_header := record
	UNSIGNED6 	did;
	QSTRING5    title;
	QSTRING20   fname;
	QSTRING20   mname;
	QSTRING20   lname;
	QSTRING20		best_lname;
	QSTRING5  	name_suffix;
	STRING10		prim_range;
	STRING2			predir;
	STRING28		prim_name;
	STRING8			sec_range;
	STRING5			zip;
	STRING1  		gender;
	INTEGER4    dob;
	UNSIGNED1		age;
	dataset(layout_lname) last_names{maxcount(100)};
	BOOLEAN			name_change_event;
	UNSIGNED2		lname_cnt;
	UNSIGNED3		date_name_first_reported;
	UNSIGNED3		dt_first_seen;
	UNSIGNED3		dt_nonglb_last_seen;
end;
layout_relatives := record
	STRING1			marital_status;
	STRING1			gender1;
	INTEGER4    dob1;
	QSTRING8    dod1;
	QSTRING20   lname1;
	QSTRING20   mname1;
	QSTRING20   fname1;
	STRING10		prim_range1;
	STRING8			sec_range1;
	recordof(doxie.Key_Relatives);
	STRING1			gender2;
	INTEGER4    dob2;
	QSTRING8    dod2;
	QSTRING20   lname2;
	QSTRING20   mname2;
	QSTRING20   fname2;
	STRING10		prim_range2;
	STRING8			sec_range2;
	INTEGER4		dob_diff;
end;
layout_sample_base := record
		UNSIGNED6		did;
		QSTRING5    title;
		QSTRING20   fname;
		QSTRING20   mname;
		QSTRING20   lname;
		QSTRING5  	name_suffix;
		STRING1			gender;
		STRING6  		date_of_birth;
		STRING5 		spouse_title;
		STRING20 		spouse_fname;
		STRING20 		spouse_mname;
		STRING20 		spouse_lname;
		STRING1  		spouse_gender;
		STRING6  		spouse_date_of_birth;
		STRING1  		spouse_indicator;
    STRING6  		refresh_date;
		string10		prim_range;
		string2			predir;
		string28		prim_name;
		string4			addr_suffix;
		string2			postdir;
		string10		unit_desig;	
		string8			sec_range;	
		string25		p_city_name;	
		string25		v_city_name; 
		string2			st;		
		string5			zip;	
		string4			zip4;	
		string4			cart;
		string1			cr_sort_sz;
		string4			lot;
		string1			lot_order;
		string2			dbpc;
		string1			chk_digit;
		string2			rec_type;
		string5			county;
		string10		geo_lat;
		string11		geo_long;
		string4			msa;
		string7			geo_blk;
		string1			geo_match;
		string4			err_stat;
end;
layout_pre_final := record
		UNSIGNED6 	did;
		QSTRING5    title;
		QSTRING20   fname;
		QSTRING20   mname;
		QSTRING20   lname;
		QSTRING5  	name_suffix;			
		QSTRING20		best_lname;
		QSTRING20		married_lname;
		QSTRING20		previous_lname;
		STRING10		prim_range;
		STRING2			predir;
		STRING28		prim_name;
		STRING8			sec_range;
		STRING5			zip;
		STRING1  		gender;
		INTEGER4    dob;
		QSTRING8    dod;
		UNSIGNED1		age;		
		//spouse information
		UNSIGNED6		spouse_did;
		UNSIGNED6		potential_spouse_did; //if marital status is 'D'
		QSTRING20		spouse_fname;
		QSTRING20		spouse_mname;
		QSTRING20		spouse_lname;
		STRING1			spouse_gender;
		INTEGER4		spouse_dob;
		QSTRING8    spouse_dod;
		UNSIGNED1		spouse_age;
		//spouse match variables
		STRING1			marital_status;	//(W)idowed, (M)arried, (D)ivorced, (X)Deceased, (S)ibling
		BOOLEAN			rel_address;  //prim = prim or 0 or -3
		BOOLEAN			rel_vehicle;  //prim = -6
		BOOLEAN			rel_property; //prim = -5
		BOOLEAN			rel_SSN;  		//prim = -1
		BOOLEAN			rel_Spouse;  	//prim = -7
		BOOLEAN			name_change_event;
		INTEGER4		number_cohabits;
		INTEGER4		recent_cohabit;
		UNSIGNED2		lname_cnt;
		dataset(layout_lname) last_names{maxcount(100)};
end;

layout_final := record
		UNSIGNED6 	did;
		QSTRING5    title;
		QSTRING20   fname;
		QSTRING20   mname;
		QSTRING20   lname;
		QSTRING5  	name_suffix;			
		STRING10		prim_range;
		STRING2			predir;
		STRING28		prim_name;
		STRING8			sec_range;
		STRING5			zip;
		STRING1  		gender;
		INTEGER4    dob;
		QSTRING8    dod;
		UNSIGNED1		age;		
		//spouse information
		UNSIGNED6		spouse_did;
		UNSIGNED6		potential_spouse_did; //if marital status is 'D'
		QSTRING20		spouse_fname;
		QSTRING20		spouse_mname;
		QSTRING20		spouse_lname;
		STRING1			spouse_gender;
		INTEGER4		spouse_dob;
		QSTRING8    spouse_dod;
		UNSIGNED1		spouse_age;
		//spouse match variables
		STRING1			marital_status;	//(W)idowed, (M)arried, (D)ivorced, (X)Deceased, (S)ibling
		BOOLEAN			rel_address;  //prim = prim or 0 or -3
		BOOLEAN			rel_vehicle;  //prim = -6
		BOOLEAN			rel_property; //prim = -5
		BOOLEAN			rel_SSN;  		//prim = -1
		BOOLEAN			rel_Spouse;  	//prim = -7
		BOOLEAN			name_change_event;
		INTEGER4		number_cohabits;
		INTEGER4		recent_cohabit;
		UNSIGNED2		lname_cnt;
//more target DID information
		QSTRING20		married_lname;
		QSTRING20		previous_lname;	
		QSTRING20		best_lname;
		QSTRING20		prev_lname1;
		UNSIGNED3		lname1_dt_first_seen;
		QSTRING20		prev_lname2;
		UNSIGNED3		lname2_dt_first_seen;
		QSTRING20		prev_lname3;
		UNSIGNED3		lname3_dt_first_seen;
end;



//
// data sets
header_file_dist 		:= distribute(Header.File_Headers, did);
relatives_file_dist := distribute(Header.File_Relatives_full, person1);
best_file_dist 			:= distribute(marital_status_indicator.key_MSI_best_did, did);

//join sample dids to Header.File_Headers and grab up to 100 names per DID
layout_slim_header addHeaderSample(relatives_file_dist l, header_file_dist r) := transform
	self.did := l.person1;
	self.title := r.title;
	self.fname := r.fname;
	self.mname := r.mname;
	self.lname := models.common.getw( r.lname, 1 );
	self.name_suffix := r.name_suffix;
	self.dob := r.dob;
	self.last_names := dataset([{models.common.getw(r.lname, 1), r.dt_first_seen}], layout_lname);
	self.date_name_first_reported := r.dt_vendor_first_reported;
	self.dt_nonglb_last_seen := r.dt_nonglb_last_seen;
	self.dt_first_seen := r.dt_first_seen;
	self := [];
end;

header_sample := join(relatives_file_dist, header_file_dist,
	left.person1 = right.did,
	addHeaderSample(left,right),Left Outer, keep(100), local);

//consolidate last name child sets and sort from most recent to oldest
header_sample_dist := distribute(header_sample, did);
names_deduped := dedup(sort(header_sample_dist, did, lname, -dt_nonglb_last_seen, local), did, lname, local);
names_deduped_dist := distribute(names_deduped, did);
names_sorted := sort(names_deduped_dist, did, -dt_first_seen, local);

//collapse last name child record sets by last name using 80% match as threshold
layout_slim_header namesRoll(layout_slim_header l, layout_slim_header r) := transform
	name_score := Risk_Indicators.LnameScore(l.lname, l.last_names[1].lname);
	self.last_names := if(name_score > 80, l.last_names + r.last_names, l.last_names);
	self := l;
end;
names_rolled := rollup(names_sorted, namesRoll(left,right), did, local);

names_rolled_dist := distribute(names_rolled, did);

// standardize last name and infer gender and age
layout_slim_header inferPersonData(names_rolled_dist l) := transform
	self.gender := if(l.title <> '', if(l.title ='MR', 'M', 'F'), if(l.name_suffix <>'', 'M', ''));
	self.name_change_event := if(l.title <>'MR', if(count(l.last_names)>=2, TRUE, FALSE), FALSE);
	self := l;
end;
complete_header := project(names_rolled_dist, inferPersonData(left), local);

complete_header_dist := distribute(complete_header, did);

// get remaining genders from key_did_lookups
did_lookup := pull(dx_header.key_did_lookups());
did_lookup_dist := distribute(did_lookup, did);
layout_slim_header addBestGender(complete_header_dist l, did_lookup_dist r) := transform
	self.gender := if(l.gender ='', r.gender, l.gender);
	self := l;
	self := [];
end;

header_best_gender := join(complete_header_dist, did_lookup_dist,
	left.did = right.did,
	addBestGender(left, right), keep(1), local);

header_best_gender_dist := distribute(header_best_gender, did);

// join to header.best to get best last name and prim range
layout_slim_header addBestLast(header_best_gender_dist l, best_file_dist r) := transform
	self.best_lname := models.common.getw(r.lname, 1);
	self.prim_range := r.prim_range;
	self.prim_name := r.prim_name;
	self.predir := r.predir;
	self.sec_range := r.sec_range;
	self.zip := r.zip;
	birthday := if(l.dob = 0, r.dob, l.dob);
	self.dob := birthday;
	self.age := if(birthday>0,(integer)ut.getdate[1..4] - (integer)birthday[1..4],0);
	self := l;
	self := [];
end;

header_best := join(header_best_gender_dist, best_file_dist,
	left.did = right.did,
	addBestLast(left, right), keep(1), local);

// join to header.File_Relatives to find relatives
layout_relatives addRelativeSample(relatives_file_dist l, relatives_file_dist r) := transform
	self := r;
	self := [];
end;

relatives_sample := join(relatives_file_dist, relatives_file_dist,
	left.person1 = right.person1 and
	right.prim_range <> -2 and right.prim_range >= -7 and
	right.same_lname,  //drop all relatives without same name,
	addRelativeSample(left, right), keep(20), local);

relatives_filtered_sample_dist := distribute(relatives_sample, person1);

// join to best to fill in person1 detail
layout_relatives addTargetData(relatives_filtered_sample_dist l, best_file_dist r) := transform
	self.dob1 := r.dob;
	self.dod1 := r.dod;
	self.fname1 := models.common.getw(r.fname, 1); //truncates two names to the first name
	self.mname1 := models.common.getw(r.mname, 1); //truncates two names to the first name
	self.lname1 := models.common.getw(r.lname, 1); //truncates two names to the first name
	self.prim_range1 := r.prim_range;
	self.sec_range1 := r.sec_range;
	self := l;
	self := [];
end;

target_data := join(relatives_filtered_sample_dist, best_file_dist,
	left.person1 = right.did,
	addTargetData(left, right), keep(20), local);

target_data_dist := distribute(target_data, person2);

// join to best to fill in person2 detail
layout_relatives addRelativeData(target_data_dist l, best_file_dist r) := transform
	self.dob2 := r.dob;
	self.dod2 := r.dod;
	self.fname2 := models.common.getw(r.fname, 1); //truncates two names to the first name
	self.mname2 := models.common.getw(r.mname, 1); //truncates two names to the first name
	self.lname2 := models.common.getw(r.lname, 1); //truncates two names to the first name
	self.prim_range2 := r.prim_range;
	self.sec_range2 := r.sec_range;
	self := l;
	self := [];
end;

relatives_data := join(target_data_dist, best_file_dist,
	left.person2 = right.did,
	addRelativeData(left, right), keep(20), local);

relatives_data_dist := distribute(relatives_data, person1);

// get remaining gender1 from key_did_lookups
layout_relatives addBestGender1(relatives_data_dist l, did_lookup_dist r) := transform
	self.gender1 := if(l.gender1 ='', r.gender, l.gender1);
	self := l;
	self := [];
end;

header_best_gender1 := join(relatives_data_dist, did_lookup_dist,
	left.person1 = right.did,
	addBestGender1(left, right),keep(1),local);

header_best_gender1_dist := distribute(header_best_gender1, person2);

// get remaining gender2 from key_did_lookups
layout_relatives addBestRelGender(header_best_gender1_dist l, did_lookup_dist r) := transform
	self.gender2 := if(l.gender2 ='', r.gender, l.gender2);
	self := l;
	self := [];
end;

header_bestRel_gender := join(header_best_gender1_dist, did_lookup_dist,
	left.person2 = right.did,
	addBestRelGender(left, right),keep(1),local);

header_bestRel_gender_dist := distribute(header_bestRel_gender, hash32(fname1));

//final gender pass where gender is U or N or blank
gender_fname := pull(marital_status_indicator.key_gender_fname);
gender_fname_dist := distribute(gender_fname, hash32(fname));
layout_relatives addStatGender1(header_bestRel_gender_dist l, gender_fname_dist r) := transform
	gender := if(r.F > r.M, 'F', 'M');	
	self.gender1 := if(l.gender1 IN ['N','U',''], gender, l.gender1);
	self := l;
	self := [];
end;

header_stat_gender1 := join(header_bestRel_gender_dist, gender_fname_dist,
	left.fname1 = right.fname,
	addStatGender1(left, right), left outer,keep(1),local);

header_stat_gender1_dist := distribute(header_stat_gender1, hash32(fname2));

//final gender pass where gender is U or N or blank
layout_relatives addStatGender2(header_stat_gender1_dist l, gender_fname_dist r) := transform
	gender := if(r.F > r.M, 'F', 'M');		
	self.gender2 := if(l.gender2 IN ['N','U',''], gender, l.gender2);
	self := l;
	self := [];
end;

header_StatRel_gender := join(header_stat_gender1_dist, gender_fname_dist,
	left.fname2 = right.fname,
	addStatGender2(left, right), left outer, local);
	
/////////////end data collection
//filter minors and child DIDs where the first and middle names are mixed up causing an ID split
header_StatRel_gender_dist := distribute(header_StatRel_gender, person1);
relatives_filtered := sort(header_StatRel_gender_dist((dob2<19940101), fname1 <> fname2, fname1 <> mname2, mname1 <> fname2), -lname1, -recent_cohabit, local);

//filter out where genders are equal
relatives_gender_filt := relatives_filtered(gender1 <> gender2);

//calculate age
layout_relatives calcDobDiff(relatives_gender_filt l) := transform
	self.dob_diff := if(l.dob1 > 0 and l.dob2 > 0, abs((integer)l.dob1[1..4]-(integer)l.dob2[1..4]),-1);
	self := l;
end;
relatives_dob_pre_filt := project(relatives_gender_filt, calcDobDiff(left), local);

// filter dob differences > 18 years - a threshold set to prevent children from matching to parents
relatives_dob_filt := relatives_dob_pre_filt(dob_diff < 18);

relatives_dob_filt_dist := distribute(relatives_dob_filt, person1);
final := sort(relatives_dob_filt_dist, -lname1, -recent_cohabit, prim_range, local);

final_left  := final(person1 > person2);
final_left_dist := distribute(sort(final_left, person1), hash32(person1, person2));
final_right := final(person1 < person2);
final_right_dist := distribute(sort(final_right, person2), hash32(person2, person1));


//Bi-directional relationships
bi_directional := join(final_left_dist, final_right_dist, 
			left.person1=right.person2 and 
			left.person2=right.person1, 
			transform(layout_relatives, self := left),full outer, local);

bi_directional_dist := distribute(bi_directional, person1);

//Append marital status
layout_relatives appendMaritalStatus(layout_relatives l) := transform
	status := MAP(l.dod1 <> ''	=> 'X', //deceased
								l.dod2 <> ''	=> 'W', //widowed/widower
								'M');	
	self.marital_status := status;
	self := l;
end;
Married_current := project(bi_directional_dist, appendMaritalStatus(left), local);

Married_current_dist := distribute(Married_current, person1);

//rollup married
Married_current_sort := sort(Married_current_dist, person1, -recent_cohabit, local);

layout_relatives cleanMarried(layout_relatives l, layout_relatives r) := transform
	self := if(l.recent_cohabit >= r.recent_cohabit, l, r);
end;
Married_current_cleaned := rollup(Married_current_sort, cleanMarried(left,right), person1, local);

Married_current_cleaned_dist := distribute(Married_current_cleaned, person2);
married_too := group(sort(Married_current_cleaned_dist, person2, -recent_cohabit, local), person2, local);


layout_relatives cleanDivorces(layout_relatives l, layout_relatives r) := transform
	self.marital_status := if(l.marital_status ='M' and r.marital_status='M', 'D', r.marital_status);
	self := r;
end;
Current_div_cleaned := iterate(married_too, cleanDivorces(left,right));

Current_div_cleaned_dist := distribute(Current_div_cleaned, person1);

//join back to main file
layout_pre_final addFinal(header_best l, Current_div_cleaned_dist r) := transform
 	self.did := r.person1;
	self.title := l.title;;
  self.fname := r.fname1;
  self.mname := r.mname1;;
  self.lname := r.lname1;
  self.name_suffix := l.name_suffix;	
	self.married_lname  := if(l.gender <> 'M', if(l.prim_range = (string)r.prim_range, r.lname2, ''), l.best_lname);
	self.previous_lname := if(l.gender <> 'M', l.last_names[2].lname, l.best_lname);
	// self.best_lname := l.;
	// self.married_lname := l.;
	// self.previous_lname := l.;
	self.prim_range :=l.prim_range;
	self.predir :=l.predir;
	self.prim_name :=l.prim_name;
	self.sec_range :=l.sec_range;
	self.zip :=l.zip;
  self.gender :=r.gender1;
  self.dob :=r.dob1;
  self.dod :=r.dod1;
	self.age :=l.age;		
	//spouse information
	self.spouse_did := if(r.marital_status = 'D', 0, r.person2); 
	self.potential_spouse_did := if(r.marital_status = 'D', r.person2, 0); 
	self.spouse_fname := r.fname2;
	self.spouse_mname := r.mname2;
	self.spouse_lname := r.lname2;
	self.spouse_gender := r.gender2;
	self.spouse_dob := r.dob2;
	self.spouse_dod := r.dod2;
	self.spouse_age := if(r.dob2>0,(integer)ut.getdate[1..4] - (integer)r.dob2[1..4],0);					
	//spouse match variables
	self.marital_status := r.marital_status;	//(W)idowed, (M)arried, (D)ivorced, (X)Deceased, (S)ibling	
	self.name_change_event := l.name_change_event;
	self.rel_address := r.prim_range in [0, -3] OR r.prim_range > 0;  
  self.rel_vehicle := r.prim_range = -6; 
	self.rel_property:= r.prim_range = -5;
	self.rel_SSN := r.prim_range = -1;
	self.rel_Spouse := r.prim_range = -7;
	self.number_cohabits := r.number_cohabits;
	self.recent_cohabit := r.recent_cohabit;
	self := l;
	self := [];
end;

data_final := join(header_best, Current_div_cleaned_dist,
	left.did = right.person1,
	addFinal(left, right), keep(1), local);

protoFinal := project(data_final, transform(layout_final, self := left; self :=[]));

//number sorted header records by did to allow for last name sequence analysis
layout_final fillNameData(layout_final l, layout_pre_final r, integer seq) := transform	
			self.did := l.did;
			self.prev_lname1 		:= r.last_names[1].lname;
			self.prev_lname2 		:= r.last_names[2].lname;
			self.prev_lname3 		:= r.last_names[3].lname;
			
			self.lname1_dt_first_seen 	:= r.last_names[1].date_name_first_seen;			
			self.lname2_dt_first_seen 	:= r.last_names[2].date_name_first_seen;			
			self.lname3_dt_first_seen 	:= r.last_names[3].date_name_first_seen;
			self := l;
		end;

norm_header := DENORMALIZE(protoFinal, data_final, 
																 left.did = right.did, 
																 fillNameData(left,right,counter), local); 

EXPORT file_MSI_V1 := norm_header;
