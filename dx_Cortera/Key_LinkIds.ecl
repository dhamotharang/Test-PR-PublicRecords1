IMPORT $, BIPV2, doxie;

EXPORT Key_LinkIds := MODULE

	// DEFINE THE LinkIds INDEX
  shared superfile_name  := $.Keynames().LinkIds.QA;
	
	EXPORT key_rec := RECORD
    BIPV2.IDlayouts.l_key_ids;
    $.Layouts.Layout_Header_Out - BIPV2.IDlayouts.l_xlink_ids;
    integer1 fp := 0;  					//for platform?
  end;
  
  EXPORT Key := INDEX(
											 {BIPV2.IDlayouts.l_key_ids_bare}, //{UltID,OrgID,SELEID,ProxID,POWID,EmpID,DotID},    
											 {key_rec},    
											 superfile_name
										 );  
  
	//DEFINE THE INDEX ACCESS
  EXPORT kFetch(dataset(BIPV2.IDlayouts.l_xlink_ids) inputs, 
								string1 Level = BIPV2.IDconstants.Fetch_Level_DotID,  //The lowest level you'd like to pay attention to.  If U, then all the records for the UltID will be returned.
																																			//Values:  D is for Dot.  E is for Emp.  W is for POW.  P is for Prox.  O is for Org.  U is for Ult.
																																			//Should be enumerated or something?  at least need constants defined somewhere if you keep string1
								unsigned2 ScoreThreshold = 0                					//Applied at lowest level of ID
							 ) :=
  FUNCTION

    BIPV2.IDmacros.mac_IndexFetch(inputs, Key, out, Level)
    return out;                                          
  end;
	
	//DEFINE THE INDEX ACCESS
	 EXPORT kFetch2(dataset(BIPV2.IDlayouts.l_xlink_ids2) inputs, 
									string1 Level = BIPV2.IDconstants.Fetch_Level_DotID,
									unsigned2 ScoreThreshold = 0,
									joinLimit = 25000,
									unsigned1 JoinType = BIPV2.IDconstants.JoinTypes.KeepJoin,
									doxie.IDataAccess mod_access = MODULE (doxie.IDataAccess) END,
									boolean append_contact = FALSE
								 ) :=
	 FUNCTION

					BIPV2.IDmacros.mac_IndexFetch2(inputs, Key, fetched, Level, joinLimit, JoinType);
					$.mac_check_access(fetched, out, mod_access, append_contact);
					return out;
	end;
	
end;
