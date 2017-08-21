import header, mdr;

hdr := dataset(header.Filename_Header,header.Layout_Header,flat)
		+ header.File_TUCS_did + header.File_transunion_did;

//hdr := DISTRIBUTE(hdr1, HASH(did)) : PERSIST('~thor400_88::persist::calvo::hdr');

//hdr := CHOOSEN(dataset(header.Filename_Header,header.Layout_Header,flat),10000);

compliance.rQueryResult x(header.Layout_Header L, compliance.Layout_Parms R) := TRANSFORM
	SELF.Is_DL:=map(mdr.sourceTools.SourceIsDirectDL(L.src)=>'Direct'
				,mdr.sourceTools.SourceIsDL(L.src)=>'non-Direct'
				,'');
	SELF.Is_Vehicle:=map(mdr.sourceTools.SourceIsDirectVehicle(L.src)=>'Direct'
					,mdr.sourceTools.SourceIsVehicle(L.src)=>'non-Direct'
					,'');
	SELF.contributing_source:=header.translateSource(L.src);
	SELF.dod := 0;	// comes from Doxie key
	SELF.query := R.class;
	SELF := R;
	SELF := L;
END;

//qry := compliance.dsHdrQuery;
qry := PROJECT(Compliance.In_Sprechman_ID, Compliance.ExtractParms(LEFT));

boolean EQ(string l, string r) := IF(r='',true, l=r);

q :=
	JOIN(hdr, qry(class='ACSZ'), 
/*ACSZ*/ LEFT.city_name=RIGHT.city AND LEFT.st=RIGHT.state AND LEFT.zip=RIGHT.zip
			AND TRIM(LEFT.prim_range+LEFT.predir+LEFT.prim_name+LEFT.suffix+LEFT.postdir+LEFT.unit_desig+LEFT.sec_range,ALL)=RIGHT.address
			, x(LEFT, RIGHT), LEFT OUTER, LOOKUP)
	+ JOIN(hdr, qry(class='FL'), 
/*FL*/	  LEFT.fname=RIGHT.fname AND LEFT.lname=RIGHT.lname
			, x(LEFT, RIGHT), LEFT OUTER, LOOKUP) +
	JOIN(hdr, qry(class='FLACSZ'), 
/*FLACSZ*/ LEFT.fname=RIGHT.fname AND LEFT.lname=RIGHT.lname AND   
				LEFT.city_name=RIGHT.city AND LEFT.st=RIGHT.state AND LEFT.zip=RIGHT.zip
			AND TRIM(LEFT.prim_range+LEFT.predir+LEFT.prim_name+LEFT.suffix+LEFT.postdir+LEFT.unit_desig+LEFT.sec_range,ALL)=RIGHT.address
			, x(LEFT, RIGHT), LEFT OUTER, LOOKUP) +
	JOIN(hdr, qry(class='FLCSZ'), 
/*FLCSZ*/   LEFT.fname=RIGHT.fname AND LEFT.lname=RIGHT.lname AND
					LEFT.city_name=RIGHT.city AND LEFT.st=RIGHT.state AND LEFT.zip=RIGHT.zip
			, x(LEFT, RIGHT), LEFT OUTER, LOOKUP) +
	JOIN(hdr, qry(class='FLS'), 
/*FLS*/		LEFT.fname=RIGHT.fname AND LEFT.lname=RIGHT.lname AND LEFT.st=RIGHT.state
			, x(LEFT, RIGHT), LEFT OUTER, LOOKUP) +
	JOIN(hdr, qry(class='N'), 
/*N*/		LEFT.ssn=RIGHT.ssn
			, x(LEFT, RIGHT), LEFT OUTER, LOOKUP) +
	JOIN(hdr, qry(class='FML'), 
/*FML*/		LEFT.fname=RIGHT.fname AND LEFT.mname=RIGHT.mname AND LEFT.lname=RIGHT.lname
			, x(LEFT, RIGHT), LEFT OUTER, LOOKUP) +
	JOIN(hdr, qry(class='ACS'), 
/*ACS*/		LEFT.city_name=RIGHT.city AND LEFT.st=RIGHT.state AND 
				TRIM(LEFT.prim_range+LEFT.predir+LEFT.prim_name+LEFT.suffix+LEFT.postdir+LEFT.unit_desig+LEFT.sec_range,ALL)=RIGHT.address
			, x(LEFT, RIGHT), LEFT OUTER, LOOKUP) +
	JOIN(hdr, qry(class='FLCS'), 
/*FLCS*/	LEFT.fname=RIGHT.fname AND LEFT.lname=RIGHT.lname AND
					LEFT.city_name=RIGHT.city AND LEFT.st=RIGHT.state
			, x(LEFT, RIGHT), LEFT OUTER, LOOKUP) +
	JOIN(hdr, qry(class='FMLS'), 
/*FMLS*/	LEFT.fname=RIGHT.fname AND LEFT.mname=RIGHT.mname AND LEFT.lname=RIGHT.lname AND LEFT.st=RIGHT.state
			, x(LEFT, RIGHT), LEFT OUTER, LOOKUP) +
	JOIN(hdr, qry(class='FLACS'), 
/*FLACS*/	LEFT.fname=RIGHT.fname AND LEFT.lname=RIGHT.lname AND LEFT.city_name=RIGHT.city AND LEFT.st=RIGHT.state
				AND TRIM(LEFT.prim_range+LEFT.predir+LEFT.prim_name+LEFT.suffix+LEFT.postdir+LEFT.unit_desig+LEFT.sec_range,ALL)=RIGHT.address
			, x(LEFT, RIGHT), LEFT OUTER, LOOKUP) +
	JOIN(hdr, qry(class='FMLACS'), 
/*FMLACS*/	LEFT.fname=RIGHT.fname AND LEFT.mname=RIGHT.mname AND LEFT.lname=RIGHT.lname AND LEFT.city_name=RIGHT.city AND LEFT.st=RIGHT.state
				AND TRIM(LEFT.prim_range+LEFT.predir+LEFT.prim_name+LEFT.suffix+LEFT.postdir+LEFT.unit_desig+LEFT.sec_range,ALL)=RIGHT.address
			, x(LEFT, RIGHT), LEFT OUTER, LOOKUP) +
	JOIN(hdr, qry(class='FLN'), 
/*FLN*/		LEFT.fname=RIGHT.fname AND LEFT.lname=RIGHT.lname AND LEFT.ssn=RIGHT.ssn
			, x(LEFT, RIGHT), LEFT OUTER, LOOKUP) +
	JOIN(hdr, qry(class='FMLCS'), 
/*FMLCS*/   LEFT.fname=RIGHT.fname AND LEFT.mname=RIGHT.mname AND LEFT.lname=RIGHT.lname AND LEFT.city_name=RIGHT.city AND LEFT.st=RIGHT.state
			, x(LEFT, RIGHT), LEFT OUTER, LOOKUP) +
	JOIN(hdr, qry(class='FLSN'), 
/*FLSN*/	LEFT.fname=RIGHT.fname AND LEFT.lname=RIGHT.lname AND LEFT.st=RIGHT.state and LEFT.ssn=RIGHT.ssn
			, x(LEFT, RIGHT), LEFT OUTER, LOOKUP) +
	JOIN(hdr, qry(class='P'), 
/*P*/		LEFT.phone=RIGHT.phone
			, x(LEFT, RIGHT), LEFT OUTER, LOOKUP) +
	JOIN(hdr, qry(class='LACSZ'), 
/*LACSZ*/	LEFT.lname=RIGHT.lname AND LEFT.city_name=RIGHT.city AND LEFT.st=RIGHT.state AND LEFT.zip=RIGHT.zip
				AND TRIM(LEFT.prim_range+LEFT.predir+LEFT.prim_name+LEFT.suffix+LEFT.postdir+LEFT.unit_desig+LEFT.sec_range,ALL)=RIGHT.address
			, x(LEFT, RIGHT), LEFT OUTER, LOOKUP) +
	JOIN(hdr, qry(class='FLSZ' ), 
/*FLSZ*/	LEFT.fname=RIGHT.fname AND LEFT.lname=RIGHT.lname AND LEFT.st=RIGHT.state and LEFT.zip=RIGHT.zip
			, x(LEFT, RIGHT), LEFT OUTER, LOOKUP) +
	JOIN(hdr, qry(class='LS'), 
/*LS*/		LEFT.lname=RIGHT.lname AND LEFT.st=RIGHT.state
			, x(LEFT, RIGHT), LEFT OUTER, LOOKUP) +
	JOIN(hdr, qry(class='FMLCSZ'), 
/*FMLCSZ*/  LEFT.fname=RIGHT.fname AND LEFT.mname=RIGHT.mname AND LEFT.lname=RIGHT.lname AND LEFT.city_name=RIGHT.city AND LEFT.st=RIGHT.state AND LEFT.zip=RIGHT.zip
			, x(LEFT, RIGHT), LEFT OUTER, LOOKUP) +
	JOIN(hdr, qry(class='A'), 
/*A*/		TRIM(LEFT.prim_range+LEFT.predir+LEFT.prim_name+LEFT.suffix+LEFT.postdir+LEFT.unit_desig+LEFT.sec_range,ALL)=RIGHT.address
			, x(LEFT, RIGHT), LEFT OUTER, LOOKUP) +
	JOIN(hdr, qry(class='LCSZ'), 
/*LCSZ*/	LEFT.lname=RIGHT.lname AND LEFT.city_name=RIGHT.city AND LEFT.st=RIGHT.state AND LEFT.zip=RIGHT.zip
			, x(LEFT, RIGHT), LEFT OUTER, LOOKUP) +
	JOIN(hdr, qry(class='CSZ'), 
/*CSZ*/		 LEFT.city_name=RIGHT.city AND LEFT.st=RIGHT.state AND LEFT.zip=RIGHT.zip
			, x(LEFT, RIGHT), LEFT OUTER, LOOKUP) +
	JOIN(hdr, qry(class='LCS'), 
/*LCS*/		 LEFT.lname=RIGHT.lname AND LEFT.city_name=RIGHT.city AND LEFT.st=RIGHT.state
			, x(LEFT, RIGHT), LEFT OUTER, LOOKUP) +
	JOIN(hdr, qry(class='FLCSZN'), 
/*FLCSZN*/  LEFT.fname=RIGHT.fname AND LEFT.lname=RIGHT.lname AND LEFT.ssn=RIGHT.ssn AND
					LEFT.city_name=RIGHT.city AND LEFT.st=RIGHT.state AND LEFT.zip=RIGHT.zip
			, x(LEFT, RIGHT), LEFT OUTER, LOOKUP) +
	JOIN(hdr, qry(class='FMLAC'), 
/*FMLAC*/   LEFT.fname=RIGHT.fname AND LEFT.mname=RIGHT.mname AND LEFT.lname=RIGHT.lname AND LEFT.city_name=RIGHT.city 
				AND TRIM(LEFT.prim_range+LEFT.predir+LEFT.prim_name+LEFT.suffix+LEFT.postdir+LEFT.unit_desig+LEFT.sec_range,ALL)=RIGHT.address
			, x(LEFT, RIGHT), LEFT OUTER, LOOKUP) +
	JOIN(hdr, qry(class='FLAN'), 
/*FLAN*/	LEFT.fname=RIGHT.fname AND LEFT.lname=RIGHT.lname AND LEFT.ssn=RIGHT.ssn      
				AND TRIM(LEFT.prim_range+LEFT.predir+LEFT.prim_name+LEFT.suffix+LEFT.postdir+LEFT.unit_desig+LEFT.sec_range,ALL)=RIGHT.address
			, x(LEFT, RIGHT), LEFT OUTER, LOOKUP) +
/*S*/	// skip this
	JOIN(hdr, qry(class='FLCSN'), 
/*FLCSN*/	LEFT.fname=RIGHT.fname AND LEFT.lname=RIGHT.lname AND LEFT.ssn=RIGHT.ssn AND LEFT.city_name=RIGHT.city AND LEFT.st=RIGHT.state
			, x(LEFT, RIGHT), LEFT OUTER, LOOKUP) +
	JOIN(hdr, qry(class='FMLN'), 
/*FMLN*/	LEFT.fname=RIGHT.fname AND LEFT.mname=RIGHT.mname AND LEFT.lname=RIGHT.lname AND LEFT.ssn=RIGHT.ssn
			, x(LEFT, RIGHT), LEFT OUTER, LOOKUP) +
/*FM*/	// skip this
/*FCS*/	// skip this       
	JOIN(hdr, qry(class='FMLSZ'), 
/*FMLSZ*/	LEFT.fname=RIGHT.fname AND LEFT.mname=RIGHT.mname AND LEFT.lname=RIGHT.lname AND LEFT.st=RIGHT.state AND LEFT.zip=RIGHT.zip
			, x(LEFT, RIGHT), LEFT OUTER, LOOKUP) +
	JOIN(hdr, qry(class='FLACSN'), 
/*FLACSN*/	LEFT.fname=RIGHT.fname AND LEFT.lname=RIGHT.lname AND LEFT.ssn=RIGHT.ssn AND
					LEFT.city_name=RIGHT.city AND LEFT.st=RIGHT.state 
				AND TRIM(LEFT.prim_range+LEFT.predir+LEFT.prim_name+LEFT.suffix+LEFT.postdir+LEFT.unit_desig+LEFT.sec_range,ALL)=RIGHT.address
			, x(LEFT, RIGHT), LEFT OUTER, LOOKUP) +
/*FS*/	// skip this
	JOIN(hdr, qry(class='AS'), 
/*AS*/		LEFT.st=RIGHT.state
				AND TRIM(LEFT.prim_range+LEFT.predir+LEFT.prim_name+LEFT.suffix+LEFT.postdir+LEFT.unit_desig+LEFT.sec_range,ALL)=RIGHT.address
			, x(LEFT, RIGHT), LEFT OUTER, LOOKUP) +
	JOIN(hdr, qry(class='FACSZ'), 
/*FACSZ*/	LEFT.fname=RIGHT.fname AND LEFT.city_name=RIGHT.city AND LEFT.st=RIGHT.state AND LEFT.zip=RIGHT.zip    
				AND TRIM(LEFT.prim_range+LEFT.predir+LEFT.prim_name+LEFT.suffix+LEFT.postdir+LEFT.unit_desig+LEFT.sec_range,ALL)=RIGHT.address
			, x(LEFT, RIGHT), LEFT OUTER, LOOKUP) +
/*CS*/	// skip this
	JOIN(hdr, qry(class='LASZ'), 
/*LASZ*/	LEFT.lname=RIGHT.lname AND LEFT.st=RIGHT.state AND LEFT.zip=RIGHT.zip
				AND TRIM(LEFT.prim_range+LEFT.predir+LEFT.prim_name+LEFT.suffix+LEFT.postdir+LEFT.unit_desig+LEFT.sec_range,ALL)=RIGHT.address
			, x(LEFT, RIGHT), LEFT OUTER, LOOKUP) +
	JOIN(hdr, qry(class='ACSZN'), 
/*ACSZN*/	LEFT.ssn=RIGHT.ssn AND LEFT.city_name=RIGHT.city AND LEFT.st=RIGHT.state AND LEFT.zip=RIGHT.zip     
				AND TRIM(LEFT.prim_range+LEFT.predir+LEFT.prim_name+LEFT.suffix+LEFT.postdir+LEFT.unit_desig+LEFT.sec_range,ALL)=RIGHT.address
			, x(LEFT, RIGHT), LEFT OUTER, LOOKUP) +
/*F*/	// skip this
	JOIN(hdr, qry(class='FLSZN'), 
/*FLSZN*/	LEFT.fname=RIGHT.fname AND LEFT.lname=RIGHT.lname AND LEFT.ssn=RIGHT.ssn
					AND LEFT.st=RIGHT.state AND LEFT.zip=RIGHT.zip
			, x(LEFT, RIGHT), LEFT OUTER, LOOKUP) +
	JOIN(hdr, qry(class='FLAC'), 
/*FLAC*/	 LEFT.fname=RIGHT.fname AND LEFT.lname=RIGHT.lname AND LEFT.city_name=RIGHT.city
				AND TRIM(LEFT.prim_range+LEFT.predir+LEFT.prim_name+LEFT.suffix+LEFT.postdir+LEFT.unit_desig+LEFT.sec_range,ALL)=RIGHT.address
			, x(LEFT, RIGHT), LEFT OUTER, LOOKUP) +
	JOIN(hdr, qry(class='FLZ'), 
/*FLZ*/		LEFT.fname=RIGHT.fname AND LEFT.lname=RIGHT.lname AND LEFT.zip=RIGHT.zip
			, x(LEFT, RIGHT), LEFT OUTER, LOOKUP) +
	JOIN(hdr, qry(class='FMLACSZ'), 
/*FMLACSZ*/ LEFT.fname=RIGHT.fname AND LEFT.mname=RIGHT.mname AND LEFT.lname=RIGHT.lname
				AND LEFT.city_name=RIGHT.city AND LEFT.st=RIGHT.state AND LEFT.zip=RIGHT.zip
				AND TRIM(LEFT.prim_range+LEFT.predir+LEFT.prim_name+LEFT.suffix+LEFT.postdir+LEFT.unit_desig+LEFT.sec_range,ALL)=RIGHT.address
			, x(LEFT, RIGHT), LEFT OUTER, LOOKUP) +
	JOIN(hdr, qry(class='FMLCSZN'), 
/*FMLCSZN*/	LEFT.fname=RIGHT.fname AND LEFT.mname=RIGHT.mname AND LEFT.lname=RIGHT.lname
				AND LEFT.ssn=RIGHT.ssn AND LEFT.city_name=RIGHT.city AND LEFT.st=RIGHT.state AND LEFT.zip=RIGHT.zip
			, x(LEFT, RIGHT), LEFT OUTER, LOOKUP) +
	JOIN(hdr, qry(class='LC'), 
/*LC*/		LEFT.lname=RIGHT.lname AND LEFT.city_name=RIGHT.city
			, x(LEFT, RIGHT), LEFT OUTER, LOOKUP) +
	JOIN(hdr, qry(class='CSZN'), 
/*CSZN*/	LEFT.ssn=RIGHT.ssn AND LEFT.city_name=RIGHT.city AND LEFT.st=RIGHT.state AND LEFT.zip=RIGHT.zip
			, x(LEFT, RIGHT), LEFT OUTER, LOOKUP) +
/*L*/	// skip
	JOIN(hdr, qry(class='MLS'), 
/*MLS*/		LEFT.mname=RIGHT.mname AND LEFT.lname=RIGHT.lname AND LEFT.st=RIGHT.state
			, x(LEFT, RIGHT), LEFT OUTER, LOOKUP) +
	JOIN(hdr, qry(class='LSZ'), 
/*LSZ*/		LEFT.lname=RIGHT.lname and LEFT.st=RIGHT.state AND LEFT.zip=RIGHT.zip
			, x(LEFT, RIGHT), LEFT OUTER, LOOKUP) +
	JOIN(hdr, qry(class='FMLSN'), 
/*FMLSN*/	LEFT.fname=RIGHT.fname AND LEFT.mname=RIGHT.mname AND LEFT.lname=RIGHT.lname
					AND LEFT.st=RIGHT.state and LEFT.ssn=RIGHT.ssn
			, x(LEFT, RIGHT), LEFT OUTER, LOOKUP) +
	JOIN(hdr, qry(class='FMN'), 
/*FMN*/		LEFT.fname=RIGHT.fname AND LEFT.mname=RIGHT.mname AND LEFT.ssn=RIGHT.ssn
			, x(LEFT, RIGHT), LEFT OUTER, LOOKUP) +
	JOIN(hdr, qry(class='LN'), 
/*LN*/		LEFT.lname=RIGHT.lname AND LEFT.ssn=RIGHT.ssn
			, x(LEFT, RIGHT), LEFT OUTER, LOOKUP) +
	JOIN(hdr, qry(class='FZ'), 
/*FZ*/		LEFT.fname=RIGHT.fname AND LEFT.zip=RIGHT.zip
			, x(LEFT, RIGHT), LEFT OUTER, LOOKUP) +
	JOIN(hdr, qry(class='FMLCSN'), 
/*FMLCSN*/	LEFT.fname=RIGHT.fname AND LEFT.mname=RIGHT.mname AND LEFT.lname=RIGHT.lname AND
					LEFT.ssn=RIGHT.ssn AND LEFT.city_name=RIGHT.city AND LEFT.st=RIGHT.state
			, x(LEFT, RIGHT), LEFT OUTER, LOOKUP) +
	JOIN(hdr, qry(class='LZ'), 
/*LZ*/		LEFT.lname=RIGHT.lname AND LEFT.zip=RIGHT.zip
			, x(LEFT, RIGHT), LEFT OUTER, LOOKUP) +
	JOIN(hdr, qry(class='FMLA'), 
/*FMLA*/	LEFT.fname=RIGHT.fname AND LEFT.mname=RIGHT.mname AND LEFT.lname=RIGHT.lname
				AND TRIM(LEFT.prim_range+LEFT.predir+LEFT.prim_name+LEFT.suffix+LEFT.postdir+LEFT.unit_desig+LEFT.sec_range,ALL)=RIGHT.address
			, x(LEFT, RIGHT), LEFT OUTER, LOOKUP);

			
OUTPUT(q,, '~thor400_88::csalvo::hdrqueryx',COMPRESSED,OVERWRITE);

EXPORT BWR_HdrQuery := '';