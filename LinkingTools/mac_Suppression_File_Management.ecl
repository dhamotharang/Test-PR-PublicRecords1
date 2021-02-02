/*

  returns module with exported tools to manage underlink files:
    dataIn_file       -- underlink superfile
    addCandidates     -- add candidates to the underlink file using a dataset.  layout is {unsigned6 ID(your id) ,integer underLinkId}
    removeCandidates  -- remove candidates from the underlink file.  you only pass in the underlinkid here.  so this is one at a time.
    recLayout         -- layout of underlink file created.  {unsigned6 ID(your id) ,integer underLinkId}
*/
EXPORT mac_Suppression_File_Management(
   // pID                          //= 'proxid'  // or 'lgid3'
   pSuppression_Filename_Prefix //= '\'~thor_data400::bip::lgid3::underlink::\''

) :=
functionmacro

  // Module contains support functions. They help to add or remove candidates from the underlink file containing underlink clusters.
  return module
       
    import ut,std;

    export Suppression_field := {string fieldname ,string fieldvalue};
    
    // -- Layout of Input Suppression File
    export in_recLayout := LinkingTools.layouts.Suppression_in;
    // record
       // dataset(Suppression_field) suppressed_field_values  
      // ,string                     comment
      // ,dataset(Suppression_field) context                 := dataset([],Suppression_field)  //optional
    // end;
    
    // -- Layout of output suppression file
    export recLayout := LinkingTools.layouts.Suppression_out;
    // record
       // unsigned6                  suppressionid  
      // ,dataset(Suppression_field) context  
      // ,dataset(Suppression_field) suppressed_field_values  
      // ,string                     date_added 
      // ,string                     userid  
      // ,string                     comment
    // end;

    // -- Suppression Super Filenames
    export file_prefix            := pSuppression_Filename_Prefix ;
    shared superfile 						  := file_prefix + 'qa'         ;
    shared superfile_father 			:= file_prefix + 'father'     ;
    shared superfile_grandfather 	:= file_prefix + 'grandfather';

    // -- Suppression Logical Filenames
    shared wuid            := thorlib.wuid();
    export logicalFilename := file_prefix + wuid;

    // -- Suppression File Definitions
    export dataIn_file      := dataset(                  superfile      ,recLayout  ,flat ,opt);
    export dataIn_file_prod := dataset(ut.foreign_prod + superfile[2..] ,recLayout  ,flat ,opt);

    // -- UpdateSuppressionSuperFile
    export updateSuppressionSuperFile(string inFile) := 
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
      
      maxId := IF(NOTHOR(FileServices.FileExists(superfile)), max(oldData, SuppressionId), 0);
      
      // linksIDs := dedup(sort(newData, SuppressionId), SuppressionId);
      linksIDs := sort(newData, record);
      
      rec := record
        newData;
        integer new_SuppressionId;
      end;
      // increment ids by did only.
      recLayout addId(linksIDs L, integer cnt) := transform
        self.SuppressionId        := maxId + cnt          ;
        self.wuid                 := workunit             ;//ut.GetTimeDate     ();
        self.userid               := STD.System.Job.User();
        self.suppression_counter  := 0                    ;
        self 							        := L                    ;
      end;
      linksWithIds := project(linksIDs, AddId(left, counter));
      

      AllData := oldData + linksWithIds;
              
      a := output(allData, ,logicalFilename, overwrite);
      return a;
    end;
      
    // -- It adds candidates to the ManualLink file
    export addCandidates(dataset(in_recLayout) newData) := function
    
      a := createLogicalFile(newData);

      b := updateSuppressionSuperFile(logicalFilename);

      c := sequential(a,b);
      
      return c;
    end;

    // -- It removes candidates from the ManualLink file
    export removeCandidates(integer gid) := function
    
      ds := dataIn_file(SuppressionId != gid);
      
      a := output(ds, ,logicalFilename, overwrite);
      
      b := updateSuppressionSuperFile(logicalFilename);
      
      c := sequential(a, b);

      return c;
    end;

    export clearsuperfile := std.file.clearsuperfile(superfile);

    export IncrementSuppressionCounter(dataset(recLayout) newData = dataIn_file) := function
    
      ds_increment_suppression_file := project(newData ,transform(recordof(left) ,self.suppression_counter := left.suppression_counter + 1 ,self := left));

      a := output(ds_increment_suppression_file, ,logicalFilename, overwrite);

      b := updateSuppressionSuperFile(logicalFilename);

      c := sequential(a,b);
      
      return c;
    end;

    export InitializeSuppressionCounter(dataset(recLayout) newData = dataIn_file) := function
    
      ds_initialize_suppression_file := project(newData ,transform(recordof(left) ,self.suppression_counter := 0 ,self := left));

      a := output(ds_initialize_suppression_file, ,logicalFilename, overwrite);

      b := updateSuppressionSuperFile(logicalFilename);

      c := sequential(a,b);
      
      return c;
    end;
    
  end;

endmacro;
