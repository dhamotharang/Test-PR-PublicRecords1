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


export DID_Add_MAC_Match_Flex
	(infile, matchset,	//see above
	 ssn_field, dob_field, fname_field, mname_field,lname_field, suffix_field, 
	 prange_field, pname_field, srange_field,zip_field, state_field, phone_field,
	 DID_field,   			
	 outrec, 
	 bool_outrec_has_score, DID_Score_field,	//these should default to zero in definition
	 low_score_threshold,	//dids with a score below here will be dropped 
	 outfile,
	 bool_outrec_has_ssn_append = 'false', ssn_append_field = '',
	 bool_infile_has_name_source = 'false', src_field = '',
	 bool_all_scores ='false',  // will pass through even records with a 100 score							// on to further match macros, to get further scores
	 bool_outrec_has_indiv_scores='false',score_a_field='score_a',score_d_field='score_d',
	 score_s_field='score_s',score_p_field='score_p', score_f_field='score_f', score_n_field = 'score_n',// appends individual match scores
	 bool_clean_addr = 'false', // re-cleans addresses before trying match. 
	 predir_field = 'predir',addr_suffix_field = 'addr_suffix',postdir_field = 'postdir',
	 udesig_field = 'unit_desig',city_field = 'p_city_name', zip4_field = 'zip4') 
	:= macro

import property, ut, header_slimsort, DID_Add, didville, Business_Header_SS, MDR, Business_header, Address, Header, Watchdog,PersonLinkingADL2V3,PersonLinkingADL2,_Control;
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
#uniquename(best_ssn)
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
	#if(bool_outrec_has_ssn_append)
	#uniquename(best_ssn)
    unsigned1 %best_ssn% := 0;
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

//-----------------
//output(%infile_id%);
//-----------------

// IF SSN MATCH WANTED
#uniquename(outfile_ssn)
#uniquename(pre_outfile_ssn)
#uniquename(infile_ADL2)
%infile_ADL2% := %infile_id%;
#if('S' in matchset)
	did_add.Mac_Match_NmSSN(%infile_id%,%pre_outfile_ssn%,
		did_field,%did_score%,
		fname_field,mname_field,lname_field,suffix_field,ssn_field,
		%use_fuzzy%,true,%score_s%,bool_all_scores)	
	did_add.mac_dedup_uid_did(%pre_outfile_ssn%, did_field, %outfile_ssn%)
#else
	%outfile_ssn% := %infile_id%;
#end
//------------------
//output(%outfile_ssn%);
//------------------

// IF ADDRESS MATCH WANTED
#uniquename(outfile_addr)
#uniquename(pre_outfile_addr)

#if('A' in matchset or 'Q' in matchset)
	did_add.Mac_Match_NmAddr(%outfile_ssn%,%pre_outfile_addr%, 
		did_field,%did_score%,
		fname_field,mname_field,lname_field,suffix_field,
		prange_field,pname_field,srange_field,zip_field,state_field,
		%use_fuzzy%,true,%score_a%,bool_all_scores)	
	did_add.mac_dedup_uid_did(%pre_outfile_addr%, did_field, %outfile_addr%)
#else
	%outfile_addr% := %outfile_ssn%;
#end

//-----------------------------
//OUTPUT(%outfile_addr%);
//----------------------

// IF DOB MATCH WANTED
#uniquename(outfile_dob)
#uniquename(pre_outfile_dob)

#if('D' in matchset)
	did_add.Mac_Match_NmDayOBZip(%outfile_addr%,%pre_outfile_dob%,
		did_field,%did_score%,
		fname_field,mname_field,lname_field,suffix_field,dob_field,zip_field,
		state_field,%use_fuzzy%,true,%score_d%,bool_all_scores)	
	did_add.mac_dedup_uid_did(%pre_outfile_dob%, did_field, %outfile_dob%)
#else
	%outfile_dob% := %outfile_addr%;
#end

//--------------------
//output(%outfile_dob%);
//--------------------

// IF PHONE MATCH WANTED
#uniquename(outfile_phone)
#uniquename(pre_outfile_phone)
#if('P' in matchset)
	did_add.Mac_Match_NmPhone(%outfile_dob%,%pre_outfile_phone%,
		did_field,%did_score%,
		fname_field,mname_field,lname_field,suffix_field,phone_field,
		true,%score_p%,bool_all_scores)	
	did_add.mac_dedup_uid_did(%pre_outfile_phone%, did_field, %outfile_phone%)
#else
	%outfile_phone% := %outfile_dob%;
#end

//----------------------
// output(%outfile_phone%);
//----------------------

// if Any 'fuzzy' match wanted
#uniquename(outfile_fuzzy)
#if ('G' in matchset or '4' in matchset or 'Z' in matchset)
	did_add.MAC_Match_Fuzzies(%outfile_phone%,matchset,fname_field,mname_field,
				lname_field,suffix_field,dob_field,ssn_field,zip_field,
				did_field,%did_score%,%outfile_fuzzy%,true,%score_f%,bool_all_scores)
	
	//don't need dedup because it's the last one.
#else
	%outfile_fuzzy% := %outfile_phone%;
#end

//---------------------
 //output(%outfile_fuzzy%);
//---------------------

// if Source match wanted

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
		%infile_id%.temp_id;
		%infile_id%.did_field;
		%infile_id%.%did_score%;
		#if(bool_infile_has_name_source)
		%infile_id%.src_field;
		%infile_id%.%score_n%;
		#end
		%infile_id%.suffix_field;
		%infile_id%.%score_a%;
		%infile_id%.%score_d%;
		%infile_id%.%score_s%;
		%infile_id%.%score_p%;
		%infile_id%.%score_f%;
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

%pre_nmsource_rec% %make_expand%(%infile_slim_rec% l) := transform
	
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
#uniquename(use_xADL2)
%use_xADL2% := _Control.mod_xADLversion.constant_usexADL2;

#if(bool_infile_has_name_source) 
%infile_pre_nmsource% := project(if(%use_xADL2%, %infile_ADL2%,%outfile_fuzzy%), %make_expand%(left));
#else
%infile_pre_nmsource% := if(%use_xADL2%, %infile_ADL2%, %outfile_fuzzy%);

#end

//****** Dedup the matches
#uniquename(pre_all_recs_clean)
DID_Add.MAC_Dedup_DIDs(%infile_pre_nmsource%, temp_id, did_field, %did_score%,
					   %pre_all_recs_clean%,bool_outrec_has_indiv_scores,%score_a%,%score_d%,%score_s%,%score_p%,%score_f%)
		
//---------------------------
//output(%pre_all_recs_clean%);
//---------------------------

#uniquename(outfile_source)

#if(bool_infile_has_name_source and ('A' in matchset or 'Q' in matchset))

DID_Add.MAC_Match_NmSource(%pre_all_recs_clean%,%outfile_source%,
                            temp_id,did_field,%did_score%,low_score_threshold,src_field,
	                        %fname%,%mname%,%lname%,suffix_field,
							%prange%,%pname%,%srange%,%zip%,%ssn%,%dob%,true,%score_n%)

#elseif(bool_infile_has_name_source and 'S' in matchset)
DID_Add.MAC_Match_NmSource_NoAddr(%pre_all_recs_clean%,%outfile_source%,
                            temp_id,did_field,%did_score%,low_score_threshold,src_field,
	                        %fname%,%mname%,%lname%,suffix_field,
							%prange%,%pname%,%srange%,%zip%,%ssn%,%dob%,true,%score_n%)

#else
%outfile_source% := %pre_all_recs_clean%;
#end

//---------------------
//output(%outfile_source%);
//---------------------

//****** Take the DID and score off the dedupped rec and put it back on the orig
#uniquename(arc_dist)
#uniquename(all_recs_clean)
    %arc_dist% := distribute(%outfile_source%, hash(temp_id));	
/*
		#if('S' in matchset)
			ssn_field, 
		#end
		#if('D' in matchset)
			dob_field, 
		#end
		fname_field, mname_field,lname_field, suffix_field, 
		#if('A' in matchset or 'Q' in matchset)
			prange_field, pname_field, srange_field, state_field,
		#end
		#if('A' in matchset or 'Q' in matchset or 'D' in matchset)
			zip_field, 
		#end
		#if('P' in matchset)
			phone_field,
		#end
		1));	//the one just keeps the commas from messing it up
*/	

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

#uniquename(outfile_no_need_ADL2)
#uniquename(outfile_need_ADL2)
%outfile_no_need_ADL2%    := %all_recs_clean%(did_field > 0 or (fname_field = '' and lname_field = ''));
%outfile_need_ADL2% := %all_recs_clean%(~(did_field > 0 or (fname_field = '' and lname_field = '')));

// output(count(%all_recs_clean%(did_field > 0)), named('cnt_src_did'));
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


//*********************
//****** 		ROXIE route
//*********************

#uniquename(roxprep)
didville.Layout_DID_InBatch %roxprep%(%pre_infile_id% l) := transform
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
%roxin% := distribute(project(if(%use_xADL2%, %outfile_need_ADL2%,%pre_infile_id%), %roxprep%(left)),hash(random()));

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
DID_Add_Mac_Match_Roxie(%roxin%, %roxout%, %opts%)


//** Reappend the full rec
#uniquename(postrox)
typeof(%pre_infile_id%) %postrox%(%pre_infile_id% l, %roxout% r) := transform
	self.did_field := if (r.score >= low_score_threshold,r.did,0);
	self.%did_score% := if (r.score >= low_score_threshold, r.score,0);
  #if(bool_outrec_has_ssn_append)
	    // self.ssn_append_field := if(self.did_field > 0, r.max_ssn, '');
	    self.ssn_append_field := if(self.did_field > 0, r.best_ssn, '');
  #end
	self := L;
end;

#uniquename(roxplus)
%roxplus% := 
join(
	if(
		%use_xADL2%,
		%outfile_need_ADL2%,
		%pre_infile_id%
	), 
	%roxout%,
	left.temp_id = right.seq,
	%postrox%(left, right),
	hash,
	keep(1) //xadl2 occasionally will return dups, since this macro gives dups the same uniqueid
);

#uniquename(roxplus_ADL2)
%roxplus_ADL2% := %roxplus% + %outfile_no_need_ADL2%;

#uniquename(strip_id_roxie)
outrec %strip_id_roxie%(%roxplus% L) := transform
	self.did_field := L.did_field;
	#if(bool_outrec_has_score)
			self.DID_Score_field := l.%did_score%;
	#end
	self := L;
end;

#uniquename(strip_id_roxie)
outrec %strip_id_roxie%(%roxplus% L) := transform
	self.did_field := L.did_field;
	#if(bool_outrec_has_score)
			self.DID_Score_field := l.%did_score%;
	#end
	self := L;
end;


//************use xADL2 when xADL2 switch on*******************
//prepare the layout and call ADL2 macro
//only passing the records w/o DID from source matching to xADL2
#uniquename(infile_xadl2)
%infile_xadl2% := project(%outfile_need_ADL2%, transform(PersonLinkingADL2V3.layout_Person_xADL2,
                                             self.uniqueid := left.temp_id,
								 			#if('S' in matchset or '4' in matchset)
											 self.ssn5 := PersonLinkingADL2.mod_SSNParse(left.ssn_field).ssn5,
											 self.ssn4 := PersonLinkingADL2.mod_SSNParse(left.ssn_field).ssn4,
											#else
											 self.ssn5 := '',
											 self.ssn4 := '',
											#end
											 self.fname := left.fname_field,
											 self.mname := left.mname_field,
											 self.lname := left.lname_field,
											#if('A' in matchset)
   										     self.prim_range := left.prange_field,
				                             self.prim_name  := left.pname_field,
				                             self.sec_range  := left.srange_field, 
											 self.name_suffix := left.suffix_field,
											 self.city := '',
											 self.state := left.state_field,
											#else
											 self.prim_range := '',
				                             self.prim_name  := '',
				                             self.sec_range  := '', 
											 self.name_suffix := '',
											 self.city := '',
											 self.state := '',
											#end
											#if('A' in matchset or 'D' in matchset or 'Z' in matchset)
											self.zip := left.zip_field,
											#else
											self.zip := '',
											#end
											#if('P' in matchset)
 											 self.phone := left.phone_field,
											 #else
											 self.phone := '',
											 #end
											 #if('D' in matchset or 'G' in matchset)
		                                     self.dob:= (string8)left.dob_field;
	                                         #else
		                                     self.dob := '';
	                                         #end
											 self.did    := 0,
                                             self := left,  
											 self := []));
											 
//output(count(infile), named('cnt_infile'));

#uniquename(outfile_ADL2)
#uniquename(all_recs_clean_ADL2)
DID_Add.mac_match_flex_ADL2(%infile_xadl2%, %outfile_ADL2%)
//-------------
//output(%outfile_ADL2%);
//-------------

//combine all records from xADL2 and source matching
                                                                                                               
//****** Reappend the full rec
	#uniquename(putemback_ADL2)
    typeof(%outfile_need_ADL2%) %putemback_ADL2%(%outfile_need_ADL2% l, %outfile_ADL2% r) := transform 
		self.did_field := if (r.score >= low_score_threshold,r.did,0);
	    self.%did_score% := if (r.score >= low_score_threshold, r.score,0);
		self := l;
	end;
		
%all_recs_clean_ADL2% := join(distribute(%outfile_need_ADL2%,hash(temp_id)),
	                distribute(%outfile_ADL2%,hash(reference)),
				    left.temp_id = right.reference,
					%putemback_ADL2%(left, right), left outer, local) + %outfile_no_need_ADL2%;
//-------------
//output(%all_recs_clean_ADL2%);
//-------------
#uniquename(force)
string4 %force% := '' : stored('did_add_force');

//********* Pick which route to go
/***************************************************************************
   combine name source matching with other hitting thor conditions, name source
   matching need expand one source field and join source matching file after join with
   other slimsort files.
***************************************************************************/
#uniquename(hit_thor)
%hit_thor% := (bool_infile_has_name_source and ~%use_xADL2%) or %force%='thor' or (count(infile) > 15000000 and %force% <> 'roxi' and thorlib.nodes() >= 400);

#uniquename(preclean)
// %preclean% := if(%hit_thor%, 
			  // project(if(%use_xADL2%,%all_recs_clean_ADL2%,%all_recs_clean%),%strip_id%(LEFT)), 
			  // project(if(%use_xADL2%,%roxplus_ADL2%,%roxplus%),%strip_id_roxie%(LEFT)));
%preclean% := project(if(%use_xADL2%,%roxplus_ADL2%,%roxplus%),%strip_id_roxie%(LEFT));


outfile := %preclean%;
endmacro;