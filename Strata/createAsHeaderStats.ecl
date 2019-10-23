export createAsHeaderStats(ds, 
                           pBuildName, 
                           pBuildSubSet, 
						   pVersionName, 
						   pEmailNotifyList, 
						   rOut,
							 pOmit_Output_To_Screen=false
						  ) := macro

import header, ngadl;

#uniquename(headerLayout)    
// %ds% := pStats;

%headerLayout%
 :=
  record
    unsigned8 CountGroup := count(group);
    ds.src;
    unsigned8 did_CountNonZero                                     := sum(group,if(ds.did<>0,1,0));
    unsigned8 rid_CountNonZero                                     := sum(group,if(ds.rid<>0,1,0));
    unsigned8 pflag1_CountNonBlank                                 := sum(group,if(ds.pflag1<>'',1,0));
    unsigned8 pflag2_CountNonBlank                                 := sum(group,if(ds.pflag2<>'',1,0));
    unsigned8 pflag3_CountNonBlank                                 := sum(group,if(ds.pflag3<>'',1,0));
    unsigned8 dt_first_seen_CountNonZero                           := sum(group,if(ds.dt_first_seen<>0,1,0));
    unsigned8 dt_last_seen_CountNonZero                            := sum(group,if(ds.dt_last_seen<>0,1,0));
    unsigned8 dt_vendor_last_reported_CountNonZero                 := sum(group,if(ds.dt_vendor_last_reported<>0,1,0));
    unsigned8 dt_vendor_first_reported_CountNonZero                := sum(group,if(ds.dt_vendor_first_reported<>0,1,0));
    unsigned8 dt_nonglb_last_seen_CountNonZero                     := sum(group,if(ds.dt_nonglb_last_seen<>0,1,0));
    unsigned8 rec_type_CountNonBlank                               := sum(group,if(ds.rec_type<>'',1,0));
    unsigned8 vendor_id_CountNonBlank                              := sum(group,if(ds.vendor_id<>'',1,0));
    unsigned8 phone_CountNonBlank                                  := sum(group,if(ds.phone<>'',1,0));
    unsigned8 ssn_CountNonBlank                                    := sum(group,if(ds.ssn<>'',1,0));
    unsigned8 dob_CountNonZero                                     := sum(group,if(ds.dob<>0,1,0));
    unsigned8 title_CountNonBlank                                  := sum(group,if(ds.title<>'',1,0));
    unsigned8 fname_CountNonBlank                                  := sum(group,if(ds.fname<>'',1,0));
    unsigned8 mname_CountNonBlank                                  := sum(group,if(ds.mname<>'',1,0));
    unsigned8 lname_CountNonBlank                                  := sum(group,if(ds.lname<>'',1,0));
    unsigned8 name_suffix_CountNonBlank                            := sum(group,if(ds.name_suffix<>'',1,0));
    unsigned8 prim_range_CountNonBlank                             := sum(group,if(ds.prim_range<>'',1,0));
    unsigned8 predir_CountNonBlank                                 := sum(group,if(ds.predir<>'',1,0));
    unsigned8 prim_name_CountNonBlank                              := sum(group,if(ds.prim_name<>'',1,0));
    unsigned8 suffix_CountNonBlank                                 := sum(group,if(ds.suffix<>'',1,0));
    unsigned8 postdir_CountNonBlank                                := sum(group,if(ds.postdir<>'',1,0));
    unsigned8 unit_desig_CountNonBlank                             := sum(group,if(ds.unit_desig<>'',1,0));
    unsigned8 sec_range_CountNonBlank                              := sum(group,if(ds.sec_range<>'',1,0));
    unsigned8 city_name_CountNonBlank                              := sum(group,if(ds.city_name<>'',1,0));
    unsigned8 st_CountNonBlank                                     := sum(group,if(ds.st<>'',1,0));
    unsigned8 zip_CountNonBlank                                    := sum(group,if(ds.zip<>'',1,0));
    unsigned8 zip4_CountNonBlank                                   := sum(group,if(ds.zip4<>'',1,0));
    unsigned8 county_CountNonBlank                                 := sum(group,if(ds.county<>'',1,0));
    unsigned8 geo_blk_CountNonBlank                                := sum(group,if(ds.geo_blk<>'',1,0));
    unsigned8 cbsa_CountNonBlank                                   := sum(group,if(ds.cbsa<>'',1,0));
    unsigned8 tnt_CountNonBlank                                    := sum(group,if(ds.tnt<>'',1,0));
    unsigned8 valid_SSN_CountNonBlank                              := sum(group,if(ds.valid_SSN<>'',1,0));
    unsigned8 jflag1_CountNonBlank                                 := sum(group,if(ds.jflag1<>'',1,0));
    unsigned8 jflag2_CountNonBlank                                 := sum(group,if(ds.jflag2<>'',1,0));
    unsigned8 jflag3_CountNonBlank                                 := sum(group,if(ds.jflag3<>'',1,0));
    unsigned8 uid_CountNonZero                                     := sum(group,if(ds.uid<>0,1,0));
end;

#uniquename(tstats)
#uniquename(zAsHeaderOut1)
#uniquename(zAsHeaderOut2)
%tStats% := table(ds, %headerLayout%, src, few);

strata.createXMLStats(%tStats%, pBuildName, pBuildSubSet, pVersionName, pEmailNotifyList, %zAsHeaderOut1%, 'AsHeader', 'Population',,,pOmit_Output_To_Screen)

#uniquename(dNGADL_as_header_hygiene)

%dNGADL_as_header_hygiene% :=     ngadl.hygiene(project(ds,ngadl.layout_header)).validityerrors;
strata.createXMLStats(%dNGADL_as_header_hygiene%, pBuildName, pBuildSubSet, pVersionName, pEmailNotifyList, %zAsHeaderOut2%, 'AsHeader', 'NGADL_Hygiene',,,pOmit_Output_To_Screen)  

rOut   :=     parallel(%zAsHeaderOut1%,%zAsHeaderOut2%);

  endmacro
 ;