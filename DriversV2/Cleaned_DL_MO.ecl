IMPORT Drivers, Address, ut, NID, lib_stringlib, _Validate;

EXPORT Cleaned_DL_MO(STRING processDate, STRING fileDate) := FUNCTION
  
 in_file := DriversV2.File_DL_MO_RAW(fileDate);
 
 TrimUpper(STRING s):= FUNCTION
		RETURN TRIM(stringlib.StringToUppercase(s),LEFT,RIGHT);
 END;

 layout_out := DriversV2.Layouts_DL_MO_New_In.Layout_MO_Fixed;
	
 layout_out  trans1(in_file l) := TRANSFORM
	 SELF.Unique_Key           := l.Line[1..10];
	 SELF.Rec_Len              := l.Line[11..25];
	 SELF.Filler1              := l.Line[26..100];
	 //********* Basic Record          101-350   ****************
	 SELF.Lic_Number           := l.Line[101..110];             //  101 -  110
	 SELF.Last_Name            := l.Line[111..135];             //  111 -  135
	 SELF.First_Name           := l.Line[136..150];             //  136 -  150
	 SELF.Middle_Name          := l.Line[151..162];             //  151 -  162
	 SELF.Suffix               := l.Line[163..165];             //  163 -  165
	 SELF.Birthdate            := l.Line[166..173];             //  166 -  173
	 SELF.Gender               := l.Line[174..174];             //  174 -  174
	 SELF.Address              := l.Line[175..199];             //  175 -  199
	 SELF.City                 := l.Line[200..219];             //  200 -  219
	 SELF.State                := l.Line[220..221];             //  220 -  221
	 SELF.Zip5                 := l.Line[222..226];             //  222 -  226
	 SELF.Zip4                 := l.Line[227..230];             //  227 -  230
	 SELF.Mailing_Address1     := l.Line[231..255];             //  231 -  255
	 SELF.Mailing_Address2     := l.Line[256..280];             //  256 -  280
	 SELF.Mailing_City         := l.Line[281..300];             //  281 -  300
	 SELF.Mailing_State        := l.Line[301..302];             //  301 -  302
	 SELF.Mailing_Zip          := l.Line[303..311];             //  303 -  311
	 SELF.Height               := l.Line[312..314];             //  312 -  314
	 SELF.Weight               := l.Line[315..317];             //  315 -  317
	 SELF.Eye_Color            := l.Line[318..318];             //  318 -  318
	 SELF.Operator_Status      := l.Line[319..320];             //  319 -  320
	 SELF.Commercial_Status    := l.Line[321..322];             //  321 -  322
	 SELF.Sch_Bus_Status       := l.Line[323..324];             //  323 -  324
	 SELF.Pending_Act_Code     := l.Line[325..325];             //  325 -  325
	 SELF.Must_Test_Ind        := l.Line[326..326];             //  326 -  326
	 SELF.Deceased_Ind         := l.Line[327..327];             //  327 -  327 
	 SELF.Prev_CDL_Class       := l.Line[328..329];             //  328 -  329
	 SELF.CDL_Ptr              := l.Line[330..330];             //  330 -  330
	 SELF.PDPS_Ptr             := l.Line[331..331];             //  331 -  331
	 SELF.MVR_Privacy_Code     := l.Line[332..332];             //  332 -  332
	 SELF.BRC_Status_Code      := l.Line[333..333];             //  333 -  333
	 SELF.BRC_Status_Date      := l.Line[334..341];             //  334 -  341
	 SELF.Filler2              := l.Line[342..350];             //  342 -  350
	 //********* License Issuance Record          351 -  540   ****************
   SELF.Lic_Iss_Code         := l.Line[351..351];             //  351 -  351
	 SELF.Lic_Class            := l.Line[352..353];             //  352 -  353
	 SELF.Lic_Exp_Date         := l.Line[354..361];             //  354 -  361
	 SELF.Lic_Seq_Number       := l.Line[362..373];             //  362 -  373
	 SELF.Lic_Surrender_From   := l.Line[374..375];             //  374 -  375
	 SELF.Lic_Surrender_To     := l.Line[376..377];             //  376 -  377
	 SELF.New_Out_of_St_DL_Num := l.Line[378..402];             //  378 -  402
	 SELF.Lic_Endorsements     := l.Line[403..412];             //  403 -  412
	 SELF.Lic_Restrictions     := l.Line[413..417];             //  413 -  417
	 SELF.Filler3              := l.Line[418..422];             //  418 -  422
	 SELF.Lic_Trans_Type       := l.Line[423..424];             //  423 -  424
	 SELF.Lic_Print_Date       := l.Line[425..432];             //  425 -  432
	 SELF.Filler4              := l.Line[433..442];             //  433 -  442
	 SELF.Permit_Iss_Code      := l.Line[443..443];             //  443 -  443
	 SELF.Permit_Class         := l.Line[444..445];             //  444 -  445
	 SELF.Permit_Exp_Date      := l.Line[446..453];             //  446 -  453
	 SELF.Permit_Seq_Number    := l.Line[454..465];             //  454 -  465
	 SELF.Permit_Endorse_Codes := l.Line[466..475];             //  466 -  475
	 SELF.Permit_Restric_Codes := l.Line[476..480];             //  476 -  480
	 SELF.Filler5              := l.Line[481..485];             //  481 -  485
	 SELF.Permit_Trans_Type    := l.Line[486..487];             //  486 -  487
	 SELF.Permit_Print_Date    := l.Line[488..495];             //  488 -  495
	 SELF.Filler6              := l.Line[496..497];             //  496 -  497
	 SELF.Non_Drvr_Code        := l.Line[498..498];             //  498 -  498
	 SELF.Non_Drvr_Exp_Date    := l.Line[499..506];             //  499 -  506
	 SELF.Non_Drvr_Seq_Num     := l.Line[507..518];             //  507 -  518
	 SELF.Non_Drvr_Trans_Type  := l.Line[519..520];             //  519 -  520
	 SELF.Non_Drvr_Print_Date  := l.Line[521..528];             //  521 -  528
	 SELF.Filler7              := l.Line[529..540];             //  529 -  540
 	 //********* Other Records    ****************
	 SELF.Action_Surrender_Date:= l.Line[541..548];             //  541 -  548
	 SELF.Action_Counts        := (UNSIGNED4)l.Line[549..551];  //  549 -  551
	 SELF.Driv_Priv_Counts     := (UNSIGNED4)l.Line[552..554];  //  552 -  554
	 SELF.Conv_Counts          := (UNSIGNED4)l.Line[555..557];  //  555 -  557
	 SELF.Accidents_Counts     := (UNSIGNED4)l.Line[558..560];  //  558 -  560
	 SELF.AKA_Counts           := (UNSIGNED4)l.Line[561..563];  //  561 -  563
	 SELF.Filler8              := l.Line[564..569];             //  564 -  569
	 //********* Starting Position of the other records
   UNSIGNED4 Act_st := 570;
	 UNSIGNED4 Act_end:= Act_st + (SELF.Action_Counts * 120);	
	 UNSIGNED4 DP_st  := Act_end; 
	 UNSIGNED4 DP_end := DP_st + (SELF.Driv_Priv_Counts * 40);	 
	 UNSIGNED4 Con_st := DP_end;
	 UNSIGNED4 Con_end:= Con_st + (SELF.Conv_Counts * 110);	
	 UNSIGNED4 Acc_st := Con_end;
	 UNSIGNED4 Acc_end:= Acc_st +(SELF.Accidents_Counts * 50);	
	 UNSIGNED4 AKA_st := Acc_end;
	 UNSIGNED4 AKA_end:= AKA_st +(SELF.AKA_Counts * 100);
   SELF.Action_Recs    := IF(SELF.Action_Counts > 0, L.Line[Act_st..(Act_end - 1)],'');
	 SELF.Driv_Priv_Recs := IF(SELF.Driv_Priv_Counts > 0, L.Line[DP_st..(DP_end - 1)],'');
	 SELF.Convict_Recs   := IF(SELF.Conv_Counts > 0, L.Line[Con_st..(Con_end - 1)],'');
	 SELF.Accident_Recs  := IF(SELF.Accidents_Counts > 0, L.Line[Acc_st..(Acc_end - 1)],'');
	 SELF.AKA_Recs       := IF(SELF.AKA_Counts > 0, L.Line[AKA_st..(AKA_end - 1)],'');
 END;
 
 inrecs := PROJECT(in_file, trans1(left)) : PERSIST(DriversV2.Constants.cluster+'in::dl2::MO_fixed_update::'+ filedate);
	
 //********* AKA Records *****************************************************************************
 Layouts_DL_MO_New_In.Layout_MO_AKA transAKA1(inrecs l, UNSIGNED4 C) := TRANSFORM,SKIP(l.AKA_Recs = '')
	 SELF.Unique_Key    := trimUpper(l.Unique_Key);
	 SELF.AKA_Lic_State := trimUpper(CHOOSE(C,l.AKA_Recs[1..2], l.AKA_Recs[101..102],l.AKA_Recs[201..202]));
	 SELF.AKA_Lic_Num   := trimUpper(CHOOSE(C,l.AKA_Recs[3..27],l.AKA_Recs[103..127],l.AKA_Recs[203..227]));
	 SELF.AKA_LName     := trimUpper(CHOOSE(C,l.AKA_Recs[28..52],l.AKA_Recs[128..152],l.AKA_Recs[228..252]));
	 SELF.AKA_FName     := trimUpper(CHOOSE(C,l.AKA_Recs[53..67],l.AKA_Recs[153..167],l.AKA_Recs[253..267]));
	 SELF.AKA_MName     := trimUpper(CHOOSE(C,l.AKA_Recs[68..79],l.AKA_Recs[168..179],l.AKA_Recs[268..279]));  
	 SELF.AKA_Suffix    := trimUpper(CHOOSE(C,l.AKA_Recs[80..82],l.AKA_Recs[180..182],l.AKA_Recs[280..282]));
	 SELF.AKA_DOB       := lib_stringlib.stringlib.stringfilter(CHOOSE(C,l.AKA_Recs[83..90],l.AKA_Recs[183..190],l.AKA_Recs[283..290]),'0123456789');
	 SELF.AKA_Filler2   := trimUpper(CHOOSE(C,l.AKA_Recs[91..100],l.AKA_Recs[191..200],l.AKA_Recs[291..300]));
 END;
 
 akarecs := NORMALIZE(inrecs,
                      IF(LEFT.AKA_Counts > 3,ERROR('THE NUMBER OF AKA RECORDS ARE OVER THE EXPECTED LIMIT OF 3'),LEFT.AKA_Counts),
											transAKA1(LEFT,COUNTER));
 
 //********* MO DL Mapping *****************************************************************************
 NID.Mac_CleanParsedNames(inrecs,cln_file,First_Name,Middle_Name,Last_Name,Suffix);
 
 cln_file2 := cln_file;

 Layouts_DL_MO_New_In.Layout_MO_with_Clean mapClean(cln_file2 l) := TRANSFORM
   													 
   SELF.process_date          := IF(_Validate.Date.fIsValid(processDate),processDate,'');
	 SELF.Unique_Key            := trimUpper(l.Unique_Key);
	 SELF.Filler1               := trimUpper(l.Filler1);
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
	 SELF.Filler2               := trimUpper(l.Filler2);
	
	 SELF.Lic_Iss_Code          := trimUpper(l.Lic_Iss_Code);
	 SELF.License_Class         := trimUpper(l.Lic_Class);
	 SELF.Lic_Exp_Date          := IF(_Validate.Date.fIsValid(l.Lic_Exp_Date),l.Lic_Exp_Date,'');
	 SELF.Lic_Seq_Number        := trimUpper(l.Lic_Seq_Number);
	 SELF.Lic_Surrender_From    := trimUpper(l.Lic_Surrender_From);
	 SELF.Lic_Surrender_To      := trimUpper(l.Lic_Surrender_To);
	 SELF.New_Out_of_St_DL_Num  := trimUpper(l.New_Out_of_St_DL_Num);
	 SELF.License_Endorsements  := trimUpper(l.Lic_Endorsements);
	 SELF.License_Restrictions  := trimUpper(l.Lic_Restrictions);
	 SELF.Filler3               := trimUpper(l.Filler3);
	 SELF.License_Trans_Type    := trimUpper(l.Lic_Trans_Type);
	 SELF.Lic_Print_Date        := IF(_Validate.Date.fIsValid(l.Lic_Print_Date) AND
	                                  _Validate.Date.fIsValid(l.Lic_Print_Date,_Validate.Date.Rules.DateInPast),l.Lic_Print_Date,'');
	 SELF.Filler4               := trimUpper(l.Filler4);
	 SELF.Permit_Iss_Code       := trimUpper(l.Permit_Iss_Code);
	 SELF.Permit_Class          := trimUpper(l.Permit_Class);
	 SELF.Permit_Exp_Date       := IF(_Validate.Date.fIsValid(l.Permit_Exp_Date),l.Permit_Exp_Date,'');
	 SELF.Permit_Seq_Number     := trimUpper(l.Permit_Seq_Number);
	 SELF.Permit_Endorse_Codes  := trimUpper(l.Permit_Endorse_Codes);
	 SELF.Permit_Restric_Codes  := trimUpper(l.Permit_Restric_Codes);
	 SELF.Filler5               := trimUpper(l.Filler5);
	 SELF.Permit_Trans_Type     := trimUpper(l.Permit_Trans_Type);
	 SELF.Permit_Print_Date     := IF(_Validate.Date.fIsValid(l.Permit_Print_Date) AND
	                                  _Validate.Date.fIsValid(l.Permit_Print_Date,_Validate.Date.Rules.DateInPast),l.Permit_Print_Date,'');
	 SELF.Filler6               := trimUpper(l.Filler6);
	 SELF.Non_Driver_Code       := trimUpper(l.Non_Drvr_Code);
	 SELF.Non_Driver_Exp_Date   := IF(_Validate.Date.fIsValid(l.Non_Drvr_Exp_Date),l.Non_Drvr_Exp_Date,'');
	 SELF.Non_Driver_Seq_Num    := trimUpper(l.Non_Drvr_Seq_Num);
	 SELF.Non_Driver_Trans_Type := trimUpper(l.Non_Drvr_Trans_Type);
	 SELF.Non_Driver_Print_Date := IF(_Validate.Date.fIsValid(l.Non_Drvr_Print_Date) AND
	                                  _Validate.Date.fIsValid(l.Non_Drvr_Print_Date,_Validate.Date.Rules.DateInPast),l.Non_Drvr_Print_Date,'');
   SELF.Filler7               := trimUpper(l.Filler7);	
	 SELF.Action_Surrender_Date := IF(_Validate.Date.fIsValid(l.Action_Surrender_Date),l.Action_Surrender_Date,'');
	 SELF.Action_Counts         := IF((INTEGER)stringlib.stringfilter((STRING)l.Action_Counts,'0123456789')<>0,l.Action_Counts,0);
	 SELF.Driv_Priv_Counts      := IF((INTEGER)stringlib.stringfilter((STRING)l.Driv_Priv_Counts,'0123456789')<>0,l.Driv_Priv_Counts,0);
	 SELF.Conv_Counts           := IF((INTEGER)stringlib.stringfilter((STRING)l.Conv_Counts,'0123456789')<>0,l.Conv_Counts,0);
	 SELF.Accidents_Counts      := IF((INTEGER)stringlib.stringfilter((STRING)l.Accidents_Counts,'0123456789')<>0,l.Accidents_Counts,0);
	 SELF.AKA_Counts            := IF((INTEGER)stringlib.stringfilter((STRING)l.AKA_Counts,'0123456789')<>0,l.AKA_Counts,0);
	 SELF.Filler8               := trimUpper(l.Filler8);
	 SELF.title           		  := l.cln_title; 
	 SELF.fname           		  := l.cln_fname; 
	 SELF.mname           		  := l.cln_mname; 
	 SELF.lname           		  := l.cln_lname; 
	 SELF.name_suffix	 			    := l.cln_suffix; 
	 SELF                       := [];
 END;
 
 Cleaned_DL_MO := PROJECT(cln_file2, mapClean(LEFT));
 
 dl_dist   := SORT(DISTRIBUTE(Cleaned_DL_MO, HASH(unique_key)),unique_key,LOCAL);
 aka_dist  := SORT(DISTRIBUTE(akarecs, HASH(unique_key)),unique_key,LOCAL);
 
 Layouts_DL_MO_New_In.Layout_MO_with_Clean joinDLNum(dl_dist l, aka_dist r) := TRANSFORM
  SELF.previous_dl_number   := IF(r.aka_lic_num   <> '' AND r.aka_lic_state <> '' AND r.aka_lic_state <> 'MO', TRIM(r.aka_lic_num, LEFT, RIGHT), '');
	SELF.previous_st          := IF(r.aka_lic_state <> '' AND r.aka_lic_state <> 'MO', TRIM(r.aka_lic_state, LEFT, RIGHT), '');
	SELF.old_dl_number        := IF(r.aka_lic_state = 'MO',TRIM(r.aka_lic_num, LEFT, RIGHT), '');
	SELF                      := l;
 END;

 jCleaned_MO := JOIN(dl_dist, aka_dist(aka_lic_num <> '' OR aka_lic_state <> ''),
				  LEFT.unique_key = RIGHT.unique_key,
			 	  joinDLNum(LEFT, RIGHT),
				  LEFT OUTER,
				  LOCAL);
 
 //Gender = 'B' is filtered out because it is invalid.
 dCleaned_MO  := DEDUP(SORT(jCleaned_MO(Gender <> 'B'),unique_key));
												
 RETURN dCleaned_MO;
END;