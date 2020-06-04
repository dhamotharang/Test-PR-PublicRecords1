I'm checking this in to reflect the hacks necessary for DOT to use SALT 3.1.1 -- check the history if using an older SALT

=-=-= BIPV2_DOTID_PLATFORM.MOD_Attr_ForeignCorpkey =-=-=
- Be sure to get all five of these; see a previous hacked version of the code for details.
/* HACK - replace Cands0 */
/* HACK - add ChildRec1 */
/* HACK - comment-out three lines, add childs line */
/* HACK - add Cands1/Cands2 */
/* HACK - replace D1/D2 */


=-=-= BIPV2_DOTID_PLATFORM.Proc_Iterate =-=-=
- Delete references to OSL and SP (Issue #1334)
- Add keysuffix to changes filename, so it will be unique per build and prevent superfile error too.
  IMPORT BIPV2;
  SHARED ChangeName := '~temp::DOTid::BIPV2_DOTID_PLATFORM::changes_it'+iter+'_'+ BIPV2.KeySuffix;


-------------------------------------------------------------------------------------------------------------
Explore using the concepts in BIPV2_ProxID._ApplyProxidHacks to simplify applying HACKS to rebuilt SALT code
-------------------------------------------------------------------------------------------------------------
