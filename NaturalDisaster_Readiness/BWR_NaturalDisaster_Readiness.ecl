pversion    := '20110722';     // modify to folder date
directory := '/hds_180/SIM/NaturalDisaster_Readiness' + pversion;
/////////////////////////////////////////////////////////////
// -- Quick Documentation
// --    1. Put the Build Date in the pversion attribute above
// --    2. Make sure the following attribute contains your email address sandboxed(do not check in!)
// --          _control.MyInfo.EmailAddressNotify
// --        You will receive build emails to this address
// --    3. Check the following attribute to make sure it is correct:
// --          NaturalDisaster_Readiness._Flags
/////////////////////////////////////////////////////////////
#workunit('name', 'NaturalDisaster_Readiness ' + pversion);
NaturalDisaster_Readiness.Build_All(pversion).all;