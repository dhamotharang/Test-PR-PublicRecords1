import doxie, tools;

export Keys(string pversion = '') :=
module

	shared Base					:= _Filters.Keybuild(Files(pversion).Base.Built);
	
	shared FilterBdids	:= Base(bdid	!= 0);
	shared FilterDids		:= Base(did		!= 0);
	
	//Transform to convert the varying length zoomId field to fixed zoomId field
	shared Layout_base_fixed_zoomid := record
	    string15 zoomID := '';
	    layouts.keybuild;		 
	end;
	
	shared Layout_base_fixed_zoomid trfBaseZoomId(layouts.keybuild l) := transform
	   self.zoomId := trim(l.rawfields.zoomid,left,right);
	   self := l;
	end;
	
	shared base_fixed_zoomid       := project(Base, trfBaseZoomId(left));
	
	shared FilterZoomIds		:= base_fixed_zoomid((integer)zoomID != 0);

	
	shared BaseXML := Files(pversion).BaseXML.Built;
	
	shared Layout_keyXML  := Layouts.KeyXML;
		
	Layout_KeyXML trfBaseXML(BaseXML l) := transform
	    self := l;
	end;
	
	shared baseXML_keys   := project(BaseXML, trfBaseXML(left));		
	
	shared FilterXMLZoomID	:= baseXML_keys((integer)rawfields.ZoomID	!= 0);

	tools.mac_FilesIndex('FilterBdids			,{bdid						}	,{FilterBdids			}'	,keynames(pversion).Bdid	 			,Bdid  			);
	tools.mac_FilesIndex('FilterDids			,{did							}	,{FilterDids			}'	,keynames(pversion).Did		 			,Did	  		);
	tools.mac_FilesIndex('FilterZoomIds		,{zoomID					} ,{FilterZoomIds		}'	,keynames(pversion).ZoomId 			,ZoomId			);
	tools.mac_FilesIndex('FilterXMLZoomID	,{rawfields.zoomID} ,{FilterXMLZoomID	}'	,keynames(pversion).XMLZoomId		,XMLZoomId	);

end;