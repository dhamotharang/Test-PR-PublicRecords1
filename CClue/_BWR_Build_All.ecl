import std,_control,cclue;

/////////////////////////////////////////////////////////////
// -- Quick Documentation
// -- 	1. Put the Build Date in the pversion attribute above
// --     a. Moved the call to get the file date inside the Call to CCLUE.Build_All
// --		2. Make sure the following attribute contains your email address sandboxed(do not check in!)
// --				_control.MyInfo.EmailAddressNotify
// --			 You will receive build emails to this address
/////////////////////////////////////////////////////////////
#WORKUNIT('name','Yogurt:CCLUE Build kick off build');
#OPTION('multiplePersistInstances',FALSE);
output(_control.fSubmitNewWorkunit('#OPTION(\'multiplePersistInstances\',FALSE);\r\n'+
       '#workunit(\'protect\',true);\r\n' +
			 '#workunit(\'name\',\'Yogurt:' + CClue._Dataset().Name +' '+ '\');\r\n'+
			  'pversion := (STRING)CCLUE.Get_Version_Date(): GLOBAL;\r\n'+
			 'CCLUE.Build_All(pversion);'
      ,_control.Config.groupname('36');