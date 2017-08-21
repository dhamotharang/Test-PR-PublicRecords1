
export fn_remove_etal_WV(string name) := function 

v_xname0:=StringLib.StringToUpperCase(name);
v_xname1:=regexreplace(' (ATTY) ', v_xname0,' ');
v_xname2:=regexreplace(' ARCHBIXHOP ', v_xname1,' ');
v_xname3:=regexreplace(' (BY CLK) ', v_xname2,' ');
v_xname4:=regexreplace(' (BY DIR) ', v_xname3,' ');
v_xname5:=regexreplace(' (BY LQDR) ', v_xname4,' ');
v_xname6:=regexreplace(' (TEMPACO) ', v_xname5,' ');
v_xname7:=regexreplace(' (TRU) ', v_xname6,' ');
v_xname8:=regexreplace(' (CONSERVATOR FOR)', v_xname7,' ');
v_xname9:=regexreplace('(GRAVE-YARD)', v_xname8,' ');
v_xname10:=regexreplace(' FAMILY TRUST ', v_xname9,' ');
v_xname11:=regexreplace(' IRREV TRU II ', v_xname10,' ');
v_xname12:=regexreplace(' MD PA PEN PLAN ', v_xname11,' ');
v_xname13:=regexreplace(' MD PA PROFIT- ', v_xname12,' ');
v_xname14:=regexreplace(' DO PA PEN PLAN & TRU ', v_xname13,' ');
v_xname15:=regexreplace(' DMD PA PROFIT SH ', v_xname14,' ');
v_xname16:=regexreplace(' MD PA PROFIT SHARING PLAN ', v_xname15,' ');
v_xname17:=regexreplace(' DDS PA PROFIT SHARING PLAN & TRUST ', v_xname16,' ');
v_xname18:=regexreplace(' DDS PA PROFIT SHARING PLAN ', v_xname17,' ');
v_xname19:=regexreplace(' ET ALS TRS', v_xname18,' ');
v_xname20:=regexreplace(' ET ALS', v_xname19,' ');
v_xname21:=regexreplace(' FAMILY L P', v_xname20,' ');
v_xname22:=regexreplace(' GND ', v_xname21,' ');
v_xname23:=regexreplace(' GUARDIAN ', v_xname22,' ');
v_xname24:=regexreplace(' GUARDN ', v_xname23,' ');
v_xname25:=regexreplace(' IN RE ', v_xname24,' ');
v_xname26:=regexreplace(' IN RE. ', v_xname25,' ');
v_xname27:=regexreplace(' IN REGARD ', v_xname26,' ');
v_xname28:=regexreplace(' IN REGARDS ', v_xname27,' ');
v_xname29:=regexreplace(' RE EST ', v_xname28,' ');
v_xname30:=regexreplace(' RE ESTATE ', v_xname29,' ');
v_xname31:=regexreplace(' RE. EST ', v_xname30,' ');
v_xname32:=regexreplace(' DEC EST ', v_xname31,' ');
v_xname33:=regexreplace(' DECEASED ', v_xname32,' ');
v_xname34:=regexreplace(' DBA ', v_xname33,' ');
v_xname35:=regexreplace(' DECD ', v_xname34,' ');
v_xname36:=regexreplace(' DECD. ', v_xname35,' ');
v_xname37:=regexreplace(' RE. ESTATE ', v_xname36,' ');
v_xname38:=regexreplace(' PER REP ', v_xname37,' ');
v_xname39:=regexreplace(' PER. REP ', v_xname38,' ');
v_xname40:=regexreplace(' PER. REP. ', v_xname39,' ');
v_xname41:=regexreplace(' DEC ', v_xname40,' ');
v_xname42:=regexreplace(' WIDOW ', v_xname41,' ');
v_xname43:=regexreplace(' WIDOWER ', v_xname42,' ');
v_xname44:=regexreplace('REVOC TRUST', v_xname43,' ');
v_xname45:=regexreplace('REV TRUST', v_xname44,' ');
v_xname46:=regexreplace('REV TR', v_xname45,' ');
v_xname47:=regexreplace('REVOCABLE TRUST', v_xname46,' ');
v_xname48:=regexreplace('REVOCABLE ', v_xname47,' ');
v_xname49:=regexreplace('FAMILY TRU', v_xname48,' ');
v_xname50:=regexreplace('FAMILY TR', v_xname49,' ');
v_xname51:=regexreplace('FAM TR', v_xname50,' ');
v_xname52:=regexreplace('REV LIV TR', v_xname51,' ');
v_xname53:=regexreplace(' REV. ', v_xname52,' ');
v_xname54:=regexreplace('LIVING TRUST', v_xname53,' ');
v_xname55:=regexreplace(' LIV TR', v_xname54,' ');
v_xname56:=regexreplace(' TRST ', v_xname55,' ');
v_xname57:=regexreplace(' TRSTE ', v_xname56,' ');
v_xname58:=regexreplace(' TREAS. ', v_xname57,' ');
v_xname59:=regexreplace(' TRUSTEE ', v_xname58,' ');
v_xname60:=regexreplace(' TRUSTEES ', v_xname59,' ');
v_xname61:=regexreplace('TRUSTEES ', v_xname60,' ');
v_xname62:=regexreplace('TRSTEES ', v_xname61,' ');
v_xname63:=regexreplace(' TRUSTE ', v_xname62,' ');
v_xname64:=regexreplace('IN TRUST FOR', v_xname63,' ');
v_xname65:=regexreplace(' TRUST ', v_xname64,' ');
v_xname66:=regexreplace(' TRUST,*', v_xname65,' ');
v_xname67:=regexreplace('-TRUSTEE', v_xname66,' ');
v_xname68:=regexreplace('J-TRUST', v_xname67,' ');
v_xname69:=regexreplace('L-TRUST', v_xname68,' ');
v_xname70:=regexreplace('-TRUST', v_xname69,' ');
v_xname71:=regexreplace(' TRU ', v_xname70,' ');
v_xname72:=regexreplace(' TRE ', v_xname71,' ');
v_xname73:=regexreplace(' TR ', v_xname72,' ');
v_xname74:=regexreplace('-TR ', v_xname73,' ');
v_xname75:=regexreplace(' REGARDS ', v_xname74,' ');
v_xname76:=regexreplace(' REGARDING ', v_xname75,' ');
v_xname77:=regexreplace('HUSBAND AND WIFE', v_xname76,' ');
v_xname78:=regexreplace('HER HUSBAND', v_xname77,' ');
v_xname79:=regexreplace('HIS WIFE', v_xname78,' ');
v_xname80:=regexreplace('SECRETARY OF', v_xname79,' ');
v_xname81:=regexreplace('ITMO:', v_xname80,' ');
v_xname82:=regexreplace(' ,ET AL ', v_xname81,' ');
v_xname83:=regexreplace(' ,ET.AL.', v_xname82,' ');
v_xname84:=regexreplace(' ,ET. AL.', v_xname83,' ');
v_xname85:=regexreplace(' ET AL ', v_xname84,' ');
v_xname86:=regexreplace(' ET  AL ', v_xname85,' ');
v_xname87:=regexreplace(' ,ETAL ', v_xname86,' ');
v_xname88:=regexreplace('-ETAL', v_xname87,' ');
v_xname89:=regexreplace(' ETAL ', v_xname88,' ');
v_xname90:=regexreplace(' ET UX ', v_xname89,' ');
v_xname91:=regexreplace(' ET UX ', v_xname90,' ');
v_xname92:=regexreplace(' ET  UX ', v_xname91,' ');
v_xname93:=regexreplace(' ETUX ', v_xname92,' ');
v_xname94:=regexreplace(' ETUX ', v_xname93,' ');
v_xname95:=regexreplace(',ET VIR ', v_xname94,' ');
v_xname96:=regexreplace(' ET VIR ', v_xname95,' ');
v_xname97:=regexreplace(' ET  VIR ', v_xname96,' ');
v_xname98:=regexreplace(',ETVIR ', v_xname97,' ');
v_xname99:=regexreplace(' ETVIR ', v_xname98,' ');
v_xname100:=regexreplace(' ESTATE OF', v_xname99,' ');
v_xname101:=regexreplace(' (ESTATE OF)', v_xname100,' ');
v_xname102:=regexreplace(' ESTATE', v_xname101,' ');
v_xname103:=regexreplace(' ESTATE', v_xname102,' ');
v_xname104:=regexreplace('LAW OFFICES OF', v_xname103,' ');
v_xname105:=regexreplace('LAW OFFICES', v_xname104,' ');
v_xname106:=regexreplace('LAW OFFICE OF', v_xname105,' ');
v_xname107:=regexreplace('LAW OFFICE', v_xname106,' ');
v_xname108:=regexreplace(' MR AND MRS ', v_xname107,' ');
v_xname109:=regexreplace(' MR & MRS ', v_xname108,' ');
v_xname110:=regexreplace(' MR. AND MRS. ', v_xname109,' ');
v_xname111:=regexreplace(' MR. & MRS. ', v_xname110,' ');
v_xname112:=regexreplace('1/2 INT EA', v_xname111,' ');
v_xname113:=regexreplace('1/2 INT', v_xname112,' ');
v_xname114:=regexreplace('UNDIV 1/2', v_xname113,' ');
v_xname115:=regexreplace('3/4 INT', v_xname114,' ');
v_xname116:=regexreplace('1/4 INT', v_xname115,' ');
v_xname117:=regexreplace('1/2 ', v_xname116,' ');
v_xname118:=regexreplace('50%', v_xname117,' ');
v_xname119:=regexreplace('25%', v_xname118,' ');
v_xname120:=regexreplace(' +', v_xname119,' ');
v_xname121:=regexreplace(' +$', v_xname120,' ');

return v_xname121;

end; 