IMPORT CanadianPhones, Data_Services;
EXPORT file_CanadianWhitePagesBase := dataset(CanadianPhones.thor_cluster + 'base::canadianwp_v2',
                                              CanadianPhones_V2.layoutCanadianWhitepagesBase,
																							THOR);
