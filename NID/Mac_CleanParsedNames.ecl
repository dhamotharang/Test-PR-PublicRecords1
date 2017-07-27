export Mac_CleanParsedNames(inFile, outFile,
		firstname='fname',middlename='mname',lastname='lname',namesuffix='name_suffix',
		fullname='fullname',
		nameid = 'nid',
		namtype = 'nametype',		// name type field
		_title = 'cln_title',		// cleaned title field
		_fname = 'cln_fname',		// cleaned first name field
		_mname = 'cln_mname',		// cleaned middle name field
		_lname = 'cln_lname',		// cleaned last name field
		_suffix = 'cln_suffix',	// cleaned suffix field
		_title2 = 'cln_title2',	// cleaned title for name 2
		_fname2 = 'cln_fname2',	// cleaned first name for name 2
		_mname2 = 'cln_mname2',	// cleaned middle name for name 2
		_lname2 = 'cln_lname2',	// cleaned last name for name 2
		_suffix2 = 'cln_suffix2',	// cleaned suffix for name 2
		_name_ind = 'name_ind',	// name indicator. See Nid.NameIndicators
includeInRepository=true,
normalizeDualNames=false,
_chkpoint = 1
) := MACRO

//#UNIQUENAME(nosuffix)
//%nosuffix% := IF(#TEXT(namesuffix) = '\'\'', true, false);

#UNIQUENAME(cln_layout)
// layout with cleaned name
	%cln_layout% := RECORD
		NID.Common.xNID	nameid := Nid.Common.BlankNid;
		string1		namType := '';
		NID.Common.xNameString fullname := '';
		string5		_title := '';
		string20	_fname := '';
		string20	_mname := '';
		string20	_lname := '';
		string5		_suffix := '';
		string5		_title2 := '';
		string20	_fname2 := '';
		string20	_mname2 := '';
		string20	_lname2 := '';
		string5		_suffix2 := '';
		unsigned2	_name_ind;
	END;
	
#UNIQUENAME(new_layout)
	%new_layout% := {RecordOf(inFile) OR %cln_layout%};
#UNIQUENAME(r)
%r% := RECORD
  RecordOf(inFile);
  NID.Common.xNID __nid;
END;

#UNIQUENAME(xform)
//	%new_layout% %xform%(RECORDOF(inFile) L, Nid.Key_Repository R) := TRANSFORM
	%new_layout% %xform%(%r% L, Nid.Layout_Repository R) := TRANSFORM
		self.namType 	:= R.nametype;
		self.nameid		:= R.NID;
		self.fullname	:= R.name;
		
		self._title		:= R.cln_title;
		self._fname		:= R.cln_fname;
		self._mname		:= R.cln_mname;
		self._lname		:= R.cln_lname;
		self._suffix	:= R.cln_suffix;
		self._title2	:= R.cln_title2;
		self._fname2	:= R.cln_fname2;
		self._mname2	:= R.cln_mname2;
		self._lname2	:= R.cln_lname2;
		self._suffix2   := R.cln_suffix2;

		self._name_ind := R.nameind;
//		self._name_ind := Nid.NameIndicators.fn_setNameIndicator(R.nametype,R.derivation,R.gender,Length(trim(R.cln_fname))=1);
		
		self := L;
	END;
	
#UNIQUENAME(xform2)
	//%new_layout% %xform2%(RECORDOF(inFile) L) := TRANSFORM
	%new_layout% %xform2%(%new_layout% L) := TRANSFORM
		name := Address.Persons.ReconstructName(L.firstname,L.middlename,L.lastname, L.namesuffix);

		ntype := Address.Business.GetNameType(name);
		self.namType := ntype;
		self.nameid		:= NID.Common.fGetNIDParsed(L.firstname,L.middlename,L.lastname, L.namesuffix);
		self.fullname	:= name;
		string140 cln_name := if(ntype in ['P','D','I'],Address.NameCleaner.CleanNameEx(name,'f'),'');

		self._title		:= cln_name[1..5];
		self._fname		:= cln_name[6..25];
		self._mname		:= cln_name[26..45];
		self._lname		:= cln_name[46..65];
		self._suffix	:= cln_name[66..70];
		self._title2	:= cln_name[71..75];
		self._fname2	:= cln_name[76..95];
		self._mname2	:= cln_name[96..115];
		self._lname2	:= cln_name[116..135];
		self._suffix2   := cln_name[136..140];

		self._name_ind := Nid.NameIndicators.fn_setNameIndicator(ntype,0,
						IF(ntype='P',Address.NameTester.genderEx(self._fname,self._mname),''),
						IF(ntype='P',Length(trim(self._fname))=1,false));
		
		self := L;
	END;	

#UNIQUENAME(src)
#UNIQUENAME(matches)
#UNIQUENAME(nomatches)
#UNIQUENAME(dsin)
%dsin% := DISTRIBUTE(
			PROJECT(inFile(TRIM(firstname + middlename + lastname)<>''), TRANSFORM(%r%,
				SELF.__nid := 
					Nid.Common.fGetNIDParsed(LEFT.firstname,LEFT.middlename,LEFT.lastname,LEFT.namesuffix);
				SELF := LEFT)),
			__nid);
					
	%matches% := JOIN(%dsin%, Nid.NameRepository(derivation=0),
					//Nid.Common.fGetNIDParsed(LEFT.firstname, LEFT.middlename, LEFT.lastname, LEFT.namesuffix)
					LEFT.__nid	= RIGHT.Nid,
						%xform%(LEFT, RIGHT),
						LOCAL, KEEP(1), LEFT OUTER)
						: INDEPENDENT;
#UNIQUENAME(ds1)
#UNIQUENAME(nomatchdedup)
#UNIQUENAME(nomatchclean)
    %ds1% := SORT(%matches%(Nid=0),firstname,middlename,lastname,namesuffix, LOCAL) : INDEPENDENT;
	%nomatchdedup% := DEDUP(%ds1%,firstname,middlename,lastname,namesuffix, LOCAL);
	%nomatchclean% := PROJECT(%nomatchdedup%, %xform2%(LEFT)) : INDEPENDENT; 

	%nomatches% := IF(EXISTS(%matches%(Nid=0)),
					JOIN(%ds1%, %nomatchclean%, 
						    LEFT.firstname=RIGHT.firstname AND LEFT.middlename=RIGHT.middlename
						AND LEFT.lastname=RIGHT.lastname AND LEFT.namesuffix=RIGHT.namesuffix,
							TRANSFORM(%new_layout%, 
									SELF.nameid := RIGHT.nameid;
									self.namType := RIGHT.namType;
									self.fullname := RIGHT.fullname;
									self._title := RIGHT._title;
									self._fname := RIGHT._fname;
									self._mname := RIGHT._mname;
									self._lname := RIGHT._lname;
									self._suffix := RIGHT._suffix;
									self._title2 := RIGHT._title2;
									self._fname2 := RIGHT._fname2;
									self._mname2 := RIGHT._mname2;
									self._lname2 := RIGHT._lname2;
									self._suffix2 := RIGHT._suffix2;
									self._name_ind := RIGHT._name_ind;
									SELF := LEFT;),
								LOCAL, LEFT OUTER, KEEP(1))) : INDEPENDENT;
								
	
#UNIQUENAME(tempout)
	%tempout% := IF(EXISTS(%nomatches%), %matches%(NID<>0) + %nomatches%, %matches%) +
				PROJECT(inFile(TRIM(firstname + middlename + lastname)=''),
					TRANSFORM(%new_layout%, 
							//SELF.nametype := '';
							SELF.nameid := Nid.Common.BlankNid;
							self._name_ind := Nid.NameIndicators.Blank;
							SELF := LEFT;
							//SELF := [];
							))
				: INDEPENDENT;
							
#if(normalizeDualNames=true)

#UNIQUENAME(xform_dual)

	%new_layout% %xform_dual%(%new_layout% L, integer c) := TRANSFORM
		SELF.namType := IF(L.namType='D','P',SKIP);
		self.nameid := NID.Common.fGetNIDParsed(L.firstname,L.middlename,L.lastname,L.namesuffix,c);
		
		SELF._title := IF(c=1,L._title, L._title2);
		SELF._fname := IF(c=1,L._fname, L._fname2);
		SELF._mname := IF(c=1,L._mname, L._mname2);
		SELF._lname := IF(c=1,L._lname, L._lname2);
		SELF._suffix := IF(c=1,L._suffix, L._suffix2);
		
		SELF._title2 := '';
		SELF._fname2 := '';
		SELF._mname2 := '';
		SELF._lname2 := '';
		SELF._suffix2 := '';
		
		self._name_ind := Nid.NameIndicators.fn_setNameIndicator('P',c,
					Address.NameTester.GenderEx(SELF._fname,SELF._mname),
					LENGTH(TRIM(SELF._fname))=1);
				
		SELF := L;
	
	END;

#UNIQUENAME(dualnames)
	%dualnames% := %tempout%(namType='D'); 

	outFile := IF(Exists(%dualnames%), %tempout%(namType<>'D') +
					NORMALIZE(%dualnames%, 2, %xform_dual%(LEFT, COUNTER)),
				%tempout%);	
#else
	outFile := %tempout%;
#end	


#IF(includeInRepository=true)

Nid.MAC_IncludeInRepositoryParsed(%nomatchclean%,
	firstname,middlename,lastname,namesuffix,
	nameid,
	namtype,	// name type field
	_title,		// cleaned title field
	_fname,		// cleaned first name field
	_mname,		// cleaned middle name field
	_lname,		// cleaned last name field
	_suffix,	// cleaned suffix field
	_title2,	// cleaned title for name 2
	_fname2,	// cleaned first name for name 2
	_mname2,	// cleaned middle name for name 2
	_lname2,	// cleaned last name for name 2
	_suffix2		
	);


#END


ENDMACRO;
