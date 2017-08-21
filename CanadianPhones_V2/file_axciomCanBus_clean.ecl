IMPORT CanadianPhones;

EXPORT file_axciomCanBus_clean := dataset(CanadianPhones.thor_cluster + 'in::axciombus_v2',
																					CanadianPhones_V2.layoutCanadianWhitepagesBase,
																					THOR);