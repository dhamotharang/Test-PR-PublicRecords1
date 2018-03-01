import ut, Data_Services;

n := 0; /* n - to test a sample set */

export File_AccLogs_in := choosen(dataset(Data_Services.foreign_logs + 'thor10_11::in::accurint_acclogs_cc', Accurint_AccLogs.Layout_AccLogs_Raw, csv(separator('~~'))),IF(n > 0, n, choosen:ALL));