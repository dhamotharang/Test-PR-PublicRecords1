IMPORT CanadianPhones;                
EXPORT file_axciomCanRes_clean := dataset(CanadianPhones.thor_cluster + 'in::axciomres_v2',
																					CanadianPhones_V2.layoutCanadianWhitepagesBase,
																					THOR);