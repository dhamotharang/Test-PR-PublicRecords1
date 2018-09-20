export MAC_GlbClean_Header(infile,outfile, batch = false, IsFCRA = false, modAccess) := macro

//TODO: check if glb_ok nad dppa_ok can be moved here
import mdr, ut, doxie, suppress, header, codes;

#uniquename(isUtility)
%isUtility% := modAccess.industry_class = 'UTILI';

#uniquename(appType)
%appType% := modAccess.application_type;

#uniquename(suppressDMVInfo)
%suppressDMVInfo% :=  modAccess.suppress_dmv;

#uniquename(oformat)
%oformat% := record
  infile;
  boolean glb;
  boolean dppa;
end;

// to check DL permissions we need to know if record's source is non-DL, general DL, or Experian-related
#uniquename(dl_rec)
%dl_rec% := record
  infile;
  integer dl_src; //0 -- non-DL, 1 -- general DL, 2 -- Experian DL
end;

#uniquename(AssignDLSource)
%dl_rec% %AssignDLSource% (infile le) := TRANSFORM
  dppa_check := mdr.SourceTools.SourceIsDPPA(le.src); // check the set of sources
  //? TODO: export isExperian from AutoStandardI/PermissionI_Tools
  isExperian := MDR.sourceTools.SourceIsExperianVehicle (le.src); // old *E, but not DE or FE

  SELF.dl_src := IF (~dppa_check, 0, IF (IsExperian, 2, 1));
  SELF := le;
END;

// decide which DL permissions to apply; show a utility record only if not a utility customer
#uniquename(Fetch1);
%Fetch1% := PROJECT (infile, %AssignDLSource% (LEFT)) (~mdr.SourceTools.SourceIsUtility(src) OR ~%isUtility%);


// Check both DL and GLB permissions
#uniquename(into)
%oformat% %into% (%dl_rec% le, codes.Key_Codes_V3 R) := TRANSFORM
  _dppa_ok := #if (batch) le. #end dppa_ok;
  _dppa    := #if (batch) le.dppa_purpose #else modAccess.dppa; #end;
  //? TODO: interestingly enough, also skip for batch
  SELF.dppa := IF (le.dl_src = 0, FALSE, IF (_dppa_ok AND (R.file_name = ''), TRUE, SKIP));

  SELF.glb := ~modAccess.isHeaderPreGLB ((unsigned3)le.dt_nonglb_last_seen, (unsigned3)le.dt_first_seen, le.src);

  // if we filled in the ssn with a utility ssn and it's a utility customer, blank out
  clean_ssn := IF(le.pflag3 in ['U','X'],'',le.ssn);
  self.ssn := IF ( ~self.dppa or _dppa IN [1,4,6], clean_ssn, '' );
  self.valid_ssn := IF ( le.ssn<>'' AND self.ssn='' ,'S',le.valid_ssn);
	self.name_suffix := IF(ut.is_unk(le.name_suffix),'',le.name_suffix);
	// scrub prim names from death records
	self.prim_name := IF(mdr.SourceTools.SourceIsDeath(le.src), '', le.prim_name);
  self := le;
END;

#uniquename(Fetch2);
%Fetch2% := JOIN (%Fetch1%, codes.Key_Codes_V3,
                  (LEFT.dl_src != 0) AND // zero means do not need to check DL permission
                  KEYED (RIGHT.file_name='GENERAL') AND
                  KEYED (RIGHT.field_name = IF (LEFT.dl_src = 1, 'DL-PURPOSE', 'EXPERIAN-DL-PURPOSE')) AND
                  // header/translateSource returns a full source name, but all DL sources' names 
                  // start from have 2-char state abbreviation
                  KEYED (RIGHT.field_name2 = (string2) header.translateSource (LEFT.src)) AND
                  KEYED (RIGHT.code = (string1) (#if(batch) LEFT.dppa_purpose #else modAccess.dppa #end)),
                  %into% (LEFT, RIGHT),
                  LEFT OUTER, 
                  LIMIT (0), KEEP (1)); // limit(0) since we checking just exists condition


// Check if records are on probation
#uniquename(CheckProbation);
%oformat% %CheckProbation% (%oformat% L, codes.Key_Codes_V3 R) := TRANSFORM
  // if we have a match, then this record is on probabtion; check if probation is overriden.
  boolean toDrop := (R.long_desc != '') AND 
                     ~(
                       #if (batch)
                         L.probation_override_value
                       #else
                         modAccess.probation_override 
                       #end
                       and l.src IN mdr.Probation_Smartlinx_Override);
  // in case of batch blank the record, otherwise skip.
  // TODO: this is contradict the usage above and below, where filters are applied freely.
  #if (batch)
    SELF.seq := L.seq;
    SELF := IF (not toDrop, L);
  #else
    SELF.src := IF (not toDrop, L.src, SKIP);
    SELF := L;
  #end
END;

#uniquename(ds_prob);
%ds_prob% := JOIN (%Fetch2%, codes.Key_Codes_V3,
                   KEYED (RIGHT.file_name = 'HEADER_MASTER_V5') AND
                   KEYED (RIGHT.field_name = 'PROBATION') AND
                   KEYED (RIGHT.field_name2 = '') AND
                   KEYED (RIGHT.code = LEFT.src),
                   %CheckProbation% (LEFT, RIGHT),
                   LEFT OUTER,
                   LIMIT (0), KEEP (1));

#uniquename(Fetch3);
%Fetch3% := IF (modAccess.no_scrub, %Fetch2%, %ds_prob%); //no_scrub is the same as input parameter 'Raw'


#uniquename(Fetch3a)
#uniquename(Fetch3b)
Suppress.MAC_Suppress(%Fetch3%,%Fetch3a%,%appType%,Suppress.Constants.LinkTypes.SSN,ssn,,,batch);
Suppress.MAC_Suppress(%Fetch3a%,%Fetch3b%,%appType%,Suppress.Constants.LinkTypes.DID,did,,,batch);

#uniquename(Fetch3c)
#uniquename(Fetch3c_minors_cleaned)
%Fetch3c_minors_cleaned% := doxie.functions.MAC_FilterOutMinors (%Fetch3b%,,dob, modAccess.show_minors);
%Fetch3c% := if (IsFCRA, %Fetch3b%, %Fetch3c_minors_cleaned%);

// Filter out any specific source(s) based upon the DataRestrictionMask.
// As of October 2009 only Experian Credit Header is possibly being filtered out.
#uniquename(Fetch3d)
%Fetch3d% := doxie.functions.MAC_FilterSources (%Fetch3c%, src, modAccess.DataRestrictionMask);

#uniquename(Fetch3e0)
#uniquename(Fetch3e)
%Fetch3e0% := Header.FilterDMVInfo(%Fetch3d%);
%Fetch3e% := if(%suppressDMVInfo% and modAccess.isConsumer () and ~isFCRA, %Fetch3e0%, %Fetch3d%);

outfile := %Fetch3e%(glb_ok or ~glb);

endmacro;