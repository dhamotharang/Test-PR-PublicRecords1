EXPORT layouts := MODULE

  EXPORT soap_common := RECORD
    INTEGER soap_seq;
    INTEGER soap_status := 0;
    STRING  soap_message := '';
    UNSIGNED hash_val := 0;
  END;

  EXPORT testcase := RECORD
    INTEGER tid := 0;
    STRING suite := '';
    STRING query;
    STRING short_description;
    UTF8 request_xml;
    STRING created_by := '';
    STRING wuid := '';
  END;

  EXPORT testcase_result := RECORD
    testcase.tid;
    testcase.suite;
    INTEGER1 result;
    testcase.query;
    testcase.request_xml;
    soap_common;
  END;

  EXPORT summary_count := RECORD
    STRING s;
    STRING c;
  END;

  EXPORT external := RECORD
    STRING glbpurpose;
    STRING dppapurpose;
    STRING datapermissionmask;
    STRING datarestrictionmask;
    STRING industryclass;
    STRING dlmask;
    STRING ssnmask;
    STRING dobmask;

  END;

END;
