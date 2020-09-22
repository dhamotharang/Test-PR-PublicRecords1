EXPORT fn_eCrash_RemoveRawDupes() := FUNCTION

 eCrash_RemoveDupes := Sequential(
																	eCrash_Maintenance.fn_Citation_RemoveRawDupes(),
																	eCrash_Maintenance.fn_Commercial_RemoveRawDupes(),
																	eCrash_Maintenance.fn_Document_RemoveRawDupes(),
																	eCrash_Maintenance.fn_Incident_RemoveRawDupes(),
																	eCrash_Maintenance.fn_Person_RemoveRawDupes(),
																	eCrash_Maintenance.fn_PropertyDamage_RemoveRawDupes(),
																	eCrash_Maintenance.fn_Vehicle_RemoveRawDupes()
                                 );
RETURN eCrash_RemoveDupes;

END;