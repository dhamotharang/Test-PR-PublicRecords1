﻿// Create Global SID set using Infile, exported from Orbit.
// Currently there are 4 global_sid sets -
// 1. Public Records Non Professional Data - include PR non prefessional data global_sids
// 2. Public Records Professional Data - include all PR global_sids
// 3. Health Care - include all HC global_sids
// 4. Insurance - include all Insurance global_sids
EXPORT SET OF UNSIGNED4 fExtractGlobalSids(STRING20 domain, STRING1 pdata='') := FUNCTION

    // Select CCPA in scope records 
    infile_0                    := $.Files.Exemptions.Basefile(Domain_Id=domain);
    // For Public Records, the none Professional Data Global SID set includes global sids whose professional
    // data flag set to N and Professional Data Global SID set includes all PR global sids.
    infile                      := IF(domain=$.Constants.Exemptions().Domain_Id_PR and pdata='N',
                                      infile_0(professional_flag='N'),
                                      infile_0);
    infile_in_scope             := infile(act='CCPA' AND 
                                          REGEXFIND('NONE',data_based_exemptions)
                                         );
    layout_global_sid := RECORD
        UNSIGNED4 global_sid;
    end;

    global_sid_list             := PROJECT(infile_in_scope,TRANSFORM({LEFT.global_sid},SELF:=LEFT));
    global_sid_list_dedup       := DEDUP(SORT(DISTRIBUTE(global_sid_list),RECORD,LOCAL),RECORD,LOCAL);
    global_sid_set              := SET(global_sid_list_dedup,global_sid);

    RETURN global_sid_set;
    
END;