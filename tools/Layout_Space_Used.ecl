import std;

EXPORT Layout_Space_Used :=
module

  fileinforecord := record(std.file.FsLogicalFileNameRecord) boolean superfile; integer8 size; string size_pretty;integer8 rowcount; string19 modified; string owner{maxlength(255)}; string cluster{maxlength(255)}; end;
  
  export FileInfo :=
  record
    fileinforecord;
    boolean isSubFile;
  end;

  export subsetcounts :=
  record
    unsigned          cnt_files       ;
    unsigned          TotalSpaceUsed  ;
    string            TotalSpacePretty;
  end;
  
  export big := record

    string            version       ;
    string            wuid          ;
    string            timestamp     ;
    string            Notes         ;
    subsetcounts      All_Files     ;
    subsetcounts      Sub_Files     ;
    subsetcounts      NotSub_Files  ;
    dataset(FileInfo) Files         ;

  end;

  export slim := record

    string            version       ;
    string            wuid          ;
    string            timestamp     ;
    string            Notes         ;
    subsetcounts      All_Files     ;
    subsetcounts      Sub_Files     ;
    subsetcounts      NotSub_Files  ;

  end;

  export norm := record

    string            version       ;
    string            wuid          ;
    string            timestamp     ;
    string            Notes         ;
    subsetcounts      All_Files     ;
    subsetcounts      Sub_Files     ;
    subsetcounts      NotSub_Files  ;
    FileInfo                        ;

  end;

end;