import BIPV2;
 
EXPORT segmentation_category := module

  export category := module
    export Gold     := 'G';
    export Active   := 'A';
    export Inactive := 'I';
    export Defunct  := 'D';
    export Unknown  := '?';
  end;
 
  export subCategory := module
    export High_Valid   := '3';
    export Medium_Valid := '2';
    export Low_Valid    := '1';
    export Valid        := 'V';
    export C_Merge      := 'C';
    export H_Merge      := 'H';
    export Noise        := 'N';
    export None         := ' ';
  end;
 
  export	segCategoryLayout := {
        BIPV2.CommonBase.Layout.seleid,
        string1 category, 
        string1 subCategory
        };

 export perSeleid(
   dataset(BIPV2.CommonBase.Layout) header_clean
  ,String                           pToday
  ,boolean                          pNewWay       = false
 ) := 
 function
 
    header_clean_gold     := header_clean(sele_gold ='G') ;
    header_clean_non_gold := header_clean(sele_gold<>'G') ;
 
    hasValidId(BIPV2.CommonBase.Layout rec) := function
        hasFein       := trim(rec.company_fein)<>'';
        hasCharter    := trim(rec.company_charter_number)<>'';
        hasDuns       := trim(rec.duns_number)<>'' or trim(rec.active_duns_number)<>'' or trim(rec.hist_duns_number)<>'';
        hasEnterprise := trim(rec.active_enterprise_number)<>'' or trim(rec.hist_enterprise_number)<>'';
        return hasFein or hasCharter or hasDuns or hasEnterprise;
    end;
 
    hasValidAddress(BIPV2.CommonBase.Layout rec) := function				
        return    (trim(rec.p_city_name)<>'' or trim(rec.v_city_name)<>'')
                    and trim(rec.st)<>'' 
                    and trim(rec.zip)<>''
                    and trim(rec.prim_name) <> ''
                    and (trim(rec.prim_range) <> ''
                    or REGEXFIND('\\b[P]*(OST)*\\.*\\s*[0|O]*(FFICE)*\\.*\\s*B[O|0]X\\b', rec.prim_name));
    end;

    {header_clean.seleid} validAddressFilt(BIPV2.CommonBase.Layout rec) := transform, skip(not hasValidAddress(rec))
        self := rec;
    end;

    {header_clean.seleid} validIdFilt(BIPV2.CommonBase.Layout rec) := transform, skip(not hasValidId(rec))
        self := rec;
    end;
				
    // The independent was added because the work to generate for the next 2 joins was done in multiple graphs because segmentation below will be done in multiple graphs
    clean_id_address_seleids := table(project(header_clean, validAddressFilt(left)) + project(header_clean, validIdFilt(left)), {seleid}, seleid) : independent;
 
    clean_non_gold_good_addr_id := join(header_clean_non_gold, clean_id_address_seleids, left.seleid=right.seleid, transform(left), keep(1), local);
    clean_non_gold_bad_addr_id  := join(header_clean_non_gold, clean_id_address_seleids, left.seleid=right.seleid, transform(left), left only, local);

    goodAddrSegmentation := segmentation(clean_non_gold_good_addr_id, 'SELEID', pToday).result;
    badAddrSegmentation  := segmentation(clean_non_gold_bad_addr_id,  'SELEID', pToday).result;

    segResultLayout := recordof(goodAddrSegmentation);

    // This transform for non-Gold only
    segCategoryLayout categoryTransform(segResultLayout l, Boolean goodAddr) := transform
        active   := l.inactive='';
        inactive := l.inactive='I';
        defunct  := l.inactive='D';
        valid         := l.core in ['2','3','T'];							
        high_valid    := l.core in ['2','3','T'] and l.status_score = '3' and active;							
        medium_valid  := l.core in ['2','3','T'] and l.status_score = '2' and active;							
        low_valid     := l.core in ['2','3','T'] and l.status_score = '1' and active;							
        self.category  := map(active  => category.Active,
                              defunct => category.Defunct,
                              inactive => category.Inactive,
                              category.Unknown);
																															
        self.subCategory := map(defunct                              => subCategory.None        ,
                                 pNewWay and high_valid              => subCategory.High_Valid  ,
                                 pNewWay and medium_valid            => subCategory.Medium_Valid,
                                 pNewWay and low_valid               => subCategory.Low_Valid   ,
                                 valid                               => subCategory.Valid       ,
                                 not valid and goodAddr and active   => subCategory.C_Merge     ,
                                 not valid and goodAddr and inactive => subCategory.H_Merge     ,
                                 not valid and not goodAddr          => subCategory.Noise       ,
                                 subCategory.None);
        self.seleid:=l.id;
    end;

    goodAddrSeg := project(goodAddrSegmentation, categoryTransform(LEFT,TRUE));
    badAddrSeg  := project(badAddrSegmentation,  categoryTransform(LEFT,FALSE));
    goldSeg     := project(table(header_clean_gold, {seleid}, seleid), 
                           transform(segCategoryLayout, 
                                     self.category    := category.Gold;
                                     self.subCategory := subCategory.None;
                                     self := left));
    result := distribute(goldSeg + goodAddrSeg + badAddrSeg, hash32(seleid));
    return result;
  end;
end; 