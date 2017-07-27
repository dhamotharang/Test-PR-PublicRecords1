export Mac_Match_NmDayobZip(infile,outfil,
					did_field,score_field,
					fname_field,mname_field,lname_field,suffix_field,dob_field,zip_field,
					state_field,use_fuzzy = 'true',bool_indiv_score = 'false',
					score_d_field='score_d',bool_all_scores = 'false') := macro

#uniquename(canodist)
#uniquename(didfilter)
%canodist% := header_slimsort.File_name_dayob;
#if(~bool_all_scores)
%didfilter% := infile.did_field = 0 or infile.score_field < 90;
#else
%didfilter% := true;
#end

#uniquename(ca)
%ca% := %canodist%;//DISTRIBUTE(%canodist%, HASH(mob, trim((string)lname))); // NEED TO BE ABLE TO ASSUME DISTRIBUTION AFTER BUILD
// dobs considered to be an integer of form YYYYMMDD or YYYYMM

#uniquename(ca_alph)
#uniquename(dob_alph_rec)
#uniquename(ca_alph_rec)
#uniquename(into_dob_alph)

%dob_alph_rec% := record
	infile;
	string2	alphinit;
end;

%dob_alph_rec% %into_dob_alph%(infile L) := transform
	self.alphinit := ut.alphinit2(datalib.preferredFirstNew(L.fname_field,Header_Slimsort.Constants.UsePFNew)[1],L.lname_field[1]);
	self := L;
end;

%ca_alph% := %ca%;
%ca_alph_rec% := %ca_alph%;

/* ******* JOIN RULE 1 ***************
	dob / f&l name */
#uniquename(min2)
integer %min2% (integer l, integer r) := IF(l<r,l,r);
#uniquename(min5)
integer %min5% (integer l1, integer l2, integer l3, integer l4, integer l5) := %min2%(%min2%(%min2%(l1,l2),%min2%(l3,l4)),l5);
#uniquename(dob_tra)
%dob_alph_rec% %dob_tra%(%dob_alph_rec% l, %ca_alph% r) := transform
		
		localscore := (integer)(9000 / %min5%( 
						r.dob_fnname_dids,
					     IF ((integer)l.dob_field < 10000000 or (integer)l.dob_field % 100 <= 1 or r.dayob <= 1,99999,r.dob_fnname_dob_dids),
						IF( datalib.preferredFirstNew(l.mname_field,Header_Slimsort.Constants.UsePFNew)=datalib.preferredFirstNew(r.mname,Header_Slimsort.Constants.UsePFNew) and r.dob_fnmname_dids<>0, r.dob_fnmname_dids,99999 ),
						IF( (string5)l.zip_field=r.zip and (integer)r.zip > 0 and r.dob_fnname_zip_dids<>0, r.dob_fnname_zip_dids, 99999 ),
				        IF( l.state_field=r.st and r.st <> '' and r.dob_fnname_st_dids<>0, r.dob_fnname_st_dids, 99999 )
				));
		self.score_field :=	did_add.compute_score(l.did_field, r.did, l.score_field, localscore);
		self.did_field := did_add.pick_DID(l.did_field, r.did, l.score_field, self.score_field);
		#if (bool_indiv_score)
			self.score_d_field := if (self.did_field = r.did, localscore, l.score_d_field);
		#end
		
	self := l;
end;
#uniquename(infile_id_attempt)
#uniquename(infile_id_skip)
%infile_id_attempt% := distribute(project(infile((integer)dob_field <> 0 and (%didfilter%)),%into_dob_alph%(LEFT)),hash(ut.mob((integer)dob_field),alphinit)); //,trim((string)lname_field)));
%infile_id_skip% := infile(~((integer)dob_field <> 0 and (%didfilter%)));

#uniquename(dob_join)
%dob_join% := join(
	%infile_id_attempt%,%ca_alph%,
	 datalib.preferredFirstNew(left.fname_field,Header_Slimsort.Constants.UsePFNew) = right.fname and
	 left.lname_field = right.lname and
	 left.alphinit = right.alphinit and
	 ut.mob((integer)left.dob_field) = right.mob and
	 ((integer)left.dob_field < 10000000 
		or (integer)left.dob_field % 100 = right.dayob
		or (integer)left.dob_field % 100 <= 1
		or right.dayob <= 1),
     %dob_tra%(left, right), local, left outer,
	atmost(datalib.preferredFirstNew(left.fname_field,Header_Slimsort.Constants.UsePFNew) = right.fname and
	 left.lname_field = right.lname and left.alphinit = right.alphinit and 
	 ut.mob((integer)left.dob_field) = right.mob,1000));
//output(%dob_join%);
/*---------*/
// There is a dist problem with this join.
// I can't distribute by just mob, because i get 
// row-array-too-large errors at runtime.
// it was dist by mob,lname but that doesn't work for this
// join.  I had it dist by mob,dayob but that throws off
// the "right.dayob <= 1" compare below (except where left.dayob is
// also <= 1).

// I am trying to dist by an "alphinit"
// as a way of splitting the losses from a name dist.

//the records with ADL's only on name zip match go through name DOB check
#uniquename(dob_join2)
%dob_join2% := join(
	%dob_join%(did_field = 0 or score_field = DID_Add.mod_hard_scores.zip_dist_score),%ca_alph%(~near_name),
	 ut.mob((integer)left.dob_field) = right.mob and
	 left.alphinit = right.alphinit and
	 ((integer)left.dob_field > 10000000 and
	 (integer)left.dob_field % 100  = right.dayob) and
      ut.NameMatch(datalib.preferredFirstNew(left.fname_field,Header_Slimsort.Constants.UsePFNew),datalib.preferredFirstNew(left.mname_field,Header_Slimsort.Constants.UsePFNew),left.lname_field, //add pf(mname)
				 right.fname,right.mname,right.lname) < 3,
	%dob_tra%(LEFT,RIGHT),local,left outer,
	atmost(ut.mob((integer)left.dob_field) = right.mob and
		  (integer)left.dob_field % 100 = right.dayob and left.alphinit = right.alphinit,1000));
//output(%dob_join2%);
#uniquename(into_out)

typeof(infile) %into_out%(%dob_alph_rec% L) := transform
	self := L;
end;

outfil := 
	#if(use_fuzzy)
		project(%dob_join2% + %dob_join%(did_field != 0 and score_field != DID_Add.mod_hard_scores.zip_dist_score),%into_out%(LEFT)) + %infile_id_skip%;
	#else
		project(%dob_join%,%into_out%(LEFT)) + %infile_id_skip%;
	#end

endmacro;