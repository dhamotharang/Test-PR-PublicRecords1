IMPORT BIPV2,data_services;

EXPORT Key_LinkIds := MODULE

  // DEFINE THE INDEX
	shared superfile_name	:= Keynames().linkids.qa;
//	shared superfile_name	:= data_services.data_location.prefix() + 'thor_data400::key::sheila_greco::qa::linkids';
	
	shared Base := File_Base;
  
	maxRec := record, maxLength(9999)
     Sheila_Greco.Layouts.Base.Companies;
    end;
  
	newBase:=project(Base ,transform(maxRec, self := left;));	
		
	BIPV2.IDmacros.mac_IndexWithXLinkIDs(newBase, k, superfile_name)
	export Key := k;

	//DEFINE THE INDEX ACCESS
	export kFetch(
		dataset(BIPV2.IDlayouts.l_xlink_ids) inputs, 
		string1 Level = BIPV2.IDconstants.Fetch_Level_DotID,	//The lowest level you'd like to pay attention to.  If U, then all the records for the UltID will be returned.
																								//Values:  D is for Dot.  E is for Emp.  W is for POW.  P is for Prox.  O is for Org.  U is for Ult.
																								//Should be enumerated or something?  at least need constants defined somewhere if you keep string1
		unsigned2 ScoreThreshold = 0,								//Applied at lowest level of ID
		joinLimit = 25000
		) :=
	FUNCTION

		BIPV2.IDmacros.mac_IndexFetch(inputs, Key, out, Level,joinLimit)
		return out;																					

	END;

END;