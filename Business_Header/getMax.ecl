import business_header;
export getMax(unsigned8 inval, unsigned8 inmax, boolean OL) := if(OL, business_header.utMin2(inval, inmax), 999999);