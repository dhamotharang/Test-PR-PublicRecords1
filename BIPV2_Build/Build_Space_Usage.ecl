import tools,ut,bipv2,std;
/*
  so, run this three times in the BIP build
  once at the beginning of the build
  once after everything is finished.
  once after cleanup has been performed
  each time, it write out a file with the following information
    1. build version
    2. wuid
    3. child dataset of files from build
    4. total space used
  first time ,begin, 2nd, end, 3rd cleanup
  if you want to recreate them(and they already exist)
  run with overwrite one, it will delete them all.
  then turn off overwrite in the 2nd call

  Then, after the last time this runs, another function could be called to calculate the following statistics:
    1.  Total Space used by all BIP files
    2.  Total Space used by this build
    3.  Total space cleaned up by this build
    4.  Files rebuilt in this build
    5.  Files not rebuilt in this build
    6.  Files not rebuilt in this build and not in superfiles
    7.  New files built in this build
    8.  total space of files rebuilt in this build
    9.  total space of new files built
    10. total space of files not rebuilt in this build
    11. total space of files not rebuilt in this build and not in superfiles

*/
EXPORT Build_Space_Usage(

   string   pversion              = bipv2.KeySuffix
  ,string   pEndDate              = ut.GetDate 
  ,string   pFileRegex            = 'bipv2|bizlinkfull|bip2.0|bip_v2'
  ,string   pBeginFilename        = filenames(pversion + '_begin'       ).space_usage.logical
  ,string   pEndFilename          = filenames(pversion + '_end'         ).space_usage.logical
  ,string   pPostCleanupFilename  = filenames(pversion + '_postcleanup' ).space_usage.logical
  ,unsigned pType                 = 0  //1 = 'begin 2 = end 3 = postcleanup'
  ,boolean  pOverwrite            = false
  ,boolean  pDoCompare            = false  
  
) :=
function

  Note := global(map(
     not std.file.fileexists(pBeginFilename       )  or pType = 1 => 'Begin'
    ,not std.file.fileexists(pEndFilename         )  or pType = 2 => 'End'
    ,not std.file.fileexists(pPostCleanupFilename )  or pType = 3 => 'Post Cleanup'
    ,                                                  'Begin'
  ),few);

  filename := map(
     not std.file.fileexists(pBeginFilename       )   or pType = 1 => pBeginFilename      
    ,not std.file.fileexists(pEndFilename         )   or pType = 2 => pEndFilename        
    ,not std.file.fileexists(pPostCleanupFilename )   or pType = 3 => pPostCleanupFilename
    ,                                                  ''
  );
  
  filename2 := map(
     not std.file.fileexists(pBeginFilename       )   or pType = 1 => pBeginFilename      
    ,not std.file.fileexists(pEndFilename         )   or pType = 2 => pEndFilename        
    ,not std.file.fileexists(pPostCleanupFilename )   or pType = 3 => pPostCleanupFilename
    ,                                                  pBeginFilename
  );

  version := map(
     not std.file.fileexists(pBeginFilename       )   or pType = 1 => pversion + '_begin'      
    ,not std.file.fileexists(pEndFilename         )   or pType = 2 => pversion + '_end'        
    ,not std.file.fileexists(pPostCleanupFilename )   or pType = 3 => pversion + '_postcleanup'
    ,                                                  pversion + '_begin'
  ) : independent;

  dSpace := tools.fun_CheckSpaceUsed(
     pversion
    ,pOwner								:= 'lbentley'	  // regex to filter the file owner
    ,pFilename						:= pFileRegex		// regex to filter the filenames
    ,pCluster							:= ''			      // regex to filter the cluster
    ,pModified						:= ''			      // regex to filter the modified time
    ,pModifiedBefore	    := 0
    ,pModifiedAfter	      := 0
    ,pSizeMinimum					:= 0			      // regex to filter by size
    ,pIncludeNormalFiles	:= true		      // If true,  return logical files 
    ,pIncludeSuperFiles		:= false	      // If true,  return super files 
    ,pIncludeSubfiles		  := true	        // If true,  return sub files
//    ,pNote                := ''
    ,pNote                := Note
  );

  //should have three versions now: begin, end and postcleanup
  dspaceslim  := project  (dSpace,tools.Layout_Space_Used.slim);
  dspacenorm  := normalize(dSpace,left.files,transform(tools.Layout_Space_Used.norm,self := right,self := left));

  writefile   := if(filename2 != ''  ,tools.macf_WriteFile(filename2,dspace,,,pOverwrite));
  promotefile := promote(version,'SpaceUsage').new2qaMult;
  
  clearstuff := if(pOverwrite,
				sequential(
           nothor(Tools.fun_ClearfilesFromSupers(dataset([{pBeginFilename},{pEndFilename},{pPostCleanupFilename}], Tools.Layout_Names), false))
          ,tools.mod_Utilities.DeleteLogical(pBeginFilename       )
          ,tools.mod_Utilities.DeleteLogical(pEndFilename         )
          ,tools.mod_Utilities.DeleteLogical(pPostCleanupFilename )
        ));
        

  //analysis here
  
  dqa       := files().space_usage.qa(version = pversion);
  dqaslim   := project  (dqa,tools.Layout_Space_Used.slim);
  dqanorm   := normalize(dqa,left.files,transform(tools.Layout_Space_Used.norm,self := right,self := left));
  
  //files that did not get rebuilt(may be candidates for deletion).  could furthur divide into subfiles and non subfiles
  djoin1 := join(dqanorm,dqanorm,left.name = right.name and left.modified  = right.modified and left.notes = 'Begin' and right.notes = 'End',transform({tools.Layout_Space_Used.norm leftrec,tools.Layout_Space_Used.norm rightrec},self.leftrec := left,self.rightrec := right));
  
  //files that do get rebuilt.  These are probably ones that we keep(mostly persists, temp files, etc).  for these, only thing we want to know is increase/decrease in size of them over time
  djoin2 := join(dqanorm,dqanorm,left.name = right.name and left.modified <> right.modified and left.notes = 'Begin' and right.notes = 'End',transform({tools.Layout_Space_Used.norm leftrec,tools.Layout_Space_Used.norm rightrec},self.leftrec := left,self.rightrec := right));
  
  //new files built in this build
  djoin3 := sort(join(dqanorm(notes = 'Begin'),dqanorm(notes = 'End'         ),left.name = right.name,transform({tools.Layout_Space_Used.norm},self := right),right only),-size);
  dproj3 := project(djoin3,transform(recordof(left)
    ,self.All_Files.cnt_files             := count(djoin3)
    ,self.All_Files.TotalSpaceUsed        := sum(djoin3,size)
    ,self.All_Files.TotalSpacePretty      := ut.FHumanReadableSpace(self.All_Files.TotalSpaceUsed)

    ,self.Sub_Files.cnt_files             := count(djoin3(isSubFile))
    ,self.Sub_Files.TotalSpaceUsed        := sum(djoin3(isSubFile),size)
    ,self.Sub_Files.TotalSpacePretty      := ut.FHumanReadableSpace(self.Sub_Files.TotalSpaceUsed)

    ,self.NotSub_Files.cnt_files          := count(djoin3(~isSubFile))
    ,self.NotSub_Files.TotalSpaceUsed     := sum(djoin3(~isSubFile),size)
    ,self.NotSub_Files.TotalSpacePretty   := ut.FHumanReadableSpace(self.NotSub_Files.TotalSpaceUsed)
    ,self                                 := left
  ));
  //files deleted/cleaned up
  djoin4 := sort(join(dqanorm(notes = 'End'  ),dqanorm(notes = 'Post Cleanup'),left.name = right.name,transform({tools.Layout_Space_Used.norm},self := left ),left  only),-size);
  dproj4 := project(djoin4,transform(recordof(left)
    ,self.All_Files.cnt_files             := count(djoin4)
    ,self.All_Files.TotalSpaceUsed        := sum(djoin4,size)
    ,self.All_Files.TotalSpacePretty      := ut.FHumanReadableSpace(self.All_Files.TotalSpaceUsed)

    ,self.Sub_Files.cnt_files             := count(djoin4(isSubFile))
    ,self.Sub_Files.TotalSpaceUsed        := sum(djoin4(isSubFile),size)
    ,self.Sub_Files.TotalSpacePretty      := ut.FHumanReadableSpace(self.Sub_Files.TotalSpaceUsed)

    ,self.NotSub_Files.cnt_files          := count(djoin4(~isSubFile))
    ,self.NotSub_Files.TotalSpaceUsed     := sum(djoin4(~isSubFile),size)
    ,self.NotSub_Files.TotalSpacePretty   := ut.FHumanReadableSpace(self.NotSub_Files.TotalSpaceUsed)
    ,self                                 := left
  ));
  
  
  
  dothis := sequential(
     clearstuff
    ,output(version)
    ,writefile
    ,output(dspaceslim  ,named('SpaceUsed' + (string)pType))
    ,output(dspacenorm  ,named('Files'     + (string)pType),all)
    ,promotefile
    ,output('')
    ,if(pType = 3 ,output(dqaslim             ,named('BuildSpaceComparison'),all))
    ,if(pType = 3 ,output(dqanorm             ,named('AllFiles'       ),all))
    ,if(pType = 3 ,output(choosen(djoin1,1000),named('FilesNotRebuilt'),all))
    ,if(pType = 3 ,output(choosen(djoin2,1000),named('FilesRebuilt'   ),all))
    ,if(pType = 3 ,output(choosen(dproj3,1000),named('NewFiles'       ),all))
    ,if(pType = 3 ,output(choosen(dproj4,1000),named('FilesDeleted'   ),all))
  );
  //find diffs with overall numbers
  //maybe reformat and then do iterate to compare numbers?
  
  

  // ,pModifiedBefore	    := (unsigned)pEndDate[1..8]
  // ,pModifiedAfter	      := (unsigned)pversion[1..8]


  return dothis;


end;