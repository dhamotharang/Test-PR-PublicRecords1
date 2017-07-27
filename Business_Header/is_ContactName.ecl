export is_ContactName(string25 fname, string25 lname) := NOT(
fname[1..7]='COMPANY' OR 
lname[1..7]='COMPANY' OR 
fname[1..11]='ADMINISTRAT' OR 
lname[1..11]='ADMINISTRAT' OR 
fname[1..6]= 'EMPLOY' OR 
lname[1..6]= 'EMPLOY' OR 
fname[1..9]= 'REGISTRAT' OR 
lname[1..9]= 'REGISTRAT' OR 
fname[1..10]= 'CONTRACTOR' OR 
lname[1..10]= 'CONTRACTOR' OR 
fname = 'AGENT' or
lname = 'AGENT' or
fname = 'INSURANCE' or
lname = 'INSURANCE' or
(fname = 'FIDELITY' and lname = 'UNITED') or
(fname = 'TECH' and lname = 'SUPPORT') or
(fname = 'PRO' and lname = 'SE') or
(fname = 'TRUST' and lname = 'TU') or
(fname = 'MUTUAL' and lname = 'WASHINGTON') or
(fname = 'AMERILAWYER' and lname = 'CHARTERED') or
(fname = 'DOMA' and lname = 'ADMIN') or
(fname = 'C' and lname = 'NATIONAL'));

  
  
  
  
  
  

/*
FIDELITY UNITED 
COMPANY LIBERTY 
TECH SUPPORT 
COMPANY TRAVELERS 
DOMA ADMINISTRATOR 
PRO SE 
WEB ADMINISTRATOR 
TRUST TU 
MUTUAL WASHINGTON 
W EMPLOYERS 
AMERILAWYER CHARTERED 
C NATIONAL 
NORTH INSURANCE COMPANY 
AGENT RESIGNED 
DOMA REGISTRATION 
CONTRACTORS BUILDERS 
INSURANCE COMPANY 
WEB   ADMINISTRATOR  
REMOTE ADMINISTRATIVE 
SEA ADMINISTRATOR 
DOMA ADMINSITRATOR 
SYSTEMS ADMINISTRATION 
*/