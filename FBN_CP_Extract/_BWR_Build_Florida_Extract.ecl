pversion    := '20070912';     // modify to current date
/////////////////////////////////////////////////////////////
// -- Quick Documentation
// --    1. Put the Build Date in the pversion attribute above
// --    2. Make sure the following attribute contains your email address sandboxed(do not check in!)
// --          _control.MyInfo.EmailAddressNotify
// --        You will receive build emails to this address
// --    3. Leave 'F' as the second parameter. This tells the BUILD_ALL routine to build the 
// --        Florida extract.
/////////////////////////////////////////////////////////////
#workunit('name', 'FBN Florida Extract Build ' + pversion);
FBN_CP_Extract.Build_All(pversion,'F').all;
