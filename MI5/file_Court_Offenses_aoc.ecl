
import crim_common, ut;

export file_Court_Offenses_aoc := DATASET('~thor_data400::base::court_offenses_'+ crim_common.version_development,Crim_Common.Layout_Moxie_Court_Offenses ,FLAT);

//export file_Court_Offenses_aoc := DATASET('~thor_data400::texas_cross_court_offenses_20101126',Crim_Common.Layout_Moxie_Court_Offenses ,FLAT);


/////export file_Court_Offenses_aoc := DATASET(ut.foreign_dataland+'~thor200_144::persist::hygenics::crim::az_aoc_offense',Crim_Common.Layout_Moxie_Court_Offenses ,FLAT)
                                   /////// // (court_desc = 'APACHE JUNCTION MUNICIPAL');
																		  // (court_desc in [ 
																					 // 'CASA GRANDE JUSTICE',
																					 // 'CASA GRANDE MUNICIPAL',
																					 // 'APACHE JUNCTION JUSTICE',
																					 // 'APACHE JUNCTION MUNICIPAL',
																					 // 'QUARTZSITE MUNICIPAL',
																					 // 'QUARTZSITE JUSTICE',
																					 // 'BULLHEAD CITY JUSTICE',
																					 // 'BULLHEAD CITY MUNI',
																					 // 'PINETOP-LAKESIDE JUSTICE',
																					 // 'PINETOP-LAKESIDE MUNICIPAL',
																					 // 'FLAGSTAFF JUSTICE',
																					 // 'FLAGSTAFF MUNICIPAL',
																					 // 'LAKE HAVASU CITY JUSTICE',
																					 // 'LAKE HAVASU MUNI',
																					 // 'SIERRA VISTA JUSTICE',
																					 // 'SIERRA VISTA MUNICIPAL']);

