IMPORT liensv2_services;

EXPORT layout_lien_history_w_bcb :=
RECORD(liensv2_services.layout_lien_history)
  boolean bcbflag;
  unsigned case_link_priority := 0;
END;