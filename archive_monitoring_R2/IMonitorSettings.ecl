// Represents Monitor settigns common for any client

EXPORT IMonitorSettings := INTERFACE
  export unsigned subject; // for example, phone, address
  export string1   frequency_type;
  export unsigned2 frequency_time;
  export string1   delay_type := Constants.T_FREQUENCY.NONE;
  export unsigned2 delay_time := 0;
END;
