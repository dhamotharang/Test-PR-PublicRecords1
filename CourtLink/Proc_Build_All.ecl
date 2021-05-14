import _Control, CourtLink, RoxieKeyBuild, Scrubs;

export Proc_Build_All(string pversion, string directory) := function

//Start Build Process
DoBuild := CourtLink.Build_All(pversion, directory).all;

//Key Build
BuildKeys := CourtLink.Proc_Build_Keys(pversion);

//Upate Roxie Page
UpdateRoxiePage := IF(
					Scrubs.mac_ScrubsFailureTest('Scrubs_LitigiousDebtor',pversion)
					,RoxieKeybuild.updateversion('LitigiousDebtorKeys', pversion, _control.MyInfo.EmailAddressNotify,,'N')
					,OUTPUT('Keys update failed due to Scrubs failure(s)!', NAMED('Key_status'))
					);

//Sample Records
SampleRecs := output(choosen(sort(Files().Base.qa , -dt_vendor_last_reported), 1000), named ('SampleRecords'));

retval := sequential (			DoBuild
							  , BuildKeys
							  , UpdateRoxiePage
							  , SampleRecs
							  ): success(CourtLink.Send_Email(pversion).KeySuccess), failure(CourtLink.Send_Email(pversion).KeyFailure);

return retval;
end;