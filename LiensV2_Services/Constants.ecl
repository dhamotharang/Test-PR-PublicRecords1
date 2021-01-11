IMPORT AutoKeyI, Doxie, FCRA;
EXPORT Constants := MODULE


  EXPORT LIENS_RETRIEVAL := MODULE

      EXPORT DEFENDANT := 'DEFENDANT';
      EXPORT DEBTOR := 'DEBTOR';
      EXPORT OKC_TASK_DESC := 'Court Runner Task';

      // alert codes and desc
      EXPORT OKC_SUBMISSION_SUCCESS_CODE := '999';
      EXPORT COURTID_BLANK_ERRORCODE := '77';
      EXPORT GATEWAY_FAILURE_CODE := '22';
      EXPORT NO_RECS_FOUND_CODE := (STRING) AutoKeyI.errorcodes._codes.NO_RECORDS;
      EXPORT OKC_SUBMISSION_MESSAGE := 'Request has been submitted';
      //header exceptions
      EXPORT COURTID_BLANK_EXCEPTION := 'Agency cannot be identified based on the information provided. Please verify the agency information and resubmit the request';
      EXPORT NO_RECS_FOUND_EXCEPTION := Doxie.ErrorCodes((INTEGER)No_recs_found_Code);
      EXPORT GATEWAY_EXCEPTION := Doxie.ErrorCodes((INTEGER)gateway_failure_code);
      EXPORT ERRORSOURCE := 'ROXIE';
      //queri failure
      EXPORT Invalid_FilingtypeID_failure := 'The request contained an unsupported Filing Type ID';

      //supported FilingtypeID's
      EXPORT Valid_FilingtypeID := ['BN', 'CD', 'CJ', 'RL', 'CS', 'RM', 'CF', 'FT', 'FR', 'FD', 'RD', 'AJ' ,'AR', 'SC', 'RS', 'ST', 'SR', 'TW', 'WR', 'VJ', 'FE', 'WE', 'SE'];

      EXPORT OKC_TASK_ERRORS := ['41', '42', '43', '44', '45'];
  END;

END;


