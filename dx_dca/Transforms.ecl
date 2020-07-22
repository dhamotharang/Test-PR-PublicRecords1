IMPORT DCA, dx_dca;

EXPORT Transforms := MODULE

  SHARED mac_assign_contact(le, cnt) := MACRO
    SELF.#EXPAND('name_' + cnt) := le.contacts[cnt].name;
    SELF.#EXPAND('title_' + cnt) := le.contacts[cnt].title;
    SELF.#EXPAND('code_' + cnt) := le.contacts[cnt].code;
    SELF.#EXPAND('exec' + cnt + '_score') := le.contacts[cnt].exec_score;
    SELF.#EXPAND('exec' + cnt + '_title') := le.contacts[cnt].exec_title;
    SELF.#EXPAND('exec' + cnt + '_fname') := le.contacts[cnt].exec_fname;
    SELF.#EXPAND('exec' + cnt + '_mname') := le.contacts[cnt].exec_mname;
    SELF.#EXPAND('exec' + cnt + '_lname') := le.contacts[cnt].exec_lname;
    SELF.#EXPAND('exec' + cnt + '_name_suffix') := le.contacts[cnt].exec_name_suffix;
  ENDMACRO;

  SHARED mac_remove_contact(cnt) := MACRO
    SELF.#EXPAND('name_' + cnt) := '';
    SELF.#EXPAND('title_' + cnt) := '';
    SELF.#EXPAND('code_' + cnt) := '';
    SELF.#EXPAND('exec' + cnt + '_score') := '';
    SELF.#EXPAND('exec' + cnt + '_title') := '';
    SELF.#EXPAND('exec' + cnt + '_fname') := '';
    SELF.#EXPAND('exec' + cnt + '_mname') := '';
    SELF.#EXPAND('exec' + cnt + '_lname') := '';
    SELF.#EXPAND('exec' + cnt + '_name_suffix') := '';
  ENDMACRO;

  EXPORT DCA.Layout_DCA_Base_slim flatten_contacts(dx_dca.Layouts.dca_bdid_rollup_layout L) := TRANSFORM
    mac_assign_contact(L, 1);
    mac_assign_contact(L, 2);
    mac_assign_contact(L, 3);
    mac_assign_contact(L, 4);
    mac_assign_contact(L, 5);
    mac_assign_contact(L, 6);
    mac_assign_contact(L, 7);
    mac_assign_contact(L, 8);
    mac_assign_contact(L, 9);
    mac_assign_contact(L, 10);
    SELF := L;
  END;

  EXPORT dx_dca.Layouts.dca_bdid_rollup_layout remove_contacts(DCA.Layout_DCA_Base_slim L) := TRANSFORM
    mac_remove_contact(1);
    mac_remove_contact(2);
    mac_remove_contact(3);
    mac_remove_contact(4);
    mac_remove_contact(5);
    mac_remove_contact(6);
    mac_remove_contact(7);
    mac_remove_contact(8);
    mac_remove_contact(9);
    mac_remove_contact(10);
    SELF := L;
  END;

  EXPORT dx_dca.Layouts.dca_bdid_rollup_layout rollup_contacts(dx_dca.Layouts.dca_bdid_rollup_layout L,
    dx_dca.Layouts.dca_bdid_rollup_layout R) := TRANSFORM
      SELF.contacts := L.contacts + R.contacts;
      SELF := L;
  END;

END;
