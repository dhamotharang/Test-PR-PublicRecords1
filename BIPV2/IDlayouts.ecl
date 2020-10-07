EXPORT IDlayouts := 
MODULE

/* 
***********************
START - DO NOT EDIT - Do not edit or reproduce or copy the code or ID names below here without the express written consent of Chad Morton or Jill Luber.
***********************
*/

shared type_id 			:= unsigned6;
shared type_score		:= unsigned2;	//1-100.  measure of how unique a match is (requires a minimal level of strength in the match)
shared type_weight	:= unsigned2; //range no fixed.  SALT generated.  measure of combined specificities of matching fields and concepts.  measure of strength of match.  (regardless of uniqueness)

// this is the layout returned by the external linking process

export l_xlink_ids := record

	type_id 		DotID			:= 0;
	type_score	DotScore	:= 0;
	type_weight	DotWeight	:= 0;
   
	// in BIP2.0, these will always be 0
	type_id 		EmpID			:= 0;
	type_score	EmpScore	:= 0;
	type_weight	EmpWeight	:= 0;
	
	// in BIP2.0, these will always be 0
	type_id 		POWID			:= 0;
	type_score	POWScore	:= 0;
	type_weight	POWWeight	:= 0;
	
	type_id 		ProxID		:= 0;
	type_score	ProxScore	:= 0;
	type_weight	ProxWeight:= 0;
	
	type_id 		SELEID		:= 0;
	type_score	SELEScore	:= 0;
	type_weight	SELEWeight:= 0;	
	
	type_id 		OrgID			:= 0;
	type_score	OrgScore	:= 0;
	type_weight	OrgWeight	:= 0;
	
	type_id 		UltID			:= 0;
	type_score	UltScore	:= 0;
	type_weight	UltWeight	:= 0;	

end;

export l_xlink_ids2 := record(l_xlink_ids)
	type_id			UniqueID := 0;
end;

// this is the layout that should be used at the beginning of header derived datasets (where weight and score make no sense)
export l_key_ids_bare := record
	l_xlink_ids.UltID;
	l_xlink_ids.OrgID;
	l_xlink_ids.SELEID;
	l_xlink_ids.ProxID;
	l_xlink_ids.POWID;
	l_xlink_ids.EmpID;
	l_xlink_ids.DotID;
end;

// this is the layout that should be used at the beginning of appended dataset indexes
export l_key_ids := record
	l_key_ids_bare;
	
	l_xlink_ids.UltScore;
	l_xlink_ids.OrgScore;
	l_xlink_ids.SELEScore;
	l_xlink_ids.ProxScore;
	l_xlink_ids.POWScore;
	l_xlink_ids.EmpScore;
	l_xlink_ids.DotScore;

	l_xlink_ids.UltWeight;
	l_xlink_ids.OrgWeight;
	l_xlink_ids.SELEWeight;
	l_xlink_ids.ProxWeight;
	l_xlink_ids.POWWeight;
	l_xlink_ids.EmpWeight;
	l_xlink_ids.DotWeight;
end;

// this is the layout to be used within the header file

export l_header_ids := record
	type_id 		DotID;
	type_id 		EmpID;
	type_id 		POWID;
	type_id 		ProxID;
	type_id 		SELEID;  
	type_id 		OrgID;
	type_id 		UltID;
end;


    //BH-840 Filter layout
    EXPORT l_filter_record := RECORD
        unsigned6 UniqueId;
        string10 prim_range;
        string28 prim_name;
        string8 sec_range;
        string5 zip;
        string9 company_fein;
        string10 company_phone;
    END;
/* 
***********************
END - DO NOT EDIT
***********************
*/


END;