Source(s)								  :	Accutrend 
	
Update Frequency					:	Monthly	
										
Data Description					:	Business Registrations
						
Source Notes							: The source provides one file with Fixed Length with Carriage Return  (Record length 1745)
															
Loading Notes					    :	X:\business\business_registrations_(en)\accutrend 

Additional codes         	: scrubsAlert found few additional codes !!!please note below code&descriptions have been added to the code-----Jira/DF-19166!! 

//@@@@@@@		TITLE CODES:

ASSIS = ASSISTANT
ATTOR = ATTORNEY
ACCOU = ACCOUNTANT  
CERTI = CERTIFIED PUBLIC ACCOUNTANT
CHAIR = CHARIMAN
CHIEF = CHIEF EXECUTIVE OFFICER
CLERK = CLERK
CONTA = CONTACT
CONTR = CONTROLLER
DIREC = DIRECTOR 
ESQUI = ESQUIRE
EXECU = EXECUTIVE
GENER = GENERAL MANAGER
INCOR = INCORPORATOR
MANAG = MANAGER
MEMBE = MEMBER
OFFIC = OFFICER
OPERA = OPERATOR
ORGAN = ORGANIZER
OWNER = OWNER
PARTN = PARTNER
PRESI = PRESIDENT
QUALI = QUALIFIER
SECRE = SECRETARY
SENIO = SENIOR
SHARE = SHAREHOLDER
TREAS = TREASURER
VICE  = VICE PRESIDENT


//@@@@@@@		CORPCODES:

CP = Secretary of State
TL = Tax License
ML = Merchants License

//@@@@@@@		SOS_Codes:

U = Unknown (Normally ,we would not output but there are too many examples to ignore!! outputting as is)-per Rosemary!!
CSO = Do not map -per Rosemary!!
INC = Incorporation
LLLP = Limited Liability Limited Partnership

//@@@@@@@		Note :filing numbers are accurate leave in (there are from a specific SC county): for example, 1535 / 22 and 1535 / 87 but report characters, including:  <, > ,#,! and |  