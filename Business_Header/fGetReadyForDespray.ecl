import versioncontrol, _control;

export fGetReadyForDespray(
	
	 dataset(versioncontrol.Layout_Versions.builds)	pFilenames
	,string																					pBusMount		= ''
	,string																					pServer			= _control.IPAddress.edata14a
	,boolean																				pOverwrite	= false

) := 
function

	
	versioncontrol.Layout_DKCs.Input tPrepareForDkc(versioncontrol.Layout_Versions.builds l) :=
	transform

		regex		:= '^.*key::moxie[.]([^.]*).*$';
	
		subdir	:= regexreplace(regex, l.templatename, '$1', nocase);
	
		lMount := pBusMount;

	
		self.logicalkeyname		:= l.templatename;
		self.destinationIP		:= pServer;
		self.destinationpath	:= fGetDesprayPath(self.logicalkeyname, lMount);
		self.allowoverwrite		:= pOverwrite;

	end;

	dDKC := project(pFilenames, tPrepareForDkc(left));

	return dDKC;

end;
