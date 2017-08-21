import tools;
#option('maxLength', 131072); 				// have to increase for the remote directory child datasets
ddnbinput	:= DNB_DMI.Files('20110208').input.logical;

tools.mac_RedefineFormat(ddnbinput,dnb_dmi.Layouts.input.flattened,loutput,5698,[30,30],pOutputEcl := false);
output(sizeof(dnb_dmi.Layouts.input.sprayed)	,named('sizeofDnbDmiSprayedLayout'));
output(loutput);
//output(project(loutput,dnb_dmi.Layouts.input.sprayed3));