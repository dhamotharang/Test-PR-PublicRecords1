/*

  returns module with exported tools to manage underlink files:
    dataIn_file       -- underlink superfile
    addCandidates     -- add candidates to the underlink file using a dataset.  layout is {unsigned6 ID(your id) ,integer underLinkId}
    removeCandidates  -- remove candidates from the underlink file.  you only pass in the underlinkid here.  so this is one at a time.
    recLayout         -- layout of underlink file created.  {unsigned6 ID(your id) ,integer underLinkId}
*/
EXPORT mac_Underlink_File_Management(
   pID                        //= 'proxid'  // or 'lgid3'
  ,pUnderlink_Filename_Prefix //= '\'~thor_data400::bip::lgid3::underlink::\''

) :=
functionmacro

  // Module contains support functions. They help to add or remove candidates from the underlink file containing underlink clusters.
  return module
   
    #UNIQUENAME(ID      )
    #SET(ID ,#TEXT(pID))
    
    import ut,std;

    // -- Layout of Underlink File
    export in_recLayout := 
    record
      unsigned6 pID                   ;
      integer   underLinkId           ;
      string    comment               ;
    end;

    export recLayout := 
    record
      unsigned6 pID                   ;
      integer   underLinkId           ;
      string    date_added            ;
      string    userid                ;
      string    comment               ;
    end;

    // -- Underlink Super Filenames
    export file_prefix            := pUnderlink_Filename_Prefix ;
    shared superfile 						  := file_prefix + 'qa'         ;
    shared superfile_father 			:= file_prefix + 'father'     ;
    shared superfile_grandfather 	:= file_prefix + 'grandfather';

    // -- Underlink Logical Filenames
    shared wuid            := thorlib.wuid();
    export logicalFilename := file_prefix + wuid;

    // -- Underlink File Definitions
    export dataIn_file      := dataset(                  superfile      ,recLayout  ,flat ,opt);
    export dataIn_file_prod := dataset(ut.foreign_prod + superfile[2..] ,recLayout  ,flat ,opt);

    // -- UpdateUnderLinkSuperFile
    export updateUnderLinkSuperFile(string inFile) := 
    function
      action := Sequential(
                  nothor(FileServices.PromoteSuperFileList([   superfile 
                                                              ,superfile_father
                                                              ,superfile_grandfather
                                                           ]
                                                           ,inFile
                                                           ,true
                  ))
                );
      return action;
    end;

    // -- CreateLogicalFile
    export createLogicalFile(dataset(in_recLayout) newData) := 
    function	
      oldData := IF(NOTHOR(FileServices.FileExists(superfile)),  dataset(superfile, recLayout, thor,opt),  dataset([], recLayout));
      
      maxId := IF(NOTHOR(FileServices.FileExists(superfile)), max(oldData, UnderLinkId), 0);
      
      linksIDs := dedup(sort(newData, underLinkId), underLinkId);
      
      rec := record
        newData;
        integer new_underLinkId;
      end;
      // increment ids by did only.
      rec addId(linksIDs L, integer cnt) := transform
        self.new_underLinkId  := maxId + cnt;
        self 							    := L;
      end;
      linksWithIds := project(linksIDs, AddId(left, counter));
      
      newlinks := join(newData, linksWithIds, 
                            left.underLinkId = right.underLinkId,
                            transform(recLayout
                              ,self.underLinkId := right.new_underLinkId
                              ,self.date_added  := ut.GetTimeDate()
                              ,self.userid      := STD.System.Job.User();
                              ,self             := left
                  ));

      AllData := oldData + newlinks;
              
      a := output(allData, ,logicalFilename, overwrite);
      return a;
    end;
      
    // -- It adds candidates to the ManualLink file
    export addCandidates(dataset(in_recLayout) newData) := function
    
      a := createLogicalFile(newData);

      b := updateUnderLinkSuperFile(logicalFilename);

      c := sequential(a,b);
      
      return c;
    end;

    // -- It removes candidates from the ManualLink file
    export removeCandidates(integer gid) := function
    
      ds := dataIn_file(underLinkId != gid);
      
      a := output(ds, ,logicalFilename, overwrite);
      
      b := updateUnderLinkSuperFile(logicalFilename);
      
      c := sequential(a, b);

      return c;
    end;

    export clearsuperfile := std.file.clearsuperfile(superfile);
    
  end;

endmacro;
