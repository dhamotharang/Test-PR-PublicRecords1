import ut, doxie, NID, header, dx_header;

i := dx_header.key_wild_address_EN();

doxie.layout_references xt(i r) := TRANSFORM
      SELF := r;
END;

export Fetch_Address_MOXIE_Function (string10 prange_value
 							  ,string28 pname_value
							  ,string25 city_value
							  ,string2 state_value
							  ,string5 zip_val
							  ,unsigned2 zip_radius_value
							  ,string8 sec_range_value
							  ,string20 lname_value
							  ,string20 fname_value
							  ,string20 mname_value
							  ,boolean phonetics
							  ) 
:= function

     city_zip_value := ziplib.CityToZip5(state_value, city_value);
     zip_value := IF(zip_val<>'', IF(ziplib.ZipsWithinRadius(zip_val, zip_radius_value)=[],
  				  						           [(INTEGER4)zip_val],
												 ziplib.ZipsWithinRadius(zip_val, zip_radius_value)),
			   IF(state_value<>'' AND city_value<>'' AND zip_radius_value>0, ziplib.ZipsWithinRadius(city_zip_value, zip_radius_value),
			      []));

     pfe(string20 l, string20 r) := NID.mod_PFirstTools.PFLeqPFR(l,r);

     ids :=i(
		 keyed(prim_name=pname_value), 
		 keyed(prim_range=prange_value),
		 keyed(city_code in doxie.Make_CityCodes(city_value).rox OR city_value=''),
		 keyed(state_value=st OR state_value=''),
		 //zip_value=[] or (integer4)zip IN zip_value,
		  (lname_value='' or lname = lname_value or 
		    moxie_lname_typo.r1(lname, lname_value) or 
		    moxie_lname_typo.r2(lname, lname_value) or 
		    moxie_lname_typo.r3(lname, lname_value) or 
		    moxie_lname_typo.r4(lname, lname_value) or 
		    moxie_lname_typo.r5(lname, lname_value) or
		    moxie_lname_typo.r6(lname, lname_value) or 
		    moxie_lname_typo.r7(lname, lname_value)) AND 
		  (fname_value='' or fname=fname_value or
		    trim(fname_value)=fname[1] and ut.nneq(mname[1],mname_value[1]) or
		    pfe(fname, fname_value) or header.is_moxie_nickname(trim(fname),trim(fname_value)) or
		    ((moxie_fname_typo.l1(fname,fname_value) or
		      moxie_fname_typo.l2(fname,fname_value) or
		      moxie_fname_typo.l3(fname,fname_value) or
		      moxie_fname_typo.l4(fname,fname_value)) and 
		      (~moxie_fname_typo.l0(fname,fname_value) or
		       ~header.is_moxie_neqname(fname, fname_value))) or
		      moxie_fname_typo.l5(fname,fname_value) or
		      moxie_fname_typo.l6(fname,fname_value)) OR
		  (fname=lname_value and lname=fname_value) OR  
		  (lname=lname_value and length(trim(lname_value))>3 and 
		   mname=fname_value and length(trim(fname_value))>3) OR
		  ((trim(fname_value)=fname[1..length(trim(fname_value))] or
		    trim(fname)=fname_value[1..length(trim(fname))]) and 
				(sec_range_value='' or sec_range=sec_range_value) and 
		   lname=lname_value and length(trim(lname_value))>3)
		 );
   
     outrecs := project(LIMIT(LIMIT(ids, 100000, SKIP, keyed),9000, SKIP), xt(LEFT));
 
     return outrecs;
  
END;
