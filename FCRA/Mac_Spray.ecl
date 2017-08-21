import FCRA,_control;

export Mac_Spray(string filedate) := function

FCRA.Mac_Override_Spray_SFMove(_control.IPAddress.edata12,
								'/thor_back5/riskwise/daily_files/bk/build/bk_filing.d00',
								1553,
								'bankrupt_main',
								filedate,
								bkm
								);
FCRA.Mac_Override_Spray_SFMove(_control.IPAddress.edata12,
								'/thor_back5/riskwise/daily_files/bk/build/bk_search.d00',
								498,
								'bankrupt_search',
								filedate,
								bks);
								
FCRA.Mac_Override_Spray_SFMove(_control.IPAddress.edata12,
								'/thor_back5/riskwise/daily_files/property/build/property_assessment_v2.d00',
								1208,
								'property_assessment_v2',
								filedate,
								pa);
FCRA.Mac_Override_Spray_SFMove(_control.IPAddress.edata12,
								'/thor_back5/riskwise/daily_files/property/build/property_deeds_v2.d00',
								1041,
								'property_deeds_v2',
								filedate,
								pd);
FCRA.Mac_Override_Spray_SFMove(_control.IPAddress.edata12,
								'/thor_back5/riskwise/daily_files/property/build/property_search_v2.d00',
								544,
								'property_search_v2',
								filedate,
								ps);
FCRA.Mac_Override_Spray_SFMove(_control.IPAddress.edata12,
								'/thor_back5/riskwise/daily_files/flag/build/flag.d00',
								273,
								'flag',
								filedate,
								fl);
FCRA.Mac_Override_Spray_SFMove(_control.IPAddress.edata12,
								'/thor_back5/riskwise/daily_files/pcr/build/pcr.d00',
								348,
								'pcr',
								filedate,
								pcr);
FCRA.Mac_Override_Spray_SFMove(_control.IPAddress.edata12,
								'/thor_back5/riskwise/daily_files/liens/build/liens_party.d00',
								1452,
								'liensv2_party',
								filedate,
								lp);
FCRA.Mac_Override_Spray_SFMove(_control.IPAddress.edata12,
								'/thor_back5/riskwise/daily_files/liens/build/liens_main.d00',
								746,
								'liensv2_main',
								filedate,
								lm);
FCRA.Mac_Override_Spray_SFMove(_control.IPAddress.edata12,
								'/thor_back5/riskwise/daily_files/student/build/student.d00',
								735,
								'american_student',
								filedate,
								st);
FCRA.Mac_Override_Spray_SFMove(_control.IPAddress.edata12,
								'/thor_back5/riskwise/daily_files/proflic/build/proflic.d00',
								3533,
								'proflic',
								filedate,
								pl);
FCRA.Mac_Override_Spray_SFMove(_control.IPAddress.edata12,
								'/thor_back5/riskwise/daily_files/watercraft/build/watercraft.d00',
								964,
								'watercraft',
								filedate,
								wc);
FCRA.Mac_Override_Spray_SFMove(_control.IPAddress.edata12,
								'/thor_back5/riskwise/daily_files/crim/build/fcra_crim_offender.d00',
								1788,
								'crim_offender',
								filedate,
								co);

FCRA.Mac_Override_Spray_SFMove(_control.IPAddress.edata12,
								'/thor_back5/riskwise/daily_files/crim/build/fcra_crim_offenses.d00',
								2300,
								'crim_offenses',
								filedate,
								cof);

FCRA.Mac_Override_Spray_SFMove(_control.IPAddress.edata12,
								'/thor_back5/riskwise/daily_files/impulse/build/impulse.d00',
								800,
								'impulse',
								filedate,
								imp);

retval := sequential(bkm,bks,pa,pd,ps,fl,pcr
					,lp,lm,st,pl,wc,co,cof,imp);
return retval;
end;

							

								

