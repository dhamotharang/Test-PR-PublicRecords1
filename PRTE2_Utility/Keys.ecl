import doxie, BIPV2, Data_Services;

EXPORT Keys := module

shared file_util_orig_in := project(files.full_did_for_index, layouts.slimrec);

shared file_util_orig_in_address := project(files.full_did_for_index_address, layouts.slimrec);

export Address := 
       index(file_util_orig_in_address(trim(prim_name)<>''),
             {prim_name,st,zip,prim_range,sec_range},
						 {file_util_orig_in_address},
						 constants.key_prefix_util +doxie.Version_SuperKey+ '::utility_address');
					
export DID := index(file_util_orig_in,
             {unsigned6 s_did := (unsigned6)did},
						 {file_util_orig_in},
						 constants.key_prefix_util +doxie.Version_SuperKey+ '::utility_did');						
						 

export misc2b_hval  := index(files.misc2b,{hval},{files.misc2b}, constants.key_prefix_date +doxie.Version_SuperKey+ '::hval');

shared pfile := PROJECT(files.util_daily,transform(layouts.did_out, self.ssn := '',self := left));
export daily_fdid := INDEX(pfile,{fdid},{pfile},constants.Key_prefix +doxie.Version_SuperKey+ '::daily.fdid');
export daily_did 	:= INDEX(pfile,{unsigned6 s_did := (unsigned6)did},{pfile}, constants.key_prefix +doxie.Version_SuperKey+ '::daily.did');

EXPORT LinkIds := MODULE

  // DEFINE THE INDEX
	shared superfile_name	:= constants.key_prefix +doxie.Version_SuperKey+ '::linkids';
	
	keyfile := project(files.full_did_for_index_bdid, {files.full_did_for_index_bdid} - [bug_num, cust_num]);
	BIPV2.IDmacros.mac_IndexWithXLinkIDs(keyfile, k, superfile_name)
	export Key := k;

	// DEFINE THE INDEX ACCESS
	export kFetch2(
		dataset(BIPV2.IDlayouts.l_xlink_ids2) inputs, 
		string1 Level = BIPV2.IDconstants.Fetch_Level_DotID,	// The lowest level you'd like to pay attention to.  If U, then all the records for the UltID will be returned.
																													// Values:  D is for Dot.  E is for Emp.  W is for POW.  P is for Prox.  O is for Org.  U is for Ult.
																													// Should be enumerated or something?  at least need constants defined somewhere if you keep string1
		unsigned2 ScoreThreshold = 0,													// Applied at lowest leve of ID
		joinLimit = 25000,
		unsigned1 JoinType = BIPV2.IDconstants.JoinTypes.KeepJoin
		) :=
	FUNCTION

		BIPV2.IDmacros.mac_IndexFetch2(inputs, Key, out, Level, joinLimit, JoinType);
		return out;																					

	END;


END;

end;						 