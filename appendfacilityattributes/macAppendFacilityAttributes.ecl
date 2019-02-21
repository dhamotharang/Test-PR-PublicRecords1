EXPORT macAppendFacilityAttributes (Infile, InputLnpid, UseIndexThreshold=5000000, appendPrefix = '\'\'') := FUNCTIONMACRO
		IMPORT ecl;
		OutputRecord := RECORD
			RECORDOF (Infile);
			STRING1	 		#EXPAND(appendPrefix + 'EntityType');
			STRING120	  #EXPAND(appendPrefix + 'CNAME');
			STRING10  	#EXPAND(appendPrefix + 'NPINUMBER');
			STRING8   	#EXPAND(appendPrefix + 'NPIEnumerationDate');
			STRING8   	#EXPAND(appendPrefix + 'NPIDeactivationDate');
			STRING8   	#EXPAND(appendPrefix + 'NPIReactivationDate');
			STRING1	  	#EXPAND(appendPrefix + 'NPIFlag');
			STRING10  	#EXPAND(appendPrefix + 'DEANumber');
			STRING1	  	#EXPAND(appendPrefix + 'isStateSanction');
			STRING1	  	#EXPAND(appendPrefix + 'isOIGSanction');
			STRING1	  	#EXPAND(appendPrefix + 'isOPMSanction');
			STRING10  	#EXPAND(appendPrefix + 'Taxonomy');
			STRING50  	#EXPAND(appendPrefix + 'TaxonomyDescription');		
			STRING3	  	#EXPAND(appendPrefix + 'SpecialityCode');	
			STRING40  	#EXPAND(appendPrefix + 'GroupKey');
			STRING10  	#EXPAND(appendPrefix + 'Clia');
			STRING7	  	#EXPAND(appendPrefix + 'NCPDP');
		END;		
		
		//concatenate these in the output
		invalidLnpidDs := Infile(InputLnpid = 0);
		
		//join to Facility attributes
		joinKeyRecord := RECORD
			Infile.InputLnpid;
		END;
		
		validLnpidDs := Infile(InputLnpid > 0);		
		validLnpidDsDist := DISTRIBUTE(validLnpidDs, HASH32(InputLnpid));
		joinKeyDs := PROJECT(validLnpidDsDist, joinKeyRecord, LOCAL);
		joinKeyDsDedup := DEDUP(SORT(joinKeyDs, InputLnpid, LOCAL), InputLnpid, LOCAL);
		
		joinDs := ecl.macJoinKey(joinKeyDsDedup, AppendFacilityAttributes.Key_Facility_Attributes,
			'KEYED(LEFT.' + #TEXT(InputLnpid) + ' = RIGHT.LNPID)', 
			'RIGHT.' + #TEXT(InputLnpid) + ' = LEFT.LNPID', 
			UseIndexThreshold,'INNER',true,1,,,TRUE);

		OutputRecord	tOutputRecord (validLnpidDsDist L, joinDs R) := TRANSFORM

			SELF.#EXPAND(appendPrefix + 'EntityType')						:=	R.EntityType;
			SELF.#EXPAND(appendPrefix + 'CNAME')								:=	R.cname;
			SELF.#EXPAND(appendPrefix + 'NPINUMBER')						:=	R.npinumber;
			SELF.#EXPAND(appendPrefix + 'NPIEnumerationDate')		:=	R.npienumerationdate;
			SELF.#EXPAND(appendPrefix + 'NPIDeactivationDate')	:=	R.npideactivationdate;
			SELF.#EXPAND(appendPrefix + 'NPIReactivationDate')	:=	R.npireactivationdate;
			SELF.#EXPAND(appendPrefix + 'NPIFlag')							:=	R.npiflag;
			SELF.#EXPAND(appendPrefix + 'DEANumber')						:=	R.deanumber;
			SELF.#EXPAND(appendPrefix + 'isStateSanction')			:=	R.isstatesanction;
			SELF.#EXPAND(appendPrefix + 'isOIGSanction')				:=	R.isoigsanction;
			SELF.#EXPAND(appendPrefix + 'isOPMSanction')				:=	R.isopmsanction;
			SELF.#EXPAND(appendPrefix + 'Taxonomy')							:=	R.taxonomy;
			SELF.#EXPAND(appendPrefix + 'TaxonomyDescription')	:=	R.taxonomydescription;
			SELF.#EXPAND(appendPrefix + 'SpecialityCode')				:=	R.specialitycode;
			SELF.#EXPAND(appendPrefix + 'GroupKey')							:=	R.groupkey;
			SELF.#EXPAND(appendPrefix + 'Clia')									:=	R.clianumber;
			SELF.#EXPAND(appendPrefix + 'NCPDP')								:=	R.ncpdpnumber;
			SELF :=  L;
			SELF :=  R;
			SELF :=  [];
		END;		
		
		//can't guarantee that macJoinKey won't redistribute
		joinDsDist := DISTRIBUTE(joinDs, HASH32(InputLnpid) );
		
		outJoinedDs := JOIN (validLnpidDsDist, joinDsDist, 
								LEFT.InputLnpid = RIGHT.InputLnpid, 
								tOutputRecord(LEFT, RIGHT),								
								LEFT OUTER, LOCAL);
								
		outInvalidLnpidDs	:= PROJECT( invalidLnpidDs, TRANSFORM(OutputRecord, SELF:=LEFT, SELF:=[]));	
		outResult := outJoinedDs + outInvalidLnpidDs;
		RETURN outResult;

ENDMACRO;
