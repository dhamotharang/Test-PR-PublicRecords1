IMPORT AutoKeyI, Doxie, FCRA;
EXPORT Constants := MODULE


  EXPORT LIENS_RETRIEVAL := MODULE

      EXPORT DEFENDANT     := 'DEFENDANT';
      EXPORT DEBTOR        := 'DEBTOR';
      EXPORT OKC_TASK_DESC := 'Court Runner Task';

      // alert codes and desc
      EXPORT OKC_SUBMISSION_SUCCESS_CODE  := '999';
      EXPORT COURTID_BLANK_ERRORCODE      := '77';
      EXPORT GATEWAY_FAILURE_CODE         := '22';
      EXPORT NO_RECS_FOUND_CODE           := AutoKeyI.errorcodes._codes.NO_RECORDS;
      EXPORT OKC_SUBMISSION_MESSAGE  := 'Request has been submitted';
      EXPORT COURTID_BLANK_EXCEPTION := 'Agency cannot be identified based on the information provided.  Please verify the agency information and resubmit the request';
      EXPORT NO_RECS_FOUND_EXCEPTION := Doxie.ErrorCodes(No_recs_found_Code);
      EXPORT GATEWAY_EXCEPTION       := Doxie.ErrorCodes((integer)gateway_failure_code);
      EXPORT ERRORSOURCE	:= 'ROXIE';
  END;

END;


