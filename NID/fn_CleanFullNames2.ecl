﻿IMPORT Address,NID,Std;
EXPORT fn_CleanFullNames2(inFile, Field, 
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
_nameorder = '',				// preferred name order: F (FML) L (LFM) u (unknown)
_cleanBiznames = false,	// standardize business names (true or false)
_cname = 'cname'				// cleaned business names
) := FUNCTIONMACRO

// layout with cleaned name
	cln_layout := RECORD
		NID.Common.xNID	nameid := 0;
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
#if(_cleanBiznames=true)
		string180	_cname := '';
#end
	END;
	
	new_layout := {RecordOf(inFile) OR cln_layout};

r := RECORD
  RecordOf(inFile);
  NID.Common.xNID __nid;
END;

	new_layout xform(new_layout L, Nid.Layout_Repository R) := TRANSFORM
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
#if(_cleanBiznames=true)
		//self._cname := R.std_biz;
		// temporary ... biz name in repository may be out of date
		self._cname := case(self.namType,
											'B' => NID.clnBizName(R.name),
											'T' => NID.clnTrustName(R.name),
											'');
#end

		self := L;
	END;

	new_layout xform1(r L, Nid.Layout_Repository R) := TRANSFORM
		self.namType 	:= R.nametype;
		self.nameid		:= L.__NID;
		
		self._title		:= R.cln_title;
		self._fname		:= R.cln_fname;
		self._mname		:= R.cln_mname;
		self._lname		:= R.cln_lname;
		self._suffix	  := R.cln_suffix;
		self._title2		:= R.cln_title2;
		self._fname2		:= R.cln_fname2;
		self._mname2		:= R.cln_mname2;
		self._lname2		:= R.cln_lname2;
		self._suffix2   := R.cln_suffix2;
		
		self._name_ind := R.nameind;
#if(_cleanBiznames=true)
		//self._cname := R.std_biz;
		// temporary ... biz name in repository may be out of date
		self._cname := case(self.namType,
											'B' => NID.clnBizName(R.name),
											'T' => NID.clnTrustName(R.name),
											'');
#end
		self.Field := L.field;
		self := L;
	END;
	
	new_layout xform2(new_layout L) := TRANSFORM
					__preProcessed := TRIM(Nid.Preprocess(Std.Str.ToUpperCase(L.Field),''),LEFT,RIGHT);
					__preCleaned := Address.PrecleanName(L.Field);
					__fmt := Nid.mod_NameFormat.PersonalNameFormat(__preCleaned);
					__nameQuality := Nid.mod_NameFormat.NameQuality(__preCleaned, __fmt);
					
					__isDualName := false;			//Address.Persons.IsDualName(preCleaned);
		
					__nameType := nid.fn_nonPerson(TRIM(L.Field), TRIM(__preProcessed), TRIM(__preCleaned),
													__nameQuality, __fmt);
					__CleanedName := CASE(__nameType,
							   Nid.MatchType.Person => nid.mod_NameFormat.FormatName(__preCleaned, __fmt), 
							   Nid.MatchType.Dual => nid.mod_NameFormat.FormatName1(__preCleaned, __fmt),
								 '');
					__CleanedName2 := IF(__nameType = Nid.MatchType.Dual, Nid.mod_NameFormat.FormatName2(__preCleaned, __fmt), '');
					__gender := Nid.NameTester.genderEx(__CleanedName[6..25],__CleanedName[26..45]);
					__gender2 := Nid.NameTester.genderEx(__CleanedName2[6..25],__CleanedName2[26..45]);
					__nameind := __nameType | (__nameQuality << 3);

		self.namType := Nid.Conversions.NameTypeToChar(__nameType);
		self.nameid		:= Nid.Common.fGetNID(L.Field);;
		//self.name			:= L.__rawName;
		
		self._title		:= CASE(__gender, 'M'=>'MR', 'F'=>'MS', '');
		self._fname		:= __CleanedName[6..25];
		self._mname		:= __CleanedName[26..45];
		self._lname		:= __CleanedName[46..65];
		self._suffix	:= __CleanedName[66..70];

		self._title2	:= CASE(__gender2, 'M'=>'MR', 'F'=>'MS', '');;
		self._fname2	:= __CleanedName2[6..25];
		self._mname2	:= __CleanedName2[26..45];
		self._lname2	:= __CleanedName2[46..65];
		self._suffix2	:= __CleanedName2[66..70];
	
		self._name_ind := __nameind;
		
#if(_cleanBiznames=true)
		self._cname := case(L.__nType,
											'B' => NID.clnBizName(name),
											'T' => NID.clnTrustName(name),
											'');
#end
		self := L;
	END;

	dsin := DISTRIBUTE(
			PROJECT(inFile(TRIM(Field)<>''), TRANSFORM(r,
				SELF.__nid := 
					Nid.Common.fGetNid(LEFT.Field);
				SELF := LEFT)),
			__nid);					
						
		matches1 := JOIN(dsin,  Nid.Overrides(true) ,
						LEFT.__nid = RIGHT.NID,
						xform1(LEFT, RIGHT),
						LOOKUP, FEW, LEFT OUTER);

		matches2 := JOIN(DISTRIBUTE(matches1(namType=''),nameid), Nid.NameRepository(derivation=0),
						LEFT.nameid = RIGHT.NID,
						xform(LEFT, RIGHT),
						LOCAL, KEEP(1), LEFT OUTER);
		matches := matches1(namType<>'') + matches2 : INDEPENDENT;
							
		nomatches := PROJECT(matches(namtype=''), xform2(LEFT)) : INDEPENDENT; 
	
		tempout := IF(EXISTS(nomatches), matches(namtype<>'') + nomatches, matches) +
				PROJECT(DISTRIBUTE(inFile(Field='')),
					TRANSFORM(new_layout, 
							SELF.nameid := Nid.Common.BlankNid;
							self._name_ind := Nid.NameIndicators.NameTypes.Blank;
							SELF := LEFT;
							));

#if(normalizeDualNames=true)

	new_layout xform_dual(new_layout L, integer c) := TRANSFORM,
				SKIP(c=2 AND L._fname=L._fname2 AND L._mname=L._mname2 AND L._lname=L._lname2 AND L._suffix=L._suffix2)
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

	dualnames := tempout(namType='D'); 

	outFile := IF(Exists(dualnames), tempout(namType<>'D') +
					NORMALIZE(dualnames, 2, xform_dual(LEFT, COUNTER)),
				tempout);	
#else
	outFile := tempout;
#end	


	
#IF(includeInRepository=true)
Nid.MAC_IncludeInRepository(
  nomatches,
	Field,
	nameid,
	namtype,		// name type field
	_title,		// cleaned title field
	_fname,		// cleaned first name field
	_mname,		// cleaned middle name field
	_lname,		// cleaned last name field
	_suffix,		// cleaned suffix field
	_title2,		// cleaned title for name 2
	_fname2,		// cleaned first name for name 2
	_mname2,		// cleaned middle name for name 2
	_lname2,		// cleaned last name for name 2
	_suffix2,		// cleaned suffix for name 2
	true
	);
#END

	return outFile;


ENDMACRO;