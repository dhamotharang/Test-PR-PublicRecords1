IMPORT Marketing_Suite_List_Gen, ut; 

// Go through some waterfall logic to determine which duplicate seleid records to keep.
EXPORT fnDedupContacts(DATASET(Marketing_Suite_List_Gen.layouts.Layout_TempFull) dLv0_ML) := FUNCTION

  dLv0_ML_Table := TABLE(dLv0_ML, {seleid, UNSIGNED CountGroup := COUNT(GROUP)}, seleid);
  dLv0_ML_Good_Group  := dLv0_ML_Table(CountGroup < 2);
  dLv0_ML_Dupes_Group  := dLv0_ML_Table(CountGroup > 1);
  dLv0_ML_Good := JOIN(dLv0_ML, dLv0_ML_Good_Group, LEFT.seleid = RIGHT.seleid, TRANSFORM(LEFT), LOOKUP);
  dLv0_ML_Dupes := JOIN(dLv0_ML, dLv0_ML_Dupes_Group, LEFT.seleid = RIGHT.seleid, TRANSFORM(LEFT), LOOKUP);


  /****  Remove duplicates based on same lexid or if lexid is 0 then look at first/last name ****/
  dLv0_ML_Dupes_Sort := SORT(dLv0_ML_Dupes, seleid, lexid, lname, fname, LOCAL);
  dLv1_ML := DEDUP(dLv0_ML_Dupes_Sort, 
                        LEFT.seleid = RIGHT.seleid
                        AND LEFT.lexid = RIGHT.lexid OR (LEFT.lexid = 0 AND (LEFT.fname = RIGHT.fname AND LEFT.lname = RIGHT.lname))
                       ,LOCAL);

  /****  Check to see how many duplicates are left ****/
  dLv1_ML_Table := TABLE(dLv1_ML, {seleid, UNSIGNED CountGroup := COUNT(GROUP)}, seleid);
  dLv1_ML_Good_Group  := dLv1_ML_Table(CountGroup < 2);
  dLv1_ML_Dupes_Group := dLv1_ML_Table(CountGroup > 1);

  /****  Here are the good non-dupes after lexid ****/
  dLv1_ML_Good := JOIN(dLv1_ML, dLv1_ML_Good_Group, LEFT.seleid = RIGHT.seleid, TRANSFORM(LEFT), LOOKUP);

  /****  Here are the dupes after lexid ****/
  dLv1_ML_Dupes := JOIN(dLv1_ML, dLv1_ML_Dupes_Group, LEFT.seleid = RIGHT.seleid, TRANSFORM(LEFT), LOOKUP);



  /****  Remove duplicates based on most recent contact date last seen ****/
  dLv1_ML_Dupes_Sort := SORT(dLv1_ML_Dupes, seleid, lexid, lname, fname, -dt_last_seen);
  dLv2_ML := DEDUP(dLv1_ML_Dupes_Sort 
                       ,LEFT.seleid = RIGHT.seleid
                        AND LEFT.lexid = RIGHT.lexid OR (LEFT.lexid = 0 AND (LEFT.fname = RIGHT.fname AND LEFT.lname = RIGHT.lname))
                        AND LEFT.dt_last_seen > RIGHT.dt_last_seen
                       ,LOCAL);

  /****  Check to see how many duplicates are left after date last seen check ****/
  dLv2_ML_Table := TABLE(dLv2_ML, {seleid, UNSIGNED CountGroup := COUNT(GROUP)}, seleid);
  dLv2_ML_Good_Group  := dLv2_ML_Table(CountGroup < 2);
  dLv2_ML_Dupes_Group := dLv2_ML_Table(CountGroup > 1);

  /****  Here are the good non-dupes after date last seen check ****/
  dLv2_ML_Good := JOIN(dLv2_ML, dLv2_ML_Good_Group, LEFT.seleid = RIGHT.seleid, TRANSFORM(LEFT), LOOKUP);

  /****  Here are the dupes after date last seen check ****/
  dLv2_ML_Dupes := JOIN(dLv2_ML, dLv2_ML_Dupes_Group, LEFT.seleid = RIGHT.seleid, TRANSFORM(LEFT), LOOKUP);


  /****  Remove duplicates based on the contact address populated ****/
  dLv2_ML_Dupes_Sort := SORT(dLv2_ML_Dupes, seleid, lexid, lname, fname, -contact_address);
  dLv3_ML := DEDUP(dLv2_ML_Dupes_Sort 
                       ,LEFT.seleid = RIGHT.seleid
                        AND LEFT.lexid = RIGHT.lexid OR (LEFT.lexid = 0 AND (LEFT.fname = RIGHT.fname AND LEFT.lname = RIGHT.lname))
                        AND LENGTH(ut.CleanSpacesAndUpper(LEFT.contact_address)) > 0 AND LENGTH(ut.CleanSpacesAndUpper(RIGHT.contact_address)) = 0
                       ,LOCAL);

  /****  Check to see how many duplicates are left after contact address populated ****/
  dLv3_ML_Table := TABLE(dLv3_ML, {seleid, UNSIGNED CountGroup := COUNT(GROUP)}, seleid);
  dLv3_ML_Good_Group  := dLv3_ML_Table(CountGroup < 2);
  dLv3_ML_Dupes_Group := dLv3_ML_Table(CountGroup > 1);

  /****  Here are the good non-dupes after contact address populated ****/
  dLv3_ML_Good := JOIN(dLv3_ML, dLv3_ML_Good_Group, LEFT.seleid = RIGHT.seleid, TRANSFORM(LEFT), LOOKUP);

  /****  Here are the dupes after contact address populated ****/
  dLv3_ML_Dupes := JOIN(dLv3_ML, dLv3_ML_Dupes_Group, LEFT.seleid = RIGHT.seleid, TRANSFORM(LEFT), LOOKUP);


  /****  Remove duplicates based on the contact email address populated ****/
  dLv3_ML_Dupes_Sort := SORT(dLv3_ML_Dupes, seleid, lexid, lname, fname, -contact_email_address);
  dLv4_ML := DEDUP(dLv3_ML_Dupes_Sort 
                       ,LEFT.seleid = RIGHT.seleid
                        AND LEFT.lexid = RIGHT.lexid OR (LEFT.lexid = 0 AND (LEFT.fname = RIGHT.fname AND LEFT.lname = RIGHT.lname))
                        AND LENGTH(ut.CleanSpacesAndUpper(LEFT.contact_email_address)) > 0 AND LENGTH(ut.CleanSpacesAndUpper(RIGHT.contact_email_address)) = 0
                       ,LOCAL);

  /****  Check to see how many duplicates are left after contact email address populated ****/
  dLv4_ML_Table := TABLE(dLv4_ML, {seleid, UNSIGNED CountGroup := COUNT(GROUP)}, seleid);
  dLv4_ML_Good_Group  := dLv4_ML_Table(CountGroup < 2);
  dLv4_ML_Dupes_Group := dLv4_ML_Table(CountGroup > 1);

  /****  Here are the good non-dupes after contact email address populated ****/
  dLv4_ML_Good := JOIN(dLv4_ML, dLv4_ML_Good_Group, LEFT.seleid = RIGHT.seleid, TRANSFORM(LEFT), LOOKUP);

  /****  Here are the dupes after contact email address populated ****/
  dLv4_ML_Dupes := JOIN(dLv4_ML, dLv4_ML_Dupes_Group, LEFT.seleid = RIGHT.seleid, TRANSFORM(LEFT), LOOKUP);


  /****  Remove duplicates based on the title populated ****/
  dLv4_ML_Dupes_Sort := SORT(dLv4_ML_Dupes, seleid, lexid, lname, fname, -title);
  dLv5_ML := DEDUP(dLv4_ML_Dupes_Sort 
                       ,LEFT.seleid = RIGHT.seleid
                        AND LEFT.lexid = RIGHT.lexid OR (LEFT.lexid = 0 AND (LEFT.fname = RIGHT.fname AND LEFT.lname = RIGHT.lname))
                        AND LENGTH(ut.CleanSpacesAndUpper(LEFT.title)) > 0 AND LENGTH(ut.CleanSpacesAndUpper(RIGHT.title)) = 0
                       ,LOCAL);

  /****  Check to see how many duplicates are left after title populated ****/
  dLv5_ML_Table := TABLE(dLv5_ML, {seleid, UNSIGNED CountGroup := COUNT(GROUP)}, seleid);
  dLv5_ML_Good_Group  := dLv5_ML_Table(CountGroup < 2);
  dLv5_ML_Dupes_Group := dLv5_ML_Table(CountGroup > 1);

  /****  Here are the good non-dupes after title populated ****/
  dLv5_ML_Good := JOIN(dLv5_ML, dLv5_ML_Good_Group, LEFT.seleid = RIGHT.seleid, TRANSFORM(LEFT), LOOKUP);

  /****  Here are the dupes after title populated ****/
  dLv5_ML_Dupes := JOIN(dLv5_ML, dLv5_ML_Dupes_Group, LEFT.seleid = RIGHT.seleid, TRANSFORM(LEFT), LOOKUP);


  /****  Remove duplicates based on the largest proxid ****/
  dLv5_ML_Dupes_Sort := SORT(dLv5_ML_Dupes, seleid, lexid, lname, fname, -proxid);
  dLv6_ML := DEDUP(dLv5_ML_Dupes_Sort 
                       ,LEFT.seleid = RIGHT.seleid
                        AND LEFT.lexid = RIGHT.lexid OR (LEFT.lexid = 0 AND (LEFT.fname = RIGHT.fname AND LEFT.lname = RIGHT.lname))
                        AND LEFT.proxid > RIGHT.proxid
                       ,LOCAL);

  /****  Check to see how many duplicates are left after largest proxid ****/
  dLv6_ML_Table := TABLE(dLv6_ML, {seleid, UNSIGNED CountGroup := COUNT(GROUP)}, seleid);
  dLv6_ML_Good_Group  := dLv6_ML_Table(CountGroup < 2);
  dLv6_ML_Dupes_Group := dLv6_ML_Table(CountGroup > 1);

  /****  Here are the good non-dupes after largest proxid ****/
  dLv6_ML_Good := JOIN(dLv6_ML, dLv6_ML_Good_Group, LEFT.seleid = RIGHT.seleid, TRANSFORM(LEFT), LOOKUP);

  /****  Here are the dupes after largest proxid ****/
  dLv6_ML_Dupes := JOIN(dLv6_ML, dLv6_ML_Dupes_Group, LEFT.seleid = RIGHT.seleid, TRANSFORM(LEFT), LOOKUP);


  /****  Remove duplicates based on the lowest person_hierarchy ****/
  dLv6_ML_Dupes_Sort := SORT(dLv6_ML_Dupes, seleid, lexid, lname, fname, person_hierarchy);
  dLv7_ML := DEDUP(dLv6_ML_Dupes_Sort 
                       ,LEFT.seleid = RIGHT.seleid
                        AND LEFT.lexid = RIGHT.lexid OR (LEFT.lexid = 0 AND (LEFT.fname = RIGHT.fname AND LEFT.lname = RIGHT.lname))
                        AND LEFT.person_hierarchy < RIGHT.person_hierarchy
                       ,LOCAL);

  /****  Check to see how many duplicates are left after lowest person_hierarchy ****/
  dLv7_ML_Table := TABLE(dLv7_ML, {seleid, UNSIGNED CountGroup := COUNT(GROUP)}, seleid);
  dLv7_ML_Good_Group  := dLv7_ML_Table(CountGroup < 2);
  dLv7_ML_Dupes_Group := dLv7_ML_Table(CountGroup > 1);

  /****  Here are the good non-dupes after lowest person_hierarchy ****/
  dLv7_ML_Good := JOIN(dLv7_ML, dLv7_ML_Good_Group, LEFT.seleid = RIGHT.seleid, TRANSFORM(LEFT), LOOKUP);

  /****  Here are the dupes after lowest person_hierarchy ****/
  dLv7_ML_Dupes := JOIN(dLv7_ML, dLv7_ML_Dupes_Group, LEFT.seleid = RIGHT.seleid, TRANSFORM(LEFT), LOOKUP);


  /****  Remove duplicates RANDOMLY from the duplicates that are left ****/
  dLv7_ML_Dupes_Sort := SORT(dLv7_ML_Dupes, seleid, lexid, lname, fname);
  dLv8_ML := DEDUP(dLv7_ML_Dupes_Sort 
                       ,LEFT.seleid = RIGHT.seleid
                        AND LEFT.lexid = RIGHT.lexid OR (LEFT.lexid = 0 AND (LEFT.fname = RIGHT.fname AND LEFT.lname = RIGHT.lname))
                       ,KEEP 1
                       ,LOCAL);


  d_ML_Good := dLv0_ML_Good + dLv1_ML_Good + dLv2_ML_Good + dLv3_ML_Good + dLv4_ML_Good + dLv5_ML_Good + dLv6_ML_Good + dLv7_ML_Good + dLv8_ML;
  
  RETURN d_ML_Good;

END;