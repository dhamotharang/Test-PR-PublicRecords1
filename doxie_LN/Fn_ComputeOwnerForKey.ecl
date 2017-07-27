import LN_Property, doxie, standard,ut,NID;
//see test code at bottom
export Fn_ComputeOwnerForKey(
	dataset(recordof(ln_property.File_Search)) searchfile,
	dataset(recordof(ln_property.File_Assessment)) assesfile,
	dataset(recordof(ln_property.File_Deed)) deedfile
) := FUNCTION

layout_check :=
RECORD
	searchfile.ln_fares_id;
	STRING20 fname;
	STRING20 lname;
	STRING5  name_suffix;
	Standard.Addr;
	integer6 date;
END;

// **** Collect clean name from search
layout_check get_search(searchfile le) :=
TRANSFORM
	SELF.fname := NID.PreferredFirstVersionedStr(le.fname, NID.version);
	SELF := le;
	SELF.addr_suffix := le.suffix;
	SELF.zip5 := le.zip;
	SELF := [];
END;
searchfile_dist := DISTRIBUTE(searchfile(source_code[2] = 'P'), HASH(ln_fares_id));
	
p_search := PROJECT(searchfile_dist(source_code[1] IN ['O','B']),get_search(LEFT));


integer6 assessdate(string recdate, string assvalueyear) := 
	IF((unsigned)recdate > (unsigned)(assvalueyear+'01'+'01'), (unsigned)recdate, (unsigned)(assvalueyear+'01'+'01'));


// **** Collect date from assessments
assess := dedup(sort(distribute(PROJECT(assesfile, {assesfile.ln_fares_id,
	assesfile.recording_date,
	assesfile.assessed_value_year,
	assesfile.apna_or_pin_number}), hash(apna_or_pin_number)), apna_or_pin_number, -assessdate(recording_date, assessed_value_year), local), apna_or_pin_number, local);

layout_check get_deed(layout_check le, assess ri) :=
TRANSFORM
	rec_date := (unsigned)ri.recording_date;
	tax_date := (unsigned)(ri.assessed_value_year+'01'+'01');


	SELF.date := assessdate(ri.recording_date, ri.assessed_value_year);//IF(rec_date > tax_date, rec_date, tax_date);
	SELF := le;
END;

j_assess:= JOIN(p_search(ln_fares_id[2]='A'), DISTRIBUTE(assess, HASH(ln_fares_id)), 
									LEFT.ln_fares_id=RIGHT.ln_fares_id, get_deed(LEFT,RIGHT), LOCAL);


// **** Collect date from deeds
deed := PROJECT(deedfile, {deedfile.ln_fares_id, deedfile.recording_date, deedfile.contract_date, 
						   deedfile.fares_refi_flag, deedfile.fares_transaction_type});

layout_check get_assessment(layout_check le, deed ri) :=
TRANSFORM
	boolean isRefi := ri.fares_refi_flag = 'T' or ri.fares_transaction_type = '2';
	SELF.date := 
		IF(isRefi, -1, //refi record is last resort
			IF((unsigned)ri.contract_date=0,(unsigned)(ri.recording_date),(unsigned)ri.contract_date));
	SELF := le;
END;


j_deeds := JOIN(p_search(ln_fares_id[2]<>'A'), DISTRIBUTE(deed, HASH(ln_fares_id)), 
									LEFT.ln_fares_id=RIGHT.ln_fares_id, get_assessment(LEFT,RIGHT), LOCAL);

all_prop_wseller :=  DISTRIBUTE((j_deeds+j_assess)(prim_name<>'' AND zip5<>''), HASH(prim_name,zip5,prim_range));


// **** Remove Sellers (but do not call them a seller if they are a buyer on the same record)
sellers := join(searchfile_dist(source_code[1] = 'S'),
								searchfile_dist(source_code[1] <> 'S'),
								left.ln_fares_id = right.ln_fares_id and
								ut.NameMatch(left.fname,'',left.lname,right.fname,'',right.lname) <= 2,
								left only,
								local);

sellers_dist := distribute(sellers, HASH(prim_name,zip,prim_range));
										
all_prop := join(all_prop_wseller, sellers_dist,
								 left.prim_name = right.prim_name and
								 left.zip5 = right.zip and
								 left.prim_range = right.prim_range and
								 ut.NameMatch(left.fname,'',left.lname,right.fname,'',right.lname) <= 2,
								 transform(layout_check, self := left),
								 left only,
								 local);
								 
// **** Decide who the owner is
each_prop := DEDUP(SORT(all_prop, prim_name, prim_range, zip5, addr_suffix, sec_range, -date, LOCAL),
												prim_name, prim_range, zip5, addr_suffix, sec_range, LOCAL);
												
												
layout_check keepdeeds(layout_check l) := transform
	self := l;
end;



best_fids := join(all_prop, each_prop, 
				  left.prim_name = right.prim_name and 
				  left.prim_range = right.prim_range and
				  left.zip5 = right.zip5 and  
				  left.addr_suffix = right.addr_suffix and
				  left.sec_range = right.sec_range and
				  left.date = right.date, keepdeeds(left), LOCAL);


all_prop_rec := {all_prop.prim_name, all_prop.prim_range, all_prop.zip5, all_prop.predir, all_prop.postdir, all_prop.addr_suffix, all_prop.sec_range, all_prop.lname, all_prop.fname, all_prop.name_suffix};


//*********
//  IMPORTANT - THIS FUNCTION MUST RETURN A DATASET THAT IS DISTRIBUTED BY HASH(prim_name,zip5,prim_range)
//  ANY CHANGE MUST BE ACCOUNTED FOR IN doxie_LN.Key_Addr_Fid
//*********

return dedup(sort(project(best_fids, all_prop_rec),record, local),record, local);

END;














/* for hthor testing at one address
FIDS := doxie_ln.Key_Addr_Fid
	//(prim_name = 'CHATHAM', PRIM_RANGE = '480', ZIP = '45429', LN_FARES_ID[1] = 'R');
	(prim_name = 'BRADWOOD', PRIM_RANGE = '4204', ZIP = '78722');
							  
S := SET(FIDS, LN_FARES_ID);	

Rs := RECORDOF(ln_property.File_Search);
Ra := RECORDOF(ln_property.File_Assessment);
Rd := RECORDOF(ln_property.File_Deed);						  

searchfile := PROJECT(DOXIE_LN.key_fid_search(LN_FARES_ID IN S), RS);						 
assesfile := PROJECT(DOXIE_LN.key_assessor_fid(LN_FARES_ID IN S), RA);
deedfile := PROJECT(DOXIE_LN.key_deed_fid(LN_FARES_ID IN S), RD);
*/