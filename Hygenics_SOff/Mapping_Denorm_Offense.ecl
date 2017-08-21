DOffense       := DISTRIBUTE(hygenics_soff.file_in_so_offense,  HASH32(RecordID));
DSortedOffense := SORT(DOffense, RecordID, finalrulingdate, LOCAL);

IdTable        := table(DSortedOffense, Hygenics_SOff.Layout_Denorm_Offense, RecordID, LOCAL);
 
	Hygenics_SOff.Layout_Denorm_Offense DeNormOffense(Hygenics_SOff.Layout_Denorm_Offense L, Hygenics_soff.Layout_in_SO_offense R, INTEGER C) := TRANSFORM
				
			//CaseComments////////////////////////////////////////////////////////////
			
				arrest_dt			:= if(regexfind('ARREST DATE:', r.casecomments, 0)<>'',
											trim(r.casecomments[stringlib.stringfind(r.casecomments, 'ARREST DATE:', 1)+12..(stringlib.stringfind(r.casecomments, 'ARREST DATE:', 1) + stringlib.stringfind(r.casecomments[stringlib.stringfind(r.casecomments, 'ARREST DATE:', 1)..length(r.casecomments)], ']', 1)-2)], left, right),
											'');
				
				arrest_date			:= if(regexfind('-', arrest_dt, 0)<>'',
											StringLib.StringFilter(arrest_dt, '1234567890'),
											arrest_dt);
				
				arrest_warrant		:= '';
										
				conviction_location	:= if(trim(r.casecomments, left, right)[1..15]='CONVICTION LOC:' and stringlib.stringfind(r.casecomments, ';', 1)<>0,
											trim(r.casecomments[16..stringlib.stringfind(r.casecomments, ';', 1)-1], left, right),
										if(trim(r.casecomments, left, right)[1..15]='CONVICTION LOC:' and stringlib.stringfind(r.casecomments, ';', 1)=0,
											trim(r.casecomments[16..], left, right),
											''));
				
						computer_used	:= if(regexfind('COMPUTER USED:', r.casecomments, 0)<>'',
												trim(r.casecomments[stringlib.stringfind(r.casecomments, 'COMPUTER USED:', 1)..(stringlib.stringfind(r.casecomments, 'COMPUTER USED:', 1) + stringlib.stringfind(r.casecomments[stringlib.stringfind(r.casecomments, 'COMPUTER USED:', 1)..length(r.casecomments)], ']', 1)-2)], left, right)+';',
												'');
					
						force_used		:= if(regexfind('FORCE USED:', r.casecomments, 0)<>'',
												trim(r.casecomments[stringlib.stringfind(r.casecomments, 'FORCE USED:', 1)..(stringlib.stringfind(r.casecomments, 'FORCE USED:', 1) + stringlib.stringfind(r.casecomments[stringlib.stringfind(r.casecomments, 'FORCE USED:', 1)..length(r.casecomments)], ']', 1)-2)], left, right)+';',
												'');
												
						porn_used		:= if(regexfind('PORNOGRAPHY INVOLVED:', r.casecomments, 0)<>'',
												trim(r.casecomments[stringlib.stringfind(r.casecomments, 'PORNOGRAPHY INVOLVED:', 1)..(stringlib.stringfind(r.casecomments, 'PORNOGRAPHY INVOLVED:', 1) + stringlib.stringfind(r.casecomments[stringlib.stringfind(r.casecomments, 'PORNOGRAPHY INVOLVED:', 1)..length(r.casecomments)], ']', 1)-2)], left, right)+';',
												'');
									
						weapon_used		:= if(regexfind('WEAPON USED:', r.casecomments, 0)<>'',
												trim(r.casecomments[stringlib.stringfind(r.casecomments, 'WEAPON USED:', 1)..(stringlib.stringfind(r.casecomments, 'WEAPON USED:', 1) + stringlib.stringfind(r.casecomments[stringlib.stringfind(r.casecomments, 'WEAPON USED:', 1)..length(r.casecomments)], ']', 1)-2)], left, right)+';',
												'');
				
						d_computer_used := if(trim(computer_used, left, right)<> 'COMPUTER USED: ;;',
																	computer_used,
																	'');
																	
						d_force_used 		:= if(trim(force_used, left, right)<> 'FORCE USED: ;;',
																	force_used,
																	'');
																	
						d_porn_used 		:= if(trim(porn_used, left, right)<> 'PORNOGRAPHY INVOLVED: ;;',
																	porn_used,
																	'');
																	
						d_weapon_used 	:= if(trim(weapon_used, left, right)<> 'WEAPON USED: ;;',
																	weapon_used,
																	'');
				
				offense_desc_2		:= trim(trim(trim(d_computer_used +' '+d_force_used, left, right)+' '+d_porn_used, left, right)+' '+d_weapon_used, left, right);
				
				offense_level		:= '';
				
				victim_relation		:= if(regexfind('VICTIM RELATION:', r.casecomments, 0)<>'',
											trim(r.casecomments[stringlib.stringfind(r.casecomments, 'VICTIM RELATION:', 1)+16..(stringlib.stringfind(r.casecomments, 'VICTIM RELATION:', 1) + stringlib.stringfind(r.casecomments[stringlib.stringfind(r.casecomments, 'VICTIM RELATION:', 1)..length(r.casecomments)], ']', 1)-2)], left, right),
										if(trim(r.casecomments[stringlib.stringfind(r.casecomments, 'WAS VICTIM A STRANGER:', 1)+22..(stringlib.stringfind(r.casecomments, 'WAS VICTIM A STRANGER:', 1) + stringlib.stringfind(r.casecomments[stringlib.stringfind(r.casecomments, 'WAS VICTIM A STRANGER:', 1)..length(r.casecomments)], ']', 1)-2)], left, right) = 'YES',
											'STRANGER',
										if(trim(r.casecomments[stringlib.stringfind(r.casecomments, 'WAS VICTIM A STRANGER:', 1)+22..(stringlib.stringfind(r.casecomments, 'WAS VICTIM A STRANGER:', 1) + stringlib.stringfind(r.casecomments[stringlib.stringfind(r.casecomments, 'WAS VICTIM A STRANGER:', 1)..length(r.casecomments)], ']', 1)-2)], left, right) = 'NO',	
											'NON-STRANGER',
										if(regexfind('RELATIONSHIP TO VICTIM:', r.casecomments, 0)<>'',
											trim(r.casecomments[stringlib.stringfind(r.casecomments, 'RELATIONSHIP TO VICTIM:', 1)+23..(stringlib.stringfind(r.casecomments, 'RELATIONSHIP TO VICTIM:', 1) + stringlib.stringfind(r.casecomments[stringlib.stringfind(r.casecomments, 'RELATIONSHIP TO VICTIM:', 1)..length(r.casecomments)], ']', 1)-2)], left, right),
											''))));
			
				d_victim_relation := if(trim(victim_relation, left, right)<>';',
															victim_relation, 
															'');
							
							
			//CaseInfo////////////////////////////////////////////////////////////
			
				vict_age			:= if(trim(r.caseinfo, left, right)[1..11]='VICTIM AGE:' and stringlib.stringfind(r.caseinfo, ',', 1)=0 and regexfind('[A-Z]+', trim(r.caseinfo[12..], left, right), 0)='',
											trim(r.caseinfo[12..], left, right),
										if(trim(r.caseinfo, left, right)[1..11]='VICTIM AGE:' and stringlib.stringfind(r.caseinfo, ',', 1)<>0 and regexfind('[A-Z]+', trim(r.caseinfo[12..stringlib.stringfind(r.caseinfo, ',', 1)-1], left, right), 0)='',	
											trim(r.caseinfo[12..stringlib.stringfind(r.caseinfo, ',', 1)-1], left, right),
											''));
											
				victim_age			:= if(regexfind('-', vict_age, 0)<>'',
											'',
										if(stringlib.stringfind(vict_age, ';', 1)=2 and stringlib.stringfind(vict_age, ':', 1)=0,
											vict_age[1],
										if(stringlib.stringfind(vict_age, ';', 1)=3 and stringlib.stringfind(vict_age, ':', 1)=0,
											vict_age[1..2],
										if(stringlib.stringfind(vict_age, ';', 1)=3 and stringlib.stringfind(vict_age, ':', 1)=1,
											vict_age[2],
										if(stringlib.stringfind(vict_age, ';', 1)=4 and stringlib.stringfind(vict_age, ':', 1)=1,
											vict_age[2..3],
											vict_age)))));
												
				victim_gender		:= if(regexfind('VICTIM GENDER:', r.caseinfo, 0)<>'' and regexfind(',', r.caseinfo, 0)='',
											trim(r.caseinfo[stringlib.stringfind(r.caseinfo, 'VICTIM GENDER:', 1)+14..], left, right),
										if(regexfind(', VICTIM GENDER:', r.caseinfo, 0)<>'',	
											trim(r.caseinfo[stringlib.stringfind(r.caseinfo, ', VICTIM GENDER:', 1)+16..], left, right),
											''));
				
				victim_minor		:= if(trim(r.caseinfo, left, right)[1..11]='VICTIM AGE:' and stringlib.stringfind(r.caseinfo, ',', 1)=0 and regexfind('[A-Z]+', trim(r.caseinfo[12..], left, right), 0)<>'',
											trim(r.caseinfo[12..], left, right),
										if(trim(r.caseinfo, left, right)[1..11]='VICTIM AGE:' and stringlib.stringfind(r.caseinfo, ',', 1)<>0 and regexfind('[A-Z]+', trim(r.caseinfo[12..stringlib.stringfind(r.caseinfo, ',', 1)-1], left, right), 0)<>'',	
											trim(r.caseinfo[12..stringlib.stringfind(r.caseinfo, ',', 1)-1], left, right),
											''));
			
			//Map Offenses////////////////////////////////////////
			
				SELF.arrest_date_1             	:=  IF(C=1, 
															arrest_date, 
															L.arrest_date_1);
				SELF.arrest_warrant_1          	:=  IF(C=1, 
															arrest_warrant, 
															L.arrest_warrant_1);
				SELF.conviction_jurisdiction_1 	:=  IF(C=1, 
															conviction_location, 
															L.conviction_jurisdiction_1);
				SELF.conviction_date_1         	:=  IF(C=1, 
															trim(r.finalrulingdate,left,right), 
															L.conviction_date_1);
				SELF.court_1 					:=  IF(C=1, 
															trim(r.courtname,left,right), 
															L.court_1);
				SELF.court_case_number_1		:=  IF(C=1, 
															trim(r.casenumber,left,right), 
															L.court_case_number_1);
				SELF.offense_date_1				:=  IF(C=1, 
															trim(r.offensedate,left,right), 
															L.offense_date_1);
				SELF.offense_code_or_statute_1 	:=  IF(C=1, 
															trim(r.offensecode,left,right), 
															L.offense_code_or_statute_1);			
				SELF.offense_description_1     	:=  IF(C=1, 
															trim(r.offensedesc,left,right),
															L.offense_description_1);
				SELF.offense_description_1_2   	:=  IF(C=1, 
																								offense_desc_2, 
																								L.offense_description_1_2);
				SELF.offense_level_1			:=  IF(C=1, 
															offense_level, 
															L.offense_level_1);
				SELF.victim_minor_1      		:=  IF(C=1, 
														MAP(r.victimunder18 <> '' => trim(r.victimunder18,left,right),
															REGEXFIND('MINOR', victim_minor) => 'Y',
															REGEXFIND('ADOLESCENT|PRE[-]*PUBESCENT|PRE[-]*TEEN|(AGE|VICTIM)*.*(WAS|A|AN|TO)[ ](ONE|TWO|THREE|FOUR|FIVE|SIX|SEVEN|EIGHT|NINE|TEN|ELEVEN|TWELVE|THIRTEEN|FOURTEEN|FIFTEEN|SIXTEEN|SEVENTEEN|EIGHTEEN)[ -](YEAR[S]*[- ]*O[L]*D)|([1][01234567]|[ ][0123456789])[- ](YEAR[S]*|YR[S.]*)[- ]OLD|AGE.*[01][01234567]|AGE.*[ ][123456789][). ]|(VICTIM|FEMALE|MALE).*[ ][0123456789][) ]|STAT[. ](RAPE|SODOMY)|STATUTORY|CUSTODIAL|GUARDIAN|SUPERVISORY|UNDERAGE|W/MNR|W/MINR|MINOR|W/JUV|[( ]JUV[). ]|JUVENILE|PUPIL|CHI[LDS][LDS]+|CH[ILD][ILD]+|CHLID|CGILD|CH[U]*LD|(FEMALE|MALE|V[ICTIMS]+[ ].*|VCTM[ ].*|PERSON[ ].*|V[ICTIM]*)1[01234567]([ -]1[01234567])*(YEARS OF AGE)*|(W/|U[/]*|UND[ER]*(AGE OF)*|LESS THAN|<)[ _]*1[012345678]|(W/|U[/]*|UND[ER]*(AGE OF)*|LESS THAN|<)[ _]*[123456789][ ]',stringlib.stringtouppercase(r.offensedesc)) and 
															REGEXFIND('OVER 18|JUVENILE PROBATION',stringlib.stringtouppercase(r.offensedesc))=false => 'Y',
															regexfind('MINOR|<18|UNDER 18|^[0]*[0123456789]([,; ]|$)|[10][01234567]([,; ]|$)|([10][01234567]|[0123456789])[ ]*-[ ]*([0123456789]([ ]|$)|[01][01234567])',stringlib.stringtouppercase(victim_minor)) => 'Y',
															''), 
														L.victim_minor_1);
				SELF.victim_age_1				:=  IF(C=1, 
															victim_age, 
															L.victim_age_1);
				SELF.victim_gender_1			:=  IF(C=1, 
															victim_gender, 
															L.victim_gender_1);	
				SELF.victim_relationship_1		:=  IF(C=1, 
															d_victim_relation, 
															L.victim_relationship_1);
				SELF.offense_location_1			:=  IF(C=1, 
															r.offenselocation, 
															L.offense_location_1);
				SELF.disposition_dt_1			:=  IF(C=1, 
															r.dispositiondate, 
															L.disposition_dt_1);
				SELF.arrest_date_2				:=	IF(C=2, 
															arrest_date, 
															L.arrest_date_2);
				SELF.arrest_warrant_2			:=  IF(C=2, 
															arrest_warrant, 
															L.arrest_warrant_2);
				SELF.conviction_jurisdiction_2  :=  IF(C=2, 
															conviction_location, 
															L.conviction_jurisdiction_2);
				SELF.conviction_date_2          :=  IF(C=2, 
															trim(r.finalrulingdate,left,right), 
															L.conviction_date_2);
				SELF.court_2 					:=  IF(C=2, 
															trim(r.courtname,left,right), 
															L.court_2);
				SELF.court_case_number_2		:=  IF(C=2, 
															trim(r.casenumber,left,right), 
															L.court_case_number_2);
				SELF.offense_date_2				:=  IF(C=2, 
															trim(r.offensedate,left,right), 
															L.offense_date_2);
				SELF.offense_code_or_statute_2  :=  IF(C=2, 
															trim(r.offensecode,left,right), 
															L.offense_code_or_statute_2);			
				SELF.offense_description_2      :=  IF(C=2, 
															trim(r.offensedesc,left,right),
															L.offense_description_2);
				SELF.offense_description_2_2    :=  IF(C=2, 
															offense_desc_2, 
															L.offense_description_2_2);
				SELF.offense_level_2			:=  IF(C=2, 
															offense_level, 
															L.offense_level_2);
				SELF.victim_minor_2      		:=  IF(C=2, 
														MAP(r.victimunder18 <> '' => trim(r.victimunder18,left,right),
															REGEXFIND('MINOR', victim_minor) => 'Y',
															REGEXFIND('ADOLESCENT|PRE[-]*PUBESCENT|PRE[-]*TEEN|(AGE|VICTIM)*.*(WAS|A|AN|TO)[ ](ONE|TWO|THREE|FOUR|FIVE|SIX|SEVEN|EIGHT|NINE|TEN|ELEVEN|TWELVE|THIRTEEN|FOURTEEN|FIFTEEN|SIXTEEN|SEVENTEEN|EIGHTEEN)[ -](YEAR[S]*[- ]*O[L]*D)|([1][01234567]|[ ][0123456789])[- ](YEAR[S]*|YR[S.]*)[- ]OLD|AGE.*[01][01234567]|AGE.*[ ][123456789][). ]|(VICTIM|FEMALE|MALE).*[ ][0123456789][) ]|STAT[. ](RAPE|SODOMY)|STATUTORY|CUSTODIAL|GUARDIAN|SUPERVISORY|UNDERAGE|W/MNR|W/MINR|MINOR|W/JUV|[( ]JUV[). ]|JUVENILE|PUPIL|CHI[LDS][LDS]+|CH[ILD][ILD]+|CHLID|CGILD|CH[U]*LD|(FEMALE|MALE|V[ICTIMS]+[ ].*|VCTM[ ].*|PERSON[ ].*|V[ICTIM]*)1[01234567]([ -]1[01234567])*(YEARS OF AGE)*|(W/|U[/]*|UND[ER]*(AGE OF)*|LESS THAN|<)[ _]*1[012345678]|(W/|U[/]*|UND[ER]*(AGE OF)*|LESS THAN|<)[ _]*[123456789][ ]',stringlib.stringtouppercase(r.offensedesc)) and 
															REGEXFIND ('OVER 18|JUVENILE PROBATION' ,stringlib.stringtouppercase(r.offensedesc))=false => 'Y',
															regexfind('MINOR|<18|UNDER 18|^[0]*[0123456789]([,; ]|$)|[10][01234567]([,; ]|$)|([10][01234567]|[0123456789])[ ]*-[ ]*([0123456789]([ ]|$)|[01][01234567])',stringlib.stringtouppercase(victim_minor)) => 'Y',
															''), 
														L.victim_minor_2);
				SELF.victim_age_2				:=  IF(C=2, 
															victim_age, 
															L.victim_age_2);
				SELF.victim_gender_2			:=  IF(C=2, 
															victim_gender, 
															L.victim_gender_2);
				SELF.victim_relationship_2		:=  IF(C=2, 
															d_victim_relation, 
															L.victim_relationship_2);
				SELF.offense_location_2			:=  IF(C=2, 
															r.offenselocation, 
															L.offense_location_2);
				SELF.disposition_dt_2			:=  IF(C=2, 
															r.dispositiondate, 
															L.disposition_dt_2);
				SELF.arrest_date_3				:=	IF(C=3, 
															arrest_date, 
															L.arrest_date_3);
				SELF.arrest_warrant_3			:=  IF(C=3, 
															arrest_warrant, 
															L.arrest_warrant_3);
				SELF.conviction_jurisdiction_3  :=  IF(C=3, 
															conviction_location, 
															L.conviction_jurisdiction_3);
				SELF.conviction_date_3          :=  IF(C=3, 
															trim(r.finalrulingdate,left,right), 
															L.conviction_date_3);
				SELF.court_3 					:=  IF(C=3, 
															trim(r.courtname,left,right), 
															L.court_3);
				SELF.court_case_number_3		:=  IF(C=3, 
															trim(r.casenumber,left,right), 
															L.court_case_number_3);
				SELF.offense_date_3				:=  IF(C=3, 
															trim(r.offensedate,left,right), 
															L.offense_date_3);
				SELF.offense_code_or_statute_3  :=  IF(C=3, 
															trim(r.offensecode,left,right), 
															L.offense_code_or_statute_3);			
				SELF.offense_description_3      :=  IF(C=3, 
															trim(r.offensedesc,left,right),
															L.offense_description_3);
				SELF.offense_description_3_2    :=  IF(C=3, 
															offense_desc_2, 
															L.offense_description_3_2);
				SELF.offense_level_3			:=  IF(C=3, 
															offense_level, 
															L.offense_level_3);
				SELF.victim_minor_3      		:=  IF(C=3, 
														MAP(r.victimunder18 <> '' => trim(r.victimunder18,left,right),
															REGEXFIND('MINOR', victim_minor) => 'Y',
															REGEXFIND('ADOLESCENT|PRE[-]*PUBESCENT|PRE[-]*TEEN|(AGE|VICTIM)*.*(WAS|A|AN|TO)[ ](ONE|TWO|THREE|FOUR|FIVE|SIX|SEVEN|EIGHT|NINE|TEN|ELEVEN|TWELVE|THIRTEEN|FOURTEEN|FIFTEEN|SIXTEEN|SEVENTEEN|EIGHTEEN)[ -](YEAR[S]*[- ]*O[L]*D)|([1][01234567]|[ ][0123456789])[- ](YEAR[S]*|YR[S.]*)[- ]OLD|AGE.*[01][01234567]|AGE.*[ ][123456789][). ]|(VICTIM|FEMALE|MALE).*[ ][0123456789][) ]|STAT[. ](RAPE|SODOMY)|STATUTORY|CUSTODIAL|GUARDIAN|SUPERVISORY|UNDERAGE|W/MNR|W/MINR|MINOR|W/JUV|[( ]JUV[). ]|JUVENILE|PUPIL|CHI[LDS][LDS]+|CH[ILD][ILD]+|CHLID|CGILD|CH[U]*LD|(FEMALE|MALE|V[ICTIMS]+[ ].*|VCTM[ ].*|PERSON[ ].*|V[ICTIM]*)1[01234567]([ -]1[01234567])*(YEARS OF AGE)*|(W/|U[/]*|UND[ER]*(AGE OF)*|LESS THAN|<)[ _]*1[012345678]|(W/|U[/]*|UND[ER]*(AGE OF)*|LESS THAN|<)[ _]*[123456789][ ]',stringlib.stringtouppercase(r.offensedesc)) and 
															REGEXFIND ('OVER 18|JUVENILE PROBATION' ,stringlib.stringtouppercase(r.offensedesc))= false => 'Y',
															regexfind('MINOR|<18|UNDER 18|^[0]*[0123456789]([,; ]|$)|[10][01234567]([,; ]|$)|([10][01234567]|[0123456789])[ ]*-[ ]*([0123456789]([ ]|$)|[01][01234567])',stringlib.stringtouppercase(victim_minor)) => 'Y',
															''), 
														L.victim_minor_3);
				SELF.victim_age_3				:=  IF(C=3, 
															victim_age, 
															L.victim_age_3);
				SELF.victim_gender_3  			:=  IF(C=3, 
															victim_gender, 
															L.victim_gender_3);	
				SELF.victim_relationship_3		:=  IF(C=3, 
															d_victim_relation, 
															L.victim_relationship_3);
				SELF.offense_location_3			:=  IF(C=3, 
															r.offenselocation, 
															L.offense_location_3);
				SELF.disposition_dt_3			:=  IF(C=3, 
															r.dispositiondate, 
															L.disposition_dt_3);
				SELF.arrest_date_4				:=	IF(C=4, 
															arrest_date, 
															L.arrest_date_4);
				SELF.arrest_warrant_4			:=  IF(C=4, 
															arrest_warrant, 
															L.arrest_warrant_4);
				SELF.conviction_jurisdiction_4  :=  IF(C=4, 
															conviction_location, 
															L.conviction_jurisdiction_4);
				SELF.conviction_date_4          :=  IF(C=4, 
															trim(r.finalrulingdate,left,right), 
															L.conviction_date_4);
				SELF.court_4 					:=  IF(C=4, 
															trim(r.courtname,left,right), 
															L.court_4);
				SELF.court_case_number_4		:=  IF(C=4, 
															trim(r.casenumber,left,right), 
															L.court_case_number_4);
				SELF.offense_date_4				:=  IF(C=4, 
															trim(r.offensedate,left,right), 
															L.offense_date_4);
				SELF.offense_code_or_statute_4  :=  IF(C=4, 
															trim(r.offensecode,left,right), 
															L.offense_code_or_statute_4);			
				SELF.offense_description_4      :=  IF(C=4, 
															trim(r.offensedesc,left,right),
															L.offense_description_4);
				SELF.offense_description_4_2    :=  IF(C=4, 
															offense_desc_2, 
															L.offense_description_4_2);
				SELF.offense_level_4			:=  IF(C=4, 
															offense_level, 
															L.offense_level_4);
				SELF.victim_minor_4      		:=  IF(C=4, 
														MAP(r.victimunder18 <> '' => trim(r.victimunder18,left,right),
															REGEXFIND('MINOR', victim_minor) => 'Y',
															REGEXFIND('ADOLESCENT|PRE[-]*PUBESCENT|PRE[-]*TEEN|(AGE|VICTIM)*.*(WAS|A|AN|TO)[ ](ONE|TWO|THREE|FOUR|FIVE|SIX|SEVEN|EIGHT|NINE|TEN|ELEVEN|TWELVE|THIRTEEN|FOURTEEN|FIFTEEN|SIXTEEN|SEVENTEEN|EIGHTEEN)[ -](YEAR[S]*[- ]*O[L]*D)|([1][01234567]|[ ][0123456789])[- ](YEAR[S]*|YR[S.]*)[- ]OLD|AGE.*[01][01234567]|AGE.*[ ][123456789][). ]|(VICTIM|FEMALE|MALE).*[ ][0123456789][) ]|STAT[. ](RAPE|SODOMY)|STATUTORY|CUSTODIAL|GUARDIAN|SUPERVISORY|UNDERAGE|W/MNR|W/MINR|MINOR|W/JUV|[( ]JUV[). ]|JUVENILE|PUPIL|CHI[LDS][LDS]+|CH[ILD][ILD]+|CHLID|CGILD|CH[U]*LD|(FEMALE|MALE|V[ICTIMS]+[ ].*|VCTM[ ].*|PERSON[ ].*|V[ICTIM]*)1[01234567]([ -]1[01234567])*(YEARS OF AGE)*|(W/|U[/]*|UND[ER]*(AGE OF)*|LESS THAN|<)[ _]*1[012345678]|(W/|U[/]*|UND[ER]*(AGE OF)*|LESS THAN|<)[ _]*[123456789][ ]',stringlib.stringtouppercase(r.offensedesc)) and 
															REGEXFIND('OVER 18|JUVENILE PROBATION' ,stringlib.stringtouppercase(r.offensedesc))= false => 'Y',
															regexfind('MINOR|<18|UNDER 18|^[0]*[0123456789]([,; ]|$)|[10][01234567]([,; ]|$)|([10][01234567]|[0123456789])[ ]*-[ ]*([0123456789]([ ]|$)|[01][01234567])',stringlib.stringtouppercase(victim_minor)) => 'Y',
															''), 
														L.victim_minor_4);
				SELF.victim_age_4				:=  IF(C=4, 
															victim_age, 
															L.victim_age_4);
				SELF.victim_gender_4  			:=  IF(C=4, 
															victim_gender, 
															L.victim_gender_4);	
				SELF.victim_relationship_4		:=  IF(C=4, 
															victim_relation, 
															L.victim_relationship_4);	
				SELF.offense_location_4			:=  IF(C=4, 
															r.offenselocation, 
															L.offense_location_4);
				SELF.disposition_dt_4			:=  IF(C=4, 
															r.dispositiondate, 
															L.disposition_dt_4);
				SELF.arrest_date_5				:=	IF(C=5, 
															arrest_date, 
															L.arrest_date_5);
				SELF.arrest_warrant_5			:=  IF(C=5, 
															arrest_warrant, 
															L.arrest_warrant_5);
				SELF.conviction_jurisdiction_5  :=  IF(C=5, 
															conviction_location, 
															L.conviction_jurisdiction_5);
				SELF.conviction_date_5          :=  IF(C=5, 
															trim(r.finalrulingdate,left,right), 
															L.conviction_date_5);
				SELF.court_5 					:=  IF(C=5, 
															trim(r.courtname,left,right), 
															L.court_5);
				SELF.court_case_number_5		:=  IF(C=5, 
															trim(r.casenumber,left,right), 
															L.court_case_number_5);
				SELF.offense_date_5				:=  IF(C=5, 
															trim(r.offensedate,left,right), 
															L.offense_date_5);
				SELF.offense_code_or_statute_5  :=  IF(C=5, 
															trim(r.offensecode,left,right), 
															L.offense_code_or_statute_5);			
				SELF.offense_description_5      :=  IF(C=5, 
															trim(r.offensedesc,left,right),
															L.offense_description_5);
				SELF.offense_description_5_2    :=  IF(C=5, 
															offense_desc_2, 
															L.offense_description_5_2);
				SELF.offense_level_5			:=  IF(C=5, 
															offense_level, 
															L.offense_level_5);
				SELF.victim_minor_5      		:=  IF(C=5, 
															MAP(r.victimunder18 <> '' => trim(r.victimunder18,left,right),
																REGEXFIND('MINOR', victim_minor) => 'Y',
																REGEXFIND('ADOLESCENT|PRE[-]*PUBESCENT|PRE[-]*TEEN|(AGE|VICTIM)*.*(WAS|A|AN|TO)[ ](ONE|TWO|THREE|FOUR|FIVE|SIX|SEVEN|EIGHT|NINE|TEN|ELEVEN|TWELVE|THIRTEEN|FOURTEEN|FIFTEEN|SIXTEEN|SEVENTEEN|EIGHTEEN)[ -](YEAR[S]*[- ]*O[L]*D)|([1][01234567]|[ ][0123456789])[- ](YEAR[S]*|YR[S.]*)[- ]OLD|AGE.*[01][01234567]|AGE.*[ ][123456789][). ]|(VICTIM|FEMALE|MALE).*[ ][0123456789][) ]|STAT[. ](RAPE|SODOMY)|STATUTORY|CUSTODIAL|GUARDIAN|SUPERVISORY|UNDERAGE|W/MNR|W/MINR|MINOR|W/JUV|[( ]JUV[). ]|JUVENILE|PUPIL|CHI[LDS][LDS]+|CH[ILD][ILD]+|CHLID|CGILD|CH[U]*LD|(FEMALE|MALE|V[ICTIMS]+[ ].*|VCTM[ ].*|PERSON[ ].*|V[ICTIM]*)1[01234567]([ -]1[01234567])*(YEARS OF AGE)*|(W/|U[/]*|UND[ER]*(AGE OF)*|LESS THAN|<)[ _]*1[012345678]|(W/|U[/]*|UND[ER]*(AGE OF)*|LESS THAN|<)[ _]*[123456789][ ]',stringlib.stringtouppercase(r.offensedesc)) and 
																REGEXFIND('OVER 18|JUVENILE PROBATION',stringlib.stringtouppercase(r.offensedesc))= false => 'Y',
																regexfind('MINOR|<18|UNDER 18|^[0]*[0123456789]([,; ]|$)|[10][01234567]([,; ]|$)|([10][01234567]|[0123456789])[ ]*-[ ]*([0123456789]([ ]|$)|[01][01234567])',stringlib.stringtouppercase(victim_minor)) => 'Y',
																''), 
															L.victim_minor_5);
				SELF.victim_age_5				:=  IF(C=5, 
															victim_age, 
															L.victim_age_5);
				SELF.victim_gender_5			:=  IF(C=5, 
															victim_gender, 
															L.victim_gender_5);	
				SELF.victim_relationship_5		:=  IF(C=5, 
															d_victim_relation, 
															L.victim_relationship_5);
				SELF.offense_location_5			:=  IF(C=5, 
															r.offenselocation, 
															L.offense_location_5);
				SELF.disposition_dt_5			:=  IF(C=5, 
															r.dispositiondate, 
															L.disposition_dt_5);
				SELF := L;
		end;
	 
		d_offense 		:= DENORMALIZE(IdTable, DSortedOffense,
									LEFT.recordid = RIGHT.recordid,
									DeNormOffense(LEFT,RIGHT,COUNTER),LOCAL);
	
		d_offense 	offenseFix(d_offense l):= transform
				self.conviction_jurisdiction_1 	:= if(regexfind('0 -', l.conviction_jurisdiction_1, 0)<>'',
													'',
													l.conviction_jurisdiction_1);		
				self.victim_age_1 				:= if(regexfind('0 -', l.victim_age_1, 0)<>'',
													'',
													l.victim_age_1);
				self.victim_age_2 				:= if(regexfind('0 -', l.victim_age_2, 0)<>'',
													'',
													l.victim_age_2);
				self.victim_age_3 				:= if(regexfind('0 -', l.victim_age_3, 0)<>'',
													'',
													l.victim_age_3);
				self.victim_age_4 				:= if(regexfind('0 -', l.victim_age_4, 0)<>'',
													'',
													l.victim_age_4);
				self.victim_age_5 				:= if(regexfind('0 -', l.victim_age_5, 0)<>'',
													'',
													l.victim_age_5);
				self := l;
		end;
			
		denorm_offense 	:= project(d_offense, offenseFix(left));

		denorm_offense removeSemi(denorm_offense l):= transform
			self.offense_description_1_2 := if(l.offense_description_1_2=';',
																					'',
																					l.offense_description_1_2);
			self.offense_description_2_2 := if(l.offense_description_2_2=';',
																					'',
																					l.offense_description_2_2);
			self := l;
		end;
		
		fixRecords := project(denorm_offense, removeSemi(left)):persist('~thor_200::persist::soff_offense');
		
export Mapping_Denorm_Offense := fixRecords;
														
