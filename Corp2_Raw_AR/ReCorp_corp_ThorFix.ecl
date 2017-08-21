import corp2, Corp2_Mapping;
#workunit('protect',true);
#workunit('name', 'Yogurt:Corp2 thor patches');
#workunit('priority','high');
#workunit('priority',12);
#option('activitiesPerCpp', 50);

pversion		 		 :='20170211y'; //new version of data
state_origin		 :='AR';
state_fips	 		 :='05';	
state_desc	 		 :='ARKANSAS';
dsCurrentCorp		 :=	corp2.files().Base_xtnd.corp.qa: independent; // Current QA superfile for corp file
output(dsCurrentCorp,named('dsCurrentCorp'));


//--------------------------------------------


toExclude		:= dsCurrentCorp(trim(corp_state_origin,left,right)=state_origin and trim(corp_process_date)='20170202');
TheRest			:= dsCurrentCorp(trim(corp_state_origin,left,right)<>state_origin or trim(corp_state_origin,left,right)=state_origin and corp_process_date<>'20170202');

output(toExclude,,named('toExclude'));
output(count(toExclude),named('cnt_toExclude'));			// sanity check count

NewCorpBase :=  TheRest;

output(NewCorpBase,named('NewCorpBase'));
output(count(NewCorpBase),named('cnt_NewCorpBase'));	// sanity check count

output(count(NewCorpBase + toExclude),named('totalCorpBase'));	// sanity check count
output(count(dsCurrentCorp),named('cnt_dsCurrentCorp'));	// sanity check count

//---------------------------------------------
// output new version of the data, clear superfiles & add to superfiles							
//output(NewCorpBase,,	'~thor_data400::base::corp2::'+ pversion +'::corp_xtnd',overwrite,__compressed__);