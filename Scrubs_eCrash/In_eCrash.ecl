 import ut;
 
 eCrash            := dataset(ut.foreign_prod+'thor_data400::base::ecrash',Scrubs_eCrash.Layout_eCrash,thor)(date_vendor_last_reported [1..2]= '20'); 
 maxprocessdate    := max(eCrash(date_vendor_last_reported [1..2]= '20'), date_vendor_last_reported) ; // some junk dates in there
 EXPORT In_eCrash  := eCrash( date_vendor_last_reported = MaxprocessDate) ;
