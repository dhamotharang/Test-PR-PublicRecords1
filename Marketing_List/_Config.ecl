import tools,mdr,BIPV2;

export _Config(
	 boolean	pUseOtherEnvironment	= false
	,string		pDatasetname					= 'Marketing_List'
) := 
module(
	tools.Constants(
		 pDatasetName					:= pDatasetname
		,pUseOtherEnvironment	:= pUseOtherEnvironment
		,pGroupname						:= '36'
		,pMaxRecordSize				:= 4096
		,pIsTesting						:= Tools._Constants.IsDataland
	))
	
  export EmailList                      := 'laverne.bentley@lexisnexisrisk.com';

  export set_marketing_approved_sources := mdr.sourceTools.set_Marketing_Sources;
 
  code                    := BIPV2.mod_sources.code.MARKETING_UNRESTRICTED;        // (= 9  )
  export Marketing_Bitmap := BIPV2.mod_sources.code2bmap(code);                    // (= 512) "&" with data permits field in best, non-zero = ok for marketing
 
  // -- Ranking of approved sources for Industry codes
  export ds_sources_of_industry_codes      := dataset([
     {1   ,MDR.sourceTools.src_DCA                   }
    ,{2   ,MDR.sourceTools.src_Equifax_Business_Data }
    ,{3   ,MDR.sourceTools.src_OSHAIR                }
    ,{4   ,MDR.sourceTools.src_DataBridge            }
    ,{5   ,MDR.sourceTools.src_Infutor_NARB          }
    ,{6   ,MDR.sourceTools.src_Cortera               }
    ,{7   ,MDR.sourceTools.src_Business_Registration }
  ], Marketing_List.Layouts.source_rank);

  // -- Ranking of approved sources for Number of Employees
  export ds_sources_of_number_of_employees :=  dataset([
     {1   ,MDR.sourceTools.src_DCA                    }
    ,{2   ,MDR.sourceTools.src_Equifax_Business_Data  }
    ,{3   ,MDR.sourceTools.src_OSHAIR                 }
    ,{4   ,MDR.sourceTools.src_Cortera                }
    ,{5   ,MDR.sourceTools.src_Infutor_NARB           }
    ,{6   ,MDR.sourceTools.src_Business_Registration  }  
  ], Marketing_List.Layouts.source_rank);
  ;
  
  // -- Ranking of approved sources for Sales and Revenue
  export ds_sources_of_sales_revenue :=   dataset([
     {1   ,MDR.sourceTools.src_DCA                    }
    ,{2   ,MDR.sourceTools.src_Equifax_Business_Data  }
    ,{3   ,MDR.sourceTools.src_Cortera                }
  ], Marketing_List.Layouts.source_rank);
  ;
  
  export set_sources_of_industry_codes      := set(ds_sources_of_industry_codes       ,source);
  export set_sources_of_number_of_employees := set(ds_sources_of_number_of_employees  ,source);
  export set_sources_of_sales_revenue       := set(ds_sources_of_sales_revenue        ,source);

end;
