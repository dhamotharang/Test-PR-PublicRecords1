Import Address;
EXPORT Layouts := MODULE

	export rawNameInput := record
		string20	 	acctno := '';
		String100 	nameFull := '';
		boolean			isLFM := false;
		string10		namePrefix := '';
		string50		nameFirst := '';
		string50		nameMiddle := '';
		string50		nameLast := '';
		string10		nameSuffix := '';
		string15		nameProfessionalSuffix := '';
	end;
	export prenameResult := record
		String50 	preName := '';
		String150 remainingName := '';
	end;
	export workRec := record
		String150 	rawInput := '';
		string20		preName := '';
		boolean			hasPreName := false;
		string100		namePart := '';
		boolean			namePartAddSpace := false;
		boolean			namePartEqualsWorkstring := false;
		string50		workstring := '';
		string50		profSuffix := '';
	end;
	export splitRec := record
			string 	word := '';
	end;		
	export splitRec2 := record
			unsigned1	loc := 0;
			string 	word := '';
			string 	origword := '';
			boolean hasComma := false;
	end;		
	export cleanNameOutput := record
		string20	 	acctno := '';
		String100 	rawNameFull := '';
		boolean			rawIsLFM := false;
		string10		rawNamePrefix := '';
		string50		rawNameFirst := '';
		string50		rawNameMiddle := '';
		string50		rawNameLast := '';
		string10		rawNameSuffix := '';
		string15		rawNameProfessionalSuffix := '';
		Address.Layout_Clean_Name_Enclarity;
	end;

	export rawAddressInput := record
		string20	 	acctno := '';
		String100 	addressLine1 := '';
		String100 	addressLine2 := '';
		string10  	prim_range := '';
		string2   	predir := '';
		string28  	prim_name := '';
		string4   	addr_suffix := '';
		string2   	postdir := '';
		string10  	unit_desig := '';
		string8   	sec_range := '';
		string25  	p_city_name := '';
		string2   	st := '';
		string5   	z5 := '';
	end;
	export cleanAddressOutput := record
		string20	 	acctno := '';
		String100 	rawAddressLine1 := '';
		String100 	rawAddressLine2 := '';
		string10  	rawPrim_range := '';
		string2   	rawPredir := '';
		string28  	rawPrim_name := '';
		string4   	rawAddr_suffix := '';
		string2   	rawPostdir := '';
		string10  	rawUnit_desig := '';
		string8   	rawSec_range := '';
		string25  	rawP_city_name := '';
		string2   	rawSt := '';
		string5   	rawZ5 := '';
		Address.Layout_Clean_Addr_Enclarity;
		string1   	err_type;
		string4   	err_code;
		string4   	warn_code;
		boolean			cleanfailure;
		//HRI | delimited collection up to 5 HRI
		string45 		sic_code := '';        
		string405		sic_code_desc := '';           
		string10 		addr_fraud_alert_flag := '';      
		string405 	addr_fraud_alert_description := '';
		boolean			correctionalfacility := false;
		//ADVO
		string4			Route_Num :=''; //Carrier Route for this address
		string9			WALK_Sequence	:='';//Walk Sequence number The walk sequence will have a maximum number of 9 digits but will not consistently be 9 digits.
		string1			Address_Vacancy_Indicator	:='';//Indicator of Y=vacancy and N = active delivery.
		string1			Throw_Back_Indicator :='';//Indicator of Y= yes, it is a throwback or N = no, it is not a throwback and it is an active delivery.
		string1			Seasonal_Delivery_Indicator :='';//Indicator of Y=seasonal delivery, N=not a seasonal delivery, and E = educational identifier.
		string5			Seasonal_Start_Suppression_Date :='';
		string5			Seasonal_End_Suppression_Date :='';
		string1			DND_Indicator :='';//This will be an indicator Y for YES or N for NO that the address has been flagged as a DND - DO NOT DELIVER
		string1			College_Indicator :='';//This will be an indicator Y for YES or N for NO that the address has been flagged as a COLLEGE
		string10		College_Start_Suppression_Date :='';
		string10		College_End_Suppression_Date :='';
		//Address_Style_Flag = Identifies the address as City Style (C) or Simplified (S). City style (C) addressing requires that there is a specific street address including street numbers or specific post office box number.  Simplified addressing (S) is an address method used for rural deliveries.  Simplified addresses are those which do not contain a specific street address. Renamed from city rural flag
		string1			Address_Style_Flag :='';
		string5			Simplify_Address_Count :='';//Will supply a count for a simplified rural routes only. Renamed from box count
		/* Drop indicator - This is renamed from  Address Status 2. There are Four valid values for this field; 
				C - This address is a CMRA (Commercial Mail Receiving Agency)
				Y - This address is part of a drop delivery
				N - This address is neither a CMRA, Drop Stop or Simplified
				Blank - Simplified Carrier Route  (see field, Addres Style Flag)
		*/
		string1			Drop_Indicator :='';
		/* Residential_or_Business_Ind - The DPT codes are A=Residential, B=Business and G=General Delivery. 
					A (Residential) = A - Residential Curb , 
					B (Business) = I - Business CURB , 
					C (Primary Residential with Business) = D - Residential Other , 
					D (Primary Business with Residential) = L - Business Other , 
					NULL (no data) = Q - general 
					The DEL_TYPE_CODE should have the following codes: A,D,I,L,Q. , Code change pushed to production 3/26/08. 		*/
		string1			Residential_or_Business_Ind :='';
		string3			County_Num :='';
		string28		County_Name :='';
		string2			Congressional_District_Number :='';
		string1			OWGM_Indicator :='';//Only Way to Get Mail - These are critical post office boxes where the consumer residing in the town can only receive residential delivery via Post Office Boxes.  
		/* Record_Type_Code - An alphabetic value that identifies the type of delivery point
				F = Firm
				G = General
				H = Highrise
				P = PO Box
				R = Rural Route
				S = Street
		*/
		string1			Record_Type_Code :='';
		/* Address_Type - 
				0=Undefined or Business
				1=SFDU Single Family
				2=MFDU Multi Family
				9=PO Box
		*/
		string1			Address_Type :='';
		string1			Mixed_Address_Usage :='';//The DPT codes are C=Primarily Residential with Business, D=Primarily Business with Residential or U=Unassigned
		string8  		Vac_BegDT :='';
		string8  		Vac_EndDT :='';
		string8  		Months_Vac_Curr :='';
		string8  		Months_Vac_Max :='';                
		string8  		Vac_Count :='';
		string5			CBSA:='';
	end;
End;