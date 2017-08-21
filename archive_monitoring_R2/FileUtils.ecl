FS := FileServices;

EXPORT FileUtils := MODULE

  // Get a short file name (segment after last '::')
  shared integer2 GetFileNamePosition (const varstring fullname) := BEGINC++
    char* p_res = strrchr (fullname, ':');
    size32_t cpp_ind = 0;
    if (p_res != NULL) cpp_ind = p_res - fullname + 1;
    return cpp_ind + 1; // adjust for ECL indeces
  ENDC++;
  EXPORT string GetFileName (string str) := str [GetFileNamePosition (str)..];

  // trim all trailing chars which are less that \u0020
  shared integer GetLastValidChar (const string src) := BEGINC++
    int i = 0; 
    for (i= lenSrc-1; i > 0; i--) {
      if (src[i] > 32) break;
    }
    return i + 1; // adjust for ECL indeces
  ENDC++;
  EXPORT string trim_u20 (string str) := str [1..GetLastValidChar (str)];


  // get file name without leading '~'
  EXPORT string GetNoTildaName (string fname) := IF (fname[1] = '~', fname [2..], fname);

  EXPORT string GetFileSuffix (string full_name) := FUNCTION
    // find last '.'
    ext_num := stringlib.StringFindCount (full_name, '.');
    ext_start := stringlib.stringfind (full_name, '.', ext_num);
    short_name := IF (ext_num = 0, full_name, full_name [1..ext_start-1]);

    // find last '_'
    underscore_count := stringlib.StringFindCount (short_name, '_');
    undescore_start := stringlib.stringfind (short_name, '_', underscore_count);
    suffix := IF (underscore_count = 0, short_name, short_name [undescore_start+1..]);
    return suffix;
  END;

  EXPORT string SetVersion (string pFilenameTemplate, string pVersionString) :=
    RegExReplace('@version@', StringLib.stringtolowercase(pFilenameTemplate), pVersionString);

  EXPORT CreateSuperFile (string fname, boolean checkExistance) := 
    IF (~(checkExistance and FS.SuperFileExists (fname)), FS.CreateSuperFile (fname));

  EXPORT CreateAllSuperFiles (string fname_base, boolean checkExistance) := FUNCTION
    action := PARALLEL (
      CreateSuperFile (SetVersion (fname_base, Environment.QA_NAME), checkExistance),
      CreateSuperFile (SetVersion (fname_base, Environment.FATHER_NAME), checkExistance)
      // CreateSuperFile (SetVersion (fname_base, Environment.GR_FATHER_NAME), checkExistance),
      // CreateSuperFile (SetVersion (fname_base, Environment.GR_GR_FATHER_NAME), checkExistance)
    );
    return action;
  END;

  // moves logical file from one super to another: both source and destination super files are cleared,
  // source-subfile is moved to dest-super, dest-subfile can be deleted upon request.
  // NOTE: only for simple superfiles (at most one subfile)
  EXPORT MoveLogicalFileSimple (string super_source, string super_dest, boolean delete_dest = false) := FUNCTION
    // NB following two strings get re-evaluated wherever used
    string lname_source := FS.GetSuperFileSubName(super_source, 1, true);
    string lname_dest := FS.GetSuperFileSubName(super_dest,1, true);
    // NB: FS.LogicalFileSuperOwners can be used here for double checking, if needed
    action := SEQUENTIAL (
      IF (~FS.SuperFileExists (super_dest), FS.CreateSuperFile (super_dest)),
      IF (FS.GetSuperFileSubCount (super_dest) > 0, 
          FS.RemoveSuperFile (super_dest, lname_dest, delete_dest)), //will fail if subfile belongs to some other superfile
      FS.AddSuperFile (super_dest, lname_source),
      FS.ClearSuperFile (super_source)
    );
    return IF (FS.SuperFileExists (super_source) AND  FS.GetSuperFileSubCount (super_source) > 0, action);
  END;

  
  EXPORT MoveSuperFiles (string fname_base, string lname, boolean checkExistance) := FUNCTION
    fname_qa := SetVersion (fname_base, Environment.QA_NAME);
    fname_father := SetVersion (fname_base, Environment.FATHER_NAME);
    fname_grandfather := SetVersion (fname_base, Environment.GR_FATHER_NAME);
 
    action := SEQUENTIAL (
      // MoveLogicalFileSimple (fname_grandfather, SetVersion (fname_base, Environment.GR_GR_FATHER_NAME), true),
      // MoveLogicalFileSimple (fname_father, fname_grandfather),
      MoveLogicalFileSimple (fname_qa, fname_father, true),
      IF (lname != '', FS.AddSuperFile (fname_qa, lname))
    );

    return action;
  END;

  // Same as above, but it inverse direction: father->qa, grand->father, etc.
  EXPORT RollbackSuperFiles (string fname_base) := FUNCTION
    fname_qa := SetVersion (fname_base, Environment.QA_NAME);
    fname_father := SetVersion (fname_base, Environment.FATHER_NAME);
    fname_grandfather := SetVersion (fname_base, Environment.GR_FATHER_NAME);
    fname_grandgrandfather := SetVersion (fname_base, Environment.GR_GR_FATHER_NAME);
 
    action := SEQUENTIAL (
      MoveLogicalFileSimple (fname_father, fname_qa, true),
      MoveLogicalFileSimple (fname_grandfather, fname_father),
      MoveLogicalFileSimple (fname_grandgrandfather, fname_grandfather)
    );
    return action;
  END;

  // this is to replace MoveLogicalFileSimple with new FIleServices.Promote...
  EXPORT set of string GetList (string fname_base) := FUNCTION
    return [
      SetVersion (fname_base, Environment.QA_NAME), 
      SetVersion (fname_base, Environment.FATHER_NAME)//, 
      // SetVersion (fname_base, Environment.GR_FATHER_NAME), 
      // SetVersion (fname_base, Environment.GR_GR_FATHER_NAME) 
    ];
  END;

  EXPORT GetFileNameShort (string full_name) := FUNCTION
    ext_num := stringlib.StringFindCount (full_name, '.');
    ext_start := stringlib.stringfind (full_name, '.', ext_num);
    fname := IF (ext_num > 0, full_name [1..ext_start-1], full_name);  
    return fname;
  END;

  // returns file name extension
  EXPORT GetFileExtension (string full_name) := FUNCTION
    ext_num := stringlib.StringFindCount (full_name, '.');
    ext_start := stringlib.stringfind (full_name, '.', ext_num);
    fextension := IF (ext_num > 0, full_name [ext_start+1..], '');  
    return fextension;
  END;

  EXPORT CleanMainFile (string fname) := FUNCTION
    ds := FileServices.SuperFileContents (fname);

    safe_move (string cname) := function
      string base_name := '~' + RegExReplace ('::' + Environment.QA_NAME + '::', cname, '::@version@::');
      return sequential (
               // ensure all superfiles exist
//               CreateAllSuperFiles (base_name, TRUE),
               MoveSuperFiles (base_name, '', TRUE) 
             );
    end;
    return NOTHOR (APPLY (ds, safe_move (name)));
  END;

  // Clean short term history fiels

  EXPORT CleanShortTermHistory () := FUNCTION // this function is obsolete...
    return parallel (
      CleanMainFile (Files.Names.ADDRESS_SHORT_TERM),
      CleanMainFile (Files.Names.Phone_SHORT_TERM)
    );
  END;

  EXPORT CleanSTHAddress () := FUNCTION
    return CleanMainFile (Files.Names.ADDRESS_SHORT_TERM);
  END;
  EXPORT CleanSTHPhone () := FUNCTION
    return CleanMainFile (Files.Names.PHONE_SHORT_TERM);
  END;
  EXPORT CleanSTHProperty () := FUNCTION
    return CleanMainFile (Files.Names.PROPERTY_SHORT_TERM);
  END;
  EXPORT CleanSTHPaw () := FUNCTION
    return CleanMainFile (Files.Names.PAW_SHORT_TERM);
  END;

  EXPORT GetUpdateJobFileNames (string customer_id, string fileName, string wuid_descriptor, string sub_dir = '') := FUNCTION
    string targetFileName := GetFileNameShort (fileName);    // file name without extension
    string root_dir := Files.NAMES.THOR_ROOT + customer_id + '::' + if (sub_dir != '', sub_dir + '::', '');
    
    ThisJobNames := MODULE (IUpdateJobFileNames)
      export string wuid := wuid_descriptor;
      export string customer_dir := root_dir;
      export string source := fileName;
      export string file_descriptor := stringlib.StringToUpperCase (GetFileSuffix (fileName));
      export string source_lz := Environment.LandingZone.sourcePath + customer_id + '/' + fileName;

      export string source_thor := Files.NAMES.THOR_ROOT + 'in::' + customer_id + '::' + targetFileName +
        // account for same file names (maybe is worth doing for all customers?)
        trim (IF (customer_id = 'SAC', '_' + wuid_descriptor, ''));
      export string verified := customer_dir + 'verified_batch';

      export string archive_ver  := customer_dir + '@version@::' + Files.NAMES.ARCHIVE;
      export string archive_qa   := SetVersion (archive_ver, Environment.QA_NAME);
      export string archive_file := customer_dir + targetFileName + '_archive_' + wuid;

      export string raw_ver  := customer_dir + '@version@::' + Files.NAMES.RAW;
      export string raw_qa   := SetVersion (raw_ver, Environment.QA_NAME);
      export string raw_file := customer_dir + targetFileName + '_raw_' + wuid;

      export string submonitor_ver  := customer_dir + '@version@::' + Files.NAMES.SUBMONITOR;
      export string submonitor_qa   := SetVersion (submonitor_ver, Environment.QA_NAME);
      export string submonitor_file := customer_dir + targetFileName + '_submonitor_' + wuid;

      export string sth_address_ver  := customer_dir + '@version@::' + Files.NAMES.STH_ADDRESS;
      export string sth_address_qa   := SetVersion (sth_address_ver, Environment.QA_NAME);
      export string sth_address_file := customer_dir + targetFileName + '_address_' + wuid;

      export string sth_phone_ver  := customer_dir + '@version@::' + Files.NAMES.STH_PHONE;
      export string sth_phone_qa   := SetVersion (sth_phone_ver, Environment.QA_NAME);
      export string sth_phone_file := customer_dir + targetFileName + '_phone_' + wuid;

      export string sth_prop_ver  := customer_dir + '@version@::' + Files.NAMES.STH_PROPERTY;
      export string sth_prop_qa   := SetVersion (sth_prop_ver, Environment.QA_NAME);
      export string sth_prop_file := customer_dir + targetFileName + '_prop_' + wuid;

      export string sth_paw_ver  := customer_dir + '@version@::' + Files.NAMES.STH_PAW;
      export string sth_paw_qa   := SetVersion (sth_paw_ver, Environment.QA_NAME);
      export string sth_paw_file := customer_dir + targetFileName + '_paw_' + wuid;

      export string report_ver  := customer_dir + '@version@::' + Files.NAMES.REPORT;
      export string report_qa   := SetVersion (report_ver, Environment.QA_NAME);
      export string report_file := customer_dir + targetFileName + '_report_' + wuid;
      export string report_despray := customer_id + '/' + targetFileName + '_' + WUID[2..] + '_REPORT.CSV';
    END;
    return ThisJobNames;
  END;

  EXPORT GetJobLog (IUpdateJobFileNames INames) := FUNCTION
    log_rec := record
      string32 name;
      string128 value := '';
    end;
    ds_main := DATASET ([
      {'WUID', INames.wuid}, 
      {'input file ', INames.source}, 
      {'input file (landing)', INames.source_lz}, 
      {'input file (THOR)', INames.source_thor}, 
      {'customer_dir', INames.customer_dir}, 
      {'monitor', Files.Names.MONITOR}, 
      {'archive super', INames.archive_qa}, 
      {'archive subfile', INames.archive_file}, 
      {'monitor raw super', INames.raw_qa}, 
      {'monitor raw subfile', INames.raw_file}, 
      {'submonitor super', INames.submonitor_qa}, 
      {'submonitor subfile', INames.submonitor_file}, 
      {'report super', INames.report_qa},
      {'report subfile', INames.report_file},
      //{'report despray', INames.report_despray},
      {'HISTORY'}, 
      {'address history', Files.Names.ADDRESS_SHORT_TERM}, 
      {'address history super',   INames.sth_address_qa}, 
      {'address history subfile', INames.sth_address_file}, 
      {'phone history', Files.Names.PHONE_SHORT_TERM}, 
      {'phone history super',   INames.sth_phone_qa}, 
      {'phone history subfile', INames.sth_phone_file}, 
      {'property history', Files.Names.PROPERTY_SHORT_TERM}, 
      {'property history super',   INames.sth_prop_qa}, 
      {'property history subfile', INames.sth_prop_file}, 
      {'paw history', Files.Names.PAW_SHORT_TERM}, 
      {'paw history super',   INames.sth_paw_qa}, 
      {'paw history subfile', INames.sth_paw_file} 
    ], log_rec);

    return ds_main;
  END;

END;