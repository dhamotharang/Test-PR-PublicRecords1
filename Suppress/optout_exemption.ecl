/*
(glb - first 12 bits from right to left)
1  - 0x00000001 - Transactions Authorized by Consumer
2  - 0x00000002 - Law Enforcement Purposes
3  - 0x00000004 - Use by Persons Holding a Legal or Beneficial Interest Relating to the Consumer
4  - 0x00000008 – Not used
5  - 0x00000010 - Fraud Prevention or Detection
6  - 0x00000020 - Required Institutional Risk Control
7  - 0x00000040 - Legal Compliance
8  - 0x00000080 - not used
9  - 0x00000100 - not used
10 - 0x00000200 - not used
11 - 0x00000400 - Transactions Authorized by Consumer (Application Verification Only)
12 - 0x00000800 - Use by Persons Acting in a Fiduciary Capacity on Behalf of the Consumer

(dppa - bits 13-20 from right to left)
1  - 0x00001000 - Court, Law Enforcement or Government Agencies
2  - 0x00002000 - Motor Vehicle Safety or Theft
3  - 0x00004000 - Use in the Normal Course of Business
4  - 0x00008000 - Civil, Criminal, Administrative, or Arbitral Proceedings
5  - 0x00010000 - Commercial Driver's License
6  - 0x00020000 - Insurance
7  - 0x00040000 - Licensed Private Investigative or Security Services
8  - 0x00080000 - Reserved/unassigned.

(others - bits 21-31 from right to left)
0  - 0x00000000 - Reserved/unassigned.

(test - bit 32 from right to left)
1  - 0x80000000 - Test bit
*/
EXPORT optout_exemption := MODULE
  EXPORT unsigned4 bit_glb (unsigned1 glb) := IF (glb > 12 OR glb = 0, 0, 1 << (glb - 1)); // glb: first 12 bits
  EXPORT unsigned4 bit_dppa (unsigned1 dppa) := IF (dppa > 8 OR dppa = 0, 0, (1 << 11) << dppa); // dppa: next 8 bits
  EXPORT unsigned4 bit_other (unsigned1 b) := IF (b = 0, 0, (1 << 19) << b); // unassigned: next 11 bits
  EXPORT boolean is_test(unsigned4 exemption) := (exemption & (1 << 31)) > 0;
END;