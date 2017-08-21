IMPORT standard;

// TODO: check if input fiels are distributed
export Proc_SendResults (
  DATASET (Monitoring.layout_address_update) addr_new,
  DATASET (Monitoring.layout_phone_out) phone_new,
  DATASET (Monitoring.Layout_Address_History) addr_hist_new
) := FUNCTION

  addr_hist := addr_hist_new(prim_name[1..3]='DOD') : persist('per_addr_hist_dod');

  // call for every client custom procedure to send results back to batch site
  act_send_nco := Client_NCO.SendMonitorResults (addr_new, phone_new, addr_hist);
  act_send_pra := parallel (Client (Constants.ClientID.PRA).SendAddress (addr_new, addr_hist),
                            Client (Constants.ClientID.PRA).SendPhone   (phone_new, addr_hist));
  act_send_bwh := parallel (Client (Constants.ClientID.BWH).SendAddress (addr_new, addr_hist),
                            Client (Constants.ClientID.BWH).SendPhone   (phone_new, addr_hist));

  act_send_arm := parallel (Monitoring.Clients.ARM.SendAddress (addr_new, addr_hist),
                            Monitoring.Clients.ARM.SendPhone   (phone_new, addr_hist));

  act_send_cbd := parallel (Monitoring.Clients.CBD.SendAddress (addr_new, addr_hist),
                            Monitoring.Clients.CBD.SendPhone   (phone_new, addr_hist));

  act_send_cps := parallel (Monitoring.Clients.CPS.SendAddress (addr_new, addr_hist),
                            Monitoring.Clients.CPS.SendPhone   (phone_new, addr_hist));

  act_send_cps2 := Monitoring.Clients.CPS2.SendPhone (phone_new, addr_hist);

  act_send_don := Monitoring.Clients.DON.SendPhone (phone_new, addr_hist);

  act_send_ffc := parallel (Monitoring.Clients.FFC.SendAddress (addr_new, addr_hist),
                            Monitoring.Clients.FFC.SendPhone   (phone_new, addr_hist));

  act_send_hhl := parallel (Monitoring.Clients.HHL.SendAddress (addr_new, addr_hist),
                            Monitoring.Clients.HHL.SendPhone   (phone_new, addr_hist));

  act_send_naa := Monitoring.Clients.NAA.SendPhone (phone_new, addr_hist);

  act_send_naf := Monitoring.Clients.NAF.SendPhone (phone_new, addr_hist);

  act_send_eps := parallel (Monitoring.Clients.EPS.SendAddress (addr_new, addr_hist),
                            Monitoring.Clients.EPS.SendPhone   (phone_new, addr_hist));

  act_send_pca := parallel (Monitoring.Clients.PCA.SendAddress (addr_new, addr_hist),
                            Monitoring.Clients.PCA.SendPhone   (phone_new, addr_hist));
  act_send_pca_1 := parallel (Monitoring.Clients.PCA1.SendAddress (addr_new, addr_hist),
                              Monitoring.Clients.PCA1.SendPhone   (phone_new, addr_hist));
  act_send_pca_2 := parallel (Monitoring.Clients.PCA2.SendAddress (addr_new, addr_hist),
                              Monitoring.Clients.PCA2.SendPhone   (phone_new, addr_hist));
  act_send_pca_3 := parallel (Monitoring.Clients.PCA3.SendAddress (addr_new, addr_hist),
                              Monitoring.Clients.PCA3.SendPhone   (phone_new, addr_hist));

  act_send_rnb := parallel (Monitoring.Clients.RNB.SendAddress (addr_new, addr_hist),
                            Monitoring.Clients.RNB.SendPhone   (phone_new, addr_hist));
  act_send_sac := Monitoring.Clients.SAC.SendPhone (phone_new, addr_hist);

  act_send_scc := parallel (Monitoring.Clients.SCC.SendAddress (addr_new, addr_hist),
                            Monitoring.Clients.SCC.SendPhone   (phone_new, addr_hist));

  act_send_spd := Monitoring.Clients.SPD.SendAddress (addr_new, addr_hist);


  act_send_tgi := parallel (Monitoring.Clients.TGI.SendAddress (addr_new, addr_hist),
                            Monitoring.Clients.TGI.SendPhone   (phone_new, addr_hist));

  act_send_wam := parallel (Monitoring.Clients.WAM.SendAddress (addr_new, addr_hist),
                            Monitoring.Clients.WAM.SendPhone   (phone_new, addr_hist));
  act_send_wam2 := parallel (Monitoring.Clients.WAM2.SendAddress (addr_new, addr_hist),
                             Monitoring.Clients.WAM2.SendPhone   (phone_new, addr_hist));
  act_send_wam3 := parallel (Monitoring.Clients.WAM3.SendAddress (addr_new, addr_hist),
                             Monitoring.Clients.WAM3.SendPhone   (phone_new, addr_hist));

  act_send_wlf := parallel (Monitoring.Clients.WLF.SendAddress (addr_new, addr_hist),
                            Monitoring.Clients.WLF.SendPhone   (phone_new, addr_hist));
  // act_send_wpf := parallel (Monitoring.Clients.WPF.SendAddress (addr_new, addr_hist),
                            // Monitoring.Clients.WPF.SendPhone   (phone_new, addr_hist));

  return 0;
// parallel (// act_send_nco,
                   // act_send_pra//, 
                   // act_send_bwh, 
                   // act_send_arm,
                   // act_send_cbd, 
                   // act_send_cps, act_send_cps2, 
                   //act_send_don,
                   // act_send_eps, 
                   // act_send_hhl, 
                   //act_send_naa,
                   // act_send_naf, 
                   // act_send_pca, act_send_pca_1, act_send_pca_2, act_send_pca_3, 
                   // act_send_rnb,
                   // act_send_sac, 
                   // act_send_scc, 
                   //act_send_spd, 
                   // act_send_tgi,
                   // act_send_wam, act_send_wam2, act_send_wam3
                   // );
                   // act_send_wlf);
END;
