import header, ut, doxie, data_services, Watchdog_V2;

TeaserLayout := RECORD
Watchdog_V2.TeaserLayout;
END;

Parms := Module(Watchdog_V2.UniversalKeyInterface)
EXPORT Permissions := Watchdog_V2.fn_UniversalKeySearch.PermissionsType.nonglb_noneq_teaser;
END;

FilteredDS := Watchdog_V2.fn_UniversalKeySearch.FetchRecords(Parms);

SortNonglb_noneq_teaser := SORT (FilteredDS, lname,SKEW(1.0));

EXPORT key_watchdog_teaser_V2 := PROJECT(SortNonglb_noneq_teaser,TRANSFORM(TeaserLayout,self.pfname := datalib.preferredFirstNew(left.fname, true),SELF :=LEFT));


 


