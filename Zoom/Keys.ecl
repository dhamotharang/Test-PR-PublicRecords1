import doxie, VersionControl;

export Keys(string pversion = '') :=
module

	shared Base					:= _Filters.Keybuild(Files(pversion).Base.Built);

	shared FilterBdids	:= Base(bdid	!= 0);
	shared FilterDids		:= Base(did		!= 0);
	
	//Transfrom to convert the varying length zoomId field to fixed zoomId field
	Layout_base_fixed_zoomid := record
	    string15 zoomID := '';
	    layouts.keybuild;		 
	end;
	
	Layout_base_fixed_zoomid trfBaseZoomId(base l) := transform
	   self.zoomId := trim(l.rawfields.zoomid,left,right);
	   self := l;
	end;
	
	base_fixed_zoomid       := project(Base, trfBaseZoomId(left));	
	
	shared FilterZoomIds		:= base_fixed_zoomid((integer)zoomID != 0);

	versioncontrol.macBuildKeyVersions(FilterBdids	,{bdid}	  ,{FilterBdids	}	,keynames(pversion).Bdid	 ,Bdid  );
	versioncontrol.macBuildKeyVersions(FilterDids		,{did	}	  ,{FilterDids	}	,keynames(pversion).Did		 ,Did	  );
	versioncontrol.macBuildKeyVersions(FilterZoomIds,{zoomID} ,{FilterZoomIds},keynames(pversion).ZoomId ,ZoomId);
	
	shared BaseXML := Files(pversion).BaseXML.Built;
	
	Layout_keyXML  := Layouts.KeyXML;
		
	Layout_KeyXML trfBaseXML(BaseXML l) := transform
	    self := l;
	end;
	
	baseXML_keys   := project(BaseXML, trfBaseXML(left));		
	
	shared FilterXMLZoomID	:= baseXML_keys((integer)rawfields.ZoomID	!= 0);
	versioncontrol.macBuildKeyVersions(FilterXMLZoomID,{rawfields.zoomID} ,{FilterXMLZoomID}, keynames(pversion).XMLZoomId, XMLZoomId);

end;