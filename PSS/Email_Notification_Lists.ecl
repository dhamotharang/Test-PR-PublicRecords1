import roxiekeybuild, _control;
export Email_Notification_Lists :=
module

	export BuildFailure := if(_Flags.IsTesting, _Control.MyInfo.EmailAddressNotify, _Control.MyInfo.EmailAddressNotify + ';angela.herzberg@lexisnexisrisk.com;krishna.gummadi@lexisnexisrisk.com;christopher.brodeur@lexisnexisrisk.com; Manuel.Tarectecan@lexisnexisrisk.com; Randy.Reyes@lexisnexisrisk.com; Abednego.Escobal@lexisnexisrisk.com');

	export BuildSuccess := if(_Flags.IsTesting, _Control.MyInfo.EmailAddressNotify, _Control.MyInfo.EmailAddressNotify + ';angela.herzberg@lexisnexisrisk.com;krishna.gummadi@lexisnexisrisk.com;christopher.brodeur@lexisnexisrisk.com; Manuel.Tarectecan@lexisnexisrisk.com; Randy.Reyes@lexisnexisrisk.com; Abednego.Escobal@lexisnexisrisk.com');

	export Roxie  			:= if(_Flags.IsTesting, _Control.MyInfo.EmailAddressNotify, _Control.MyInfo.EmailAddressNotify + ';' + roxiekeybuild.Email_Notification_List + ';angela.herzberg@lexisnexisrisk.com;Krishna.Gummadi@lexisnexisrisk.com;christopher.brodeur@lexisnexisrisk.com; Manuel.Tarectecan@lexisnexisrisk.com; Randy.Reyes@lexisnexisrisk.com; Abednego.Escobal@lexisnexisrisk.com');

end;