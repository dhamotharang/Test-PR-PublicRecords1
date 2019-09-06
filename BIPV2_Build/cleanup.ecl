EXPORT cleanup(

   string   pversion
  ,boolean  pIncBuiltDelete = true
  ,boolean  pDeleteThem     = true

) :=
function

  // -- Cleanup the previous build -- this needs to expand to more files
  notdeleteversion  := regexfind('[[:digit:]]+',pversion,0,nocase);  //do this so we don't delete any files from a rebuild--may want to keep those until the next build for research purposes.
  CleanupLastBuild  := BIPV2_Build.Promote(,'^(?!.*?(wkhistory|precision|space|dashboard).*).*$',pDelete := pDeleteThem,pIncludeBuiltDelete := pIncBuiltDelete,pCleanupFilter := '^(?!.*?' + notdeleteversion + '.*).*$').Cleanup; //cleanup last build's iterations

  return CleanupLastBuild;
  
end;