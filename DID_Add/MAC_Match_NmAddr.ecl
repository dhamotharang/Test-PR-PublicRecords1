/*2010-07-28T18:07:29Z (T Leonard)
PreferredFirst update
*/
export Mac_Match_NmAddr(infile,outfil,
					did_field,score_field,
					fname_field,mname_field,lname_field,suffix_field,
					prim_range_field,prim_name_field,sec_range_field,zip_field,state_field,
					use_fuzzy = 'true',bool_indiv_score = 'false',
					score_a_field = 'score_a',bool_all_scores = 'false') := macro
import header_slimsort, didville, ut;
#uniquename(inf_prim)
%inf_prim% := infile;

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
#uniquename(rec_id)
#uniquename(local_temp_id)
#uniquename(addr_did)
#uniquename(addr_score)
%rec_id% := record
	unsigned6 %local_temp_id%;
	unsigned6	%addr_did%   := 0;
	unsigned1	%addr_score% := 0;
	%inf_prim%;
end;

#uniquename(min2)
integer %min2% (integer l, integer r) := IF(l<r,l,r);
#uniquename(min4)
integer %min4% (integer l1, integer l2, integer l3, integer l4) := %min2%(%min2%(l1,l2),%min2%(l3,l4));
#uniquename(add_tra)
%rec_id% %add_tra%(%rec_id% l, %ca% r) := transform

		integer localscore := (integer)(100 div
				//new logic for st and not zip match
				%min2%(
						if (l.state_field <> R.st or l.sec_Range_field != r.sec_range,999,r.fl_st_count),
						if (l.zip_field <> r.zip, 999,
							%min4%(
								r.fl_nosec_count,
								IF (l.sec_range_field=r.sec_range and r.fl_sec_count<>0, r.fl_sec_count, 999 ),
								%min2%(IF (DidVille.fn_midmatch(l.mname_field,r.mname) and ut.fGetSuffix(l.suffix_field) = ut.fGetSuffix(r.name_suffix) and r.fmls_nosec_count<>0, r.fmls_nosec_count, 999 ),
								       IF (DidVille.fn_midmatch(l.mname_field,r.mname) and ut.fGetSuffix(l.suffix_field) = ut.fGetSuffix(r.name_suffix) and l.sec_range_field=r.sec_range and r.fmls_sec_count<>0, r.fmls_sec_count, 999 )),
								if (r.fl_pz_count = 1, r.fl_pz_count,999)
								)))
				* if(datalib.preferredfirstNew(l.fname_field,Header_Slimsort.Constants.UsePFNew) = r.fname or r.did = 0, 1, 0.98) * if(l.zip_field != r.zip,.95,1) //rem pf(r)
				* if(length(trim(l.prim_Range_field)) = datalib.slidingmatch(trim(l.prim_Range_field),trim(r.prim_range)) and length(trim(l.prim_Range_field)) = length(trim(r.prim_range)), 1, .90));

		integer comboscore := did_add.compute_score(L.did_field,R.did,L.score_field,localscore);
		self.%addr_score% := if (comboscore >= L.%addr_score% and comboscore != 0, comboscore, L.%addr_score%);
		self.%addr_did% := if (comboscore >= L.%addr_score% and comboscore != 0, did_add.pick_did(L.did_field,R.did, l.score_field, comboscore), L.%addr_did%);
		#if(bool_indiv_score)
			self.score_a_field := if (self.%addr_did% = r.did and L.%addr_score% < comboscore,localscore, L.score_a_field);
		#end
		self := l;
end;

#uniquename(add_tra_FO)
%rec_id% %add_tra_FO%(%rec_id% l, %ca% r) := transform
		integer localscore := (integer)(100 / (r.fo_small_count * if(l.lname_field != R.lname,1.33,1)));
		integer comboscore := did_add.compute_score(l.did_field, r.did, l.score_field,localscore);
		self.%addr_score% := if (comboscore >= L.%addr_score% and comboscore != 0, comboscore, L.%addr_score%);
		self.%addr_did% := if (comboscore >= L.%addr_score% and comboscore != 0, did_add.pick_did(L.did_field,R.did, l.score_field, comboscore), L.%addr_did%);
		#if(bool_indiv_score)
		 self.score_a_field := if (self.%addr_did% = r.did and L.%addr_score% < comboscore, localscore, l.score_a_field);
		#end
		self := l;
end;

#uniquename(infile_id_attempt)
%infile_id_attempt% :=
	distribute(%inf_prim%(prim_name_field<>'' and lname_field <> '' and (%didfilter%)),
				hash((string)prim_name_field,(string)prim_range_field,(string)lname_field));

#uniquename(infile_id_skip)
%infile_id_skip% := %inf_prim%(~(prim_name_field != ''and lname_field != '' and (%didfilter%)));

#uniquename(with_temp)
ut.MAC_Sequence_Records_NewRec(%infile_id_attempt%,%rec_id%,%local_temp_id%,%with_temp%)

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
         ut.stringsimilar(datalib.preferredfirstNew(left.fname_field,Header_Slimsort.Constants.UsePFNew),right.fname) < 3
      ),
      %add_tra%(left, right), local, left outer,
	 atmost(left.prim_range_field = right.prim_range and
	 (integer)left.zip_field = (integer)right.zip and
	 left.prim_name_field = right.prim_name and
      left.lname_field = right.lname,500));

#uniquename(first_dedup)
%first_dedup% := dedup(sort(%add_join%,%local_temp_id%,%addr_did%,-%addr_score%,local),
						%local_temp_id%,%addr_did%,local);

//--------------------//
//output(%add_join%);
//output(%first_dedup%);
//--------------------//

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
         datalib.preferredfirstnew(left.fname_field,Header_Slimsort.Constants.UsePFNew) =
         right.fname //rem pf(r)
         or
         ut.stringsimilar(datalib.preferredfirstNew(left.fname_field,Header_Slimsort.Constants.UsePFNew),right.fname) < 3
     ),
     %add_tra%(left, right), local, left outer,
	atmost(left.prim_range_field = right.prim_range and
	left.state_field = right.st and
	left.sec_Range_field = right.sec_range and
	left.prim_name_field = right.prim_name and
     left.lname_field = right.lname,500));

#uniquename(add_join_st_ddp)
%add_join_st_ddp% := dedup(sort(%add_join_st%,%local_temp_id%,%addr_did%,-%addr_score%,local),
						%local_temp_id%,%addr_did%,local);

//----------------------
//output(%add_join_st%);
//output(%add_join_st_ddp%);
//----------------------


#uniquename(add_join_pz)
%add_join_pz% := join(
	distribute(%add_join_st_ddp%,hash((String)prim_name_field,(String)zip_field,(String)lname_field)),
	distribute(%ca%,hash((String)prim_name,(String)zip,(String)lname)),
     (left.prim_Range_field = ''
	or datalib.slidingmatch(trim(left.prim_Range_field),trim(right.prim_range)) >= 2) and
	right.fl_pz_count = 1 and (integer)left.zip_field = (integer)right.zip and
     left.prim_name_field = right.prim_name and
     left.lname_field = right.lname
     and
     (
         datalib.preferredfirstNew(left.fname_field,Header_Slimsort.Constants.UsePFNew) =
         right.fname //rem pf(r)
         or
         ut.stringsimilar(datalib.preferredfirstNew(left.fname_field,Header_Slimsort.Constants.UsePFNew),right.fname) < 3
     ),
     %add_tra%(left, right), local, left outer,
	atmost((integer)left.zip_field = (integer)right.zip and
     left.prim_name_field = right.prim_name and
     left.lname_field = right.lname,500));


#uniquename(try_b)
%try_b% := dedup(sort(%add_join_pz%(%addr_did% = 0), lname_field,
					prim_name_field,zip_field,prim_range_field,sec_range_field, fname_field,
					mname_field, local),
			     lname_field, prim_name_field,zip_field,prim_range_field,
				 sec_range_field, fname_field, mname_field,  local);

//****** Name Zip match
#uniquename(getsafezips)
%rec_id% %getsafezips%(%try_b% l, %ca% r) := transform
	self.%addr_did% := if (r.did > 0 and L.%addr_score% < DID_Add.mod_hard_scores.zip_dist_score, R.did, L.%addr_did%);
	self.%addr_score% := if(r.did > 0 and L.%addr_score% < DID_Add.mod_hard_scores.zip_dist_score, DID_Add.mod_hard_scores.zip_dist_score, L.%addr_score%);
	#if(bool_indiv_score)
		self.score_a_field := self.%addr_score%;
	#end
	self := l;
end;

#uniquename(safezips)
%safezips% := join(distribute(%try_b%, hash(trim((string)fname_field), trim((string)lname_field))),
				 distribute(%ca%(safe_name_zip>0),hash(trim((string)fname), trim((string)lname))),
				 left.fname_field = right.fname and
				 left.lname_field = right.lname and
				 ((integer)left.zip_field = (integer)right.zip or
					(ut.zip_Dist(left.zip_field,right.zip) <= did_add.mod_hard_scores.zip_dist and right.safe_name_zip = 1)),
				 %getsafezips%(left, right),
				 //do i want a left outer?? yes, then redist, yuck.
				 left outer, local,atmost(left.fname_field = right.fname and
				 left.lname_field = right.lname,1000));

#uniquename(safezips_dist)
%safezips_dist% := distribute(%safezips%, hash((string)zip_field,(string)prim_name_field,(string)prim_range_field));


//----------------//
//output(%safezips_dist%);
//---------------//


#uniquename(try_c)
%try_c% := dedup(sort(%safezips_dist%(%addr_did%=0),
					  prim_range_field, prim_name_field, zip_field,
					  sec_range_field, fname_field, mname_field, lname_field, local),
			     prim_range_field, prim_name_field, zip_field,
				 sec_range_field, fname_field, mname_field, lname_field, local);

#uniquename(ca2)
%ca2% := distribute(%ca%,hash((string)zip,(string)prim_name,(string)prim_range));

//****** Fuzzy name/address match
#uniquename(from_fuzzy)
%from_fuzzy% := join(%try_c%,%ca2%(near_name<2),
     left.prim_range_field = right.prim_range and
     left.prim_name_field = right.prim_name and
     (integer)left.zip_field = (integer)right.zip and
     (left.sec_range_field = right.sec_range or
	 (right.apt_cnt < 100 and right.near_name = 0)) and
     ut.NameMatch(datalib.preferredfirstNew(left.fname_field,Header_Slimsort.Constants.UsePFNew),datalib.preferredfirstNew(left.mname_field,Header_Slimsort.Constants.UsePFNew),left.lname_field,//added pf(mname)
                  right.fname,right.mname,right.lname) < 3,
     %add_tra%(left, right), local, left outer,
	atmost(left.prim_range_field = right.prim_range and
		  left.prim_name_field = right.prim_name and
		  (integer)left.zip_field = (integer)right.zip,500)) + %safezips_dist%(%addr_did% <> 0);

#uniquename(from_fuzzy_ddp)
%from_fuzzy_ddp% := dedup(sort(%from_fuzzy%(%addr_did% = 0),
					  prim_range_field, prim_name_field, zip_field,
					  sec_range_field, fname_field, mname_field, lname_field, local),
			     prim_range_field, prim_name_field, zip_field,
				 sec_range_field, fname_field, mname_field, lname_field, local);

//--------------------------//
//output(%from_fuzzy%);
//--------------------------//

//First Only Matching
#uniquename(FO_Join)
#uniquename(fo_Join_ddp)
%fo_join% := join(%from_fuzzy_ddp%,%ca2%(fo_small_count != 0),
		left.prim_name_field = right.prim_name and
		left.prim_range_field = right.prim_range and
		left.sec_range_field = right.sec_range and
		(integer)left.zip_field = (integer)right.zip and
		datalib.preferredFirstNew(Left.fname_field,Header_Slimsort.Constants.UsePFNew) = Right.fname, //rem pf(r)
		%add_tra_FO%(LEFT,RIGHT),local,left outer,atmost(left.prim_name_field = right.prim_name and
		left.prim_range_field = right.prim_range and
		left.sec_range_field = right.sec_range and
		(integer)left.zip_field = (integer)right.zip,500));

%fo_join_ddp% := dedup(sort(%fo_join%(%addr_did% != 0) + %from_fuzzy%(%addr_did% != 0) + %safezips_dist%(%addr_did% != 0),%local_temp_id%,%addr_did%,-%addr_score%,local),
						%local_temp_id%,%addr_did%,local);



//--------------------//
//output(%fo_join_ddp%);
//--------------------//


#uniquename(make_add_join2)
%rec_id% %make_add_join2%(%add_join% l, %fo_join_ddp% r) := transform
	self.%addr_score% := r.%addr_score%;
	#if(bool_indiv_score)
		self.score_a_field := self.%addr_score%;
	#end
	self.%addr_did% := r.%addr_did%;
	self := l;
end;

#uniquename(add_join_orig_ddp)
%add_join_orig_ddp% := dedup(%add_join_pz%(%addr_did% = 0),all,local);


//****** Add the results back to the dups
#uniquename(add_join2)
%add_join2% := join(distribute(%add_join_orig_ddp%,hash((string)zip_field,(string)prim_name_field,(string)prim_range_field)),
					%fo_join_ddp%,
					left.prim_range_field = right.prim_range_field and
					left.prim_name_field = right.prim_name_field and
					(integer)left.zip_field = (integer)right.zip_field and
					left.sec_range_field = right.sec_range_field and
					left.fname_field = right.fname_field and
					left.mname_field = right.mname_field and
					left.lname_field = right.lname_field,
					%make_add_join2%(left, right), left outer, local);

#uniquename(rmID)
typeof(%inf_prim%) %rmID%(%rec_id% L) := transform
 self.score_field := if (L.%addr_score% = 0, L.score_field, L.%addr_score%);
 self.did_field := if (L.%addr_did% = 0, L.did_field,L.%addr_did%);
 self := l;
end;

  outfil := Project(
	#if(use_fuzzy)
		%add_join2%+%add_join_pz%(%addr_did%<>0)
	#else
		%add_join_pz%
	#end
	,%rmID%(left))+%infile_id_skip%;

endmacro;
