EXPORT Functions := MODULE
  EXPORT unsigned4 bit_glb (unsigned1 glb) := IF (glb > 12 OR glb = 0, 0, 1 << (glb - 1)); //glb: first 12 bits
  EXPORT unsigned4 bit_dppa (unsigned1 dppa) := IF (dppa > 12 OR dppa = 0, 0, (1 << 11) << dppa); //dppa: second 12 bits
  EXPORT unsigned4 bit_other (unsigned1 b) := IF (b > 8 OR b = 0, 0, (1 << 23) << b); //remaining 8 bits
END;