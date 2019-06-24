/*
(glb - first 12 bits from right to left)
1  - 0000 0000 0001 - 0x001 - Transactions Authorized by Consumer
2  - 0000 0000 0010 - 0x002 - Law Enforcement Purposes
3  - 0000 0000 0100 - 0x004 - Use by Persons Holding a Legal or Beneficial Interest Relating to the Consumer
4  - 0000 0000 1000 - 0x008 – Not used
5  - 0000 0001 0000 - 0x010 - Fraud Prevention or Detection
6  - 0000 0010 0000 - 0x020 - Required Institutional Risk Control
7  - 0000 0100 0000 - 0x040 - Legal Compliance
8  - 0000 1000 0000 - 0x080 - not used
9  - 0001 0000 0000 - 0x100 - not used
10 - 0010 0000 0000 - 0x200 - not used
11 - 0100 0000 0000 - 0x400 - Transactions Authorized by Consumer (Application Verification Only)
12 - 1000 0000 0000 - 0x800 - Use by Persons Acting in a Fiduciary Capacity on Behalf of the Consumer

(dppa – bits 13-20 from right to left)
1  - 0000 0000 0001 0000 0000 0000 - 0x001000 - Court, Law Enforcement or Government Agencies
2  - 0000 0000 0010 0000 0000 0000 - 0x002000 - Motor Vehicle Safety or Theft
3  - 0000 0000 0100 0000 0000 0000 - 0x004000 - Use in the Normal Course of Business
4  - 0000 0000 1000 0000 0000 0000 - 0x008000 - Civil, Criminal, Administrative, or Arbitral Proceedings
5  - 0000 0001 0000 0000 0000 0000 - 0x010000 - Commercial Driver's License
6  - 0000 0010 0000 0000 0000 0000 - 0x020000 - Insurance
7  - 0000 0100 0000 0000 0000 0000 - 0x040000 - Licensed Private Investigative or Security Services

(others - bits 21-32 from right to left)

*/
EXPORT optout_exemption := MODULE
  EXPORT unsigned4 bit_glb (unsigned1 glb) := IF (glb > 12 OR glb = 0, 0, 1 << (glb - 1)); //glb: first 12 bits
  EXPORT unsigned4 bit_dppa (unsigned1 dppa) := IF (dppa > 8 OR dppa = 0, 0, (1 << 11) << dppa); //dppa: next 8 bits
  EXPORT unsigned4 bit_other (unsigned1 b) := IF (b = 0, 0, (1 << 19) << b); //remaining 12 bits
END;