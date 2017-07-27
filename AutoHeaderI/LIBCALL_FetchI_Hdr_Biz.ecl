import _Control;
export LIBCALL_FetchI_Hdr_Biz := module
#if(not _Control.LibraryUse.ForceOff_AutoHeaderI__LIB_FetchI_Hdr_Biz)
	shared templib(LIBIN.FetchI_Hdr_Biz.full in_mod) := library('AutoHeaderI.LIB_FetchI_Hdr_Biz',LIBOUT.FetchI_Hdr_Biz(in_mod));
#else
	shared templib(LIBIN.FetchI_Hdr_Biz.full in_mod) := LIB_FetchI_Hdr_Biz(in_mod);
#end
	export do(LIBIN.FetchI_Hdr_Biz.full in_mod) := templib(in_mod).do;
	export do_plus(LIBIN.FetchI_Hdr_Biz.full in_mod) := templib(in_mod).do_plus;
end;
