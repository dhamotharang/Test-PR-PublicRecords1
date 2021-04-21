const cp = require('child_process');
const fs = require('fs');
const fetch = require('node-fetch');
const xjs = require('xml-js');


// utility functions
// ----------------------------------------------
let checkObject = function(obj) {
  return typeof obj === 'object' && obj !== null;
};

let findFirstKey = function(obj, key) {
  let out = null;

  if (checkObject(obj))
  {
    let karr = Object.keys(obj);
    if (karr.find(kk => kk == key)) out = obj[key];
    else {
      for (const kk of karr) {
        let tmp = findFirstKey(obj[kk], key);
        if (tmp) { out = tmp; break; }
      }
    }
  }

  return out;
};

let getDateString = function () {
  let d = new Date();
  return d.toISOString();
};
// ----------------------------------------------

// Service Fetching
// ----------------------------------------------
let soapCall = async function(url, request_txt, timeout = 8000) {
  let opt = { 
    method: 'post', 
    body: request_txt, 
    headers: { 'Content-Type': 'text/xml' }, 
  };
  let result = {
    status_ok: false, 
    status: { val: 0, text: 'soapcall error' }, 
    response: '', 
  };

  console.log('Sending Request to: ' + url);

  try {
    let response = await fetch(url, opt);
    let rtxt = await response.text();
    
    console.log('Soapcall response');

    // assemble result
    result = {
      status_ok: response.ok, 
      status: { val: response.status, text: response.statusText }, 
      response: rtxt, 
    };

    if (!result.status_ok) {
      console.log('Error: Request Failed');
    }
  }
  catch (error) {
    result.status.text = error;
    console.log('Error: Request Failed');
  }

  return result;
}

let dedupServices = function(list) {
  let out = [];
  let last = '';
  
  for (let item of list) {
    if (item.toLowerCase() != last.toLowerCase()) out.push(item);
    last = item;
  }
  return out;
}

let getServicesFromFile = function(filename, filter = 1) {
  let out = [];
  console.log('Fetching Services From File: ' + filename);
  
  try {
    let txt = fs.readFileSync(filename, { encoding: 'utf8' });
    if (txt) out = txt.split('\n').filter((item) => item.trim());
  }
  catch (err) {
    console.log('Error Reading File: ' + filename)
  }

  // optionally filter a random subset
  if (filter < 1) out = out.filter(() => Math.random() < filter);
  
  return out;
}

let getServices = async function(filter = 1) {
  const server_url = 'http://uspr-dopsservices.risk.regn.net/demodopsservice.asmx';
  const server_req = '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:lex="http://lexisnexis.com/"><soapenv:Header/><soapenv:Body><lex:GetQueryList><lex:location>B</lex:location><lex:environment></lex:environment><lex:cluster></lex:cluster></lex:GetQueryList></soapenv:Body></soapenv:Envelope>';
  let out = [];
  console.log('Fetching Services List...');
  
  let res = await soapCall(server_url, server_req);
  if (res.status_ok) {
    let obj = xjs.xml2js(res.response, { compact: true, trim: true });
    let tmp = findFirstKey(obj, 'dquery');
    let arr = (tmp && Array.isArray(tmp)) ? tmp : [];
    
    console.log('Services Response OK: ' + arr.length);
    arr.forEach((item) => out.push(item.queryname._text));
  }
  else console.log('Services Request Failed');
  
  // optionally filter a random subset
  if (filter < 1) out = out.filter(() => Math.random() < filter);
  
  return dedupServices(out);
}

let getExceptions = function(fname) {
  let exceptions = new Set();

  try {
    let txt = fs.readFileSync(fname, { encoding: 'utf8' });
    let obj = JSON.parse(txt);
    
    for (let item of obj.nofastsyntax) {
      let tmp = item.toLowerCase();
      exceptions.add(tmp);
    }
    console.log('Loaded Fast Syntax Exceptions: ' + exceptions.size);
  }
  catch (error) {
    console.log('Unable to read: ' + fname);
  }

  return exceptions;
}
// ------------------------------------------


let isLibrary = function(str) {
  let arr = str.split('.');
  let is_lib = false;

  if (arr.length > 0) {
    let el = arr[arr.length - 1];
    if (el.toLowerCase().search('lib_') == 0) is_lib = true;
  }

  return is_lib;
}

// match attribute name to (case-correct) file path
let findPath = function(str, workpath) {
  let arr = str.split('.');
  let pp = workpath;
  let find = (str, dir) => {
    let tmp = str.toLowerCase();
    let ret = null;
    
    for (let item of dir) {
      if (item.toLowerCase() == tmp) { ret = item; break; }
    }
    return ret;
  };
  
  // add ECL suffix to final file name
  if (arr.length == 0) return null;
  else arr[arr.length - 1] += '.ecl';
  
  for (let item of arr) {
    let dir = [];
    try { dir = fs.readdirSync(pp); } catch (error) {}
    
    let name = find(item, dir);
    if (name) pp = pp + '/' + name;
    else return null;
  }
  return pp;
}

// count warnings / errors in a results string
let countExceptions = function(text) {
  let regex_e = /: error [A-Z]\d+:/g;
  let regex_w = /: warning [A-Z]\d+:/g;
  let lines = text.split('\n');
  let out = { errors: 0, warnings: 0 };

  for (let item of lines) {
    if (regex_e.test(item)) out.errors++;
    if (regex_w.test(item)) out.warnings++;
  }

  return out;
};

// perform syntax check
let syntax_check_async = function(path, workpath, use_fast = true) {
  return new Promise(resolve => {
    let args = [
      '-syntax', 
      '--nostdinc', 
      '-I', 
      workpath, 
      '-legacy', 
      path
    ];
    let out = { ok: false, status: 0, stdout: '', stderr: '' };
  
    // optionally use fastsyntax
    if (use_fast) args.splice(1, 0, '--fastsyntax');

    let proc = cp.execFile('eclcc', args, (error, stdout, stderr) => {
      out.stdout = (stdout) ? stdout.trim() : '';
      out.stderr = (stderr) ? stderr.trim() : '';

      if (error) {
        let ex = countExceptions(out.stderr);

        // eclcc may return an error code but no errors - in that case mark as ok
        out.ok = (ex.errors <= 0);
        out.status = error.status;
      }
      else out.ok = true;

      resolve(out);
    });
  });
}

// export warning info to file
let exportWarnings = function(warn, file) {
  let log = 'Syntax Check Warnings: ' + getDateString() + '\n\n';

  for (let item of warn) {
    log += '[[ ' + item.query + ' ]]\n';
    log += '----------------------------------------------------------\n';
    log += item.res.stderr;
    log += '\n----------------------------------------------------------\n\n';
  }
  
  try {
    fs.writeFileSync(file, log);
    console.log('Warnings Exported: ' + file);
  }
  catch (error) {
    console.log('Unable to Write Warnings File: ' + file);
  }
}

// exported functions
module.exports = {
  getServices: getServices, 
  getServicesFromFile: getServicesFromFile, 
  getExceptions: getExceptions, 
  isLibrary: isLibrary, 
  findPath: findPath, 
  getDateString: getDateString, 
  syntax_check_async: syntax_check_async, 
  exportWarnings: exportWarnings, 
}
