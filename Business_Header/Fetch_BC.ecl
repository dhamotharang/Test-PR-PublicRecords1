import doxie,ut, NID;

export Fetch_BC 
	(unsigned6 bdid_value = 0,
	 unsigned6 did_value = 0,
	 string9 ssn_value = '',
	 string25 fname_value = '', 
	 string25 mname_value = '', 
	 string25 lname_value = '',
	 string20 prange_value = '',
	 string40 pname_value = '',
	 string50 city_value = '',
	 string2 state_value = '', 
	 string5 zip_val = '',
	 string100 company_name_Value = '',
	 boolean glb_ok = false,
	 boolean dppa_ok = false,
	 boolean nicknames = false, 
	 boolean phonetics = false
	 ) :=
FUNCTION
//Business_Header.doxie_MAC_Field_Declare()
k_fetched := 
	IF (ssn_value <> '',
      Business_Header.Fetch_BC_Key_SSN((unsigned4)ssn_value),
			Business_Header.Fetch_BC_Key_State_LFName(state_value, fname_value, lname_value, nicknames, phonetics));
    
did_value_ds := dataset([{did_value}], doxie.layout_references);		
c_fetched := 
  map(bdid_value > 0 => Business_Header.Fetch_BC_BDID(bdid_value),
			did_value > 0  => Business_Header.Fetch_BC_DID(did_value_ds),
      dedup(business_header.Fetch_BC_ByGetDIDs () + 
				    business_header.Fetch_BC_Full(k_fetched), record, all));

filter := (lname_value='' or c_fetched.lname=lname_value
             or metaphonelib.DMetaPhone1(c_fetched.lname)=metaphonelib.DMetaPhone1(lname_value))
		 and
		(fname_value='' or c_fetched.fname[1..length(trim(fname_value))]=fname_value
			or fname_value[1..length(trim(c_fetched.fname))]=c_fetched.fname
			or NID.mod_PFirstTools.SUBPFLeqPFR(c_fetched.fname, fname_value)
			or NID.mod_PFirstTools.SUBPFLeqR(fname_value, c_fetched.fname)) 
		and
		(mname_value='' or c_fetched.mname='' or c_fetched.mname[1..length(trim(mname_value))]=mname_value[1..length(trim(mname_value))] or
			mname_value[1..length(trim(c_fetched.mname))]=c_fetched.mname[1..length(trim(c_fetched.mname))]
			or NID.mod_PFirstTools.PFLeqPFR(c_fetched.mname, mname_value)) 
		and
		(city_value='' or c_fetched.city		 = city_value
					or c_fetched.company_city = city_value) 
		and
		(state_value='' or c_fetched.state		   = state_value
					 or c_fetched.company_state = state_value) 
		and
		(zip_val='' or c_fetched.zip=(unsigned3)zip_val
				  or c_fetched.company_zip = (unsigned3)zip_val) 
		and
		(prange_value='' or (integer)c_fetched.prim_range         = (integer)prange_value
					  or (integer)c_fetched.company_prim_range = (integer)prange_value) 
		and
		((company_name_value = '' or ut.StringSimilar(c_fetched.company_name,company_name_value) <= 3)
			or (bdid_value != 0 and c_fetched.bdid = bdid_value))			
		and
		(glb_ok or ~c_fetched.glb) 
		and
		(dppa_ok or ~c_fetched.dppa);

contact_match := c_fetched(filter);

return contact_match;

END;