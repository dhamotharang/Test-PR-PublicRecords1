 import FLAccidents_Ecrash;
 
 eCrash            := project(FLAccidents_Ecrash.BaseFile, transform(Scrubs_eCrash.Layout_eCrash, self := left; self := []))(date_vendor_last_reported [1..2]= '20'); 
 maxprocessdate    := max(eCrash(date_vendor_last_reported [1..2]= '20'), date_vendor_last_reported) ; // some junk dates in there
 export In_eCrash  := eCrash( date_vendor_last_reported = MaxprocessDate) ;
