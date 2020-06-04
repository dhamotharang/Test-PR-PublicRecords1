IMPORT Std, _Control;

Directory := '/data/temp/healthcare/';

ip :=  _control.IPAddress.bctlpedata12;
root := '~thor::bridger::medicaid::';

EXPORT SprayFile(string version) := FUNCTION

		lfn := 'hc_med_sanc_extract_' + version + '.tab';

		return STD.File.fSprayVariable(ip,
							Directory + lfn,
							8192,'\\t',,'\"',
							'thor400_44',
							root + Std.Str.tolowercase(lfn),
							,,,true,false,true
						);
END;