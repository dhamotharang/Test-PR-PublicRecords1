EXPORT Files := module
 
 export AllDuplicates := dataset('~thor200::out::fedex::dupes',fedex.Layout_FedEx.ReturnFiles,csv(separator(','),terminator('\r\n'),QUOTE('"')));
 export NewDuplicates := dataset('~thor200::out::fedex::new_dupes',fedex.Layout_FedEx.ReturnFiles,csv(separator(','),terminator('\r\n'),QUOTE('"')));
 export NewUniques    := dataset('~thor200::out::fedex::new_uniques',fedex.Layout_FedEx.ReturnFiles,csv(separator(','),terminator('\r\n'),QUOTE('"')));

end;