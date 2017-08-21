Import utilfile;

export fn_util_base(dataset(UtilFile.layout_util.base) file_in) := function
//**** Filtered Business Utility records from the Utility file.
 
Util_bus_base := file_in(name_flag = 'B');

	UtilFile.Layout_Utility_Bus_Base tMarkUtilBusinessRecs(Util_bus_base l) := transform
		string fmname 		:= if(length(trim(l.orig_fname,left,right)) = 20, 
														trim(l.orig_fname) + trim(l.orig_mname),
														trim(l.orig_fname) + ' ' + trim(l.orig_mname));   
		string100 cname		:= if(fFixCompanyName.IsStrFound(fFixCompanyName.pLFMPattern, fmname),
														fFixCompanyName.fMakeCompanyName1(trim(l.orig_lname), trim(l.orig_fname), trim(l.orig_mname), trim(l.orig_name_suffix)),
														fFixCompanyName.fMakeCompanyName(trim(l.orig_lname), trim(l.orig_fname), trim(l.orig_mname), trim(l.orig_name_suffix)));
		self.company_name	:=	fFixCompanyName.FixBrokenWords(cname);			
		self							:=	l;
	end;
	
	dUtilBusRecs := project(Util_bus_base, tMarkUtilBusinessRecs(left));
lnames := ['JEWISH H', 'MIAMI JEWISH HOM', 'DOUGLAS GARDENS', 'PROPERT', 'ALL SAINTS CATH', 'SHOWCASE PRO', 'UTION SYSTEMS', 'NOBLES COUNTY C', 'CENTER'];
fnames :=['OSPITAL FOR', 'E HOSPIT',  'E HOSP', 'COMMUNITY MENTA', 'IES', 'OLIC CHURCH', 'PERTIES ERA', 'CENTURY DISTRIB', 'OURT', 'LINCOLNWOOD TOW'];
mnames :=['SHOWCASE', 'N', ''];

UtilFile.Layout_Utility_Bus_Base xForm(dUtilBusRecs L) := Transform
CompName := If(L.orig_lname in lnames and L.orig_fname in fnames and L.orig_mname in mnames,
								Map(	Trim(L.Company_name, Left, Right) = 'PERTIES ERA SHOWCASE PRO' => 'PROPERTIES ERA SHOWCASE',
											Trim(L.Company_name, Left, Right) = 'OSPITAL FOR JEWISH H' => 'JEWISH HOSPITAL FOR',
											Trim(L.Company_name, Left, Right) in ['E HOSPIT MIAMI JEWISH HOM',  'E HOSP MIAMI JEWISH HOM'] => 'MIAMI JEWISH HOME HOSPIT',
											Trim(L.Company_name, Left, Right) = 'COMMUNITY MENTA DOUGLAS GARDENS' => 'DOUGLAS GARDENS COMMUNITY MENTA',
											Trim(L.Company_name, Left, Right) = 'OLIC CHURCH ALL SAINTS CATH' => 'ALL SAINTS CATHOLIC CHURCH',
											Trim(L.Company_name, Left, Right) = 'IES SHOWCASE PROPERT' => 'PROPERTIES SHOWCASE',
											Trim(L.Company_name, Left, Right) = 'CENTURY DISTRIB UTION SYSTEMS' => 'CENTURY DISTRIBUTION SYSTEMS',
											Trim(L.Company_name, Left, Right) = 'OURT NOBLES COUNTY C' => 'NOBLES COUNTY COURT',
											Trim(L.Company_name, Left, Right) = 'LINCOLNWOOD TOW N CENTER' => 'LINCOLNWOOD TOWN CENTER', ''), L.Company_Name);
Self.Company_Name := CompName;
Self := L;
Self := [];
End;

patched := Project(dUtilBusRecs, xForm(Left));
return patched;
end;