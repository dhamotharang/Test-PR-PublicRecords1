EXPORT Constants := MODULE

  EXPORT APPID_VIR_TEXT := 'VirtualIdentityReport'; //specific text that ESP is expecting
  EXPORT APPID_WPL_TEXT := 'WorkspaceLocator';

  EXPORT MODE_PERSON := 'PII';
  EXPORT LIMIT_PERSON := 1;

  EXPORT GATEWAYS_EMPTY_MESSAGE := 'Input gateways dataset is empty';

  EXPORT GW_RETRIES := 1;
  EXPORT GW_TIMEOUT := 10;
  

END;
