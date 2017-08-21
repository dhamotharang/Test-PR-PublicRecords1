export Mac_CleanFullNamesFromRepository(inFile, outFile, Field, 
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
normalizeDualNames=false
) := MACRO

#UNIQUENAME(cln_layout)
// layout with cleaned name
	%cln_layout% := RECORD
		NID.Common.xNID	nameid := Nid.Common.BlankNid;
		string1		namType := '';
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
		unsigned2	_name_ind := 0;
	END;
	
#UNIQUENAME(new_layout)
	%new_layout% := {RecordOf(inFile) OR %cln_layout%};
#UNIQUENAME(r)
%r% := RECORD
  RecordOf(inFile);
  NID.Common.xNID __nid;
END;

#UNIQUENAME(xform)
	%new_layout% %xform%(%r% L, Nid.Layout_Repository R) := TRANSFORM
//	%new_layout% %xform%(RECORDOF(inFile) L, Nid.Key_Repository R) := TRANSFORM
		self.namType 	:= R.nametype;
		self.nameid		:= R.NID;
		
		self._title		:= R.cln_title;
		self._fname		:= R.cln_fname;
		self._mname		:= R.cln_mname;
		self._lname		:= R.cln_lname;
		self._suffix	    := R.cln_suffix;
		self._title2		:= R.cln_title2;
		self._fname2		:= R.cln_fname2;
		self._mname2		:= R.cln_mname2;
		self._lname2		:= R.cln_lname2;
		self._suffix2    := R.cln_suffix2;
		
		self._name_ind := R.nameind;

		self := L;
	END;

#UNIQUENAME(matches)
#UNIQUENAME(nomatches)
#UNIQUENAME(dsin)

	%dsin% := DISTRIBUTE(
			PROJECT(inFile(TRIM(Field)<>''), TRANSFORM(%r%,
				SELF.__nid := 
					Nid.Common.fGetNid(LEFT.Field);
				SELF := LEFT)),
			__nid);					
						
						
	%matches% := JOIN(%dsin%, Nid.NameRepository(derivation=0),	//			Nid.NameRepository,
						//Nid.Common.fGetNID(LEFT.Field) = RIGHT.NID,
						LEFT.__nid = RIGHT.NID,
						%xform%(LEFT, RIGHT),
						LOCAL, KEEP(1), LEFT OUTER);
						
 	 %nomatches% := %matches%(Nid=0);
	 
#UNIQUENAME(tempout)
#if(normalizeDualNames=true)

#UNIQUENAME(xform_dual)

	%new_layout% %xform_dual%(%new_layout% L, integer c) := TRANSFORM
		SELF.namType := IF(L.namType='D','P',SKIP);
		name := TRIM(L.Field,LEFT,RIGHT);
		self.nameid		:= NID.Common.fGetNID(name,c);
		
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
	%dualnames% := %matches%(namType='D'); 

	%tempout% := IF(Exists(%dualnames%), %matches%(namType<>'D') +
					NORMALIZE(%dualnames%, 2, %xform_dual%(LEFT, COUNTER)),
				%matches%);	
#else
	%tempout% := %matches%;
#end	
	 
outfile := %tempout% + %nomatches%;



ENDMACRO;