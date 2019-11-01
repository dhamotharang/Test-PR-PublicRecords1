  // -- 1.  take bip commonbase, filter for populated name, address, only marketing sources, and proxid_status_public = ''
  // -- 2.  cut down record from bip base to just seleid, proxid, company_name, prim_range, prim_name, sec_range, v_city_name, st, zip, county, dt_first_seen, dt_last_seen, phone, contact_email, fname, lname, contact_did, msa, err_stat, proxid_status_public
  // -- 3.  pick best company name, most recently last seen.
  // -- 4.  pick best address, most recently last seen.
  // -- 5.  pick best phone, most recently last seen.
  // -- 6.  pick best email, most recently last seen.
  // -- 7.  pick best contact_info, most recently last seen.
  // -- 8.  calculate age of company from dt_first_seen.
  // -- 9.  pick best industry codes from single source using first 4 digits in this priority order(if same seleid and same unique id, then keep industry code with most recent dt last seen.  for tie breakers use one listed most often):
  // --     a. dca
  // --     b. equifax
  // --     c. osha
  // --     d. databridge
  // --     e. infutor narb
  // --     f. cortera
  // --     g. accutrend
  // -- 10. pick best number of employees. if same seleid and same unique id, then keep employees with most recent dt last seen.  if same seleid and different unique ids, use the one with the highest employee number if in last two years.  
  // --     for tie breaker use dt_last_seen, further tie breaker use one with highest unique id.
  // --     a. dca
  // --     b. equifax
  // --     c. osha
  // --     d. cortera
  // --     e. infutor narb
  // --     f. accutrend
  // -- 11. pick best sales. if same seleid and same unique id, then keep sales with most recent dt last seen.  if same seleid and different unique ids, use the one with the highest sales if in last two years.  
  // --     for tie breaker use dt_last_seen, further tie breaker use one with highest unique id.
  // --     a. dca
  // --     b. equifax
  // --     d. cortera

