// Create Global SID set using Infile, exported from Orbit.
// Currently there are 4 global_sid sets -
// 1. Public Records Non Professional Data - include PR non prefessional data global_sids
// 2. Public Records Professional Data - include all PR global_sids
// 3. Health Care - include all HC global_sids
// 4. Insurance - include all Insurance global_sids
EXPORT SET OF UNSIGNED4 fExtractGlobalSids(STRING20 domain, STRING1 pdata='') := FUNCTION

    // Select CCPA in scope records - current record, act is set to CCPA and data_base_exemptions contains NONE
    infile_0                    := $.Files.Exemptions.Basefile(Domain_Id=domain AND
                                                               history_flag='' AND      //current record only
                                                               act='CCPA' AND 
                                                               REGEXFIND('NONE',data_based_exemptions));
    // For Public Records, the none Professional Data Global SID set includes global sids whose professional
    // data flag set to N and Professional Data Global SID set includes all PR global sids.
    infile                      := IF(domain=$.Constants.Exemptions().Domain_Id_PR and pdata='N',
                                      infile_0(professional_flag='N'),
                                      infile_0);
    layout_global_sid := RECORD
        UNSIGNED4 global_sid;
    end;

    global_sid_list             := PROJECT(infile,TRANSFORM({LEFT.global_sid},SELF:=LEFT));
    global_sid_list_dedup       := DEDUP(SORT(DISTRIBUTE(global_sid_list),RECORD,LOCAL),RECORD,LOCAL);
    //CCPA-685 temporary exclude these virtual global_sids from global_sid set
    global_sids_Exclusion	    :=  [27751,27761,27771,27781,27791,27801,27811,27821,28281];
    global_sid_set              := SET(global_sid_list_dedup(global_sid not in global_sids_Exclusion),global_sid);

    RETURN global_sid_set;
    
END;