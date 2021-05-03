import tools,mdr,BIPV2,ut;

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
    ,pAdd_Eclcc           := true
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

  export set_bad_phones := ['2222222222', '3333333333', '4444444444', '5555555555', '6666666666', '7777777777', '8888888888', '9999999999', '9876543210'] 
                           + ut.set_BadPhones
  ;
  
  export set_valid_lexid_segs := ['CORE'  ,'C_MERGE' ,'NO_SSN' ,'AMBIG'];
  
  export business_terms_regex := '\\b(EXT|INC|FAX|CELL|FX|LLC|COMPANY|BUSINESS|BUSINESSES|EXTENSION|NEW|USE|CARRYOUT|TRUSTEE|BOTH|TAX)\\b';

  export Add_Extra_Source_Fields := true;                    // -- add the extra source fields for sic,naics,employees,contact name. also executive ind & age for contacts.
  
  export Pull_From_Best_File    := true;                    // -- pull sic,naics,employees & revenue from the best file instead of the individual source files.
  export Best_Has_Source_Fields := false;                   // -- pull sic,naics,employees & revenue from the best file instead of the individual source files.

end;
