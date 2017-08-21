export MAC_IncludeInRepository(inFile, 
	Field='fullname',
nameid = 'nid',
namtype = 'nametype',		// name type field
title = 'cln_title',		// cleaned title field
fname = 'cln_fname',		// cleaned first name field
mname = 'cln_mname',		// cleaned middle name field
lname = 'cln_lname',		// cleaned last name field
suffix = 'cln_suffix',		// cleaned suffix field
title2 = 'cln_title2',		// cleaned title for name 2
fname2 = 'cln_fname2',		// cleaned first name for name 2
mname2 = 'cln_mname2',		// cleaned middle name for name 2
lname2 = 'cln_lname2',		// cleaned last name for name 2
suffix2 = 'cln_suffix2'		// cleaned suffix for name 2
) := MACRO

#UNIQUENAME(xform)
	NID.Layout_Repository %xform%(RECORDOF(inFile) L) := TRANSFORM
		nm := TRIM(L.Field,LEFT,RIGHT);
		self.NID := NID.Common.fGetNID(nm);
		self.Name := nm;		
		self.NameType := L.namtype;
		
		self.cln_title		:= L.title;
		self.cln_fname		:= L.fname;
		self.cln_mname		:= L.mname;
		self.cln_lname		:= L.lname;
		self.cln_suffix	    := L.suffix;
		self.cln_title2		:= L.title2;
		self.cln_fname2		:= L.fname2;
		self.cln_mname2		:= L.mname2;
		self.cln_lname2		:= L.lname2;
		self.cln_suffix2    := L.suffix2;
		self.gender			:= if(L.namtype = 'P',
								Address.NameTester.GenderEx(self.cln_fname,self.cln_mname),'');
		self.nameind := Nid.NameIndicators.fn_setNameIndicator(self.NameType,0,self.gender,Length(trim(self.cln_fname))=1);
		
		self := [];
	END;

#UNIQUENAME(dsOut)
	%dsOut% := 	PROJECT(DEDUP(SORT(DISTRIBUTE(inFile,NID),NID,LOCAL),NID,LOCAL), %xform%(LEFT)); // : INDEPENDENT;
/*	
#UNIQUENAME(dualxform)
	NID.Layout_Repository %dualxform%(NID.Layout_Repository L, integer c) := TRANSFORM
		SELF.NameType := IF(L.NameType='D','P',SKIP);
		self.NID := NID.Common.fGetNID(L.name,c);
		self.derivation := c;
		
		SELF.cln_title := IF(c=1,L.cln_title, L.cln_title2);
		SELF.cln_fname := IF(c=1,L.cln_fname, L.cln_fname2);
		SELF.cln_mname := IF(c=1,L.cln_mname, L.cln_mname2);
		SELF.cln_lname := IF(c=1,L.cln_lname, L.cln_lname2);
		SELF.cln_suffix := IF(c=1,L.cln_suffix, L.cln_suffix2);
		self.gender		:= Address.NameTester.GenderEx(SELF.cln_fname,SELF.cln_mname);
		self.nameind := Nid.NameIndicators.fn_setNameIndicator('P',c,
					Address.NameTester.GenderEx(SELF.cln_fname,SELF.cln_mname),
					LENGTH(TRIM(SELF.cln_fname))=1);
		
		SELF.cln_title2 := '';
		SELF.cln_fname2 := '';
		SELF.cln_mname2 := '';
		SELF.cln_lname2 := '';
		SELF.cln_suffix2 := '';
		SELF := L;	
	END;
#UNIQUENAME(dual)
	%dual% := DISTRIBUTE(NORMALIZE(%dsOut%(NameType='D'), 2, %dualxform%(LEFT, COUNTER)),nid);
*/				
#UNIQUENAME(outfile)
	//%outfile% := SORT(DISTRIBUTE(%dsOut% + %dual%,HASH64(NID)),NID,LOCAL)
	%outfile% := %dsOut%;	// & %dual%;
				//			: INDEPENDENT;

#UNIQUENAME(filename)
#UNIQUENAME(fn, '#$');
	%filename% := Nid.CreateRepositoryFilename(#TEXT(%fn%));
		NID.AddToCache(%outfile%, %filename%);

ENDMACRO;