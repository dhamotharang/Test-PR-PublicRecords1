// -- https://jira.rsi.lexisnexis.com/browse/BH-687

/*
Requirement: Marketing Data File

The product must create two files, one with business information and one with business contact information. The files must use data from the data sources approved for marketing in Appendix A that is not filtered to ensure that all of the results are returned. The lists must include the following fields that have a marketing permissible use:

File 1 - Business Information

All fields in the Business Information file should be in one row per PROXID. If there are multiple PROXIDs in a SELEID then all SELEID data will be repeated in each row.

    SELEID
    PROXID
    ULTID
    ORGID
    All data below should be by the SELEID level
        Business Name
        Business Address
            Street Address - to be one field and include all these fields
                Prim Range
                Predir
                Prim Name
                Addr Suffix
                PostDir
                Unit Desig
                Sec Range
            City
            State
            Zip 5
            County
        MSA
        Address Cleaner Status
        Age of Company - Use the LexisNexis “first seen date” and "last seen date" and it must use the standard format
            Date First Seen
            Date Last Seen
        Business Phone on file
        Business Email on file
        Revenue
            Annual Revenue
        Employees
            Number of Employees
        Industry
            SIC Primary (4 digit level) - all SIC should be in a separate field (total of 5 fields)
                SIC2
                SIC3
                SIC4
                SIC5
            NAICS Primary (6 digit level) - all NAICS should be in a separate field (total of 5 fields)
                NAICS2
                NAICS3
                NAICS4
                NAICS5
    All data below should be at the PROXID level
        Business Name
        Business Address
            Street Address - to be one field and include all these fields
                Prim Range
                Predir
                Prim Name
                Addr Suffix
                PostDir
                Unit Desig
                Sec Range
            City
            State
            Zip 5
            County
        MSA
        Address Cleaner Status
        Age of Company - Use the LexisNexis “first seen date” and "last seen date" and it must be using the standard format
            Date First Seen
            Date Last Seen
        Business Phone on file

 

File 2 - Business Contact Information (LEXID not required) 

All business contact data is to be at the PROXID level

    SELEID – connect the person to the business
    PROXID
    LEXID
    EMPID
    First name
    Last name
    Title 
        Date First Seen
        Date Last Seen
    Title2
        Title2 Date First Seen
        Title2 Date Last Seen
    Title3
        Title3 Date First Seen
        Title3 Date Last Seen
    Title4
        Title4 Date First Seen
        Title4 Date Last Seen
    Title5
        Title5 Date First Seen
        Title5 Date Last Seen
    Person Hierarchy - allow the flexibility to return a single contact

The Business Contact Information will use the below logic for the person hierarchy and will return all unique contacts where a unique contact is first rolled up by LEXID if one exists and then if no LEXID exists rolled up by First Name, Last Name.

    A consumer has been seen at the business in the past 2 years
        Highest ranked title in current hierarchy of titles (used in the contact key build today)
        If no person on file with a title or a tie pick a consumer with the most recent last seen
    A consumer seen at the business outside of the past 2 years
        Highest ranked title in current hierarchy of titles (used in the contact key build today)
        If no person on file with a title or a tie pick a consumer with the most recent last seen

 

The general rule is to create a file at the PROXID Best level with Marketing Data. The service must search at the PROXID Best level that is restricted for marketing data.

EXAMPLE: Return address level 2 in the below scenario:

Address 1 is data that we have but it is not marketing approved, so do not return this data.

Address 2 is data that we have and it is marketing approved, so return this even though we have an Address 1 data that we really know is better.

This product must always use marketing approved sources. Only entities and data containing data from the Marketing Approved Sources List in Appendix A must be returned in a customer’s lists.

Product Management will work with Engineering to determine the best response for all elements.

The file must be updated monthly, after the BIP header build.

The file must be delivered to a location on Dataland that ECL engineering, Linking, and Data Modelling can access.

*/

/*
steps to create business contacts file from crosswalk file:

    Filter crosswalk file for proxid != 0, marketing sources, and the existence of the contactnames child dataset(so it contains contacts).
    Join to business information file so we only have proxids that are contained in the business information file.
    Rollup #2 following the rules for unique contacts(first rolled by lexid if exists, otherwise by fname, lname)
    In rollup, rank and sort the titles using executive_ind so that the highest ranked one is #1 title, then #2, etc. and assign them to the appropriate fields.
    Might be able to set the person hierarchy field to the contact_rank field.
*/



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

