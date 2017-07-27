export TimeService := SERVICE
  // unsigned4 Ticks() : library='holertl',holertl,entrypoint='rtlTick'; //non-OSS
  unsigned4 Ticks() : library='eclrtl', eclrtl, entrypoint='rtlTick'; //OSS
END;