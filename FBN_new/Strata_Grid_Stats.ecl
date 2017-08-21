import strata;
fbn_file := file_fbn_fixed_in;
Layout_fbn_file_stat :=
record
	unsigned8 CountGroup                                                                  := count(group);
	fbn_file.BUS_STATE;
	unsigned8 PROCESS_DATE_CountNonBlank                                                  := sum(group, if(fbn_file.PROCESS_DATE                                                       <> ''  ,1,0));
	unsigned8 CNTCT_SALUTATION_CountNonBlank                                              := sum(group, if(fbn_file.CNTCT_SALUTATION                                                   <> ''  ,1,0));
	unsigned8 CNTCT_FIRST_NAME_CountNonBlank                                              := sum(group, if(fbn_file.CNTCT_FIRST_NAME                                                   <> ''  ,1,0));
	unsigned8 CNTCT_LAST_NAME_CountNonBlank                                               := sum(group, if(fbn_file.CNTCT_LAST_NAME                                                    <> ''  ,1,0));
	unsigned8 CNTCT_SUFFIX_CountNonBlank                                                  := sum(group, if(fbn_file.CNTCT_SUFFIX                                                       <> ''  ,1,0));
	unsigned8 BUS_NAME_CountNonBlank                                                      := sum(group, if(fbn_file.BUS_NAME                                                           <> ''  ,1,0));
	unsigned8 BUS_STR_ADDR_CountNonBlank                                                  := sum(group, if(fbn_file.BUS_STR_ADDR                                                       <> ''  ,1,0));
	unsigned8 BUS_CITY_CountNonBlank                                                      := sum(group, if(fbn_file.BUS_CITY                                                           <> ''  ,1,0));
	unsigned8 BUS_ZIP_CountNonBlank                                                       := sum(group, if(fbn_file.BUS_ZIP                                                            <> ''  ,1,0));
	unsigned8 BUS_ZIP_4_CountNonBlank                                                     := sum(group, if(fbn_file.BUS_ZIP_4                                                          <> ''  ,1,0));
	unsigned8 BUS_CARRIER_RT_CountNonBlank                                                := sum(group, if(fbn_file.BUS_CARRIER_RT                                                     <> ''  ,1,0));
	unsigned8 BUS_PHONE_NUM_CountNonBlank                                                 := sum(group, if(fbn_file.BUS_PHONE_NUM                                                      <> ''  ,1,0));
	unsigned8 FIPS_CNTY_CODE_CountNonBlank                                                := sum(group, if(fbn_file.FIPS_CNTY_CODE                                                     <> ''  ,1,0));
	unsigned8 SIC_CODE_CountNonBlank                                                      := sum(group, if(fbn_file.SIC_CODE                                                           <> ''  ,1,0));
	unsigned8 BUS_DESCRIPTION_CountNonBlank                                               := sum(group, if(fbn_file.BUS_DESCRIPTION                                                    <> ''  ,1,0));
	unsigned8 FILING_TYPE_CountNonBlank                                                   := sum(group, if(fbn_file.FILING_TYPE                                                        <> ''  ,1,0));
	unsigned8 FILING_DATE_CountNonBlank                                                   := sum(group, if(fbn_file.FILING_DATE                                                        <> ''  ,1,0));
	unsigned8 CNTCT_STR_ADDR_CountNonBlank                                                := sum(group, if(fbn_file.CNTCT_STR_ADDR                                                     <> ''  ,1,0));
	unsigned8 CNTCT_CITY_CountNonBlank                                                    := sum(group, if(fbn_file.CNTCT_CITY                                                         <> ''  ,1,0));
	unsigned8 CNTCT_STATE_CountNonBlank                                                   := sum(group, if(fbn_file.CNTCT_STATE                                                        <> ''  ,1,0));
	unsigned8 CNTCT_ZIP_CountNonBlank                                                     := sum(group, if(fbn_file.CNTCT_ZIP                                                          <> ''  ,1,0));
	unsigned8 CNTCT_PHONE_NUM_CountNonBlank                                               := sum(group, if(fbn_file.CNTCT_PHONE_NUM                                                    <> ''  ,1,0));
	unsigned8 HOTLINE_MM_YY_CountNonBlank                                                 := sum(group, if(fbn_file.HOTLINE_MM_YY                                                      <> ''  ,1,0));
	unsigned8 FILING_NUMBER_CountNonBlank                                                 := sum(group, if(fbn_file.FILING_NUMBER                                                      <> ''  ,1,0));
end;
fbn_file_stat := table(fbn_file, Layout_fbn_file_stat, BUS_STATE  , few);
strata.createXMLStats(fbn_file_stat, 'Infousa FBN', 'data', ut.GetDate, 'lbentley@seisint.com', resultsOut, 'View', 'Population');

export Strata_Grid_Stats := resultsOut;