IMPORT doxie, bipv2, ut, Data_Services, autokeyb2, PRTE2_FCC, FCC, versioncontrol;

EXPORT Keys := MODULE

	//BDID
	Layouts.FCC_BDID_rec norm(Files.FCC_base L,integer cnt) := transform
		self.bdid := choose(cnt,l.licensee_bdid,l.dba_bdid,l.firm_bdid);
		self := l;
	end;
 
	all_bdids := normalize(Files.FCC_base,3,norm(left,counter));
	rm_dups := dedup(all_bdids(bdid>0),all);

	EXPORT FCC_BDID := index(rm_dups,{bdid},{fcc_seq},Constants.KEY_PREFIX + doxie.Version_SuperKey + '::bdid');
	
	//DID
	EXPORT FCC_DID := index(Files.FCC_base(attention_did>0),{unsigned did := Files.FCC_base.attention_did},{fcc_seq},Constants.KEY_PREFIX + doxie.Version_SuperKey + '::did');
	
	//Seq
	EXPORT FCC_seq := index(Files.FCC_base,{fcc_seq},{Files.FCC_base},Constants.KEY_PREFIX + doxie.Version_SuperKey + '::seq');
	
	//LinkIDs
	EXPORT FCC_Linkids := MODULE

	// DEFINE THE INDEX
	SHARED superfile_name		:= Constants.KEY_PREFIX + doxie.Version_SuperKey + '::linkids';
	SHARED Base							:= Files.FCC_base_BIP;

	BIPV2.IDmacros.mac_IndexWithXLinkIDs(Base, k, superfile_name)
	EXPORT Key := k;
	
	//DEFINE THE INDEX ACCESS
	EXPORT kFetch(
		dataset(BIPV2.IDlayouts.l_xlink_ids) inputs, 
		string1 Level = BIPV2.IDconstants.Fetch_Level_DotID,	//The lowest level you'd like to pay attention to.  If U, then all the records for the UltID will be returned.
																								//Values:  D is for Dot.  E is for Emp.  W is for POW.  P is for Prox.  O is for Org.  U is for Ult.
																								//Should be enumerated or something?  at least need constants defined somewhere if you keep string1
		unsigned2 ScoreThreshold = 0								//Applied at lowest leve of ID
		) :=
	FUNCTION

		BIPV2.IDmacros.mac_IndexFetch(inputs, Key, out, Level)
		RETURN out;																					

	END;

END;


END;