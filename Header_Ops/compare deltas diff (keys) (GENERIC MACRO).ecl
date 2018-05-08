#WORKUNIT('name','Analyze differences between two files');
#OPTION('defaultSkewError',0.2);

// example: mac_count_sample('dataset_attribute_name_as_a_string');

EXPORT mac_count_sample(macro_dataset,pivot_field='',sample_limit=1000) := MACRO

			output(count(#EXPAND(macro_dataset)),named(macro_dataset+'_count'));
			output(choosen(#EXPAND(macro_dataset),sample_limit),named(macro_dataset+'_sample'));

ENDMACRO;





fieldDef(fld) := functionmacro
    return 'string '+fld+'_change';
endmacro;

fieldChange(fld) := functionmacro
    return 'self.'+fld+'_change:= if(L.'+fld+'<>allRows[2].'+fld+',L.'+fld+'+\' -> \'+allRows[2].'+fld+',\'\')';
endmacro;

reportFieldDetails(fld):= functionmacro

return  'ds_'+fld+'_change:=diff_details(grp_cnt>1,'+fld+'_change<>\'\');'
       +'output(choosen(sort(table(ds_'+fld+'_change,{'+fld+'_change,cnt_:=count(group)},'+fld+'_change,merge,many),-cnt_),200),named(\'cnt_'+fld+'_change\'));'
       +'mac_count_sample(\'ds_'+fld+'_change\');';

endmacro;

reportFieldDetails2(fld):= functionmacro

return  'ds_'+fld+'_change2:=diff_details2(grp_cnt>1,'+fld+'_change<>\'\');'
       +'output(choosen(sort(table(ds_'+fld+'_change2,{'+fld+'_change,cnt_:=count(group)},'+fld+'_change,merge,many),-cnt_),200),named(\'cnt_'+fld+'_change2\'));'
       +'mac_count_sample(\'ds_'+fld+'_change2\');';

endmacro;

compareDeltas(i1,i2,kf1,kf2='',kf3='',kf4='',kf5='',cf1,cf2='',cf3='') := functionmacro

d1 := project(i1,transform({string fl:='1',unsigned8 grp_cnt:=1,recordof(LEFT)},SELF:=LEFT));
d2 := project(i2,transform({string fl:='2',unsigned8 grp_cnt:=1,recordof(LEFT)},SELF:=LEFT));

#uniquename(d_groups);
#IF(#TEXT(kf2)='')
%d_groups% := group(dedup(sort(d1+d2,kf1,cf1,fl),kf1,cf1,fl),kf1,cf1);
#ELSEIF(#TEXT(kf3)='')
%d_groups% := group(dedup(sort(d1+d2,kf1,kf2,cf1,fl),kf1,kf2,cf1,fl),kf1,kf2,cf1);
#ELSEIF(#TEXT(kf4)='')
%d_groups% := group(dedup(sort(d1+d2,kf1,kf2,kf3,cf1,fl),kf1,kf2,kf3,cf1,fl),kf1,kf2,kf3,cf1);
#ELSEIF(#TEXT(kf5)='')
%d_groups% := group(dedup(sort(d1+d2,kf1,kf2,kf3,kf4,cf1,fl),kf1,kf2,kf3,kf4,cf1,fl),kf1,kf2,kf3,kf4,cf1);
#ELSE
%d_groups% := group(dedup(sort(d1+d2,kf1,kf2,kf3,kf4,kf5,cf1,fl),kf1,kf2,kf3,kf4,kf5,cf1,fl),kf1,kf2,kf3,kf4,kf5,cf1);
#END

#uniquename(diff_rep_layout);
%diff_rep_layout% := record

    %d_groups%.kf1;
    #IF(#TEXT(kf2)<>'') %d_groups%.kf2; #END
    #IF(#TEXT(kf3)<>'') %d_groups%.kf3; #END
    #IF(#TEXT(kf4)<>'') %d_groups%.kf4; #END
    #IF(#TEXT(kf5)<>'') %d_groups%.kf5; #END
    
    %d_groups%.cf1;
    #IF(#TEXT(cf2)<>'') #EXPAND('d1.'+#TEXT(cf2)); #END
    #IF(#TEXT(cf3)<>'') #EXPAND('d1.'+#TEXT(cf3)); #END
    
    %d_groups%.fl;
    #EXPAND(fieldDef(#TEXT(cf1)));
    #IF(#TEXT(cf2)<>'') #EXPAND(fieldDef(#TEXT(cf2))); #END
    #IF(#TEXT(cf3)<>'') #EXPAND(fieldDef(#TEXT(cf3))); #END
    
    d1.grp_cnt;

end;

%diff_rep_layout% flag_diff(%d_groups% L, dataset(recordof(%d_groups%)) allRows) := transform
                            
    self.grp_cnt         := count(allRows);
    
                       #EXPAND(fieldChange(#TEXT(cf1)));
    #IF(#TEXT(cf2)<>'')#EXPAND(fieldChange(#TEXT(cf2))); #END
    #IF(#TEXT(cf3)<>'')#EXPAND(fieldChange(#TEXT(cf3))); #END
    
    SELF:=L;
        
end;

diff_details:=rollup(%d_groups%,group,flag_diff(LEFT,ROWS(LEFT)));

// Take no matches from the first rollup and restore pre-rollup layout for second rollup
isolated_cf1_changes := project(diff_details(#EXPAND(#TEXT(cf1)+'_change')<>''),
                                TRANSFORM({d1},SELF:=LEFT,SELF:=[]));

mac_count_sample('isolated_cf1_changes');

#uniquename(d_groups2);
#IF(#TEXT(kf2)='')
%d_groups2% := group(sort(isolated_cf1_changes,kf1,fl),kf1);
#ELSEIF(#TEXT(kf3)='')
%d_groups2% := group(sort(isolated_cf1_changes,kf1,kf2,fl),kf1,kf2);
#ELSEIF(#TEXT(kf4)='')
%d_groups2% := group(sort(isolated_cf1_changes,kf1,kf2,kf3,fl),kf1,kf2,kf3);
#ELSEIF(#TEXT(kf5)='')
%d_groups2% := group(sort(isolated_cf1_changes,kf1,kf2,kf3,kf4,fl),kf1,kf2,kf3,kf4);
#ELSE
%d_groups2% := group(sort(isolated_cf1_changes,kf1,kf2,kf3,kf4,kf5,fl),kf1,kf2,kf3,kf4,kf5);
#END


diff_details2:=rollup(%d_groups2%,group,flag_diff(LEFT,ROWS(LEFT)));


output(count(d1),named('total_before'));
output(count(d2),named('total_after'));

only_in_first:=diff_details(grp_cnt=1,fl='1');
only_in_secnd:=diff_details(grp_cnt=1,fl='2');

mac_count_sample('only_in_first');
mac_count_sample('only_in_secnd');

only_in_first2:=diff_details2(grp_cnt=1,fl='1');
only_in_secnd2:=diff_details2(grp_cnt=1,fl='2');

mac_count_sample('only_in_first2');
mac_count_sample('only_in_secnd2');


#IF(#TEXT(cf2)<>'') #EXPAND(reportFieldDetails(#TEXT(cf2))); #END
#IF(#TEXT(cf3)<>'') #EXPAND(reportFieldDetails(#TEXT(cf3))); #END

                    #EXPAND(reportFieldDetails2(#TEXT(cf1)));
#IF(#TEXT(cf2)<>'') #EXPAND(reportFieldDetails2(#TEXT(cf2))); #END
#IF(#TEXT(cf3)<>'') #EXPAND(reportFieldDetails2(#TEXT(cf3))); #END

multiple_group_match_inc_cf1 := diff_details(grp_cnt>2);
mac_count_sample('multiple_group_match_inc_cf1');

multiple_group_match_diff_cf1 := diff_details2(grp_cnt>2);
mac_count_sample('multiple_group_match_diff_cf1');

return true;

endmacro;

// ************************************************************************************

// Define your dataset below, specify fields and call 'compareDeltas'
fd:=data_services.foreign_dataland;
lc:=data_services.foreign_prod;

// ds1 := pull(index(doxie.key_nbr_headers_uid,'~thor_data400::key::header::20171121::nbr_uid'));
// ds2 := pull(index(doxie.key_nbr_headers_uid,'~thor_data400::key::header::20171121w::nbr_uid'));

// ds1 := pull(index(Doxie.Key_DID_SSN_Date(),'~thor_data400::key::header::20180130::did.ssn.date'));
// ds2 := pull(index(Doxie.Key_DID_SSN_Date(),'~thor_data400::key::header::20180221::did.ssn.date'));

// ds1 := table(pull(index(watchdog.Key_watchdog_glb,'~thor_data400::key::watchdog::20180111::best.did')),{did,ssn,valid_ssn});
// ds2 := table(pull(index(watchdog.Key_watchdog_glb,'~thor_data400::key::watchdog::20180122::best.did')),{did,ssn,valid_ssn});

ds1:=dataset('~thor_200::base::dl2::drvlic_aid_w20180327-163110',driversv2.Layout_Base_withAID,thor);
ds2:=dataset('~thor_200::base::dl2::drvlic_aid_w20180422-040837',driversv2.Layout_Base_withAID,thor);

c1 := 
compareDeltas(ds1,ds2,                    // datasets to compare

              dob,did,orig_state,lname,prim_name,           // 1-5 rollup fields (to generate unique record per dataset)
              ssn_safe,ssn,); // 1-3 fields for difference analysis. >>> NB !!!! >>> (no. 1 is the same as "cf1" in results)
c1;