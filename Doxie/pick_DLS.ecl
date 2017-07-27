doxie.mac_header_field_declare()
export pick_DLS(unsigned3 dtls, unsigned3 nonglb_dtls) := if(glb_ok, dtls, nonglb_dtls);