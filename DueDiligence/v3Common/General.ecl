IMPORT Doxie, DueDiligence, STD;


EXPORT General := MODULE


    EXPORT CombineNamePartsForFullName(STRING20 firstName, STRING20 middleName, STRING20 lastName, STRING5 suffix) := FUNCTION

      trimFN := TRIM(firstName);
      trimMN := TRIM(middleName);
      trimLN := TRIM(lastName);
      trimSN := TRIM(suffix);

      RETURN IF(trimFN <> '', trimFN + ' ', '') +
             IF(trimMN <> '', trimMN + ' ', '') +
             IF(trimLN <> '', trimLN + ' ', '') +
             trimSN;

    END;


    //dsToLimit, should already come in sorted and grouped so counter can keep groups sequential
    EXPORT GetMaxNumberOfRecords(dsToLimit, maxRecords) := FUNCTIONMACRO

      RECORDOF(dsToLimit) getMaxRecs(dsToLimit dtl, INTEGER maxCounter) := TRANSFORM, SKIP(maxCounter > maxRecords)
        SELF := dtl;
      END;

      LOCAL maxedRecords := PROJECT(dsToLimit, getMaxRecs(LEFT, COUNTER));

      RETURN UNGROUP(maxedRecords);
    ENDMACRO;


    EXPORT GetAttributeFlagDetails(STRING1 flag9, STRING1 flag8, STRING1 flag7, STRING1 flag6, STRING1 flag5, STRING1 flag4, STRING1 flag3, STRING1 flag2, STRING1 flag1, STRING1 flag0) := FUNCTION

      concatFlags := flag9 + flag8 + flag7 + flag6 + flag5 + flag4 + flag3 + flag2 + flag1;

      calcFlag_0 := IF(STD.Str.Find(concatFlags, DueDiligence.Constants.T_INDICATOR, 1) = 0, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);

      finalFlags := IF(flag0 = DueDiligence.Constants.EMPTY, concatFlags + calcFlag_0, concatFlags + flag0);

      RETURN finalFlags;
    END;

    EXPORT FirstPopulatedString(field) := FUNCTIONMACRO
      IMPORT DueDiligence;

      RETURN IF(TRIM(LEFT.field) = DueDiligence.Constants.EMPTY, RIGHT.field, LEFT.field);
    ENDMACRO;

    EXPORT FirstNonZeroNumber(field) := FUNCTIONMACRO
      //so negative numbers would also be returned (ie -1)
      RETURN IF(LEFT.field = DueDiligence.Constants.NUMERIC_ZERO, RIGHT.field, LEFT.field);
    ENDMACRO;

    EXPORT GetModAccess(DueDiligence.DDInterface.iDDRegulatoryCompliance regulatoryAccess) := FUNCTION
      modAccess := MODULE(Doxie.IDataAccess)
        EXPORT glb := regulatoryAccess.glba;
        EXPORT dppa := regulatoryAccess.dppa;
        EXPORT UNSIGNED1 lexid_source_optout := regulatoryAccess.lexIDSourceOptOut;
        EXPORT STRING transaction_id := regulatoryAccess.transactionID; // esp transaction id or batch uid
        EXPORT UNSIGNED6 global_company_id := regulatoryAccess.globalCompanyID; // mbs gcid
        EXPORT string ssn_mask := regulatoryAccess.ssn_mask;
      END;

      RETURN modAccess;
    END;


END;
