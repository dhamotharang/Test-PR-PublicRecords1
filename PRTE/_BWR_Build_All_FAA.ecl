#OPTION('multiplePersistInstances',FALSE);

pversion  := '20150211';     // modify to build date

/////////////////////////////////////////////////////////////
// -- Quick Documentation
// --    1. Put the Build Date in the pversion attribute above
// --    2. Make sure the following attribute contains your email address sandboxed(do not check in!)
// --          _control.MyInfo.EmailAddressNotify
// --        You will receive build emails to this address
/////////////////////////////////////////////////////////////
#workunit('name', 'Build FAA PRTE Keys ' + pversion);

PRTE.Build_All_FAA(pversion).all;