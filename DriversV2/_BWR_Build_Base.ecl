pversion 	:= '20151029'											;		// modify to current date

/////////////////////////////////////////////////////////////
// -- Quick Documentation
// -- 	1. Put the Build Date in the pversion attribute above
// --		2. Make sure the following attribute contains your email address sandboxed(do not check in!)
// --				_control.MyInfo.EmailAddressNotify
// --			 You will receive build emails to this address
/////////////////////////////////////////////////////////////

#workunit('name', 'Yogurt:DL2 Base Build ' + pversion);
#workunit('protect',true);
#workunit('priority','high');
#workunit('priority',11);
#option('multiplePersistInstances', FALSE);

DriversV2.Build_Base(pversion);