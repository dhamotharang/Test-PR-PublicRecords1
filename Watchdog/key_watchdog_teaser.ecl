import header, ut, doxie, data_services,Watchdog_V2;

 
EXPORT TeaserLayout := RECORD
Watchdog_V2.TeaserLayout;
END;
 
Parms := Module(Watchdog_V2.UniversalKeyInterface)
EXPORT Permissions := Watchdog_V2.fn_UniversalKeySearch.PermissionsType.nonglb_teaser;
END;


EXPORT FilteredDS := Watchdog_V2.fn_UniversalKeySearch.FetchRecords(Parms);

SortNonglb_teaser := SORT (FilteredDS, lname,SKEW(1.0));

Nonglb_teaser := PROJECT(SortNonglb_teaser,TRANSFORM(TeaserLayout,self.pfname := datalib.preferredFirstNew(left.fname, true),SELF :=LEFT));

EXPORT key_watchdog_teaser := Nonglb_teaser;
 




