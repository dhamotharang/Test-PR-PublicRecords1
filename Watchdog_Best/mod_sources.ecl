IMPORT MDR, Watchdog_V2, header, Python, ut, codes;
EXPORT mod_sources := MODULE

	lfn := '~thor::watchdog_best::sources';
	rSources := RECORD
		string2		src;
		string48	description;
		string1		glb;
		string1		non_glb;
		string1		marketing;
	END;
	export sources := dataset(lfn, rsources, CSV(Heading(1)));	
	
	export dGlb := DICTIONARY(sources(glb='X'), {src});
	export dNonglb := DICTIONARY(sources(non_glb='X'), {src});
	export dMarketing := DICTIONARY(sources(marketing='X'), {src});
	export dDPPA := DICTIONARY(sources, {src});

	export flavors := 
					ENUM(UNSIGNED4,
								glb                      = 1b,
								glb_nonutil              = 10b,
								glb_nonen                = 100b,
								glb_noneq                = 1000b,
								glb_nonen_noneq          = 10000b,
								nonglb                   = 100000b,
								nonglb_noneq             = 1000000b,
								marketing								 = 10000000b,
								d2c											 = 100000000b,			// direct to consumer
								dppa										 = 1000000000000b		// dppa
					);
				
	export dsD2c := codes.file_codes_v3_in(long_flag = 'N' and 
						field_name2 = 'ALLOW' and file_name = 'PERSON-HEADER' and field_name = 'CONSUMER-PORTAL' 
						);						

	export dD2c := DICTIONARY(dsD2c, {code});

	
	//shared glb(string2 src) := ~mdr.Source_is_DPPA(src) AND NOT mdr.sourcetools.sourceisonprobation(src)
	//											AND src != mdr.sourcetools.src_TU_CreditHeader;
												//AND MDR.SourceTools.SourceIsGLB(src);
	export glb(string2 src) := src in dGlb OR src='QH';
	shared utils := ['ZK', 'ZT', 'UT', 'UW'];
	export glb_nonutil(string2 src) := glb(src) AND src NOT IN utils;
	export glb_nonen_noneq(string2 src) := glb(src) AND src NOT IN ['EN','EQ'];
	export glb_noneq(string2 src) := glb(src) AND src<>'EQ';	
	export glb_nonen(string2 src) := glb(src) AND src<>'EN';	
	
	//export nonglb(string2 src) := ~mdr.Source_is_DPPA(src) AND NOT mdr.sourcetools.sourceisonprobation(src)
	//												AND src != mdr.sourcetools.src_TU_CreditHeader
	//												AND ~Mdr.sourcetools.SourceIsGLB(src);
	export nonglb(string2 src) := src in dNonglb;												
	export nonglb_noneq(string2 src) := nonGlb(src) AND src<>'EQ';
  export marketing(string2 src) := src in dMarketing;
  export dppa(string2 src) := src in dDPPA OR mdr.sourcetools.SourceIsDPPA(src);
  export d2c(string2 src) := src in dD2c;
	

	export unsigned src2bmap(string src) := 
								IF(glb(src), flavors.glb, 0)
						|		IF(glb_noneq(src), flavors.glb_noneq, 0)
						|		IF(glb_nonen(src), flavors.glb_nonen, 0)
						|		IF(glb_nonen_noneq(src), flavors.glb_nonen_noneq, 0)
						|		IF(nonGlb(src), flavors.nonglb, 0)
						|		IF(nonglb_noneq(src), flavors.nonglb_noneq, 0)
						|		IF(marketing(src), flavors.marketing, 0)
						|		IF(d2c(src), flavors.d2c, 0)
						|		IF(dppa(src), flavors.dppa, 0)
				;


 string sortstr(string s) := EMBED(Python)		
    return ''.join(sorted(s))
 ENDEMBED;

	BOOLEAN bit_test(unsigned x, unsigned bit) := IF((x & bit) = 0, false, true);

	// the following attribute is for development and debugging
	// it returns a string representation of the sources rather than a bitmpa
	export string src2str(unsigned x) := FUNCTION
					s := 
								IF(bit_test(x, flavors.glb), 'GLB', '')
						+		IF(bit_test(x, flavors.glb_nonen), ' NONEN', '')
						+		IF(bit_test(x, flavors.glb_noneq), ' NONEQ', '')
						+		IF(bit_test(x, flavors.glb_nonen_noneq), ' NONENEQ', '')
						+		IF(bit_test(x, flavors.nonglb), ' NONGLB', '')
						+		IF(bit_test(x, flavors.nonglb_noneq), ' NONGLBEQ', '')
						+		IF(bit_test(x, flavors.marketing), ' MARKETING', '')
						+		IF(bit_test(x, flavors.d2c), ' D2C', '')
						+		IF(bit_test(x, flavors.dppa), ' DPPA', '')
				;
				
		return TRIM(s, left, right);
	END;
END;