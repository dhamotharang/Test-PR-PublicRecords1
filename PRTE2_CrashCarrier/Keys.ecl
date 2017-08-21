IMPORT  doxie,mdr, BIPV2;;

EXPORT keys := MODULE


EXPORT Key_LinkIds := MODULE

shared dkeybuild		:= project(files.crashcarrier_base, transform(layouts.keybuild, self := left));	                          	


	BIPV2.IDmacros.mac_IndexWithXLinkIDs(dkeybuild, k, 
	constants.KeyName_crashcarrier + doxie.Version_SuperKey + '::linkids');
  
	export Key := k;

	//DEFINE THE INDEX ACCESS
	export kFetch(
		dataset(BIPV2.IDlayouts.l_xlink_ids) inputs, 
		string1 Level = BIPV2.IDconstants.Fetch_Level_DotID,	//The lowest level you'd like to pay attention to.  If U, then all the records for the UltID will be returned.
																								//Values:  D is for Dot.  E is for Emp.  W is for POW.  P is for Prox.  O is for Org.  U is for Ult.
																								//Should be enumerated or something?  at least need constants defined somewhere if you keep string1
		unsigned2 ScoreThreshold = 0								//Applied at lowest leve of ID
		) :=
	FUNCTION

		BIPV2.IDmacros.mac_IndexFetch(inputs, Key, out, Level)
		return out;																					

	END;

END;
end;
