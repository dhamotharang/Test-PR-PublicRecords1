export program_lookup(string20 sanctions_program) := case(sanctions_program
                                                         ,'NS-PLC'   => 'Non-Specially Designated Terrorists- Palestinian Legislative Council'
														 ,'SDT'      => 'Specially Designated Terrorists'
														 ,'SDGT'     => 'Specially Designated Global Terrorists'
														 ,'SDNT'     => 'Specially Designated Narcotics Traffickers'
														 ,'SDNTK'    => 'Specially Designated Narcotic Trafficking Kingpins'
														 ,'FTO'      => 'Foreign Terrorists Organization'
														 ,'UNITA'    => 'Unita (Angola)'
														 ,'RYM'      => 'Federal Republic of Yugoslavia % Milosevic'
														 ,'FRYK'     => 'Federal Republic Of Yugoslavia % Kosovo'
														 ,'FRYS&M'   => 'Federal Republic of Yugoslavia % Serbia & Montenegro'
														 ,'SRBH'     => 'Bosnian Serb-Controlled Areas of the Republic of Bosnia and Herzegovina'
														 ,'TALIBAN'  => 'Taliban (Afghanistan)'
														 ,'NKOREA'   => 'North Korea'
														 ,'BALKANS'  => 'Balkans'
														 ,'CUBA'     => 'Cuba'
														 ,'IRAN'     => 'Iran'
														 ,'IRAQ'     => 'Iraq'
														 ,'LIBYA'    => 'Libya'
														 ,'SUDAN'    => 'Sudan'
														 ,'BELARUS'  => 'Belarus'
														 ,'BPI-PA'   => 'Blocked Pending Investigation: Patriot Act'
														 ,'BPI-SDNT' => 'Blocked Pending Investigation: Specially Designated Narcotics Traffickers'
														 ,'BPI-SDNTK'=> 'Blocked Pending Investigation: Significant Foreign Narcotics Traffickers under the Foreign Narcotics Kingpin Designation Act'
														 ,'BURMA'    => 'Burma'
														 ,'COTED'    => 'Cote d\'Ivoire (Ivory Coast)'
														 ,'IRAQ2'    => 'Iraq2'
														 ,'LIBERIA'  => 'Liberia'
														 ,'NPWMD'    => 'Non-Proliferation Sanctions - Weapons of Mass Destruction'
														 ,'SYRIA'    => 'Syria'
														 ,'ZIMB'     => 'Zimbabwe'
											             ,sanctions_program);
