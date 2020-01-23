IMPORT PhonesPlus_V2, Royalty, MDR, Phones, iesp;

EXPORT GetSourceInformation (DATASET($.Layouts.PhoneFinder.Final) inRecs
                             ) := FUNCTION

  //Function to map categories and create a table with category, Type and count of sources within category.
  dGetCtgSources(DATASET($.Layouts.PhoneFinder.src_rec) dIn) := FUNCTION

    iesp.phonefinder.t_PhoneFinderSourceIndicator src_it ($.Layouts.PhoneFinder.src_rec l) := TRANSFORM
     SELF.Category := $.Constants.MapCategoryDCT(l.Src);
     SELF._Type := $.Constants.MapSourceTypeDCT(l.Src);
     SELF.Count := 0;
    end;

    dCtg := PROJECT(dIn, src_it(LEFT));

    tCtgRec := RECORD
      dCtg.Category;
      dCtg._Type;
      INTEGER count := COUNT(GROUP);
    END;

    tCtg := TABLE(dCtg, tCtgRec, Category, _Type, FEW);

    return tCtg;

  END;

  //Assign SourceInfo back to the final layout with actual categories.
  $.Layouts.PhoneFinder.Final getCategory(PhoneFinder_Services.Layouts.PhoneFinder.Final l) := TRANSFORM
     SELF.SourceInfo := PROJECT(dGetCtgSources(DEDUP(SORT(l.phn_src_all, src), src)),
                           TRANSFORM(iesp.phonefinder.t_PhoneFinderSourceIndicator, SELF  := LEFT));
     SELF := l;
  END;

   ds_ctg := PROJECT(inRecs, getCategory(LEFT));

  return ds_ctg;
END;
