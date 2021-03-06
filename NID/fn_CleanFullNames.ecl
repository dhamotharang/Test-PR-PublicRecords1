IMPORT Address,NID;
EXPORT fn_CleanFullNames(inFile, Field, 
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
_cname = 'cname',					// cleaned business names
useV2 = false								// use new repository 
) := FUNCTIONMACRO

// layout with cleaned name
	cln_layout := RECORD
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
#if(_cleanBiznames=true)
		string180	_cname := '';
#end
	END;
	
	new_layout := {RecordOf(inFile) OR cln_layout};

r := RECORD
  RecordOf(inFile);
  NID.Common.xNID __nid;
END;

	new_layout xform(r L, Nid.Layout_Repository R) := TRANSFORM
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
	
	options := case(#text(_nameorder),
								'f' => ['f'],
								'F' => ['f'],	
								'l' => ['l'],
								'L' => ['L'],
								[]);
	
	new_layout xform2(new_layout L) := TRANSFORM
		ntype := Address.Business.GetNameType(L.Field, options);
		self.namType := if(usev2 OR ntype<>'T',ntype,'U');
		name := TRIM(L.Field,LEFT,RIGHT);
		self.nameid		:= NID.Common.fGetNID(name);
		string140 cln_name := Address.NameCleaner.CleanNameEx(name, bSkipTrust := (ntype='T'), nmtype := ntype);
		
		self._title		:= cln_name[1..5];
		self._fname		:= cln_name[6..25];
		self._mname		:= cln_name[26..45];
		self._lname		:= cln_name[46..65];
		self._suffix	    := cln_name[66..70];
		self._title2		:= cln_name[71..75];
		self._fname2		:= cln_name[76..95];
		self._mname2		:= cln_name[96..115];
		self._lname2		:= cln_name[116..135];
		self._suffix2    := cln_name[136..140];

		self._name_ind := Nid.NameIndicators.fn_setNameIndicator(ntype,0,
						IF(ntype='P',Address.NameTester.genderEx(self._fname,self._mname),''),
						IF(ntype='P',Length(trim(self._fname))=1,false));
		
#if(_cleanBiznames=true)
		self._cname := case(ntype,
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
						
						
	matches := JOIN(dsin, Nid.Overrides & 
											if(useV2,Nid.NameRepository(derivation=0),Nid.NameRepositoryV1(derivation=0)),
						LEFT.__nid = RIGHT.NID,
						xform(LEFT, RIGHT),
						LOCAL, KEEP(1), LEFT OUTER);	//* : INDEPENDENT;
						
    ds1 := SORT(matches(Nid=0),Field, LOCAL);	// : INDEPENDENT;
		//nomatchdedup := DEDUP(ds1,Field, LOCAL);
		//nomatchclean := PROJECT(nomatchdedup, xform2(LEFT)); //* : INDEPENDENT; 
		nomatchclean := PROJECT(DEDUP(ds1,Field, LOCAL), xform2(LEFT)) : INDEPENDENT; 

		nomatches := IF(EXISTS(matches(Nid=0)),
					JOIN(ds1, nomatchclean, 
						    LEFT.Field=RIGHT.Field,
							TRANSFORM(new_layout, 
									SELF.nameid := RIGHT.nameid;
									self.namType := RIGHT.namType;
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
#if(_cleanBiznames=true)
									self._cname := RIGHT._cname;
#end
									SELF := LEFT;),
								LOCAL, LEFT OUTER, KEEP(1))); //: INDEPENDENT;						
						
	
	tempout := IF(EXISTS(nomatches), matches(NID<>0) + nomatches, matches) +
				PROJECT(DISTRIBUTE(inFile(Field='')),
					TRANSFORM(new_layout, 
							SELF.nameid := Nid.Common.BlankNid;
							self._name_ind := Nid.NameIndicators.Blank;
							SELF := LEFT;
							));

#if(normalizeDualNames=true)

	new_layout xform_dual(new_layout L, integer c) := TRANSFORM
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
newnames := nomatchclean;
Nid.MAC_IncludeInRepository(newnames,
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
	_suffix2		// cleaned suffix for name 2
	);
#END

	return outFile;


ENDMACRO;