EXPORT Client_TST := MODULE (Monitoring.IClient)
  export string customer_id := 'TST';

  export unsigned1 MAX_INPUT_ADDRESSES := 12;
  export unsigned1 MAX_INPUT_PHONES := 20;

  export unsigned1 MAX_OUTPUT_ADDRESS := 1;
  export unsigned1 MAX_OUTPUT_PHONE := 1;
END;