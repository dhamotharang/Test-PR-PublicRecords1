//Get characteristics/attributes about a subject from Watchdog.Key_Supplemental
//NOTE: DL sourced characteristics are selected before other sources with the exception of RACE. 
//  Height is greatest found and latest date
//  Race is most reported value and lastest date
//  All others lastest date.
IMPORT Header, Watchdog, ut, doxie, iesp;

EXPORT fn_getAttributes(integer subjectDid, 
												integer dppa_purpose = 0,
												integer glb_purpose = 0,
                        boolean no_scrub = true, 
												boolean probation_override_value = false,
												string industry_class_value = ''												
												) := function
	
	mod_access := MODULE (doxie.functions.GetGlobalDataAccessModuleTranslated (AutoStandardI.GlobalModule ()))
    EXPORT unsigned1 glb := glb_purpose;
    EXPORT unsigned1 dppa := dppa_purpose;
    EXPORT boolean probation_override := probation_override_value;
    EXPORT string5 industry_class := industry_class_value;
    EXPORT boolean no_scrub := ^.no_scrub;
  END; 

	dppa_ok := mod_access.isValidDPPA();
	glb_ok := mod_access.isValidGLB();												

  //get single record from watchdogSupplemental key by DID (ie best supplemental)
	attributes := Watchdog.Key_Supplemental(keyed(l_did = subjectDid));
	aRec := attributes[1];
	//seperate out child datasets for processing
	aGenders := aRec.gender;
	aHairColors := aRec.hair_color;
	aEyeColors := aRec.eye_color;
	aHeights := aRec.height;
	aWeights := aRec.weight;
	aRaces := aRec.race;
	aSmts := aRec.smt;
	
	//applying GLB, DPPA restrictions by source
	tmpFiller := record
	 string pflag3 := '';
	 integer dt_nonglb_last_seen := 1;  //all sources are non-glb so force non-glb restrictions used by AutoStandardI.PermissionI_Tools.glb.HeaderIsPreGLB()
	 integer dt_first_seen := 0;        //only here because of preglb header that is hardcoded into restrictions macro
	 string ssn := '';                  //only here because of preglb header that is hardcoded into restrictions macro
	 integer dob := 0;                  //only here because of preglb header that is hardcoded into restrictions macro
	 unsigned did := 0;                  //only here because of preglb header that is hardcoded into restrictions macro
	 string valid_ssn := '';            //only here because of preglb header that is hardcoded into restrictions macro
	 string name_suffix := '';          //only here because of preglb header that is hardcoded into restrictions macro
	 string prim_name := '';            //only here because of preglb header that is hardcoded into restrictions macro
	 string dppa_purpose := '';         //only here because of preglb header that is hardcoded into restrictions macro
	 unsigned rid := 0;
	end;
	tmpRecord := record
   tmpFiller;
	 string src := '';
 	 string date := '';
	 string description := '';
	 integer numFound := 0;
	end;
	tmpRecord fillGenders(aGenders l) := transform
		self.src := l.source;
	  self.date := (string)l.date;
	  self.description := l.gender;
	end;
	tmpRecord fillHairColors(aHairColors l) := transform
		self.src := l.source;
	  self.date := (string)l.date;
	  self.description := l.hair_color;
	end;
	tmpRecord fillEyeColors(aEyeColors l) := transform
		self.src := l.source;
	  self.date := (string)l.date;
	  self.description := l.eye_Color;
	end;
	tmpRecord fillHeights(aHeights l) := transform
		self.src := l.source;
	  self.date := (string)l.date;
	  self.description := l.height;
	end;
	tmpRecord fillWeights(aWeights l) := transform
		self.src := l.source;
	  self.date := (string)l.date;
	  self.description := l.weight;
	end;
	tmpRecord fillRaces(aRaces l) := transform
		self.src := l.source;
	  self.date := (string)l.date;
	  self.description := l.race;
		self.numFound := l.total;
	end;
	tmpRecord fillSmts(aSmts l) := transform
		self.src := l.source;
	  self.date := (string)l.date;
	  self.description := l.smt;
	end;
	//fill records layouts needed for Header.MAC_GlbClean_Header
	tmpGenders := project(aGenders,fillGenders(left));
	tmpHairColors := project(aHairColors,fillHairColors(left));
	tmpEyeColors := project(aEyeColors,fillEyeColors(left));
	tmpHeights := project(aHeights,fillHeights(left));
	tmpWeights := project(aWeights,fillWeights(left));
	tmpRaces := project(aRaces,fillRaces(left));
	tmpSmts := project(aSmts,fillSmts(left));
	
	//apply DPPA and GLB restrictions
	Header.MAC_GlbClean_Header(tmpGenders, outGenders, , , mod_access);
	Header.MAC_GlbClean_Header(tmpHairColors, outHaircolors, , , mod_access);
	Header.MAC_GlbClean_Header(tmpEyeColors, outEyecolors, , , mod_access);
	Header.MAC_GlbClean_Header(tmpHeights, outHeights, , , mod_access);
	Header.MAC_GlbClean_Header(tmpWeights, outWeights, , , mod_access);
	Header.MAC_GlbClean_Header(tmpRaces, outRaces, , , mod_access);
	Header.MAC_GlbClean_Header(tmpSmts, outSmts, , , mod_access);
	
	//Sort to put "top ranked" value found on top as 1st record
	//DL sourced values have highest rank followed by most recent found (exceptions are height and race).
	sortedGenders := sort(outGenders, -(src in MDR.sourceTools.set_dl),-date);
	sortedHairColors := sort(outHairColors,-(src in MDR.sourceTools.set_dl), -date);	
	sortedEyeColors := sort(outEyeColors,-(src in MDR.sourceTools.set_dl), -date);
	sortedHeights := sort(outHeights,-(src in MDR.sourceTools.set_dl), -(integer)description, -date);  //greatest height 
	sortedWeights := sort(outWeights,-(src in MDR.sourceTools.set_dl), -date);
	sortedRaces := sort(outRaces, -numFound,-date);  //most reported race
	sortedSmt := sort(outSmts, -(src in MDR.sourceTools.set_dl),-date);	
	
	//load record with the single best value from all the top records based on sort above.
	topGender := sortedGenders[1];
	topHairColor := sortedHairColors[1];
	topEyeColor := sortedEyeColors[1];
	topHeight := sortedHeights[1];
	topWeight := sortedWeights[1];
	topRace := sortedRaces[1];
	topSmt := sortedSmt[1];

	//load attributes record with Top values for each attribute
	iesp.smartlinxreport.t_SLRAttributes loadAttributes() := transform
	  self.gender := topGender.description;
		self.hairColor := topHairColor.description;
		self.eyeColor := topEyeColor.description;
		self.height := topHeight.description;
	  self.weight := topWeight.description;
	  self.race := topRace.description;
	 	self.ScarsMarksTattoos := topSmt.description;
	  self.DateLastSeen.gender := iesp.ECL2ESP.toDateString8(topGender.date);
		self.DateLastSeen.HairColor := iesp.ECL2ESP.toDateString8(topHairColor.date);
		self.DateLastSeen.EyeColor := iesp.ECL2ESP.toDateString8(topEyeColor.date);
		self.DateLastSeen.Height := iesp.ECL2ESP.toDateString8(topHeight.date);
	  self.DateLastSeen.Weight := iesp.ECL2ESP.toDateString8(topWeight.date);
	  self.DateLastSeen.Race := iesp.ECL2ESP.toDateString8(topRace.date);
	  self.DateLastSeen.ScarsMarksTattoos := iesp.ECL2ESP.toDateString8(topSmt.date);
	end;
	
	
  return ROW(loadAttributes());  //returns record not a dataset!
	
	
end;
