IMPORT Address, Ut, lib_stringlib, _Control, business_header,_Validate, idl_header,std;

EXPORT StandardizeInputFile := module

	EXPORT fPreProcess(DATASET(Workers_Compensation.Layouts.Input) pRawFileInput, string pversion) := FUNCTION    

		generateEffDate(string MonthDay) := function
			FileYear := pversion[1..4];
			FileMonthDay:= pversion[5..8];
			EffMonthDay := (string) MonthDay[1..2] + (string) MonthDay[4..5];
			PriorYear   := (integer) FileYear-1;
			EffYear     := if ( (integer) FileMonthDay >= (integer) EffMonthDay
													,FileYear
													,(string) PriorYear );
			EffDate			:= if ( EffMonthDay = ''
												  ,''
													,(string) EffYear + EffMonthDay );
			
			return (string) EffDate;
		end;		
	
		Workers_Compensation.Layouts.Temp_FULL	trfWrkCompFile(Workers_Compensation.Layouts.input L)	:=	TRANSFORM	
				SELF.Business_Name := StringLib.StringToUpperCase(l.Business_Name);
				SELF.address := StringLib.StringToUpperCase(l.address);
				SELF.city := StringLib.StringToUpperCase(l.city);
				SELF.state := if ( StringLib.StringToUpperCase(l.state) in 
											    	['AA','AB','AE','AK','AL','AP','AR','AS','AZ','BC',
														 'CA','CO','CT','DC','DE','FL','FM','GA','GU','HI',
														 'IA','ID','IL','IN','KS','KY','LA','MA','MB','MD',
														 'ME','MH','MI','MN','MO','MP','MS','MT','NB','NC',
														 'ND','NE ','NH','NJ','NL','NM','NS','NT','NU','NV',
														 'NY','OH','OK','ON','OR','PA','PE','PR','PW','QC',
														 'RI','SC','SD','SK','TN','TX','UT','VA','VI','VT',
														 'WA','WI','WV','WY','YT'], 
												   StringLib.StringToUpperCase(l.state), '' );
				SELF.zip := if (l.zip[1..1] in ['0','1','2','3','4','5','6','7','8','9'] and
												l.zip[2..2] in ['0','1','2','3','4','5','6','7','8','9'] and
												l.zip[3..3] in ['0','1','2','3','4','5','6','7','8','9'] and
												l.zip[4..4] in ['0','1','2','3','4','5','6','7','8','9'] and
												l.zip[5..5] in ['0','1','2','3','4','5','6','7','8','9'] and 
												(unsigned4)l.zip <> 0,l.zip, '');
												
				SELF.zipplus4 := if (l.zipplus4[1..1] in ['0','1','2','3','4','5','6','7','8','9'] and
											 	     l.zipplus4[2..2] in ['0','1','2','3','4','5','6','7','8','9'] and
											     	 l.zipplus4[3..3] in ['0','1','2','3','4','5','6','7','8','9'] and
												     l.zipplus4[4..4] in ['0','1','2','3','4','5','6','7','8','9'] and
														(unsigned4)l.zipplus4 <> 0 ,  l.zipplus4, '');
														
				SELF.Effective_Month_Day := StringLib.StringToUpperCase(l.Effective_Month_Day);										 
				SELF.Carrier_NAIC_Name := StringLib.StringToUpperCase(l.Carrier_NAIC_Name);
				SELF.Group_NAIC_NAME := StringLib.StringToUpperCase(l.Group_NAIC_NAME);
				SELF.Policy_Eff_Date := IF(l.Policy_Eff_Date = '', generateEffDate(l.Effective_Month_Day),stringlib.stringfilter(l.Policy_Eff_Date, '0123456789'));	
				SELF.FEIN	:= IF (L.FEIN = '000000001','',L.FEIN);
				SELF  :=	L;
				SELF	:=	[];
		END;
		
		dPreProcess		:=	PROJECT(pRawFileInput, trfWrkCompFile(left));
		RETURN dPreProcess;
	END;
		
	EXPORT fStandardizeAddresses(DATASET(Workers_Compensation.Layouts.Temp_FULL) pStandardizeNameInput, string pversion) := FUNCTION
		
		Workers_Compensation.Layouts.temp_Full tPROJECTAddress(Workers_Compensation.Layouts.Temp_FULL l) := TRANSFORM
			SELF.Append_MailAddress1		:=  StringLib.StringCleanSpaces(TRIM(L.Address));
			SELF.Append_MailAddressLast	:= 	IF (L.City!='',
																					StringLib.StringCleanSpaces(TRIM(L.City) + ', ' + TRIM(L.State) + ' ' + TRIM(L.Zip[1..5])),
			  																	StringLib.StringCleanSpaces(TRIM(L.State) + ' ' + TRIM(L.Zip[1..5])) ); 
			SELF												:= 	L;
		END;
      
		dAddressPrep   := PROJECT(pStandardizeNameInput, tPROJECTAddress(left));
      
		RETURN dAddressPrep;
  END;

	EXPORT fAll( DATASET(Workers_Compensation.Layouts.Input)  pRawFileInput, string pversion) := FUNCTION
   	
		dPreprocess1	 := fPreProcess (pRawFileInput,pversion);
		dPreProcess    := dPreprocess1(Unique_ID <> 'UniqueID');
     		 
		#IF(_flags.UseStandardizePersists)
			dAppendBusinessInfo  := fStandardizeAddresses	(dPreprocess, pversion) : persist(Persistnames.standardizeInput);
		#else
			dAppendBusinessInfo  := fStandardizeAddresses	(dPreprocess, pversion);
		#end

		RETURN dAppendBusinessInfo;
	  	
	END;
		
END;
