import doxie, ut, suppress, doxie_ln;

rec := doxie_ln.layout_property_ids;

export property_ids (
    dataset(Doxie.layout_references) dids,
		dataset(Doxie.Layout_ref_bdid) bdids,
    unsigned3 dateVal = 0,
    unsigned1 dppa_purpose = 0,
    unsigned1 glb_purpose = 0,
		boolean ln_branded_value = false,
		boolean probation_override_value = false,
		
		boolean Include_PriorProperties = true,
		boolean Use_CurrentlyOwnedProperty_value = false,

    DATASET (doxie.Layout_Comp_Addresses) addresses = DATASET ([], doxie.Layout_Comp_Addresses),
    DATASET (doxie.layout_NameDID) names = DATASET ([], doxie.layout_NameDID),
    boolean IsFCRA = false,
		boolean is_asset_report = false,
		boolean skipAddressRollup = false,
		string32 appType
) := FUNCTION

// In the future {mod_access} should be provided in the input
mod_access := MODULE (doxie.functions.GetGlobalDataAccessModuleTranslated (AutoStandardI.GlobalModule (IsFCRA)))
  EXPORT unsigned1 glb := glb_purpose;
  EXPORT unsigned1 dppa := dppa_purpose;
  EXPORT boolean ln_branded := ln_branded_value;
  EXPORT boolean probation_override := probation_override_value;
  EXPORT unsigned3 date_threshold := ^.dateVal;
  EXPORT string32 application_type := appType;
  EXPORT boolean no_scrub := FALSE;	
END;

//***** BY DID (previously 'current')******
ids := doxie_ln.Fetch_Property_Did (dids, IsFCRA);

rec current_tor(ids l) := transform
	self.fid := l.ln_fares_id;
	self.current := true;
	self.source_code := l.source_code;
	self.did := L.did;
	self.bdid := L.bdid;
end;
bydid := project(ids(mod_access.ln_branded or ln_fares_id[1] <> 'D'), current_tor(left));


//***** BY ADDRESS (previously 'prior'..now prior and new currently owned option) ******
// IMPORTANT: For FCRA-side queries [addresses] should be always provided!

// names from input pre-calculated addresses
ds_addr_slim := PROJECT (addresses, doxie.layout_NameDID);
doxie.layout_NameDID name_tra(doxie.layout_NameDID l, doxie.layout_NameDID r) := transform
	self.name_occurences := 
		if(l.did = r.did and l.name_suffix = r.name_suffix and l.fname = r.fname and l.lname = r.lname,
			1+l.name_occurences, 1);
	self := r;
end;

ds_occur := iterate (sort (ds_addr_slim, name_suffix, did, fname, lname), name_tra(left, right));

ds_names := dedup (sort(ds_occur, name_suffix, did, fname, lname,-name_occurences),
                                  name_suffix, did, fname, lname);

// pure addresses from input pre-calculated addresses
doxie.MAC_Address_Rollup (addresses,1000,Main_Dn);
doxie.Layout_Comp_Addresses tra(Main_Dn lef,Main_Dn ref) := transform
  self.address_seq_no := if(lef.address_seq_no <=0,1,lef.address_seq_no +1);
  self := ref;
  end;
ds_addresses := 
if(
	skipAddressRollup,
	addresses,
	iterate(Main_Dn,tra(left,right))
);

// STRING5 industry_class_val := '' : STORED('IndustryClass');
// industry_class_value := StringLib.StringToUpperCase (industry_class_val) : global;

// get_csa0 := doxie.Comp_Subject_Addresses(dids, dateVal,
// 	dppa_purpose, glb_purpose,
// 	ln_branded_value, , 
// 	probation_override_value, industry_class_value);

get_csa0 := doxie.Comp_Subject_Addresses(dids, , , , mod_access);

// enforce using [addresses] for FCRA-side queries
get_csa := IF (IsFCRA, ds_addresses, IF (EXISTS (addresses), ds_addresses, get_csa0.addresses));
get_csn := IF (IsFCRA, ds_names, IF (EXISTS (names), names, get_csa0.names));

addr := project (get_csa, doxie.layout_propertySearch);

byaddr0 := doxie_ln.fn_PropIDsByAddr(
  addr, 
  get_csn, 
  mod_access.date_threshold,
  mod_access.dppa,
  mod_access.glb,
  mod_access.ln_branded,
  mod_access.probation_override,
  true, //when Include_PriorProperties=false, i am going to go ahead and fetch them, use them to set the address_seq_no, and then filter them out at the bottom
	Use_CurrentlyOwnedProperty_value, ,
  IsFCRA,
	is_asset_report).records;

byaddr := project(byaddr0, rec);  

priors := byaddr(not current, source_code[1] <> 'S' or Use_CurrentlyOwnedProperty_value);  //when usecurr, these are ones without the subject's name
cor := byaddr(current);								//...and these are with the subjects names
currents := if(Use_CurrentlyOwnedProperty_value, cor, bydid); 

//***** ROLL THEM UP ******
  

cp := dedup(currents + priors, all);
Suppress.MAC_Suppress(cp,cp_filter,mod_access.application_type,,,Suppress.Constants.DocTypes.FaresID,fid);

// cannot use pullSSN in fcra-side:
cpclean := IF (IsFCRA, cp, cp_filter);

boolean myNNEQ(integer l, integer r) :=	(l = 0) or (r = 0) or (l = r);

rec rollem(rec le, rec ri) := transform
	self.current := le.current or ri.current;
	self.address_seq_no := if(le.address_seq_no > ri.address_seq_no, le.address_seq_no, ri.address_seq_no);
	self := ri;
end;

rolled := rollup(sort(cpclean, did, bdid, fid, address_seq_no, if(source_code[1]='S',0,1), record), 
			  left.did = right.did and
			  left.bdid = right.bdid and
			  left.fid = right.fid and 
			  (myNNEQ(left.address_seq_no, right.address_seq_no) or
			   left.address_seq_no < 0 or right.address_seq_no < 0) and
			   left.source_code = right.source_code,
			  rollem(left, right));


//***** POPULATE ADDRESS_SEQ_NO FOR BYDID ******	
pop := 
	join(
		rolled(current),
		dedup(sort(rolled(not current, address_seq_no >0), fid, -address_seq_no), fid),
		left.fid = right.fid,
		transform(
			rec,
			self.address_seq_no := if(right.address_seq_no > 0, right.address_seq_no, left.address_seq_no),
			self := left
		),
		left outer
	)
	+ rolled(not current and Include_PriorProperties);
	
// FOR DEBUG
// output(byaddr0, all, named('byaddr0'), extend);
// output(byaddr, named('byaddr'), extend, all);
// output(pop, named('pop'), extend, all);
// output(addresses, extend, named('pi_addresses'));
// output(ds_addresses, extend, named('pi_ds_addresses'));
// output(addr, extend, named('pi_addr'));

RETURN pop;
END;
