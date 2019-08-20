import _control;

export Email_Notification_Lists := 
module

	export SprayCompletion	:= if(_Flags.Istesting, _control.MyInfo.EmailAddressNotify,'lbentley@seisint.com;skasavajjala@seisint.com;charlene.ros@lexisnexis.com');
	export BuildSuccess			:= if(_Flags.Istesting, _control.MyInfo.EmailAddressNotify, _control.MyInfo.EmailAddressNotify + ';lbentley@seisint.com;qualityassurance@seisint.com;skasavajjala@seisint.com;charlene.ros@lexisnexis.com');
	export BuildFailure			:= if(_Flags.Istesting, _control.MyInfo.EmailAddressNotify, _control.MyInfo.EmailAddressNotify + ';lbentley@seisint.com;qualityassurance@seisint.com;skasavajjala@seisint.com;charlene.ros@lexisnexis.com');
	export RoxieKeybuild		:= if(_Flags.Istesting, _control.MyInfo.EmailAddressNotify,_control.MyInfo.EmailAddressNotify + ';skasavajjala@seisint.com;charlene.ros@lexisnexis.com');
	export Stats						:= if(_Flags.Istesting, _control.MyInfo.EmailAddressNotify,_control.MyInfo.EmailAddressNotify + ';lbentley@seisint.com;skasavajjala@seisint.com;charlene.ros@lexisnexis.com');
	export Scrubs						:= if(_Flags.Istesting, _control.MyInfo.EmailAddressNotify,_control.MyInfo.EmailAddressNotify + ';skasavajjala@seisint.com;charlene.ros@lexisnexis.com;saritha.myana@lexisnexis.com' );
	
end;