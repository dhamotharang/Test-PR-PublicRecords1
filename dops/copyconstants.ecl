import _Control,lib_stringlib;
EXPORT copyconstants(string destenv) := module

	export copyfile := 'copyfiles::in::transfer::filelist'+destenv;

	export copyfileds := dataset('~'+copyfile,dops.layouts.filestocopy,thor,opt);
	
	export rFromEmail := 'bocaroxiepackageteam@lexisnexis.com';

end;