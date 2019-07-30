import VehicleV2, Doxie, ut, data_services,BIPV2;

get_recs	:= VehicleV2.file_VehicleV2_Party_Clean_Sequence_Key;

//party_dist   := distribute(get_recs, hash(Vehicle_Key, iteration_key, sequence_key));

//Add standardized lienholder for quiz project
layout_std_lienholder_lkp := RECORD
	STRING70	Append_Clean_CName;
	STRING70	std_lienholder_name;
END;

file_std_lienholder_lkp := DATASET('~thor_data400::lookup::vehiclesv2::std_lienholder', layout_std_lienholder_lkp, CSV(SEPARATOR('|')));

layout_Key_Vehicle_Party_Key
	:=
		RECORD
			VehicleV2.Layout_Base_Party;
			STRING70	std_lienholder_name;
			BIPV2.IDlayouts.l_xlink_ids;
			string1 filler := '';
			END;

layout_Key_Vehicle_Party_Key	tAddStdLienholder(get_recs pLeft, layout_std_lienholder_lkp pLkp)
	:=
		TRANSFORM
			self.std_lienholder_name	:=	pLkp.std_lienholder_name;
			self											:=	pLeft;
		END
	;

party_recs_std_lienholder	:=	JOIN(get_recs, file_std_lienholder_lkp, LEFT.Orig_Name_Type = '7' 
																																	AND StringLib.StringToUpperCase(StringLib.StringCleanSpaces(LEFT.Append_Clean_CName)) = StringLib.StringToUpperCase(StringLib.StringCleanSpaces(RIGHT.Append_Clean_CName))
																																	, tAddStdLienholder(left,right), LEFT OUTER, LOOKUP);


export	Key_Vehicle_Party_Key	:=	index(	party_recs_std_lienholder,
																					{Vehicle_Key, iteration_key, sequence_key}, {party_recs_std_lienholder},
																					Data_Services.Data_location.Prefix('NONAMEGIVEN')+'thor_data400::key::vehicleV2::party_Key_'+ doxie.Version_SuperKey
																				);	