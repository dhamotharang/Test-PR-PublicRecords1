import ut, NID;
// This macro is used inside a transform function; the caller must include all required IMPORTs.

export MAC_Gong_History_Penalty(l_rec,fallback) 
:= MACRO  

// Name Stuff
MAP(lname_value='' or l_rec.name_last=lname_value => 0,
    metaphonelib.DMetaPhone1(l_rec.name_last)=metaphonelib.DMetaPhone1(lname_value) => 2,
    l_rec.name_last='' => 3,
    MIN (datalib.namesimilar(l_rec.name_last,lname_value,1)*3,10)) +

MAP(fname_value='' or l_rec.name_first=fname_value => 0,
    NID.mod_PFirstTools.PFLeqPFR(l_rec.name_first, fname_value) => 1,
    l_rec.name_first[1]=fname_value or l_rec.name_first=fname_value[1] => 1,
    l_rec.name_first='' => 3,
    MIN((datalib.namesimilar(l_rec.name_first,fname_value,1) * 3),10)) +

MAP(mname_value='' or l_rec.name_middle=mname_value => 0,
    l_rec.name_middle[1]=mname_value or l_rec.name_middle=mname_value[1] => 2,
    l_rec.name_middle='' => 2,
    MIN((datalib.namesimilar(l_rec.name_middle,mname_value,1) * 3),10)) +

// Phone Stuff
MAP (phone_value='' or l_rec.phone10=phone_value or l_rec.phone10[4..10]=phone_value => 0 ,
		l_rec.phone10=phone_value[4..10] => 1,
		l_rec.phone10[4..10]=phone_value[4..10] => 2,
		l_rec.phone10='' =>3, 10) +

// Address Stuff
MAP ((unsigned8)prange_value=0 or (unsigned8)l_rec.prim_range=(unsigned8)prange_value => 0,
		 addr_range and (unsigned)l_rec.prim_range >= prange_beg_value and
				(unsigned)l_rec.prim_range <= prange_end_value => 0,
		 addr_wild and StringLib.StringWildMatch(l_rec.prim_range,prange_wild_value, TRUE) => 0,
		 dir_prange_range and (unsigned)l_rec.prim_range >= dir_prange_beg_value and
				(unsigned)l_rec.prim_range <= dir_prange_end_value => 0,
		 dir_prange_wild and StringLib.StringWildMatch(l_rec.prim_range,dir_prange_value, TRUE) => 0,
		 (unsigned8)l_rec.prim_range=0 => 2, 
     ut.stringsimilar(prange_value,l_rec.prim_range)) +

MAP (pname_value='' or ut.StripOrdinal(l_rec.prim_name)=pname_value => 0,
     l_rec.prim_name='' => 8, 
     ut.stringsimilar(pname_value,l_rec.prim_name)) +

MAP (sec_range_value='' or l_rec.sec_range=sec_range_value => 0,
		 l_rec.sec_range='' => 2, // maybe more stuff here?
     ut.stringsimilar(sec_range_value,l_rec.sec_range)) +

MAP (city_value=''  or l_rec.p_city_name=city_value => 0, 
     l_rec.p_city_name='' => 2,
     zipradius_value>0 or ut.stringsimilar(l_rec.p_city_name,city_value)<3 => 1,	 
     2 ) +

MAP	(state_value='' or l_rec.st=state_value => 0, 
     fallback => 1, 
		 10 ) +

MAP (zip_value=[] => 0,
     (unsigned4)l_rec.z5=0 => 2,
		 (unsigned4)(4*ut.zip_Dist(IF(zip_val<>'',zip_val,city_zip_value),l_rec.z5) / zipradius_value )) 

ENDMACRO;