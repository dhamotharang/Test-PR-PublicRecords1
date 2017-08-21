records := MODULE

  // failes if maxlength=30, succeeds if maxlength=32
  export unique_id := RECORD, MAXLENGTH (30)
    string UniqueID_1;
    string UniqueID_2;
    string UniqueID_3;
  end;

  export batch_in_customer := RECORD // about 1800 max
    string1 request_code;
    unique_id rec;
    string20 name_first;
    string20 name_last;
    string60 line_1;
    string25 city;
    string2  state;
    string10 zip;
    string10 phone;
  end;
END;

ip := 'batchdev01.br.seisint.com';
fname_source := '/batchshare/THORMonitoring/incoming/fail_rec.csv';
fname_thor := '~production_watch_thor::monitoring::in::fail_rec';

// spray, if not done yet
act_sprayFile := FileServices.SprayVariable (
  ip, fname_source, 16384, '|',,'\'', 'production_watch_thor', fname_thor,,,, true,,); //allow overwrite

// read the file just sprayed
ds_request := DATASET (fname_thor, records.batch_in_customer, CSV (separator('|'), QUOTE(''), maxlength (16384)));

// sequential (act_sprayFile, output (ds_request, ALL));
output (ds_request, ALL);

/*
// content of fail_rec.csv
A|4800114021920452|||Fernando|Muhaded|23679 CALABASAS RD|Calabasas|CA|91302|
A|480430000000|||Minyon|Young|1304 S FULTON WAY APT C206|Denver|CO|80247|303/726-0479
A|48043000000001852019|||Danielle|Burdeaux|3961 S HELENA|Aurora|CO|80013|
*/
