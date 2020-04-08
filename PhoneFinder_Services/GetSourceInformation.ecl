IMPORT $, iesp;

EXPORT GetSourceInformation (DATASET($.Layouts.PhoneFinder.Final) inRecs
                             ) := FUNCTION

  //Function to map categories and create a table with category, Type and count of sources within category.
  dGetCtgSources(DATASET($.Layouts.PhoneFinder.src_rec) dIn) := FUNCTION

    tempLayout_Category := RECORD
     STRING40 _Type;
     STRING24 Category;
    END;

    tempLayout_Category src_it ($.Layouts.PhoneFinder.src_rec l) := TRANSFORM
     SELF.Category := $.Constants.MapCategoryDCT(l.Src);
     SELF._Type := $.Constants.MapSourceTypeDCT(l.Src);
    end;

    dCtg := PROJECT(dIn, src_it(LEFT));

    tCtgRec := RECORD
      dCtg.Category;
      dCtg._Type;
      UNSIGNED count := COUNT(GROUP);
    END;

    tCtg := TABLE(dCtg, tCtgRec, Category, _Type, FEW);

    return tCtg;

  END;

  //Assign SourceInfo back to the final layout with actual categories.
  $.Layouts.PhoneFinder.Final getCategory(PhoneFinder_Services.Layouts.PhoneFinder.Final l) := TRANSFORM

    dDedupSrc := DEDUP(SORT(l.phn_src_all, src), src);
    Src_Func := dGetCtgSources(dDedupSrc);

    iesp.phonefinder.t_PhoneFinderSourceIndicator denormCats(RECORDOF(Src_Func) l, DATASET(RECORDOF(Src_Func)) r)  := TRANSFORM
      SELF._Type := l._Type;
      SELF.Categories := PROJECT(r, TRANSFORM(iesp.phonefinder.t_PhoneFinderSourceCategory, SELF := LEFT));
    END;
    dGrpSrc := DENORMALIZE(DEDUP(SORT(Src_Func, _Type), _Type), Src_Func, LEFT._Type = RIGHT._Type, GROUP, denormCats(LEFT, ROWS(RIGHT)));
     SELF.SourceInfo           := dGrpSrc;
     SELF.TotalSourceCount     := COUNT(dDedupSrc);
     SELF.SelfReportedSourcesOnly := ~(EXISTS(Src_Func(_Type = $.Constants.PFSourceType.Account)));
     SELF.phn_src_all          := dDedupSrc;
     SELF := l;
  END;

   ds_ctg := PROJECT(inRecs, getCategory(LEFT));

  return ds_ctg;
END;
