EXPORT SetAttributes(string clustername = '') := module
	export packageid(attributename,attributevalue,l_packageid,filepromoted) := macro
		PKG_DS := pkgfile.files('flat',clustername).getflatpackage;
		PKGID_DS := PKG_DS(id = l_packageid);
		pkgfile.layouts.flat_layouts.packageid populateattribute(PKGID_DS l) := transform
				self.attributename := attributevalue;
				self := l;
		end;
		l_attributeset := project(PKGID_DS,populateattribute(left));
	
		Full_DS := PKG_DS(id <> l_packageid) + l_attributeset;
		pkgfile.Promote.New(Full_DS,'flat',filepromoted);
	endmacro;
end;