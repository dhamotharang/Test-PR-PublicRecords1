import _control, VersionControl;

export _Flags(string pInput_Name='', string pBase_Name='',boolean pUseProd=false)  := module

	export IsTesting					:= IDA._Constants(pUseProd).IsDataland;
	export UseStandardizePersists		:= not IsTesting; // for bug 26170 -- Missing dependency from persist to stored
	export ExistCurrentSprayed			:= fileservices.superfileexists('~thor_data400::in::ida') and 
										   count(fileservices.superfilecontents('~thor_data400::base::ida::built')) > 0  ;
	export ExistBaseFile				:= count(nothor(fileservices.superfilecontents(IDA.filenames(pBase_name,).base.qa))) > 0;	
	export Update						:= ExistCurrentSprayed and ExistBaseFile;
	export IsUpdateFullFile				:= false;
	
	
SHARED GetActiveWU(string wuname) := function

  valid_state :=['','unknown','submitted', 'compiling','compiled','blocked','running','wait'];
	d := sort(nothor(WorkunitServices.WorkunitList('',NAMED jobname:=wuname ))(wuid <> thorlib.wuid() and state in valid_state), -wuid):independent;
	active_workunit :=  exists(d);

	return d;//active_workunit;

END;

SHARED GetActiveWUState(string wuname) := function

  valid_state :=['','unknown','submitted', 'compiling','compiled','blocked','running','wait','completed'];
	d := sort(nothor(WorkunitServices.WorkunitList('',NAMED jobname:=wuname ))(wuid <> thorlib.wuid() and state in valid_state), -wuid):independent;
	active_workunit :=  exists(d);

	return d;//active_workunit;

END;

EXPORT IDA_Daily_Base_Build_ActiveWU        := GetActiveWU('IDA DAILY BUILD'+' 2*')[1].wuid;
EXPORT IDA_Daily_Base_Build_State           := GetActiveWUState('IDA DAILY BUILD'+' 2*')[1].state;
export IDA_Daily_Base_Build_Active 		    := if (IDA_Daily_Base_Build_ActiveWU='','', 'IDA Daily Build is being executed already - ' + IDA_Daily_Base_Build_ActiveWU);


EXPORT IDA_Monthly_Base_Reappend_ActiveWU 	:= GetActiveWU('IDA MONTHLY REAPPEND BUILD'+' 2*')[1].wuid;
EXPORT IDA_Monthly_Base_Reappend_State 	    := GetActiveWUState('IDA MONTHLY REAPPEND BUILD'+' 2*')[1].state;
export IDA_Monthly_Base_Build_Active 		:= if (IDA_Monthly_Base_Reappend_ActiveWU='','', 'IDA Monthly Build is being executed already - ' + IDA_Monthly_Base_Reappend_ActiveWU);

end;

