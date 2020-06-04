import doxie, Data_Services, BIPV2;

EXPORT Keys := module

slimBase := project(files.base, transform(Layouts.Slim_Base, self := left));
export bdid := index(slimBase(bdid <> 0),{bdid},{slimBase}, Constants.key_prefix + doxie.Version_SuperKey + 'bdid' );

EXPORT LinkIds := MODULE
// DEFINE THE INDEX
	shared superfile_name		:= Data_Services.Data_location.Prefix('NONAMEGIVEN')+ Constants.key_prefix + doxie.Version_SuperKey + 'linkids';
	
	shared Base				:= project(files.base, {files.base}- [cust_name, bug_num, link_fein, link_inc_date, link_ssn, link_dob] );
	
	 
	BIPV2.IDmacros.mac_IndexWithXLinkIDs(Base, k, superfile_name)
	export Key := k;


	//DEFINE THE INDEX ACCESS
	export kFetch2(
		dataset(BIPV2.IDlayouts.l_xlink_ids2) inputs, 
		string1 Level = BIPV2.IDconstants.Fetch_Level_DotID,	//The lowest level you'd like to pay attention to.  If U, then all the records for the UltID will be returned.
																								//Values:  D is for Dot.  E is for Emp.  W is for POW.  P is for Prox.  O is for Org.  U is for Ult.
																								//Should be enumerated or something?  at least need constants defined somewhere if you keep string1
		unsigned2 ScoreThreshold = 0,								//Applied at lowest leve of ID
		joinLimit = 25000,
		unsigned1 JoinType = BIPV2.IDconstants.JoinTypes.KeepJoin
		) :=
	FUNCTION

		BIPV2.IDmacros.mac_IndexFetch2(inputs, Key, out, Level, joinLimit, JoinType);
		return out;																					

	END;
	
	
END;

												
END;
