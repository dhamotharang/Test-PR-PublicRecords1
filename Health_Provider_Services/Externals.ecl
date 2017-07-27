EXPORT Externals := MODULE
  IMPORT SALT25,Health_Provider_Services;// Gather up the UID counts from each of the children - provides 'we also found' capability
  AllEfr0 := ;
  m := GROUP(AllEfr0,LNPID);
  r := ROLLUP(m,GROUP,TRANSFORM(Ext_Layouts.EFR_Layout,SELF.Hits := PROJECT(ROWS(LEFT),Ext_Layouts.EFR_Child),SELF := LEFT));
EXPORT EFR := INDEX(r,{LNPID},{r},'~key::Health_Provider_Services::LNPID::efr');
EXPORT BuildEFR := BUILDINDEX(EFR,OVERWRITE);
// Act as a central construction point for building ALL the external files.
// In reality - most of them will be individually built to different timescales
EXPORT BuildAll := SEQUENTIAL(PARALLEL(),BuildEFR);
// Construct a fetch interface for a 'comp report' of all the external files
EXPORT FetchParams := MODULE,VIRTUAL // Derive from here to change some of the default values
  EXPORT SET OF INTEGER2 ToFetch := []; // Remove elements to prevent externals being fetched
END;
EXPORT Layout := RECORD
  UNSIGNED4 Ref; // Will be the reference from the request
END;
EXPORT Fetch(DATASET(Health_Provider_Services.Process_xLNPID_Layouts.id_stream_layout) ins,FetchParams P=FetchParams) := FUNCTION
  Layout Get(DATASET(Health_Provider_Services.Process_xLNPID_Layouts.id_stream_layout) ids) := TRANSFORM
    SELF.Ref := ids[0].UniqueId;
  END;
  ig := GROUP(ins,UniqueId,ALL);
  RETURN ROLLUP(ig,GROUP,Get(ROWS(LEFT)));
END;
END;

