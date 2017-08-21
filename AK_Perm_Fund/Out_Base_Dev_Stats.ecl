import ut,strata;

ds    := ak_perm_fund.file_APF_In;
ds_pe := ak_perm_fund.file_APF_PE_In;

rPopulationStats_ds
 :=
  record
    CountGroup := count(group);
    ds.state_origin;
	ds.process_date;
    process_year_CountNonBlank                := sum(group,if(ds.process_year<>'',1,0));
    last_name_CountNonBlank                   := sum(group,if(ds.last_name<>'',1,0));
    first_name_CountNonBlank                  := sum(group,if(ds.first_name<>'',1,0));
    address1_CountNonBlank                    := sum(group,if(ds.address1<>'',1,0));
    address2_CountNonBlank                    := sum(group,if(ds.address2<>'',1,0));
    city_CountNonBlank                        := sum(group,if(ds.city<>'',1,0));
    state_CountNonBlank                       := sum(group,if(ds.state<>'',1,0));
    zip5_CountNonBlank                        := sum(group,if(ds.zip5<>'',1,0));
    junk_CountNonBlank                        := sum(group,if(ds.junk<>'',1,0));
    zip4_CountNonBlank                        := sum(group,if(ds.zip4<>'',1,0));
    crlf_CountNonBlank                        := sum(group,if(ds.crlf<>'',1,0));
    clean_address_CountNonBlank               := sum(group,if(ds.clean_address<>'',1,0));
    pname_CountNonBlank                       := sum(group,if(ds.pname<>'',1,0));
end;

rPopulationStats_ds_pe
 :=
  record
    CountGroup := count(group);
    ds_pe.state_origin;
    ds_pe.process_date;
    last_name_CountNonBlank                    := sum(group,if(ds_pe.last_name<>'',1,0));
    first_name_CountNonBlank                   := sum(group,if(ds_pe.first_name<>'',1,0));
    middle_initial_CountNonBlank               := sum(group,if(ds_pe.middle_initial<>'',1,0));
    address1_CountNonBlank                     := sum(group,if(ds_pe.address1<>'',1,0));
    address2_CountNonBlank                     := sum(group,if(ds_pe.address2<>'',1,0));
    city_CountNonBlank                         := sum(group,if(ds_pe.city<>'',1,0));
    state_CountNonBlank                        := sum(group,if(ds_pe.state<>'',1,0));
    zip5_CountNonBlank                         := sum(group,if(ds_pe.zip5<>'',1,0));
    zip4_CountNonBlank                         := sum(group,if(ds_pe.zip4<>'',1,0));
    lf_CountNonBlank                           := sum(group,if(ds_pe.lf<>'',1,0));
    clean_address_CountNonBlank                := sum(group,if(ds_pe.clean_address<>'',1,0));
    pname_CountNonBlank                        := sum(group,if(ds_pe.pname<>'',1,0));
end;

tStats    := table(ds,   rPopulationStats_ds,   state_origin,process_date,few);
tStats_pe := table(ds_pe,rPopulationStats_ds_pe,state_origin,process_date,few);

zOrig_Stats    := output(choosen(tStats,   all));
zOrig_Stats_pe := output(choosen(tStats_pe,all));

STRATA.createXMLStats(tStats,   'AK Perm Fund','APF',   ut.GetDate,'jtrost@seisint.com',zPopulation_Stats,   'View','Population')
STRATA.createXMLStats(tStats_pe,'AK Perm Fund','APF PE',ut.GetDate,'jtrost@seisint.com',zPopulation_Stats_pe,'View','Population')

STRATA.createAsHeaderStats(ak_perm_fund.APF_As_Header(ak_perm_fund.file_APF_In,ak_perm_fund.file_APF_PE_In),'AK Perm Fund','Data',ut.GetDate,'jtrost@seisint.com',zAs_Header_Stats)

export Out_Base_Dev_Stats := parallel(zOrig_Stats
                                      ,zOrig_Stats_pe
									  ,zPopulation_Stats
									  ,zPopulation_Stats_pe
									  ,zAs_Header_Stats
									  );