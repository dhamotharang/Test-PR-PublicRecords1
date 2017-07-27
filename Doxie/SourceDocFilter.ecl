/*
	---------------------------
	A filter to be applied to RIDs returned by doxie.HeaderSource_Service.
	This has been requested for FCOl, TCOL, and COL (see bug #138025).	
	---------------------------
	Usage: see _selftest() below.
	---------------------------
*/
EXPORT SourceDocFilter := MODULE

	// Filter categories (as defined in Doxie_Raw.Occurrence.ridSrc_to_desc).
	EXPORT STRING fLOCATOR		:= 'LOCATOR';
	EXPORT STRING fDECEASED		:= 'DECEASED';
	EXPORT STRING fUTILITY		:= 'UTILITY';

	// A bitmask for each filter category.
	EXPORT UNSIGNED bLOCATOR  := 00000000000000001b; // 1
	EXPORT UNSIGNED bDECEASED := 00000000000000010b; // 2
	EXPORT UNSIGNED bUTILITY  := 00000000000000100b; // 4

	EXPORT GetBitmask(SET OF STRING pAllowedSrcs = []) := 
			IF(fLOCATOR 	in pAllowedSrcs, bLOCATOR,		0) +	
			IF(fDECEASED	in pAllowedSrcs, bDECEASED, 	0) +	
			IF(fUTILITY 	in pAllowedSrcs, bUTILITY,		0);

	// Returns true if a given source is allowed under the specified filter bitmask.
	EXPORT BOOLEAN KeepSource(UNSIGNED pFilter, STRING pSrcCategory) := 
				 pFilter = 0																															 	 OR // if filter is not enabled, keep all sources by default...
				(pFilter & bLOCATOR 	> 0	AND	REGEXFIND('.*LOCATOR', 	pSrcCategory, NOCASE)) OR 
				(pFilter & bDECEASED > 0	AND	REGEXFIND('.*DECEASED', pSrcCategory, NOCASE)) OR
				(pFilter & bUTILITY 	> 0	AND	REGEXFIND('.*UTILITY', 	pSrcCategory, NOCASE));

	EXPORT TranslateBitmask(UNSIGNED pFilter) := FUNCTION
		lfil := record string desc; end;
		RETURN	
			IF(pFilter & bLOCATOR 	> 0, DATASET([{fLOCATOR }], lfil)) +
			IF(pFilter & bDECEASED 	> 0, DATASET([{fDECEASED}], lfil)) +
			IF(pFilter & bUTILITY		> 0, DATASET([{fUTILITY }], lfil))	+
			DATASET([], lfil);									
	END;

	/////////////////////////////////////////////////////////////////////////	
	/////////////////////////////////////////////////////////////////////////	
	/////////////////////////////////////////////////////////////////////////	
	
	
	EXPORT _selftest() := MACRO
	  IMPORT Doxie_Raw;
		//SET OF STRING src_set := [];
		SET OF STRING src_set := ['LOCATOR','UTILITY', 'DECEASED'];		
		sdocfilter := doxie.SourceDocFilter.GetBitmask(src_set);

		l	:= record
			string2 src;
			string	ext_src := '';
			boolean keepit := false;
		end;

		ds0 := DATASET([
							{'PH'},{'SD'},{'FI'},{'FA'},{'E3'},{'EQ'},{'UT'},{'D2'}, {'TN'}
							], l);
					
		ds1 := PROJECT(ds0, transform(l,
								_ext_src := Doxie_Raw.Occurrence.ridSrc_to_desc(left.src);
								self.src := left.src;
								self.ext_src := _ext_src;
								self.keepit := doxie.SourceDocFilter.KeepSource(sdocfilter, _ext_src);
							));
							
		OUTPUT(sdocfilter, NAMED('sdocfilter'));		
		OUTPUT(doxie.SourceDocFilter.TranslateBitmask(sdocfilter), NAMED('sdocTrans'));		
		OUTPUT(ds1, NAMED('ds1'));		
	ENDMACRO;
	
END;