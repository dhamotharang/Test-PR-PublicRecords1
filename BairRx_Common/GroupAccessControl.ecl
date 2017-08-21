import BairRx_Common;

// Group Access Control: 
// 	This piece is supposed to implement what's described here: 
//		http://wiki.baircorp.com/display/SP/Group+Access+System
EXPORT GroupAccessControl := MODULE

	EXPORT LayoutGAC := RECORD
		BairRx_Common.Keys.GroupAccessKey.ori;
		BairRx_Common.Keys.GroupAccessKey.group_id;
		BairRx_Common.Keys.GroupAccessKey.owner;
		BairRx_Common.Keys.GroupAccessKey.mode_id;
		unsigned1 etype := 0;
	END;		
	
	EXPORT Clean(inf, agency_ori, ori_field = 'ori') := FUNCTIONMACRO

		GAK := BairRx_Common.Keys.GroupAccessKey;		
		LGAC := BairRx_Common.GroupAccessControl.LayoutGAC;
		
		// Restrictions are to be applied based on the ORI (agency) and mode of the incoming dataset.
		inFS 	:= PROJECT(inF, TRANSFORM(LGAC, 
			SELF.etype := BairRx_Common.EID.TypeFromString(LEFT.eid),
			SELF.mode_id := BairRx_Common.EID.TypeToMode(SELF.etype),
			SELF.ori := LEFT.ori_field; 
			SELF := []));
		
		// Keep only one ori per mode.
		inORI := DEDUP(SORT(inFS, ori, mode_id), ori, mode_id);
		
		// Pick the groups these agencies are sharing data with (owner=1), for each mode or all modes (mode_id=0)
		inORIGroups := JOIN(inORI, GAK, left.ori = right.ori and RIGHT.owner=1 and (RIGHT.mode_id=0 OR left.mode_id = right.mode_id), 
			TRANSFORM(LGAC, SELF.etype := LEFT.etype, SELF := RIGHT),
			LIMIT(BairRx_Common.Constants.MAX_JOIN_LIMIT)); 
		
		// Pick the groups the input agency has access to.
		agencyORIGroups := PROJECT(LIMIT(GAK(keyed(ori=agency_ori)), BairRx_Common.Constants.MAX_JOIN_LIMIT), TRANSFORM(LGAC, SELF := LEFT, SELF := [])); 
		
		// Get the allowable agencies, based on group ids and modes.
		granted := JOIN(inORIGroups, agencyORIGroups, 
			left.group_id = right.group_id and (RIGHT.mode_id=0 OR left.mode_id = right.mode_id), 
			TRANSFORM(LGAC,SELF := LEFT));
			
		// and finally, keep only what's allowable in the incoming dataset.
		outF := JOIN(inF, granted, LEFT.ori_field = RIGHT.ori and (RIGHT.mode_id=0 OR BairRx_Common.EID.TypeFromString(LEFT.eid) = RIGHT.etype), TRANSFORM(LEFT), keep(1), LIMIT(0));
		
		RETURN IF(agency_ori<>'', outF, inF);
	ENDMACRO;

END;