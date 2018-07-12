pversion 	:= 	'20180618'										;		// modify to current date

/////////////////////////////////////////////////////////////
// -- Quick Documentation
// -- 	1. Put the Build Date in the pversion attribute above
// --		2. Make sure the following attribute contains your email address sandboxed(do not check in!)
// --				_control.MyInfo.EmailAddressNotify
// --			 You will receive build emails to this address
/////////////////////////////////////////////////////////////
#workunit('protect','true');
#workunit('name','Yogurt:'+ CClue._Dataset().Name + ' Build - ' + pversion);
CClue.Build_All(pversion);  


