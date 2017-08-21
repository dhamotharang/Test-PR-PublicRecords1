// TNS0513 / Tennessee Reg Board and Commission Commerce & Ins / Multiple Professions //


export layout_TNS0513 := MODULE

export raw 
			:= 
				RECORD
					string  Pro_Code;     //new 
					string  SLNUM;
					string  ORG_NAME;
					string  CONTACT;   //Attention
					string  ADDRESS1_1;
					string  ADDRESS2_1;
					string  CITY_1;
					string  STATE_1;
					string  ZIP;
					string  Area_Code;		//new
					string	Phone;				//new
					string  Email;				//new
					string 	County;				//new
					string  Original_Date;	//new
					string  EXPDT;
					string  Status_Desc;
					string  RANK1; 
					
// (FM)   FIRM
// (LREA) LICENSE REAL ESTATE APPRAISER
// (CGAP) CERTIFIED GENERAL REAL ESTATE APPRAISER
// (CRAP) CERTIFIED RESIDENTIAL REAL ESTATE APPRISER
// (AF)   AFFILIATED BROKER
// (PB)   PRINCIPAL BROKER
// (TS)   TIME SHARE SALERSPERSON
// (BR) 	REAL ESTATE BOKER
// (TRN)	REGISTERED TRAINEE
// (AAL)	ACQUISITION AGENT
// (AA) 	ACQUISITION AGENT
// (TN)		Need research
// (APPL)	UNAPPROVED INITIAL
					
			END;


	export src 	:=	RECORD
					raw;     
					string8  ln_filedate;
		end;
end;		