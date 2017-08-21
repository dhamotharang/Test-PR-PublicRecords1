import VersionControl;
export Promote(string pversion = '') :=
module
   
   export Input := 
   module
      shared dfilenames       := Filenames().Input.dAll_templates;
      
      shared inputpromote  := VersionControl.mPromote.InputFiles(dFilenames);
      
      export Root2Sprayed     := inputpromote.Root2Sprayed  ();
      export Sprayed2Using := inputpromote.Sprayed2Using    ;
      export Using2Used       := inputpromote.Using2Used    ();
   end;
   export Base := 
   module
      shared dfilenames    := Filenames(pversion).base.dAll_filenames;
      shared dTemplates    := versioncontrol.SlimFilenameDs.fOther      (dfilenames ,'T');
      shared basepromote   := VersionControl.mPromote.BuildFiles        (dTemplates       );
      
      export New2Building        := basepromote.New2Building      (pversion)  ;
      export New2Built           := basepromote.New2Built         (pversion)  ;
      export Building2Built      := basepromote.Building2Built                   ;
      export Built2Qa2Delete  := basepromote.Built2Qa2Delete                  ;
      export Built2QA2Father  := basepromote.Built2QA2Father                  ;
      export QA2Prod             := basepromote.QA2Prod                             ;
      
   end;
/*
   export RoxieKeys := 
   module
      shared roxiepromote := VersionControl.mPromote.BuildFiles(keynames(pversion).dTemplate);
      
      export New2Building        := roxiepromote.New2Building     (pversion)  ;
      export New2Built           := roxiepromote.New2Built           (pversion)  ;
      export Building2Built      := roxiepromote.Building2Built                     ;
      export Built2Qa2Delete  := roxiepromote.Built2Qa2Delete                    ;
      export Built2QA2Father  := roxiepromote.Built2QA2Father                    ;
      export QA2Prod             := roxiepromote.QA2Prod                               ;
   
   end;
*/ 
   export Built2Qa2Delete :=
   parallel(
       Base.Built2Qa2Delete
//    ,Roxiekeys.Built2Qa2Delete
   );
   export Built2QA2Father :=
   parallel(
       Base.Built2QA2Father
//    ,RoxieKeys.Built2QA2Father
   );
   export QA2Prod :=
   parallel(
       Base.QA2Prod
//    ,RoxieKeys.QA2Prod
   );
end;
