import PRTE2_Ecrash, FLAccidents_Ecrash;


ds := File_KeybuildV2.eCrashSearchRecs(Accident_Location <> '');  


SlimAccident := record 
ds;
string100 Alocation1; 
string99 Alocation2; 
string98 Alocation3; 
string97 Alocation4; 
string96 Alocation5; 
string95 Alocation6; 
string94 Alocation7; 
string93 Alocation8; 
string92 Alocation9; 
string90 Alocation10; 
string89 Alocation11; 
string88 Alocation12; 
string87 Alocation13; 
string86 Alocation14;
string85 Alocation15;
string84 Alocation16;
string83 Alocation17;
string82 Alocation18;
string81 Alocation19;
string80 Alocation20; 
string79 Alocation21;
string78 Alocation22;
string77 Alocation23;
string76 Alocation24;
string75 Alocation25;
string74 Alocation26;
string73 Alocation27;
string72 Alocation28;
string71 Alocation29;
string70 Alocation30;
string69 Alocation31;
string68 Alocation32;
string67 Alocation33;
string66 Alocation34;
string65 Alocation35;
string64 Alocation36;
string63 Alocation37;
string62 Alocation38;
string61 Alocation39;
string60 Alocation40;
string59 Alocation41;
string58 Alocation42;
string57 Alocation43;
string56 Alocation44;
string55 Alocation45;
string54 Alocation46;
string53 Alocation47;
string52 Alocation48;
string51 Alocation49;
string50 Alocation50;
string49 Alocation51;
string48 Alocation52;
string47 Alocation53;
string46 Alocation54;
string45 Alocation55;
string44 Alocation56;
string43 Alocation57;
string42 Alocation58;
string41 Alocation59;
string40 Alocation60;
string39 Alocation61;
string38 Alocation62;
string37 Alocation63;
string36 Alocation64;
string35 Alocation65;

string34 Alocation66;
string33 Alocation67;
string32 Alocation68;
string31 Alocation69;
string30 Alocation70;
string29 Alocation71;
string28 Alocation72;
string57 Alocation73;
string56 Alocation74;
string55 Alocation75;
string54 Alocation76;
string53 Alocation77;
string52 Alocation78;
string51 Alocation79;
string51 Alocation80;
string51 Alocation81;
string51 Alocation82;
string51 Alocation83;
string51 Alocation84;
string51 Alocation85;
string51 Alocation86;
string51 Alocation87;
string51 Alocation88;
string51 Alocation89;
string51 Alocation90;
string51 Alocation91;
string51 Alocation92;
string51 Alocation93;
string51 Alocation94;
string51 Alocation95;
string54 Alocation96;
string53 Alocation97;
end; 

Parse_Accident_Location := project(ds, transform(SlimAccident, 

  Part_AccidentLocation := if(trim(left.Accident_Location,left,right) ='' , '', trim(left.Accident_Location,left,right));
  AlMaxLength	:=	100;
  SELF.Alocation1 := Part_AccidentLocation[1..AlMaxLength];
  SELF.Alocation2 := if(length(trim(Part_AccidentLocation[2..AlMaxLength],left,right)) < 4 , '',trim(Part_AccidentLocation[2..AlMaxLength], left, right)) ;
  SELF.Alocation3 := if(length(trim(Part_AccidentLocation[3..AlMaxLength],left,right)) < 4 , '',trim(Part_AccidentLocation[3..AlMaxLength], left, right));
  SELF.Alocation4 := if(length(trim(Part_AccidentLocation[4..AlMaxLength],left,right)) < 4 , '',trim(Part_AccidentLocation[4..AlMaxLength], left, right));
  SELF.Alocation5 := if(length(trim(Part_AccidentLocation[5..AlMaxLength],left,right)) < 4 , '',trim(Part_AccidentLocation[5..AlMaxLength], left, right));
  SELF.Alocation6 := if(length(trim(Part_AccidentLocation[6..AlMaxLength],left,right)) < 4 , '',trim(Part_AccidentLocation[6..AlMaxLength], left, right));
  SELF.Alocation7 := if(length(trim(Part_AccidentLocation[7..AlMaxLength],left,right)) < 4 , '',trim(Part_AccidentLocation[7..AlMaxLength], left, right));
  SELF.Alocation8 := if(length(trim(Part_AccidentLocation[8..AlMaxLength],left,right)) < 4 , '',trim(Part_AccidentLocation[8..AlMaxLength], left, right));
  SELF.Alocation9 := if(length(trim(Part_AccidentLocation[9..AlMaxLength],left,right)) < 4 , '',trim(Part_AccidentLocation[9..AlMaxLength], left, right)) ; 
  SELF.Alocation10 := if(length(trim(Part_AccidentLocation[10..AlMaxLength],left,right)) < 4 , '',trim(Part_AccidentLocation[10..AlMaxLength], left, right)); 
  SELF.Alocation11 := if(length(trim(Part_AccidentLocation[11..AlMaxLength],left,right)) < 4 , '',trim(Part_AccidentLocation[11..AlMaxLength], left, right));
  SELF.Alocation12 := if(length(trim(Part_AccidentLocation[12..AlMaxLength],left,right)) < 4 , '',trim(Part_AccidentLocation[12..AlMaxLength], left, right));
  SELF.Alocation13 := if(length(trim(Part_AccidentLocation[13..AlMaxLength],left,right)) < 4 , '',trim(Part_AccidentLocation[13..AlMaxLength], left, right));
  SELF.Alocation14 := if(length(trim(Part_AccidentLocation[14..AlMaxLength],left,right)) < 4 , '',trim(Part_AccidentLocation[14..AlMaxLength], left, right));
  SELF.Alocation15 := if(length(trim(Part_AccidentLocation[15..AlMaxLength],left,right)) < 4 , '',trim(Part_AccidentLocation[15..AlMaxLength], left, right));
  SELF.Alocation16 := if(length(trim(Part_AccidentLocation[16..AlMaxLength],left,right)) < 4 , '',trim(Part_AccidentLocation[16..AlMaxLength], left, right));
  SELF.Alocation17 := if(length(trim(Part_AccidentLocation[17..AlMaxLength],left,right)) < 4 , '',trim(Part_AccidentLocation[17..AlMaxLength], left, right));
	SELF.Alocation18 := if(length(trim(Part_AccidentLocation[18..AlMaxLength],left,right)) < 4 , '',trim(Part_AccidentLocation[18..AlMaxLength], left, right));
  SELF.Alocation19 := if(length(trim(Part_AccidentLocation[19..AlMaxLength],left,right)) < 4 , '',trim(Part_AccidentLocation[19..AlMaxLength], left, right));
  SELF.Alocation20 := if(length(trim(Part_AccidentLocation[20..AlMaxLength],left,right)) < 4 , '',trim(Part_AccidentLocation[20..AlMaxLength], left, right));
  SELF.Alocation21 := if(length(trim(Part_AccidentLocation[21..AlMaxLength],left,right)) < 4 , '',trim(Part_AccidentLocation[21..AlMaxLength], left, right));
  SELF.Alocation22 := if(length(trim(Part_AccidentLocation[22..AlMaxLength],left,right)) < 4 , '',trim(Part_AccidentLocation[22..AlMaxLength], left, right));
  SELF.Alocation23 := if(length(trim(Part_AccidentLocation[23..AlMaxLength],left,right)) < 4 , '',trim(Part_AccidentLocation[23..AlMaxLength], left, right));
	SELF.Alocation24 := if(length(trim(Part_AccidentLocation[24..AlMaxLength],left,right)) < 4 , '',trim(Part_AccidentLocation[24..AlMaxLength], left, right));
  SELF.Alocation25 := if(length(trim(Part_AccidentLocation[25..AlMaxLength],left,right)) < 4 , '',trim(Part_AccidentLocation[25..AlMaxLength], left, right));
	SELF.Alocation26 := if(length(trim(Part_AccidentLocation[26..AlMaxLength],left,right)) < 4 , '',trim(Part_AccidentLocation[26..AlMaxLength], left, right));
  SELF.Alocation27 := if(length(trim(Part_AccidentLocation[27..AlMaxLength],left,right)) < 4 , '',trim(Part_AccidentLocation[27..AlMaxLength], left, right));
  SELF.Alocation28 := if(length(trim(Part_AccidentLocation[28..AlMaxLength],left,right)) < 4 , '',trim(Part_AccidentLocation[28..AlMaxLength], left, right));
  SELF.Alocation29 := if(length(trim(Part_AccidentLocation[29..AlMaxLength],left,right)) < 4 , '',trim(Part_AccidentLocation[29..AlMaxLength], left, right));
  SELF.Alocation30 := if(length(trim(Part_AccidentLocation[30..AlMaxLength],left,right)) < 4 , '',trim(Part_AccidentLocation[30..AlMaxLength], left, right));
  SELF.Alocation31 := if(length(trim(Part_AccidentLocation[31..AlMaxLength],left,right)) < 4 , '',trim(Part_AccidentLocation[31..AlMaxLength], left, right));
  SELF.Alocation32 := if(length(trim(Part_AccidentLocation[32..AlMaxLength],left,right)) < 4 , '',trim(Part_AccidentLocation[32..AlMaxLength], left, right));
  SELF.Alocation33 := if(length(trim(Part_AccidentLocation[33..AlMaxLength],left,right)) < 4 , '',trim(Part_AccidentLocation[33..AlMaxLength], left, right));
  SELF.Alocation34 := if(length(trim(Part_AccidentLocation[34..AlMaxLength],left,right)) < 4 , '',trim(Part_AccidentLocation[34..AlMaxLength], left, right));
  SELF.Alocation35 := if(length(trim(Part_AccidentLocation[35..AlMaxLength],left,right)) < 4 , '',trim(Part_AccidentLocation[35..AlMaxLength], left, right));
  SELF.Alocation36 := if(length(trim(Part_AccidentLocation[36..AlMaxLength],left,right)) < 4 , '',trim(Part_AccidentLocation[36..AlMaxLength], left, right));
  SELF.Alocation37 := if(length(trim(Part_AccidentLocation[37..AlMaxLength],left,right)) < 4 , '',trim(Part_AccidentLocation[37..AlMaxLength], left, right));
	SELF.Alocation38 := if(length(trim(Part_AccidentLocation[38..AlMaxLength],left,right)) < 4 , '',trim(Part_AccidentLocation[38..AlMaxLength], left, right));
	SELF.Alocation39 := if(length(trim(Part_AccidentLocation[39..AlMaxLength],left,right)) < 4 , '',trim(Part_AccidentLocation[39 ..AlMaxLength], left, right));
	SELF.Alocation40 := if(length(trim(Part_AccidentLocation[40..AlMaxLength],left,right)) < 4 , '',trim(Part_AccidentLocation[40..AlMaxLength], left, right));
	
	 
  SELF.Alocation41 := if(length(trim(Part_AccidentLocation[41..AlMaxLength],left,right)) < 4 , '',trim(Part_AccidentLocation[41..AlMaxLength], left, right));
  SELF.Alocation42 := if(length(trim(Part_AccidentLocation[42..AlMaxLength],left,right)) < 4 , '',trim(Part_AccidentLocation[42..AlMaxLength], left, right));
  SELF.Alocation43 := if(length(trim(Part_AccidentLocation[43..AlMaxLength],left,right)) < 4 , '',trim(Part_AccidentLocation[43..AlMaxLength], left, right));
	SELF.Alocation44 := if(length(trim(Part_AccidentLocation[44..AlMaxLength],left,right)) < 4 , '',trim(Part_AccidentLocation[44..AlMaxLength], left, right));
  SELF.Alocation45 := if(length(trim(Part_AccidentLocation[45..AlMaxLength],left,right)) < 4 , '',trim(Part_AccidentLocation[45..AlMaxLength], left, right));
	SELF.Alocation46 := if(length(trim(Part_AccidentLocation[46..AlMaxLength],left,right)) < 4 , '',trim(Part_AccidentLocation[46..AlMaxLength], left, right));
  SELF.Alocation47 := if(length(trim(Part_AccidentLocation[47..AlMaxLength],left,right)) < 4 , '',trim(Part_AccidentLocation[47..AlMaxLength], left, right));
  SELF.Alocation48 := if(length(trim(Part_AccidentLocation[48..AlMaxLength],left,right)) < 4 , '',trim(Part_AccidentLocation[48..AlMaxLength], left, right));
  SELF.Alocation49 := if(length(trim(Part_AccidentLocation[49..AlMaxLength],left,right)) < 4 , '',trim(Part_AccidentLocation[49..AlMaxLength], left, right));
  SELF.Alocation50 := if(length(trim(Part_AccidentLocation[50..AlMaxLength],left,right)) < 4 , '',trim(Part_AccidentLocation[50..AlMaxLength], left, right));
  SELF.Alocation51 := if(length(trim(Part_AccidentLocation[51..AlMaxLength],left,right)) < 4 , '',trim(Part_AccidentLocation[51..AlMaxLength], left, right));
  SELF.Alocation52 := if(length(trim(Part_AccidentLocation[52..AlMaxLength],left,right)) < 4 , '',trim(Part_AccidentLocation[52..AlMaxLength], left, right));
  SELF.Alocation53 := if(length(trim(Part_AccidentLocation[53..AlMaxLength],left,right)) < 4 , '',trim(Part_AccidentLocation[53..AlMaxLength], left, right));
  SELF.Alocation54 := if(length(trim(Part_AccidentLocation[54..AlMaxLength],left,right)) < 4 , '',trim(Part_AccidentLocation[54..AlMaxLength], left, right));
  SELF.Alocation55 := if(length(trim(Part_AccidentLocation[55..AlMaxLength],left,right)) < 4 , '',trim(Part_AccidentLocation[55..AlMaxLength], left, right));
  SELF.Alocation56 := if(length(trim(Part_AccidentLocation[56..AlMaxLength],left,right)) < 4 , '',trim(Part_AccidentLocation[56..AlMaxLength], left, right));
  SELF.Alocation57 := if(length(trim(Part_AccidentLocation[57..AlMaxLength],left,right)) < 4 , '',trim(Part_AccidentLocation[57..AlMaxLength], left, right));
	SELF.Alocation58 := if(length(trim(Part_AccidentLocation[58..AlMaxLength],left,right)) < 4 , '',trim(Part_AccidentLocation[58..AlMaxLength], left, right));
	SELF.Alocation59 := if(length(trim(Part_AccidentLocation[59..AlMaxLength],left,right)) < 4 , '',trim(Part_AccidentLocation[59 ..AlMaxLength], left, right));
	SELF.Alocation60 := if(length(trim(Part_AccidentLocation[60..AlMaxLength],left,right)) < 4 , '',trim(Part_AccidentLocation[60..AlMaxLength], left, right));

	SELF.Alocation61 := if(length(trim(Part_AccidentLocation[61..AlMaxLength],left,right)) < 4 , '',trim(Part_AccidentLocation[61..AlMaxLength], left, right));
  SELF.Alocation62 := if(length(trim(Part_AccidentLocation[62..AlMaxLength],left,right)) < 4 , '',trim(Part_AccidentLocation[62..AlMaxLength], left, right));
  SELF.Alocation63 := if(length(trim(Part_AccidentLocation[63..AlMaxLength],left,right)) < 4 , '',trim(Part_AccidentLocation[63..AlMaxLength], left, right));
	SELF.Alocation64 := if(length(trim(Part_AccidentLocation[64..AlMaxLength],left,right)) < 4 , '',trim(Part_AccidentLocation[64..AlMaxLength], left, right));
  SELF.Alocation65 := if(length(trim(Part_AccidentLocation[65..AlMaxLength],left,right)) < 4 , '',trim(Part_AccidentLocation[65..AlMaxLength], left, right));
	SELF.Alocation66 := if(length(trim(Part_AccidentLocation[66..AlMaxLength],left,right)) < 4 , '',trim(Part_AccidentLocation[66..AlMaxLength], left, right));
  SELF.Alocation67 := if(length(trim(Part_AccidentLocation[67..AlMaxLength],left,right)) < 4 , '',trim(Part_AccidentLocation[67..AlMaxLength], left, right));
  SELF.Alocation68 := if(length(trim(Part_AccidentLocation[68..AlMaxLength],left,right)) < 4 , '',trim(Part_AccidentLocation[68..AlMaxLength], left, right));
  SELF.Alocation69 := if(length(trim(Part_AccidentLocation[69..AlMaxLength],left,right)) < 4 , '',trim(Part_AccidentLocation[69..AlMaxLength], left, right));
  SELF.Alocation70 := if(length(trim(Part_AccidentLocation[70..AlMaxLength],left,right)) < 4 , '',trim(Part_AccidentLocation[70..AlMaxLength], left, right));
  SELF.Alocation71 := if(length(trim(Part_AccidentLocation[71..AlMaxLength],left,right)) < 4 , '',trim(Part_AccidentLocation[71..AlMaxLength], left, right));
  SELF.Alocation72 := if(length(trim(Part_AccidentLocation[72..AlMaxLength],left,right)) < 4 , '',trim(Part_AccidentLocation[72..AlMaxLength], left, right));
  SELF.Alocation73 := if(length(trim(Part_AccidentLocation[73..AlMaxLength],left,right)) < 4 , '',trim(Part_AccidentLocation[73..AlMaxLength], left, right));
  SELF.Alocation74 := if(length(trim(Part_AccidentLocation[74..AlMaxLength],left,right)) < 4 , '',trim(Part_AccidentLocation[74..AlMaxLength], left, right));
  SELF.Alocation75 := if(length(trim(Part_AccidentLocation[75..AlMaxLength],left,right)) < 4 , '',trim(Part_AccidentLocation[75..AlMaxLength], left, right));
  SELF.Alocation76 := if(length(trim(Part_AccidentLocation[76..AlMaxLength],left,right)) < 4 , '',trim(Part_AccidentLocation[76..AlMaxLength], left, right));
  SELF.Alocation77 := if(length(trim(Part_AccidentLocation[77..AlMaxLength],left,right)) < 4 , '',trim(Part_AccidentLocation[77..AlMaxLength], left, right));
	SELF.Alocation78 := if(length(trim(Part_AccidentLocation[78..AlMaxLength],left,right)) < 4 , '',trim(Part_AccidentLocation[78..AlMaxLength], left, right));
	SELF.Alocation79 := if(length(trim(Part_AccidentLocation[79..AlMaxLength],left,right)) < 4 , '',trim(Part_AccidentLocation[79 ..AlMaxLength], left, right));
	SELF.Alocation80 := if(length(trim(Part_AccidentLocation[80..AlMaxLength],left,right)) < 4 , '',trim(Part_AccidentLocation[80..AlMaxLength], left, right));
	
	SELF.Alocation81 := if(length(trim(Part_AccidentLocation[81..AlMaxLength],left,right)) < 4 , '',trim(Part_AccidentLocation[81..AlMaxLength], left, right));
  SELF.Alocation82 := if(length(trim(Part_AccidentLocation[82..AlMaxLength],left,right)) < 4 , '',trim(Part_AccidentLocation[82..AlMaxLength], left, right));
  SELF.Alocation83 := if(length(trim(Part_AccidentLocation[83..AlMaxLength],left,right)) < 4 , '',trim(Part_AccidentLocation[83..AlMaxLength], left, right));
	SELF.Alocation84 := if(length(trim(Part_AccidentLocation[84..AlMaxLength],left,right)) < 4 , '',trim(Part_AccidentLocation[84..AlMaxLength], left, right));
  SELF.Alocation85 := if(length(trim(Part_AccidentLocation[85..AlMaxLength],left,right)) < 4 , '',trim(Part_AccidentLocation[85..AlMaxLength], left, right));
	SELF.Alocation86 := if(length(trim(Part_AccidentLocation[86..AlMaxLength],left,right)) < 4 , '',trim(Part_AccidentLocation[86..AlMaxLength], left, right));
  SELF.Alocation87 := if(length(trim(Part_AccidentLocation[87..AlMaxLength],left,right)) < 4 , '',trim(Part_AccidentLocation[87..AlMaxLength], left, right));
  SELF.Alocation88 := if(length(trim(Part_AccidentLocation[88..AlMaxLength],left,right)) < 4 , '',trim(Part_AccidentLocation[88..AlMaxLength], left, right));
  SELF.Alocation89 := if(length(trim(Part_AccidentLocation[89..AlMaxLength],left,right)) < 4 , '',trim(Part_AccidentLocation[89..AlMaxLength], left, right));
  SELF.Alocation90 := if(length(trim(Part_AccidentLocation[90..AlMaxLength],left,right)) < 4 , '',trim(Part_AccidentLocation[90..AlMaxLength], left, right));
  SELF.Alocation91 := if(length(trim(Part_AccidentLocation[91..AlMaxLength],left,right)) < 4 , '',trim(Part_AccidentLocation[91..AlMaxLength], left, right));
  SELF.Alocation92 := if(length(trim(Part_AccidentLocation[92..AlMaxLength],left,right)) < 4 , '',trim(Part_AccidentLocation[92..AlMaxLength], left, right));
  SELF.Alocation93 := if(length(trim(Part_AccidentLocation[93..AlMaxLength],left,right)) < 4 , '',trim(Part_AccidentLocation[93..AlMaxLength], left, right));
  SELF.Alocation94 := if(length(trim(Part_AccidentLocation[94..AlMaxLength],left,right)) < 4 , '',trim(Part_AccidentLocation[94..AlMaxLength], left, right));
  SELF.Alocation95 := if(length(trim(Part_AccidentLocation[95..AlMaxLength],left,right)) < 4 , '',trim(Part_AccidentLocation[95..AlMaxLength], left, right));
  SELF.Alocation96 := if(length(trim(Part_AccidentLocation[96..AlMaxLength],left,right)) < 4 , '',trim(Part_AccidentLocation[96..AlMaxLength], left, right));
  SELF.Alocation97 := if(length(trim(Part_AccidentLocation[97..AlMaxLength],left,right)) < 4 , '',trim(Part_AccidentLocation[97..AlMaxLength], left, right));
	

  self := left)); 
	
Slim_Accident_Rec	:=	RECORD
	String100	Partial_Accident_Location := '';
	FLAccidents_Ecrash.Layouts.key_slim_layout;
END;

Slim_Accident_Rec SlimLocation(SlimAccident l, integer cnt) := transform

		self := l;
		self.Partial_Accident_Location:= choose(cnt, l.Alocation1,
																					 l.Alocation2,
																					 l.Alocation3,
																					 l.Alocation4,
																					 l.Alocation5,
																					 l.Alocation6,
                                           l.Alocation7,
                                           l.Alocation8,
                                           l.Alocation9,
                                           l.Alocation10,
                                           l.Alocation11,
                                           l.Alocation12,
                                           l.Alocation13,
                                           l.Alocation14,
                                           l.Alocation15,
                                           l.Alocation16,
                                           l.Alocation17,
                                           l.Alocation18,
                                           l.Alocation19,
                                           l.Alocation20,
                                           l.Alocation21,
                                           l.Alocation22, 
																					 l.Alocation23,
																					 l.Alocation24,
																					 l.Alocation25,
																					 l.Alocation26,
																					 l.Alocation27,
																					 l.Alocation28,
																					 l.Alocation29,
																					 l.Alocation30,
																					 l.Alocation31,
																					 l.Alocation32,
																					 l.Alocation33,
																					 l.Alocation34,
																					 l.Alocation35,
																					 l.Alocation36,
																					 l.Alocation37,
																					 
																					 l.Alocation38,
                                           l.Alocation39,
                                           l.Alocation40,
                                           l.Alocation41,
                                           l.Alocation42, 
																					 l.Alocation43,
																					 l.Alocation44,
																					 l.Alocation45,
																					 l.Alocation46,
																					 l.Alocation47,
																					 l.Alocation48,
																					 l.Alocation49,
																					 l.Alocation50,
																					 l.Alocation51,
																					 l.Alocation52,
																					 l.Alocation53,
																					 l.Alocation54,
																					 l.Alocation55,
																					 l.Alocation56,
																					 l.Alocation57,
																					 l.Alocation58,
                                           l.Alocation59,
                                           l.Alocation60,
                                           l.Alocation61,
                                           l.Alocation62, 
																					 l.Alocation63,
																					 l.Alocation64,
																					 l.Alocation65,
																					 l.Alocation66,
																					 l.Alocation67,
																					 l.Alocation68,
																					 l.Alocation69,
																					 l.Alocation70,
																					 l.Alocation71,
																					 l.Alocation72,
																					 l.Alocation73,
																					 l.Alocation74,
																					 l.Alocation75,
																					 l.Alocation76,
																					 l.Alocation77,
																					 l.Alocation78,
                                           l.Alocation79,
                                           l.Alocation80,
                                           l.Alocation81,
                                           l.Alocation82, 
																					 l.Alocation83,
																					 l.Alocation84,
																					 l.Alocation85,
																					 l.Alocation86,
																					 l.Alocation87,
																					 l.Alocation88,
																					 l.Alocation89,
																					 l.Alocation90,
																					 l.Alocation91,
																					 l.Alocation92,
																					 l.Alocation93,
																					 l.Alocation94,
																					 l.Alocation95,
																					 l.Alocation96,
																					 l.Alocation97
																					 
																					 );						  	
		
	end;
					   
norm_report := normalize(Parse_Accident_Location, 97, SlimLocation(left, counter))(partial_accident_location <>''); 

EXPORT file_stAndLocation	:=	dedup(sort(distribute(project(norm_report , transform(Slim_Accident_Rec, 
																														self.Partial_Accident_Location := if(trim(left.Partial_Accident_Location,left,right) ='' , '', 
																																																	trim(left.Partial_Accident_Location,left,right));
																														self := left;))(Partial_Accident_Location <>''),hash64(accident_nbr)),accident_nbr, local), all,local);
