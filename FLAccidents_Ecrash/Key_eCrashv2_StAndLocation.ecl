dseCrashSearch := File_KeybuildV2.eCrashSearchRecs(Accident_Location <> ''); 

InterimAccidentLocLayout := RECORD 
	dseCrashSearch;
	STRING100 Alocation1; 
	STRING99 Alocation2; 
	STRING98 Alocation3; 
	STRING97 Alocation4; 
	STRING96 Alocation5; 
	STRING95 Alocation6; 
	STRING94 Alocation7; 
	STRING93 Alocation8; 
	STRING92 Alocation9; 
	STRING90 Alocation10; 
	STRING89 Alocation11; 
	STRING88 Alocation12; 
	STRING87 Alocation13; 
	STRING86 Alocation14;
	STRING85 Alocation15;
	STRING84 Alocation16;
	STRING83 Alocation17;
	STRING82 Alocation18;
	STRING81 Alocation19;
	STRING80 Alocation20; 
	STRING79 Alocation21;
	STRING78 Alocation22;
	STRING77 Alocation23;
	STRING76 Alocation24;
	STRING75 Alocation25;
	STRING74 Alocation26;
	STRING73 Alocation27;
	STRING72 Alocation28;
	STRING71 Alocation29;
	STRING70 Alocation30;
	STRING69 Alocation31;
	STRING68 Alocation32;
	STRING67 Alocation33;
	STRING66 Alocation34;
	STRING65 Alocation35;
	STRING64 Alocation36;
	STRING63 Alocation37;
	STRING62 Alocation38;
	STRING61 Alocation39;
	STRING60 Alocation40;
	STRING59 Alocation41;
	STRING58 Alocation42;
	STRING57 Alocation43;
	STRING56 Alocation44;
	STRING55 Alocation45;
	STRING54 Alocation46;
	STRING53 Alocation47;
	STRING52 Alocation48;
	STRING51 Alocation49;
	STRING50 Alocation50;
	STRING49 Alocation51;
	STRING48 Alocation52;
	STRING47 Alocation53;
	STRING46 Alocation54;
	STRING45 Alocation55;
	STRING44 Alocation56;
	STRING43 Alocation57;
	STRING42 Alocation58;
	STRING41 Alocation59;
	STRING40 Alocation60;
	STRING39 Alocation61;
	STRING38 Alocation62;
	STRING37 Alocation63;
	STRING36 Alocation64;
	STRING35 Alocation65;
	STRING34 Alocation66;
	STRING33 Alocation67;
	STRING32 Alocation68;
	STRING31 Alocation69;
	STRING30 Alocation70;
	STRING29 Alocation71;
	STRING28 Alocation72;
	STRING27 Alocation73;
	STRING26 Alocation74;
	STRING25 Alocation75;
	STRING24 Alocation76;
	STRING23 Alocation77;
	STRING22 Alocation78;
	STRING21 Alocation79;
	STRING20 Alocation80;
	STRING19 Alocation81;
	STRING18 Alocation82;
	STRING17 Alocation83;
	STRING16 Alocation84;
	STRING15 Alocation85;
	STRING14 Alocation86;
	STRING13 Alocation87;
	STRING12 Alocation88;
	STRING11 Alocation89;
	STRING10 Alocation90;
	STRING9  Alocation91;
	STRING8  Alocation92;
	STRING7  Alocation93;
	STRING6  Alocation94;
	STRING5  Alocation95;
	STRING4  Alocation96;
	STRING3  Alocation97;
END;

InterimAccidentLocLayout tParseAccidentLocation(dseCrashSearch L) := TRANSFORM
  Part_AccidentLocation := IF(TRIM(L.Accident_Location, LEFT, RIGHT) = '', '', TRIM(L.Accident_Location, LEFT, RIGHT));
  AlMaxLength	:= 100;
  SELF.Alocation1 := Part_AccidentLocation[1..AlMaxLength];
  SELF.Alocation2 := IF(LENGTH(TRIM(Part_AccidentLocation[2..AlMaxLength], LEFT, RIGHT)) < 4 , '', TRIM(Part_AccidentLocation[2..AlMaxLength], LEFT, RIGHT));
  SELF.Alocation3 := IF(LENGTH(TRIM(Part_AccidentLocation[3..AlMaxLength], LEFT, RIGHT)) < 4 , '', TRIM(Part_AccidentLocation[3..AlMaxLength], LEFT, RIGHT));
  SELF.Alocation4 := IF(LENGTH(TRIM(Part_AccidentLocation[4..AlMaxLength], LEFT, RIGHT)) < 4 , '', TRIM(Part_AccidentLocation[4..AlMaxLength], LEFT, RIGHT));
  SELF.Alocation5 := IF(LENGTH(TRIM(Part_AccidentLocation[5..AlMaxLength], LEFT, RIGHT)) < 4 , '', TRIM(Part_AccidentLocation[5..AlMaxLength], LEFT, RIGHT));
  SELF.Alocation6 := IF(LENGTH(TRIM(Part_AccidentLocation[6..AlMaxLength], LEFT, RIGHT)) < 4 , '', TRIM(Part_AccidentLocation[6..AlMaxLength], LEFT, RIGHT));
  SELF.Alocation7 := IF(LENGTH(TRIM(Part_AccidentLocation[7..AlMaxLength], LEFT, RIGHT)) < 4 , '', TRIM(Part_AccidentLocation[7..AlMaxLength], LEFT, RIGHT));
  SELF.Alocation8 := IF(LENGTH(TRIM(Part_AccidentLocation[8..AlMaxLength], LEFT, RIGHT)) < 4 , '', TRIM(Part_AccidentLocation[8..AlMaxLength], LEFT, RIGHT));
  SELF.Alocation9 := IF(LENGTH(TRIM(Part_AccidentLocation[9..AlMaxLength], LEFT, RIGHT)) < 4 , '', TRIM(Part_AccidentLocation[9..AlMaxLength], LEFT, RIGHT)) ; 
  SELF.Alocation10 := IF(LENGTH(TRIM(Part_AccidentLocation[10..AlMaxLength], LEFT, RIGHT)) < 4 , '', TRIM(Part_AccidentLocation[10..AlMaxLength], LEFT, RIGHT)); 
  SELF.Alocation11 := IF(LENGTH(TRIM(Part_AccidentLocation[11..AlMaxLength], LEFT, RIGHT)) < 4 , '', TRIM(Part_AccidentLocation[11..AlMaxLength], LEFT, RIGHT));
  SELF.Alocation12 := IF(LENGTH(TRIM(Part_AccidentLocation[12..AlMaxLength], LEFT, RIGHT)) < 4 , '', TRIM(Part_AccidentLocation[12..AlMaxLength], LEFT, RIGHT));
  SELF.Alocation13 := IF(LENGTH(TRIM(Part_AccidentLocation[13..AlMaxLength], LEFT, RIGHT)) < 4 , '', TRIM(Part_AccidentLocation[13..AlMaxLength], LEFT, RIGHT));
  SELF.Alocation14 := IF(LENGTH(TRIM(Part_AccidentLocation[14..AlMaxLength], LEFT, RIGHT)) < 4 , '', TRIM(Part_AccidentLocation[14..AlMaxLength], LEFT, RIGHT));
  SELF.Alocation15 := IF(LENGTH(TRIM(Part_AccidentLocation[15..AlMaxLength], LEFT, RIGHT)) < 4 , '', TRIM(Part_AccidentLocation[15..AlMaxLength], LEFT, RIGHT));
  SELF.Alocation16 := IF(LENGTH(TRIM(Part_AccidentLocation[16..AlMaxLength], LEFT, RIGHT)) < 4 , '', TRIM(Part_AccidentLocation[16..AlMaxLength], LEFT, RIGHT));
  SELF.Alocation17 := IF(LENGTH(TRIM(Part_AccidentLocation[17..AlMaxLength], LEFT, RIGHT)) < 4 , '', TRIM(Part_AccidentLocation[17..AlMaxLength], LEFT, RIGHT));
	SELF.Alocation18 := IF(LENGTH(TRIM(Part_AccidentLocation[18..AlMaxLength], LEFT, RIGHT)) < 4 , '', TRIM(Part_AccidentLocation[18..AlMaxLength], LEFT, RIGHT));
  SELF.Alocation19 := IF(LENGTH(TRIM(Part_AccidentLocation[19..AlMaxLength], LEFT, RIGHT)) < 4 , '', TRIM(Part_AccidentLocation[19..AlMaxLength], LEFT, RIGHT));
  SELF.Alocation20 := IF(LENGTH(TRIM(Part_AccidentLocation[20..AlMaxLength], LEFT, RIGHT)) < 4 , '', TRIM(Part_AccidentLocation[20..AlMaxLength], LEFT, RIGHT));
  SELF.Alocation21 := IF(LENGTH(TRIM(Part_AccidentLocation[21..AlMaxLength], LEFT, RIGHT)) < 4 , '', TRIM(Part_AccidentLocation[21..AlMaxLength], LEFT, RIGHT));
  SELF.Alocation22 := IF(LENGTH(TRIM(Part_AccidentLocation[22..AlMaxLength], LEFT, RIGHT)) < 4 , '', TRIM(Part_AccidentLocation[22..AlMaxLength], LEFT, RIGHT));
  SELF.Alocation23 := IF(LENGTH(TRIM(Part_AccidentLocation[23..AlMaxLength], LEFT, RIGHT)) < 4 , '', TRIM(Part_AccidentLocation[23..AlMaxLength], LEFT, RIGHT));
	SELF.Alocation24 := IF(LENGTH(TRIM(Part_AccidentLocation[24..AlMaxLength], LEFT, RIGHT)) < 4 , '', TRIM(Part_AccidentLocation[24..AlMaxLength], LEFT, RIGHT));
  SELF.Alocation25 := IF(LENGTH(TRIM(Part_AccidentLocation[25..AlMaxLength], LEFT, RIGHT)) < 4 , '', TRIM(Part_AccidentLocation[25..AlMaxLength], LEFT, RIGHT));
	SELF.Alocation26 := IF(LENGTH(TRIM(Part_AccidentLocation[26..AlMaxLength], LEFT, RIGHT)) < 4 , '', TRIM(Part_AccidentLocation[26..AlMaxLength], LEFT, RIGHT));
  SELF.Alocation27 := IF(LENGTH(TRIM(Part_AccidentLocation[27..AlMaxLength], LEFT, RIGHT)) < 4 , '', TRIM(Part_AccidentLocation[27..AlMaxLength], LEFT, RIGHT));
  SELF.Alocation28 := IF(LENGTH(TRIM(Part_AccidentLocation[28..AlMaxLength], LEFT, RIGHT)) < 4 , '', TRIM(Part_AccidentLocation[28..AlMaxLength], LEFT, RIGHT));
  SELF.Alocation29 := IF(LENGTH(TRIM(Part_AccidentLocation[29..AlMaxLength], LEFT, RIGHT)) < 4 , '', TRIM(Part_AccidentLocation[29..AlMaxLength], LEFT, RIGHT));
  SELF.Alocation30 := IF(LENGTH(TRIM(Part_AccidentLocation[30..AlMaxLength], LEFT, RIGHT)) < 4 , '', TRIM(Part_AccidentLocation[30..AlMaxLength], LEFT, RIGHT));
  SELF.Alocation31 := IF(LENGTH(TRIM(Part_AccidentLocation[31..AlMaxLength], LEFT, RIGHT)) < 4 , '', TRIM(Part_AccidentLocation[31..AlMaxLength], LEFT, RIGHT));
  SELF.Alocation32 := IF(LENGTH(TRIM(Part_AccidentLocation[32..AlMaxLength], LEFT, RIGHT)) < 4 , '', TRIM(Part_AccidentLocation[32..AlMaxLength], LEFT, RIGHT));
  SELF.Alocation33 := IF(LENGTH(TRIM(Part_AccidentLocation[33..AlMaxLength], LEFT, RIGHT)) < 4 , '', TRIM(Part_AccidentLocation[33..AlMaxLength], LEFT, RIGHT));
  SELF.Alocation34 := IF(LENGTH(TRIM(Part_AccidentLocation[34..AlMaxLength], LEFT, RIGHT)) < 4 , '', TRIM(Part_AccidentLocation[34..AlMaxLength], LEFT, RIGHT));
  SELF.Alocation35 := IF(LENGTH(TRIM(Part_AccidentLocation[35..AlMaxLength], LEFT, RIGHT)) < 4 , '', TRIM(Part_AccidentLocation[35..AlMaxLength], LEFT, RIGHT));
  SELF.Alocation36 := IF(LENGTH(TRIM(Part_AccidentLocation[36..AlMaxLength], LEFT, RIGHT)) < 4 , '', TRIM(Part_AccidentLocation[36..AlMaxLength], LEFT, RIGHT));
  SELF.Alocation37 := IF(LENGTH(TRIM(Part_AccidentLocation[37..AlMaxLength], LEFT, RIGHT)) < 4 , '', TRIM(Part_AccidentLocation[37..AlMaxLength], LEFT, RIGHT));
	SELF.Alocation38 := IF(LENGTH(TRIM(Part_AccidentLocation[38..AlMaxLength], LEFT, RIGHT)) < 4 , '', TRIM(Part_AccidentLocation[38..AlMaxLength], LEFT, RIGHT));
	SELF.Alocation39 := IF(LENGTH(TRIM(Part_AccidentLocation[39..AlMaxLength], LEFT, RIGHT)) < 4 , '', TRIM(Part_AccidentLocation[39 ..AlMaxLength], LEFT, RIGHT));
	SELF.Alocation40 := IF(LENGTH(TRIM(Part_AccidentLocation[40..AlMaxLength], LEFT, RIGHT)) < 4 , '', TRIM(Part_AccidentLocation[40..AlMaxLength], LEFT, RIGHT));
	SELF.Alocation41 := IF(LENGTH(TRIM(Part_AccidentLocation[41..AlMaxLength], LEFT, RIGHT)) < 4 , '', TRIM(Part_AccidentLocation[41..AlMaxLength], LEFT, RIGHT));
  SELF.Alocation42 := IF(LENGTH(TRIM(Part_AccidentLocation[42..AlMaxLength], LEFT, RIGHT)) < 4 , '', TRIM(Part_AccidentLocation[42..AlMaxLength], LEFT, RIGHT));
  SELF.Alocation43 := IF(LENGTH(TRIM(Part_AccidentLocation[43..AlMaxLength], LEFT, RIGHT)) < 4 , '', TRIM(Part_AccidentLocation[43..AlMaxLength], LEFT, RIGHT));
	SELF.Alocation44 := IF(LENGTH(TRIM(Part_AccidentLocation[44..AlMaxLength], LEFT, RIGHT)) < 4 , '', TRIM(Part_AccidentLocation[44..AlMaxLength], LEFT, RIGHT));
  SELF.Alocation45 := IF(LENGTH(TRIM(Part_AccidentLocation[45..AlMaxLength], LEFT, RIGHT)) < 4 , '', TRIM(Part_AccidentLocation[45..AlMaxLength], LEFT, RIGHT));
	SELF.Alocation46 := IF(LENGTH(TRIM(Part_AccidentLocation[46..AlMaxLength], LEFT, RIGHT)) < 4 , '', TRIM(Part_AccidentLocation[46..AlMaxLength], LEFT, RIGHT));
  SELF.Alocation47 := IF(LENGTH(TRIM(Part_AccidentLocation[47..AlMaxLength], LEFT, RIGHT)) < 4 , '', TRIM(Part_AccidentLocation[47..AlMaxLength], LEFT, RIGHT));
  SELF.Alocation48 := IF(LENGTH(TRIM(Part_AccidentLocation[48..AlMaxLength], LEFT, RIGHT)) < 4 , '', TRIM(Part_AccidentLocation[48..AlMaxLength], LEFT, RIGHT));
  SELF.Alocation49 := IF(LENGTH(TRIM(Part_AccidentLocation[49..AlMaxLength], LEFT, RIGHT)) < 4 , '', TRIM(Part_AccidentLocation[49..AlMaxLength], LEFT, RIGHT));
  SELF.Alocation50 := IF(LENGTH(TRIM(Part_AccidentLocation[50..AlMaxLength], LEFT, RIGHT)) < 4 , '', TRIM(Part_AccidentLocation[50..AlMaxLength], LEFT, RIGHT));
  SELF.Alocation51 := IF(LENGTH(TRIM(Part_AccidentLocation[51..AlMaxLength], LEFT, RIGHT)) < 4 , '', TRIM(Part_AccidentLocation[51..AlMaxLength], LEFT, RIGHT));
  SELF.Alocation52 := IF(LENGTH(TRIM(Part_AccidentLocation[52..AlMaxLength], LEFT, RIGHT)) < 4 , '', TRIM(Part_AccidentLocation[52..AlMaxLength], LEFT, RIGHT));
  SELF.Alocation53 := IF(LENGTH(TRIM(Part_AccidentLocation[53..AlMaxLength], LEFT, RIGHT)) < 4 , '', TRIM(Part_AccidentLocation[53..AlMaxLength], LEFT, RIGHT));
  SELF.Alocation54 := IF(LENGTH(TRIM(Part_AccidentLocation[54..AlMaxLength], LEFT, RIGHT)) < 4 , '', TRIM(Part_AccidentLocation[54..AlMaxLength], LEFT, RIGHT));
  SELF.Alocation55 := IF(LENGTH(TRIM(Part_AccidentLocation[55..AlMaxLength], LEFT, RIGHT)) < 4 , '', TRIM(Part_AccidentLocation[55..AlMaxLength], LEFT, RIGHT));
  SELF.Alocation56 := IF(LENGTH(TRIM(Part_AccidentLocation[56..AlMaxLength], LEFT, RIGHT)) < 4 , '', TRIM(Part_AccidentLocation[56..AlMaxLength], LEFT, RIGHT));
  SELF.Alocation57 := IF(LENGTH(TRIM(Part_AccidentLocation[57..AlMaxLength], LEFT, RIGHT)) < 4 , '', TRIM(Part_AccidentLocation[57..AlMaxLength], LEFT, RIGHT));
	SELF.Alocation58 := IF(LENGTH(TRIM(Part_AccidentLocation[58..AlMaxLength], LEFT, RIGHT)) < 4 , '', TRIM(Part_AccidentLocation[58..AlMaxLength], LEFT, RIGHT));
	SELF.Alocation59 := IF(LENGTH(TRIM(Part_AccidentLocation[59..AlMaxLength], LEFT, RIGHT)) < 4 , '', TRIM(Part_AccidentLocation[59 ..AlMaxLength], LEFT, RIGHT));
	SELF.Alocation60 := IF(LENGTH(TRIM(Part_AccidentLocation[60..AlMaxLength], LEFT, RIGHT)) < 4 , '', TRIM(Part_AccidentLocation[60..AlMaxLength], LEFT, RIGHT));
	SELF.Alocation61 := IF(LENGTH(TRIM(Part_AccidentLocation[61..AlMaxLength], LEFT, RIGHT)) < 4 , '', TRIM(Part_AccidentLocation[61..AlMaxLength], LEFT, RIGHT));
  SELF.Alocation62 := IF(LENGTH(TRIM(Part_AccidentLocation[62..AlMaxLength], LEFT, RIGHT)) < 4 , '', TRIM(Part_AccidentLocation[62..AlMaxLength], LEFT, RIGHT));
  SELF.Alocation63 := IF(LENGTH(TRIM(Part_AccidentLocation[63..AlMaxLength], LEFT, RIGHT)) < 4 , '', TRIM(Part_AccidentLocation[63..AlMaxLength], LEFT, RIGHT));
	SELF.Alocation64 := IF(LENGTH(TRIM(Part_AccidentLocation[64..AlMaxLength], LEFT, RIGHT)) < 4 , '', TRIM(Part_AccidentLocation[64..AlMaxLength], LEFT, RIGHT));
  SELF.Alocation65 := IF(LENGTH(TRIM(Part_AccidentLocation[65..AlMaxLength], LEFT, RIGHT)) < 4 , '', TRIM(Part_AccidentLocation[65..AlMaxLength], LEFT, RIGHT));
	SELF.Alocation66 := IF(LENGTH(TRIM(Part_AccidentLocation[66..AlMaxLength], LEFT, RIGHT)) < 4 , '', TRIM(Part_AccidentLocation[66..AlMaxLength], LEFT, RIGHT));
  SELF.Alocation67 := IF(LENGTH(TRIM(Part_AccidentLocation[67..AlMaxLength], LEFT, RIGHT)) < 4 , '', TRIM(Part_AccidentLocation[67..AlMaxLength], LEFT, RIGHT));
  SELF.Alocation68 := IF(LENGTH(TRIM(Part_AccidentLocation[68..AlMaxLength], LEFT, RIGHT)) < 4 , '', TRIM(Part_AccidentLocation[68..AlMaxLength], LEFT, RIGHT));
  SELF.Alocation69 := IF(LENGTH(TRIM(Part_AccidentLocation[69..AlMaxLength], LEFT, RIGHT)) < 4 , '', TRIM(Part_AccidentLocation[69..AlMaxLength], LEFT, RIGHT));
  SELF.Alocation70 := IF(LENGTH(TRIM(Part_AccidentLocation[70..AlMaxLength], LEFT, RIGHT)) < 4 , '', TRIM(Part_AccidentLocation[70..AlMaxLength], LEFT, RIGHT));
  SELF.Alocation71 := IF(LENGTH(TRIM(Part_AccidentLocation[71..AlMaxLength], LEFT, RIGHT)) < 4 , '', TRIM(Part_AccidentLocation[71..AlMaxLength], LEFT, RIGHT));
  SELF.Alocation72 := IF(LENGTH(TRIM(Part_AccidentLocation[72..AlMaxLength], LEFT, RIGHT)) < 4 , '', TRIM(Part_AccidentLocation[72..AlMaxLength], LEFT, RIGHT));
  SELF.Alocation73 := IF(LENGTH(TRIM(Part_AccidentLocation[73..AlMaxLength], LEFT, RIGHT)) < 4 , '', TRIM(Part_AccidentLocation[73..AlMaxLength], LEFT, RIGHT));
  SELF.Alocation74 := IF(LENGTH(TRIM(Part_AccidentLocation[74..AlMaxLength], LEFT, RIGHT)) < 4 , '', TRIM(Part_AccidentLocation[74..AlMaxLength], LEFT, RIGHT));
  SELF.Alocation75 := IF(LENGTH(TRIM(Part_AccidentLocation[75..AlMaxLength], LEFT, RIGHT)) < 4 , '', TRIM(Part_AccidentLocation[75..AlMaxLength], LEFT, RIGHT));
  SELF.Alocation76 := IF(LENGTH(TRIM(Part_AccidentLocation[76..AlMaxLength], LEFT, RIGHT)) < 4 , '', TRIM(Part_AccidentLocation[76..AlMaxLength], LEFT, RIGHT));
  SELF.Alocation77 := IF(LENGTH(TRIM(Part_AccidentLocation[77..AlMaxLength], LEFT, RIGHT)) < 4 , '', TRIM(Part_AccidentLocation[77..AlMaxLength], LEFT, RIGHT));
	SELF.Alocation78 := IF(LENGTH(TRIM(Part_AccidentLocation[78..AlMaxLength], LEFT, RIGHT)) < 4 , '', TRIM(Part_AccidentLocation[78..AlMaxLength], LEFT, RIGHT));
	SELF.Alocation79 := IF(LENGTH(TRIM(Part_AccidentLocation[79..AlMaxLength], LEFT, RIGHT)) < 4 , '', TRIM(Part_AccidentLocation[79 ..AlMaxLength], LEFT, RIGHT));
	SELF.Alocation80 := IF(LENGTH(TRIM(Part_AccidentLocation[80..AlMaxLength], LEFT, RIGHT)) < 4 , '', TRIM(Part_AccidentLocation[80..AlMaxLength], LEFT, RIGHT));
	SELF.Alocation81 := IF(LENGTH(TRIM(Part_AccidentLocation[81..AlMaxLength], LEFT, RIGHT)) < 4 , '', TRIM(Part_AccidentLocation[81..AlMaxLength], LEFT, RIGHT));
  SELF.Alocation82 := IF(LENGTH(TRIM(Part_AccidentLocation[82..AlMaxLength], LEFT, RIGHT)) < 4 , '', TRIM(Part_AccidentLocation[82..AlMaxLength], LEFT, RIGHT));
  SELF.Alocation83 := IF(LENGTH(TRIM(Part_AccidentLocation[83..AlMaxLength], LEFT, RIGHT)) < 4 , '', TRIM(Part_AccidentLocation[83..AlMaxLength], LEFT, RIGHT));
	SELF.Alocation84 := IF(LENGTH(TRIM(Part_AccidentLocation[84..AlMaxLength], LEFT, RIGHT)) < 4 , '', TRIM(Part_AccidentLocation[84..AlMaxLength], LEFT, RIGHT));
  SELF.Alocation85 := IF(LENGTH(TRIM(Part_AccidentLocation[85..AlMaxLength], LEFT, RIGHT)) < 4 , '', TRIM(Part_AccidentLocation[85..AlMaxLength], LEFT, RIGHT));
	SELF.Alocation86 := IF(LENGTH(TRIM(Part_AccidentLocation[86..AlMaxLength], LEFT, RIGHT)) < 4 , '', TRIM(Part_AccidentLocation[86..AlMaxLength], LEFT, RIGHT));
  SELF.Alocation87 := IF(LENGTH(TRIM(Part_AccidentLocation[87..AlMaxLength], LEFT, RIGHT)) < 4 , '', TRIM(Part_AccidentLocation[87..AlMaxLength], LEFT, RIGHT));
  SELF.Alocation88 := IF(LENGTH(TRIM(Part_AccidentLocation[88..AlMaxLength], LEFT, RIGHT)) < 4 , '', TRIM(Part_AccidentLocation[88..AlMaxLength], LEFT, RIGHT));
  SELF.Alocation89 := IF(LENGTH(TRIM(Part_AccidentLocation[89..AlMaxLength], LEFT, RIGHT)) < 4 , '', TRIM(Part_AccidentLocation[89..AlMaxLength], LEFT, RIGHT));
  SELF.Alocation90 := IF(LENGTH(TRIM(Part_AccidentLocation[90..AlMaxLength], LEFT, RIGHT)) < 4 , '', TRIM(Part_AccidentLocation[90..AlMaxLength], LEFT, RIGHT));
  SELF.Alocation91 := IF(LENGTH(TRIM(Part_AccidentLocation[91..AlMaxLength], LEFT, RIGHT)) < 4 , '', TRIM(Part_AccidentLocation[91..AlMaxLength], LEFT, RIGHT));
  SELF.Alocation92 := IF(LENGTH(TRIM(Part_AccidentLocation[92..AlMaxLength], LEFT, RIGHT)) < 4 , '', TRIM(Part_AccidentLocation[92..AlMaxLength], LEFT, RIGHT));
  SELF.Alocation93 := IF(LENGTH(TRIM(Part_AccidentLocation[93..AlMaxLength], LEFT, RIGHT)) < 4 , '', TRIM(Part_AccidentLocation[93..AlMaxLength], LEFT, RIGHT));
  SELF.Alocation94 := IF(LENGTH(TRIM(Part_AccidentLocation[94..AlMaxLength], LEFT, RIGHT)) < 4 , '', TRIM(Part_AccidentLocation[94..AlMaxLength], LEFT, RIGHT));
  SELF.Alocation95 := IF(LENGTH(TRIM(Part_AccidentLocation[95..AlMaxLength], LEFT, RIGHT)) < 4 , '', TRIM(Part_AccidentLocation[95..AlMaxLength], LEFT, RIGHT));
  SELF.Alocation96 := IF(LENGTH(TRIM(Part_AccidentLocation[96..AlMaxLength], LEFT, RIGHT)) < 4 , '', TRIM(Part_AccidentLocation[96..AlMaxLength], LEFT, RIGHT));
  SELF.Alocation97 := IF(LENGTH(TRIM(Part_AccidentLocation[97..AlMaxLength], LEFT, RIGHT)) < 4 , '', TRIM(Part_AccidentLocation[97..AlMaxLength], LEFT, RIGHT));
	SELF := L;
END;  
ParseAccidentLocation := PROJECT(dseCrashSearch, tParseAccidentLocation(LEFT));

SlimAccidentLocLayout	:=	RECORD
	STRING100	Partial_Accident_Location := '';
	Layouts.key_slim_layout;
END;
SlimAccidentLocLayout tSlimLocation(InterimAccidentLocLayout L, INTEGER Cnt) := TRANSFORM
	SELF := L;
	SELF.Partial_Accident_Location := CHOOSE(Cnt, L.Alocation1,
																					 L.Alocation2,
																					 L.Alocation3,
																					 L.Alocation4,
																					 L.Alocation5,
																					 L.Alocation6,
																					 L.Alocation7,
																					 L.Alocation8,
																					 L.Alocation9,
																					 L.Alocation10,
																					 L.Alocation11,
																					 L.Alocation12,
																					 L.Alocation13,
																					 L.Alocation14,
																					 L.Alocation15,
																					 L.Alocation16,
																					 L.Alocation17,
																					 L.Alocation18,
																					 L.Alocation19,
																					 L.Alocation20,
																					 L.Alocation21,
																					 L.Alocation22, 
																					 L.Alocation23,
																					 L.Alocation24,
																					 L.Alocation25,
																					 L.Alocation26,
																					 L.Alocation27,
																					 L.Alocation28,
																					 L.Alocation29,
																					 L.Alocation30,
																					 L.Alocation31,
																					 L.Alocation32,
																					 L.Alocation33,
																					 L.Alocation34,
																					 L.Alocation35,
																					 L.Alocation36,
																					 L.Alocation37,
																					 L.Alocation38,
																					 L.Alocation39,
																					 L.Alocation40,
																					 L.Alocation41,
																					 L.Alocation42, 
																					 L.Alocation43,
																					 L.Alocation44,
																					 L.Alocation45,
																					 L.Alocation46,
																					 L.Alocation47,
																					 L.Alocation48,
																					 L.Alocation49,
																					 L.Alocation50,
																					 L.Alocation51,
																					 L.Alocation52,
																					 L.Alocation53,
																					 L.Alocation54,
																					 L.Alocation55,
																					 L.Alocation56,
																					 L.Alocation57,
																					 L.Alocation58,
																					 L.Alocation59,
																					 L.Alocation60,
																					 L.Alocation61,
																					 L.Alocation62, 
																					 L.Alocation63,
																					 L.Alocation64,
																					 L.Alocation65,
																					 L.Alocation66,
																					 L.Alocation67,
																					 L.Alocation68,
																					 L.Alocation69,
																					 L.Alocation70,
																					 L.Alocation71,
																					 L.Alocation72,
																					 L.Alocation73,
																					 L.Alocation74,
																					 L.Alocation75,
																					 L.Alocation76,
																					 L.Alocation77,
																					 L.Alocation78,
																					 L.Alocation79,
																					 L.Alocation80,
																					 L.Alocation81,
																					 L.Alocation82, 
																					 L.Alocation83,
																					 L.Alocation84,
																					 L.Alocation85,
																					 L.Alocation86,
																					 L.Alocation87,
																					 L.Alocation88,
																					 L.Alocation89,
																					 L.Alocation90,
																					 L.Alocation91,
																					 L.Alocation92,
																					 L.Alocation93,
																					 L.Alocation94,
																					 L.Alocation95,
																					 L.Alocation96,
																					 L.Alocation97);
END;					   
normAccidentLocation := NORMALIZE(ParseAccidentLocation, 97, tSlimLocation(LEFT, COUNTER));

pAccidentLocation	:= PROJECT(normAccidentLocation(partial_accident_location <> ''),
                             TRANSFORM(SlimAccidentLocLayout, 
                                       SELF.Partial_Accident_Location := IF(TRIM(LEFT.Partial_Accident_Location, LEFT, RIGHT) = '', 
																													                  '', 
																																						TRIM(LEFT.Partial_Accident_Location, LEFT, RIGHT));
					                             SELF := LEFT;));
dAccidentLocation	:= DISTRIBUTED(pAccidentLocation, HASH32(accident_nbr));
sAccidentLocation	:= SORT(dAccidentLocation, accident_nbr, Partial_Accident_Location, report_code, jurisdiction_state, jurisdiction,
                                             accident_date, report_type_id, LOCAL);
uAccidentLocation	:= DEDUP(sAccidentLocation, accident_nbr, Partial_Accident_Location, report_code, jurisdiction_state, jurisdiction, 
                                              accident_date, report_type_id, LOCAL);
																							
EXPORT Key_eCrashv2_StAndLocation := INDEX(uAccidentLocation,
                                           {Partial_Accident_location, jurisdiction_state, jurisdiction},
                                           {uAccidentLocation},
                                           Files_eCrash.FILE_KEY_ST_AND_LOCATION_SF);
