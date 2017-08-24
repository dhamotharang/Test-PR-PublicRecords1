import BairRx_Common,BairRx_CFS,BairRx_Crash,BairRx_Event,BairRx_Intel,BairRx_LPR,BairRx_Offender,BairRx_Spotter;

EXPORT GetIDs(BairRx_Common.IParam.SearchParam inMod, boolean is_raids, boolean eid_download, boolean skipOffenderDates = true) := FUNCTION
	
	voidIDs := DATASET([], BairRx_Common.Layouts.SearchRec);	
	m_active := inMod.Active[1];	
	dIDsEVE := IF(m_active.EVE, BairRx_Event.GetIDs(inMod, eid_download, TRUE, is_raids), voidIDs);  
	dIDsCFS := IF(m_active.CFS, BairRx_CFS.GetIDs(inMod), voidIDs);
	dIDsCRA := IF(m_active.CRA, BairRx_Crash.GetIDs(inMod), voidIDs);  
	dIDsLPR := IF(m_active.LPR, BairRx_LPR.GetIDs(inMod), voidIDs);  
	dIDsOFF := IF(m_active.OFF, BairRx_Offender.GetIDs(inMod, is_raids, skipOffenderDates), voidIDs);  
	dIDsSPO := IF(m_active.SHO, BairRx_Spotter.GetIDs(inMod), voidIDs);  
	dIDsINT := IF(m_active.INT, BairRx_Intel.GetIDs(inMod), voidIDs);  
	
	dIDs := IF(is_raids, dIDsEVE+dIDsOFF, dIDsEVE+dIDsCFS+dIDsCRA+dIDsLPR+dIDsOFF+dIDsSPO+dIDsINT);
	
	RETURN dIDs;
	
END;