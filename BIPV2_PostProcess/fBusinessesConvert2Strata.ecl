import bipv2;

EXPORT fBusinessesConvert2Strata(

   string                             pId
  ,dataset(layouts.stats_layout     ) pStats
  ,dataset(BIPV2.CommonBase.layout  ) pBase      = BIPV2.CommonBase.DS_CLEAN

) :=
function

  Total_Records                       := 	count(pBase);
  Total_IDs                           :=  sum(pStats                                                                   ,total);
  ID_Active                           :=  sum(pStats(segtype != 'INACTIVE'                                            ),total);
  ID_Tri_Major_Sources                :=  sum(pStats(segtype  = 'CORE'            ,segSubType = 'TriCore'             ),total);
  ID_Dual_Major_Sources               :=  sum(pStats(segtype  = 'CORE'            ,segSubType = 'DualCore'            ),total);
  ID_Single_Source_w_multiple_records :=  sum(pStats((segtype = 'CORE'         and segSubType = 'TrustedSource'       ) 
                                                  or (segtype = 'EMERGINGCORE' and segSubType = 'TrustedSrcSingleton')),total);
  ID_Single_Source_w_single_record    :=  sum(pStats(segtype  = 'CORE'            ,segSubType = 'SingleSource'        ),total);
  ID_Inactive                         :=  sum(pStats(segtype  = 'INACTIVE'        ,segSubType = 'NoActivity'          ),total);
  ID_Defunct                          :=  sum(pStats(segtype  = 'INACTIVE'        ,segSubType = 'ReportedInactive'    ),total);

  doutput := dataset([
  
//  { 'Total Records'                             ,2883814282 }
     { pId                                         ,Total_IDs                            ,Total_IDs                            }
    ,{ pId + ' - Active'                           ,ID_Active                            ,ID_Active                            }
    ,{ pId + ' - Tri-Major Sources'                ,ID_Tri_Major_Sources                 ,ID_Tri_Major_Sources                 }
    ,{ pId + ' - Dual-Major Sources'               ,ID_Dual_Major_Sources                ,ID_Dual_Major_Sources                }
    ,{ pId + ' - Single Source w/multiple records' ,ID_Single_Source_w_multiple_records  ,ID_Single_Source_w_multiple_records  }
    ,{ pId + ' - Single Source w/single record'    ,ID_Single_Source_w_single_record     ,ID_Single_Source_w_single_record     }
    ,{ pId + ' - Inactive'                         ,ID_Inactive                          ,ID_Inactive                          }
    ,{ pId + ' - Defunct'                          ,ID_Defunct                           ,ID_Defunct                           }
    
  ],layouts.layout_Businesses);
  
//cnt_prox_per_lgid3 >1 then seleid got id from lgid3

  return doutput;
  
end;

//input
// export stats_layout := 
// record
  // string20  segType;
  // string20  segSubType;
  // unsigned4 total;
// end;
  
// layouts.stats_layout
// segtype       segsubtype           total 
// CORE          DualCore             11758429 
// CORE          SingleSource         29534725 
// INACTIVE      NoActivity          161742301 
// CORE          TriCore                468932 
// EMERGINGCORE  TrustedSrcSingleton  30100494 
// INACTIVE      ReportedInactive     18484383 
// CORE          TrustedSource        35565451 

//output
// layouts.layout_Businesses
  // export layout_Businesses := 
  // record
      // STRING40 US_Businesses;
      // UNSIGNED Build_Value;
      // UNSIGNED CountGroup 	;//:= Build_Value;		
  // END;

// Businesses_rec :=
// dataset([
  // { 'Total Records',	2883814282 },
  // { 'PROXID', 286858000 },
  // { 'PROXID - Active', 107378000 },
  // { 'PROXID - Tri-Major Sources', 468000 },
  // { 'PROXID - Dual-Major Sources', 11750000 },
  // { 'PROXID - Single Source w/multiple records', 65660000 },
  // { 'PROXID - Single Source w/single record', 29500000 },
  // { 'PROXID - Inactive', 161000000 },
  // { 'PROXID - Defunct', 18480000 },
  
  // { 'SELE', 285860000 },
  // { 'SELE - Active', 105951000 },
  // { 'SELE - Tri-Major Sources', 454000 },
  // { 'SELE - Dual-Major Sources', 11497000 },
  // { 'SELE - Single Source w/multiple records', 64720000 },
  // { 'SELE - Single Source w/single record', 29280000 },
  // { 'SELE - Inactive', 161475000 },
  // { 'SELE - Defunct', 18434000 },
  // { 'SELE - Total SELEs from LGID3 Processing', 0}, 
  
  // { 'ORGID', 285615000 },
  // { 'ORGID - Active', 105757000 },
  // { 'ORGID - Tri-Major Sources', 433000 },
  // { 'ORGID - Dual-Major Sources', 11455000 },
  // { 'ORGID - Single Source w/multiple records', 64630000 },
  // { 'ORGID - Single Source w/single record', 29239000 },
  // { 'ORGID - Inactive', 161443000 },
  // { 'ORGID - Defunct', 18415000 },
  
  // { 'ULTID', 285582000 },
  // { 'ULTID - Active', 433000 },   
  // { 'ULTID - Tri-Major Sources', 11455000 },
  // { 'ULTID - Dual-Major Sources', 64600000 },	
  // { 'ULTID - Single Source w/multiple records', 29239000 },
  // { 'ULTID - Single Source w/single record', 161440000 },
  // { 'ULTID - Inactive', 18415000 },
  // { 'ULTID - Defunct', 0}
// ],layout_Businesses);
