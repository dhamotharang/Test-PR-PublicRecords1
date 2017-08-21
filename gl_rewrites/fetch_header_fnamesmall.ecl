import doxie,ut;
export Fetch_Header_FNameSmall(
	gl_rewrites.person_interfaces.i__fetch_header_fnamesmall in_parms) :=
		function
			i := doxie.Key_Header_FnameSmall;
			dti := doxie.Key_Header_DTS_FnameSmall;

			first_fil := in_parms.lname_value='' AND in_parms.fname_value<>'';

			Mac_Header_Indexing.gen_withdobfilt(i,gen_fil,TRUE)
			Mac_Header_Indexing.pref(i,pref_fil)
			Mac_Header_Indexing.state(i,state_fil)
			Mac_Header_Indexing.Zip(i,zip_fil)
			Mac_Header_Indexing.pname(i,pname_fil)

			refcount :=
			RECORD
				doxie.layout_references;
				i.fname_count;
			END;

			index_Lev1(boolean keyedcount) := project(i(first_fil,
													keyed(pref_fil) AND
													keyed(state_fil OR  i.st='') AND
													keyed(zip_fil OR i.zip=0 OR in_parms.zip_value=[]) AND
													nofold(pname_fil OR i.prim_name='' OR in_parms.pname_value='') AND
													gen_fil), refcount);

			//allowing dt_seen fitler
			Mac_Header_Indexing.gen_withdobfilt(dti,gen_fil_dt,TRUE)
			Mac_Header_Indexing.pref(dti,pref_fil_dt)
			Mac_Header_Indexing.state(dti,state_fil_dt)
			Mac_Header_Indexing.Zip(dti,zip_fil_dt)
			Mac_Header_Indexing.pname(dti,pname_fil_dt)

			index_LevDt(boolean keyedcount) := project(dti(first_fil,
													keyed(pref_fil_dt) AND
															 keyed(state_fil_dt OR  dti.st='') AND
														keyed(zip_fil_dt OR dti.zip=0 OR in_parms.zip_value=[]) AND
													keyed(in_parms.date_first_seen_value=0 and dt_last_seen >= in_parms.date_last_seen_value or 
																												in_parms.date_first_seen_value<>0 and dt_last_seen >= in_parms.date_first_seen_value) AND
													(pname_fil_dt OR dti.prim_name='' OR in_parms.pname_value='') AND
													(in_parms.date_first_seen_value=0 and dt_first_seen <= in_parms.date_last_seen_value or 
																									 in_parms.date_first_seen_value<>0 and dt_first_seen <= in_parms.date_last_seen_value) AND
													gen_fil_dt), refcount);

			index_Lev(boolean keyedcount) := if(in_parms.allow_date_seen_value and in_parms.date_last_seen_value<>0 and in_parms.pname_value<>'', 
																					index_LevDt(keyedcount), index_Lev1(keyedcount));

			Fetch_Lev_fail := LIMIT(LIMIT(index_Lev(false)
									, 100000, FAIL(203, doxie.ErrorCodes(203)), keyed)
									, doxie.Limit_FetchUnkeyed  , FAIL(203, doxie.ErrorCodes(203)));
												
			Fetch_Lev_nofail := LIMIT(LIMIT(index_Lev(false)
										, 100000, SKIP, keyed)
										, doxie.Limit_FetchUnkeyed  , SKIP);

			Fetch_Lev1 := IF(in_parms.noFail, Fetch_Lev_nofail, Fetch_Lev_fail);

			// Would be better if the fail were in the transform, but Roxie bug
			doxie.layout_references check_count(refcount le) :=
			TRANSFORM
				SELF.did := IF(le.fname_count>20000,SKIP,le.did);
			END;
				
			p_final := PROJECT(Fetch_Lev1, check_count(LEFT));

			return IF(COUNT(Fetch_Lev1) > COUNT(p_final),
																									FAIL(doxie.layout_references,11,doxie.ErrorCodes(11)),
																									p_final);
																								
		END;