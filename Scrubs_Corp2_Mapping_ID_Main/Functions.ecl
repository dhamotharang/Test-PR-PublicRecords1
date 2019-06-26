IMPORT corp2;
	
EXPORT Functions := MODULE

  // Update when we see new corp_ln_name_type_cd values in Raw updates
	EXPORT Name_Type_Codes :=[ '01','06','07','11','F' ];
	
	// Update when we see new corp_ln_name_type_desc values in Raw updates
	EXPORT Name_Type_Descs :=[ 'LEGAL','ASSUMED','RESERVED','FOREIGN REGISTERED NAME','FOREIGN NAME' ];
	
	// Update when we see new corp_status_desc values in Raw updates
	EXPORT status_Descs :=[ 'ACTIVE-CURRENT',
													'ACTIVE-EXISTING',
													'ACTIVE-GOOD STANDING',
													'INACTIVE-CANCELLED',
													'INACTIVE-CANCELLED (ADMINISTRATIVE)',
													'INACTIVE-CONSOLIDATED',
													'INACTIVE-CONVERTED OUT',
													'INACTIVE-DISSOLVED',
													'INACTIVE-DISSOLVED (ADMINISTRATIVE)',
													'INACTIVE-DISSOLVED (NO AGENT)',
													'INACTIVE-DOMESTICATED OUT',
													'INACTIVE-EXPIRED',
													'INACTIVE-FORFEITED',
													'INACTIVE-MERGED OUT',
													'INACTIVE-REVOKED (ADMINISTRATIVE)',
													'INACTIVE-REVOKED (NO AGENT)',
													'INACTIVE-TERMINATED',
													'INACTIVE-TERMINATED (ADMINISTRATIVE)',
													'INACTIVE-WITHDRAWN',
													''];
													 
END;