import bipv2,bipv2_strata;

EXPORT fDemographicsConvert2Strata(

   string                                   pId
  ,dataset(BIPV2_Strata.layout_fieldstats ) pActiveStats
  ,dataset(BIPV2_Strata.layout_fieldstats ) pInactiveStats
  ,dataset(BIPV2.CommonBase.layout        ) pBase          = BIPV2.CommonBase.DS_CLEAN

) :=
function
/*
IDfield,CountField,active/inactive, countgroup, percent

Example data:
ORGID,City,ACTIVE,1403947122,9957
ORGID,City,INACTIVE,1003947122,9943

So basically it is grouped on idfield, countfield and active/inactive.  The countgroup field would contain the population of that field, the percent the percentage population of that field.
This way we have the counts in addition to the percentages for active and inactive records for each field.  Currently we only have the percentages and a count of both active & inactive(not broken out).  Designed this way would also allow for more fields to be added to the stats without any changes needed to the layout of the stats going to strata(because that is not allowed, we would need to add new stats).
Would this way make more sense and provide a more complete picture?

*/
  Total_Records  :=  count(pBase);
  
  Total_IDsActive        :=  sum(pActiveStats,countgroup);
  StreetActive           :=  (unsigned8)(sum(pActiveStats  ,prim_range         ) / Total_IDsActive   * 10000.0);
  CityActive             :=  (unsigned8)(sum(pActiveStats  ,v_city_name        ) / Total_IDsActive   * 10000.0);
  StateActive            :=  (unsigned8)(sum(pActiveStats  ,st                 ) / Total_IDsActive   * 10000.0);
  ZIPActive              :=  (unsigned8)(sum(pActiveStats  ,zip                ) / Total_IDsActive   * 10000.0);
  PhoneActive            :=  (unsigned8)(sum(pActiveStats  ,company_phone      ) / Total_IDsActive   * 10000.0);
  DBAActive              :=  (unsigned8)(sum(pActiveStats  ,dba_name           ) / Total_IDsActive   * 10000.0);
  SIC_PrimaryActive      :=  (unsigned8)(sum(pActiveStats  ,company_sic_code1  ) / Total_IDsActive   * 10000.0);
  NAICS_PrimaryActive    :=  (unsigned8)(sum(pActiveStats  ,company_naics_code1) / Total_IDsActive   * 10000.0);
  NameActive             :=  (unsigned8)(sum(pActiveStats  ,lname              ) / Total_IDsActive   * 10000.0);
  EmailActive            :=  (unsigned8)(sum(pActiveStats  ,contact_email      ) / Total_IDsActive   * 10000.0);
  ContactPhoneActive     :=  (unsigned8)(sum(pActiveStats  ,contact_phone      ) / Total_IDsActive   * 10000.0);
  FEINActive             :=  (unsigned8)(sum(pActiveStats  ,company_fein       ) / Total_IDsActive   * 10000.0);
  TickerActive           :=  (unsigned8)(sum(pActiveStats  ,company_ticker     ) / Total_IDsActive   * 10000.0);
  URLActive              :=  (unsigned8)(sum(pActiveStats  ,company_url        ) / Total_IDsActive   * 10000.0);

  Total_IDsInactive      :=  sum(pInactiveStats,countgroup);
  StreetInactive         :=  (unsigned8)(sum(pInactiveStats,prim_range         ) / Total_IDsInactive * 10000.0);
  CityInactive           :=  (unsigned8)(sum(pInactiveStats,v_city_name        ) / Total_IDsInactive * 10000.0);
  StateInactive          :=  (unsigned8)(sum(pInactiveStats,st                 ) / Total_IDsInactive * 10000.0);
  ZIPInactive            :=  (unsigned8)(sum(pInactiveStats,zip                ) / Total_IDsInactive * 10000.0);
  PhoneInactive          :=  (unsigned8)(sum(pInactiveStats,company_phone      ) / Total_IDsInactive * 10000.0);
  DBAInactive            :=  (unsigned8)(sum(pInactiveStats,dba_name           ) / Total_IDsInactive * 10000.0);
  SIC_PrimaryInactive    :=  (unsigned8)(sum(pInactiveStats,company_sic_code1  ) / Total_IDsInactive * 10000.0);
  NAICS_PrimaryInactive  :=  (unsigned8)(sum(pInactiveStats,company_naics_code1) / Total_IDsInactive * 10000.0);
  NameInactive           :=  (unsigned8)(sum(pInactiveStats,lname              ) / Total_IDsInactive * 10000.0);
  EmailInactive          :=  (unsigned8)(sum(pInactiveStats,contact_email      ) / Total_IDsInactive * 10000.0);
  ContactPhoneInactive   :=  (unsigned8)(sum(pInactiveStats,contact_phone      ) / Total_IDsInactive * 10000.0);
  FEINInactive           :=  (unsigned8)(sum(pInactiveStats,company_fein       ) / Total_IDsInactive * 10000.0);
  TickerInactive         :=  (unsigned8)(sum(pInactiveStats,company_ticker     ) / Total_IDsInactive * 10000.0);
  URLInactive            :=  (unsigned8)(sum(pInactiveStats,company_url        ) / Total_IDsInactive * 10000.0);

  doutput := dataset([
  
		 { pId + ' - Street'       ,StreetActive        ,StreetInactive        ,sum(pActiveStats  ,prim_range         ) + sum(pInactiveStats,prim_range         )}
		,{ pId + ' - City'         ,CityActive          ,CityInactive          ,sum(pActiveStats  ,v_city_name        ) + sum(pInactiveStats,v_city_name        )}
		,{ pId + ' - State'        ,StateActive         ,StateInactive         ,sum(pActiveStats  ,st                 ) + sum(pInactiveStats,st                 )}
		,{ pId + ' - ZIP'          ,ZIPActive           ,ZIPInactive           ,sum(pActiveStats  ,zip                ) + sum(pInactiveStats,zip                )}
		,{ pId + ' - Phone'        ,PhoneActive         ,PhoneInactive         ,sum(pActiveStats  ,company_phone      ) + sum(pInactiveStats,company_phone      )}
		,{ pId + ' - DBA'          ,DBAActive           ,DBAInactive           ,sum(pActiveStats  ,dba_name           ) + sum(pInactiveStats,dba_name           )}
		,{ pId + ' - SIC Primary'  ,SIC_PrimaryActive   ,SIC_PrimaryInactive   ,sum(pActiveStats  ,company_sic_code1  ) + sum(pInactiveStats,company_sic_code1  )}
		,{ pId + ' - NAICS Primary',NAICS_PrimaryActive ,NAICS_PrimaryInactive ,sum(pActiveStats  ,company_naics_code1) + sum(pInactiveStats,company_naics_code1)}
		,{ pId + ' - Name'         ,NameActive          ,NameInactive          ,sum(pActiveStats  ,lname              ) + sum(pInactiveStats,lname              )}
		,{ pId + ' - Email'        ,EmailActive         ,EmailInactive         ,sum(pActiveStats  ,contact_email      ) + sum(pInactiveStats,contact_email      )}
		,{ pId + ' - Contact Phone',ContactPhoneActive  ,ContactPhoneInactive  ,sum(pActiveStats  ,contact_phone      ) + sum(pInactiveStats,contact_phone      )}
		,{ pId + ' - FEIN'         ,FEINActive          ,FEINInactive          ,sum(pActiveStats  ,company_fein       ) + sum(pInactiveStats,company_fein       )}
		,{ pId + ' - Ticker'       ,TickerActive        ,TickerInactive        ,sum(pActiveStats  ,company_ticker     ) + sum(pInactiveStats,company_ticker     )}
		,{ pId + ' - URL'          ,URLActive           ,URLInactive           ,sum(pActiveStats  ,company_url        ) + sum(pInactiveStats,company_url        )}
    
  ],BIPV2_Strata.layouts.layout_Demographics_Strata);
  

  return doutput;
  
end;