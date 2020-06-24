import ut;
  export Mac_address_Filter (pInputfile
                ,paddress_prim_name
                ,paddress_prim_range
                ,paddress_predir
                ,paddress_postdir
                ,paddress_suffix
                ,paddress_sec_range
                ,paddress_city
                ,paddress_state
                ,paddress_zip
                ,m_AddrInfo
                ,pOutFile // output file name
                ) :=
  macro

    pOutFile := pInputfile(paddress_prim_name = m_AddrInfo[1].prim_name AND
                            paddress_prim_range = m_AddrInfo[1].prim_range AND
                            paddress_zip = m_AddrInfo[1].zip);
  endmacro;
