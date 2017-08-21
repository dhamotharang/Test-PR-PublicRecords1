import corp2, Corp2_Mapping;

//#workunit('protect',true);
#workunit('name', 'Yogurt:Corp2 thor patches');
#workunit('priority','high');
#workunit('priority',12);
#option('activitiesPerCpp', 50);

pversion		 :=	'20170211z'; //new version of data
state_origin :='OH';
state_fips	 :='39';	
state_desc	 :='OHIO';
dsCurrentCorp:=	corp2.files().Base_xtnd.ar.qa: independent; // Current QA superfile for corp file

output(dsCurrentCorp,,named('dsCurrentCorp'));
output(count(dsCurrentCorp),named('cnt_dsCurrentCorp'));	// sanity check count

//--------------------------------------------


ToFix				:= dsCurrentCorp(corp2.t2u(corp_state_origin)=state_origin);
TheRest			:= dsCurrentCorp(corp2.t2u(corp_state_origin)<>state_origin);

output(ToFix,,named('ToFix'));
output(count(ToFix),named('cnt_ToFix'));			// sanity check count

output(TheRest,,named('TheRest'));
output(count(TheRest),named('cnt_TheRest'));	// sanity check count

//--------------------------------------------
// Transform to fix the data
Corp2.Layout_Corporate_Direct_AR_Base_Expanded trfCleanFields(Corp2.Layout_Corporate_Direct_AR_Base_Expanded Input)	:=	transform
		
	self.ar_filed_dt := '';
	self						 := input;
		 
end;

FixedIt	:= project(ToFix, trfCleanFields(left));
Fixed   := sort(distribute(FixedIt,hash(corp_key)),record,local);

output(Fixed,,named('Fixed'));
output(count(Fixed),named('cnt_Fixed'));	// sanity check count

NewARBase := Fixed + TheRest;

output(NewARBase,,named('NewARBase'));
output(count(NewARBase),named('cnt_NewARBase'));	// sanity check count

//---------------------------------------------
// output new version of the data, clear superfiles & add to superfiles							
//output(NewARBase,,	'~thor_data400::base::corp2::'+ pversion +'::ar_xtnd',overwrite,__compressed__);