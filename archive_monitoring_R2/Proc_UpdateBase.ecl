
EXPORT Proc_UpdateBase (string vendorName, string fileName, boolean do_spray = true) := FUNCTION
  #workunit('name', vendorName + ' Monitor Update');

  act := MAP (
              // those are specific clients with particular processing rules
              // vendorName = 'BWH' => Monitoring.Proc_BWH_UpdateBase (vendorName, fileName, do_spray),
              // vendorName = 'NCO' => Monitoring.Proc_NCO_UpdateBase (vendorName, fileName, do_spray),
              // vendorName = 'PRA' => Monitoring.Proc_PRA_UpdateBase (vendorName, fileName, do_spray),

              // clients compliant with standard input/output
              // vendorName = 'ARM' => Monitoring._UpdateBase (fileName, do_spray, Monitoring.Clients.ARM),
              // vendorName = 'CBD' => Monitoring._UpdateBase (fileName, do_spray, Monitoring.Clients.CBD),
              // vendorName = 'CPS' => Monitoring._UpdateBase (fileName, do_spray, Monitoring.Clients.CPS),
              // vendorName = 'CPS2'=> Monitoring._UpdateBase (fileName, do_spray, Monitoring.Clients.CPS2),
              //vendorName = 'DON'=> Monitoring._UpdateBase (fileName, do_spray, Monitoring.Clients.DON),
              // vendorName = 'EPS' => Monitoring._UpdateBase (fileName, do_spray, Monitoring.Clients.EPS),
              vendorName = 'FFC' => Monitoring._UpdateBase (fileName, do_spray, Monitoring.Clients.FFC),
              // vendorName = 'HHL' => Monitoring._UpdateBase (fileName, do_spray, Monitoring.Clients.HHL),
              // vendorName = 'NAA' => Monitoring._UpdateBase (fileName, do_spray, Monitoring.Clients.NAA),
              // vendorName = 'NAF' => Monitoring._UpdateBase (fileName, do_spray, Monitoring.Clients.NAF),
              // vendorName = 'PCA'  => Monitoring._UpdateBase (fileName, do_spray, Monitoring.Clients.PCA),
              // vendorName = 'PCA1' => Monitoring._UpdateBase (fileName, do_spray, Monitoring.Clients.PCA1),
              // vendorName = 'PCA2' => Monitoring._UpdateBase (fileName, do_spray, Monitoring.Clients.PCA2),
              // vendorName = 'PCA3' => Monitoring._UpdateBase (fileName, do_spray, Monitoring.Clients.PCA3),
              // vendorName = 'RMI' => Monitoring._UpdateBase (fileName, do_spray, Monitoring.Clients.RMI),
              // vendorName = 'RNB' => Monitoring._UpdateBase (fileName, do_spray, Monitoring.Clients.RNB),
              // vendorName = 'SAC' => Monitoring._UpdateBase (fileName, do_spray, Monitoring.Clients.SAC),
              // vendorName = 'SCC' => Monitoring._UpdateBase (fileName, do_spray, Monitoring.Clients.SCC),
              // vendorName = 'SPD' => Monitoring._UpdateBase (fileName, do_spray, Monitoring.Clients.SPD),
              // vendorName = 'TGI' => Monitoring._UpdateBase (fileName, do_spray, Monitoring.Clients.TGI),
              // vendorName = 'WAM'  => Monitoring._UpdateBase (fileName, do_spray, Monitoring.Clients.WAM),
              // vendorName = 'WAM2' => Monitoring._UpdateBase (fileName, do_spray, Monitoring.Clients.WAM2),
              // vendorName = 'WAM3' => Monitoring._UpdateBase (fileName, do_spray, Monitoring.Clients.WAM3),
              // vendorName = 'WLF' => Monitoring._UpdateBase (fileName, do_spray, Monitoring.Clients.WLF),
              // vendorName = 'WPF' => Monitoring._UpdateBase (fileName, do_spray, Monitoring.Clients.WPF),
               
              // test client: 
              vendorName = 'TST' => Monitoring._UpdateBase (fileName, do_spray, Monitoring.Client_TST),
              output ('unknown customer: ' + vendorName));
              //unknown (unimplemented) client
              // Monitoring._UpdateBase (fileName, false, cli));
  return act;
END;

