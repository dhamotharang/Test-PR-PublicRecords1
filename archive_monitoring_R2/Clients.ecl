// Encapsulates trivial customers: the ones who doesn't have special processing, sending results, etc.

// IMPORTANT: this is example of setting the record level monitoring features:
/*
    export GetMonitorSettings (string20 request_type, unsigned2 score) := FUNCTION 
      string str_request := stringlib.StringToupperCase (trim (request_type));
      sub_phone := phn.PHONE_TA + phn.PHONE_TB + phn.PHONE_TG;
      ds_addr  := dataset ([{subj.ADDRESS,  0,         freq.NONE, 0, freq.DAY, 1, MAX_OUTPUT_ADDRESS, false, ''}], layouts.m_settings);
      ds_phone := dataset ([{subj.PHONE,    sub_phone, freq.NONE, 0, freq.DAY, 1, MAX_OUTPUT_PHONE,   false, ''}], layouts.m_settings);
      ds_prop  := dataset ([{subj.PROPERTY, 0,         freq.NONE, 0, freq.DAY, 1, MAX_OUTPUT_PROP,    false, ''}], layouts.m_settings);
      ds_paw   := dataset ([{subj.PAW,      0,         freq.NONE, 0, freq.DAY, 1, MAX_OUTPUT_PAW,     false, ''}], layouts.m_settings);

      res := dataset ([], layouts.m_settings) +
        if (StringLib.StringFind (str_request, 'A', 1) > 0, ds_addr) +
        if (StringLib.StringFind (str_request, 'P', 1) > 0, ds_phone) +
        if (StringLib.StringFind (str_request, 'R', 1) > 0, ds_prop) +
        if (StringLib.StringFind (str_request, 'W', 1) > 0, ds_paw);
      return res;
    end;
*/

EXPORT Clients := MODULE

shared subj := Constants.T_SUBJECT;
shared phn  := Constants.T_PHONES;
shared freq := Constants.T_FREQUENCY;

  export ARM := MODULE (Monitoring.IClient) //Accounts Receivable Management Inc, id=19947
    export string customer_id := 'ARM';

    export unsigned1 MAX_INPUT_ADDRESSES := 1;
    export unsigned1 MAX_INPUT_PHONES := 5;
    export unsigned1 MAX_OUTPUT_ADDRESS := 1;
    export unsigned1 MAX_OUTPUT_PHONE := 3;

    export GetMonitorSettings (string20 request_type, unsigned2 score) := FUNCTION
      sub_phone := phn.PHONE_TA + phn.PHONE_TB + phn.PHONE_TC;
      res := dataset ([
        {subj.ADDRESS,  0,         Constants.T_FREQUENCY.NONE, 0, Constants.T_FREQUENCY.DAY, 1, MAX_OUTPUT_ADDRESS,  false, ''},
        {subj.PHONE,    sub_phone, Constants.T_FREQUENCY.NONE, 0, Constants.T_FREQUENCY.DAY, 1, MAX_OUTPUT_PHONE,    false, ''}
      ], layouts.m_settings);
      return res;
    end; 
  end;

  export CBD := MODULE (Monitoring.IClient)
    export string customer_id := 'CBD';

    export unsigned1 MAX_INPUT_ADDRESSES := 12;
    export unsigned1 MAX_INPUT_PHONES := 20;
    export unsigned1 MAX_OUTPUT_ADDRESS := 1;
    export unsigned1 MAX_OUTPUT_PHONE := 1;

    export GetMonitorSettings (string20 request_type, unsigned2 score) := FUNCTION
      sub_phone := phn.PHONE_TA + phn.PHONE_TB;
      res := dataset ([
        {subj.ADDRESS,  0,         Constants.T_FREQUENCY.NONE, 0, Constants.T_FREQUENCY.DAY, 1, MAX_OUTPUT_ADDRESS,  false, ''},
        {subj.PHONE,    sub_phone, Constants.T_FREQUENCY.NONE, 0, Constants.T_FREQUENCY.DAY, 1, MAX_OUTPUT_PHONE,    false, ''}
      ], layouts.m_settings);
      return res;
    end; 
  end;


  export CPS := MODULE (Monitoring.IClient)
    export string customer_id := 'CPS';

    export unsigned1 MAX_INPUT_ADDRESSES := 12;
    export unsigned1 MAX_INPUT_PHONES := 20;

    export unsigned1 MAX_OUTPUT_ADDRESS := 1;
    export unsigned1 MAX_OUTPUT_PHONE := 1;

    export GetMonitorSettings (string20 request_type, unsigned2 score) := FUNCTION
      sub_phone := phn.PHONE_TA + phn.PHONE_TB;
      res := dataset ([
        {subj.ADDRESS,  0,         Constants.T_FREQUENCY.NONE, 0, Constants.T_FREQUENCY.DAY, 1, MAX_OUTPUT_ADDRESS,  false, ''},
        {subj.PHONE,    sub_phone, Constants.T_FREQUENCY.NONE, 0, Constants.T_FREQUENCY.DAY, 1, MAX_OUTPUT_PHONE,    false, ''}
      ], layouts.m_settings);
      return res;
    end; 
  end;


  export CPS2 := MODULE (Monitoring.IClient)
    export string customer_id := 'CPS2';

    export unsigned1 MAX_INPUT_ADDRESSES := 12;
    export unsigned1 MAX_INPUT_PHONES := 20;

    export unsigned1 MAX_OUTPUT_ADDRESS := 1;
    export unsigned1 MAX_OUTPUT_PHONE := 1;

    export GetMonitorSettings (string20 request_type, unsigned2 score) := FUNCTION
      sub_phone := phn.PHONE_TA + phn.PHONE_TB;
      res := dataset ([
        {subj.PHONE, sub_phone, Constants.T_FREQUENCY.NONE, 0, Constants.T_FREQUENCY.DAY, 1, MAX_OUTPUT_PHONE, false, ''}
      ], layouts.m_settings);
      return res;
    end; 
  end;


  EXPORT DON := MODULE (Monitoring.IClient)
    export string customer_id := 'DON';

    export unsigned1 MAX_INPUT_PHONES := 10;
    export unsigned1 MAX_OUTPUT_PHONE := 10;

    export GetMonitorSettings (string20 request_type, unsigned2 score) := FUNCTION 
      sub_phone := phn.PHONE_TA + phn.PHONE_TB + phn.PHONE_TG;

      res := dataset ([
        {subj.PHONE,    sub_phone, Constants.T_FREQUENCY.NONE, 0, Constants.T_FREQUENCY.DAY, 1, MAX_OUTPUT_PHONE,   false, ''}
      ], layouts.m_settings);
      return res;
    end;
  END;


  export EPS := MODULE (Monitoring.IClient)
    export string customer_id := 'EPS';

    export unsigned1 MAX_INPUT_ADDRESSES := 1;
    export unsigned1 MAX_INPUT_PHONES := 1;
    export unsigned1 MAX_OUTPUT_ADDRESS := 1;
    export unsigned1 MAX_OUTPUT_PHONE := 1;

    export GetMonitorSettings (string20 request_type, unsigned2 score) := FUNCTION
      sub_phone := phn.PHONE_TA + phn.PHONE_TB + phn.PHONE_TC + phn.PHONE_TG;
      res := dataset ([
        {subj.ADDRESS,  0,         Constants.T_FREQUENCY.NONE, 0, Constants.T_FREQUENCY.DAY, 1, MAX_OUTPUT_ADDRESS,  false, ''},
        {subj.PHONE,    sub_phone, Constants.T_FREQUENCY.NONE, 0, Constants.T_FREQUENCY.DAY, 1, MAX_OUTPUT_PHONE,    false, ''}
      ], layouts.m_settings);
      return res;
    end; 
  end;

  export FFC := MODULE (Monitoring.IClient)
    export string customer_id := 'FFC';

    export unsigned1 MAX_INPUT_ADDRESSES := 12;
    export unsigned1 MAX_INPUT_PHONES := 20;
    export unsigned1 MAX_OUTPUT_ADDRESS := 1;
    export unsigned1 MAX_OUTPUT_PHONE := 1;
  end;


  EXPORT HHL := MODULE (Monitoring.IClient)
    export string customer_id := 'HHL';

    export unsigned1 MAX_INPUT_ADDRESSES := 1;
    export unsigned1 MAX_INPUT_PHONES := 10;

    export unsigned1 MAX_OUTPUT_ADDRESS := 1;
    export unsigned1 MAX_OUTPUT_PHONE := 1;

    export GetMonitorSettings (string20 request_type, unsigned2 score) := FUNCTION
      string str_request := stringlib.StringToupperCase (trim (request_type));
      sub_phone := phn.PHONE_TA + phn.PHONE_TB + phn.PHONE_TG;

      ds_addr  := dataset ([{subj.ADDRESS,  0,         Constants.T_FREQUENCY.NONE, 0, Constants.T_FREQUENCY.DAY, 1, MAX_OUTPUT_ADDRESS, false, ''}], layouts.m_settings);
      ds_phone := dataset ([{subj.PHONE,    sub_phone, Constants.T_FREQUENCY.NONE, 0, Constants.T_FREQUENCY.DAY, 1, MAX_OUTPUT_PHONE,   false, ''}], layouts.m_settings);

      res := dataset ([], layouts.m_settings) +
        if (StringLib.StringFind (str_request, 'A', 1) > 0, ds_addr) +
        if (StringLib.StringFind (str_request, 'P', 1) > 0, ds_phone);
      return res;
    end; 
  END;


  EXPORT NAA := MODULE (Monitoring.IClient)
    export string customer_id := 'NAA';

    export unsigned1 MAX_INPUT_ADDRESSES := 1;
    export unsigned1 MAX_INPUT_PHONES := 15;

    export unsigned1 MAX_OUTPUT_ADDRESS := 0;
    export unsigned1 MAX_OUTPUT_PHONE := 1;

    EXPORT GetMonitorSettings (string20 request_type, unsigned2 score) := FUNCTION
      sub_phone := phn.PHONE_TA + phn.PHONE_TB + phn.PHONE_TG;
      res := dataset ([
        {subj.PHONE, sub_phone, Constants.T_FREQUENCY.NONE, 0, Constants.T_FREQUENCY.DAY, 1, MAX_OUTPUT_PHONE, false, ''}
      ], layouts.m_settings);
      return res;
    END; 
  END;


  EXPORT NAF := MODULE (Monitoring.IClient)
    export string customer_id := 'NAF';

    export unsigned1 MAX_INPUT_ADDRESSES := 0; //this will be treated as "1" in _UpdateBase
    export unsigned1 MAX_INPUT_PHONES := 20;

    export unsigned1 MAX_OUTPUT_ADDRESS := 0;
    export unsigned1 MAX_OUTPUT_PHONE := 1;

    EXPORT GetMonitorSettings (string20 request_type, unsigned2 score) := FUNCTION
      sub_phone := phn.PHONE_TA + phn.PHONE_TB + phn.PHONE_TG;
      res := dataset ([
        {subj.PHONE, sub_phone, Constants.T_FREQUENCY.NONE, 0, Constants.T_FREQUENCY.DAY, 1, MAX_OUTPUT_PHONE, false, ''}
      ], layouts.m_settings);
      return res;
    END; 
  END;


  // PCAx clients are almost exactly same, hence the interface
  shared I_PCA := INTERFACE (Monitoring.IClient)
    export unsigned1 MAX_INPUT_ADDRESSES := 1;
    export unsigned1 MAX_INPUT_PHONES := 3;

    export unsigned1 MAX_OUTPUT_ADDRESS := 1;
    export unsigned1 MAX_OUTPUT_PHONE := 1;
    export unsigned1 MAX_OUTPUT_PROP := 1;
    export unsigned1 MAX_OUTPUT_PAW := 1;

    export GetMonitorSettings (string20 request_type, unsigned2 score) := FUNCTION
      sub_phone := phn.PHONE_TA + phn.PHONE_TB + phn.PHONE_TG;
      res := dataset ([
        {subj.ADDRESS,  0,         Constants.T_FREQUENCY.NONE, 0, Constants.T_FREQUENCY.DAY, 1, MAX_OUTPUT_ADDRESS, false, ''},
        {subj.PHONE,    sub_phone, Constants.T_FREQUENCY.NONE, 0, Constants.T_FREQUENCY.DAY, 1, MAX_OUTPUT_PHONE,   false, ''}
      ], layouts.m_settings);
      return res;
    end; 
  end;

  export PCA := MODULE (I_PCA)
    export string customer_id := 'PCA';
  end;

  export PCA1 := MODULE (I_PCA)
    export string customer_id := 'PCA1';
  end;

  export PCA2 := MODULE (I_PCA)
    export string customer_id := 'PCA2';
  end;

  export PCA3 := MODULE (I_PCA)
    export string customer_id := 'PCA3';
  end;


  export RMI := MODULE (Monitoring.IClient)
    export string customer_id := 'RMI';

    export unsigned1 MAX_INPUT_ADDRESSES := 12;
    export unsigned1 MAX_INPUT_PHONES := 20;

    export unsigned1 MAX_OUTPUT_ADDRESS := 1;
    export unsigned1 MAX_OUTPUT_PHONE := 1;
  end;


  EXPORT RNB := MODULE (Monitoring.IClient)
    export string customer_id := 'RNB';
    export boolean SetRequestTypeError := true;

    export unsigned1 MAX_INPUT_ADDRESSES := 1;
    export unsigned1 MAX_INPUT_PHONES := 1;

    export unsigned1 MAX_OUTPUT_ADDRESS := 1;
    export unsigned1 MAX_OUTPUT_PHONE := 1;

    export GetMonitorSettings (string20 request_type, unsigned2 score) := FUNCTION 
      string str_request := stringlib.StringToupperCase (trim (request_type));
      sub_phone := phn.PHONE_TA + phn.PHONE_TB + phn.PHONE_TG;
      ds_addr  := dataset ([{subj.ADDRESS,  0,         freq.NONE, 0, freq.DAY, 1, MAX_OUTPUT_ADDRESS, false, ''}], layouts.m_settings);
      ds_phone := dataset ([{subj.PHONE,    sub_phone, freq.NONE, 0, freq.DAY, 1, MAX_OUTPUT_PHONE,   false, ''}], layouts.m_settings);

      res := dataset ([], layouts.m_settings) +
        if (StringLib.StringFind (str_request, 'A', 1) > 0, ds_addr) +
        if (StringLib.StringFind (str_request, 'P', 1) > 0, ds_phone);
      return res;
    end;
  END;


  EXPORT SAC := MODULE (Monitoring.IClient)
    export string customer_id := 'SAC';

    export unsigned1 MAX_INPUT_ADDRESSES := 12;
    export unsigned1 MAX_INPUT_PHONES := 20;

    export unsigned1 MAX_OUTPUT_ADDRESS := 0;
    export unsigned1 MAX_OUTPUT_PHONE := 1;

    EXPORT GetMonitorSettings (string20 request_type, unsigned2 score) := FUNCTION
      sub_phone := phn.PHONE_TA + phn.PHONE_TB;
      res := dataset ([
        {subj.PHONE, sub_phone, Constants.T_FREQUENCY.NONE, 0, Constants.T_FREQUENCY.DAY, 1, MAX_OUTPUT_PHONE, false, ''}
      ], layouts.m_settings);
      return res;
    END; 
  END;


  export SCC := MODULE (Monitoring.IClient) //Settlement Capital Corporation, id=8950
    export string customer_id := 'SCC';

    export unsigned1 MAX_INPUT_ADDRESSES := 1;
    export unsigned1 MAX_INPUT_PHONES := 1;
    export unsigned1 MAX_OUTPUT_ADDRESS := 1;
    export unsigned1 MAX_OUTPUT_PHONE := 3;

    export GetMonitorSettings (string20 request_type, unsigned2 score) := FUNCTION
      sub_phone := phn.PHONE_TA + phn.PHONE_TB + phn.PHONE_TC;
      res := dataset ([
        {subj.ADDRESS,  0,         Constants.T_FREQUENCY.NONE, 0, Constants.T_FREQUENCY.DAY, 1, MAX_OUTPUT_ADDRESS,  false, ''},
        {subj.PHONE,    sub_phone, Constants.T_FREQUENCY.NONE, 0, Constants.T_FREQUENCY.DAY, 1, MAX_OUTPUT_PHONE,    false, ''}
      ], layouts.m_settings);
      return res;
    end; 
  end;


  EXPORT SPD := MODULE (Monitoring.IClient) // disabled on MArch, 04 2011
    export string customer_id := 'SPD';

    export unsigned1 MAX_INPUT_ADDRESSES := 1;
    export unsigned1 MAX_INPUT_PHONES := 0;
    export unsigned1 MAX_OUTPUT_ADDRESS := 1;

    export GetMonitorSettings (string20 request_type, unsigned2 score) := FUNCTION
      res := dataset ([
        {subj.ADDRESS,  0, Constants.T_FREQUENCY.NONE, 0, Constants.T_FREQUENCY.DAY, 1, MAX_OUTPUT_ADDRESS,  false, ''}
      ], layouts.m_settings);
      return res;
    end; 
  END;  


  EXPORT TGI := MODULE (Monitoring.IClient)
    export string customer_id := 'TGI';

    export unsigned1 MAX_INPUT_ADDRESSES := 1;
    export unsigned1 MAX_INPUT_PHONES := 1;

    export unsigned1 MAX_OUTPUT_ADDRESS := 2;
    export unsigned1 MAX_OUTPUT_PHONE := 2;

    export GetMonitorSettings (string20 request_type, unsigned2 score) := FUNCTION 
      sub_phone := phn.PHONE_TA + phn.PHONE_TB + phn.PHONE_TC;

      res := dataset ([
        {subj.ADDRESS,  0,         Constants.T_FREQUENCY.NONE, 0, Constants.T_FREQUENCY.DAY, 1, MAX_OUTPUT_ADDRESS, false, ''},
        {subj.PHONE,    sub_phone, Constants.T_FREQUENCY.NONE, 0, Constants.T_FREQUENCY.DAY, 1, MAX_OUTPUT_PHONE,   false, ''}
      ], layouts.m_settings);
      return res;
    end;
  END;


  // Same interface for WAMx clients as well:
  shared I_WAM := INTERFACE (Monitoring.IClient)
    export unsigned1 MAX_INPUT_ADDRESSES := 12;
    export unsigned1 MAX_INPUT_PHONES := 20;

    export unsigned1 MAX_OUTPUT_ADDRESS := 1;
    export unsigned1 MAX_OUTPUT_PHONE := 1;
    export unsigned1 MAX_OUTPUT_PAW := 1;

    export GetMonitorSettings (string20 request_type, unsigned2 score) := FUNCTION
      sub_phone := phn.PHONE_TA + phn.PHONE_TB + phn.PHONE_TC + phn.PHONE_TG;
      res := dataset ([
        {subj.ADDRESS,  0,         Constants.T_FREQUENCY.NONE, 0, Constants.T_FREQUENCY.DAY, 1, MAX_OUTPUT_ADDRESS,  false, ''},
        {subj.PHONE,    sub_phone, Constants.T_FREQUENCY.NONE, 0, Constants.T_FREQUENCY.DAY, 1, MAX_OUTPUT_PHONE,    false, ''}
      ], layouts.m_settings);
      return res;
    end; 
  end;

  export WAM := MODULE (I_WAM)
    export string customer_id := 'WAM'; 
  end;

  export WAM2 := MODULE (I_WAM)
    export string customer_id := 'WAM2';
  end;

  export WAM3 := MODULE (I_WAM)
    export string customer_id := 'WAM3';
  end;


  EXPORT WLF := MODULE (Monitoring.IClient)
    export string customer_id := 'WLF';

    export unsigned1 MAX_INPUT_ADDRESSES := 1;
    export unsigned1 MAX_INPUT_PHONES := 1;

    export unsigned1 MAX_OUTPUT_ADDRESS := 6;
    export unsigned1 MAX_OUTPUT_PHONE := 10;

    export GetMonitorSettings (string20 request_type, unsigned2 score) := FUNCTION
      sub_phone := phn.PHONE_TA + phn.PHONE_TB + phn.PHONE_TC;
      res := dataset ([
        {subj.ADDRESS,  0,         Constants.T_FREQUENCY.NONE, 0, Constants.T_FREQUENCY.DAY, 1, MAX_OUTPUT_ADDRESS, false, ''},
        {subj.PHONE,    sub_phone, Constants.T_FREQUENCY.NONE, 0, Constants.T_FREQUENCY.DAY, 1, MAX_OUTPUT_PHONE,   false, ''}
      ], layouts.m_settings);
      return res;
    end; 
  END;
END;