export date_overlap_last(unsigned8 lf, unsigned8 ll, 
                         unsigned8 rf, unsigned8 rl) :=

  MAP ( yearmap_low(lf) > yearmap_high(rl) => 0,
        yearmap_low(rf) > yearmap_high(ll) => 0,
        yearmap_high(ll) > yearmap_high(rl) => yearmap_high(rl),
        yearmap_high(ll) );