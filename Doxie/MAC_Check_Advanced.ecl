export MAC_Check_Advanced(dids,did_field,outfile,in_keyFile) := MACRO
import ut, doxie;
#uniquename(header_recs_)
#uniquename(header_knowx_recs)
#uniquename(header_hdr_recs)
#uniquename(header_recs)
#uniquename(header_recs_rolled)
#uniquename(header_recs_deduped)
#uniquename(calc_bmap)
#uniquename(keep_did)
#uniquename(rel_recs)
#uniquename(rel_header_recs)
#uniquename(roll_did)
#uniquename(header_check)

#uniquename(oformat)
%oformat% := recordof(dids);

#uniquename(oformat2)
%oformat2% := RECORD
  %oformat%;
	unsigned1 bmap;
END;

#uniquename(kh)
%kh% := in_keyFile;
  
// confirm other-last-name and other-city and other-state-1 and other-state-2 matches
%oformat2% %calc_bmap%(%oformat% l, %kh% r, unsigned6 le_did) :=
TRANSFORM
	SELF.did := le_did;
	SELF.bmap :=  IF(r.lname = other_lname_value1, ut.bit_set(0,0), 0) | 
	              IF(other_city_value IN ut.ZipToCities(r.zip).set_cities, ut.bit_set(0,1), 0) |
								IF(r.st = prev_state_val1, ut.bit_set(0,2), 0) |
								IF(r.st = prev_state_val2, ut.bit_set(0,3), 0);
	SELF := l;
END;
%header_recs_% := JOIN(dids, %kh%, KEYED(LEFT.did_field = RIGHT.s_did) AND 
                      ((other_lname_value1 <> '' AND other_lname_value1 = RIGHT.lname) OR 
											 (other_city_value <> '' AND other_city_value IN ut.ZipToCities(RIGHT.zip).set_cities) OR 
											 (prev_state_val1 <> '' AND prev_state_val1 = RIGHT.st) OR 
											 (prev_state_val2 <> '' AND prev_state_val2 = RIGHT.st)), 
				%calc_bmap%(LEFT, RIGHT, LEFT.did_field), LIMIT(ut.limits .DID_PER_PERSON, SKIP));

%oformat2% %roll_did%(%header_recs_% l, %header_recs_% r) := TRANSFORM
	SELF.bmap := l.bmap | r.bmap;
	SELF := l;
END;

// this establishes all of the match criteria across the DID space according to search criteria
#uniquename(target_bmap)
%target_bmap% := IF(other_lname_value1 <> '', ut.bit_set(0, 0), 0) | 
	               IF(other_city_value <> '', ut.bit_set(0, 1), 0) |
							   IF(prev_state_val1 <> '',	ut.bit_set(0, 2), 0) |
							   IF(prev_state_val2 <> '',	ut.bit_set(0, 3), 0);
							 
%header_recs_rolled% := ROLLUP(SORT(%header_recs_%, did),%roll_did%(LEFT, RIGHT),did); 
// only keep DIDs that match all of the search criteria (filter on target_bmap)
%header_recs_deduped% := DEDUP(%header_recs_rolled%(bmap = %target_bmap%), did, all);
ut.MAC_Slim_Back(%header_recs_deduped%, %oformat%, %header_recs%)

// confirm relative-first-name match // does not need to happen if both rel_fnames are blank
%rel_recs% := If( rel_fname_value1 = '' and rel_fname_value2 = '',
									project(dids,%oformat%),
									project(doxie.relatives_records_little(project(dids,doxie.layout_references),rel_fname_value1,rel_fname_value2,100)
													,transform(%oformat%,self:=left,self:=[])));


%oformat% %keep_did%(%oformat% l, unsigned6 le_did) :=
TRANSFORM
	SELF.did := le_did;
	SELF := l;
END;

// possibly combine the two
%rel_header_recs% := JOIN(%header_recs%, %rel_recs%, LEFT.did=RIGHT.did, %keep_did%(LEFT, LEFT.did));

%header_check% := (other_lname_value1<>'' OR other_city_value <> '' OR prev_state_val1 <> '' OR prev_state_val2 <> '');

outfile := MAP((rel_fname_value1<>'') AND %header_check% 	=> %rel_header_recs%,
			   (rel_fname_value1<>'')						=> %rel_recs%,
			   %header_check%       						=> %header_recs%,
			   PROJECT(dids, %keep_did%(LEFT,LEFT.did_field)))

ENDMACRO;