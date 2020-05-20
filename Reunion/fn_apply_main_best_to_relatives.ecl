EXPORT fn_apply_main_best_to_relatives(DATASET(reunion.layouts.lRelativesSlim) dInRelatives,DATASET(RECORDOF(reunion.mapping_reunion_main().all)) dInMain):=FUNCTION

  dRelatives01:=DISTRIBUTE(dInRelatives,HASH(person1));
  dMain:=DISTRIBUTE(dInMain,HASH(did));

  // First join the relative pair candidates to the main where came_from='1'
  // to restrict the list to first-degree only
  dFirstDegreeRelatives:=DISTRIBUTE(JOIN(dRelatives01,dMain(came_from='1'),LEFT.person1=RIGHT.did,TRANSFORM(RECORDOF(dRelatives01),SELF:=LEFT;),LOCAL),HASH(person2));

  // Then join on person2 to get best information for the remaining relative
  // records
  lJoined:=RECORD
    dMain.came_from;
    dFirstDegreeRelatives.person1;
    dFirstDegreeRelatives.person2;
    reunion.layouts.lRelatives;
  END;

  lJoined tjoin(dFirstDegreeRelatives L,dmain R):=TRANSFORM
    SELF.came_from              :=R.came_from;
    SELF.person1                :=L.person1;
    SELF.person2                :=L.person2;
    SELF.main_adl               :=INTFORMAT(L.person1,12,1);
    SELF.relative_adl           :=INTFORMAT(L.person2,12,1);
    SELF.relative_title         :=R.best_title;
    SELF.relative_fname         :=R.best_fname;
    SELF.relative_mname         :=R.best_mname;
    SELF.relative_lname         :=R.best_lname;
    SELF.relative_name_suffix   :=R.best_name_suffix;
    SELF.relative_street        :=R.best_street;
    SELF.relative_city          :=R.best_city;
    SELF.relative_st            :=R.best_st;
    SELF.relative_zip           :=R.best_zip;
    SELF.relative_phone         :=R.phone;
    SELF.relative_dob           :=R.best_dob;
    SELF.relative_date_of_death :=R.date_of_death;
  END;
  dJoined:=JOIN(dFirstDegreeRelatives,dMain,LEFT.person2=RIGHT.did,tjoin(LEFT,RIGHT),LOCAL);

  RETURN dJoined;
END;