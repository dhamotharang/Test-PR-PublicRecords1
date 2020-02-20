import  RoxieKeyBuild,ut,autokey,doxie, header_services, vault, _control;

// per Legal request, we removed the following sources that were in the original release of FCRA PAW:
// AT           Accurint Trade Show
// BA          Bankruptcy
// LA           LN_Propertyv2 Lexis Assessors
// LC           CL,CJ Liens v2 Chicago Law
// LI             Liens
// LP           LN_Propertyv2 Lexis Deeds and Mortgages

PAW_FCRA_sources := 
['!W','#W','[W','1W','2W','3W','4W','5W','6W','7W','9W',
'AB','AM','AR','BR','BW',
'C`','C-','C(','C)','C*','C,','C.','C:','C;','C?','C[','C\\',
'C]','C^','C{','C|','C}','C~','C+','C<','C=','C>','C0','C1','C2',
'C3','C4','C5','C6','C7','C8','C9','CA','CB','CG','CH','CI',
'CK','CL','CN','CP','CQ','CR','CS','CT','CU','CV','CW','CX','CZ',
'DA','DS','DW','E1','E2','E3','EB','EM','EQ','EW','EY',
'FF','FK','FT','FW','GW','HW','IL','IN','IT','IW','JI','JW',
'KW','LB','LL','LW','MW','NW','OL','OW',
'PI','PL','PW','QW','RW','SB','SK','SL','SP','SW',
'TL','TW','TX','V ','VW','WT','WW','XF','XW','YW','ZM','ZW'];

KeyName       := cluster.cluster_out+'Key::pAW::';
dBase_filtered 	      := paw.File_base_cleanAddr_keybuild(did>0 and source in PAW_FCRA_sources);



#IF(_Control.Environment.onVault) // when running on vault cluster, we need to use the file pointer instead of the roxie key in boca
EXPORT Key_DID_FCRA := vault.paw.Key_DID_FCRA;

#ELSE
EXPORT Key_DID_FCRA := INDEX(dBase_filtered  ,{did},{dBase_filtered},KeyName +doxie.Version_SuperKey+ '::did_FCRA');


#END;

