pversion    := '20070912';     // modify to current date
directory := '/hds_180/CourtLink/' + pversion;
/////////////////////////////////////////////////////////////
// -- Quick Documentation
// --    1. Put the Build Date in the pversion attribute above
// --    2. Make sure the following attribute contains your email address sandboxed(do not check in!)
// --          _control.MyInfo.EmailAddressNotify
// --        You will receive build emails to this address
// --    3. Check the following attribute to make sure it is correct:
// --          CourtLink._Flags
/////////////////////////////////////////////////////////////
#workunit('name', 'CourtLink Litigious Debtor Build ' + pversion);
CourtLink.Build_All(pversion, directory).all;