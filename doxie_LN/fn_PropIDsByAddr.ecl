import codes, doxie, ln_propertyv2, NID;

layout_names := doxie.layout_NameDID;

export fn_PropIDsByAddr(
  dataset(doxie.layout_propertySearch) infile,
  dataset(layout_names) name_records, 
	
  unsigned3 dateVal = 0,
  unsigned1 dppa_purpose = 0,
  unsigned1 glb_purpose = 0,
  boolean ln_branded_value = false,
  boolean probation_override_value = false,
	
  boolean Include_PriorProperties = true,
  boolean Use_CurrentlyOwnedProperty_value = false,
  string data_restriction_value = '0',
  boolean IsFCRA = false,
	boolean is_asset_report = false
) := MODULE

rec := record
	unsigned6	did;
	string12 fid;
	integer3 address_seq_no;
	string2  source_code;
	boolean current;
	boolean owner;
	name_records.fname;
	name_records.lname;
	name_records.name_suffix;
end;

kaf := ln_propertyv2.key_addr_fid(isFCRA);

//add seq if there is none
header2addr := PROJECT(infile, TRANSFORM(doxie.Layout_Comp_Addresses, SELF := LEFT, SELF := []));
// nb: just taking top 50 addresses
doxie.MAC_Address_Rollup(header2addr, 50, addr_recs);

doxie.layout_propertySearch toPropSearch(addr_recs le, INTEGER i) :=
TRANSFORM
	SELF.address_Seq_no := i;
	SELF := le;
END;


addr_seq := PROJECT(addr_recs,toPropSearch(LEFT,COUNTER));

infile_seq := if(exists(infile(address_Seq_no > 0)), infile, addr_seq);
 
rec GetFareRecord (infile le, kaf ri) := transform, skip (ri.ln_fares_id[1] = 'D' and not ln_branded_value and isFCRA)
  self.did := le.did;
  self.fid := ri.ln_fares_id;
  self.address_seq_no := le.address_seq_no;
  self.source_code := ri.source_code_1 + ri.source_code_2;
  self.current := false;
  // NB: FCRA data is implicetly Fares-restricted
  self.owner := if(ln_branded_value,
                   if(not (doxie.DataRestriction.Fares or IsFCRA), ri.ln_owner,ri.ln_owner AND ri.nofares_owner),
	                 if(not (doxie.DataRestriction.Fares or IsFCRA), ri.owner,ri.owner AND ri.nofares_owner));
  self.fname := ri.fname;
  self.lname := ri.lname;
  self.name_suffix := ri.name_suffix;
end;  

JoinByAddress (dataset(doxie.layout_propertySearch) in_file, boolean full_address) := function
  out_file := join (in_file, kaf,
                    keyed(left.prim_name = right.prim_name) and
                    keyed(left.prim_range = right.prim_range) and
                    keyed(left.zip = right.zip) and									 
                    keyed(left.predir = right.predir) and 
                    keyed(left.postdir = right.postdir) and 
                    keyed(left.suffix = right.suffix) and
                    IF (full_address, 
                        keyed (left.sec_range = right.sec_range),
                        keyed (right.sec_range = '')) AND
                    //select only those records where the address is the property address
                    keyed(is_asset_report or right.source_code_2 = 'P'),
                    GetFareRecord (left, right), 
                    atmost(200));
	return out_file;									
END;

jr1 := JoinByAddress (infile_seq,  true);
//might consider rolling up the owner flag accross recs with the same seq_no (>0)

// find those with a sec range that didn't get a hit above
infile2 := JOIN(infile(sec_range<>''), jr1, LEFT.address_seq_no=RIGHT.address_seq_no,
								TRANSFORM(RECORDOF(infile),SELF := LEFT), LEFT ONLY);

jr2 := JoinByAddress (infile2, false);

priors := jr1 + jr2;

//when Use_CurrentlyOwnedProperty_value, we need to do some name matching work here
//? TODO: this might not be needed at all upto join below: input names are good enough
layout_names roll_name(layout_names le, layout_names ri) := TRANSFORM
  //deleted: ...and le.name_occurences >= ri.name_occurences
	SELF.name_suffix := IF(codes.GENERAL.Name_Suffix(le.name_suffix)<>'',le.name_suffix,
													IF(codes.GENERAL.Name_Suffix(ri.name_suffix)<>'',ri.name_suffix,''));

	SELF.fname := ri.fname;
	SELF := le;
END;


name_recs := 
	ROLLUP(SORT(PROJECT(name_records, 
						TRANSFORM(layout_names, 
								  SELF.fname := NID.PreferredFirstVersionedStr(LEFT.fname, NID.version), 
								  SELF := LEFT)), 
		        fname, lname, name_suffix), 
			LEFT.fname=RIGHT.fname AND LEFT.lname=RIGHT.lname AND 
			(LEFT.name_suffix=RIGHT.name_suffix OR LEFT.name_suffix=''), 
			roll_name(LEFT,RIGHT));

rec matchname(name_recs le, jr1 ri) :=
TRANSFORM
  self.current := true;
  self := ri;
END;

//? TODO: CRS_records uses preferredfirst & NNEQ for suffix and middle names, which seems much better
j := JOIN(name_recs, priors(owner), 
		  left.did = right.did and
		  LEFT.fname=RIGHT.fname AND LEFT.lname=RIGHT.lname AND 
		  (LEFT.name_suffix=RIGHT.name_suffix OR RIGHT.name_suffix=''), 
		  matchname(LEFT,RIGHT));
	  
shared recs(boolean lived, boolean owned) := function
  recs_ddp := dedup(
	if(lived and Include_PriorProperties,priors) +
	if(owned and Use_CurrentlyOwnedProperty_value,j), all);
  // filter out "Care-Of" records on FCRA side
  return recs_ddp (~IsFCRA or source_code[1] <> 'C');
end;

export records_lived := recs(true, false);
export records_owned := recs(false, true);


export records := records_owned + records_lived;
	
export owned_address_count := count(dedup(if(Doxie.DataRestriction.Fares, records_owned(address_seq_no > 0,fid[1] <> 'R'),records_owned(address_seq_no > 0)), address_seq_no, all));
END;