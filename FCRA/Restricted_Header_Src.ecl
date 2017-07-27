import MDR;
export Restricted_Header_Src (string2 src, string1 vid='') := src not in mdr.sourceTools.set_scoring_FCRA;


// OLD CODE
/*src in [
	'FA','FP','FB','FR',    // FARES
	'TU', 'LT', 'TN',  			// TRANSUNION (credit header)
	'LI',       						// Liens V1
	'CY',										// Certegy
	'EN',										// Experian
	'NT',										// Foreclosures - notice of delinquency (FARES)
	'EL',										// Experian insource
	'WP',										// White Pages
	'Y '										// Yellow Pages
] or MDR.sourceTools.SourceIsDL(src) /* exclude DL sources * /
	or MDR.sourceTools.SourceIsVehicle(src) /* exclude vehicle sources * /
	or MDR.sourceTools.SourceIsUtility(src) //UTILS
	or (src in ['LP','LA'] and vid = 'F');  /* common property, fares recs */