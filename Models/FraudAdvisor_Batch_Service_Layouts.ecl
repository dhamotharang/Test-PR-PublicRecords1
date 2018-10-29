Import risk_indicators;

EXPORT FraudAdvisor_Batch_Service_Layouts := MODULE 

		export BatchInput := record
			risk_indicators.Layout_Batch_In;
			STRING120 UnparsedFullName2;
			STRING30  Name_First2;
			STRING30  Name_Middle2;
			STRING30  Name_Last2;
			STRING5   Name_Suffix2;
			STRING65  Street_Addr2;
			string10  Prim_Range2;
			string2   Predir2;
			string28  Prim_Name2;
			string4   Suffix2;
			string2   Postdir2;
			string10  Unit_Desig2;
			string8   Sec_Range2;
			STRING25  p_City_name2;
			STRING2   St2;
			STRING5   Z52;
			STRING10  Home_Phone2;	
			STRING5 Grade := '';
			// fields below requested by Deni/Mike to be added for fraudpoint 2.0, even though we do nothing with them
			string16 Channel := '';
			string8 Income := '';
			string16 OwnOrRent := '';
			string16 LocationIdentifier := '';
			string16 OtherApplicationIdentifier := '';
			string16 OtherApplicationIdentifier2 := '';
			string16 OtherApplicationIdentifier3 := '';
			string8 DateofApplication := '';
			string8 TimeofApplication := '';
			string50 email := '';
			string64 custom_input1 := '';
			string64 custom_input2 := '';
			string64 custom_input3 := '';
			string64 custom_input4 := '';
			string64 custom_input5 := '';
			string64 custom_input6 := '';
			string64 custom_input7 := '';
			string64 custom_input8 := '';
			string64 custom_input9 := '';
			string64 custom_input10 := '';
			string64 custom_input11 := '';
			string64 custom_input12 := '';
			string64 custom_input13 := '';
			string64 custom_input14 := '';
			string64 custom_input15 := '';
			string64 custom_input16 := '';
			string64 custom_input17 := '';
			string64 custom_input18 := '';
			string64 custom_input19 := '';
			string64 custom_input20 := '';
			string64 custom_input21 := '';
			string64 custom_input22 := '';
			string64 custom_input23 := '';
			string64 custom_input24 := '';
			string64 custom_input25 := '';		
	end;

END;