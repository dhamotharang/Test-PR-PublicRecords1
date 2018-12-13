/* ************************************************************************************************************
/* ************************************************************************************************************
PRTE2_Liens_Ins_DataPrep.Layouts

************************************************************************************************************ */
IMPORT PRTE2_Liens_Ins_DataPrep, PRTE2_Liens_Ins, PRTE2_X_Ins_DataCleanse;

EXPORT Layouts := MODULE

			EXPORT IHDR_DL_Death := PRTE2_X_Ins_DataCleanse.Layouts_Alpha.IHDR_DL_Death;
			EXPORT IHDR_DL_Death_Joinable := RECORD
					unsigned JoinInt := 0;
					STRING used := '';
					STRING Bocahit := '';
					IHDR_DL_Death;
			END;
					
			EXPORT BaseMain_in_raw := PRTE2_Liens_Ins.Layouts.BaseMain_in_raw;		
			EXPORT Baseparty_in := PRTE2_Liens_Ins.Layouts.Baseparty_in;
			EXPORT Boca_main_base 	:= PRTE2_Liens_Ins.Layouts.Boca_main_base;
			EXPORT Boca_party_base 	:= PRTE2_Liens_Ins.Layouts.Boca_party_base;
			EXPORT BaseMainInJoin := RECORD
					unsigned JoinInt := 0;
					STRING used := '';
					BaseMain_in_raw;
			END;
			EXPORT BaseMainRenumberJoin := RECORD
					unsigned JoinInt := 0;
					STRING used := '';
					STRING ExJoinInt1 := '';
					BaseMain_in_raw;
			END;
			EXPORT BaseMainCrossReportJoin := RECORD
					unsigned JoinInt := 0;
					unsigned PJoinInt := 0;		// joinint
					STRING12 PDID := '';				// did
					STRING PSSN		:= '';			// NNS
					STRING2 POState := '';			// orig_state
					STRING PSt		 := '';			// st in cleanaddress
					STRING PName := '';				// orig_name
					STRING RecType_LJ := '';			// lookup in L & J Sets
					STRING ExJoinInt1 := '';
					BaseMain_in_raw;
					STRING12 did;
					STRING12 ssn;
					string20 fname;
					string20 mname;
					string20 lname;
					string5 name_suffix;
					string orig_address1;
					string orig_city;
					string orig_state;
					string orig_zip5;
			END;
			EXPORT BasePartyInJoin := RECORD
					unsigned JoinInt := 0;
					STRING used := '';
					Baseparty_in;
			END;
			EXPORT BasePartyExtraJoin := RECORD
					unsigned ExJoinInt := 0;
					BasePartyInJoin;
			END;
			EXPORT BasePartyBocaHit := RECORD
					STRING Bocahit :='';
					BasePartyExtraJoin;
			END;
			EXPORT BasePartyReportLayout := RECORD
					string12 did;
					string9 ssn;
					string20 fname;
					string20 mname;
					string20 lname;
					string5 name_suffix;
					string orig_address1;
					string orig_city;
					string orig_state;
					string orig_zip5;
					unsigned Judgmts := 0;
					unsigned Liens := 0;
					unsigned GroupCount := 0;
			END;
			EXPORT BasePartyWIPLayout := RECORD
					string recTypeSrc;
					STRING12 DID :='';
					STRING2	STATE :='';
					unsigned Judgmts;
					unsigned Liens;
					unsigned GroupCount;
			END;
			

// ********* The following were just "temp" files spraying in 50k records and selecting random 10/state ********* 
			EXPORT Spray_TU_Layout := RECORD
						STRING LAST_NAME;
						STRING FIRST_NAME;
						STRING MIDDLE_NAME;
						STRING SUFFIX;
						STRING PREFIX;
						STRING ALIAS_NAME;
						STRING SSN;
						STRING HOUSE_num;
						STRING DIRECTION;
						STRING STREET_NAME;
						STRING STREET_TYPE;
						STRING UNIT;
						STRING CITY;
						STRING STATE;
						STRING ZIP;
						STRING Num_ACCOUNTS;
						STRING Num_REVOLVING_ACCOUNTS;
						STRING Num_INSTALLMENT ;
						STRING Num_MORTGAGE_ACCOUNTS;
						STRING Num_OPEN_ACCOUNTS;
						STRING Num_INQUIRIES;
						STRING Num_PUBLIC_RECORDS;
						STRING Num_COLLECTIONS;
						STRING FICO_1998;
						STRING FICO_2004;
						STRING FICO_2008;
						STRING FICO_BNKR;
						STRING FICO_NEXTGEN;
						STRING FICO_SG_2_0;
						STRING TU_IRS_AP;
						STRING VANTAGE;
			END;
			EXPORT New_TU_Layout := RECORD
					unsigned JoinInt := 0;
					STRING used := '';
					STRING LAST_NAME;
					STRING FIRST_NAME;
					STRING MIDDLE_NAME;
					STRING SUFFIX;
					STRING PREFIX;
					STRING ALIAS_NAME;
					STRING SSN;
					STRING HOUSE_num;
					STRING DIRECTION;
					STRING STREET_NAME;
					STRING STREET_TYPE;
					STRING UNIT;
					STRING AddressLine1;
					STRING CITY;
					STRING STATE;
					STRING ZIP;
					STRING Num_ACCOUNTS;
					STRING Num_REVOLVING_ACCOUNTS;
					STRING Num_INSTALLMENT ;
					STRING Num_MORTGAGE_ACCOUNTS;
					STRING Num_OPEN_ACCOUNTS;
					STRING Num_INQUIRIES;
					STRING Num_PUBLIC_RECORDS;
					STRING Num_COLLECTIONS;
					STRING FICO_1998;
					STRING FICO_2004;
					STRING FICO_2008;
					STRING FICO_BNKR;
					STRING FICO_NEXTGEN;
					STRING FICO_SG_2_0;
					STRING TU_IRS_AP;
					STRING VANTAGE;
			END;

			EXPORT spray_EQ_Layout := RECORD
						STRING Hit_No_Hit;
						STRING First_Name;
						STRING Middle_Name;
						STRING Last_Name;
						STRING Suffix;
						STRING SSN;
						STRING DOB_AGE;
						STRING Street_Number;
						STRING Street_Name;
						STRING Street_Suffix;
						STRING City;
						STRING State;
						STRING ZIP;
			END;
			EXPORT New_EQ_Layout := RECORD
					unsigned JoinInt := 0;
					STRING used := '';
					STRING Hit_No_Hit;
					STRING First_Name;
					STRING Middle_Name;
					STRING Last_Name;
					STRING Suffix;
					STRING SSN;
					STRING DOB_AGE;
					STRING Street_Number;
					STRING Street_Name;
					STRING Street_Suffix;
					STRING AddressLine1;
					STRING City;
					STRING State;
					STRING ZIP;
			END;


END;