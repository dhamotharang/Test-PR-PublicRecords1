import ut;

dNonExperianDLs
 := Florida_As_DL 
 +    Ohio_As_DL
 +    TX_As_DL
 +    MO_as_DL 
 +    MN_as_DL 
 +    NM_as_DL
 +    ID_as_DL
 +    WI_as_DL
 +    WV_as_DL
 +    MI_as_DL
 +    ME_as_DL
 +    MA_as_DL
 +    TN_as_DL
 +    WY_as_DL
 +    KY_as_DL
 +    CT_as_DL
/* -- Removed per Kim Hester (OR: 2004.11.16, IA: 2004.10.14)
 +    OR_as_DL
 +    IA_as_DL
*/
 ;    // Adding in Experian records below!

dExperianDist        :=    distribute(Drivers.Mapping_Experian_as_DL,hash(orig_state,lname));
dNonExperianDist    :=    distribute(dNonExperianDLs,hash(orig_state,lname));
dExperianSort        :=    sort(dExperianDist,orig_state,lname,fname,mname,name_suffix,zip5,zip4,lic_issue_date,orig_expiration_date,local);
dNonExperianSort    :=    sort(dNonExperianDist,orig_state,lname,fname,mname,name_suffix,zip5,zip4,lic_issue_date,orig_expiration_date,local);

recordof(dExperianSort)    tExperianNotAlreadyHere(dExperianSort pExperian, dNonExperianSort pNonExperian)
 :=
  transform
    self    :=    pExperian;
  end
 ;

dExperianNotInHouse    :=    join(dExperianSort,dNonExperianSort,
                             left.orig_state            =    right.orig_state
                         and left.lname                    =    right.lname
                         and left.fname                    =    right.fname
                         and left.mname                    =    right.mname
                         and left.name_suffix            =    right.name_suffix
                         and left.zip5                    =    right.zip5
                         and left.zip4                    =    right.zip4
                         and left.lic_issue_date        =    right.lic_issue_date
                         and left.orig_expiration_date    =    right.orig_expiration_date,
                             tExperianNotAlreadyHere(left,right),
                             left only,
                             local
                            );


ldl := drivers.Layout_DL;

//****** Check each rec to make sure it did not expire b4 that states initial load
//         If it did, then zero out its dates

drivers.MAC_Check_Expire(dNonExperianDLs, orig_expiration_date, dNonExperianChecked)

dCombinedDLs    :=    dNonExperianChecked    + dExperianNotInHouse;    // no need to check Experian DL dates...  already done there.

//****** Get rid of recs that are just a state dumping the same thing again

dist := distribute(dCombinedDLs, hash(orig_state, dl_number));
srtd := sort(dist,orig_state,dl_number,name,addr1,city,state,zip,dob,race,sex_flag,license_type,
    attention_flag,dod,restrictions,orig_expiration_date,orig_issue_date,lic_issue_date,
    expiration_date,active_date,inactive_date,lic_endorsement,motorcycle_code,ssn,age,
    privacy_flag,driver_edu_code,dup_lic_count,rcd_stat_flag,height,hair_color,eye_color,weight,
    oos_previous_dl_number,oos_previous_st,status,issuance,address_change,name_change,dob_change,
    sex_change,old_dl_number,dl_key_number, 
    //want to keep the oldest rec
    dt_first_seen, lic_issue_date, orig_expiration_date,
    local);

mac_selfequalr(field) := macro
    self.field := r.field;
endmacro;

typeof(srtd) rollem(srtd l, srtd r) := transform
    //take the right (newer data) on cleaned fields
    mac_selfequalr(title)
    mac_selfequalr(fname)
    mac_selfequalr(mname)
    mac_selfequalr(lname)
    mac_selfequalr(name_suffix)
    mac_selfequalr(cleaning_score)
    mac_selfequalr(addr_fix_flag)
    mac_selfequalr(prim_range)
    mac_selfequalr(predir)
    mac_selfequalr(prim_name)
    mac_selfequalr(suffix)
    mac_selfequalr(postdir)
    mac_selfequalr(unit_desig)
    mac_selfequalr(sec_range)
    mac_selfequalr(p_city_name)
    mac_selfequalr(v_city_name)
    mac_selfequalr(st)
    mac_selfequalr(zip5)
    mac_selfequalr(zip4)
    mac_selfequalr(cart)
    mac_selfequalr(cr_sort_sz)
    mac_selfequalr(lot)
    mac_selfequalr(lot_order)
    mac_selfequalr(dpbc)
    mac_selfequalr(chk_digit)
    mac_selfequalr(rec_type)
    mac_selfequalr(ace_fips_st)
    mac_selfequalr(county)
    mac_selfequalr(geo_lat)
    mac_selfequalr(geo_long)
    mac_selfequalr(msa)
    mac_selfequalr(geo_blk)
    mac_selfequalr(geo_match)
    mac_selfequalr(err_stat)
    //otherwise take the orig
    self := l;
end;

ddpd := rollup(srtd,
    left.orig_state = right.orig_state and
    left.dl_number = right.dl_number and
    left.name = right.name and
    left.addr1 = right.addr1 and
    left.city = right.city and
    left.state = right.state and
    left.zip = right.zip and
    left.dob = right.dob and
    left.race = right.race and
    left.sex_flag = right.sex_flag and
    left.license_type = right.license_type and
    left.attention_flag = right.attention_flag and
    left.dod = right.dod and
    left.restrictions = right.restrictions and
    left.orig_expiration_date = right.orig_expiration_date and
    left.orig_issue_date = right.orig_issue_date and
    left.lic_issue_date = right.lic_issue_date and
    left.expiration_date = right.expiration_date and
    left.active_date = right.active_date and
    left.inactive_date = right.inactive_date and
    left.lic_endorsement = right.lic_endorsement and
    left.motorcycle_code = right.motorcycle_code and
    left.ssn = right.ssn and
    left.age = right.age and
    left.privacy_flag = right.privacy_flag and
    left.driver_edu_code = right.driver_edu_code and
    left.dup_lic_count = right.dup_lic_count and
    left.rcd_stat_flag = right.rcd_stat_flag and
    left.height = right.height and
    left.hair_color = right.hair_color and
    left.eye_color = right.eye_color and
    left.weight = right.weight and
    left.oos_previous_dl_number = right.oos_previous_dl_number and
    left.oos_previous_st = right.oos_previous_st and
    left.status = right.status and
    left.issuance = right.issuance and
    left.address_change = right.address_change and
    left.name_change = right.name_change and
    left.dob_change = right.dob_change and
    left.sex_change = right.sex_change and
    left.old_dl_number = right.old_dl_number and
    left.dl_key_number = right.dl_key_number, 
    rollem(left, right), local);



//****** Set the history flag where there is a newer rec for that person

rlup_same_grp := group(sort(ddpd(history <> 'E'),dl_number, orig_State,-dt_last_seen,-dt_first_seen,-lic_issue_Date,local),dl_number, orig_State,local);


ldl make_hist(ldl le,ldl ri) := transform
  self.history := map(ri.history <> '' => ri.history,
                      ri.orig_expiration_Date > 0 and ri.orig_expiration_Date < (unsigned4)ut.GetDate => 'E',
                      le.orig_state='' => ri.history,
                      'H');
  self := ri;
  end;

res := iterate(rlup_same_grp,make_hist(left,right) ) + ddpd(history = 'E');

export DL_joined := group(res): persist('~thor_200::Persist::DrvLic_DL_Joined');
