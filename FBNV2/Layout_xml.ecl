EXPORT Layout_xml := 
  module
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
   END;*/
   
	EXPORT InfoUSA := RECORD
			string46 	CiteId ;	
			string50 	DBAName ;	
			string48 	BusinessDesc  ; 	
			string6 	SIC ;
			string8 	FilingDate ; 
			string5 	FileId ;	
			string8 	DateLastTrans ;	
			string10 	Telephone ;	 
			string30 	county;
			string6 	FileCode;
			string60  	Owneraddress;	
			string34  	OwnerCity;	
			string2   	OwnerState;	
			string5   	OwnerZIP;
			string10  	OwnerPhone; 
			string60  	Busaddress;	
			string28  	BusCity;	
			string2   	BusState;	
			string10  	BusZIP;
			string182 	clean_address;
			string182 	clean_own_addres;
	END ;
   
  /* EXPORT TXDOwner:=RECORD, maxlength(5024000)

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
	END;*/
	EXPORT TXD:=RECORD
		string600 DBAName ;
		string8   FilingDate ;
		string12  FileId ;	
		string12  FilingNumber ;
		string8   DateLastTrans ; 	
		string15  FilingType; 
		string69  Ownerflname;
		string150 OwnerAF ;
		string73  Owneraddress;	
		string28  OwnerCity;	
		string2   OwnerState;	
		string9   OwnerZIP; 	
		string32  ownerCounty      ;
		string73  Busaddress;	
		string28  BusCity;	
		string2   BusState;	
		string9   BusZIP;	
		string12  BusCounty;	
		string182 clean_address;	
		string182 clean_own_addres; 
		string73  pname;
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

	end;
	
	/*EXPORT CAB    :=RECORD, maxlength(5024000)
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
	EXPORT CAV   :=RECORD, maxlength(5024000)
string8    Abandon_Date ;	
string8    BusCommDate ;
string192  DBAName ;		
string8    ExpirationDate ;	
string8    FilingDate ;
string12   FileId ;	
string16   FilingNumber ;
string8    DateLastTrans ;
string8    OwnerAOD;	
string8    OwnerWDD;	
string69   Ownerflname;	
string40   Ownerlastname;	
string30   Ownerfirstname;	
string71   Owneraddress;	
string28   OwnerCity;	
string2    OwnerState;	
string9    OwnerZIP;
string22   ownerMname  ;	
string9    ownerMI        ;	
string7    ownerNameType   ; 	
string6    ownerNameSuffix;	
string83   Busaddress;	
string28   BusCity;	
string2    BusState;	
string9    BusZIP;	
string83   Maddress;	
string28   MCity;	
string2    MState;	
string9    MZIP;	
string182  Clean_address;
string182  clean_own_addres;	
string182  clean_Maddress;	 
string73   pname;
end;
	
/*    EXPORT FLOwner:=RECORD, maxlength(5024000)

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
	END;*/
	
	/*EXPORT FL    :=record, maxlength(5024000)
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
		end ;*/
	EXPORT CAS:=record
		  string8   Abandon_Date;
		  string12  AbandFileNo;
		  string192 DBAName;
		  string8   FilingDate;
		  string12  FileId;
		  string12  FilingNumber;
		  string9   Status;
		  string8   DateLastTrans;
		  string8   OwnerWDD ;
		  string69  Ownerflname ;
		  string73  pname ;
		  string20  OwnerAF ;
	 END;
	 
 	EXPORT FL    :=record
		STRING8    Abandon_Date ;
		STRING12   AbandFileNo ;
		STRING8    BusCommDate ;
		STRING192  DBAName ;
		STRING12   DBANumber ;
		STRING8    ExpirationDate ;
		STRING8    FilingDate ;
		STRING9    FEIN ;
		STRING12   FileId ;
		STRING12   FilingNumber ;
		STRING8    InactiveDate ;
		STRING30   IncorpState ;
		STRING15    OwnerType ;
		STRING9    Status ;
		STRING8    DateLastTrans ;
		STRING10   Telephone ;
		STRING15   FilingType;
		STRING30   county;
		STRING8    FilingdateH      ;
		STRING61   FiletypeH       ;
		STRING200  comments         ;
		STRING12   doNH             ; 
		STRING8    OwnerWDD;
		STRING69   Ownerflname;
		STRING30   Ownerlastname;
		STRING30   Ownerfirstname;
		STRING71   Owneraddress;
		STRING28   OwnerCity;
		STRING2    OwnerState;
		STRING9    OwnerZIP;
		STRING22   ownerMname  ;
		STRING9    ownerMI        ;
		STRING7    ownerNameType   ;
		STRING32   ownerCounty      ; 
		STRING3    ownerNameSuffix;
		STRING83   Busaddress;
		STRING28   BusCity;
		STRING2    BusState;
		STRING9    BusZIP;
		STRING32   BusCounty;
		STRING182  clean_address;
		STRING182  clean_own_addres;
		STRING73   pname;
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
		STRING182  clean_own_addres;	
		STRING73   pname;	
    END;


END ;