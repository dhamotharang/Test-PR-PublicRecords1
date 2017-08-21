import versioncontrol;
export Files(string pversion = '') :=
module
   //////////////////////////////////////////////////////////////////
   // -- Input File Versions
   //////////////////////////////////////////////////////////////////
   versioncontrol.macInputFileVersions(Filenames(pversion).input  ,layouts.Input.Sprayed  ,Input);
   //////////////////////////////////////////////////////////////////
   // -- Base File Versions
   //////////////////////////////////////////////////////////////////
   versioncontrol.macBuildFileVersions(Filenames(pversion).Base      ,layouts.Base                 , Base   );
//export StandardizeInput  := dataset     (Persistnames.StandardizeInput   ,layouts.Temporary   ,flat);
//export UpdateBase           := dataset     (Persistnames.UpdateBase            ,layouts.Temporary   ,flat);
end;
