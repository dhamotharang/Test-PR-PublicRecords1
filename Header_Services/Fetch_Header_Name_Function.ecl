import doxie, dx_header, NID;

i := dx_header.key_name();

doxie.layout_references xt(i r) := TRANSFORM
                                        SELF := r;
                                 END;
pfe(string20 l, string20 r) := NID.mod_PFirstTools.SubLinPFR(l,r);
 
export Fetch_Header_Name_Function(string20 fname_value
												 ,string20 lname_value
												 ,boolean phonetics
												 ,boolean nicknames
													) 
:= MODULE
		  shared ids := i(//lname_value != '', // uncomment this when bugzilla 16202 gets deployed
			(dph_lname=metaphonelib.DMetaPhone1(lname_value)),
			((lname=lname_value OR phonetics)),
			(pfe(pfname,fname_value) OR pfname[1..length(trim(fname_value))]=(STRING20)fname_value OR LENGTH(TRIM(fname_value))<2),
			(fname[1..length(trim(fname_value))]=fname_value OR (nicknames AND LENGTH(TRIM(fname_value))>=2)) 
		   );
			shared idsp := project(  LIMIT(LIMIT(ids, 100000, SKIP, keyed), 9000  , SKIP), xt(LEFT));
			EXPORT lafn := if(count(idsp) != 0
								, false
									, if ( count(ids) = 0
									, false
									, true
									)
								);
			EXPORT outrec := idsp;
	END;
  