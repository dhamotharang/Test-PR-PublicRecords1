IMPORT BIPV2, doxie,Data_Services;

EXPORT Key_Sanctions_LinkIds := MODULE
		shared temp_rec:=record
			Ingenix_NatlProf.layout_sanctions_bdid -DerivedReinstateDate;
		end;
		
		shared base_recs := project(Ingenix_NatlProf.Basefile_Sanctions_Bdid,transform(temp_rec,self:=left;));		

		export  out_SuperFile_Name  := Data_Services.Data_location.Prefix('Ingenix_NatlProf')+'thor_data400::key::ingenix_sanctions_linkids_' + doxie.Version_SuperKey; //linkids Key Super FileName

		BIPV2.IDmacros.mac_IndexWithXLinkIDs(base_recs, out_key, out_SuperFile_Name);
		export Key := out_key;
  
	//DEFINE THE INDEX ACCESS
export KeyFetch(
		dataset(BIPV2.IDlayouts.l_xlink_ids) in_ds_withids, 
		string1 Level = BIPV2.IDconstants.Fetch_Level_DotID,	//The lowest level you'd like to pay attention to.  If U, then all the records for the UltID will be returned.
																												 //Values:  D is for Dot.  E is for Emp.  W is for POW.  P is for Prox.  O is for Org.  U is for Ult.
																												//Should be enumerated or something?  at least need constants defined somewhere if you keep string1
		unsigned2 ScoreThreshold = 0											 //Applied at lowest leve of ID
								) :=FUNCTION

		BIPV2.IDmacros.mac_IndexFetch(in_ds_withids, Key, out_fetch, Level)
		return out_fetch;	
END;

END;