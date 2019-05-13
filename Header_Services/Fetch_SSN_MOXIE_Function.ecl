import ut, doxie, NID, header, dx_header;

i := dx_header.key_wild_SSN_EN();
				
doxie.layout_references xt(i r) := TRANSFORM
   SELF := r;
END;

pfe(string20 l, string20 r) := NID.mod_PFirstTools.PFLeqPFR(l, r);

export Fetch_SSN_MOXIE_Function(
               string9   ssn_value
 					    ,string20  lname_value
						  ,string20  fname_value
						  ,string20  mname_value
						  ,unsigned1 score_threshold_value
						  ,boolean   use_loose_logic = true
						  )

:= FUNCTION
// These may be moved into the function parameters if needed
boolean fuzzy_ssn := false;

        outrecs := project(
                   map( ~fuzzy_ssn => 
                   i(keyed(s1=ssn_value[1]),keyed(s2=ssn_value[2]),keyed(s3=ssn_value[3]),keyed(s4=ssn_value[4]),keyed(s5=ssn_value[5]),keyed(s6=ssn_value[6]),keyed(s7=ssn_value[7]),keyed(s8=ssn_value[8]),keyed(s9=ssn_value[9])),
                   i(wild(s1),keyed(s2=ssn_value[2]),keyed(s3=ssn_value[3]),keyed(s4=ssn_value[4]),keyed(s5=ssn_value[5]),keyed(s6=ssn_value[6]),keyed(s7=ssn_value[7]),keyed(s8=ssn_value[8]),keyed(s9=ssn_value[9])) +
                   i(keyed(s1=ssn_value[1]),wild(s2),keyed(s3=ssn_value[3]),keyed(s4=ssn_value[4]),keyed(s5=ssn_value[5]),keyed(s6=ssn_value[6]),keyed(s7=ssn_value[7]),keyed(s8=ssn_value[8]),keyed(s9=ssn_value[9])) +
                   i(keyed(s1=ssn_value[1]),keyed(s2=ssn_value[2]),wild(s3),keyed(s4=ssn_value[4]),keyed(s5=ssn_value[5]),keyed(s6=ssn_value[6]),keyed(s7=ssn_value[7]),keyed(s8=ssn_value[8]),keyed(s9=ssn_value[9])) +
                   i(keyed(s1=ssn_value[1]),keyed(s2=ssn_value[2]),keyed(s3=ssn_value[3]),wild(s4),keyed(s5=ssn_value[5]),keyed(s6=ssn_value[6]),keyed(s7=ssn_value[7]),keyed(s8=ssn_value[8]),keyed(s9=ssn_value[9])) +
                   i(keyed(s1=ssn_value[1]),keyed(s2=ssn_value[2]),keyed(s3=ssn_value[3]),keyed(s4=ssn_value[4]),wild(s5),keyed(s6=ssn_value[6]),keyed(s7=ssn_value[7]),keyed(s8=ssn_value[8]),keyed(s9=ssn_value[9])) +
                   i(keyed(s1=ssn_value[1]),keyed(s2=ssn_value[2]),keyed(s3=ssn_value[3]),keyed(s4=ssn_value[4]),keyed(s5=ssn_value[5]),wild(s6),keyed(s7=ssn_value[7]),keyed(s8=ssn_value[8]),keyed(s9=ssn_value[9])) +
                   i(keyed(s1=ssn_value[1]),keyed(s2=ssn_value[2]),keyed(s3=ssn_value[3]),keyed(s4=ssn_value[4]),keyed(s5=ssn_value[5]),keyed(s6=ssn_value[6]),wild(s7),keyed(s8=ssn_value[8]),keyed(s9=ssn_value[9])) +
                   i(keyed(s1=ssn_value[1]),keyed(s2=ssn_value[2]),keyed(s3=ssn_value[3]),keyed(s4=ssn_value[4]),keyed(s5=ssn_value[5]),keyed(s6=ssn_value[6]),keyed(s7=ssn_value[7]),wild(s8),keyed(s9=ssn_value[9])) +
                   i(keyed(s1=ssn_value[1]),keyed(s2=ssn_value[2]),keyed(s3=ssn_value[3]),keyed(s4=ssn_value[4]),keyed(s5=ssn_value[5]),keyed(s6=ssn_value[6]),keyed(s7=ssn_value[7]),keyed(s8=ssn_value[8])) )
			        (score_threshold_value > 10 
								OR 
								  (i.valid_ssn='G' and
			            (lname_value='' or lname = lname_value or 
				           moxie_lname_typo.r1(lname, lname_value) or 
		               moxie_lname_typo.r2(lname, lname_value) or 
		               moxie_lname_typo.r3(lname, lname_value) or 
		               moxie_lname_typo.r4(lname, lname_value) or 
		               moxie_lname_typo.r5(lname, lname_value) or
		               moxie_lname_typo.r6(lname, lname_value) or 
					         moxie_lname_typo.r7(lname, lname_value)
									)
								AND 
			            (fname_value='' or fname=fname_value or
				           trim(fname_value) = fname[1] and ut.nneq(mname[1],mname_value[1]) or
			             pfe(fname, fname_value) or header.is_moxie_nickname(trim(fname),trim(fname_value)) or
				           ((moxie_fname_typo.l1(fname,fname_value) or
		                 moxie_fname_typo.l2(fname,fname_value) or
			               moxie_fname_typo.l3(fname,fname_value) or
			               moxie_fname_typo.l4(fname,fname_value))
										 and 
			               (~moxie_fname_typo.l0(fname,fname_value) or ~header.is_moxie_neqname(fname, fname_value))
									 )
									 or
			             moxie_fname_typo.l5(fname,fname_value) or
			             moxie_fname_typo.l6(fname,fname_value)
									)
							 OR 
			            (lname=fname_value and fname=lname_value)
							 OR 
				          (fname=fname_value and ut.nneq(mname,mname_value) and 
					         use_loose_logic and ssn_value[1..5]<>'00000' and ssn_value[6..9]<>'0000'
									)
							 OR 
			            (lname=lname_value 
									 and 
									 (use_loose_logic            and
									  ssn_value[1..5]<>'00000'   and
										ssn_value[6..9]<>'0000'    and 
						        ut.nneq(mname,mname_value) and 
				            (datalib.gender(fname)=datalib.gender(fname_value)
										 or 
									   datalib.gender(fname)='U' or datalib.gender(fname_value)='U'
										)
				            or
										mname[1..length(trim(fname_value))]=fname_value
									 )
									)
						   OR  
				       (fname=lname_value and lname=mname_value and mname=fname_value)
							 )
				     ), xt(LEFT));				 
		                 
        return outrecs;

END;
