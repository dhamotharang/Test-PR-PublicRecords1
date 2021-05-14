import mdr;

export SourceHierarchy := module

shared cortera      := mdr.sourceTools.src_Cortera;
shared dca          := mdr.sourceTools.src_DCA;
shared ebd          := mdr.sourceTools.src_Equifax_Business_Data;
shared calbus       := mdr.sourceTools.src_Calbus;
shared txbus        := mdr.sourceTools.src_TXBUS;
shared utcorp       := mdr.sourceTools.src_UT_Corporations;
shared mscorp       := mdr.sourceTools.src_MS_Corporations;
shared ricorp       := mdr.sourceTools.src_RI_Corporations;
shared experianCRDB := mdr.sourceTools.src_Experian_CRDB;
shared yellowPages  := mdr.sourceTools.src_Yellow_Pages;
shared dnb          := mdr.sourceTools.src_Dunn_Bradstreet;
shared dnbFEIN      := mdr.sourceTools.src_Dunn_Bradstreet_Fein;
shared dataBridge   := mdr.sourceTools.src_DataBridge;
shared infutorNARB  := mdr.sourceTools.src_Infutor_NARB;
shared EBR          := mdr.sourceTools.src_EBR;
shared frandX       := mdr.sourceTools.src_Frandx;

export naics_sources := dataset([
                                 {dca,1}
                                ,{ebd,2}
                                ,{cortera,3}
                                ,{calbus,4}
                                ,{txbus,5}
                                ,{utcorp,6}
                                ,{mscorp,7}
                                ,{ricorp,8}
                                ,{experianCRDB,9}
                                ,{yellowPages,10} // Change to Source Name
                                ],{string2 source, integer sourceSortOrder});

// Change to Source Name
export sic_sources := dataset([
                    {dca,1}
                   ,{ebd,2}
                   ,{dnb,3}
                   ,{dataBridge,4}
                   ,{infutorNARB,5}
                   ,{cortera,6}
                   ,{dnbFEIN,7}
                   ,{EBR,8}
                   ,{experianCRDB,9}
                   ,{frandX,10}
                   ,{yellowPages,11}
                   ],{string2 source, integer sourceSortOrder});
									 
end;