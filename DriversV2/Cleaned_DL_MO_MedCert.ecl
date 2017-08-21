IMPORT Drivers, DriversV2, Address, ut, NID, lib_stringlib, _Validate;

EXPORT Cleaned_DL_MO_MedCert(STRING processDate, STRING fileDate) := FUNCTION
 //This attribute processes the MO DL raw data containing the medical certification information
 //NOTE:  The medical certification is not mapped
	
 in_file := DriversV2.File_DL_MO_MedCert_RAW(fileDate);
 
 TrimUpper(STRING s):= FUNCTION
		RETURN TRIM(stringlib.StringToUppercase(s),LEFT,RIGHT);
 END;
 
 layout_out := DriversV2.Layouts_DL_MO_New_In.Layout_MO_Fixed_MedCert;
	
 layout_out  trans1(in_file l) := TRANSFORM
	 SELF.Unique_Key           := l.Line[1..10];
	 SELF.Rec_Len              := l.Line[11..15];
	 //********* Basic Record          101-350   ****************
	 SELF.Lic_Number           := l.Line[101..110];             
	 SELF.Last_Name            := l.Line[111..150];            
	 SELF.First_Name           := l.Line[151..190];             
	 SELF.Middle_Name          := l.Line[191..225];             
	 SELF.Suffix               := l.Line[226..230]; 
	 //The new layout contains unused field in 231-236
	 SELF.Birthdate            := l.Line[237..244];             
	 SELF.Gender               := l.Line[245..245];             
	 SELF.Address              := l.Line[246..270];             
	 SELF.City                 := l.Line[271..290];             
	 SELF.State                := l.Line[291..292];             
	 SELF.Zip5                 := l.Line[293..297];             
	 SELF.Zip4                 := l.Line[298..301];            
	 SELF.Mailing_Address1     := l.Line[302..326];             
	 SELF.Mailing_Address2     := l.Line[327..351];             
	 SELF.Mailing_City         := l.Line[352..371];             
	 SELF.Mailing_State        := l.Line[372..373];             
	 SELF.Mailing_Zip          := l.Line[374..382];             
	 SELF.Height               := l.Line[383..385];             
	 SELF.Weight               := l.Line[386..388];             
	 SELF.Eye_Color            := l.Line[389..389];             
	 SELF.Operator_Status      := l.Line[390..391];             
	 SELF.Commercial_Status    := l.Line[392..393];             
	 SELF.Sch_Bus_Status       := l.Line[394..395];             
	 SELF.Pending_Act_Code     := l.Line[396..396];             
	 SELF.Must_Test_Ind        := l.Line[397..397];             
	 SELF.Deceased_Ind         := l.Line[398..398];              
	 SELF.Prev_CDL_Class       := l.Line[399..400];             
	 SELF.CDL_Ptr              := l.Line[401..401];             
	 SELF.PDPS_Ptr             := l.Line[402..402];             
	 SELF.MVR_Privacy_Code     := l.Line[403..403];             
	 SELF.BRC_Status_Code      := l.Line[404..404];             
	 SELF.BRC_Status_Date      := l.Line[405..412];             
	 //********* License Issuance Record   ****************
	 SELF.Lic_Iss_Code         := l.Line[461..461];             
	 SELF.Lic_Class            := l.Line[462..463];             
	 SELF.Lic_Exp_Date         := l.Line[464..471];             
	 SELF.Lic_Seq_Number       := l.Line[472..483];             
	 SELF.Lic_Surrender_From   := l.Line[484..485];             
	 SELF.Lic_Surrender_To     := l.Line[486..487];             
	 SELF.New_Out_of_St_DL_Num := l.Line[488..512];             
	 SELF.Lic_Endorsements     := l.Line[513..522];             
	 SELF.Lic_Restrictions     := l.Line[523..527];             
	 SELF.Lic_Trans_Type       := l.Line[533..534];             
	 SELF.Lic_Print_Date       := l.Line[535..542];             
	 SELF.Permit_Iss_Code      := l.Line[553..553];             
	 SELF.Permit_Class         := l.Line[554..555];             
	 SELF.Permit_Exp_Date      := l.Line[556..563];             
	 SELF.Permit_Seq_Number    := l.Line[564..575];             
	 SELF.Permit_Endorse_Codes := l.Line[576..585];             
	 SELF.Permit_Restric_Codes := l.Line[586..590];             
	 SELF.Permit_Trans_Type    := l.Line[596..597];             
	 SELF.Permit_Print_Date    := l.Line[598..605];             
	 SELF.Non_Drvr_Code        := l.Line[608..608];             
	 SELF.Non_Drvr_Exp_Date    := l.Line[609..616];             
	 SELF.Non_Drvr_Seq_Num     := l.Line[617..628];             
	 SELF.Non_Drvr_Trans_Type  := l.Line[629..630];             
	 SELF.Non_Drvr_Print_Date  := l.Line[631..638];             
	 //********* Other Records    ****************
	 SELF.Action_Surrender_Date:= l.Line[709..716];             
	 SELF.Action_Counts        := (UNSIGNED4)l.Line[1137..1139];  
	 SELF.Driv_Priv_Counts     := (UNSIGNED4)l.Line[1140..1142];  
	 SELF.Conv_Counts          := (UNSIGNED4)l.Line[1143..1145];  
	 SELF.Accidents_Counts     := (UNSIGNED4)l.Line[1146..1148];  
	 SELF.AKA_Counts           := (UNSIGNED4)l.Line[1149..1151];  
	 //********* Starting Position of the other records
	 UNSIGNED4 Act_st          := 1158;   
	 UNSIGNED4 Act_end         := Act_st + (SELF.Action_Counts * 120);	
	 UNSIGNED4 DP_st           := Act_end; 
	 UNSIGNED4 DP_end          := DP_st + (SELF.Driv_Priv_Counts * 40);	 
	 UNSIGNED4 Con_st          := DP_end;
	 UNSIGNED4 Con_end         := Con_st + (SELF.Conv_Counts * 110);	
 	 UNSIGNED4 Acc_st          := Con_end;
	 UNSIGNED4 Acc_end         := Acc_st +(SELF.Accidents_Counts * 50);	
	 UNSIGNED4 AKA_st          := Acc_end;
	 UNSIGNED4 AKA_end         := AKA_st +(SELF.AKA_Counts * 171);
	 SELF.Action_Recs          := IF(SELF.Action_Counts > 0, L.Line[Act_st..(Act_end - 1)],'');
	 SELF.Driv_Priv_Recs       := IF(SELF.Driv_Priv_Counts > 0, L.Line[DP_st..(DP_end - 1)],'');
	 SELF.Convict_Recs         := IF(SELF.Conv_Counts > 0, L.Line[Con_st..(Con_end - 1)],'');
	 SELF.Accident_Recs        := IF(SELF.Accidents_Counts > 0, L.Line[Acc_st..(Acc_end - 1)],'');
	 SELF.AKA_Recs             := IF(SELF.AKA_Counts > 0, L.Line[AKA_st..(AKA_end - 1)],'');
 END;
 
 inrecs := PROJECT(in_file, trans1(left)) : PERSIST(DriversV2.Constants.cluster+'in::dl2::MO_fixed_medcert_update::'+ filedate);
	
 //********* AKA Records *****************************************************************************
 Layouts_DL_MO_New_In.Layout_MO_AKA_MedCert transAKA1(inrecs l, UNSIGNED4 C) := TRANSFORM,SKIP(l.AKA_Recs = '')
	 SELF.Unique_Key      := trimUpper(l.Unique_Key);
	 SELF.AKA_Lic_State   := trimUpper(CHOOSE(C,l.AKA_Recs[1..2], l.AKA_Recs[172..173],l.AKA_Recs[343..344]));
	 SELF.AKA_Lic_Num     := trimUpper(CHOOSE(C,l.AKA_Recs[3..27],l.AKA_Recs[174..198],l.AKA_Recs[345..369]));
	 SELF.AKA_LName       := trimUpper(CHOOSE(C,l.AKA_Recs[28..67],l.AKA_Recs[199..238],l.AKA_Recs[370..409]));
	 SELF.AKA_FName       := trimUpper(CHOOSE(C,l.AKA_Recs[68..107],l.AKA_Recs[239..278],l.AKA_Recs[410..449]));
	 SELF.AKA_MName       := trimUpper(CHOOSE(C,l.AKA_Recs[108..142],l.AKA_Recs[279..313],l.AKA_Recs[450..484]));  
	 SELF.AKA_Suffix      := trimUpper(CHOOSE(C,l.AKA_Recs[143..147],l.AKA_Recs[314..318],l.AKA_Recs[485..489]));
	 SELF.AKA_DOB         := lib_stringlib.stringlib.stringfilter(CHOOSE(C,l.AKA_Recs[148..155],l.AKA_Recs[319..326],l.AKA_Recs[490..497]),'0123456789');
END;
 
 akarecs := NORMALIZE(inrecs,
                      IF(LEFT.AKA_Counts > 3,ERROR('THE NUMBER OF AKA RECORDS ARE OVER THE EXPECTED LIMIT OF 3'),LEFT.AKA_Counts),
											transAKA1(LEFT,COUNTER));
 
 //********* MO DL Mapping *****************************************************************************
 NID.Mac_CleanParsedNames(inrecs,cln_file,First_Name,Middle_Name,Last_Name,Suffix);
 
 cln_file2 := cln_file;

 Layouts_DL_MO_New_In.Layout_MO_with_Clean_MedCert mapClean(cln_file2 l) := TRANSFORM
   													 
   SELF.process_date          := IF(_Validate.Date.fIsValid(processDate),processDate,'');
	 SELF.Unique_Key            := trimUpper(l.Unique_Key);
	 SELF.License_Number        := trimUpper(l.Lic_Number);
	 SELF.Last_Name             := trimUpper(l.Last_Name);
	 SELF.First_Name            := trimUpper(l.First_Name);
	 SELF.Middle_Name           := trimUpper(l.Middle_Name);
	 SELF.Suffix                := trimUpper(l.Suffix);
	 SELF.Date_of_Birth         := IF(_Validate.Date.fIsValid(l.Birthdate) AND
	                                  _Validate.Date.fIsValid(l.Birthdate,_Validate.Date.Rules.DateInPast),l.Birthdate,'');
	 SELF.Gender                := trimUpper(l.Gender);
	 SELF.Address               := trimUpper(l.Address);
	 SELF.City                  := trimUpper(l.City);
	 SELF.State                 := trimUpper(l.State);
	 SELF.Zip5                  := IF((INTEGER)stringlib.stringfilter(l.Zip5,'0123456789')<>0,stringlib.stringfilter(l.Zip5,'0123456789'),''); 
	 SELF.Zip4                  := IF((INTEGER)stringlib.stringfilter(l.Zip4,'0123456789')<>0,stringlib.stringfilter(l.Zip4,'0123456789'),'');
	 SELF.Mailing_Address1      := trimUpper(l.Mailing_Address1);
	 SELF.Mailing_Address2      := trimUpper(l.Mailing_Address2);
	 SELF.Mailing_City          := trimUpper(l.Mailing_City);
	 SELF.Mailing_State         := trimUpper(l.Mailing_State);
	 SELF.Mailing_Zip           := trimUpper(l.Mailing_Zip);
	 SELF.Height                := IF((INTEGER)stringlib.stringfilter(l.Height,'0123456789')<>0,stringlib.stringfilter(l.Height,'0123456789'),'');
	 SELF.Weight                := IF((INTEGER)stringlib.stringfilter(l.Weight,'0123456789')<>0,stringlib.stringfilter(l.Weight,'0123456789'),'');
	 SELF.Eye_Color             := trimUpper(l.Eye_Color);
	 SELF.Operator_Status       := trimUpper(l.Operator_Status);
	 SELF.Commercial_Status     := trimUpper(l.Commercial_Status);
	 SELF.Sch_Bus_Status        := trimUpper(l.Sch_Bus_Status);
	 SELF.Pending_Act_Code      := trimUpper(l.Pending_Act_Code);
	 SELF.Must_Test_Ind         := trimUpper(l.Must_Test_Ind);
	 SELF.Deceased_Ind          := trimUpper(l.Deceased_Ind);
	 SELF.Prev_CDL_Class        := trimUpper(l.Prev_CDL_Class);
	 SELF.CDL_Ptr               := trimUpper(l.CDL_Ptr);
	 SELF.PDPS_Ptr              := trimUpper(l.PDPS_Ptr);
	 SELF.MVR_Privacy_Code      := trimUpper(l.MVR_Privacy_Code);
	 SELF.BRC_Status_Code       := trimUpper(l.BRC_Status_Code);
	 SELF.BRC_Status_Date       := trimUpper(l.BRC_Status_Date);
   SELF.Lic_Iss_Code          := trimUpper(l.Lic_Iss_Code);
	 SELF.License_Class         := trimUpper(l.Lic_Class);
	 SELF.Lic_Exp_Date          := IF(_Validate.Date.fIsValid(l.Lic_Exp_Date),l.Lic_Exp_Date,'');
	 SELF.Lic_Seq_Number        := trimUpper(l.Lic_Seq_Number);
	 SELF.Lic_Surrender_From    := trimUpper(l.Lic_Surrender_From);
	 SELF.Lic_Surrender_To      := trimUpper(l.Lic_Surrender_To);
	 SELF.New_Out_of_St_DL_Num  := trimUpper(l.New_Out_of_St_DL_Num);
	 SELF.License_Endorsements  := trimUpper(l.Lic_Endorsements);
	 SELF.License_Restrictions  := trimUpper(l.Lic_Restrictions);
	 SELF.License_Trans_Type    := trimUpper(l.Lic_Trans_Type);
	 SELF.Lic_Print_Date        := IF(_Validate.Date.fIsValid(l.Lic_Print_Date) AND
	                                  _Validate.Date.fIsValid(l.Lic_Print_Date,_Validate.Date.Rules.DateInPast),l.Lic_Print_Date,'');
	 SELF.Permit_Iss_Code       := trimUpper(l.Permit_Iss_Code);
	 SELF.Permit_Class          := trimUpper(l.Permit_Class);
	 SELF.Permit_Exp_Date       := IF(_Validate.Date.fIsValid(l.Permit_Exp_Date),l.Permit_Exp_Date,'');
	 SELF.Permit_Seq_Number     := trimUpper(l.Permit_Seq_Number);
	 SELF.Permit_Endorse_Codes  := trimUpper(l.Permit_Endorse_Codes);
	 SELF.Permit_Restric_Codes  := trimUpper(l.Permit_Restric_Codes);
	 SELF.Permit_Trans_Type     := trimUpper(l.Permit_Trans_Type);
	 SELF.Permit_Print_Date     := IF(_Validate.Date.fIsValid(l.Permit_Print_Date) AND
	                                  _Validate.Date.fIsValid(l.Permit_Print_Date,_Validate.Date.Rules.DateInPast),l.Permit_Print_Date,'');
	 SELF.Non_Driver_Code       := trimUpper(l.Non_Drvr_Code);
	 SELF.Non_Driver_Exp_Date   := IF(_Validate.Date.fIsValid(l.Non_Drvr_Exp_Date),l.Non_Drvr_Exp_Date,'');
	 SELF.Non_Driver_Seq_Num    := trimUpper(l.Non_Drvr_Seq_Num);
	 SELF.Non_Driver_Trans_Type := trimUpper(l.Non_Drvr_Trans_Type);
	 SELF.Non_Driver_Print_Date := IF(_Validate.Date.fIsValid(l.Non_Drvr_Print_Date) AND
	                                  _Validate.Date.fIsValid(l.Non_Drvr_Print_Date,_Validate.Date.Rules.DateInPast),l.Non_Drvr_Print_Date,'');
	 SELF.Action_Surrender_Date := IF(_Validate.Date.fIsValid(l.Action_Surrender_Date),l.Action_Surrender_Date,'');
	 SELF.Action_Counts         := IF((INTEGER)stringlib.stringfilter((STRING)l.Action_Counts,'0123456789')<>0,l.Action_Counts,0);
	 SELF.Driv_Priv_Counts      := IF((INTEGER)stringlib.stringfilter((STRING)l.Driv_Priv_Counts,'0123456789')<>0,l.Driv_Priv_Counts,0);
	 SELF.Conv_Counts           := IF((INTEGER)stringlib.stringfilter((STRING)l.Conv_Counts,'0123456789')<>0,l.Conv_Counts,0);
	 SELF.Accidents_Counts      := IF((INTEGER)stringlib.stringfilter((STRING)l.Accidents_Counts,'0123456789')<>0,l.Accidents_Counts,0);
	 SELF.AKA_Counts            := IF((INTEGER)stringlib.stringfilter((STRING)l.AKA_Counts,'0123456789')<>0,l.AKA_Counts,0);
	 SELF.title           		  := l.cln_title; 
	 SELF.fname           		  := l.cln_fname; 
	 SELF.mname           		  := l.cln_mname; 
	 SELF.lname           		  := l.cln_lname; 
	 SELF.name_suffix	 			    := l.cln_suffix; 
	 SELF                       := [];
 END;
 
 Cleaned_DL_MO_MedCert := PROJECT(cln_file2, mapClean(LEFT));
 
 dl_dist   := SORT(DISTRIBUTE(Cleaned_DL_MO_MedCert, HASH(unique_key)),unique_key,LOCAL);
 aka_dist  := SORT(DISTRIBUTE(akarecs, HASH(unique_key)),unique_key,LOCAL);
 
 Layouts_DL_MO_New_In.Layout_MO_with_Clean_MedCert joinDLNum(dl_dist l, aka_dist r) := TRANSFORM
  SELF.previous_dl_number   := IF(r.aka_lic_num   <> '' AND r.aka_lic_state <> '' AND r.aka_lic_state <> 'MO', TRIM(r.aka_lic_num, LEFT, RIGHT), '');
	SELF.previous_st          := IF(r.aka_lic_state <> '' AND r.aka_lic_state <> 'MO', TRIM(r.aka_lic_state, LEFT, RIGHT), '');
	SELF.old_dl_number        := IF(r.aka_lic_state = 'MO',TRIM(r.aka_lic_num, LEFT, RIGHT), '');
	SELF                      := l;
 END;

 jCleaned_MO_MedCert := JOIN(dl_dist, aka_dist(aka_lic_num <> '' OR aka_lic_state <> ''),
				  LEFT.unique_key = RIGHT.unique_key,
			 	  joinDLNum(LEFT, RIGHT),
				  LEFT OUTER,
				  LOCAL);
 
 //Gender = 'B' is filtered out because it is invalid.
 dCleaned_MO_MedCert  := DEDUP(SORT(jCleaned_MO_MedCert(Gender <> 'B'),unique_key));
												
 RETURN dCleaned_MO_MedCert;
END;