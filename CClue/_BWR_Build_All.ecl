pversion 	:= 	CCLUE.Get_Version_Date() : Independent;										;		// modify to current date

/////////////////////////////////////////////////////////////
// -- Quick Documentation
// -- 	1. Put the Build Date in the pversion attribute above
// --		2. Make sure the following attribute contains your email address sandboxed(do not check in!)
// --				_control.MyInfo.EmailAddressNotify
// --			 You will receive build emails to this address
/////////////////////////////////////////////////////////////
#workunit('protect','true');
#workunit('name','Yogurt:'+ CClue._Dataset().Name + '');
CClue.Build_All(pversion);  


