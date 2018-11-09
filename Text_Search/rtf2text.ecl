//Extract the text from a string that is encoded as RTF, returning a string.
//The extracted string starts with a blank unless the data is truncated.
//
EXPORT STRING rtf2text(CONST STRING rtf) := BEGINC++
  #option pure
  // skip sequence
  size32_t tok_size(const size32_t pos, const char * buf, const size32_t lenBuf) {
    if (buf[pos] == '&') {  // entities longer than 100 can be keywords
      size32_t entity_len = 1;
      if (pos+entity_len<lenBuf && buf[pos+1]=='#') {
        entity_len++;
        if (pos+entity_len<lenBuf && (buf[pos+entity_len]=='x' || buf[pos+entity_len]=='X')) {
          entity_len++;
          while(pos+entity_len<lenBuf && entity_len<100
              && ((buf[pos+entity_len] >= '0' && buf[pos+entity_len] <= '9')
                  || (buf[pos+entity_len] >= 'a' && buf[pos+entity_len] <= 'f')
                  || (buf[pos+entity_len] >= 'A' && buf[pos+entity_len] <= 'F') ) ) entity_len++;
        } else while (pos+entity_len<lenBuf && entity_len < 100 && isdigit(buf[pos+entity_len])) entity_len++;
      } else while (pos+entity_len<lenBuf && entity_len < 100 && isalnum(buf[pos+entity_len])) entity_len++;
      if (pos+entity_len<lenBuf && buf[pos+entity_len] == ';') return entity_len+1;
      else return 0;
    }
    if (pos+4<lenBuf && memcmp(buf+pos, "\\bin", 4) == 0) { // embedded binary object
      char temp[10];
      size32_t p = 0;
      while (pos+4+p<lenBuf && p<10 && isdigit(buf[pos+4+p]) && pos+4+p<lenBuf) {
        temp[p] = buf[pos+4+p];
        p++;
      }
      if (p==10) rtlFail(0, "Corrupt \\binN found, N is too large");
      temp[p] = '\0';
      size32_t parm = (size32_t) atoi(temp);
      if (pos+parm+4 >= lenBuf) rtlFail(0, "Corrupt \\binN found, N past input");
      return 4 + p + 1 + parm;
    }
    if ((pos+4<lenBuf && memcmp(buf+pos, "{\\*\\", 4) == 0)    // ignorable group
     || (pos+6<lenBuf && memcmp(buf+pos, "{\\pict", 6) == 0)   // picture group
     || (pos+7<lenBuf && memcmp(buf+pos, "{\\style", 7) == 0)  // stylesheet and related group
     || (pos+7<lenBuf && memcmp(buf+pos, "{\\color", 7) == 0)  // color information group
     || (pos+9<lenBuf && memcmp(buf+pos, "{\\macpict", 9) == 0)// picture group
     || (pos+8<lenBuf && memcmp(buf+pos, "{\\object", 8) == 0)) {
      int lvl = 1;
      int p = 1;
      while (pos+p < lenBuf && lvl > 0) {
        if (pos+p<lenBuf && memcmp(buf+pos+p, "\\bin", 4) == 0) {
          char temp[10];
          size32_t s = 0;
          while (pos+p+4+s<lenBuf && s < 10 && isdigit(buf[pos+p+4+s]) && pos+p+4+s<lenBuf) {
            temp[s] = buf[pos+p+4+s];
            s++;
          }
          if (s==10) rtlFail(0, "Corrupt \\binN found during ignore");
          temp[s] = '\0';
          size32_t parm = (size32_t) atoi(temp);
          if (pos+4+s+1+parm >= lenBuf) rtlFail(0, "Corrupt \\binN found, N past input");
          p += 4 + s + 1 + parm;
        } else {
          if (pos+p<lenBuf && buf[pos+p] == '{') lvl++;
          if (buf[pos+p] == '}') lvl--;
          if (pos+p+1<lenBuf && buf[pos+p] == '\\') p+=2; // step over first char to avoid escaped char
          else p++;
        }
      }
      if (pos + p > lenBuf) rtlFail(0, "Corrupt RTF, past input");
      return p;
    }
    if (buf[pos] == '{' || buf[pos] == '}') return 1;
    if (buf[pos] != '\\') return 0;
    if (!isalpha(buf[pos+1])) return 2;
    size32_t kwd_len = 1;
    while (pos+kwd_len<lenBuf && kwd_len < 30 && isalpha(buf[pos+kwd_len])) kwd_len++;
    size32_t parm_len = 0;
    if (pos+kwd_len<lenBuf && buf[pos+kwd_len] == '-') parm_len = 1;  // minus sign
    while (pos+kwd_len+parm_len<lenBuf && parm_len<20 && isdigit(buf[pos+kwd_len+parm_len])) parm_len++;
    size32_t included_delim = 0;
    if (pos+kwd_len+parm_len<lenBuf && buf[pos+kwd_len+parm_len]==' ') included_delim = 1;
    return kwd_len + parm_len + included_delim;
  }
  #body
  const size32_t max_len = 40000000;
  size32_t work_len = (lenRtf>max_len) ? max_len  : lenRtf+1;
  char* work = (char*) rtlMalloc(work_len + 1);  // 1 for null terminator
  size32_t used = 1;
  work[0] = ' ';
  size32_t pos = 0;
  while (pos < lenRtf && used < work_len) {
    if (rtf[pos]!='\\' && rtf[pos]!='{' && rtf[pos]!='}' && rtf[pos]!='&') {
      if (work[used-1] != ' ' || (rtf[pos]!=' ' && rtf[pos]!='\n' && rtf[pos]!='\r')) {
        work[used] = (!isalnum(rtf[pos])) ? ' '  : rtf[pos];
        used++;
      }
      pos++;
      continue;
    }
    size32_t len = tok_size(pos, rtf, lenRtf);
    switch (len) {
      case 0:
        if (work[used-1] != ' ' || (rtf[pos]!=' ' && rtf[pos]!='\n' && rtf[pos]!='\r')) {
          work[used] = (rtf[pos]=='\n' || rtf[pos]=='\r') ? ' '  : rtf[pos];
          used++;
        }
        pos++;
        break;
      case 2:
        if (!isalpha(rtf[pos+1])) {  // escaped special char
          work[used] = rtf[pos+1];
          used++;
        }
        pos += 2;
        break;
      default:
        if (rtf[pos]=='&' && work[used-1]!=' ') { // have an entity, treat as single blank
          work[used] = ' ';
          used++;
        }
        pos += len;
    }
  }
  if (pos < lenRtf) work[0] = '$';
  work[used] = '\0';
  used++;
  __lenResult = used - 1; // do not count null terminator
  __result = (char *) rtlRealloc(work, used);
ENDC++;