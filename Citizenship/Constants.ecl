﻿EXPORT Constants := MODULE

  EXPORT FLAGSHIP_MODELS := ['CIT1808_0_0'];

  EXPORT VALID_MODEL_NAMES := [FLAGSHIP_MODELS];
  
  
  //Validation error messages
  EXPORT VALIDATION_INVALID_MODEL_NAME := 'Model is currently not supported.';
  EXPORT VALIDATION_INVALID_INDIVIDUAL := 'Minimum input information not met. Minimum input information is: \n (1)  First Name, Last Name, Street Address, City and State or Zip  OR \n (2)  First Name, Last Name, SSN';


END;