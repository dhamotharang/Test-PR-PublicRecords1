export Mac_Match_NmAddr_Sensitive(infile,outfil,
					did_field,score_field,
					fname_field,mname_field,lname_field,suffix_field,
					prim_range_field,prim_name_field,sec_range_field,zip_field,state_field,
					use_fuzzy = 'true',bool_indiv_score = 'false',
					score_a_field = 'score_a',bool_all_scores = 'false') := macro
import didville;
#uniquename(inf_prim_rec)
#uniquename(addr_did)
#uniquename(addr_score)
#uniquename(local_temp_id)
%inf_prim_rec% := record
	infile;
	unsigned6	%local_temp_id%;
	unsigned6	%addr_did%;
	unsigned1	%addr_score%;
end;

#uniquename(into_prim)
%inf_prim_rec% %into_prim%(infile L) := transform
	self.%addr_did% := 0;
	self.%addr_score% := 0;
	self.%local_temp_id% := 0;
	self := l;
end;

#uniquename(inf_prim)
%inf_prim% := project(infile,%into_prim%(LEFT));

#uniquename(canodist)
#uniquename(didfilter)
%canodist% := sorted(header_slimsort.file_name_address,prim_name,prim_range,lname);

#if (~bool_all_scores)
%didfilter% := %inf_prim%.did_field = 0	or %inf_prim%.score_field <> 100;
#else
%didfilter% := true;
#end

#uniquename(ca)
%ca% := %canodist%; 


/* ******* JOIN RULE 1 ***************
	dob / f&l name */
#uniquename(min2)
%min2% (integer2 l, integer2 r) := IF(l<r,l,r);
#uniquename(min4)
%min4% (integer2 l1, integer2 l2, integer2 l3, integer2 l4) := %min2%(%min2%(l1,l2),%min2%(l3,l4));
#uniquename(add_tra)
typeof(%inf_prim_rec%) %add_tra%(%inf_prim% l, %ca% r) := transform
		localscore := (integer)(100 div 
				//new logic for st and not zip match
				%min2%(
						if (l.state_field <> R.st or l.sec_Range_field != r.sec_range,999,r.fl_st_count),
						if (l.zip_field <> r.zip, 999,
							%min4%(
								r.fl_nosec_count,
								IF (l.sec_range_field=r.sec_range and r.fl_sec_count<>0, r.fl_sec_count, 999 ),
								%min2%(IF (l.mname_field != '' and DidVille.fn_midmatch(l.mname_field,r.mname) and ut.Translate_Suffix(l.suffix_field) = ut.Translate_Suffix(r.name_suffix) and r.fmls_nosec_count<>0, r.fmls_nosec_count, 999 ),
								       IF (l.mname_field != '' and DidVille.fn_midmatch(l.mname_field,r.mname) and ut.Translate_Suffix(l.suffix_field) = ut.Translate_Suffix(r.name_suffix) and l.sec_range_field=r.sec_range and r.fmls_sec_count<>0, r.fmls_sec_count, 999 )),
								if (r.fl_pz_count = 1, r.fl_pz_count,999)
								)
						   )
						)
				* if(datalib.preferredfirstNew(l.fname_field,Header_Slimsort.Constants.UsePFNew) = r.fname or r.did = 0, 1, 0.98) * if(l.zip_field != r.zip,.95,1)); //rem pf(r)
		comboscore := did_add.compute_score(l.did_field, r.did, l.score_field,localscore);
		self.%addr_score% := if (comboscore >= L.%addr_score%, comboscore, L.%addr_score%); 
		self.%addr_did% := if (comboscore >= L.%addr_score%, did_add.pick_did(L.did_field,R.did, l.score_field, comboscore), L.%addr_did%);
		#if(bool_indiv_score)
			self.score_a_field := if (self.%addr_did% = r.did and L.%addr_score% < comboscore,localscore, L.score_a_field);
		#end
		self := l;
end;


#uniquename(infile_id_attempt)
%infile_id_attempt% := 
	distribute(%inf_prim%(prim_name_field<>'' and (%didfilter%)),
			   hash((string)prim_name_field,(string)prim_range_field,(string)header_slimsort.ZipState((string5)zip_field,(string2)state_field)));
#uniquename(infile_id_skip)
%infile_id_skip% := %inf_prim%(~(prim_name_field<>'' and (%didfilter%)));

#uniquename(with_temp)
ut.MAC_Sequence_Records_NewRec(%infile_id_attempt%,%inf_prim_rec%,%local_temp_id%,%with_temp%)


//****** Standard address match
#uniquename(add_join)
%add_join% := join(
	%with_temp%,%ca%,
      left.prim_range_field = right.prim_range and
	 (integer)left.zip_field = (integer)right.zip and
	 left.prim_name_field = right.prim_name and
      left.lname_field = right.lname 
      and
     ( 
         datalib.preferredfirstNew(left.fname_field,Header_Slimsort.Constants.UsePFNew) = 
         right.fname //rem pf(r) 
         or 
         ut.stringsimilar(left.fname_field,right.fname) < 3
     )
	 and
	 (
		 left.mname_field = '' or right.mname = '' or
         datalib.preferredfirstNew(left.mname_field,Header_Slimsort.Constants.UsePFNew) = 
         right.mname //rem pf(r)
         or 
         ut.stringsimilar(left.mname_field,right.mname) < 3
     ),
     %add_tra%(left, right), local, left outer,atmost(left.prim_range_field = right.prim_range and
	 (integer)left.zip_field = (integer)right.zip and
	 left.prim_name_field = right.prim_name and
      left.lname_field = right.lname,500));

#uniquename(first_dedup)
%first_dedup% := dedup(sort(%add_join%,%local_temp_id%,%addr_did%,-%addr_score%,local),
						%local_temp_id%,%addr_did%,local);


#uniquename(add_join_st)
%add_join_st% := join(
	%first_dedup%,%ca%,
     left.prim_range_field = right.prim_range and 
	left.state_field != '' and left.state_field = right.st and 
	left.sec_Range_field = right.sec_range and
	left.prim_name_field = right.prim_name and
     left.lname_field = right.lname 
     and
     ( 
         datalib.preferredfirstNew(left.fname_field,Header_Slimsort.Constants.UsePFNew) = 
         right.fname //rem pf(r) 
         or 
         ut.stringsimilar(left.fname_field,right.fname) < 3
     )and
	 (
		 left.mname_field = '' or right.mname = '' or
         datalib.preferredfirstNew(left.mname_field,Header_Slimsort.Constants.UsePFNew) = 
         right.mname //rem pf(r) 
         or 
         ut.stringsimilar(left.mname_field,right.mname) < 3
     ),
     %add_tra%(left, right), local, left outer, atmost(left.prim_range_field = right.prim_range and
	left.state_field = right.st and left.sec_Range_field = right.sec_range and
	left.prim_name_field = right.prim_name and
     left.lname_field = right.lname,500));

#uniquename(add_join_st_ddp)
%add_join_st_ddp% := dedup(sort(%add_join_st%,%local_temp_id%,%addr_did%,-%addr_score%,local),
						%local_temp_id%,%addr_did%,local);


#uniquename(add_join_pz)
%add_join_pz% := join(
	distribute(%add_join_st_ddp%,hash((String)prim_name_field,(String)zip_field,(String)lname_field)),
	distribute(%ca%,hash((String)prim_name,(String)zip,(String)lname)),
     (left.prim_Range_field = '' or datalib.slidingmatch(trim(left.prim_Range_field),trim(right.prim_range)) >= 2) and
	right.fl_pz_count = 1 and (integer)left.zip_field = (integer)right.zip and
     left.prim_name_field = right.prim_name and
     left.lname_field = right.lname 
     and
     ( 
         datalib.preferredFirstNew(left.fname_field,Header_Slimsort.Constants.UsePFNew) = 
         right.fname //rem pf(r) 
         or 
         ut.stringsimilar(left.fname_field,right.fname) < 3
     )and
	 (
		 left.mname_field = '' or right.mname = '' or
         datalib.preferredFirstNew(left.mname_field,Header_Slimsort.Constants.UsePFNew) = 
         right.mname //rem pf(r) 
         or 
         ut.stringsimilar(left.mname_field,right.mname) < 3
     ),
     %add_tra%(left, right), local, left outer,atmost((integer)left.zip_field = (integer)right.zip and
     left.prim_name_field = right.prim_name and
     left.lname_field = right.lname,500));


#uniquename(try_b)
%try_b% := dedup(sort(%add_join_pz%(%addr_did%=0), prim_range_field, prim_name_field, zip_field,
					  sec_range_field, fname_field, mname_field, lname_field, local),
			     prim_range_field, prim_name_field, zip_field,
				 sec_range_field, fname_field, mname_field, lname_field, local);

//****** Name Zip match
#uniquename(getsafezips)
typeof(%inf_prim_rec%) %getsafezips%(%try_b% l, %ca% r) := transform	
	self.%addr_did% := if (r.did > 0 and L.%addr_score% < 85, R.did, L.%addr_did%);
	self.%addr_score% := if(r.did > 0 and L.%addr_score% < 85, 85, L.%addr_score%);
	#if(bool_indiv_score)
		self.score_a_field := self.%addr_score%;	
	#end
	self := l;
end;

//i need to keep out the dided ones
//and then add them back
//the alternative dist here is a bit bothersome
#uniquename(safezips)
%safezips% := join(distribute(%try_b%, hash(trim((string)fname_field), trim((string)lname_field))),
				 distribute(%ca%(safe_name_zip>0),hash(trim((string)fname), trim((string)lname))),
				 left.fname_field = right.fname and
				 left.lname_field = right.lname and
				 ((integer)left.zip_field = (integer)right.zip or 
					(ut.zip_Dist(left.zip_field,right.zip) <= 500 and right.safe_name_zip = 1)),
				 %getsafezips%(left, right),
				 //do i want a left outer?? yes, then redist, yuck.
				 left outer, local,atmost(left.fname_field = right.fname and
				 left.lname_field = right.lname,1000));

#uniquename(safezips_dist)
%safezips_dist% := distribute(%safezips%, hash((string)zip_field,(string)prim_name_field,(string)prim_range_field));

#uniquename(try_c)
%try_c% := dedup(sort(%safezips_dist%(%addr_did%=0), 
					  prim_range_field, prim_name_field, zip_field,
					  sec_range_field, fname_field, mname_field, lname_field, local),
			     prim_range_field, prim_name_field, zip_field,
				 sec_range_field, fname_field, mname_field, lname_field, local);
//produce a try_c that is redist

//****** Fuzzy name/address match
#uniquename(pre_add_join2)
#uniquename(add_join2)
%pre_add_join2% := join(
	%try_c%,distribute(%ca%(near_name<2),hash((string)zip,(string)prim_name,(string)prim_range)),
     left.prim_range_field = right.prim_range and
     left.prim_name_field = right.prim_name and
     (integer)left.zip_field = (integer)right.zip and
     (left.sec_range_field=right.sec_range or (right.apt_cnt < 100 and right.near_name = 0)) and
     (ut.NameMatch(left.fname_field,left.mname_field,left.lname_field,
                  right.fname,right.mname,right.lname) < 3),
     %add_tra%(left, right), local, left outer,
	atmost(left.prim_range_field = right.prim_range and
     left.prim_name_field = right.prim_name and
     (integer)left.zip_field = (integer)right.zip,500)) + %safezips_dist%(did_field <> 0);


#uniquename(pre_add_join2_ddp)
%pre_add_join2_ddp% := distribute(dedup(sort(%pre_add_join2%(%addr_did% != 0) + %safezips_dist%(%addr_did% != 0),%local_temp_id%,%addr_did%,-%addr_score%,local),%local_temp_id%,%addr_did%,local),hash((string)zip_field,(string)prim_name_field,(string)prim_range_field));

#uniquename(make_add_join2)
typeof(%inf_prim_rec%) %make_add_join2%(%add_join_pz% l, %pre_add_join2% r) := transform
	self.%addr_score% := r.%addr_score%;
	#if(bool_indiv_score)
		self.score_a_field := self.%addr_score%;
	#end	
	self.%addr_did% := r.%addr_did%;
	self := l;
end;

#uniquename(strip_prim)
infile %strip_prim%(%inf_prim% L) := transform
	self.score_field := if (L.%addr_score% = 0, L.score_field, L.%addr_score%);
	self.did_field := if (L.%addr_did% = 0, L.did_field,L.%addr_did%);
 	self := L;
	end;

#uniquename(add_join_orig_ddp)
%add_join_orig_ddp% := dedup(%add_join_pz%(%addr_did% = 0),all);

//****** Add the results back to the dups
%add_join2% := join(distribute(%add_join_orig_ddp%,hash((string)zip_field,(string)prim_name_field,(string)prim_range_field)), 
					%pre_add_join2_ddp%,
					left.prim_range_field = right.prim_range_field and 
					left.prim_name_field = right.prim_name_field and
					left.zip_field = right.zip_field and 
					left.sec_range_field = right.sec_range_field and 
					left.fname_field = right.fname_field and 
					left.mname_field = right.mname_field and 
					left.lname_field = right.lname_field,
					%make_add_join2%(left, right), left outer, local);

  outfil :=project( 
	#if(use_fuzzy)
		%add_join2%+%add_join_pz%(%addr_did%<>0)
	#else
		%add_join_pz%
	#end
	+ %infile_id_skip%,%strip_prim%(LEFT));

endmacro;