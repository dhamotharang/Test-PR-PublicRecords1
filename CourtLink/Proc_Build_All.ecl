import _Control, CourtLink, RoxieKeyBuild;

export Proc_Build_All(string pversion, string directory) := function

//Start Build Process
DoBuild := CourtLink.Build_All(pversion, directory).all;

//Key Build
BuildKeys := CourtLink.Proc_Build_Keys(pversion);

//Upate Roxie Page
UpdateRoxiePage := RoxieKeybuild.updateversion('LitigiousDebtorKeys', pversion, _control.MyInfo.EmailAddressNotify,,'N');

//Sample Records
SampleRecs := output(choosen(sort(Files().Base.qa , -dt_vendor_last_reported), 1000), named ('SampleRecords'));

retval := sequential (DoBuild
							  , BuildKeys
							  , UpdateRoxiePage
							  , SampleRecs
							  ): success(CourtLink.Send_Email(pversion).KeySuccess), failure(CourtLink.Send_Email(pversion).KeyFailure);

return retval;
end;