/*2010-10-25T18:34:45Z (Sudhir Kasavajjala)

*/

 export File_In_GroupAffiliation := Module

  export Allied_Health := dataset('~thor_data400::in::ingenix_natlprof_alliedhealth_groupaffiliation',Ingenix_NatlProf.Layout_in_GroupAffiliation.raw,CSV(quote(''),separator('|'), maxlength(8192)));
  export DentalProf :=  dataset('~thor_data400::in::ingenix_natlprof_dentists_groupaffiliation',Ingenix_NatlProf.Layout_in_GroupAffiliation.raw,CSV(quote(''),separator('|'), maxlength(8192)));
  export Physician :=  dataset('~thor_data400::in::ingenix_natlprof_physicians_groupaffiliation',Ingenix_NatlProf.Layout_in_GroupAffiliation.raw,CSV(quote(''),separator('|'), maxlength(8192)));
 File_GroupAffiliation := dataset('~thor_data400::in::Ingenix_NatlProf_GroupAffiliation',Ingenix_NatlProf.Layout_in_GroupAffiliation.raw_srctype,CSV(quote(''),separator('|'), maxlength(8192)));



 //To Clean the fields to remove junk characters 
 Ingenix_NatlProf.Layout_in_GroupAffiliation.raw_srctype tr_clean_GrAfl(File_GroupAffiliation l) := transform
 
 self.offstreetparking := if(regexfind('[a-z+,A-Z]',l.offstreetparking) = false and l.offstreetparking <> '','',l.offstreetparking);
 self.paymenttypes := if(regexfind('[a-z+,A-Z]',l.paymenttypes) = false and l.paymenttypes <> '','',l.paymenttypes);
 self := l;
 end;
 
 export Allsrc := project(File_GroupAffiliation,tr_clean_GrAfl(LEFT));
 
 end;
