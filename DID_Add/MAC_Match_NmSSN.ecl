export MAC_Match_NmSSN(infile,outfile,
					did_field,score_field,
					fname_field,mname_field,lname_field,suffix_field,ssn_field,
					bool_use_fuzzy = 'true',bool_indiv_score='false',
					score_s_field='score_s',bool_all_scores = 'false') := macro

IMPORT header_slimsort, ut;

#uniquename(canodist)
#uniquename(didfilter)
%canodist% := sorted(header_slimsort.file_name_ssn,ssn);

#if(~bool_all_scores)
%didfilter% := infile.did_field = 0 or infile.score_field <> 100;
#else
%didfilter% := true;
#end

#uniquename(ca)
%ca% := %canodist%; // assumed distributed by hash(ssn)
/* ******* JOIN RULE 1 ***************
	SSN, preferred fname, score for suffix_nonmatch*/

#uniquename(ssn_tra)
typeof(infile) %ssn_tra%(infile l, %ca% r) := transform
		localscore := (integer)(100 / MAP (
				   datalib.preferredfirstNew(l.fname_field, Header_Slimsort.Constants.UsePFNew)=r.fname and
				   datalib.preferredfirstNew(l.mname_field, Header_Slimsort.Constants.UsePFNew)=r.mname and
				   l.lname_field=r.lname and
				   ut.fGetSuffix(l.suffix_field)=ut.fGetSuffix(r.name_suffix) and r.ssn_fullname_dids <>0 => r.ssn_fullname_dids,
				   datalib.preferredfirstNew(l.fname_field, Header_Slimsort.Constants.UsePFNew)=r.fname and
				   l.lname_field=r.lname and
				   ut.fGetSuffix(l.suffix_field)=ut.fGetSuffix(r.name_suffix) and r.ssn_fname_suffix_dids<>0=> r.ssn_fname_suffix_dids,
				   datalib.preferredfirstNew(l.fname_field, Header_Slimsort.Constants.UsePFNew)=r.fname and r.ssn_fname_dids<>0=>
							r.ssn_fname_dids * if(r.ssn_fname_dids = 1 and r.ssn_dids > 1, 1.01, 1),  //this bit of multiplication allows us to score a max of 99 when only ssn+fname, and thus we attempt other joins downstream
				   r.ssn_dids));
		self.score_field :=	did_add.compute_score(l.did_field, r.did, l.score_field, localscore);
		self.did_field := did_add.pick_DID(l.did_field, r.did, l.score_field, self.score_field);
		#if(bool_indiv_score)
			self.score_s_field := if (self.did_field = R.did,localscore, L.score_s_field);
		#end
	self := l;
end;
#uniquename(infile_id_attempt)
%infile_id_attempt% := distribute(infile((integer)ssn_field <> 0
		and (%didfilter%)),hash((string)ssn_field));



#uniquename(infile_id_skip)
%infile_id_skip% := infile(~((integer)ssn_field <> 0 and (%didfilter%)

));



#uniquename(ssn_join)
%ssn_join% := join(
	%infile_id_attempt%,%ca%,
	 (string9)left.ssn_field = right.ssn and
	 datalib.preferredfirstNew(left.fname_field, Header_Slimsort.Constants.UsePFNew) = right.fname,
	 %ssn_tra%(left, right), local, left outer,
	 atmost((string9)left.ssn_field = right.ssn and
	 datalib.preferredfirstNew(left.fname_field, Header_Slimsort.Constants.UsePFNew) = right.fname,1000));


//------------
//output(%ssn_join%);
//--------------

#uniquename(try_b)
%try_b% := %ssn_join%(did_field = 0);

#uniquename(ssn_join2)
%ssn_join2% := join(
	%try_b%,%ca%(~near_name),
	left.ssn_field = right.ssn and
	ut.NameMatch(datalib.preferredfirstNew(left.fname_field, Header_Slimsort.Constants.UsePFNew),left.mname_field,left.lname_field,
				 right.fname,right.mname,right.lname) < 3,
	%ssn_tra%(LEFT,RIGHT),local,left outer,atmost(left.ssn_field = right.ssn,1000));

//-------------------
//output(%ssn_join2%);
//-------------------

outfile :=
	#if(bool_use_fuzzy)
		%ssn_join2% + %ssn_join%(did_field != 0) + %infile_id_skip%;
	#else
		%ssn_join% + %infile_id_skip%;
	#end

  endmacro;
