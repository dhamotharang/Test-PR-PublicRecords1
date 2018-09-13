IMPORT ut;

// per Legal request, we removed the following sources that were in the original release of FCRA PAW:
// AT           Accurint Trade Show
// BA          	Bankruptcy
// CU						Credit Unions
// EY					 	Employee Directories
// LA           LN_Propertyv2 Lexis Assessors
// LB					 	Lobbyists
// LC           CL,CJ Liens v2 Chicago Law
// LI           Liens
// LP           LN_Propertyv2 Lexis Deeds and Mortgages
// WT						Wither and Die

PAW_FCRA_sources := 
['!W','#W','[W','1W','2W','3W','4W','5W','6W','7W','9W',
'AB','AM','AR','BR','BW',
'C`','C-','C(','C)','C*','C,','C.','C:','C;','C?','C[','C\\',
'C]','C^','C{','C|','C}','C~','C+','C<','C=','C>','C0','C1','C2',
'C3','C4','C5','C6','C7','C8','C9','CA','CB','CG','CH','CI',
'CK','CL','CN','CP','CQ','CR','CS','CT','CV','CW','CX','CZ',
'DA','DS','DW','E1','E2','E3','EB','EM','EQ','EW',
'FF','FK','FT','FW','GW','HW','IL','IN','IT','IW','JI','JW',
'KW','LL','LW','MW','NW','OL','OW',
'PI','PL','PW','QW','RW','SB','SK','SL','SP','SW',
'TL','TW','TX','V ','VW','WW','XF','XW','YW','ZM','ZW'];

dBase_filtered 	      := paw.File_base_cleanAddr_keybuild(did>0 and source in PAW_FCRA_sources);

// DF-21739 - Blank out fields in FCRA file thor_data400::key::paw::qa::did_fcra
fields_to_clear  := 'company_department,company_fein,dead_flag,dppa_state,title';

ut.MAC_CLEAR_FIELDS(dBase_filtered, dbase_cleared_temp, fields_to_clear);
dbase_cleared		:= DEDUP(SORT(DISTRIBUTE(dbase_cleared_temp,did), RECORD, LOCAL), RECORD, LOCAL);

EXPORT File_Key_DID_FCRA := dbase_cleared;