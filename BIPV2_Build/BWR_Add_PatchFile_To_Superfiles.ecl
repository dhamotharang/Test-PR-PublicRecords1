import std;

patched_filename  := '~thor_data400::bipv2::internal_linking::20190501_BH664_patch'                                   ;
patch_description := 'BH-560 -- Remove bad D&B fein records, BH-592 -- research accounts payable cnp_name overlinking';

sequential(
   std.file.clearsuperfile('~thor_data400::bipv2::internal_linking::building')
  ,std.file.clearsuperfile('~thor_data400::bipv2::internal_linking::built'   )
  // ,std.file.clearsuperfile('~thor_data400::bipv2::internal_linking::base'    )
  ,std.file.clearsuperfile('~thor_data400::bipv2::internal_linking::qa'      )

  ,STD.File.SetFileDescription(patched_filename  ,patch_description)
  
  ,std.file.addsuperfile('~thor_data400::bipv2::internal_linking::building' ,patched_filename)
  ,std.file.addsuperfile('~thor_data400::bipv2::internal_linking::built'    ,patched_filename)
  // ,std.file.addsuperfile('~thor_data400::bipv2::internal_linking::base'     ,patched_filename)
  ,std.file.addsuperfile('~thor_data400::bipv2::internal_linking::qa'       ,patched_filename)
);