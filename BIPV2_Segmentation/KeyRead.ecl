import Data_Services;
import tools;

export KeyRead(string   pversion  = '' ,boolean	pUseOtherEnvironment	= tools._Constants.IsDataland) := module
	removeLeadingTilde(string s) := if(s[1] = '~', s[2..], s);
	shared superfile_name := 
		if(tools._Constants.IsAlpha_dev,
			Data_Services.foreign_prod + removeLeadingTilde(keynames(, false).seg_linkids.qa),
			keynames(, pUseOtherEnvironment).seg_linkids.qa);

	shared emptyDs := dataset([], Layouts.SegKeyLayout);

	export IndexDef(string filename = superfile_name, dataset(Layouts.SegKeyLayout) ds = emptyDs)
		:= index(ds, { seleid }, { ds }, superfile_name); 
	
	export Key := indexDef();
end;