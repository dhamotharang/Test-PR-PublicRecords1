export Mac_Match_NmPhone(infile,outfile,
					did_field,score_field,
					fname_field,mname_field,lname_field,suffix_field,phone_field,
					bool_indiv_score = 'false',
					score_p_field = 'score_p',bool_all_scores = 'false') := macro

#uniquename(canodist)
#uniquename(didfilter)
%canodist% := distribute(header_slimsort.file_name_phone,hash((string)phone));

#if(~bool_all_scores)
%didfilter% := infile.did_field = 0 or infile.score_field <> 100;
#else
%didfilter% := true;
#end

#uniquename(ca)  
%ca% := %canodist%; // assumed distributed by hash(phone)
/* ******* JOIN RULE 1 ***************
	phone, preferred fname, score for suffix_nonmatch*/
#uniquename(phone_tra)
typeof(infile) %phone_tra%(infile l, %ca% r) := transform
		localscore :=   100 div MAP (
				   datalib.preferredFirstNew(l.mname_field,Header_Slimsort.Constants.UsePFNew)=r.mname and //removed pf mapping on r.mname here as it is already mapped
				   l.lname_field=r.lname and
				   ut.fGetSuffix(l.suffix_field)=ut.fGetSuffix(r.name_suffix) and r.phone_fullname_dids<>0 => r.phone_fullname_dids,
				   l.suffix_field<>'' and
				   ut.fGetSuffix(l.suffix_field)=ut.fGetSuffix(r.name_suffix) and r.phone_fname_suffix_dids<>0 => r.phone_fname_suffix_dids,
				   r.phone_fname_dids);
		self.score_field :=	did_add.compute_score(l.did_field, r.did, l.score_field, localscore);
		self.did_field := did_add.pick_DID(l.did_field, r.did, l.score_field, self.score_field);			
		#if(bool_indiv_score)
			self.score_p_field := if (self.did_field = r.did, localscore,l.score_p_field);
		#end
	self := l;
end;
#uniquename(go)
%go% := length(trim((string)(integer)infile.phone_field))=10 and (%didfilter%);
#uniquename(infile_id_attempt)
%infile_id_attempt% := distribute(infile(%go%),hash((string)phone_field));
#uniquename(infile_id_skip)
%infile_id_skip% := infile(~(%go%));
#uniquename(phone_join)
%phone_join% := join(
	%infile_id_attempt%,%ca%, 
	 datalib.preferredFirstNew(left.fname_field,Header_Slimsort.Constants.UsePFNew) = right.fname and
	 left.phone_field = right.phone
	 ,%phone_tra%(left, right), local, left outer,
	 atmost(datalib.preferredFirstNew(left.fname_field,Header_Slimsort.Constants.UsePFNew) = right.fname and
	 left.phone_field = right.phone,1000));

  outfile := %phone_join%+%infile_id_skip%;

  endmacro;