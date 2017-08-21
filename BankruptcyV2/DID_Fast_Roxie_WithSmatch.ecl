/*  Comments:
allows you to pull the individual scores for regression testing
*/
//MATCHSET should be set of char1's indicating matchfields
/*
   matchset   -    should be set of char1's indicating the indicatives in infile
                          'A' = Address
                          'D' = DOB
                          'S' = ssn
                          'P' = phone
    ***                   'Q' = Address match excluding the fuzzy logic.  Equivalent to setting use_fuzzy = false in previous versions.  Acts the same regardless of whether matchset contains 'A'.
					 '4' = ssn4 matching (last 4 digits of ssn)
					 'G' = age matching
					 'Z' = zip code matching
*/


export DID_Fast_Roxie_WithSmatch
	(infile, matchset,	//see above
	 ssn_field, dob_field, fname_field, mname_field,lname_field, suffix_field, 
	 prange_field, pname_field, srange_field,zip_field, state_field, phone_field,
	 DID_field,   			
	 outrec, 
	 bool_outrec_has_score, DID_Score_field,	//these should default to zero in definition
	 low_score_threshold,	//dids with a score below here will be dropped 
	 outfile,
	 bool_infile_has_name_source = 'false', src_field = '',
	 bool_all_scores ='false',  // will pass through even records with a 100 score							// on to further match macros, to get further scores
	 bool_outrec_has_indiv_scores='false',score_a_field='score_a',score_d_field='score_d',
	 score_s_field='score_s',score_p_field='score_p', score_f_field='score_f', score_n_field = 'score_n',// appends individual match scores
	 bool_clean_addr = 'false', // re-cleans addresses before trying match. 
	 predir_field = 'predir',addr_suffix_field = 'addr_suffix',postdir_field = 'postdir',
	 udesig_field = 'unit_desig',city_field = 'p_city_name', zip4_field = 'zip4') 
	:= macro

import property, ut, header_slimsort, DID_Add, didville, Business_Header_SS, MDR, Business_header, Address, Header, Watchdog;
#uniquename(use_fuzzy)
%use_fuzzy% := 'Q' not in matchset;

#uniquename(inf) 	
#if (bool_clean_addr)
	#uniquename(pre_clean_rec)
	#uniquename(addr1)
	#uniquename(addr2)
	%pre_clean_rec% := record,maxlength(10000)
		infile;
		string120	%addr1%;
		string120	%addr2%;
	end;

	#uniquename(into_clean)
	%pre_clean_rec% %into_clean%(infile L) := transform
		self.%addr1% := address.Addr1FromComponents(L.prange_field,L.predir_field,
									L.pname_field,L.addr_suffix_field,L.postdir_field,
									L.udesig_field,L.srange_field);
		self.%addr2% := address.Addr2FromComponents(l.city_field,L.state_field,L.zip_field+L.zip4_field);
		self := L;
	end;

	#uniquename(file_pre_clean)
	%file_pre_clean% := project(infile,%into_clean%(LEFT));

	#uniquename(file_cleaned)
	address.MAC_Address_Clean(%file_pre_clean%,%addr1%,%addr2%,true,%file_cleaned%)

	#uniquename(clean_fill)
	infile %clean_fill%(%file_cleaned% L) := transform
		self.prange_field := l.clean[1..10];
		self.Predir_field := l.clean[11..12];
		self.pname_field := l.clean[13..40];
		self.addr_Suffix_field := l.clean[41..44];
		self.Postdir_field := l.clean[45..46];
		self.udesig_field := l.clean[47..56];
		self.SRange_field := l.clean[57..64];
		self.City_field := l.clean[65..89];
		self.State_field := l.clean[115..116];
		self.Zip_field := l.clean[117..121];
		self.Zip4_field := l.clean[122..125];
		self := L;
	end;

	%inf% := group(project(%file_cleaned%,%clean_fill%(LEFT)));
#else
	%inf% := group(infile);
#end

#uniquename(did_score)
#uniquename(score_a)
#uniquename(score_d)
#uniquename(score_s)
#uniquename(score_p)
#uniquename(score_f)
#uniquename(pg_score)
#uniquename(id_layout)
%id_layout% := record,maxlength(10000)
	unsigned6 temp_ID;
	unsigned1 %did_score% := 0;	//i will use my scoring fields regardless, and then assign at the end
	unsigned1 %score_a% := 0;
	unsigned1 %score_d% := 0;
	unsigned1 %score_s% := 0;
	unsigned1 %score_p% := 0;
	unsigned1 %score_f% := 0;
	#if(bool_infile_has_name_source)
	#uniquename(score_n)
    unsigned1 %score_n% := 0;
	#end
	outrec;
end;

#uniquename(make_id_layout)
%id_layout% %make_id_layout%(%inf% l) := transform
	self.temp_ID := 0;
	self := l;
end;

#uniquename(infile_pre_id)
#uniquename(pre_infile_id)
%infile_pre_id% := project(%inf%, %make_id_layout%(left));			
ut.MAC_Sequence_Records(%infile_pre_id%,temp_ID,%pre_infile_id%)	

#uniquename(infile_id)	

	#uniquename(infile_dist)
    %infile_dist% := distribute(%pre_infile_id%(~(fname_field = '' and lname_field = '')), hash(
		#if('S' in matchset or '4' in matchset)
			ssn_field, 
		#end
		#if('D' in matchset or 'G' in matchset)
			dob_field, 
		#end
		fname_field, mname_field,lname_field, suffix_field,
		#if('A' in matchset or 'Q' in matchset)
			prange_field, pname_field, srange_field,  
		#end
		#if('A' in matchset or 'Q' in matchset or 'D' in matchset or 'Z' in matchset)
			state_field,zip_field, 
		#end
		#if('P' in matchset)
			phone_field,
		#end
        #if(bool_infile_has_name_source)
		src_field,
		#end
		1));	//the one just keeps the commas from messing it up
	#uniquename(infile_srtd)
    %infile_srtd% := sort(%infile_dist%, 
		#if('S' in matchset or '4' in matchset)
			ssn_field, 
		#end
		#if('D' in matchset or 'G' in matchset)
			dob_field, 
		#end
		fname_field, mname_field,lname_field, suffix_field,
		#if('A' in matchset or 'Q' in matchset)
			prange_field, pname_field, srange_field,
		#end
		#if('A' in matchset or 'Q' in matchset or 'D' in matchset or 'Z' in matchset)
			state_field,zip_field, 
		#end
		#if('P' in matchset)
			phone_field, 
		#end
		#if(bool_infile_has_name_source)
		src_field,
		#end
		local);	
#uniquename(infile_grpd)
    %infile_grpd% := group(%infile_srtd%, 
		#if('S' in matchset or '4' in matchset)
			ssn_field, 
		#end
		#if('D' in matchset or 'G' in matchset)
			dob_field, 
		#end
		fname_field, mname_field,lname_field, suffix_field,
		#if('A' in matchset or 'Q' in matchset)
			prange_field, pname_field, srange_field, 
		#end
		#if('A' in matchset or 'Q' in matchset or 'D' in matchset or 'Z' in matchset)
			state_field,zip_field, 
		#end
		#if('P' in matchset)
			phone_field, 
		#end
		#if(bool_infile_has_name_source)
		src_field,
		#end
		local);
	#uniquename(rid_em)
    %id_layout% %rid_em%(%id_layout% l, %id_layout% r) := transform
		self.temp_id := if (l.temp_id = 0, r.temp_id, l.temp_id);
		self := r;
	end;
	
	#uniquename(infile_iter)
	#uniquename(infile_slim)
	#uniquename(infile_slim_rec)
    %infile_iter% := iterate(%infile_grpd%, %rid_em%(left, right));	//this is where i will slap the DIDs back on				 	
	%infile_slim_rec% := record,maxlength(10000)
		%infile_iter%.temp_id;
		%infile_iter%.did_field;
		%infile_iter%.%did_score%;
		%infile_iter%.%score_a%;
		%infile_iter%.%score_d%;
		%infile_iter%.%score_s%;
		%infile_iter%.%score_p%;
		%infile_iter%.%score_f%;
		%infile_iter%.fname_field; 
		%infile_iter%.mname_field;
		%infile_iter%.lname_field;
		%infile_iter%.suffix_field; 
		#if('S' in matchset or '4' in matchset)
			%infile_iter%.ssn_field; 
		#end
		#if('D' in matchset or 'G' in matchset)
			%infile_iter%.dob_field; 
		#end
		#if('A' in matchset or 'Q' in matchset)
			%infile_iter%.prange_field; 
			%infile_iter%.pname_field;
			%infile_iter%.srange_field;
		#end				
		#if('A' in matchset or 'Q' in matchset or 'D' in matchset or 'Z' in matchset)
		%infile_iter%.state_field;
		%infile_iter%.zip_field; 
		#end
		#if('P' in matchset)
			%infile_iter%.phone_field;
		#end
        #if(bool_infile_has_name_source)
		%infile_iter%.src_field;
		%infile_iter%.%score_n%;
		#end

	end;
	%infile_slim% := table(%infile_iter%, %infile_slim_rec%);
	%infile_id% := group(dedup(%infile_slim%, temp_id));

#uniquename(outfile_fuzzy)
%outfile_fuzzy% := %infile_id%;

// if Source match wanted
/*
#uniquename(fname)
#uniquename(mname)
#uniquename(lname)
#uniquename(ssn)
#uniquename(dob)
#uniquename(prange)
#uniquename(pname)
#uniquename(srange)
#uniquename(zip)
#uniquename(state)
#uniquename(pre_nmsource_rec)
#uniquename(make_expand)

%pre_nmsource_rec% := record,maxlength(10000)
		%outfile_fuzzy%.temp_id;
		%outfile_fuzzy%.did_field;
		%outfile_fuzzy%.%did_score%;
		#if(bool_infile_has_name_source)
		%outfile_fuzzy%.src_field;
		%outfile_fuzzy%.%score_n%;
		#end
		%outfile_fuzzy%.suffix_field;
		%outfile_fuzzy%.%score_a%;
		%outfile_fuzzy%.%score_d%;
		%outfile_fuzzy%.%score_s%;
		%outfile_fuzzy%.%score_p%;
		%outfile_fuzzy%.%score_f%;
		string20  %fname%;
		string20  %mname%;
		string20  %lname%;	    
		string10  %prange%; 
		string28  %pname%;
		string8   %srange%;
		string5   %zip%;
		string9   %ssn%; 
		unsigned4 %dob%; 
	end;

%pre_nmsource_rec% %make_expand%(%outfile_fuzzy% l) := transform
	
    #if('S' in matchset or '4' in matchset)
	self.%ssn% := l.ssn_field; 
	#else
    self.%ssn% := ''; 
	#end
    #if('D' in matchset or 'G' in matchset)
	self.%dob% := (unsigned4)l.dob_field; 
	#else
	self.%dob% := 0; 
	#end
	#if('A' in matchset or 'Q' in matchset)
	self.%prange% := l.prange_field; 
	self.%pname% := l.pname_field;
	self.%srange% := l.srange_field;
	#else
	self.%prange% := ''; 
	self.%pname%  := '';
	self.%srange% := '';
	#end
	#if('A' in matchset or 'Q' in matchset or 'D' in matchset or 'Z' in matchset)
    self.%zip%  := l.zip_field;
	#else
	self.%zip%  := '';
	#end
	self.%fname% := l.fname_field;
	self.%mname% := l.mname_field;
	self.%lname% := l.lname_field;
	self := l;
end;

#uniquename(infile_pre_nmsource)

#if(bool_infile_has_name_source) 
%infile_pre_nmsource% := project(%outfile_fuzzy%, %make_expand%(left));
#else
%infile_pre_nmsource% := %outfile_fuzzy%;
#end

//****** Dedup the matches
#uniquename(pre_all_recs_clean)
DID_Add.MAC_Dedup_DIDs(%infile_pre_nmsource%, temp_id, did_field, %did_score%,
					   %pre_all_recs_clean%,bool_outrec_has_indiv_scores,%score_a%,%score_d%,%score_s%,%score_p%,%score_f%)
		
//---------------------------
//output(%pre_all_recs_clean%);
//---------------------------

#uniquename(outfile_source)



DID_Add.MAC_Match_NmSource(%pre_all_recs_clean%,%outfile_source%,
                            temp_id,did_field,%did_score%,low_score_threshold,src_field,
	                        %fname%,%mname%,%lname%,suffix_field,
							%prange%,%pname%,%srange%,%zip%,%ssn%,%dob%,true,%score_n%)

*/
//---------------------
//output(%outfile_source%);
//---------------------

//****** Take the DID and score off the dedupped rec and put it back on the orig
#uniquename(arc_dist)
#uniquename(all_recs_clean)
    %arc_dist% := distribute(%outfile_fuzzy%, hash(temp_id));	


	#uniquename(putemback)
    %id_layout% %putemback%(%id_layout% l, %arc_dist% r) := transform
		self.did_field := r.did_field;
		self.%did_score% := r.%did_score%;
		self.%score_a% := r.%score_a%;
		self.%score_d% := R.%score_d%;
		self.%score_p% := R.%score_p%;
		self.%score_s% := r.%score_s%;
		self.%score_f% := r.%score_f%;
		#if(bool_infile_has_name_source)
		self.%score_n% := r.%score_n%;
		#end
		self := l;
	end;
	
	%all_recs_clean% := join(distribute(%infile_iter%,hash(temp_id)), %arc_dist%,
						     left.temp_id = right.temp_id,
							 %putemback%(left, right), left outer, local) + %pre_infile_id%(fname_field = '' and lname_field= '');

//-------------
// output(%all_recs_clean%);
//-------------


#uniquename(max2)
#uniquename(max4)
#uniquename(arg1)
#uniquename(arg2)
#uniquename(arg3)
#uniquename(arg4)
integer %max2%(integer L, integer R) := if (L>R,L,R);
integer %max4%(integer %arg1%,integer %arg2%, integer %arg3%, integer %arg4%) :=
		%max2%(%max2%(%arg1%,%arg2%),%max2%(%arg3%,%arg4%));


//****** Strip off the temp_id (and optionally assign the scores)
#uniquename(strip_id)

outrec %strip_id%(%id_layout% l) := transform
	self.did_field := if(l.%did_score% < low_score_threshold, 0, l.did_field);

	#if(bool_outrec_has_score)
			self.DID_Score_field := l.%did_score%;
	#end
	#if(bool_outrec_has_indiv_scores)
		self.score_a_field := L.%score_a%;
		self.score_d_field := L.%score_d%;
		self.score_s_field := L.%score_s%;
		self.score_p_field := L.%score_p%;
		self.score_f_field := L.%score_f%;
		#if(bool_infile_has_name_source)
        self.score_n_field := L.%score_n%;
		#end
	#end
	self := l;
end;

#uniquename(get_smatch)
%get_smatch% := project(%all_recs_clean%, %strip_id%(left)); // not using now

#uniquename(id_layout1)
%id_layout1% := record,maxlength(10000)
	unsigned6 temp_ID;
	unsigned1 %did_score% := 0;	//i will use my scoring fields regardless, and then assign at the end
	unsigned1 %score_a% := 0;
	unsigned1 %score_d% := 0;
	unsigned1 %score_s% := 0;
	unsigned1 %score_p% := 0;
	unsigned1 %score_f% := 0;
	#if(bool_infile_has_name_source)
	#uniquename(score_n)
    unsigned1 %score_n% := 0;
	#end
	outrec;
end;

#uniquename(make_id_layout1)
%id_layout1% %make_id_layout1%(%get_smatch% l) := transform
	self.temp_ID := 0;
	self := l;
end;

#uniquename(pre_infile_id2)
#uniquename(infile_pre_id2)

%infile_pre_id2% := project(%get_smatch%, %make_id_layout1%(left));			
ut.MAC_Sequence_Records(%infile_pre_id2%,temp_ID,%pre_infile_id2%)



//*********************
//****** 		ROXIE route
//*********************

#uniquename(roxprep)
didville.Layout_DID_InBatch %roxprep%(%pre_infile_id2%  l) := transform
	#if('S' in matchset or '4' in matchset)
		self.ssn := (qSTRING9)l.ssn_field;
	#else
		self.ssn := '';
	#end
	#if('D' in matchset or 'G' in matchset)
		self.dob:= (qSTRING8)l.dob_field;
	#else
		self.dob := '';
	#end
	#if('A' in matchset)
		self.prim_range := (qSTRING10)l.prange_field;
		self.predir := '';
		self.prim_name := (qSTRING28)l.pname_field;
		self.addr_suffix := '';
		self.postdir := '';
		self.unit_desig := '';
		self.sec_range := (qSTRING8)l.srange_field; 
		self.st := (qSTRING2)l.state_field;
	#else
		self.prim_range := '';
		self.predir := '';
		self.prim_name := '';
		self.addr_suffix := '';
		self.postdir := '';
		self.unit_desig := '';
		self.sec_range := '';
		self.st := '';
	#end
	#if('A' in matchset or 'D' in matchset or 'Z' in matchset)
		self.z5 := (qSTRING5)l.zip_field;
	#else
		self.z5 := '';
	#end
	#if('P' in matchset)
		self.phone10 := (qstring10)l.phone_field;
	#else
		self.phone10 := '';
	#end
	self.seq := l.temp_id;
	self.fname := (qSTRING20)l.fname_field;
	self.mname := (qSTRING20)l.mname_field;
	self.lname := (qSTRING20)l.lname_field;
	self.suffix := (qSTRING5)l.suffix_field; 
	self.title := '';
	self.p_city_name := '';
	self.zip4 := '';
end;

#uniquename(roxin)
%roxin% := distribute(project(%pre_infile_id2%, %roxprep%(left)),hash(random()));

#uniquename(opts)
%opts% := 
#if('Z' in matchset)
	'ZIP,' + 
#end
#if('G' in matchset)
	'AGE,' + 
#end
#if('4' in matchset)
	'SSN' + 
#end
'';
#uniquename(roxout)
did_add.MAC_Match_Roxie(%roxin%, %roxout%, %opts%)

//** Reappend the full rec
#uniquename(postrox)
typeof(%pre_infile_id2%) %postrox%(%pre_infile_id2% l, %roxout% r) := transform
	self.did_field := if (r.score >= low_score_threshold,r.did,0);
	self.%did_score% := if (r.score >= low_score_threshold, r.score,0);
	self := l;
end;


#uniquename(roxplus)
%roxplus% := join(%pre_infile_id2%, %roxout%,
				left.temp_id = right.seq,
				%postrox%(left, right),hash);


#uniquename(fname)
#uniquename(mname)
#uniquename(lname)
#uniquename(ssn)
#uniquename(dob)
#uniquename(prange)
#uniquename(pname)
#uniquename(srange)
#uniquename(zip)
#uniquename(state)
#uniquename(pre_nmsource_rec)
#uniquename(make_expand)

%pre_nmsource_rec% := record,maxlength(10000)
		%roxplus%.temp_id;
		%roxplus%.did_field;
		%roxplus%.%did_score%;
		#if(bool_infile_has_name_source)
		%roxplus%.src_field;
		%roxplus%.%score_n%;
		#end
		%roxplus%.suffix_field;
		%roxplus%.%score_a%;
		%roxplus%.%score_d%;
		%roxplus%.%score_s%;
		%roxplus%.%score_p%;
		%roxplus%.%score_f%;
		string20  %fname%;
		string20  %mname%;
		string20  %lname%;	    
		string10  %prange%; 
		string28  %pname%;
		string8   %srange%;
		string5   %zip%;
		string9   %ssn%; 
		unsigned4 %dob%; 
	end;

%pre_nmsource_rec% %make_expand%(%roxplus% l) := transform
	
    #if('S' in matchset or '4' in matchset)
	self.%ssn% := l.ssn_field; 
	#else
    self.%ssn% := ''; 
	#end
    #if('D' in matchset or 'G' in matchset)
	self.%dob% := (unsigned4)l.dob_field; 
	#else
	self.%dob% := 0; 
	#end
	#if('A' in matchset or 'Q' in matchset)
	self.%prange% := l.prange_field; 
	self.%pname% := l.pname_field;
	self.%srange% := l.srange_field;
	#else
	self.%prange% := ''; 
	self.%pname%  := '';
	self.%srange% := '';
	#end
	#if('A' in matchset or 'Q' in matchset or 'D' in matchset or 'Z' in matchset)
    self.%zip%  := l.zip_field;
	#else
	self.%zip%  := '';
	#end
	self.%fname% := l.fname_field;
	self.%mname% := l.mname_field;
	self.%lname% := l.lname_field;
	self := l;
end;

#uniquename(infile_pre_nmsource)

#if(bool_infile_has_name_source) 
%infile_pre_nmsource% := project(%roxplus%, %make_expand%(left));
#else
%infile_pre_nmsource% := %roxplus%;
#end

//****** Dedup the matches
#uniquename(pre_all_recs_clean)
DID_Add.MAC_Dedup_DIDs(%infile_pre_nmsource%, temp_id, did_field, %did_score%,
					   %pre_all_recs_clean%,bool_outrec_has_indiv_scores,%score_a%,%score_d%,%score_s%,%score_p%,%score_f%)
		
//---------------------------
//output(%pre_all_recs_clean%);
//---------------------------

#uniquename(outfile_source)



DID_Add.MAC_Match_NmSource(%pre_all_recs_clean%,%outfile_source%,
                            temp_id,did_field,%did_score%,low_score_threshold,src_field,
	                        %fname%,%mname%,%lname%,suffix_field,
							%prange%,%pname%,%srange%,%zip%,%ssn%,%dob%,true,%score_n%)





#uniquename(strip_id_roxie)
// string all but temp_id
{outrec, %roxplus%.temp_id } %strip_id_roxie%(%roxplus% L) := transform
	self.did_field := L.did_field;
	#if(bool_outrec_has_score)
			self.DID_Score_field := l.%did_score%;
	#end
	self := L;
end;

#uniquename(preclean)
%preclean% := project(%roxplus%,%strip_id_roxie%(LEFT));


outfile := project(%preclean%(did_field > 0), {outrec})+
join(
	%preclean%(did_field = 0),
	%outfile_source%(did_field > 0),
	left.temp_id = right.temp_id,
	transform(
		{outrec},
		self.did_field := right.did_field,
		#if(bool_outrec_has_score)
			self.DID_Score_field := right.%did_score%,
		#end
		self := left
	),
	hash,
	left outer,
	keep(1)				//just in case
);


endmacro;