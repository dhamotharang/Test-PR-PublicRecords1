
export historic_nbr_records(hr,outrecs,checkRNA=true, modAccess) := macro
import header,doxie,ut,suppress;


#uniquename(no_prim)
%no_prim% := 'xxxxx';
#uniquename(pr)
qstring25 %pr% := map(hr.prim_range <> '' => hr.prim_range,
										hr.prim_name <> '' => hr.prim_name,
										%no_prim%);
#uniquename(hrs)
%hrs% := group(sort(hr(%pr% <> %no_prim%), prim_range, prim_name, -dt_last_seen), prim_range, prim_name);

#uniquename(roll_dates)
%hrs% %roll_dates%(%hrs% le, %hrs% ri) := transform
  self.dt_first_seen := if(ri.dt_first_seen = 0 or (le.dt_first_seen < ri.dt_first_seen and le.dt_first_seen>0),le.dt_first_seen,ri.dt_first_seen);
  self.dt_last_seen := if(le.dt_last_seen > ri.dt_last_seen, le.dt_last_seen, ri.dt_last_seen );
	self := le;
end;
#uniquename(hrd)
%hrd% := rollup(%hrs%,true,%roll_dates%(LEFT,RIGHT));
#uniquename(hrf)
%hrf% := sort(group(%hrd%), -dt_last_seen);

// This is just one of each addresses sorted by recency (most recent first)
// with the full range of dates represented -- from earliest in dt_first_seen 
//      to latest in dt_last_seen.
#uniquename(inrecs)
%inrecs% := %hrf%;

#uniquename(k)
%k% := header.Key_Nbr_Address;

unsigned1 NPA := Neighbors_PerAddress;	
unsigned1 APN := Addresses_PerNeighbor;

//---------get nbr dids

#uniquename(tnt_score)
%tnt_score%(string1 c) := 
	CASE(c,
		'B' => 1,
		'V' => 1,
		'C' => 2,
		'P' => 3,
		'R' => 4, 5);       

#uniquename(rhd0)
#uniquename(rhd)
%rhd0% := sort(dedup(sort(%inrecs%(Include_Neighbors_val and npa>0 and prim_name[1..6] != 'PO BOX'),
				    prim_name,zip,-prim_range),
			    prim_name,zip),
		   %tnt_score%(tnt), -dt_last_seen);

%rhd% := choosen(%rhd0%, if (Max_Neighborhoods < 1, 4, Max_Neighborhoods));

//-----------

//output(choosen(%rhd%,all));

//-----------

#uniquename(didrec)
%didrec% := record
	unsigned6	base_did;
	%k%.did;
	%rhd%.prim_name;
	%rhd%.prim_range;
	%k%.sec_range;
	%rhd%.zip;
	%k%.dt_last_seen;
	%k%.dt_first_seen;
end;

#uniquename(take_n)
%didrec% %take_n%(%rhd% L, %k% R) := transform
  self.base_did := L.did;
  self.did := if (R.did = L.did, skip, R.did);
  self := R;
end;


// needed to limit results -- using zip4 to do so.
// and a limit of 5k neighbors.  
// Otherwise, was hitting hard 10k candidate set limit
#uniquename(nbrsa)
#uniquename(nbrsb)
#uniquename(nbrs)
%nbrsa% := join(%rhd%(sec_range=''),%k%,
				keyed(left.prim_name = right.prim_name) and
				keyed(left.zip = right.zip) and
				keyed(left.zip4[1..2] = right.z2) and
				keyed(left.suffix = right.suffix) and
				left.prim_range != right.prim_range and 
				right.sec_range = '',
				%take_n%(LEFT,RIGHT),limit(7500,skip));
				
%nbrsb% := join(%rhd%(sec_range<>''),%k%,
				keyed(left.prim_name = right.prim_name) and
				keyed(left.zip = right.zip) and
				keyed(left.zip4[1..2] = right.z2) and
				keyed(left.suffix = right.suffix) and
				keyed(left.prim_range=right.prim_range) AND
				left.sec_range != right.sec_range and 
				right.sec_range != '',
				%take_n%(LEFT,RIGHT),limit(7500,skip));

%nbrs% := %nbrsa%+%nbrsb%;

//-----------

//output(choosen(%nbrs%,all));

//-----------
		
#uniquename(calc_distance)		
unsigned2 %calc_distance%(%nbrs% le, %rhd% ri) := if ( abs((integer8)le.prim_range-(integer8)ri.prim_range) = 0,
                        if ((le.sec_range != '' and (unsigned8)le.sec_range = 0) or
						     (ri.sec_range != '' and (unsigned8)ri.sec_range = 0),
							abs(transfer(le.sec_range,integer6) - transfer(ri.sec_range,integer6)),
							abs((integer8)le.sec_range - (integer8)ri.sec_range)),
						abs((integer8)le.prim_range-(integer8)ri.prim_range));
						

#uniquename(drec)
%drec% := record
	%nbrs%;
	unsigned2	distance;
	unsigned2	overlap;
	unsigned2	base_prim_range;
end;

// this is to clear out leading 0's from prim_ranges and sec_ranges
// which you can only do if the field is a pure number, no letters.
#uniquename(clean_field)
string %clean_field%(string f) := trim(if (f != '' and stringlib.stringfilterout(f,'0123456789') = '',(string)((integer)f),f),left,right);

#uniquename(calc_dist_and_overlap)
%drec% %calc_dist_and_overlap%(%nbrs% L, %rhd% R) := transform
	self.distance := %calc_distance%(L,R);
	// we want to get rid of 0 dates...
	// if last = 0, set to first.  if first = 0, set to last.
	tru_dt_first_seen := if (L.dt_first_seen != 0, L.dt_first_seen, L.dt_last_seen);
	tru_dt_last_seen := if (L.dt_last_seen != 0, L.dt_last_seen, L.dt_first_seen);
	self.dt_first_seen := r.dt_first_seen;
	// rule (may be temporary): if it's a recent address, then the neighbor also needs to be recent
	self.dt_last_seen := IF(doxie.isrecent((STRING6)r.dt_last_seen,3) AND 
													~doxie.isrecent((STRING6)l.dt_last_seen,3),SKIP,r.dt_last_seen);
	// then use self dates for calculation.
	self.overlap := ut.date_overlap(tru_dt_first_seen,tru_dt_last_seen,
                                 r.dt_first_seen,r.dt_last_seen);
	self.base_prim_range := (integer)R.prim_Range;
	self.prim_range := %clean_field%(L.prim_range);
	self.sec_range := %clean_field%(L.sec_range);
	self := L;
end;

#uniquename(outf1)
%outf1% := join(%nbrs%, %rhd%, left.prim_name = right.prim_name and
					  left.zip = right.zip and
					  (if (right.sec_range = '',left.prim_range != right.prim_range,
					   left.prim_range = right.prim_range and left.sec_range != right.sec_range)),
					  %calc_dist_and_overlap%(LEFT,RIGHT),local);

#uniquename(outf2)					  
%outf2% := dedup(sort(dedup(sort(%outf1%(overlap >= 1),prim_name,zip,prim_range,sec_range,-overlap,did,local),prim_name,zip,prim_range,sec_range,local),
			prim_name,zip,distance,-overlap,local),prim_name,zip,keep(NPA),local);

//--------------

//output(choosen(%outf1%,all));
//output(choosen(%outf2%,all));

//--------------

#uniquename(get_all_near)
%outf2% %get_all_near%(%outf1% L, %outf2% R) := transform
	self := l;
end;


// outf2 has been deduped to only contain the right number of neighbor addresses
// so we now rejoin with the original large set of addresses and pick up
// all the neighbors at those specific addresses.
#uniquename(outf3)
%outf3% := join(%outf1%,%outf2%, left.prim_name = right.prim_name and
					left.zip = right.zip and left.prim_range = right.prim_range and
					left.sec_range = right.sec_range,
					%get_all_near%(LEFT,RIGHT),local);
			
#uniquename(outrec)			
%outrec% := record
	doxie.Key_Header;
	unsigned2	distance;
	unsigned2	overlap;
	unsigned2	base_prim_range;
	string9		ssn_unmasked := '';
end;


#uniquename(into_out)
%outrec% %into_out%(%outf3% L, doxie.Key_Header R) := transform
	self.phone := if((unsigned6)R.phone = 0,'',R.phone);
	self.dt_last_seen := L.dt_last_seen;
	self.dt_first_seen := L.dt_first_seen;
	self := R;
	self := L;
end;

#uniquename(dirty_outf4)	
%dirty_outf4% := join(%outf3%(overlap >= 1),doxie.Key_Header, keyed(left.did = right.s_did) and
				left.prim_range = %clean_field%(right.prim_range) and
				left.prim_name = right.prim_name and
				left.sec_range = %clean_field%(right.sec_range) and
				left.zip = right.zip,%into_out%(LEFT,RIGHT), LIMIT(ut.limits .DID_PER_PERSON, SKIP));
				
#uniquename(outf4a)	
#uniquename(outf4b)	
header.MAC_GlbClean_Header(%dirty_outf4%, %outf4a%, , ,modAccess);
#uniquename(outf4a1)	
header.MAC_GLB_DPPA_Clean_RNA(%outf4a%, %outf4a1%, modAccess);
#uniquename(outf4a2)	
%outf4a2% := If (checkRNA=true,%outf4a1%,%outf4a%);

 // output(%outf4a%);
suppress.MAC_Mask(%outf4a2%,%outf4b%,ssn,foo,true,false,,true,,modAccess.ssn_mask);
// output(%outf4b%);

#uniquename(outf5)
%outf5% := dedup(sort(dedup(sort(%outf4b%,prim_name,prim_Range,sec_range,zip,did,-(integer)dt_last_seen,-phone,-dob,rid)
				,prim_name,prim_range,sec_range,zip,did)
			  ,prim_name,prim_range,sec_range,zip,-(integer)dt_last_seen)
			,prim_name,prim_range,sec_range,zip,keep(APN));
				
outrecs := sort(%outf5%,did,prim_name,prim_range,sec_range);

endmacro;
