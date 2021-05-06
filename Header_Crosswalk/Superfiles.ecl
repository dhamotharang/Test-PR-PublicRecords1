IMPORT STD.File;

EXPORT Superfiles := MODULE

  SHARED SET OF STRING fn_superfile_list(STRING str_prefix, STRING str_suffix) := FUNCTION
    RETURN [
      str_prefix + 'QA' + str_suffix,
      str_prefix + 'Father' + str_suffix,
      str_prefix + 'GrandFather' + str_suffix
    ];
  END;

  EXPORT STRING fn_logical_filename(STRING str_prefix, STRING str_version, STRING str_suffix = '') := FUNCTION
    RETURN str_prefix + str_version + str_suffix;
  END;

  EXPORT proc_promote(STRING str_prefix, STRING str_version, STRING str_suffix) := FUNCTION
    
    // Promote @str_logical_filename to QA
    RETURN File.PromoteSuperFileList(
      superNames := fn_superfile_list(str_prefix, str_suffix),
      addHead := fn_logical_filename(str_prefix, str_version, str_suffix),
      delTail := TRUE
    );
  END;

  EXPORT proc_demote(STRING str_prefix, STRING str_suffix) := FUNCTION
    
    // Demote Father to QA and GrandFather to Father
    RETURN File.PromoteSuperFileList(
      superNames := fn_superfile_list(str_prefix, str_suffix),
      delTail := FALSE,
      reverse := TRUE
    );
  END;

  EXPORT fn_add_superfile(STRING str_superfile, STRING str_logicalfile) := FUNCTION
    RETURN SEQUENTIAL(
      File.StartSuperFileTransaction();
      File.AddSuperFile(str_superfile, str_logicalfile);
      File.FinishSuperFileTransaction();
    );
  END;

END;