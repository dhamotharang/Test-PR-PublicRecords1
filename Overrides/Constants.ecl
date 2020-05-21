IMPORT FFD,STD,FCRA;
EXPORT Constants := module

EXPORT string statsAlert_threshold := '100';

EXPORT string ALLOY := 'ALLOY';
EXPORT string EMAIL_DATA   := 'EMAIL_DATA';
EXPORT string GONG  := 'GONG';
EXPORT string HDR   := 'HEADER';
EXPORT string HUNTING_FISHING   := 'HUNTING_FISHING';
EXPORT string INFUTOR   := 'INFUTOR';
EXPORT string PROFLIC := 'PROFLIC';
EXPORT string PAW := 'PAW';
EXPORT string PROFLIC_MARI := 'PROFLIC_MARI';
EXPORT string STUDENT_NEW := 'STUDENT_NEW';
EXPORT string BANKRUPT_MAIN := 'BANKRUPT_MAIN';
EXPORT string BANKRUPT_SEARCH := 'BANKRUPT_SEARCH';
EXPORT string LIENSV2_MAIN := 'LIENSV2_MAIN';
EXPORT string LIENSV2_PARTY := 'LIENSV2_PARTY';
EXPORT string COURT_OFFENSES := 'COURT_OFFENSES';
EXPORT string OFFENDERS := 'OFFENDERS';

//get datagroup referred in override key builds

EXPORT GetDsType(STRING datagroup) := function

   Dstype := CASE(datagroup, 
	  FFD.Constants.DataGroups.HDR => HDR,
		FFD.Constants.DataGroups.STUDENT_ALLOY => ALLOY,
		FFD.Constants.DataGroups.STUDENT => STUDENT_NEW,
		FFD.Constants.DataGroups.BANKRUPTCY_MAIN => 'BANKRUPT_FILING',
    FFD.Constants.DataGroups.BANKRUPTCY_SEARCH => BANKRUPT_SEARCH,
		FFD.Constants.DataGroups.LIEN_MAIN => LIENSV2_MAIN,
		FFD.Constants.DataGroups.LIEN_PARTY => LIENSV2_PARTY,
		FFD.Constants.DataGroups.MARI => PROFLIC_MARI,datagroup);
				
		return Dstype;
		
		end;
		
//get datagroup referred in ConsumerDisclosure.FCRADataService
EXPORT Getdatagroup(STRING datasetname) := function

   datagroup := CASE(STD.Str.ToUpperCase(datasetname)
										,HDR => FFD.Constants.DataGroups.HDR
                    ,PROFLIC_MARI => FFD.Constants.DataGroups.MARI
										,'AMERICAN_STUDENT_NEW' => FFD.Constants.DataGroups.STUDENT
										,ALLOY => FFD.Constants.DataGroups.STUDENT_ALLOY
										,BANKRUPT_MAIN => FFD.Constants.DataGroups.BANKRUPTCY_MAIN
										,BANKRUPT_SEARCH => FFD.Constants.DataGroups.BANKRUPTCY_SEARCH
										,LIENSV2_MAIN => FFD.Constants.DataGroups.LIEN_MAIN
										,LIENSV2_PARTY => FFD.Constants.DataGroups.LIEN_PARTY
										,COURT_OFFENSES => FFD.Constants.DataGroups.COURT_OFFENSES    
										,OFFENDERS => FFD.Constants.DataGroups.OFFENDERS
  									,STD.Str.ToUpperCase(datasetname));
		return datagroup;
		
		end;

//datagroup with flag_file_id link multiple records  
//EXPORT datagroup_m_set := [FFD.Constants.DataGroups.BANKRUPTCY_MAIN, FFD.Constants.DataGroups.BANKRUPTCY_SEARCH, 
//FFD.Constants.DataGroups.LIEN_MAIN, FFD.Constants.DataGroups.LIEN_PARTY];
EXPORT datagroup_m_set := [FFD.Constants.DataGroups.BANKRUPTCY_SEARCH];

EXPORT file_id_m_set := [FCRA.FILE_ID.BANKRUPTCY];
		
		END;
		