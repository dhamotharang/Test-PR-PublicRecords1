IMPORT  doxie,mdr,BIPV2, Data_Services;

EXPORT keys := MODULE

  EXPORT key_oshairaccident := INDEX(FILES.NewKeyBuild_accident2, {activity_number},  {files.NewKeyBuild_accident2},
	constants.KeyName_oshair + 'accident_@version@');

  EXPORT key_oshairinspection := INDEX(FILES.file_out_inspection_cleaned2, {activity_number},{files.file_out_inspection_cleaned2}, 
  constants.KeyName_oshair + 'inspection_@version@');  
	
	 EXPORT key_oshairviolations := INDEX(FILES.NewKeyBuild_violations2,{activity_number},{FILES.NewKeyBuild_violations2}, 
	 constants.KeyName_oshair + 'violations_@version@');  
	 
	  EXPORT key_oshairhazardous_substance := INDEX(FILES.NewKeyBuild_substance2,{activity_number},{FILES.NewKeyBuild_substance2},
	  constants.KeyName_oshair + 'substance_@version@');  
	
 EXPORT key_oshairbdid := INDEX(FILES.tbl_bdid,{bdid}, {Activity_Number},
   constants.KeyName_oshair + 'Bdid_@version@'); 
	 
	EXPORT key_oshairprogram := INDEX(FILES.NewKeyBuild_program2, {activity_number},{files.NewKeyBuild_program2}, 
	 constants.KeyName_oshair + 'program_@version@');

 
 
EXPORT LinkIds := MODULE
			
	SHARED Base						  	:= files.file_out_inspection_cleaned_both;
	
   slimLayout	:=	record
		layouts.layout_OSHAIR_inspection_clean_BIP	 
		  - dt_first_seen	- dt_last_seen						 
			- dt_vendor_first_reported - dt_vendor_last_reported;	  
  end;

  NewKeyBuild	:=	project(Base, TRANSFORM(slimLayout,SELF := LEFT;));
	
	NewKeyBuild2	:=	project(NewKeyBuild,
	                  TRANSFORM(layouts.linkids2,
										              self:=LEFT; 
                                  self:=[];
                                  ));
	
	
	BIPV2.IDmacros.mac_IndexWithXLinkIDs(NewKeyBuild2, k, constants.KeyName_oshair + 'linkids_@version@');
	EXPORT Key := k;

	EXPORT kFetch2(
		DATASET(BIPV2.IDlayouts.l_xlink_ids2) inputs, 
		STRING1 Level = BIPV2.IDconstants.Fetch_Level_DotID,	//The lowest level you'd like to pay attention to.  If U, then all the records for the UltID will be returned.
																								//Values:  D is for Dot.  E is for Emp.  W is for POW.  P is for Prox.  O is for Org.  U is for Ult.
																								//Should be enumerated or something?  at least need constants defined somewhere if you keep string1
		UNSIGNED2 ScoreThreshold = 0,								//Applied at lowest leve of ID
		joinLimit = 25000,
		UNSIGNED1 JoinType = BIPV2.IDconstants.JoinTypes.KeepJoin
		) :=
	FUNCTION
		BIPV2.IDmacros.mac_IndexFetch2(inputs, Key, out, Level, joinLimit, JoinType);
		RETURN out;																					
	END;
END; 
  	

END;
