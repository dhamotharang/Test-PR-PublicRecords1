export MAC_IncludeInRepositoryParsed(inFile, 
		_firstname='fname',_middlename='mname',_lastname='lname',_namesuffix='name_suffix',
nameid = 'nid',
namtype = 'nametype',		// name type field
title1 = 'cln_title',		// cleaned title field
fname1 = 'cln_fname',		// cleaned first name field
mname1 = 'cln_mname',		// cleaned middle name field
lname1 = 'cln_lname',		// cleaned last name field
suffix1 = 'cln_suffix',		// cleaned suffix field
title2 = 'cln_title2',		// cleaned title for name 2
fname2 = 'cln_fname2',		// cleaned first name for name 2
mname2 = 'cln_mname2',		// cleaned middle name for name 2
lname2 = 'cln_lname2',		// cleaned last name for name 2
suffix2 = 'cln_suffix2'		// cleaned suffix for name 2
) := MACRO

#UNIQUENAME(xform)
	NID.Layout_Repository %xform%(RECORDOF(inFile) L) := TRANSFORM
		self.NID := NID.Common.fGetNIDParsed(L._firstname,L._middlename,L._lastname,L._namesuffix);

		self.Name := Nid.ReconstructName(L._firstname,L._middlename,L._lastname,L._namesuffix);
	
		self.NameType := L.namtype;
			
		self.fname := L._firstname;
		self.mname := L._middlename;
		self.lname := L._lastname;
		self.suffix := L._namesuffix;
		self.cln_title		:= L.title1;
		self.cln_fname		:= L.fname1;
		self.cln_mname		:= L.mname1;
		self.cln_lname		:= L.lname1;
		self.cln_suffix	    := L.suffix1;
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
	%dsOut% := 	PROJECT(DEDUP(SORT(inFile,_firstname,_middlename,_lastname,_namesuffix,LOCAL),
						_firstname,_middlename,_lastname,_namesuffix,LOCAL),
					%xform%(LEFT));
	//%dsOut% := 	PROJECT(inFile, NID.Layouts.rNameCache);
	/*
#UNIQUENAME(dualxform)
	NID.Layout_Repository %dualxform%(NID.Layout_Repository L, integer c) := TRANSFORM
		SELF.NameType := IF(L.NameType='D','P',SKIP);
		//SELF.NID := L.NID[1..16] + IntFormat(c,2,1);
		self.NID := NID.Common.fGetNIDParsed(L.fname,L.mname,L.lname,L.suffix,c);

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
	%dual% := Distribute(NORMALIZE(%dsOut%(NameType='D'), 2, %dualxform%(LEFT, COUNTER)),Nid);
*/				
#UNIQUENAME(outfile)
    %outfile% := %dsOut%;	// & %dual%;
					//		: INDEPENDENT;

#UNIQUENAME(filename)
#UNIQUENAME(fp, '#$');
	%filename% := Nid.CreateRepositoryFilename(#TEXT(%fp%));
		NID.AddToCache(%outfile%, %filename%);
		

ENDMACRO;