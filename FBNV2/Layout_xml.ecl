EXPORT Layout_xml := 
  module
  
   EXPORT InfoUSA := RECORD
		STRING46  CiteId ;	
		STRING50  DBAName ;	
		STRING48  BusinessDesc  ; 	
		STRING6   SIC ;
		STRING8   FilingDate ; 
		STRING5   FileId ;	
		STRING8   DateLastTrans ;	
		STRING10  Telephone ;	 
		STRING30  county;
		STRING6   FileCode;
		STRING60  Busaddress;	
		STRING28  BusCity;	
		STRING2   BusState;	
		STRING10  BusZIP;
		STRING60  CTaddress;	
		STRING34  CTCity;	
		STRING2   CTState;	
		STRING5   CTZIP;
		STRING10  CTPhone; 
		STRING10  filingtype;
		STRING40  CTLN;
		STRING40  CTGN;
		STRING10  CTSF;
		STRING182 clean_address;
		STRING182 clean_CT_address;
		STRING73  pName;
	END ;
	
    EXPORT CAO := RECORD
		STRING52  CiteId ;	
	    STRING192 DBAName ;	
	    STRING12  FilingNumber ;
	    STRING8   FilingDate ; 
	    STRING6   FileId ;	
	    STRING8   DateLastTrans ;	
	    STRING10  Telephone ;
	    STRING80  Busaddress;	
	    STRING28  BusCity;	
	    STRING2   BusState;	
	    STRING10  BusZIP;  
	    STRING77  Ownerflname;
	    STRING20  OwnerGN;
	    STRING56  OwnerLN;
	    STRING36  OwnerMN;
	    STRING1   OwnerMI;
	    STRING50  Owneraddress;	
	    STRING30  OwnerCity;	
	    STRING2   OwnerState;	
	    STRING5   OwnerZIP;	
	    STRING182  clean_address;
	    STRING182  clean_Owner_address;		
	    STRING73   pname;	
	END;
		
 	EXPORT CSC:=record
		STRING8    Abandon_Date ;
		STRING12   AbandFileNo ;
		STRING192  DBAName ;
		STRING52   OtherName;
		STRING8    FilingDate ;
		STRING12   FileId ;
		STRING12   FilingNumber ;
		STRING9    Status ;
		STRING8    DateLastTrans ;
		STRING8    FilingdateH    ;
		STRING61   FiletypeH      ;
		STRING11   AME;   
		STRING8    OwnerWDD;
		STRING8    OwnerFND;
		STRING14   Filler;
		STRING12   OwnerAF;
		STRING69   Ownerflname;
		STRING83   Busaddress;
		STRING28   BusCity;
		STRING2    BusState;
		STRING9    BusZIP;
		STRING182  clean_address;
		STRING73   pname;
	END;

	EXPORT TXD:=RECORD
		STRING600 DBAName ;
		STRING8   FilingDate ;
		STRING12  FileId ;	
		STRING12  FilingNumber ;
		STRING8   DateLastTrans ; 	
		STRING15  FilingType; 
		STRING69  Ownerflname;
		STRING150 OwnerAF ;
		STRING73  Owneraddress;	
		STRING28  OwnerCity;	
		STRING2   OwnerState;	
		STRING9   OwnerZIP; 	
		STRING32  ownerCounty      ;
		STRING73  Busaddress;	
		STRING28  BusCity;	
		STRING2   BusState;	
		STRING9   BusZIP;	
		STRING12  BusCounty;	
		STRING182 clean_address;	
		STRING182 clean_own_addres; 
		STRING73  pname;
	 END;
	
	 EXPORT CAB:=record
		STRING8 	date_last_trans;	   
		STRING861 bus_name;
		STRING8	filing_date;
		STRING12 	filing_number;
		STRING6 	Jurisdiction;
		STRING80 	bus_address;
		STRING28 	bus_CITY;
		STRING2 	BUS_STATE;
		STRING9 	BUS_ZIP;
		STRING20 	filing_type;
		STRING10 	BUS_phone; 
		STRING57  owner_fl_name;
		STRING55 	owner_last_name;	
		STRING55 	owner_first_name;	
		STRING80 	owner_address;	
		STRING28 	owner_CITY;	
		STRING2 	owner_STATE;	
		STRING9 	owner_ZIP;	
		STRING73 	clean_name;	
		STRING182 clean_address;
		STRING182 clean_ow_address;
	END;
	
	
	EXPORT CAV   :=RECORD, maxlength(5024000)
		STRING8    Abandon_Date ;	
		STRING8    BusCommDate ;
		STRING192  DBAName ;		
		STRING8    ExpirationDate ;	
		STRING8    FilingDate ;
		STRING12   FileId ;	
		STRING16   FilingNumber ;
		STRING8    DateLastTrans ;
		STRING8    OwnerAOD;	
		STRING8    OwnerWDD;	
		STRING69   Ownerflname;	
		STRING40   Ownerlastname;	
		STRING30   Ownerfirstname;	
		STRING71   Owneraddress;	
		STRING28   OwnerCity;	
		STRING2    OwnerState;	
		STRING9    OwnerZIP;
		STRING22   ownerMname  ;	
		STRING9    ownerMI        ;	
		STRING7    ownerNameType   ; 	
		STRING6    ownerNameSuffix;	
		STRING83   Busaddress;	
		STRING28   BusCity;	
		STRING2    BusState;	
		STRING9    BusZIP;	
		STRING83   Maddress;	
		STRING28   MCity;	
		STRING2    MState;	
		STRING9    MZIP;	
		STRING182  Clean_address;
		STRING182  clean_owner_address;	
		STRING182  clean_Maddress;	 
		STRING73   pname;
	END;

	EXPORT CAS:=record
		STRING8   Abandon_Date;
		STRING12  AbandFileNo;
		STRING192 DBAName;
		STRING8   FilingDate;
		STRING12  FileId;
		STRING12  FilingNumber;
		STRING9   Status;
		STRING8   DateLastTrans;
		STRING8   OwnerWDD ;
		STRING69  Ownerflname ;
		STRING73  pname ;
		STRING15  filler;
		STRING13  OwnerAF ;
	 END;
	 
 	EXPORT FL    :=record
	
	    string8    LastTransDate;
		string192  DBAName ;		
		string8    ExpirationDate ;	
		string8    FilingDate ;	
		string9    FEIN ;	
		string12   FileId ;	
		string12   FilingNumber ;	
		string8    InactiveDate ;	
		string30   IncorpState ;	
		string9    Status ;	
		string8    DateLastTrans ;	
		string30   county;
		string8    FilingdateH     ;	
		string61   FiletypeH      ;	
		string200  comments        ;	
		string12   doNH            ; 
		string47   OwnerAF;
		string69   Ownerflname;	
		string30   Ownerlastname;	
		string30   Ownerfirstname;	
		string40   Owneraddress1;
		string40   Owneraddress2;	
		string28   OwnerCity;	
		string2    OwnerState;	
		string9    OwnerZIP;	
		string22   ownerMname ;	
		string9    ownerMI       ;	
		string7    ownerNameType  ;	
		string32   ownerCounty     ;     
		string3    ownerNameSuffix;	
		string40   Busaddress1;
		string40   Busaddress2;	
		string28   BusCity;	
		string2    BusState;	
		string9    BusZIP;		
		string32   BusCounty;
		string40   oldBusADDRess1                  ;
		string28   oldBusCITY                   ;
		string2    oldBusSTATE                  ;
		string5    oldBusZIP5                   ;
		string4    oldBusZIP4                   ;
		string9    ACTION_NEW_FEI                    ;
		string40   ACTION_NEW_ADDR1                  ;
		string28   ACTION_NEW_CITY                   ;
		string2    ACTION_NEW_STATE                  ;
		string5    ACTION_NEW_ZIP5                   ;
		string4    ACTION_NEW_ZIP4                    ;
		string70   ACTION_NEW_OWN_NAME               ;
		string9    ACTION_OWN_FEI                    ;
		string12   ACTION_OWN_CHARTER_NUMBER         ;
		string73   pNewname;
		string73   pname;	
		string182  clean_oldBusaddress          ;
		string182  clean_action_new_address          ;
		string182  clean_action_owner_address        ;
		string182  clean_address;	
	  
		/*string192  DBAName ;		
		string8    ExpirationDate ;	
		string8    FilingDate ;	
		string9    FEIN ;	
		string12   FileId ;	
		string12   FilingNumber ;	
		string8    InactiveDate ;	
		string30   IncorpState ;	
		string9    Status ;	
		string8    DateLastTrans ;	
		string30   county;
		string8    FilingdateH     ;	
		string61   FiletypeH       ;	
		string200  comments        ;	
		string12   doNH             ; 
		string47   OwnerAF;
		string69   Ownerflname;	
		string30   Ownerlastname;	
		string30   Ownerfirstname;	
		string71   Owneraddress;	
		string28   OwnerCity;	
		string2    OwnerState;	
		string9    OwnerZIP;	
		string22   ownerMname  ;	
		string9    ownerMI        ;	
		string7    ownerNameType   ;	
		string32   ownerCounty      ; 	
		string3    ownerNameSuffix;	
		string83   Busaddress;	
		string28   BusCity;	
		string2    BusState;	
		string9    BusZIP;		
		string32   BusCounty;	
		string182  clean_address;	
		string182  clean_own_addres;	
		string73   pname;*/
    END;
	EXPORT FLE    :=record
		string12 	EVENT_DOC_NUMBER                   ;
		string12 	EVENT_ORIG_DOC_NUMBER              ;
		string192 	EVENT_FIC_NAME                     ;
		string8 	EVENT_DATE                         ;
		string25 	ACTION_VERBAGE                     ;
		string40 	oldBusADDR1                   ;
		string28 	oldBusCITY                    ;
		string2 	oldBusSTATE                   ;
		string5 	oldBusZIP5                    ;
		string4 	oldBusZIP4                    ;
		string9 	ACTION_NEW_FEI                     ;
		string40 	ACTION_NEW_ADDR1                   ;
		string28 	ACTION_NEW_CITY                    ;
		string2 	ACTION_NEW_STATE                   ;
		string5 	ACTION_NEW_ZIP5                    ;
		string4 	ACTION_NEW_ZIP4                     ;
		string55 	ACTION_OWN_NAME                    ;
		string40 	ACTION_OWN_ADDRESS                 ;
		string28 	ACTION_OWN_CITY                    ;
		string2 	ACTION_OWN_STATE                   ;
		string5 	ACTION_OWN_ZIP5                    ;
		string9 	ACTION_OWN_FEI                     ;
		string12 	ACTION_OWN_CHARTER_NUMBER          ;
		string73  	pname;
		string70  	cname;
		string182 	clean_oldBusaddress           ;
		string182 	clean_action_new_address           ;
		string182 	clean_action_owner_address         ;
    END;
	EXPORT FLF   :=record
	  STRING8   DateLastTrans;
      STRING12	FIC_FIL_DOC_NUM 		  ;
      STRING192	FIC_FIL_NAME  			  ;
      STRING12	FIC_FIL_COUNTY                    ;
      STRING40	FIC_FIL_ADDR1                     ;
      STRING40	FIC_FIL_ADDR2                     ;
      STRING28	FIC_FIL_CITY                      ;
      STRING2	FIC_FIL_STATE                     ;
      STRING5	FIC_FIL_ZIP5                      ;
      STRING4   FIC_FIL_ZIP4                      ;
      STRING8	FIC_FIL_DATE                      ;
      STRING9	FIC_FIL_STATUS_DEC                ;
      STRING8	FIC_FIL_CANCELLATION_DATE         ;
      STRING8	FIC_FIL_EXPIRATION_DATE           ;
      STRING14	FIC_FIL_FEI_NUM                   ;
      STRING12	FIC_OWNER_DOC_NUM             	  ;
      STRING55	FIC_OWNER_NAME                 	  ;
      STRING1	FIC_OWNER_NAME_FORMAT          	  ;
      STRING40	FIC_OWNER_ADDR1                	  ;
      STRING40	FIC_OWNER_ADDR2                	  ;
      STRING28	FIC_OWNER_CITY                 	  ;
      STRING2	FIC_OWNER_STATE                   ;
      STRING5	FIC_OWNER_ZIP5                    ;
      STRING4   FIC_OWNER_ZIP4                    ;
      STRING9	FIC_OWNER_FEI_NUM                 ;
      STRING12	FIC_OWNER_CHARTER_NUM             ;
      STRING182 clean_fic_owner_addr              ;
      STRING73  p_owner_name           	          ;
      STRING70  c_owner_name                      ;
      STRING182 clean_address 	                  ;
    END;
	EXPORT NY    :=record
		STRING192  DBAName ;	
		STRING6    FileId ;	
		STRING16   FilingNumber ;
		STRING8    FilingDate ;
		STRING8    DateLastTrans ;
		STRING8    FileCode;
		STRING69   Ownerflname;
		STRING71   Owneraddress;	
		STRING28   OwnerCity;	
		STRING2    OwnerState;	
		STRING9    OwnerZIP;	
		STRING83   Busaddress;	
		STRING28   BusCity;	
		STRING2    BusState;	
		STRING9    BusZIP;	
		STRING182  clean_address;	
		STRING182  clean_owner_address;	
		STRING73   pname;	
    END;

/* EXPORT InfoUSA := record, maxlength(1710470) 
		STRING lni  							{xpath('@lni')};
		STRING minrev 							{xpath('@minrev')}; 
		STRING src								{xpath('@src')}; 
		STRING f 								{xpath('@f')};
		STRING Date_last_updated 				{xpath('TD')};
		STRING LEGEND2           				{xpath('LG2')};
		STRING StateDesc          				{xpath('PU')};
		STRING Bus_Name       					{xpath('DN')};
		STRING Bus_AreaCode    					{xpath('AR')};
		STRING Bus_phone         				{xpath('TP')};
		STRING Filing_Date         				{xpath('FD')};
		STRING Bus_County     					{xpath('BIC')};
		STRING Bus_County_Name   				{xpath('BIC/CU')};
		STRING Bus_Desc   		 				{xpath('DP')};
		STRING SIC					 			{xpath('SIC')};
		STRING NULL_TAG				 			{xpath('LXD')};
		STRING FileCode              			{xpath('FI')};
		STRING File               				{xpath('FLE')};
		STRING Cite_ID				          	{xpath('CI')};
		STRING Bus_Address  					{xpath('BA')};
		STRING Bus_Address_S1 					{xpath('BA/S1')};
		STRING Bus_Address_CY 					{xpath('BA/CY')};
		STRING Bus_Address_ST 					{xpath('BA/ST')};
		STRING Bus_Address_ZP 					{xpath('BA/ZP')};
		STRING Cont_Address 		 			{xpath('CCA')};
		STRING Cont_Address_S1					{xpath('CCA/S1')};
		STRING Cont_Address_CY					{xpath('CCA/CY')};
		STRING Cont_Address_ST					{xpath('CCA/ST')};
		STRING Cont_Address_ZP					{xpath('CCA/ZP')};
		STRING Cont_AreaCode					{xpath('CCA/AR')};
		STRING Cont_phone_Number				{xpath('CCA/TP')};
		STRING CCT_lastname      				{xpath('CCT/LN')};
		STRING CCT_Suffix        				{xpath('SF')};
		STRING CCT_firstname     				{xpath('CCT/GN')};
		STRING NAME_SEQUENCE      				{xpath('NS')};
		STRING Filing_Type       				{xpath('TYP')};
		STRING DUMMY_SEG          				{xpath('DUMMY-SEG')};
   END;
   EXPORT TXDOwner:=RECORD, maxlength(5024000)

		STRING owner_Full_name   {xpath('FL')};
		STRING owner_address     {xpath('S1')};
		STRING owner_CITY        {xpath('CY')};
		STRING owner_STATE       {xpath('ST')};
		STRING owner_ZIP         {xpath('ZP')};
   END;
   
   EXPORT TXDNY    :=record, maxlength(5024000)
   
		STRING date_last_trans  {xpath('TD')};
		STRING bus_name  		{xpath('DN')};
		STRING filing_date  	{xpath('FD')};
		STRING filing_number 	{xpath('FN')};
		STRING Jurisdiction		{xpath('FI')};
		STRING bus_address 		{xpath('S1')};
		STRING bus_CITY  		{xpath('CY')};
		STRING BUS_STATE  		{xpath('ST')};
		STRING BUS_ZIP 			{xpath('ZP')};
		STRING filing_type		{xpath('TYP')};		
			dataset(TXDOwner) 		owner{xpath('OW')};
	END;
	EXPORT CABOwner:=RECORD, maxlength(5024000)
		STRING owner_last_name   {xpath('LN')};
		STRING owner_first_name  {xpath('GN')};
		STRING owner_address     {xpath('S1')};
		STRING owner_CITY        {xpath('CY')};
		STRING owner_STATE       {xpath('ST')};
		STRING owner_ZIP         {xpath('ZP')};
	 END;
	 EXPORT CABBAD:=RECORD, maxlength(5024000)
		STRING BUS_address     {xpath('S1')};
		STRING BUS_CITY        {xpath('CY')};
		STRING BUS_STATE       {xpath('ST')};
		STRING BUS_ZIP         {xpath('ZP')};
	 END;
	 EXPORT CABMAD:=RECORD, maxlength(5024000)
		STRING MAD_address     {xpath('S1')};
		STRING MAD_CITY        {xpath('CY')};
		STRING MAD_STATE       {xpath('ST')};
		STRING MAD_ZIP         {xpath('ZP')};
	 END; 
	 
EXPORT FLOwner:=RECORD, maxlength(5024000)

		STRING owner_Last_name   {xpath('LN')};
		STRING owner_First_name  {xpath('GN')};
		STRING owner_address     {xpath('S1')};
		STRING owner_CITY        {xpath('CY')};
		STRING owner_STATE       {xpath('ST')};
		STRING owner_ZIP         {xpath('ZP')};
   END;
   
   EXPORT FLbus:=RECORD, maxlength(5024000)

		STRING bus_mail_address     {xpath('S1')};
		STRING bus_mail_CITY        {xpath('CY')};
		STRING bus_mail_STATE       {xpath('ST')};
		STRING bus_mail_ZIP         {xpath('ZP')};
   END;
   
   EXPORT FL    :=record, maxlength(5024000)
   
		STRING date_last_trans  {xpath('TD')};
		STRING bus_name  		{xpath('DN')};
		STRING filing_date  	{xpath('FD')};
		STRING filing_number 	{xpath('FN')};
		STRING Jurisdiction		{xpath('FI')};
		STRING bus_address 		{xpath('S1')};
			FLbus  mail_addr        {xpath('MAD')};
		STRING filing_type		{xpath('TYP')};
		STRING status           {xpath('SU')};
		STRING expiration_date  {xpath('ER')};
			dataset(FLOwner) 		owner{xpath('OW')};
	END;
	
	EXPORT FL    :=record, maxlength(5024000)
		STRING Abandon_Date ;	
		STRING AbandFileNo ;	
		STRING BusCommDate ;	
		STRING CiteId ;	
		STRING DBAName ;	
		STRING DBANumber ;	
		STRING ExpirationDate ;	
		STRING FilingDate ;	
		STRING FEIN ;	
		STRING FileId ;	
		STRING FilingNumber ;	
		STRING InactiveDate ;	
		STRING IncorpState ;	
		STRING NameSequence ;	
		STRING OwnerType ;	
		STRING Publication ;	
		STRING Status ;	
		STRING DateLastTrans ;	
		STRING Telephone ;	
		STRING FilingType;
		STRING county;
		STRING FilingdateH    ;
		STRING FiletypeH      ;
		STRING comments       ;
		STRING doNH            ;  
		STRING OwnerWDD;	
		STRING Ownerflname;	
		STRING Ownerlastname;	
		STRING Ownerfirstname;	
		STRING Owneraddress;	
		STRING OwnerCity;	
		STRING OwnerState;	
		STRING OwnerZIP;	
		STRING OwnerFZIP ;	
		STRING ownerMname ;
		STRING ownerMI        ;
		STRING ownerNameType   ;
		STRING ownerCounty      ; 
		STRING ownerNameSuffix;
		STRING Busaddress;	
		STRING BusCity;	
		STRING BusState;	
		STRING BusZIP;	
		STRING BusFZIP;
		STRING BusCounty;
		STRING clean_address;
		STRING clean_own_addres;
		STRING clean_name;
		end ;
			
  
	EXPORT CAB    :=RECORD, maxlength(5024000)
		STRING date_last_trans  {xpath('TD')};
		STRING bus_name  		{xpath('DN')};
		STRING filing_date  	{xpath('FD')};
		STRING filing_number 	{xpath('DR')};
		STRING Jurisdiction		{xpath('FI')};
			dataset(CABBAD) 		BA{xpath('BA')};
			dataset(CABMAD) 		MAD{xpath('MAD')};
		STRING filing_type		{xpath('TYP')};
		STRING Owner_type       {xpath('OY')};
			dataset(CABOwner) 		owner{xpath('OW')};
	END ;
	EXPORT CAVOwner:=RECORD, maxlength(5024000)
		STRING owner_last_name   {xpath('LN')};
		STRING owner_first_name  {xpath('GN')};
	END;
	
	EXPORT CAV    :=RECORD, maxlength(5024000)
		STRING date_last_trans  {xpath('TD')};
		STRING bus_name  		{xpath('DN')};
		STRING filing_date  	{xpath('FD')};
		STRING filing_number 	{xpath('FN')};
		STRING Jurisdiction		{xpath('FI')};
		STRING bus_address 		{xpath('S1')};
		STRING bus_CITY  		{xpath('CY')};
		STRING BUS_STATE  		{xpath('ST')};
		STRING BUS_ZIP 			{xpath('ZP')};
		STRING filing_type		{xpath('TYP')};
		STRING expiration_date  {xpath('ER')};
			dataset(CAVOwner) 		owner{xpath('OW')};
	END ;
	
	EXPORT CACOwner:=RECORD, maxlength(5024000)
		STRING owner_FL_name   {xpath('FL')}; 
	END;
	
	EXPORT CAC    :=RECORD, maxlength(5024000)
		STRING date_last_trans  {xpath('TD')};
		STRING bus_name  		{xpath('DN')};
		STRING filing_date  	{xpath('FD')};
		STRING filing_number 	{xpath('FN')};
		STRING Jurisdiction		{xpath('FI')};
		STRING bus_address 		{xpath('S1')};
		STRING bus_CITY  		{xpath('CY')};
		STRING BUS_STATE  		{xpath('ST')};
		STRING BUS_ZIP 			{xpath('ZP')};
		STRING filing_type		{xpath('TYP')};
		STRING status           {xpath('SU')};
			dataset(CACOwner) 		owner{xpath('OW')};
	END ;
	
	EXPORT CAS    :=RECORD, maxlength(5024000)
		STRING date_last_trans  {xpath('TD')};
		STRING bus_name  		{xpath('DN')};
		STRING filing_date  	{xpath('FD')};
		STRING filing_number 	{xpath('FN')};
		STRING Jurisdiction		{xpath('FI')};
		STRING status           {xpath('SU')};
		STRING owner_FL_name    {xpath('FL')}; 
	END ;*/
END ;