IMPORT Data_Services,header,PromoteSupers;

EXPORT proc_build_fraud_flag_eq(string filedate) := function

        LAYOUT_BASE := header_quick.layout_fraud_flag_eq.base;

        raw_file  := header_quick.file_fraud_flag_eq_in;

        LAYOUT_BASE map_to_base(raw_file L) := TRANSFORM

               SELF.vendor_id  :=    header.Cid_Converter(L.cid[1]) + header.Cid_Converter(L.cid[2])
                                +    header.Cid_Converter(L.cid[3]) + header.Cid_Converter(L.cid[4])
                                +    header.Cid_Converter(L.cid[5]) + header.Cid_Converter(L.cid[6])
                                +    header.Cid_Converter(L.cid[7]) + header.Cid_Converter(L.cid[8])
                                +    header.Cid_Converter(L.cid[9]);
               
                SELF.factact_code:=L.factact_code;

                // THIS NEEDS TO BE UPDATED CLOSE TO THE YEAR 2100
                yy := if(L.date_reported='',0,(unsigned)L.date_reported[3..4]);
                yyyy := if(yy=0,0,if(yy<70,2000+yy,2000-yy));
                month  := if(L.date_reported='',0,(unsigned)L.date_reported[1..2]);
                
                SELF.date_reported:= yyyy*100+month;
               
                file_date:= (unsigned3)regexfind('::[0-9]{6}',L.filename,0)[3..];
                SELF.dt_vendor_first_reported:=file_date;
                SELF.dt_vendor_last_reported:=file_date;
        END;

        flag_base_new := project(raw_file,map_to_base(LEFT));
        flag_base_old := header_quick.file_fraud_flag_eq;
        flag_base := dedup(flag_base_new + flag_base_old,record,all);

        // group uses the given sort to generate groups
        // We want consistent codes for each vendor_id over time
        s_flag_base := sort(flag_base,vendor_id,factact_code,date_reported,-dt_vendor_last_reported,-dt_vendor_first_reported);

        // now group each set of codes over time for each consumer
        grp_candidate_new_base := project(group(s_flag_base,vendor_id,factact_code,date_reported),
																																									{{s_flag_base},unsigned3 grp:=0});
								
								shiftone(unsigned3 dt,boolean up):= function

																				month:=((string)dt)[5..6];
																				modifier:= if( (month='01' and ~up) OR (month='12' AND up) , 89 , 1);
																			 return dt+(if(up,1,-1))*modifier;
								end;	

								one_after (unsigned3 dt):= shiftone(dt,true);
								one_before(unsigned3 dt):= shiftone(dt,false);

								{grp_candidate_new_base} split_dates(grp_candidate_new_base L, grp_candidate_new_base R):=TRANSFORM
								
												same_group := (R.dt_vendor_last_reported<=one_after(L.dt_vendor_last_reported)   ) AND
																									(R.dt_vendor_last_reported>=one_before(L.dt_vendor_first_reported) ) ;
																			
												self.grp:=L.grp+if(same_group,0,1);
												SELF := R;
												
								END;
								date_groups := iterate(grp_candidate_new_base,split_dates(LEFT,RIGHT));
								output(choosen(join(date_groups,date_groups(grp>0),LEFT.vendor_id=RIGHT.vendor_id,keep(1)),100));
								output(choosen(join(date_groups,date_groups(grp>1),LEFT.vendor_id=RIGHT.vendor_id,keep(1)),100));
								// regroup using date groups as an additional criteria
							 vid_flag_grp:=group(ungroup(date_groups),vendor_id,factact_code,date_reported,grp);
                
        {vid_flag_grp} set_min_max_dates(vid_flag_grp L, dataset({vid_flag_grp}) allRows) := TRANSFORM

            SELF.dt_vendor_last_reported := max(allRows,dt_vendor_last_reported);
            SELF.dt_vendor_first_reported := min(allRows,dt_vendor_first_reported);
            SELF := L;

        END;

        // rollup to geneerate the history file
        flag_history := rollup(vid_flag_grp,group,set_min_max_dates(LEFT,ROWS(LEFT)));

        PromoteSupers.MAC_SF_BuildProcess( project(flag_history,LAYOUT_BASE)
                                  ,'~thor_data400::base::headerquick::fraud_flag::eq'
                                  ,build_it
                                  ,numgenerations:=2
                                  ,pVersion:=filedate
                                  ,pCompress:=true
                                 );

        return build_it;
        
END;